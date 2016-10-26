/*
 ADAPTED FOR A STAND ALONE UTILITY FROM:
 PureMVC AS3 Utility - StateMachine
 Copyright (c) 2008 Neil Manuell, Cliff Hall
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.osflash.statemachine {
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.ILoggable;
import org.osflash.statemachine.core.IStateMachine;
import org.osflash.statemachine.core.ITransitionController;
import org.osflash.statemachine.core.ITransitionPhase;
import org.osflash.statemachine.errors.StateDecodeError;
import org.osflash.statemachine.errors.StateTransitionError;

/**
 * A Finite State Machine implementation.
 * <P>
 * Handles registration and removal of state definitions.
 * Dependencies on any Observers (Events, Signals, Notifications)
 * are encapsulated within the <code>ITransitionController</code>
 * which controls the phases of the transition between states
 * </P>
 *
 * @ see ITransitionController
 * @ see BaseTransitionController
 */
public class StateMachine implements IStateMachine, ILoggable {

     private static const NO_INITIAL_STATE_DECLARED:String = "Initial state not defined or is referring to a state that is not defined";

    /**
     * Map of States objects by name.
     */
    protected var _states:Object = new Object();

    /**
     * The initial state of the FSM.
     */
    protected var _initial:IState;

    /**
     * The ITransitionController instance.
     */
    protected var _transitionController:ITransitionController;

    /**
     * The logger instance;
     */
    private var _logger:ILoggable;

    /**
     * Constructor
     * @param controller the ITransitionController instance
     * @param logger the logger instance
     */
    public function StateMachine(controller:ITransitionController, logger:ILoggable = null):void {
        _transitionController = controller;
        _logger = logger;
        initiate()
    }

    /**
     * @private
     */
    private function initiate():void {
        _transitionController.actionCallback = doAction;
    }

    /**
     * @inheritDoc
     */
    public function get currentStateName():String {
        return (_transitionController.currentState == null) ? null : _transitionController.currentState.name.valueOf();
    }

    /**
     * @inheritDoc
     */
    public function onRegister():void {
        if (_initial)
            transitionTo(_initial, null);
        else
            throw new StateDecodeError( NO_INITIAL_STATE_DECLARED )
    }

    /**
     * @inheritDoc
     */
    public function hasState(stateName:String):Boolean {
        return ( _states[ stateName ] != null );
    }

    /**
     * @inheritDoc
     */
    public function registerState(state:IState, initial:Boolean = false):Boolean {
        if (state == null || hasState(state.name)) return false;
        _states[ state.name ] = state;
        if (initial) this._initial = IState(state);
        return true;
    }

    /**
     * @inheritDoc
     */
    public function removeState(stateName:String):Boolean {
        if (!hasState(stateName)) return false;
        delete _states[ stateName ];
        return true;
    }

    /**
     * @inheritDoc
     */
    public function destroy():void {
        _transitionController.destroy();
        for each (var state:IState in _states) state.destroy();
        _states = null;
        _initial = null;
    }

    /**
     * @inheritDoc
     */
    public function log(msg:String):void {
        if (_logger != null)
            _logger.log(msg);
    }

    public function logPhase( phase:ITransitionPhase, stateName:String = ""  ):void {
        if (_logger != null)
            _logger.logPhase(phase, stateName);
    }

    /**
     * Initiates the transition process.
     * This method is set as the ITransitionController's actionCallback property
     * @see #initiate()
     * @param action
     * @param payload
     * @returns Whether a transition has been successfully triggered or not
     */
    protected function doAction(action:String, payload:Object):Boolean {
        if (_transitionController.currentState == null)return false;
        var newStateTarget:String = _transitionController.currentState.getTarget(action);
        var newState:IState = IState(_states[ newStateTarget ]);
        if (newState != null) return transitionTo(newState, payload);
        if (newStateTarget != null)
            throw new StateTransitionError(StateTransitionError.TARGET_DECLARATION_MISMATCH + newStateTarget);
        log("ACTION: " + action + "is not defined in STATE: " + currentStateName);
        return false;
    }

    /**
     * This calls the ITransitionControllers' transition method
     * @param targetState
     * @param payload
     * @returns Whether a transition has been successfully triggered or not
     * @throws org.osflash.statemachine.errors.StateTransitionError if an transition
     * is attempted while the StateMachine is already undergoing a transition
     */
    protected function transitionTo(targetState:IState, payload:Object = null):Boolean {
        if (targetState == null) return false;
        if (_transitionController.isTransitioning)
            throw new StateTransitionError(StateTransitionError.ALREADY_TRANSITIONING);
        _transitionController.transition(targetState, payload);
        return true;
    }


}
}
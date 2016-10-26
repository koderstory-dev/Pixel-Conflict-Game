package org.osflash.statemachine.core {
/**
 * Contract with FSMInjector and framework for managing States
 */
public interface IStateMachine {
    /**
     * The name of the current state.
     * @return
     */
    function get currentStateName():String;

    /**
     * Registers a IState with the FSM.
     * @param state the IState to be registered.
     * @param initial whether the IState is the initial state.
     * @return the success of the operation.
     */
    function registerState( state:IState, initial:Boolean = false ):Boolean;

    /**
     * Removes a IState from the FSM.
     * @param stateName the IState to be removed.
     * @return the success of the opperation.
     */
    function removeState( stateName:String ):Boolean;

    /**
     * Interrogates the FSM for the presence of the named IState.
     * @param stateName the name of the IState.
     * @return
     */
    function hasState( stateName:String ):Boolean;

    /**
     * Called when all IStates have been registered
     */
    function onRegister():void;

    /**
     * The destroy method for GC.
     */
    function destroy():void;
}
}
package org.osflash.statemachine.core {
/**
 * Contract with IStateMachine for encapsulating the state transition cycle.
 */
public interface ITransitionController {
    /**
     * The current state
     * @return
     */
    function get currentState():IState;

    /**
     * Indicates whether the FSM is undergoing a transition cycle.
     * @return
     */
    function get isTransitioning():Boolean;

    /**
     * The callback function called by the StateMachine to start a new transition.
     * Unless you are adapting or extending the StateMachine, you won't need
     * must have the signature:
     * <code>sendStateActionHandler(action:String, payload:Object ):void</code>
     */
    function set actionCallback( value:Function ):void;

    /**
     * Called by the StateMachine to start the transition process.
     * @param targetState the state transitioning to.
     * @param payload the data payload to be delivered to the end clients.
     */
    function transition( targetState:IState, payload:Object = null ):void;

    /**
     * The Destroy method
     */
    function destroy():void;
}
}
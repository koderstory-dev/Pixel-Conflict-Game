package org.osflash.statemachine.errors {
/**
 * Thrown when an attempt has been made to start a transition when the
 * StateMachione is already transitioning
 *
 * @see org.osflash.statemachine.StateMachine#transitionTo()
 */
public class StateTransitionError extends Error {
    public static const ALREADY_TRANSITIONING:String = "Can not action a transition when FSM is already transitioning.";
    public static const TARGET_DECLARATION_MISMATCH:String = "Target state does not exist: ";

    public function StateTransitionError( msg:String )
    {
        super( msg );
    }
}
}
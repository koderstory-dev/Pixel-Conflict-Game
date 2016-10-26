package org.osflash.statemachine.errors {
/**
 * Thrown when an attempt has been made to start a transition when the
 * StateMachione is already transitioning
 *
 * @see org.osflash.statemachine.StateMachine#transitionTo()
 */
public class StateDecodeError extends Error {


    public function StateDecodeError( msg:String )
    {
        super( msg );
    }
}
}
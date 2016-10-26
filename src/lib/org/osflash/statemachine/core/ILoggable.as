package org.osflash.statemachine.core {
public interface ILoggable {
    /**
     * Allows wrapping of logging functionality within the StateMachine framework
     * @param msg The message to log
     */
    function log( msg:String ):void;
    function logPhase( phase:ITransitionPhase, stateName:String = ""  ):void;

}
}
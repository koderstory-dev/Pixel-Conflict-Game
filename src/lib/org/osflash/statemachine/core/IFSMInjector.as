package org.osflash.statemachine.core {
public interface IFSMInjector {
    /**
     * Registers all the decoded states with the IStateMachine, then calls the onRegister method.
     * @param statemachine the IStateMachine to inject
     */
    function inject( statemachine:IStateMachine ):void

    /**
     * The destroy method for GC
     */
    function destroy():void;
}
}
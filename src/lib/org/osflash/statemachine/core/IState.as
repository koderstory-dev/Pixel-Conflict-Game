package org.osflash.statemachine.core {
/**
 * The contract between concrete states and the StateMachine framework.
 */
public interface IState {
    /**
     * The name of the state
     */
    function get name():String;

	function get referringAction():String;

    /**
     * The number of transitions defined in this state
     */
    function get length():int;

    /**
     * Defines a transition.
     * A transition requires the name of the triggering action, and the name of the state to which the FSM will move towards.
     * @param action the name of the action.
     * @param target the name of the target state to transition to.
     * @return the success of the operation.
     */
    function defineTrans( action:String, target:String ):Boolean;

    /**
     * Remove a previously defined transition.
     * @param action the name of the action.
     * @return the success of the opperation.
     */
    function removeTrans( action:String ):Boolean;

    /**
     * Ascertains whether there is a transition defined for the specified action
     * @param action the name of the action.
     * @return
     */
    function hasTrans( action:String ):Boolean;

    /**
     * Get the target state name for a given action.
     * @param action the name of the StateMachine.ACTION event type.
     * @return the target state's name.
     */
    function getTarget( action:String ):String;



    /**
     * Destroy method.
     */
    function destroy():void;

}
}
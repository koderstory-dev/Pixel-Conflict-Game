/*
 ADAPTED FOR ROBOTLEGS FROM:
 PureMVC AS3 Utility - StateMachine
 Copyright (c) 2008 Neil Manuell, Cliff Hall
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.osflash.statemachine.base {
import org.osflash.statemachine.core.IState;

/**
 * The Abstract class from which all states should extend.
 */
public class BaseState implements IState {

    /**
     *  Transition map of actions to target states.
     */
    protected var _transitions:Object = new Object();

    /**
     * @private
     */
    private var _name:String;

    /**
     * @private
     */
    private var _numberOfTransitions:int;

	private var _referringAction:String;


    /**
     * This class is ment to be extended.
     * @param name the name of the state.
     */
    public function BaseState( name:String ):void
    {
        _name = name;
    }

    /**
     * @inheritDoc
     */
    public function get name():String { return _name; }

	 public function get referringAction():String { return _referringAction; }

    /**
     * @inheritDoc
     */
    public function get length():int { return _numberOfTransitions; }

    /**
     * @inheritDoc
     */
    public function defineTrans( action:String, target:String ):Boolean
    {
        if ( hasTrans( action ) ) return false;
        _transitions[ action ] = target;
        _numberOfTransitions++;
        return true;
    }

    /**
     * @inheritDoc
     */
    public function hasTrans( action:String ):Boolean
    {
        if ( _transitions == null ) return false;
        return ( _transitions[ action ] != null );
    }

    /**
     * @inheritDoc
     */
    public function removeTrans( action:String ):Boolean
    {
        if ( getTarget( action ) == null ) return false;
        delete _transitions[ action ];
        _numberOfTransitions--;
        return true;
    }

    /**
     * @inheritDoc
     */
    public function getTarget( action:String ):String
    {
	    if( _transitions[ action ] != null )
            _referringAction = action;

        return _transitions[ action ];
    }

    /**
     * @inheritDoc
     */
    public function destroy():void
    {
        _transitions = null;
    }
}
}
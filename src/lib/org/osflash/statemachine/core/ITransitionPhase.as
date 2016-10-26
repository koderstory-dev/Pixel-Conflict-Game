/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 31/01/11
 * Time: 16:13
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.core {
public interface ITransitionPhase {

    function get name():String;

    function get index():int;

    function equals( value:Object ):Boolean;
}
}

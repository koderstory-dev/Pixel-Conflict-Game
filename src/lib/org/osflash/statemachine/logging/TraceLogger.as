/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 31/01/11
 * Time: 16:06
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.logging {
import org.osflash.statemachine.core.ILoggable;
import org.osflash.statemachine.core.ITransitionPhase;

public class TraceLogger implements ILoggable {

    public var prefix:String;

    public var active:Boolean;

    public var flags:int;

    public function TraceLogger( prefix:String = "", active:Boolean = true, flags:int = 127 ) {
        this.prefix = prefix;
        this.active = active;
        this.flags = flags;
    }

    public function log(msg:String):void {
        if( active )
            trace( prefix + msg );
    }

    public function logPhase(phase:ITransitionPhase,stateName:String = ""):void {
        if( active && flags & phase.index )
            trace( prefix + " PHASE: " +  phase.name + " from STATE: " + stateName + " executed."  );
    }
}
}

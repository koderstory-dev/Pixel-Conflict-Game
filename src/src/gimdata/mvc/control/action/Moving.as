package gimdata.mvc.control.action 
{
	import com.greensock.TweenMax;
	import flash.geom.Point;
	import gimdata.core.config.Config;
	import gimdata.core.config.Music;
	import gimdata.mvc.model.ModelBattle;
	import gimdata.mvc.model.ModelBattle;
	import raj.soundlite.MSFX;
	/**
	 * ...
	 * @author AldyAhsandin
	 */
	public class Moving 
	{
		
		public function Moving() 
		{
			
		}
		
		/**
		 * Bergerak ke tempat yang telah diklik
		 * @param	_offset Jumlah jarak tile yang harus dikurangi
		 * @return
		 */
		public static function move( _modelBattle:ModelBattle, _offset:int =0):Number {
			
			Path.enablePassableTiles 			= true;
			Path.enableEnemyPos					= true;
			Path.enableAreaActive 				= true;
			Path.enableAllyPos					= true;
			
			var _path		: Vector.<Point>	= Path.findPath(_modelBattle, Config.focused, Config.clicked.tile.dPos);
			var _pathLength	: int				= _path.length - _offset;
			var _time		: Number			= 0.5;
			
			//block area
			//_modelBattle.openHideBlock();
			
			// animasikan display
			if (_path[0].x < _path[_path.length - 1].x) {
				TweenMax.delayedCall(0, Config.focused.showWalk_Right);
			}else 
			if (_path[0].x > _path[_path.length - 1].x) {
				TweenMax.delayedCall(0, Config.focused.showWalk_Left);
			}else
			if (Config.focused.isFaceRight)
				TweenMax.delayedCall(0, Config.focused.showWalk_Right);
			else
				TweenMax.delayedCall(0, Config.focused.showWalk_Left);
			
			Config.focused.active = false;
			
			
			// gerakkan
			for (var i:int = 0; i < _pathLength; i++ ) {
				// set posisi berurutan berdasarkan delay
				TweenMax.to(Config.focused, _time, { 
							delay		: i * _time, 
							x			: _path[i].x * Config.STANDART, 
							y			: _path[i].y * Config.STANDART,
							onComplete	: function() {
								// set posisi di posisi terakhir
								Config.focused.dPos = _path[_pathLength - 1];	
							}
				});
			}
			
			// ------------------------------------------------------
			// SFX
			// ------------------------------------------------------
			switch(Config.focused.dType) {
				case 1:
				case 2:
				case 3: Music.GRUP_GAME.playLoop(Music.sfx_infWalk, 0.2);
						TweenMax.delayedCall(_pathLength * _time, function() {
							Music.GRUP_GAME.pause(Music.sfx_infWalk);
						});
						break;
				case 4: 
				case 5:
				case 6:
				case 9:	Music.GRUP_GAME.playLoop(Music.sfx_mesWalk, 0.3);
						TweenMax.delayedCall(_pathLength * _time, function() {
							Music.GRUP_GAME.pause(Music.sfx_mesWalk);
						});
						break;
				case 7:	Music.GRUP_GAME.playLoop(Music.sfx_artWalk, 0.3);
						TweenMax.delayedCall(_pathLength * _time, function() {
							Music.GRUP_GAME.pause(Music.sfx_artWalk);
						});
						break;
			}
			
			
			
			
			// idle
			if (_path[0].x < _path[_path.length - 1].x) {
				TweenMax.delayedCall(_path.length*_time, Config.focused.showIdle_Right);
			}else 
			if (_path[0].x > _path[_path.length - 1].x) {
				TweenMax.delayedCall(_path.length * _time, Config.focused.showIdle_Left);
			}else
			if (Config.focused.isFaceRight)
				TweenMax.delayedCall(_path.length * _time, Config.focused.showIdle_Right);
			else
				TweenMax.delayedCall(_path.length * _time, Config.focused.showIdle_Left);
			
			//TweenMax.delayedCall(_path.length * _time, _modelBattle.cursor.hide);
			//TweenMax.delayedCall(_path.length * _time, _modelBattle.openHideBlock);
			
			return _time * _pathLength + 0.3;
		}
		
		
		
	}

}
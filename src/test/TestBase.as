
package test
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.setTimeout;
	
	public class TestBase extends Sprite
	{
		
		protected var _logger:TextField;
		private var _executionIndex:int = 0;
		
		private var _executionList:Array = new Array();
		
		public function TestBase()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			setupLogger();
		}
		
		private function setupLogger():void{
			_logger = new TextField();
			_logger.autoSize = TextFieldAutoSize.LEFT;
			addChild(_logger);
		}
		
		protected function log( message:String ):void
		{
			_logger.appendText(
				message+
				"\n" );
		}
		
		protected function tag( tagName:String ):void{
			_logger.appendText(
				"\n "+
				tagName+
				"\n-------------------------------------------------"+
				"\n" );
		}
		
		protected function execute( title:String, fun:Function ):void{
			_executionList = _executionList.concat( {
				title: title,
				fun: fun
			} );
		}
		
		protected function start():Boolean{
			if( _executionIndex ) return false;
			stage.addEventListener( Event.EXIT_FRAME, onFrame );
			return true;
		}
		
		protected function onFrame( e:Event ):void{
			stage.removeEventListener( Event.EXIT_FRAME, onFrame );
			
			var exObj:Object = _executionList[_executionIndex++];
			if( exObj ){
				tag( exObj.title+" ("+_executionIndex+"/"+_executionList.length+")");
				setTimeout( runner, 100, exObj.fun );
			}
		}
		
		protected function runner( fun:Function ):void{
			fun();
			stage.addEventListener( Event.EXIT_FRAME, onFrame );			
		}

	}
}
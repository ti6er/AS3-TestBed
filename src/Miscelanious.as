package
{
	import flash.utils.getTimer;
	import test.TestBase;

	public class Miscelanious extends TestBase
	{
		
		private static const COUNT:int = 10000000;
		
		private const TEST:Number = 0.5;

		private var _vP:String="";
		
		public function Miscelanious()
		{
			super();
			
			execute( "Const declaration vs Inline constants", testConst );
			execute( "Is pooling effective", testPooling );
			execute( "If, with and without braces", testIf );

			start();
		}
		
		private function testConst():void{
			
			var i:int=0, t:int, testVar:Number;

			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				testVar = TEST;
			}
			t = getTimer()-t;
			log( "Const : "+t );

			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				testVar = 0.5;
			}
			t = getTimer()-t;
			log( "Inline : "+t );

		}
		
		private function testPooling():void{
			
			var i:int=0, t:int;
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				inFunction()
			}
			t = getTimer()-t;
			log( "Declaring var inside function : "+t );
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				pooledVar()
			}
			t = getTimer()-t;
			log( "Pooling variable : "+t );
			
		}
		
		private function inFunction():void{
			var vP:String="";
		}
		
		private function pooledVar():void{
			_vP="";
		}
		
		private function testIf():void{
			
			var i:int=0, t:int;
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				if(true) _vP="";
			}
			t = getTimer()-t;
			log( "Without braces : "+t );
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				if(true){
					_vP="";
				}
			}
			t = getTimer()-t;
			log( "With braces : "+t );
			
		}

	}
}

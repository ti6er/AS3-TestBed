package
{
	import flash.utils.getTimer;
	import test.TestBase;

	public class Functions extends TestBase
	{
		
		private static const COUNT:int = 10000000;

		public function Functions()
		{
			super();
			
			execute( "Effect of number of arguments on function call", testArgumentCount );
			execute( "Function calls", funCalls );

			start();
		}
		
		private function testArgumentCount():void{

			const COUNT:int = 100000;
			
			var i:int=0, t:int;

			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				f0();
			}
			t = getTimer()-t;
			log( "0 Arg : "+t );

			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				f1(1);
			}
			t = getTimer()-t;
			log( "1 Arg : "+t );

			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				f2(1,2);
			}
			t = getTimer()-t;
			log( "2 Arg : "+t );

			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				f3(1,2,3)
			}
			t = getTimer()-t;
			log( "3 Arg : "+t );

			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				f4(1,2,3,4)
			}
			t = getTimer()-t;
			log( "4 Arg : "+t );

			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				f5(1,2,3,4,5)
			}
			t = getTimer()-t;
			log( "5 Arg : "+t );
			
		}
		
		private function f0():void{}
		private function f1( a:int ):void{}
		private function f2( a:int, b:int):void{}
		private function f3( a:int, b:int, c:int):void{}
		private function f4( a:int, b:int, c:int, d:int):void{}
		private function f5( a:int, b:int, c:int, d:int, e:int):void{}
		
		private function funCalls():void{
			
			var i:int=0, t:int;
			
			var testClass:TestClass = new TestClass;
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				TestClass.staticFun();
			}
			t = getTimer()-t;
			log( "Static function : "+t );
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				testClass.memFun();
			}
			t = getTimer()-t;
			log( "Member function : "+t );

			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				testClass.memInFun();
			}
			t = getTimer()-t;
			log( "Member function enforced by interface : "+t );

			var f:Function = TestClass.staticFun;
			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				f();
			}
			t = getTimer()-t;
			log( "Static function as var : "+t );
			
			f = testClass.memFun;
			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				f();
			}
			t = getTimer()-t;
			log( "Mem function as var: "+t );

			f = testClass.memFun;
			t = getTimer();
			for( i=0; i<COUNT; i++ ){
			}
			t = getTimer()-t;
			log( "No function: "+t );

		}
		
	}
}

internal class TestClass implements ITestInterface{

	public static function staticFun():void{}
	
	TestClass:void{}
	
	public function memFun():void{}
	public function memInFun():void{};
	
}

internal interface ITestInterface{

	function memInFun():void;

}
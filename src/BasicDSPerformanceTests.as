package
{
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import test.TestBase;

	[SWF(width=600, height=800)]
	public class BasicDSPerformanceTests extends TestBase
	{
		
		private static const COUNT:int = 100000;
		private var _data:Data = new Data();

		public function BasicDSPerformanceTests()
		{
			super();
			
			execute( "Insertion", testInsrtion );
			execute( "Iteration", testIteration );
			execute( "Random Access", testRandomAcess );
			execute( "Deletion-1", testDeletion1 );
			execute( "Deletion-2", testDeletion2 );

			execute( "Multiple vectors or vector of objects", multipleVecOrVecOfObj );
			
			start();
		}
		
		private function multipleVecOrVecOfObj():void{
			
			const COUNT:int = 5000;

			var v1:Vector.<int> = new Vector.<int>();
			var v2:Vector.<Number> = new Vector.<Number>();
			var v3:Vector.<String> = new Vector.<String>();
	
			var v:Vector.<Data> = new Vector.<Data>();

			var i:int=0, j:int, t:int, d:Data;

			for( i=0; i<COUNT; i++ ){
				
				d = new Data();
				d.integer = Math.random()*100;
				d.number = Math.random();
				d.string = Math.random().toString();
				
				v1.push( d.integer );
				v2.push( d.number );
				v3.push( d.string );
				
				v.push( d );
				
			}

			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				for( j=0; j<COUNT; j++ ){
					v1[j];
					v2[j];
					v3[j];
				}
			}
			t = getTimer()-t;
			log( "Multiple Vectors ( 3 vectors ) : "+t );

			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				for( j=0; j<COUNT; j++ ){
					v[j].integer;
					v[j].number;
					v[j].string;
				}
			}
			t = getTimer()-t;
			log( "Vector of object ( 3 properties ) : "+t );
			
		}
		
		private function testInsrtion():void{

			var o:Object = new Object();
			var d:Dictionary = new Dictionary();
			var a:Array = new Array();
			var v:Vector.<Data> = new Vector.<Data>();
			
			var i:int=0, t:int;
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				o[i] = _data;
			}
			t = getTimer()-t;
			log( "Object : "+t );
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				d[i] = _data;
			}
			t = getTimer()-t;
			log( "Dictionary : "+t );
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				a[i] = _data;
			}
			t = getTimer()-t;
			log( "Array[] : "+t );
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				v[i] = _data;
			}
			t = getTimer()-t;
			log( "Vector[] : "+t );
			
			log("");
			//------------------------------------------
			
			a = new Array();
			v = new Vector.<Data>();
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				a[a.length] = _data;
			}
			t = getTimer()-t;
			log( "Array[length] : "+t );
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				v[v.length] = _data;
			}
			t = getTimer()-t;
			log( "Vector[length] : "+t );
			
			log("");
			//------------------------------------------

			a = new Array();
			v = new Vector.<Data>();
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				a.push( _data );
			}
			t = getTimer()-t;
			log( "Array.push : "+t );
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				v.push( _data );
			}
			t = getTimer()-t;
			log( "Vector.push : "+t );
			
		}

		private function testIteration():void{

			var o:Object = new Object();
			var d:Dictionary = new Dictionary();
			var a:Array = new Array();
			var v:Vector.<Data> = new Vector.<Data>();
			
			var i:int=0, si:String, t:int, it:Data, tmp:Data;
			
			for( i=0; i<COUNT; i++ ){
				o[i] = _data;
				d[i] = _data;
				a[i] = _data;
				v[i] = _data;
			}

			t = getTimer();
			for each( it in o )tmp=it;
			t = getTimer()-t;
			log( "For each in Object : "+t );
			
			t = getTimer();
			for each( it in a )tmp=it;
			t = getTimer()-t;
			log( "For each in Dictionary : "+t );
			
			t = getTimer();
			for each( it in d )tmp=it;
			t = getTimer()-t;
			log( "For each in Array : "+t );
			
			t = getTimer();
			for each( it in v )tmp=it;
			t = getTimer()-t;
			log( "For each in Vector : "+t );
			
			log("");
			//-------------------------------------------------
			
			t = getTimer();
			for( si in o ) tmp=o[si];
			t = getTimer()-t;
			log( "For..in, Object[index] : "+t );
			
			t = getTimer();
			for( si in d ) tmp=d[si];
			t = getTimer()-t;
			log( "For..in, Dictionary[index] : "+t );
			
			t = getTimer();
			for( i in a ) tmp=a[i];
			t = getTimer()-t;
			log( "For..in, Array[index] : "+t );
			
			t = getTimer();
			for( i in v ) tmp=v[i];
			t = getTimer()-t;
			log( "For..in, Vector[index] : "+t );
			
			log("");
			//-------------------------------------------------
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ) tmp=o[i];
			t = getTimer()-t;
			log( "For, Object[index] : "+t );
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ) tmp=d[i];
			t = getTimer()-t;
			log( "For, Dictoinary[index] : "+t );
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ) tmp=a[i];
			t = getTimer()-t;
			log( "For, Array[index] : "+t );
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ) tmp=v[i];
			t = getTimer()-t;
			log( "For, Vector[index] : "+t );
			
		}

		private function testRandomAcess():void{

			var o:Object = new Object();
			var d:Dictionary = new Dictionary();
			var a:Array = new Array();
			var v:Vector.<Data> = new Vector.<Data>();
			
			var i:int=0, t:int, tmp:Data;
			
			for( i=0; i<COUNT; i++ ){
				o[i] = _data;
				d[i] = _data;
				a[i] = _data;
				v[i] = _data;
			}
			
			var rand:Array = [];
			for( i=0; i<COUNT; i++ ){
				rand[i] = int(Math.random()*COUNT-1);
			}
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ) rand[i];
			var overhead:int = getTimer()-t; // Rough overhead
			
			t = getTimer()+overhead;
			for( i=0; i<COUNT; i++ ) tmp=o[rand[i]];
			t = getTimer()-t;
			log( "Object : "+t );
			
			t = getTimer()+overhead;
			for( i=0; i<COUNT; i++ ) tmp=a[rand[i]];
			t = getTimer()-t;
			log( "Dictionary : "+t );
			
			t = getTimer()+overhead;
			for( i=0; i<COUNT; i++ ) tmp=d[rand[i]];
			t = getTimer()-t;
			log( "Array[] : "+t );
			
			t = getTimer()+overhead;
			for( i=0; i<COUNT; i++ ) tmp=v[rand[i]];
			t = getTimer()-t;
			log( "Vector[] : "+t );
			
		}

		private function testDeletion1():void{
			
			var o:Object = new Object();
			var d:Dictionary = new Dictionary();
			var a:Array = new Array();
			var v:Vector.<Data> = new Vector.<Data>();
			
			var i:int=0, t:int, l:int;
			
			for( i=0; i<COUNT; i++ ){
				o[i] = _data;
				d[i] = _data;
				a[i] = _data;
				v[i] = _data;
			}
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ) delete o[i];
			t = getTimer()-t;
			log( "Object.delete : "+t );
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ) delete d[i];
			t = getTimer()-t;
			log( "Dictionary.delete : "+t );
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ) a.splice(0,1);
			t = getTimer()-t;
			log( "Array.splice@0 : "+t );
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ) v.splice(0,1);
			t = getTimer()-t;
			log( "Vector.splice@0 : "+t );
			
			for( i=0; i<COUNT; i++ ) a[i] = _data, v[i] = _data;
			
			var data2Remove:Data = new Data();
			data2Remove.index = 0;
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				l = a.length-1;
				a[data2Remove.index] = a[l];
				a[data2Remove.index].index = data2Remove.index;
				a.length = l;
			}
			t = getTimer()-t;
			log( "Array.swap@0 : "+t );
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				l = v.length-1;
				v[data2Remove.index] = v[l];
				v[data2Remove.index].index = data2Remove.index;
				v.length = l;
			}
			t = getTimer()-t;
			log( "Vector.swap@0 : "+t );
						
		}
		
		private function testDeletion2():void{
			
			var o:Object = new Object();
			var d:Dictionary = new Dictionary();
			var a:Array = new Array();
			var v:Vector.<Data> = new Vector.<Data>();
			
			var i:int=0, t:int, l:int;
			
			var data2Remove:Data = new Data();
			data2Remove.index = 0;
			
			for( i=0; i<COUNT; i++ ){
				o[i] = _data;
				d[i] = _data;
				a[i] = _data;
				v[i] = _data;
			}
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ) i%a.length;
			var overhead:int = getTimer()-t; // Rough overhead
			
			t = getTimer()+overhead;
			for( i=0; i<COUNT; i++ ) a.splice(i%a.length,1);
			t = getTimer()-t;
			log( "Array.splice@random : "+t );
			
			t = getTimer()+overhead;
			for( i=0; i<COUNT; i++ ) v.splice(i%v.length,1);
			t = getTimer()-t;
			log( "Vector.splice@random : "+t );
			
			for( i=0; i<COUNT; i++ ) a[i] = _data, v[i] = _data;
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ) data2Remove.index = i%a.length;
			overhead = getTimer()-t; // Rough overhead
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				l = a.length-1;
				data2Remove.index = i%a.length;
				a[data2Remove.index] = a[l];
				a[data2Remove.index].index = data2Remove.index;
				a.length = l;
			}
			t = getTimer()-t;
			log( "Array.swap@random : "+t );
			
			t = getTimer();
			for( i=0; i<COUNT; i++ ){
				l = v.length-1;
				data2Remove.index = i%a.length;
				v[data2Remove.index] = v[l];
				v[data2Remove.index].index = data2Remove.index;
				v.length = l;
			}
			t = getTimer()-t;
			log( "Vector.swap@random : "+t );
			
		}

	}
}

internal class Data{
	public var index:int;
	
	public var integer:int;
	public var number:Number;
	public var string:String;
	
	public function Data(){
	}
}
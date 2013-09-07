/**
 * Created with IntelliJ IDEA.
 * User: zhishaofei
 * Date: 13-9-5
 * Time: 下午2:23
 */
package ui {
	import data.CONST;

	import flash.display.Shape;
	import flash.display.Sprite;

	public class UIQiZi extends Sprite {
		private var _type:int;
		private var _xIndex:int;
		private var _yIndex:int;

		public function UIQiZi(t:int, xI:int, yI:int) {
			type = t;
			xIndex = xI;
			yIndex = yI;
		}

		public function get type():int {
			return _type;
		}

		public function set type(value:int):void {
			_type = value;
			draw(value);
		}

		private function draw(value:int):void {
			var color:uint = value == 1 ? 0xFFFFFF : 0x000000;
			var shape:Shape = new Shape();
			shape.graphics.beginFill(color);
			shape.graphics.drawCircle(0, 0, CONST.UINT_QIZI_RADIUS);
			shape.graphics.endFill();
			addChild(shape);
		}

		public function get xIndex():int {
			return _xIndex;
		}

		public function set xIndex(value:int):void {
			_xIndex = value;
		}

		public function get yIndex():int {
			return _yIndex;
		}

		public function set yIndex(value:int):void {
			_yIndex = value;
		}
	}
}

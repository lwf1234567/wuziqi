/**
 * Created with IntelliJ IDEA.
 * User: zhishaofei
 * Date: 13-9-5
 * Time: 下午2:23
 */
package ui {
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;

	public class LayerManager {
		public static var qiziContainer:Sprite;
		public static var qipanContainer:Sprite;

		public function LayerManager() {
		}

		public static function initLayers(dison:DisplayObjectContainer):void {
			var backgroundColorShape:Shape = new Shape();
			backgroundColorShape.graphics.beginFill(0x004400);
			backgroundColorShape.graphics.drawRect(0, 0, dison.stage.stageWidth, dison.stage.stageHeight);
			backgroundColorShape.graphics.endFill();
			dison.addChild(backgroundColorShape);
			qipanContainer = new Sprite();
			dison.addChild(qipanContainer);
			qiziContainer = new Sprite();
			dison.addChild(qiziContainer);
		}
	}
}

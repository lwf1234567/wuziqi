package {

	import flash.display.Sprite;

	[SWF(backgroundColor="0xFFFFFF", width="700", height="700", frameRate="24")]
	public class Wuziqi extends Sprite {
		public function Wuziqi() {
			var qipan:QiPan = new QiPan(7, 7);
			addChild(qipan);
		}
	}
}

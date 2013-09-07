/**
 * Created with IntelliJ IDEA.
 * User: zhishaofei
 * Date: 13-9-5
 * Time: 下午1:59
 */
package {
	import data.CONST;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	import ui.LayerManager;
	import ui.UIQiZi;

	public class QiPan extends Sprite {
		private var hang:int;
		private var lie:int;
		private var qiziArr:Array;
		private var role:int;

		public function QiPan(h:int, l:int) {
			hang = h;
			lie = l;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(e:Event):void {
			LayerManager.initLayers(this);
			drawQiPan(hang, lie);
			startGame();
		}

		private function drawQiPan(h:int, l:int):void {
			var shape:Shape = new Shape();
			shape.graphics.lineStyle(2, 0x008800, 1);
			for (var i:int = 0; i < h; i++) {
				shape.graphics.moveTo(0, i * CONST.UINT_HEIGHT);
				shape.graphics.lineTo(l * CONST.UINT_WIDTH, i * CONST.UINT_HEIGHT);
				shape.graphics.endFill();
			}
			for (i = 0; i < l; i++) {
				shape.graphics.moveTo(i * CONST.UINT_WIDTH, 0);
				shape.graphics.lineTo(i * CONST.UINT_WIDTH, h * CONST.UINT_HEIGHT);
				shape.graphics.endFill();
			}			LayerManager.qipanContainer.addChild(shape);
			qiziArr = [];

			for (i = 0; i < h; i++) {
				var lie:Array = [];
				lie.length = l;
				qiziArr.push(lie);
			}
		}

		private function startGame():void {
			role = 0;
			stage.addEventListener(MouseEvent.CLICK, onXiaQi);
		}

		private function onXiaQi(e:MouseEvent):void {
			var p:Point = this.globalToLocal(new Point(e.stageX, e.stageY));
			var h:int = p.x / CONST.UINT_WIDTH;
			var l:int = p.y / CONST.UINT_HEIGHT;
			if (!qiziArr[h][l]) {
				var qizi:UIQiZi = new UIQiZi(role, h, l);
				qizi.x = h * CONST.UINT_WIDTH + CONST.UINT_WIDTH / 2;
				qizi.y = l * CONST.UINT_HEIGHT + CONST.UINT_HEIGHT / 2;
				addChild(qizi);
				qiziArr[h][l] = qizi;
				checkFive(h, l, role);
				role = role == 1 ? 0 : 1;
				trace("此棋下在了" + l + " " + h + "处")
			} else {
				trace("此处已经有棋子了！");
			}
		}

		private function checkFive(l:int, h:int, type:int):void {
			//横向检查
			var fiveVector:Vector.<UIQiZi> = new Vector.<UIQiZi>();
			var isFind:Boolean = false;
			for (var kk:int = -lie; kk < lie; kk++) {
				var ii:int = l + kk;
				if (ii >= 0 && ii <= lie - 1) {
//					trace("检查的是" + h + " " + ii);
					var qizi:UIQiZi = qiziArr[ii][h];
					if (qizi && qizi.type == type) {
						fiveVector.push(qizi);
//						trace("fiveCount " + fiveCount);
						if (fiveVector.length >= 5) {
							trace("横向至少五个了");
							isFind = true;
						}
					} else {
						if (isFind) {
							trace("1横向" + fiveVector.length + "个了");
							break;
						}
						fiveVector.length = 0;
					}
				} else {
					if (isFind) {
						trace("2横向" + fiveVector.length + "个了");
						break;
					}
				}
			}

			//纵向检查
			fiveVector.length = 0;
			isFind = false;
			for (kk = -hang; kk < hang; kk++) {
				var uu:int = h + kk;
				if (uu >= 0 && uu <= hang - 1) {
//					trace("检查的是" + uu + " " + l);
					qizi = qiziArr[l][uu];
					if (qizi && qizi.type == type) {
						fiveVector.push(qizi);
//						trace("fiveCount " + fiveCount);
						if (fiveVector.length >= 5) {
							trace("纵向至少五个了");
							isFind = true;
						}
					} else {
						if (isFind) {
							trace("1纵向" + fiveVector.length + "个了");
							break;
						}
						fiveVector.length = 0;
					}
				} else {
					if (isFind) {
						trace("2纵向" + fiveVector.length + "个了");
						break;
					}
				}
			}

			//右斜检查
			fiveVector.length = 0;
			isFind = false;
			var max:int = Math.max(hang, lie);
			for (kk = -max; kk < max; kk++) {
				uu = h + kk;
				ii = l + kk;
				if (uu >= 0 && ii >= 0 && uu <= hang - 1 && ii <= lie - 1) {
//					trace("检查的是: " + uu, ii);
					qizi = qiziArr[uu][ii];
					if (qizi && qizi.type == type) {
						fiveVector.push(qizi);
						if (fiveVector.length >= 5) {
							trace("右斜至少五个了");
							isFind = true;
						}
					} else {
						if (isFind) {
							trace("1右斜" + fiveVector.length + "个了");
							break;
						}
						fiveVector.length = 0;
					}
				} else {
					if (isFind) {
						trace("2右斜" + fiveVector.length + "个了");
						break;
					}
				}
			}

			//左斜检查
			fiveVector.length = 0;
			isFind = false;
			for (kk = -max; kk < max; kk++) {
				uu = h + kk;
				ii = l - kk;
				if (uu >= 0 && ii >= 0 && uu <= hang - 1 && ii <= lie - 1) {
//					trace("检查的是: " + uu, ii);
					qizi = qiziArr[uu][ii];
					if (qizi && qizi.type == type) {
						fiveVector.push(qizi);
						if (fiveVector.length >= 5) {
							trace("左斜至少五个了");
							isFind = true;
						}
					} else {
						if (isFind) {
							trace("1左斜" + fiveVector.length + "个了");
							break;
						}
						fiveVector.length = 0;
					}
				} else {
					if (isFind) {
						trace("2左斜" + fiveVector.length + "个了");
						break;
					}
				}
			}
		}
	}
}




















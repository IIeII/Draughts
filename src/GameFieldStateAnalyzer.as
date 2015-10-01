package {
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class GameFieldStateAnalyzer extends EventDispatcher{

		public static const EVENT_UPDATE:String = "event_update";

		private var selectedCell:XYPair = null;

		private var gameField:Array;


		public function initField():void {

			gameField = [
				[CellPlaceHolderTypes.PLAYER, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.PLAYER, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.PLAYER, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.PLAYER, CellPlaceHolderTypes.INACTIVE], //1
				[CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.PLAYER, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.PLAYER, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.PLAYER, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.PLAYER], //2
				[CellPlaceHolderTypes.PLAYER, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.PLAYER, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.PLAYER, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.PLAYER, CellPlaceHolderTypes.INACTIVE], //3
				[CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.EMPTY, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.EMPTY, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.EMPTY, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.EMPTY], //4
				[CellPlaceHolderTypes.EMPTY, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.EMPTY, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.EMPTY, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.EMPTY, CellPlaceHolderTypes.INACTIVE], //5
				[CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.ENEMY, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.ENEMY, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.ENEMY, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.ENEMY], //6
				[CellPlaceHolderTypes.ENEMY, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.ENEMY, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.ENEMY, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.ENEMY, CellPlaceHolderTypes.INACTIVE], //7
				[CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.ENEMY, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.ENEMY, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.ENEMY, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.ENEMY]  //8
			];
			notifyUpdate();
		}


		public function onClickByCell(x:String, y:String):void {

			var lastClick:XYPair = new XYPair(x, y);

			if (selectedCell == null){
				selectedCell = lastClick;
			}


		}

		public function getMarkType(x:String, y:String):int {

			if (selectedCell && selectedCell.x == x && selectedCell.y == y){
				return CellMarkTypes.SELECTED;
			}

			return CellMarkTypes.EMPTY;
		}

		public function getPlaceHolderType(x:String, y:String):int {

			return -1;
		}

		private function notifyUpdate():void {
			dispatchEvent(new Event(EVENT_UPDATE));
		}
	}
}

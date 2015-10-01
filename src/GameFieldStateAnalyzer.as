package {
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class GameFieldStateAnalyzer extends EventDispatcher{

		public static const EVENT_UPDATE:String = "event_update";

		private var selectedCell:XYPair = null;

		private var gameField:Array;

		private var xCollection:Array = ["a", "b", "c", "d", "e", "f", "g", "h"];
		private var yCollection:Array = ["1", "2", "3", "4", "5", "6", "7", "8"];

		public function GameFieldStateAnalyzer() {

			initField();
		}

		public function initField():void {

			gameField = [
				[CellPlaceHolderTypes.PLAYER, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.PLAYER, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.EMPTY, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.ENEMY, CellPlaceHolderTypes.INACTIVE], //1
				[CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.PLAYER, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.EMPTY, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.ENEMY, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.ENEMY], //2
				[CellPlaceHolderTypes.PLAYER, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.PLAYER, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.EMPTY, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.ENEMY, CellPlaceHolderTypes.INACTIVE], //3
				[CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.PLAYER, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.EMPTY, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.ENEMY, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.ENEMY], //4
				[CellPlaceHolderTypes.PLAYER, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.PLAYER, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.EMPTY, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.ENEMY, CellPlaceHolderTypes.INACTIVE], //5
				[CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.PLAYER, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.EMPTY, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.ENEMY, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.ENEMY], //6
				[CellPlaceHolderTypes.PLAYER, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.PLAYER, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.EMPTY, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.ENEMY, CellPlaceHolderTypes.INACTIVE], //7
				[CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.PLAYER, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.EMPTY, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.ENEMY, CellPlaceHolderTypes.INACTIVE, CellPlaceHolderTypes.ENEMY]  //8
			];
		}


		public function onClickByCell(x:String, y:String):void {

			var lastClick:XYPair = new XYPair(x, y);

			if (selectedCell == null && getPlaceHolderType(x, y) == CellPlaceHolderTypes.PLAYER){
				selectedCell = lastClick;
				notifyUpdate();
				return;
			}

			if (selectedCell && getPlaceHolderType(x, y) == CellPlaceHolderTypes.EMPTY){

				if(checkForPossibleMove(x, y)){
					setPlaceHolderType(selectedCell.x, selectedCell.y, CellPlaceHolderTypes.EMPTY);
					setPlaceHolderType(x, y, CellPlaceHolderTypes.PLAYER);
					selectedCell = null;
					notifyUpdate();
					return;
				}
			}

			if (selectedCell && getPlaceHolderType(x, y) == CellPlaceHolderTypes.PLAYER){

				selectedCell = lastClick;
				notifyUpdate();
			}

			notifyUpdate();
		}

		private function checkForPossibleMove(x:String, y:String):Boolean {

			var allowX:Boolean = Math.abs(xCollection.indexOf(selectedCell.x) - xCollection.indexOf(x)) == 1;
			var allowY:Boolean = yCollection.indexOf(y) - yCollection.indexOf(selectedCell.y) == 1;

			return allowX && allowY;
		}

		public function getMarkType(x:String, y:String):int {

			if (selectedCell && selectedCell.x == x && selectedCell.y == y){
				return CellMarkTypes.SELECTED;
			}

			return CellMarkTypes.EMPTY;
		}

		public function getPlaceHolderType(x:String, y:String):int {

			var _x:Array = gameField[xCollection.indexOf(x)];

			var result:int = _x[yCollection.indexOf(y)];

			return result;
		}

		private function setPlaceHolderType(x:String, y:String, type:int):void {

			gameField[xCollection.indexOf(x)][yCollection.indexOf(y)] = type;
		}
		
		private function notifyUpdate():void {
			dispatchEvent(new Event(EVENT_UPDATE));
		}
	}
}

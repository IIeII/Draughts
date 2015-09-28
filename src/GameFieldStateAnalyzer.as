package {
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class GameFieldStateAnalyzer extends EventDispatcher{

		private var selectedCell:XYPair = null;

		public static const EVENT_UPDATE:String = "event_update";



		public function onClickByCell(x:String, y:String):void {

//			if (selectedCell == null){
				selectedCell = new XYPair(x, y);
//			}
			dispatchEvent(new Event(EVENT_UPDATE));
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
	}
}

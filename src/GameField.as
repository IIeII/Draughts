package {
    import flash.display.MovieClip;
    import flash.display.Sprite;

    public class GameField extends Sprite{

        private var gameFieldMC:MovieClip;
        private var gameFieldState:GameFieldStateAnalyzer;

        public function GameField() {

            initMainMC();
            initCells();
        }

        private function initMainMC():void {
            gameFieldMC = Warehouse.getInstance().getClassByName("game_field") as MovieClip;
            gameFieldState = new GameFieldStateAnalyzer();
            this.addChild(gameFieldMC);
        }

        private function initCells():void {

            var xCollection:Array = ["a", "b", "c", "d", "e", "f", "g", "h"];
            var yCollection:Array = ["1", "2", "3", "4", "5", "6", "7", "8"];

            for (var i:int = 0; i < xCollection.length; i++){
                for (var j:int = 0; j < yCollection.length; j++){
                    var cellName:String = xCollection[i].toString() + "_" + yCollection[j].toString();
                    new Cell(xCollection[i], yCollection[j], gameFieldMC[cellName], gameFieldState);
                }
            }

        }


    }
}

package {
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;

    public class Cell {

        public var x:String;
        public var y:String;

        private var cell_mc:MovieClip;
        private var player_mc:MovieClip;
        private var enemy_mc:MovieClip;
        private var player_queen_mc:MovieClip;
        private var enemy_queen_mc:MovieClip;

        private var gameFieldState:GameFieldStateAnalyzer;

        private var layerForChip:Sprite;

        public function Cell(x:String, y:String, cellMC:MovieClip, gameFieldState:GameFieldStateAnalyzer) {

            this.x = x;
            this.y = y;
            this.cell_mc = cellMC;
            this.gameFieldState = gameFieldState;
            init();
        }

        private function init():void {

            gameFieldState.addEventListener(GameFieldStateAnalyzer.EVENT_UPDATE, update);
            cell_mc.addEventListener(MouseEvent.CLICK, onClick);

            initArt();
            update();
        }

        private function onClick(event:Event):void {
            gameFieldState.onClickByCell(x, y);
        }

        private function update(event:Event = null):void {

            updateMarkCell();
            updatePlaceHolder();
        }

        private function updatePlaceHolder():void {

            var cellPlaceHolder:int = gameFieldState.getPlaceHolderType(x, y);

            switch (cellPlaceHolder){
                case CellPlaceHolderTypes.INACTIVE:
                    disableCell();
                    break;
                case CellPlaceHolderTypes.EMPTY:
                    clearPlaceHolder();
                    break;
                case CellPlaceHolderTypes.PLAYER:
                    setPlaceHolder(player_mc);
                    break;
                case CellPlaceHolderTypes.ENEMY:
                    setPlaceHolder(enemy_mc);
                    break;
                case CellPlaceHolderTypes.PLAYER_QUEEN:
                    setPlaceHolder(player_queen_mc);
                    break;
                case CellPlaceHolderTypes.ENEMY_QUEEN:
                    setPlaceHolder(enemy_queen_mc);
                    break;
            }
        }

        private function disableCell():void {

            gameFieldState.removeEventListener(GameFieldStateAnalyzer.EVENT_UPDATE, update);
            cell_mc.visible = false;
        }

        private function setPlaceHolder(place_holder_mc:MovieClip):void {

            clearPlaceHolder();
            layerForChip.addChild(place_holder_mc);
        }

        private function clearPlaceHolder():void {

            while(layerForChip.numChildren > 0) {
                layerForChip.removeChildAt(0);
            }
        }

        private function updateMarkCell():void {

            var cellMarkType:int = gameFieldState.getMarkType(x, y);

            switch (cellMarkType){
                case CellMarkTypes.EMPTY:
                    markCellAsEmpty();
                    break;
                case CellMarkTypes.SELECTED:
                    markCellAsSelected();
                    break;
                case CellMarkTypes.TIME_LAPS:
                    markTimeLaps();
                    break;
                case CellMarkTypes.FREE_TO_MOVE:
                    markCellAsAvailableToMove();
                    break;
            }
        }

        private function initArt():void {

            layerForChip = new Sprite();
            layerForChip.mouseChildren = false;
            layerForChip.mouseEnabled = false;
            cell_mc.addChild(layerForChip);

            player_mc = initSimpleChip("player_simple");
            player_queen_mc = initSimpleChip("player_queen");
            enemy_mc = initSimpleChip("enemy_simple");
            enemy_queen_mc = initSimpleChip("enemy_queen");
        }

        private function initSimpleChip(name:String):MovieClip {

            var result:MovieClip = Warehouse.getInstance().getClassByName(name) as MovieClip;
            result.mouseChildren = false;
            result.mouseEnabled = false;

            return result;
        }

        private function markCellAsEmpty():void {

            cell_mc.gotoAndStop("empty");
        }

        private function markCellAsSelected():void {

            cell_mc.gotoAndStop("select");
        }

        private function markCellAsAvailableToMove():void {

            cell_mc.gotoAndStop("move");
        }

        private function markTimeLaps():void {

            cell_mc.gotoAndStop("time_laps");
        }

    }
}

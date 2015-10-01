package {

    import flash.display.Sprite;
    import flash.display.StageAlign;

    [SWF(width = "1024", height = "768", scaleMode = "noScale")]

    public class Main extends Sprite {

        public function Main() {

            predefineSettings();
            loadResource();
        }

        private function predefineSettings():void {

            stage.align = StageAlign.TOP_LEFT;
        }

        private function loadResource():void {

            Warehouse.getInstance().init(startApp);
        }

        private function startApp():void {

            addChild(new GameFieldScreen());
        }
    }
}

package {
import flash.display.DisplayObjectContainer;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.events.Event;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;

public class Warehouse {

    private static var instance:Warehouse;
    private var loaderInfo:LoaderInfo;
    private var callback:Function;

    [Embed(source="../res/swf/scene.swf", mimeType="application/octet-stream")]
    private var SwfClass:Class;

    public function init(callback:Function):void {

        this.callback = callback;

        var context : LoaderContext = new LoaderContext (false,
                ApplicationDomain.currentDomain);
        context.allowCodeImport = true;

        var loader : Loader = new Loader ();
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
        loader.loadBytes(new SwfClass(), context);
    }

    private function onComplete(event:Event):void {
        loaderInfo = event.target as LoaderInfo;
        callback();
    }

    public static function getInstance():Warehouse
    {
        if (instance == null)
        {
            instance = new Warehouse();
        }
        return instance as Warehouse;
    }

    public function getClassByName(name:String):DisplayObjectContainer
    {
        var item:Class = null;
            if (loaderInfo.applicationDomain.hasDefinition(name)){
                item = loaderInfo.applicationDomain.getDefinition(name) as Class;
                var exempl:DisplayObjectContainer = new item();
            }
        return exempl;
    }
}
}

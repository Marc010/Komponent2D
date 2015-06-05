package komponent.components.graphic;

import kha.Color;
import kha.Font;
import kha.FontStyle;
import kha.Loader;

import komponent.utils.Painter;
import komponent.utils.Screen;

using komponent.utils.Parser;

class Text extends Graphic
{
	
	public var text:String;
	public var font:Font;
	public var size(get, set):Float;
	public var fontstyle(get, set):FontStyle;
	
	override public function added() 
	{
		super.added();
		text = "";
	}
	
	override public function render()
	{
		if (visible && font != null)
		{
			//Painter.set(color, alpha, font);
			for (camera in Screen.cameras)
			{
				//Painter.matrix = camera.matrix * matrix;
				Painter.matrix = camera.matrix.multmat(matrix);
				//Painter.drawString(text, 0, 0);
				Painter.matrix = null;
			}
		}
	}
	
	public inline function set(text:String, font:Font)
	{
		this.text = text;
		this.font = font;
	}
	
	override public function loadConfig(data:Dynamic):Void
	{
		visible = data.visible.parse(true);
		text = data.text.parse("");
		
		var file:String = data.font.file;
		var size:Float = data.font.size;
		var style:FontStyle = data.style.parseFontStyle(FontStyle.Default);
		if (file != null && data.font.size != null && size > 0)
			font = Loader.the.loadFont(file, style, size);
	}
	
	private override function get_width():Float { return font.stringWidth(text); }
	private override function get_height():Float { return font.getHeight(); }
	
	private inline function get_size():Float { return font.size; }
	private inline function set_size(value:Float):Float
	{
		//font = Loader.the.loadFont(font.name, font.style, value);
		return value;
	}
	
	private inline function get_fontstyle():FontStyle { return font.style; }
	private inline function set_fontstyle(value:FontStyle):FontStyle
	{
		//font = Loader.the.loadFont(font.name, value, font.size);
		return value;
	}
}
import flixel.FlxSprite;

class Hold extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super();
		this.x = x;
		this.y = y;
		loadGraphic("assets/images/handhold.png", false, 34, 43);
	}
}

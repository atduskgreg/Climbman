package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.nape.FlxNapeSpace;
import flixel.addons.nape.FlxNapeSprite;
import flixel.text.FlxText;

class PlayState extends FlxState
{
	override public function create()
	{
		super.create();

		FlxNapeSpace.init();

		FlxNapeSpace.createWalls(-2000, -2000, 1640, 480);

		FlxNapeSpace.space.gravity.setxy(0, 500);

		HoldManager.instance.generateHolds();
		HoldManager.instance.addTo(this);

		var climber = new Ragdoll(315, 230);
		climber.init();
		climber.createGraphics("climber");
		add(climber);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		ClimberController.instance.update();
	}
}

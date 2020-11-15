import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;

class HoldManager
{
	public var holds = new FlxTypedGroup<Hold>();

	public static final instance:HoldManager = new HoldManager();

	public function generateHolds()
	{
		for (i in 0...6)
		{
			for (j in 0...6)
			{
				var x = 100 * j + (30 - Std.int(Math.random() * 60));
				var y = 100 * i + (30 - Std.int(Math.random() * 60));

				var hold = new Hold(x, y);
				holds.add(hold);
			}
		}
	}

	public function addTo(state:FlxState)
	{
		for (hold in holds)
		{
			state.add(hold);
		}
	}

	public function checkHolds(obj:FlxObject, callback:(FlxObject, FlxObject) -> Void)
	{
		FlxG.overlap(holds, obj, callback);
	}

	private function new() {}
}

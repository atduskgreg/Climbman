import flixel.FlxG;
import flixel.FlxObject;
import flixel.addons.nape.FlxNapeSpace;
import flixel.addons.nape.FlxNapeSprite;
import flixel.input.mouse.FlxMouseEventManager;
import nape.constraint.DistanceJoint;
import nape.constraint.PivotJoint;
import nape.geom.Vec2;

class ClimberController
{
	public static final instance:ClimberController = new ClimberController();

	var mouseJoint:DistanceJoint;

	var limbHoldJoints = new Map<FlxNapeSprite, DistanceJoint>();

	var movedBodyPart:FlxNapeSprite;

	public inline function registerControllableLimb(limbSprite:FlxNapeSprite)
	{
		FlxMouseEventManager.add(limbSprite, OnMouseDownOnJoint, OnMouseUpOnJoint);
	}

	function OnMouseDownOnJoint(limbSprite:FlxNapeSprite)
	{
		var existingJoint = limbHoldJoints.get(limbSprite);
		if (existingJoint != null)
		{
			existingJoint.space = null;
			trace("joint removed");
		}

		movedBodyPart = limbSprite;
		mouseJoint = new DistanceJoint(FlxNapeSpace.space.world, limbSprite.body, new Vec2(FlxG.mouse.x, FlxG.mouse.y),
			limbSprite.body.worldPointToLocal(new Vec2(FlxG.mouse.x, FlxG.mouse.y)), 0, 0);

		mouseJoint.space = FlxNapeSpace.space;
	}

	function OnMouseUpOnJoint(limbSprite:FlxNapeSprite)
	{
		HoldManager.instance.checkHolds(limbSprite, grabHold);
		mouseJoint.space = null;
	}

	public function grabHold(object1:FlxObject, object2:FlxObject)
	{
		if (Std.is(object1, Hold))
		{
			trace("object1 is a hold");

			var holdJoint = new DistanceJoint(FlxNapeSpace.space.world, movedBodyPart.body, new Vec2(object1.x, object1.y),
				movedBodyPart.body.worldPointToLocal(new Vec2(object1.x, object1.y)), 0, 0);
			holdJoint.space = FlxNapeSpace.space;
			var existingJoint = limbHoldJoints.get(movedBodyPart);
			if (existingJoint != null)
			{
				trace("nulling existing joint");
				existingJoint.space = null;
			}
			limbHoldJoints.set(movedBodyPart, holdJoint);
		}

		if (Std.is(object2, Hold))
		{
			trace("object2 is a hold");
		}
	}

	public function update()
	{
		if (mouseJoint != null)
		{
			mouseJoint.anchor1 = new Vec2(FlxG.mouse.x, FlxG.mouse.y);

			if (FlxG.mouse.justReleased)
			{
				mouseJoint.space = null;
			}
		}
	}

	private function new() {}
}

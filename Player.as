package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class Player extends MovieClip {
		
		var location:Vector2;
		var velocity:Vector2;
		var acceleration:Vector2;
		var mult;
		

		
		public function Player() {
			// constructor code
			
			location = new Vector2(512,384);
			velocity = new Vector2(0,0);
			acceleration = new Vector2(-0.001,0.01);
			mult = new Vector2(0.5 , 0.5);

			addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function update(e:Event) {
			
			this.x = location.x;
			this.y = location.y;
			
			
			var mouse:Vector2 = new Vector2(stage.mouseX, stage.mouseY);
			var dir:Vector2 = mouse.sub(location);
			dir.normalize();
			dir.mult(mult);
			acceleration = dir;
			
			this.rotation = Vector2.rad2deg(mouse.getAngle());
			
			location.add(velocity);
			
		}
		
		
	}
	
}
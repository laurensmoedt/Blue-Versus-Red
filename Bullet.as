package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	
	public class Bullet extends MovieClip {
		
		var location:Vector2;
		var velocity:Vector2;
		var acceleration:Vector2;
		var mult;
		var topSpeed:uint;
		
		public function Bullet() {
			// constructor code
			
			
			location = new Vector2(512, 384);
			velocity = new Vector2(0, 0);
			acceleration = new Vector2(0, 0);
			mult = new Vector2(10, 10);
			topSpeed = 10;
			
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		public function enterFrame(e:Event){
			velocity.add(acceleration);
			location.add(velocity);
			velocity.limit(topSpeed);
				
			this.rotation = Vector2.rad2deg(velocity.getAngle());
			
			this.x = location.x;
			this.y = location.y;
			
		}
		
		public function towardLocation(){
			
			var mouse:Vector2 = new Vector2(mouseX, mouseY);
			var dir:Vector2 = mouse.sub(location);
			dir.normalize();
			dir.mult(mult);
			acceleration = dir;
		}
		
		
	}
	
}
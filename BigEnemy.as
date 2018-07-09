package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class BigEnemy extends MovieClip {
		
		var location:Vector2;
		var velocity:Vector2;
		var acceleration:Vector2;
		var mult;
		var bigguyHP:uint;
		
		var backgroundWin:BackgroundWin;
		
		var topSpeed:uint;
		
		public function BigEnemy() {
			// constructor code
			this.x = -100;
			this.y = -100;
			
			var r = Math.random();
			var ty = 768;
			if (r < 0.5) {
				ty = 0;
			} else {
				ty = 768;
			}
			
			location = new Vector2(Math.random()*1024,ty);
			velocity = new Vector2(0,0);
			acceleration = new Vector2(-0.001,0.01);
			mult = new Vector2(0.3 , 0.3);
			topSpeed = 0.3;
			bigguyHP = 100;
			
			
			addEventListener(Event.ENTER_FRAME, update);
			
			
		}
		
		public function update(e:Event) {
			
			this.x = location.x;
			this.y = location.y;
			
			this.rotation = Vector2.rad2deg(velocity.getAngle());
			
			velocity.add(acceleration);
			location.add(velocity);
			velocity.limit(topSpeed);
			
			var mouse:Vector2 = new Vector2(512,384);
			var dir:Vector2 = mouse.sub(location);
			dir.normalize();
			dir.mult(mult);
			acceleration = dir;
			
		}
			
			
	}
		
		
}
	


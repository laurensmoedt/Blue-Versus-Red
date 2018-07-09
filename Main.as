package  {
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Timer;
	import flash.ui.Keyboard;
	import flash.media.Sound;
	import com.adobe.tvsdk.mediacore.events.TimeChangeEvent;

	
	public class Main extends MovieClip {
		
		static var player:Player;
		static var bullet:Bullet;
		static var enemy:Enemy;
		static var fastEnemy:FastGuy;
		static var bigEnemy:BigEnemy;
		static var realhitbox:RealBorder;
		var enemiesN:int;
		static var begin:Beginning;
		
		var bullets:Array;
		var enemies:Array;
		var fastEnemyA:Array;
		var bigEnemyA:Array;
		
		var enemyTimer:Timer;
		var timer:Timer;
		
		var background:Background;
		var backgroundWin:BackgroundWin;
		static var backgroundLose:BackgroundLose;
		
		var soundtrack:Sound;
		static var gunshot:Sound;
		
		
		public function Main() {
			// constructor code
			backgroundLose = new BackgroundLose();
			backgroundWin = new BackgroundWin()
			
			realhitbox = new RealBorder();
			addChild(realhitbox);
			
			background = new Background();
			addChild(background);
			
			player = new Player();
			addChild(player);
			
			soundtrack = new BvsR();
			soundtrack.play(0, 9999);
			
			gunshot = new gunShot();
			
			enemiesN = 0;
			
			
			bullets = new Array();
			enemies = new Array();
			fastEnemyA = new Array();
			bigEnemyA = new Array();
			
			begin = new Beginning();
			stage.addChild(begin);
			
			enemyTimer = new Timer(600);
			enemyTimer.addEventListener(TimerEvent.TIMER, sendEnemy);
			enemyTimer.start();
			
			addEventListener(MouseEvent.MOUSE_DOWN, activateBullet);
			addEventListener(Event.ENTER_FRAME, collision);
		}

		
		
		public function sendEnemy(e:Event){
			enemy = new Enemy();
			bigEnemy = new BigEnemy();
			fastEnemy = new FastGuy();
			enemiesN++;
			trace(enemiesN);
			enemies.push(enemy);
			fastEnemyA.push(fastEnemy);
			
			addChild(enemy);
			addChild(fastEnemy);
			
			if(enemiesN == 100){
				addChild(bigEnemy);
				bigEnemyA.push(bigEnemy);
			}
			
		}
		
		
		public function activateBullet(e:Event){
			
			bullet = new Bullet();
			this.addChild(bullet);
			bullet.towardLocation();
			gunshot.play();
			bullets.push(bullet);
			
		}
		
		
		
		public function collision(e:Event){
			
			
			for(var i = bullets.length-1; i >= 0; i--){
				var  bulleti:Bullet = bullets[i];
				
				for(var a = bigEnemyA.length-1; a >= 0; a--){
					var bigEnemya:BigEnemy = bigEnemyA[a];
					
					if(bigEnemya.scaleX <= 0.3){
							removeChild(bigEnemya);
							stage.addChild(backgroundWin);
					}
						
					if(bulleti.hitTestObject(bigEnemya)){
						bigEnemya.scaleX -=0.02;
						bigEnemya.scaleY -=0.02;
						removeChild(bulleti);
						bullets.removeAt(i);
					}
				}
			
				for(var p = fastEnemyA.length-1; p >= 0; p--){
					var fastEnemyp:FastGuy = fastEnemyA[p];
					
					if(bulleti.hitTestObject(fastEnemyp)){
						removeChild(bulleti);
						bullets.removeAt(i);
						removeChild(fastEnemyp);
						fastEnemyA.removeAt(p);
					}
					
					if(realhitbox.hitTestObject(fastEnemyp)){
						removeChild(fastEnemyp);
						fastEnemyA.removeAt(p);
					}
				}
				
				for(var j = enemies.length-1; j >= 0; j--){
					var enemyj:Enemy = enemies[j];
					if((enemyj.scaleX <= 0 )|| (enemyj.scaleY <= 0)){
						removeChild(enemyj);
						enemies.removeAt(j);
					}
					if(bulleti.hitTestObject(enemyj)){
						trace(bullets);
						removeChild(bulleti);
						bullets.removeAt(i);
						enemyj.scaleY -= 0.501;
						enemyj.scaleX -= 0.501;
						stage.removeChild(begin);
						
					}
					
					if(realhitbox.hitTestObject(enemyj)){
						removeChild(enemyj);
						enemies.removeAt(j);
						stage.addChild(backgroundLose);
					}
				}
			}
			
		}
		
		
	}
	
}

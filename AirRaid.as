package 
{
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.sampler.NewObjectSample;
	import flash.media.SoundMixer;
	import flash.utils.getTimer;

	public class AirRaid extends MovieClip
	{
		private var hargun:HarGun;
		private var harplane:Array;
		private var harbullet:Array;
		public var leftArrow,rightArrow:Boolean;
		private var nextPlane:Timer;
		public var rScore:int;
		public var BulletNum:int;
		private var recover:int;
		private var time:int;
		public var timeTimer:Timer;
		private var drectangle:Rectangle;
		public var cutted:Boolean;
		var help_btn_open:Boolean = false;
		private var stop_game:Stop_game;
		public static var assume_stop:Boolean = false;
		public static var stopbtnchecked:Boolean = false;
		public static var stop_time:int = 0;
		public static var oabout:Boolean=false;

		public function startAirRoid()
		{
			// constructor code
			rScore = 0;
			BulletNum = 50;
			recover = 1;
			time = 60;
			cutted = false;
			showGameScore();

			hargun = new HarGun();
			drectangle = new Rectangle(33.85,458,198.95,0);
			stop_game=new Stop_game();

			addChild(hargun);

			harplane = new Array();
			harbullet = new Array();
			timeTimer = new Timer(1000);


			about.addEventListener(MouseEvent.CLICK,openabout);
			fire.addEventListener(MouseEvent.CLICK,fireBullet);
			timeTimer.addEventListener(TimerEvent.TIMER,calTime);
			hargun.addEventListener(MouseEvent.MOUSE_DOWN,dragGun);
			hargun.addEventListener(MouseEvent.MOUSE_UP,stopdragGun);
			bg_fire.addEventListener(MouseEvent.CLICK,fireBullet);
			addEventListener(Event.ENTER_FRAME,checkforhits);
			help_btn.addEventListener(MouseEvent.CLICK,clickhelpbtn);
			stop_btn.addEventListener(MouseEvent.CLICK,clickstopbtn);

			timeTimer.start();

			setNextPlane();
		}

		function clickhelpbtn(event:MouseEvent)
		{
			if (help_btn_open==false)
			{
				helpbtns.gotoAndPlay(1);
				help_btn_open = true;
			}
			else
			{
				helpbtns.gotoAndPlay(5);
				helpbtns.x = 377;
				helpbtns.y = 410;
				help_btn_open = false;
			}
		}

		function clickstopbtn(event:MouseEvent)
		{
			stop_game.x = 160;
			stop_game.y = 240;
			parent.addChild(stop_game);
			stop_game.gotoAndPlay(1);
		}

		public function dragGun(event:MouseEvent)
		{
			hargun.startDrag(false,drectangle);
		}

		public function stopdragGun(event:MouseEvent)
		{
			hargun.stopDrag();
		}

		public function calTime(event:TimerEvent)
		{
			if (assume_stop == false)
			{
				if (time>0)
				{
					time--;
					game_time.text=String("Time:"+time);
				}
				else
				{
					endGame();
				}
			}
		}

		public function setNextPlane()
		{
			if (assume_stop == false)
			{
				nextPlane = new Timer((1000 + Math.random() * 1000),1);
				nextPlane.addEventListener(TimerEvent.TIMER_COMPLETE,newPlane);
				nextPlane.start();
			}
		}

		public function newPlane(event:TimerEvent)
		{
			var side:String;
			if (Math.random() > .5)
			{
				side = "left";
			}
			else
			{
				side = "right";
			}
			var altitude:Number = Math.random() * 40 + 30;
			var speed:Number = Math.random() * 150 + 100;

			var p:AirPlane = new AirPlane(side,altitude,speed);
			addChild(p);
			harplane.push(p);

			setNextPlane();
		}

		public function checkforhits(event:Event)
		{
			if (assume_stop == false)
			{
				stop_time = 0;
				for (var bnum:int = harbullet.length - 1; bnum >= 0; bnum--)
				{
					for (var pnum:int = harplane.length - 1; pnum >= 0; pnum--)
					{
						if (harbullet[bnum].hitTestObject(harplane[pnum]))
						{
							harplane[pnum].planeHit();
							harbullet[bnum].deleteBullet();
							rScore +=  Math.floor(Math.random() * 10 + Math.random() * 7 + Math.random());
							if (rScore>(recover*40))
							{
								BulletNum +=  10;
								time +=  10;
								recover++;
							}
							showGameScore();
							break;
						}
					}
				}
				if (BulletNum == 0)
				{
					endGame();
				}
			}
			else if (stopbtnchecked == true)
			{
				stopbtnchecked = false;
				assume_stop = false;
				stop_time = getTimer() - stop_time;
				setNextPlane();
			}

		}

		public function fireBullet(event:MouseEvent)
		{
			if (BulletNum>0)
			{
				var b:Bullet = new Bullet(hargun.x,hargun.y,-300);
				addChild(b);
				harbullet.push(b);
				BulletNum--;
				showGameScore();
			}
		}

		public function showGameScore()
		{
			bullet_number.text = String(BulletNum);
			game_score.text = "Score:" + String(rScore);
		}

		public function RemovePlane(plane:AirPlane)
		{
			for (var i in harplane)
			{
				if (harplane[i] == plane)
				{
					harplane.splice(i,1);
					break;
				}
			}
		}

		public function RemoveBullet(bullet:Bullet)
		{
			for (var i in harbullet)
			{
				if (harbullet[i] == bullet)
				{
					harbullet.splice(i,1);
					break;
				}
			}
		}

		public function endGame()
		{
			for (var i:int = harplane.length - 1; i >= 0; i--)
			{
				harplane[i].deletePlane();
			}
			harplane = null;

			hargun.deleteGun();
			hargun = null;

			removeEventListener(Event.ENTER_FRAME,checkforhits);
			bg_fire.removeEventListener(MouseEvent.CLICK,fireBullet);

			nextPlane.stop();
			nextPlane = null;
			timeTimer.stop();
			timeTimer = null;

			if (cutted==false)
			{
				gotoAndPlay(3);
			}
			else if (cutted==true)
			{
				gotoAndPlay(1);
			}
		}


		function openabout(event:MouseEvent)
		{
			oabout=true;
			stop_game.x = 160;
			stop_game.y = 240;
			parent.addChild(stop_game);
			stop_game.gotoAndPlay(1);
		}
	}
}
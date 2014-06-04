package 
{

	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import flash.events.Event;



	public class Bullet extends MovieClip
	{
		private var dy:Number;
		private var lastTime:int;


		public function Bullet(x,y:Number,speed:Number)
		{
			// constructor code
			this.x = x + 23.5;
			this.y = y;

			dy = speed;

			lastTime = getTimer();

			addEventListener(Event.ENTER_FRAME,MoveBullet);
		}

		public function MoveBullet(event:Event)
		{
			if (AirRaid.assume_stop == false)
			{
				lastTime+=AirRaid.stop_time;
				var timePassed = getTimer() - lastTime;
				lastTime +=  timePassed;

				this.y +=  dy * timePassed / 1000;

				if (this.y < 0)
				{
					deleteBullet();
				}
			}
		}

		public function deleteBullet()
		{
			MovieClip(parent).RemoveBullet(this);
			parent.removeChild(this);
			removeEventListener(Event.ENTER_FRAME,MoveBullet);
		}
	}

}
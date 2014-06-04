package 
{

	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import flash.events.Event;



	public class AirPlane extends MovieClip
	{
		private var dx:Number;
		private var lastTime:int;


		public function AirPlane(side:String,altitude:Number,speed:Number)
		{
			// constructor code
			if (side=="left")
			{
				this.x = -63;
				dx = speed;
				this.scaleX = -1;
			}
			else if (side=="right")
			{
				this.x = 380.5;
				dx =  -  speed;
				this.scaleX = 1;
			}
			this.y = altitude;
			var selectPlane:int = Math.floor(Math.random() * 3 + 1);
			this.gotoAndStop(selectPlane);

			addEventListener(Event.ENTER_FRAME,MovePlane);
			lastTime = getTimer();
		}

		public function MovePlane(event:Event)
		{
			if (AirRaid.assume_stop == false)
			{
				lastTime+=AirRaid.stop_time;
				var timePassed:int = getTimer() - lastTime;
				lastTime +=  timePassed;

				this.x +=  (dx * timePassed) / 1000;

				if ((dx<0)&&(this.x<-63))
				{
					deletePlane();
				}
				else if ((dx>0)&&(this.x>600))
				{
					deletePlane();
				}
			}
		}

		public function planeHit()
		{
			removeEventListener(Event.ENTER_FRAME,MovePlane);
			MovieClip(parent).RemovePlane(this);
			gotoAndPlay(4);
		}
		public function deletePlane()
		{
			removeEventListener(Event.ENTER_FRAME,MovePlane);
			MovieClip(parent).RemovePlane(this);
			parent.removeChild(this);
		}
	}

}
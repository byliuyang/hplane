package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	
	public class About_harry extends MovieClip {

		
		public function About_harry() {
			// constructor code
			x=0;
			y=-17;
			close_about.addEventListener(MouseEvent.CLICK,closemyabout);
		}
		
		public function closemyabout(event:MouseEvent)
		{
			this.gotoAndPlay(4);
		}
	}
	
}

package 
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class Stop_game extends MovieClip
	{

		public function Stop_game()
		{
			// constructor code
			assume_game.addEventListener(MouseEvent.CLICK,gameResume);
		}
		function gameResume(event:MouseEvent)
		{
			this.gotoAndPlay(7);
		}
	}

}
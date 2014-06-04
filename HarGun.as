package 
{

	import flash.display.MovieClip;
	import flash.display.*;
	import flash.events.*;
	import flash.utils.getTimer;


	public class HarGun extends MovieClip
	{
		public function HarGun()
		{
			// constructor code
			this.x = 133.80;
			this.y = 457.00;
		}

		public function deleteGun()
		{
			parent.removeChild(this);
		}
	}

}
package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class AreaBtn
	{
		private var _txt:TextField;
		
		private var _bg:MovieClip;
		
		private var _type:int;
		
		private var _tarMc:Sprite;
		public function AreaBtn(mc:Sprite, type:int)
		{
			_tarMc = mc;
			_tarMc.buttonMode = true;
			_type = type;
			
			_txt = mc["txt"];
			
			_bg = mc["bg"];
			
			mc.mouseChildren = false;
			mc.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			mc.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			mc.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private var _txtFormat:TextFormat = new TextFormat();
		
		private function onMouseOver(evt:MouseEvent):void
		{
			_txtFormat.color = 0xff0000;
			_txt.setTextFormat(_txtFormat);
			_bg.gotoAndStop(2);
		}
		
		private function onMouseOut(evt:MouseEvent):void
		{
			if (_isSelected == false)
			{
				_txtFormat.color = 0x333333;
				_txt.setTextFormat(_txtFormat);
				//			_txt.defaultTextFormat.color = 0x0000ff;
				_bg.gotoAndStop(1);
			}
		}
		
		private function onClick(evt:MouseEvent):void
		{
			Scene111.inst.setArea(this, _palletKey);
		}
		
		private var _isSelected:Boolean = false;
		public function reset(val:int):void
		{
			if (_type == val)
			{
				_isSelected = true;
				_txtFormat.color = 0xff0000;
				_txt.setTextFormat(_txtFormat);
				//				_txt.defaultTextFormat.color = 0x0000ff;
				_bg.gotoAndStop(3);
			}
			else
			{
				_isSelected = false;
				_txtFormat.color = 0x333333;
				_txt.setTextFormat(_txtFormat);
				//				_txt.defaultTextFormat.color = 0x333333;
				_bg.gotoAndStop(1);
			}
		}
		
		private var _palletIdx:int;
		private var _palletKey:String = "";
		public function show(name:String, type:int):void
		{
			var tmparr:Array = name.split("_");
			_palletIdx = int(tmparr[2]);
			_palletKey = tmparr[1];
			_txt.text = tmparr[0];
			
			_type = type;
			
			_tarMc.visible = true;
		}
		
		public function hide():void
		{
			_tarMc.visible = false;
		}
		
		public function get areaType():int
		{
			return _type;
		}
		
		public function get palletIdx():int
		{
			return _palletIdx ? _palletIdx : _type + 1;
		}
	}
}
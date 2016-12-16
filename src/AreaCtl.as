package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class AreaCtl
	{
		private var _btns:Vector.<AreaBtn>;
		
		private var _prev_btn:MovieClip;
		private var _next_btn:MovieClip;
		
		private var _data:Array;
		
		private var _startIdx:int = 0;
		
		public function AreaCtl(mainUI:RES_MainScene)
		{
			
			_btns = new Vector.<AreaBtn>();
			_btns.push(new AreaBtn(mainUI.area_1, 1));
			_btns.push(new AreaBtn(mainUI.area_2, 2));
			_btns.push(new AreaBtn(mainUI.area_3, 3));
			_btns.push(new AreaBtn(mainUI.area_4, 4));
			_btns.push(new AreaBtn(mainUI.area_5, 5));
			/*
			_prev_btn = mainUI.area_prev;
			_prev_btn.buttonMode = true;
			
			_next_btn = mainUI.area_next;
			_next_btn.buttonMode = true;
			
			_prev_btn.addEventListener(MouseEvent.CLICK, onPrev);
			_next_btn.addEventListener(MouseEvent.CLICK, onNext);
			*/
		}
		
		public function setData(data:Array):void
		{
			_data = data;
			
			_startIdx = 0;
			_curBtnType = -1;
			update();
		}
		
		private var _curBtnType:int = -1;
		public function setSelect(typeVal:int):void
		{
			_curBtnType = typeVal;
			for each (var areaBtn1:AreaBtn in _btns)
			{
				areaBtn1.reset(_curBtnType);
			}
		}
		
		private function onPrev(evt:MouseEvent):void
		{
			if (_startIdx > 0)
			{
				_startIdx --;
				
				update();
			}
		}
		
		private function onNext(evt:MouseEvent):void
		{
			if (_startIdx < Math.floor((_data.length - 1) / _btns.length))
			{
				_startIdx++;
				
				update();
			}
		}
		
		private function update():void
		{
			var tmpIdx:int = _startIdx * _btns.length;
			for (var i:int = 0; i < _btns.length; i++)
			{
				if (i + tmpIdx >= _data.length)
				{
					_btns[i].hide();
				}
				else
				{
					_btns[i].show(_data[i + tmpIdx], tmpIdx + i);
				}
			}
			
			if (_curBtnType != -1)
			{
				setSelect(_curBtnType);
			}
		}
	}
}
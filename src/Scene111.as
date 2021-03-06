package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import flash.utils.getDefinitionByName;
	
	import fl.controls.UIScrollBar;
	
	[SWF(width="1200", height="482", frameRate="30")]
	public class Scene111 extends Sprite
	{
		
		private static var _inst:Scene111;

		public static function get inst():Scene111
		{
			return _inst;
		}
		
		private var _bgCon:Sprite;
		
		private var _hScr:UIScrollBar;
		private var _hScrCon:Sprite;
		
		private var _vScr:UIScrollBar;
		private var _vScrCon:Sprite;
		private var _palletMC:Sprite;
		
		private var _areaTitleTxt:TextField;
		
		
		private var _curArea:int = 1;
		//		private var _areabtn_1:SimpleButton;
		//		private var _areabtn_2:SimpleButton;
		//		private var _areabtn_3:SimpleButton;
		//		private var _areaMCs:Vector.<AreaBtn>;
		
		private var _pallet:Sprite;
		
		Res_Map1;
		Res_Map2;
		Res_Map3;
		Res_Map4;
		Res_Map5;
		Res_Map6;
		Res_Map7;
		Res_Map8;
		Res_Map9;
		Res_Map10;
		Res_Map11;
	
	
		
		
		Res_Pallet1;
		Res_Pallet2;
		Res_Pallet3;
		Res_Pallet4;
		Res_Pallet5;
		Res_Pallet6;
		Res_Pallet7;
		Res_Pallet8;
		Res_Pallet9;
		Res_Pallet10;
		Res_Pallet11;
		
	
		
		private var _areaCtl:AreaCtl;
		
		public function Scene111()
		{
			_inst = this;
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			var mainUI:RES_MainScene = new RES_MainScene();
			addChild(mainUI);
			
			_areaTitleTxt = mainUI.areaTitleTxt;
			
			_pallet = mainUI.pallet_mc;
			
			_bgCon = mainUI.bg_con;
			
			_hScr = mainUI.h_scr;
			_hScr.width = 578;
			_hScr.maxScrollPosition = 2161 - 578;
			_hScr.pageSize = 800;
			_hScrCon = mainUI.vscr_con["con"];
			
			_vScr = mainUI.v_scr;
			_vScr.height = 375;
			_vScr.maxScrollPosition = 808 - 216;
			_vScr.pageSize = 100;
			_vScrCon = mainUI.pallet_mc["con"];
			
			_areaCtl = new AreaCtl(mainUI);
			//			_areaMCs = new Vector.<AreaBtn>();
			//			_areaMCs.push(new AreaBtn(mainUI.area_1, 1));
			//			_areaMCs.push(new AreaBtn(mainUI.area_2, 2));
			//			_areaMCs.push(new AreaBtn(mainUI.area_3, 3));
			//			_areaMCs.push(new AreaBtn(mainUI.area_4, 4));
			//			_areaMCs.push(new AreaBtn(mainUI.area_5, 5));
			//			_areabtn_1 = mainUI.areabtn_1;
			//			_areabtn_2 = mainUI.areabtn_2;
			//			_areabtn_3 = mainUI.areabtn_3;
			
			//			_areabtn_1.addEventListener(MouseEvent.CLICK, onSetAreaType);
			//			_areabtn_2.addEventListener(MouseEvent.CLICK, onSetAreaType);
			//			_areabtn_3.addEventListener(MouseEvent.CLICK, onSetAreaType);
			
			addEventListener(Event.ENTER_FRAME, onMoveScr);
			
			initMap(1);
			initMapEvt(_hScrCon);
			
			setPallet(1);
			
			_areaTitleTxt.text = Config.areaTitles[0];
			setAreas(Config.types[0]);
			
			//			setColor(1, 0xff0000);
		}
		
		private function setPallet(idx:int):void
		{
			if (_curPalletKey != idx)
			{
				_curPalletKey = idx;
				var cls:Class;
				if (this.loaderInfo.applicationDomain.hasDefinition("Res_Pallet" + idx))
				{
					cls = getDefinitionByName("Res_Pallet" + idx) as Class;
				}
				else
				{
					cls = Res_Pallet1;
				}
				_palletMC = new cls();
				
				_vScrCon.removeChildren();
				_vScrCon.addChild(_palletMC);
				
				_vScr.scrollPosition = 0;
				_vScr.maxScrollPosition = _palletMC.height - 216;
				
				initPallet(_palletMC);
			}
		}
		
		public function setAreas(areas:Array):void
		{
			_areaCtl.setData(areas);
			/*
			var areaMc:AreaBtn;
			for (var i:int = 0; i < _areaMCs.length; i++)
			{
			areaMc = _areaMCs[i];
			if (areas[i])
			{
			areaMc.show(areas[i]);
			}
			else
			{
			areaMc.hide();
			}
			}*/
		}
		
		private function initMapEvt(mapCon:Sprite):void
		{
			var childLen:int = mapCon.numChildren;
			var map_mc:Sprite;
			for (var i:int = 0; i < childLen; i++)
			{
				map_mc = mapCon.getChildAt(i) as Sprite;
				if (map_mc)
				{
					map_mc.buttonMode = true;
					map_mc.addEventListener(MouseEvent.CLICK, onSetMap);
				}
			}
		}
		
		private function onSetMap(evt:MouseEvent):void
		{
			var map_mc:Sprite = evt.currentTarget as Sprite;
			var mapIdx:int = int(map_mc.name.split("_")[1]);;		
			
			initMap(mapIdx);
		}
		
		private function initPallet(mc:Sprite):void
		{
			var childLen:int = mc.numChildren;
			var color_mc:Sprite;
			for (var i:int = 0; i < childLen; i++)
			{
				color_mc = mc.getChildAt(i) as Sprite;
				if (color_mc)
				{
					color_mc.buttonMode = true;
					color_mc.addEventListener(MouseEvent.CLICK, onSetColor);
				}
			}
		}
		
		private function onSetColor(evt:MouseEvent):void
		{
			var color_mc:Sprite = evt.currentTarget as Sprite;
			
			var tmpArr:Array = color_mc.name.split("_");
			//			var colorVal:int = ;
			
			if (tmpArr[0] == "an")
			{
				setColor(int("0x" + tmpArr[1]));
			}
			else
			{
				goFrame(int(tmpArr[1]));
			}
		}
		
		private function goFrame(frameIdx:int):void
		{
			if (_curArea == 1)
			{
				if (_areamc_1)
				{
					_areamc_1.gotoAndStop(frameIdx);
				}
			}
			else if (_curArea == 2)
			{
				if (_areamc_2)
				{
					_areamc_2.gotoAndStop(frameIdx);
				}
			}
			else if (_curArea == 3)
			{
				if (_areamc_3)
				{
					_areamc_3.gotoAndStop(frameIdx);
				}
			}
			else if (_curArea == 4)
			{
				if (_areamc_4)
				{
					_areamc_4.gotoAndStop(frameIdx);
				}
			}
			else if (_curArea == 5)
			{
				if (_areamc_5)
				{
					_areamc_5.gotoAndStop(frameIdx);
				}
			}
		}
		/*
		private function onSetAreaType(evt:MouseEvent):void
		{
		var tarObj:Object = evt.currentTarget;
		if (tarObj == _areabtn_1)
		{
		_curArea = 1;
		}
		else  if (tarObj == _areabtn_2)
		{
		_curArea = 2;
		}
		else  if (tarObj == _areabtn_3)
		{
		_curArea = 3;
		}
		}*/
		
		public function setArea(areaBtn:AreaBtn, palletKey:String):void
		{
			_curArea = areaBtn.palletIdx;
			
			if (palletKey)
			{
				setPallet(int(palletKey));
			}
			else
			{
				setPallet(_defPalletKey);
			}
			
			_areaCtl.setSelect(areaBtn.areaType);
		}
		
		private var a:ColorTransform = new ColorTransform();
		public function setColor(color:uint):void
		{
			var colorTran:ColorTransform = new ColorTransform();
			colorTran.color = color;
			//			a.color = color;
			if (_curArea == 1)
			{
				if (_areamc_1)
				{
					_areamc_1.transform.colorTransform = colorTran;
				}
			}
			else if (_curArea == 2)
			{
				if (_areamc_2)
				{
					_areamc_2.transform.colorTransform = colorTran;
				}
			}
			else if (_curArea == 3)
			{
				if (_areamc_3)
				{
					_areamc_3.transform.colorTransform = colorTran;
				}
			}
			else if (_curArea == 4)
			{
				if (_areamc_4)
				{
					_areamc_4.transform.colorTransform = colorTran;
				}
			}
			else if (_curArea == 5)
			{
				if (_areamc_5)
				{
					_areamc_5.transform.colorTransform = colorTran;
				}
			}
		}
		
		private var _map:Sprite;
		private var _areamc_1:MovieClip;
		private var _areamc_2:MovieClip;
		private var _areamc_3:MovieClip;
		private var _areamc_4:MovieClip;
		private var _areamc_5:MovieClip;
		
		private var _curPalletKey:int;
		private var _defPalletKey:int;
		private function initMap(idx:int):void
		{
			_bgCon.removeChildren();
			
			if (this.loaderInfo.applicationDomain.hasDefinition("Res_Map" + idx))
			{
				var cls:Class = getDefinitionByName("Res_Map" + idx) as Class;
				_map = new cls();
				_bgCon.addChild(_map);
				
				_areamc_1 = _map["areamc_1"];
				_areamc_2 = _map["areamc_2"];
				_areamc_3 = _map["areamc_3"];
				_areamc_4 = _map["areamc_4"];
				_areamc_5 = _map["areamc_5"];
				
			}
			
			_areaTitleTxt.text = Config.areaTitles[idx - 1];
			setAreas(Config.types[idx - 1]);
			
			_defPalletKey = idx;
			setPallet(idx);
			
			_curArea = 1;
		}
		
		private function onMoveScr(evt:Event):void
		{
			_hScrCon.x = -_hScr.scrollPosition;
			
			_vScrCon.y = -_vScr.scrollPosition;
		}
	}
}

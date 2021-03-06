package
{
	public class Config
	{
		public static var types:Vector.<Array>;
		
		public static var areaTitles:Vector.<String> = new Vector.<String>();
		
		setup();
		
		public static function setup():void
		{
			types = new Vector.<Array>();
			
			types.push(["厂区", "通道", "划线"]);
			types.push(["厂区", "划线"]);
			types.push(["车位", "通道", "划线","墙裙","墙面"]);
			types.push(["外围", "场区"]);
			types.push(["外围", "场区"]);
			types.push(["外围", "场区"]);
			types.push(["一区", "二区","三区"]);
			types.push(["图案"]);
			types.push(["一区", "二区"]);
			types.push(["图案"]);
			types.push(["一区","二区","三区"]);
			
			
			areaTitles.push("车间地坪区域");
			areaTitles.push("厂房地坪区域");
			areaTitles.push("停车场地坪区域");
			areaTitles.push("篮球场地坪区域");
			areaTitles.push("网球场地坪区域");
			areaTitles.push("羽毛球场地坪区域");
			areaTitles.push("透水压花地坪区域");
			areaTitles.push("艺术压膜地坪区域");
			areaTitles.push("PVC地坪区域");
			areaTitles.push("复古地坪花纹");
			areaTitles.push("环氧磨石区域");
		}
	}
}

local constantsData =
{
	ID = "DebugItem" ,
	Code = "DebugItem" ,
	Show = "调试物品" ,
	FileList =
	{
		[SIInit.StateCodeDefine.Data]           = { "1_data" } ,
		[SIInit.StateCodeDefine.DataFinalFixes] = { "3_data-final-fixes" } ,
		--[SIInit.StateCodeDefine.Control]        = { "4_control" }
	} ,
	Autoload =
	{
		Enable = true ,
		Categories =
		{
			Ammo =
			{
				DebugItem = { Code = "DebugItem" , Show = "调试物品弹药" }
			} ,
			Equipment =
			{
				DebugItem = { Code = "DebugItem" , Show = "调试物品模块" }
			} ,
			Fuel =
			{
				DebugItem = { Code = "DebugItem" , Show = "调试物品燃料" }
			} ,
			Module =
			{
				FishModule = { Code = "FishModule" , Show = "双鱼插件" }
			}
		}
	}
}

return constantsData
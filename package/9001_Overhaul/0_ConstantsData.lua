local constantsData =
{
	ID = "Overhaul" ,
	Name = "原版内容修改" ,
	FileList =
	{
		[SIInit.StateCodeDefine.DataFinalFixes] = { "3_data-final-fixes" } ,
		[SIInit.StateCodeDefine.Control]        = { "4_control"          }
	} ,
	Autoload =
	{
		Enable = true ,
		Settings =
		{
			ChangeFilterLine = { SICommon.SettingTypes.INT , SICommon.SettingAffectTypes.StartUp , 20 , 10 , 20 } ,
			ChangeInventoryLine = { SICommon.SettingTypes.INT , SICommon.SettingAffectTypes.StartUp , 15 , 10 , 20 } ,
			ChangeModuleLine = { SICommon.SettingTypes.INT , SICommon.SettingAffectTypes.StartUp , 15 , 10 , 20 }
		}
	}
}

return constantsData
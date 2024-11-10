local constantsData =
{
	ID = "AdvancedBarrel" ,
	Code = "AdvancedBarrel" ,
	Show = "高级流体罐装" ,
	FileList =
	{
		[SIInit.StateCodeDefine.Data]           = { "1_data" } ,
		[SIInit.StateCodeDefine.DataFinalFixes] = { "3_data-final-fixes" } ,
		[SIInit.StateCodeDefine.Control]        = { "4_control" }
	} ,
	Autoload =
	{
		Enable = true ,
		Settings = {} ,
		GroupsAppend =
		{
			Expand =
			{
				ConstantsDataCodeName = nil ,
				Subgroups =
				{
					MakeBarrel = "灌装"
				}
			}
		} ,
		Categories =
		{
			Recipe =
			{
				MakeBarrel = "灌装" ,
				DropBarrel = "倾倒"
			}
		}
	} ,
	BeforeLoad = function( constantsData )
		constantsData.Autoload.GroupsAppend.Expand.ConstantsDataCodeName = SIConstants_Core.CodeName
		if SIConfigs.SIAdvancedBarrel.IgnoreAutoBarrel ~= nil then constantsData.Autoload.Settings.IgnoreAutoBarrel = { Type = SICommon.SettingTypes.BOOL , Affect = SICommon.SettingAffectTypes.StartUp , Default = SIConfigs.SIAdvancedBarrel.IgnoreAutoBarrel } end
		if SIConfigs.SIAdvancedBarrel.BarrelSize       ~= nil then constantsData.Autoload.Settings.BarrelSize       = { Type = SICommon.SettingTypes.INT  , Affect = SICommon.SettingAffectTypes.StartUp , Default = SIConfigs.SIAdvancedBarrel.BarrelSize       , Min = SICommon.Numbers.CountMin     , Max = SICommon.Numbers.CountMax     } end
		if SIConfigs.SIAdvancedBarrel.BarrelStackSize  ~= nil then constantsData.Autoload.Settings.BarrelStackSize  = { Type = SICommon.SettingTypes.INT  , Affect = SICommon.SettingAffectTypes.StartUp , Default = SIConfigs.SIAdvancedBarrel.BarrelStackSize  , Min = SICommon.Numbers.StackSizeMin , Max = SICommon.Numbers.StackSizeMax } end
	end
}

return constantsData
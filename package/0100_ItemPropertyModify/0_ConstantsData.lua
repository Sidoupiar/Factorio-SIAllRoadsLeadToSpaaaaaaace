local constantsData =
{
	ID = "ItemPropertyModify" ,
	Code = "ItemPropertyModify" ,
	Show = "修改各种物品属性" ,
	FileList =
	{
		[SIInit.StateCodeDefine.DataFinalFixes] = { "3_data-final-fixes" }
	} ,
	Autoload =
	{
		Enable = true ,
		Settings = {}
	} ,
	BeforeLoad = function( constantsData )
		constantsData.Settings.RepairToolDurabilityMultiplier   = { SICommon.SettingTypes.DOUBLE , SICommon.SettingAffectTypes.StartUp , SIConfigs.SIItemPropertyModify.RepairToolDurabilityMultiplier   , SICommon.Numbers.MultiplierMin , SICommon.Numbers.MultiplierMax }
		constantsData.Settings.RepairToolSpeedMultiplier        = { SICommon.SettingTypes.DOUBLE , SICommon.SettingAffectTypes.StartUp , SIConfigs.SIItemPropertyModify.RepairToolSpeedMultiplier        , SICommon.Numbers.MultiplierMin , SICommon.Numbers.MultiplierMax }
		constantsData.Settings.ToolDurabilityMultiplier         = { SICommon.SettingTypes.DOUBLE , SICommon.SettingAffectTypes.StartUp , SIConfigs.SIItemPropertyModify.ToolDurabilityMultiplier         , SICommon.Numbers.MultiplierMin , SICommon.Numbers.MultiplierMax }
		constantsData.Settings.LabSpeedMultiplier               = { SICommon.SettingTypes.DOUBLE , SICommon.SettingAffectTypes.StartUp , SIConfigs.SIItemPropertyModify.LabSpeedMultiplier               , SICommon.Numbers.MultiplierMin , SICommon.Numbers.MultiplierMax }
		constantsData.Settings.MagazineAmmoSizeMultiplier       = { SICommon.SettingTypes.DOUBLE , SICommon.SettingAffectTypes.StartUp , SIConfigs.SIItemPropertyModify.MagazineAmmoSizeMultiplier       , SICommon.Numbers.MultiplierMin , SICommon.Numbers.MultiplierMax }
		constantsData.Settings.CircuitDistanceMultiplier        = { SICommon.SettingTypes.DOUBLE , SICommon.SettingAffectTypes.StartUp , SIConfigs.SIItemPropertyModify.CircuitDistanceMultiplier        , SICommon.Numbers.MultiplierMin , SICommon.Numbers.MultiplierMax }
		constantsData.Settings.UndergrundBeltDistanceMultiplier = { SICommon.SettingTypes.DOUBLE , SICommon.SettingAffectTypes.StartUp , SIConfigs.SIItemPropertyModify.UndergrundBeltDistanceMultiplier , SICommon.Numbers.MultiplierMin , SICommon.Numbers.MultiplierMax }
		constantsData.Settings.UndergrundPipeDistanceMultiplier = { SICommon.SettingTypes.DOUBLE , SICommon.SettingAffectTypes.StartUp , SIConfigs.SIItemPropertyModify.UndergrundPipeDistanceMultiplier , SICommon.Numbers.MultiplierMin , SICommon.Numbers.MultiplierMax }
	end
}

return constantsData
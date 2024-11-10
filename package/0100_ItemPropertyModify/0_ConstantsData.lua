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
		if SIConfigs.SIItemPropertyModify.RepairToolDurabilityMultiplier   ~= nil then constantsData.Autoload.Settings.RepairToolDurabilityMultiplier   = { Type = SICommon.SettingTypes.DOUBLE , Affect = SICommon.SettingAffectTypes.StartUp , Default = SIConfigs.SIItemPropertyModify.RepairToolDurabilityMultiplier   , Min = SICommon.Numbers.MultiplierMin , Max = SICommon.Numbers.MultiplierMax } end
		if SIConfigs.SIItemPropertyModify.RepairToolSpeedMultiplier        ~= nil then constantsData.Autoload.Settings.RepairToolSpeedMultiplier        = { Type = SICommon.SettingTypes.DOUBLE , Affect = SICommon.SettingAffectTypes.StartUp , Default = SIConfigs.SIItemPropertyModify.RepairToolSpeedMultiplier        , Min = SICommon.Numbers.MultiplierMin , Max = SICommon.Numbers.MultiplierMax } end
		if SIConfigs.SIItemPropertyModify.ToolDurabilityMultiplier         ~= nil then constantsData.Autoload.Settings.ToolDurabilityMultiplier         = { Type = SICommon.SettingTypes.DOUBLE , Affect = SICommon.SettingAffectTypes.StartUp , Default = SIConfigs.SIItemPropertyModify.ToolDurabilityMultiplier         , Min = SICommon.Numbers.MultiplierMin , Max = SICommon.Numbers.MultiplierMax } end
		if SIConfigs.SIItemPropertyModify.LabSpeedMultiplier               ~= nil then constantsData.Autoload.Settings.LabSpeedMultiplier               = { Type = SICommon.SettingTypes.DOUBLE , Affect = SICommon.SettingAffectTypes.StartUp , Default = SIConfigs.SIItemPropertyModify.LabSpeedMultiplier               , Min = SICommon.Numbers.MultiplierMin , Max = SICommon.Numbers.MultiplierMax } end
		if SIConfigs.SIItemPropertyModify.MagazineAmmoSizeMultiplier       ~= nil then constantsData.Autoload.Settings.MagazineAmmoSizeMultiplier       = { Type = SICommon.SettingTypes.DOUBLE , Affect = SICommon.SettingAffectTypes.StartUp , Default = SIConfigs.SIItemPropertyModify.MagazineAmmoSizeMultiplier       , Min = SICommon.Numbers.MultiplierMin , Max = SICommon.Numbers.MultiplierMax } end
		if SIConfigs.SIItemPropertyModify.CircuitDistanceMultiplier        ~= nil then constantsData.Autoload.Settings.CircuitDistanceMultiplier        = { Type = SICommon.SettingTypes.DOUBLE , Affect = SICommon.SettingAffectTypes.StartUp , Default = SIConfigs.SIItemPropertyModify.CircuitDistanceMultiplier        , Min = SICommon.Numbers.MultiplierMin , Max = SICommon.Numbers.MultiplierMax } end
		if SIConfigs.SIItemPropertyModify.UndergrundBeltDistanceMultiplier ~= nil then constantsData.Autoload.Settings.UndergrundBeltDistanceMultiplier = { Type = SICommon.SettingTypes.DOUBLE , Affect = SICommon.SettingAffectTypes.StartUp , Default = SIConfigs.SIItemPropertyModify.UndergrundBeltDistanceMultiplier , Min = SICommon.Numbers.MultiplierMin , Max = SICommon.Numbers.MultiplierMax } end
		if SIConfigs.SIItemPropertyModify.UndergrundPipeDistanceMultiplier ~= nil then constantsData.Autoload.Settings.UndergrundPipeDistanceMultiplier = { Type = SICommon.SettingTypes.DOUBLE , Affect = SICommon.SettingAffectTypes.StartUp , Default = SIConfigs.SIItemPropertyModify.UndergrundPipeDistanceMultiplier , Min = SICommon.Numbers.MultiplierMin , Max = SICommon.Numbers.MultiplierMax } end
	end
}

return constantsData
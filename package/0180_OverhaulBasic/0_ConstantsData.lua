local constantsData =
{
	ID = "OverhaulBasic" ,
	Code = "OverhaulBasic" ,
	Show = "全局基础修改" ,
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
		if SIConfigs.SIItemPropertyModify.TreeHealth             ~= nil then constantsData.Settings.TreeHealth             = { Type = SICommon.SettingTypes.BOOL , Affect = SICommon.SettingAffectTypes.StartUp , Default = SIConfigs.SIItemPropertyModify.TreeHealth             } end
		if SIConfigs.SIItemPropertyModify.TotalEvening           ~= nil then constantsData.Settings.TotalEvening           = { Type = SICommon.SettingTypes.BOOL , Affect = SICommon.SettingAffectTypes.StartUp , Default = SIConfigs.SIItemPropertyModify.TotalEvening           } end
		if SIConfigs.SIItemPropertyModify.EnemyCorpseDuration    ~= nil then constantsData.Settings.EnemyCorpseDuration    = { Type = SICommon.SettingTypes.INT  , Affect = SICommon.SettingAffectTypes.StartUp , Default = SIConfigs.SIItemPropertyModify.EnemyCorpseDuration    , Min = SICommon.Numbers.MultiplierMin , Max = SICommon.Numbers.MultiplierMax } end
		if SIConfigs.SIItemPropertyModify.ShowItemStackData      ~= nil then constantsData.Settings.ShowItemStackData      = { Type = SICommon.SettingTypes.BOOL , Affect = SICommon.SettingAffectTypes.StartUp , Default = SIConfigs.SIItemPropertyModify.ShowItemStackData      } end
		if SIConfigs.SIItemPropertyModify.ShowItemStackDataForce ~= nil then constantsData.Settings.ShowItemStackDataForce = { Type = SICommon.SettingTypes.BOOL , Affect = SICommon.SettingAffectTypes.StartUp , Default = SIConfigs.SIItemPropertyModify.ShowItemStackDataForce } end
	end
}

return constantsData
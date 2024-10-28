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
		constantsData.Settings.TreeHealth             = { SICommon.SettingTypes.BOOL , SICommon.SettingAffectTypes.StartUp , SIConfigs.SIItemPropertyModify.TreeHealth }
		constantsData.Settings.TotalEvening           = { SICommon.SettingTypes.BOOL , SICommon.SettingAffectTypes.StartUp , SIConfigs.SIItemPropertyModify.TotalEvening }
		constantsData.Settings.EnemyCorpseDuration    = { SICommon.SettingTypes.INT  , SICommon.SettingAffectTypes.StartUp , SIConfigs.SIItemPropertyModify.EnemyCorpseDuration , SICommon.Numbers.MultiplierMin , SICommon.Numbers.MultiplierMax }
		constantsData.Settings.ShowItemStackData      = { SICommon.SettingTypes.BOOL , SICommon.SettingAffectTypes.StartUp , SIConfigs.SIItemPropertyModify.ShowItemStackData }
		constantsData.Settings.ShowItemStackDataForce = { SICommon.SettingTypes.BOOL , SICommon.SettingAffectTypes.StartUp , SIConfigs.SIItemPropertyModify.ShowItemStackDataForce }
	end
}

return constantsData
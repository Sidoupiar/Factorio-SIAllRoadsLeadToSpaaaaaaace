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
		if SIConfigs.SIOverhaulBasic.TreeHealth             ~= nil then constantsData.Settings.TreeHealth             = { Type = SICommon.SettingTypes.BOOL , Affect = SICommon.SettingAffectTypes.StartUp , Default = SIConfigs.SIOverhaulBasic.TreeHealth             } end
		if SIConfigs.SIOverhaulBasic.TotalEvening           ~= nil then constantsData.Settings.TotalEvening           = { Type = SICommon.SettingTypes.BOOL , Affect = SICommon.SettingAffectTypes.StartUp , Default = SIConfigs.SIOverhaulBasic.TotalEvening           } end
		if SIConfigs.SIOverhaulBasic.EnemyCorpseDuration    ~= nil then constantsData.Settings.EnemyCorpseDuration    = { Type = SICommon.SettingTypes.INT  , Affect = SICommon.SettingAffectTypes.StartUp , Default = SIConfigs.SIOverhaulBasic.EnemyCorpseDuration    , Min = SICommon.Numbers.DurationMin , Max = SICommon.Numbers.DurationMax , Unit = SICommon.SettingUnitTypes.Tick } end
		if SIConfigs.SIOverhaulBasic.ShowItemStackData      ~= nil then constantsData.Settings.ShowItemStackData      = { Type = SICommon.SettingTypes.BOOL , Affect = SICommon.SettingAffectTypes.StartUp , Default = SIConfigs.SIOverhaulBasic.ShowItemStackData      } end
		if SIConfigs.SIOverhaulBasic.ShowItemStackDataForce ~= nil then constantsData.Settings.ShowItemStackDataForce = { Type = SICommon.SettingTypes.BOOL , Affect = SICommon.SettingAffectTypes.StartUp , Default = SIConfigs.SIOverhaulBasic.ShowItemStackDataForce } end
	end
}

return constantsData
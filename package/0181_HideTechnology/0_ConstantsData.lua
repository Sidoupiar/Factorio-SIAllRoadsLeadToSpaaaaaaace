local constantsData =
{
	ID = "HideTechnology" ,
	Code = "HideTechnology" ,
	Show = "隐藏科技" ,
	FileList =
	{
		[SIInit.StateCodeDefine.DataFinalFixes] = { "3_data-final-fixes" } ,
		[SIInit.StateCodeDefine.Control]        = { "4_control" }
	} ,
	Autoload =
	{
		Enable = true ,
		Settings = {}
	} ,
	BeforeLoad = function( constantsData )
		if SIConfigs.SIHideTechnology.HideTechnology     ~= nil then constantsData.Settings.HideTechnology     = { Type = SICommon.SettingTypes.BOOL , Affect = SICommon.SettingAffectTypes.StartUp , Default = SIConfigs.SIHideTechnology.HideTechnology     } end
		if SIConfigs.SIHideTechnology.HideTechnologySelf ~= nil then constantsData.Settings.HideTechnologySelf = { Type = SICommon.SettingTypes.BOOL , Affect = SICommon.SettingAffectTypes.StartUp , Default = SIConfigs.SIHideTechnology.HideTechnologySelf } end
	end
}

return constantsData
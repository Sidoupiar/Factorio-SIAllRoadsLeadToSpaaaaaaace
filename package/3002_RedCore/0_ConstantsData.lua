local constantsData =
{
	ID = "RedCore" ,
	Code = "RedCore" ,
	Show = "红核" ,
	FileList =
	{
		[SIInit.StateCodeDefine.Data]    = { "1_data_1_base" } ,
		[SIInit.StateCodeDefine.Control] = { "4_control" }
	} ,
	Autoload =
	{
		Enable = true ,
		Settings = {}
	} ,
	BeforeLoad = function( constantsData )
		if SIConfigs.SIRedCore.DifficultyLevel ~= nil then
			local default = SITools.Round( math.floor( SIConfigs.SIRedCore.DifficultyLevel ) , 1 , 5 )
			constantsData.Autoload.Settings.DifficultyLevel = { Type = SICommon.SettingTypes.INT , Affect = SICommon.SettingAffectTypes.StartUp , Default = default , AllowIn = { 1 , 2 , 3 , 4 , 5 } }
		end
	end
}

return constantsData
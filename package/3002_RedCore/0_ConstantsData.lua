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
			local default = SITools.Range( math.floor( SIConfigs.SIRedCore.DifficultyLevel ) , constantsData.MinLevel , constantsData.MaxLevel )
			local allowInList = {}
			for level = constantsData.MinLevel , 1 , constantsData.MaxLevel do
				table.insert( allowInList , level )
			end
			constantsData.Autoload.Settings.DifficultyLevel = { Type = SICommon.SettingTypes.INT , Affect = SICommon.SettingAffectTypes.StartUp , Default = default , Min = constantsData.MinLevel , Max = constantsData.MaxLevel , AllowIn = allowInList }
		end
	end ,
	MinLevel = 1 ,
	MaxLevel = 7
}

return constantsData
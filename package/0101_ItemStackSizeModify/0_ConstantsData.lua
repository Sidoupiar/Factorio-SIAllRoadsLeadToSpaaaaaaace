local constantsData =
{
	ID = "ItemStackSizeModify" ,
	Code = "ItemStackSizeModify" ,
	Show = "修改物品堆叠" ,
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
		if SIConfigs.SIItemStackSizeModify.IgnoreCannotStack ~= nil then constantsData.Settings.IgnoreCannotStack = { Type = SICommon.SettingTypes.BOOL , Affect = SICommon.SettingAffectTypes.StartUp , Default = SIConfigs.SIItemStackSizeModify.IgnoreCannotStack } end
		if SIConfigs.SIItemStackSizeModify.ItemStackSizeMultiplier and SIConfigs.SIItemStackSizeModify.ItemStackSizeMultiplier.TypeList then
			local baseMultiplier = SIConfigs.SIItemStackSizeModify.ItemStackSizeMultiplier.Multiplier or 1.0
			for itemType , defaultMultiplier in pairs( SIConfigs.SIItemStackSizeModify.ItemStackSizeMultiplier.TypeList ) do
				if defaultMultiplier ~= nil then
					if defaultMultiplier == 0.0 then
						defaultMultiplier = baseMultiplier
					end
					constantsData.Settings["ItemStackSizeMultiplier-" .. SICommon.Types.StackableItems_Reverse[itemType]] = { Type = SICommon.SettingTypes.DOUBLE , Affect = SICommon.SettingAffectTypes.StartUp , Default = defaultMultiplier , Min = SICommon.Numbers.MultiplierMin , Max = SICommon.Numbers.MultiplierMax }
				end
			end
		end
	end
}

return constantsData
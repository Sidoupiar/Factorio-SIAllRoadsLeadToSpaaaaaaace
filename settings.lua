if not SIInstrumentMode then
	require( "utils" )
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础设置 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local Settings =
{
	{
		type = "bool-setting" ,
		setting_type = "startup" ,
		name = "SIUtils-ShowPatreon" ,
		default_value = true ,
	} ,
	{
		type = "bool-setting" ,
		setting_type = "startup" ,
		name = "SIUtils-Debug" ,
		default_value = false ,
	} ,
	{
		type = "bool-setting" ,
		setting_type = "startup" ,
		name = "SIUtils-ShowError" ,
		default_value = false ,
	}
}
local function LoadSettings( list )
	for index , setting in pairs( list ) do
		setting.localised_name = { "SISettingName." .. setting.name }
		setting.localised_description = { "SICommon.SettingsDescription" , { "SIUtils.SIUtils-MainSettings" } , { "SISettingDescription." .. setting.name } , SIPrint.ToShow( setting.default_value ) }
		setting.order = index
	end
	data:extend( list )
end
LoadSettings( Settings )

-- ------------------------------------------------------------------------------------------------
-- ----------- 初始化 -----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIInit
.AutoLoadState( SIInit.StateCodeDefine.Settings )
.AutoLoad()
-- 如果你想在附属 MOD 中使用这个框架 , 则仅需在 settings.lua , data.lua , control.lua 中使用 SIInit.AutoLoad 函数即可 ( 不要在其他文件中使用 )
-- 具体请见 data.lua 中的注释
SIInstrumentMode = true

require( "__SIAllRoadsLeadToSpaaaaaaace__/utils" )

-- ------------------------------------------------------------------------------------------------
-- ----------- 初始化 -----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIInit
.AutoLoadState( SIInit.StateCodeDefine.SettingsInstrument )
.AutoLoad()
-- 如果你想在附属 MOD 中使用这个框架 , 则仅需在 settings.lua , data.lua , control.lua 中使用 SIInit.AutoLoad 函数即可 ( 不要在其他文件中使用 )
-- 使用方法可以参考我做的其他附属 MOD
-- 具体请见 data.lua 中的注释
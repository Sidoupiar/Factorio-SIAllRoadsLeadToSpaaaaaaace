-- ------------------------------------------------------------------------------------------------
-- ------- 调整持久化数据 -------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local buildLimitGlobalSettings = SIGlobal.GetGlobalSettings( SIBuildLimit.Settings.Name )
local oldLimitDataList = buildLimitGlobalSettings.LimitData
buildLimitGlobalSettings.LimitData = {}
buildLimitGlobalSettings.Modules = {}
buildLimitGlobalSettings.Beacons = {}
buildLimitGlobalSettings.Modules = {}
SIBuildLimit.AddLimitDataList( oldLimitDataList )
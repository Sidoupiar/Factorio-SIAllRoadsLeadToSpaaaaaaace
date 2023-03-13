-- ------------------------------------------------------------------------------------------------
-- --- 重新初始化 global 数据 ---------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- 更新持久化数据
SIGlobal.CreateOnMigration()

-- ------------------------------------------------------------------------------------------------
-- --- 对 global 数据进行迁移 ---------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

if SIGlobal.Get( "Mainbar" ) then
	SINeed( GetCorePath() .. "/migrationScript/OldVersion" )
end

local mainData = SIGlobal.GetGlobalSettings( SIMainData.Settings.Name )
while mainData.InnerVersion < SIMainData.InnerVersion do
	local scriptName = SIMainData.MigrationScriptList[mainData.InnerVersion]
	if scriptName then
		SINeed( GetCorePath() .. "/migrationScript/Script_" .. scriptName )
	end
	mainData.InnerVersion = mainData.InnerVersion + 1
end
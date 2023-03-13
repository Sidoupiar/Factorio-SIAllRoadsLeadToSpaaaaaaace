-- ------------------------------------------------------------------------------------------------
-- ------- 调整持久化数据 -------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- 维护 RPG 系统数据
for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIRPGSystem.Settings.Name ) ) do
	settings.PlayerSetting.Base.skillColumnCount = SIRPGSystem.Settings.DefaultPlayer.PlayerSetting.Base.skillColumnCount
	settings.PlayerSetting.Base.showPlayerSkillMini = SIRPGSystem.Settings.DefaultPlayer.PlayerSetting.Base.showPlayerSkillMini
	settings.PlayerSkillMini = SIUtils.table.deepcopy( SIRPGSystem.Settings.DefaultPlayer.PlayerSkillMini )
end
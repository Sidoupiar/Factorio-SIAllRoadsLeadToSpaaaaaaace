-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 调整持久化数据 ==================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- 维护主面板数据
for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIMainData.Settings.Name ) ) do
	if settings.Setting.frame and settings.Setting.frame.valid then
		settings.Setting.Saveing = false
		settings.Setting.Elements.itemLoadFromUser = nil
		SIMainbarSetting.CloseFrame( playerIndex )
		SIMainbarSetting.OpenFrame( playerIndex )
	end
end
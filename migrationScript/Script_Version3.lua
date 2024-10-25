-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 调整持久化数据 ==================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- 维护 RPG 系统数据
for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIRPGSystem.Settings.Name ) ) do
	settings.PlayerStatus.PropertyButton = {}
	settings.PlayerStatus.AdditionButton = {}
	settings.PlayerStatus.AdditionButtons = nil
	local player = game.get_player( settings.playerIndex )
	if player.connected then
		settings.character = player.character
	end
	if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
		SIRPGPlayerStatus.CloseFrame( playerIndex )
		SIRPGPlayerStatus.OpenFrame( playerIndex )
	end
end
-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 外部接口 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIInterface

-- ======================================================================
-- 自动填充功能相关接口
-- ======================================================================
.Add( SIAutoInsert.InterfaceID ,
{
	-- 窗口
	OpenFrameByPlayerIndex = SIAutoInsert.OpenFrameByPlayerIndex ,
	CloseFrameByPlayerIndex = SIAutoInsert.CloseFrameByPlayerIndex ,
	OpenFrames = SIAutoInsert.OpenFrames ,
	CloseFrames = SIAutoInsert.CloseFrames ,
	-- 导入导出
	ImpoerSettingsData = SIAutoInsert.ImpoerSettingsData ,
	ExportSettingsData = SIAutoInsert.ExportSettingsData ,
	-- 事件<br>
	GetModuleEventID = SIAutoInsert.GetModuleEventID
} )
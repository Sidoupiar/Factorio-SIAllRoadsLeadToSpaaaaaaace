-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 外部接口 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIInterface

-- ======================================================================<br>
-- 黄图功能相关接口<br>
-- ======================================================================<br>
.Add( SIOreMap.InterfaceID ,
{
	-- 窗口
	OpenFrameByPlayerIndex = SIOreMap.OpenFrameByPlayerIndex ,
	CloseFrameByPlayerIndex = SIOreMap.CloseFrameByPlayerIndex ,
	OpenFrames = SIOreMap.OpenFrames ,
	CloseFrames = SIOreMap.CloseFrames ,
	-- 导入导出
	ImpoerSettingsData = SIOreMap.ImpoerSettingsData ,
	ExportSettingsData = SIOreMap.ExportSettingsData ,
	-- 数据操作
	AddOre = SIOreMap.AddOre ,
	RemoveOre = SIOreMap.RemoveOre
} )

-- ======================================================================<br>
-- 紫图功能相关接口<br>
-- ======================================================================<br>
.Add( SIRequestMap.InterfaceID ,
{
	-- 窗口
	OpenFrameByPlayerIndex = SIRequestMap.OpenFrameByPlayerIndex ,
	CloseFrameByPlayerIndex = SIRequestMap.CloseFrameByPlayerIndex ,
	OpenFrames = SIRequestMap.OpenFrames ,
	CloseFrames = SIRequestMap.CloseFrames ,
	-- 导入导出
	ImpoerSettingsData = SIRequestMap.ImpoerSettingsData ,
	ExportSettingsData = SIRequestMap.ExportSettingsData ,
	-- 事件<br>
	GetModuleEventID = SIRequestMap.GetModuleEventID
} )
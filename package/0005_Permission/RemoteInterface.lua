-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 外部接口 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIInterface

-- ======================================================================<br>
-- 权限管理接口<br>
-- ======================================================================<br>
.Add( SIPermission.InterfaceID ,
{
	-- 窗口
	OpenFrameByPlayerIndex = SIPermission.OpenFrameByPlayerIndex ,
	CloseFrameByPlayerIndex = SIPermission.CloseFrameByPlayerIndex ,
	OpenFrames = SIPermission.OpenFrames ,
	CloseFrames = SIPermission.CloseFrames ,
	-- 权限管理
	RegisterPermission = SIPermission.RegisterPermission ,
	UnregisterPermission = SIPermission.UnregisterPermission ,
	SetDefaultPermission = SIPermission.SetDefaultPermission ,
	SetPermission = SIPermission.SetPermission ,
	HasPermission = SIPermission.HasPermission ,
	GetPermissionMessage = SIPermission.GetPermissionMessage ,
	IsAdmin = SIPermission.IsAdmin ,
	-- 事件<br>
	GetEventID = SIPermission.GetEventID
} )
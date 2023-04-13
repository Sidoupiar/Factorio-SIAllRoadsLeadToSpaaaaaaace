-- ------------------------------------------------------------------------------------------------
-- ---------- 外部接口 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIInterface

-- ----------------------------------------
-- 核心信息数据<br>
-- ----------------------------------------
.Add( SIMainData.InterfaceID ,
{
	-- 信息
	GetInnerVersion = SIMainData.GetInnerVersion
} )

-- ----------------------------------------
-- 主面板相关功能接口<br>
-- 包括设置 , 工具栏等一系列集成在主面板上的功能<br>
-- ----------------------------------------
.Add( SIMainbar.InterfaceID ,
{
	-- 主面板
	Fresh = SIMainbar.Fresh ,
	-- 工具栏
	OpenToolbarByPlayerIndex = SIMainbar.OpenToolbarByPlayerIndex ,
	CloseToolbarByPlayerIndex = SIMainbar.CloseToolbarByPlayerIndex ,
	OpenToolbars = SIMainbar.OpenToolbars ,
	CloseToolbars = SIMainbar.CloseToolbars ,
	-- 工具栏按钮
	RegisterToolbarButton = SIMainbar.RegisterToolbarButton ,
	UnregisterToolbarButton = SIMainbar.UnregisterToolbarButton
} )

-- ----------------------------------------
-- 主面板设置管理接口<br>
-- ----------------------------------------
.Add( SIMainbarSetting.InterfaceID ,
{
	-- 设置数据
	RegisterSettingsData = SIMainbarSetting.RegisterSettingsData
} )

-- ----------------------------------------
-- 主面板便签管理接口<br>
-- ----------------------------------------
.Add( SIMainbarNote.InterfaceID ,
{
	-- 窗口
	OpenFrameByPlayerIndex = SIMainbarNote.OpenFrameByPlayerIndex ,
	CloseFrameByPlayerIndex = SIMainbarNote.CloseFrameByPlayerIndex ,
	OpenFrames = SIMainbarNote.OpenFrames ,
	CloseFrames = SIMainbarNote.CloseFrames
	-- 便签列表
	-- 暂无接口
} )

-- ----------------------------------------
-- 主面板消息管理接口<br>
-- ----------------------------------------
.Add( SIMainbarMessage.InterfaceID ,
{
	-- 窗口
	OpenFrameByPlayerIndex = SIMainbarMessage.OpenFrameByPlayerIndex ,
	CloseFrameByPlayerIndex = SIMainbarMessage.CloseFrameByPlayerIndex ,
	OpenFrames = SIMainbarMessage.OpenFrames ,
	CloseFrames = SIMainbarMessage.CloseFrames ,
	-- 消息列表
	AddMessage = SIMainbarMessage.AddMessage ,
	RemoveMessage = SIMainbarMessage.RemoveMessage
} )

-- ----------------------------------------
-- 权限管理接口<br>
-- ----------------------------------------
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
	-- 事件
	GetEventID = SIPermission.GetEventID
} )

-- ----------------------------------------
-- 信息查询接口<br>
-- ----------------------------------------
.Add( SIFinder.InterfaceID ,
{
	-- 窗口
	OpenFrameByPlayerIndex = SIFinder.OpenFrameByPlayerIndex ,
	CloseFrameByPlayerIndex = SIFinder.CloseFrameByPlayerIndex ,
	OpenFrames = SIFinder.OpenFrames ,
	CloseFrames = SIFinder.CloseFrames ,
	-- 信息查询
	Find = SIFinder.Find
} )

-- ----------------------------------------
-- 黄图功能相关接口<br>
-- ----------------------------------------
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

-- ----------------------------------------
-- 紫图功能相关接口<br>
-- ----------------------------------------
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
	-- 事件
	GetModuleEventID = SIRequestMap.GetModuleEventID
} )

-- ----------------------------------------
-- 自动填充功能相关接口<br>
-- ----------------------------------------
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
	-- 事件
	GetModuleEventID = SIAutoInsert.GetModuleEventID
} )
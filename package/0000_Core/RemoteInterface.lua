-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 外部接口 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIInterface

-- ======================================================================
-- 核心信息数据
-- ======================================================================
.Add( SIMainData.InterfaceID ,
{
	-- 信息
	GetInnerVersion = SIMainData.GetInnerVersion
} )

-- ======================================================================
-- 主面板相关功能接口
-- 包括设置 , 工具栏等一系列集成在主面板上的功能
-- ======================================================================
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

-- ======================================================================
-- 主面板设置管理接口
-- ======================================================================
.Add( SIMainbarSetting.InterfaceID ,
{
	-- 设置数据
	RegisterSettingsData = SIMainbarSetting.RegisterSettingsData
} )

-- ======================================================================
-- 主面板便签管理接口
-- ======================================================================
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

-- ======================================================================
-- 主面板消息管理接口
-- ======================================================================
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

-- ======================================================================
-- 信息查询接口
-- ======================================================================
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
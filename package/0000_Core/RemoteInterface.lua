-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 外部接口 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIInterface

-- ======================================================================<br>
-- 核心信息数据<br>
-- ======================================================================<br>
.Add( SIMainData.InterfaceID ,
{
	-- 信息
	GetInnerVersion = SIMainData.GetInnerVersion
} )

-- ======================================================================<br>
-- 主面板相关功能接口<br>
-- 包括设置 , 工具栏等一系列集成在主面板上的功能<br>
-- ======================================================================<br>
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

-- ======================================================================<br>
-- 主面板设置管理接口<br>
-- ======================================================================<br>
.Add( SIMainbarSetting.InterfaceID ,
{
	-- 设置数据
	RegisterSettingsData = SIMainbarSetting.RegisterSettingsData
} )

-- ======================================================================<br>
-- 主面板便签管理接口<br>
-- ======================================================================<br>
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

-- ======================================================================<br>
-- 主面板消息管理接口<br>
-- ======================================================================<br>
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

-- ======================================================================<br>
-- 信息查询接口<br>
-- ======================================================================<br>
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
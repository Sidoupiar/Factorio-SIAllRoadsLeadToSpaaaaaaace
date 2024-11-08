-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 定义信息 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIControl.Init
{
	[SICommon.Types.Items.SelectionTool] =
	{
		ColorPanel = "多彩调色盘"
	} ,
	[SICommon.Types.Recipe] =
	{
		ColorPanel = "多彩调色盘"
	} ,
	[SICommon.Types.Entities.SimpleOwner] =
	{
		PixelPrefix = "像素块-" ,
		Pixel_256_256_256 = "像素块-256-256-256"
	} ,
	Styles =
	{
		-- 多彩调色盘拾色器控件样式
		ColorPanel_Frame = "多彩调色盘拾色器-窗口" ,
		ColorPanel_LabelTop = "多彩调色盘拾色器-标签顶部" ,
		ColorPanel_List = "多彩调色盘拾色器-列表" ,
		ColorPanel_Pixel = "多彩调色盘拾色器-色块"
	}
}

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 基础数据 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================<br>
-- 初始化<br>
-- ======================================================================<br>
SINeed( "GUI/SIColorPanel" )
SINeed( "Data/ColorfulRecipe" )
SIGlobal.CreateSettings( SIColorPanel.Settings )

-- ======================================================================<br>
-- 事件<br>
-- ======================================================================<br>
SIEventBus
.Init( function( functionID )
	SIUnlocker.AddUnlockDataList( SIColorfulRecipe )
end )
.ConfigurationChange( function( functionID )
	SIUnlocker.AddUnlockDataList( SIColorfulRecipe )
	SIUnlocker.FreshUnlockDataList( SIColorfulRecipe )
end )

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 图形界面 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================<br>
-- 事件<br>
-- ======================================================================<br>
SIEventBus
.Add( SIEvents.on_player_left_game , function( event , functionID )
	local playerIndex = event.player_index
	-- 多彩调色盘拾色器窗口事件
	SIColorPanel.CloseFrame( playerIndex )
end )
.Add( SIEvents.on_gui_click , function( event , functionID )
	local element = event.element
	if not element.valid then
		return
	end
	local name = element.name
	local playerIndex = event.player_index
	-- 多彩调色盘拾色器窗口事件
	if name:StartsWith( SIColorPanel.Names.Prefix ) then
		if name == SIColorPanel.Names.Close then
			SIColorPanel.CloseFrame( playerIndex )
			return
		end
		if name:StartsWith( SIColorPanel.Names.PixelPrefix ) then
			SIColorPanel.ChangePixel( playerIndex , name )
			return
		end
		return
	end
end )
.Add( SIEvents.on_gui_location_changed , function( event , functionID )
	local element = event.element
	if not element.valid then
		return
	end
	local name = element.name
	local playerIndex = event.player_index
	-- 多彩调色盘拾色器窗口事件
	if name == SIColorPanel.Names.Frame then
		SIColorPanel.MoveFrame( playerIndex )
		return
	end
end )

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 特殊工具触发 ====================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================<br>
-- 事件<br>
-- ======================================================================<br>
SIEventBus
.Add( SIEvents.on_player_selected_area , function( event , functionID )
	local itemName = event.item
	local playerIndex = event.player_index
	-- 多彩调色盘
	if itemName == SIConstants_Colorful.raw.Items.ColorPanel then
		local pixelPrefix = SIConstants_Colorful.raw.Entities.PixelPrefix
		local pixels = {}
		for index , entity in pairs( event.entities ) do
			if entity.name:StartsWith( pixelPrefix ) then
				table.insert( pixels , entity )
			end
		end
		if #pixels > 0 then
			SIColorPanel.SetPixels( playerIndex , pixels )
		end
	end
end )
.Add( SIEvents.on_player_alt_selected_area , function( event , functionID )
	local itemName = event.item
	local playerIndex = event.player_index
	-- 多彩调色盘
	if itemName == SIConstants_Colorful.raw.Items.ColorPanel then
		local pixelPrefix = SIConstants_Colorful.raw.Entities.PixelPrefix
		local pixels = {}
		for index , entity in pairs( event.entities ) do
			if entity.name:StartsWith( pixelPrefix ) then
				table.insert( pixels , entity )
			end
		end
		if #pixels > 0 then
			SIColorPanel.AddPixels( playerIndex , pixels )
		end
	end
end )
.Add( SIEvents.on_player_reverse_selected_area , function( event , functionID )
	local itemName = event.item
	local playerIndex = event.player_index
	-- 多彩调色盘
	if itemName == SIConstants_Colorful.raw.Items.ColorPanel then
		local pixelPrefix = SIConstants_Colorful.raw.Entities.PixelPrefix
		local pixels = {}
		for index , entity in pairs( event.entities ) do
			if entity.name:StartsWith( pixelPrefix ) then
				table.insert( pixels , entity )
			end
		end
		if #pixels > 0 then
			SIColorPanel.RemovePixels( playerIndex , pixels )
		end
	end
end )
.Add( SIEvents.on_player_alt_reverse_selected_area , function( event , functionID )
	local itemName = event.item
	local playerIndex = event.player_index
	-- 多彩调色盘
	if itemName == SIConstants_Colorful.raw.Items.ColorPanel then
		local pixelPrefix = SIConstants_Colorful.raw.Entities.PixelPrefix
		local pixels = {}
		for index , entity in pairs( event.entities ) do
			if entity.name:StartsWith( pixelPrefix ) then
				table.insert( pixels , entity )
			end
		end
		if #pixels > 0 then
			SIColorPanel.RemovePixels( playerIndex , pixels )
		end
	end
end )

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 外部接口 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================<br>
-- 接口注册<br>
-- ======================================================================<br>
SINeed( "RemoteInterface" )
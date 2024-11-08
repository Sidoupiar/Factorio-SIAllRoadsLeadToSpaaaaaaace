-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 定义信息 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIControl.Init
{
	Styles =
	{
		-- 自动填充控件样式
		AutoInsert_Frame = "自动填充-窗口" ,
		AutoInsert_TabPane = "自动填充-分页面板" ,
		AutoInsert_Label = "自动填充-标签" ,
		AutoInsert_Text = "自动填充-文本条" ,
		AutoInsert_EmptyFlow = "自动填充-空布局" ,
		AutoInsert_DropDown = "自动填充-下拉列表" ,
		AutoInsert_ListButtonFlow = "自动填充-列表定位按钮布局" ,
		AutoInsert_ListButton = "自动填充-列表定位按钮" ,
		AutoInsert_BlankFlow = "自动填充-空白区" ,
		AutoInsert_ListCheck = "自动填充-列表复选" ,
		AutoInsert_ListPanelFlow = "自动填充-列表面板布局" ,
		AutoInsert_SubList = "自动填充-子列表" ,
		AutoInsert_SelectList = "自动填充-选择列表" ,
		AutoInsert_ListChooser = "自动填充-列表选择" ,
		AutoInsert_ListFlow = "自动填充-列表布局" ,
		AutoInsert_ListLabel = "自动填充-列表标签" ,
		AutoInsert_ListText = "自动填充-列表文本条" ,
		AutoInsert_ListDropDown = "自动填充-列表下拉列表" ,
		AutoInsert_ListEmptyFlow = "自动填充-列表占位布局"
	}
}

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 基础数据 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================
-- 初始化
-- ======================================================================
SINeed( "GUI/AutoInsert" )
SIGlobal.CreateSettings( SIAutoInsert.Settings )

-- ======================================================================
-- 事件
-- ======================================================================

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 图形界面 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================
-- 事件
-- ======================================================================
SIEventBus
.Init( function( functionID )
	-- 自动填充的管理窗口事件
	SIMainbar.RegisterToolbarButton( SIAutoInsert.Toolbar )
	SIMainbarSetting.RegisterSettingsData( SIAutoInsert.SettingsData )
end )
.Load( function( functionID )
	-- 自动填充的管理窗口事件
	SIMainbar.RegisterToolbarButton( SIAutoInsert.Toolbar )
	SIMainbarSetting.RegisterSettingsData( SIAutoInsert.SettingsData )
end )
.Add( SIEvents.on_player_left_game , function( event , functionID )
	local playerIndex = event.player_index
	-- 自动填充的管理窗口事件
	SIAutoInsert.CloseFrame( playerIndex )
end )
.Add( SIEvents.on_gui_click , function( event , functionID )
	local element = event.element
	if not element.valid then
		return
	end
	local name = element.name
	local playerIndex = event.player_index
	-- 自动填充的管理窗口事件
	if name:StartsWith( SIAutoInsert.Names.Prefix ) then
		if name == SIAutoInsert.Names.Close then
			SIAutoInsert.CloseFrame( playerIndex )
			return
		end
		if name == SIAutoInsert.Names.Add then
			SIAutoInsert.Out_AddTabSettings( playerIndex )
			return
		end
		if name == SIAutoInsert.Names.Delete then
			SIAutoInsert.Out_DeleteTabSettings( playerIndex )
			return
		end
		if name:StartsWith( SIAutoInsert.Names.ListButtonPrefix ) then
			SIAutoInsert.ListScroll( playerIndex , name )
			return
		end
		return
	end
end )
.Add( SIEvents.on_gui_text_changed , function( event , functionID )
	local element = event.element
	if not element.valid then
		return
	end
	local name = element.name
	local playerIndex = event.player_index
	-- 自动填充的管理窗口事件
	if name:StartsWith( SIAutoInsert.Names.Prefix ) then
		if name:StartsWith( SIAutoInsert.Names.MaxSlot_Count_Prefix ) then
			SIAutoInsert.Set_MaxSlot_Count( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIAutoInsert.Names.InsertFuel_Count_Prefix ) then
			SIAutoInsert.Set_InsertFuel_Count( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIAutoInsert.Names.InsertAmmo_Count_Prefix ) then
			SIAutoInsert.Set_InsertAmmo_Count( playerIndex , name , element )
			return
		end
		return
	end
end )
.Add( SIEvents.on_gui_confirmed , function( event , functionID )
	local element = event.element
	if not element.valid then
		return
	end
	local name = element.name
	local playerIndex = event.player_index
	-- 自动填充的管理窗口事件
	if name == SIAutoInsert.Names.TabSettingsName then
		SIAutoInsert.Set_TabSettingsName( playerIndex , element )
		return
	end
end )
.Add( SIEvents.on_gui_checked_state_changed , function( event , functionID )
	local element = event.element
	if not element.valid then
		return
	end
	local name = element.name
	local playerIndex = event.player_index
	-- 自动填充的管理窗口事件
	if name:StartsWith( SIAutoInsert.Names.Prefix ) then
		if name == SIAutoInsert.Names.GreenToBlue_Check then
			SIAutoInsert.Set_GreenToBlue_Check( playerIndex , element )
			return
		end
		if name:StartsWith( SIAutoInsert.Names.EnablePrefix ) then
			SIAutoInsert.EnableFunction( playerIndex , name , element )
			return
		end
		return
	end
end )
.Add( SIEvents.on_gui_selection_state_changed , function( event , functionID )
	local element = event.element
	if not element.valid then
		return
	end
	local name = element.name
	local playerIndex = event.player_index
	-- 自动填充的管理窗口事件
	if name == SIAutoInsert.Names.DefaultIndex then
		SIAutoInsert.Set_DefaultIndex( playerIndex , element )
		return
	end
end )
.Add( SIEvents.on_gui_elem_changed , function( event , functionID )
	local element = event.element
	if not element.valid then
		return
	end
	local name = element.name
	local playerIndex = event.player_index
	-- 自动填充的管理窗口事件
	if name:StartsWith( SIAutoInsert.Names.Prefix ) then
		if name:StartsWith( SIAutoInsert.Names.MaxSlot_Entity_Prefix ) then
			SIAutoInsert.Set_MaxSlot_Entity( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIAutoInsert.Names.SetModule_Entity_Prefix ) then
			SIAutoInsert.Set_SetModule_Entity( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIAutoInsert.Names.SetModule_Item_Prefix ) then
			SIAutoInsert.Set_SetModule_Item( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIAutoInsert.Names.InsertFuel_Entity_Prefix ) then
			SIAutoInsert.Set_InsertFuel_Entity( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIAutoInsert.Names.InsertFuel_Item_Prefix ) then
			SIAutoInsert.Set_InsertFuel_Item( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIAutoInsert.Names.InsertAmmo_Entity_Prefix ) then
			SIAutoInsert.Set_InsertAmmo_Entity( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIAutoInsert.Names.InsertAmmo_Item_Prefix ) then
			SIAutoInsert.Set_InsertAmmo_Item( playerIndex , name , element )
			return
		end
		return
	end
end )
.Add( SIEvents.on_gui_selected_tab_changed , function( event , functionID )
	local element = event.element
	if not element.valid then
		return
	end
	local name = element.name
	local playerIndex = event.player_index
	-- 自动填充的管理窗口事件
	if name == SIAutoInsert.Names.TabPane then
		SIAutoInsert.SwitchTab( playerIndex )
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
	-- 自动填充的管理窗口事件
	if name == SIAutoInsert.Names.Frame then
		SIAutoInsert.MoveFrame( playerIndex )
		return
	end
end )

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 操作事件 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================
-- 事件
-- ======================================================================
SIEventBus
.Add( SIEvents.on_built_entity , function( event , functionID )
	local entity = event.entity
	if not entity.valid then
		return
	end
	local playerIndex = event.player_index
	-- 自动填充的管理窗口事件
	if SIPermission.HasPermission( SIPermission.PermissionIDs.AutoInsert , playerIndex ) then
		SIAutoInsert.EffectSelect( playerIndex , entity )
	end
end )

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 外部接口 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================
-- 接口注册
-- ======================================================================
SINeed( "RemoteInterface" )
-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 定义信息 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 基础数据 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================
-- 初始化
-- ======================================================================

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
	-- 权限管理窗口事件
	SIMainbar.RegisterToolbarButton( SIPermission.Toolbar )
end )
.Load( function( functionID )
	-- 权限管理窗口事件
	SIMainbar.RegisterToolbarButton( SIPermission.Toolbar )
end )
.Add( SIEvents.on_player_left_game , function( event , functionID )
	local playerIndex = event.player_index
	-- 权限管理窗口事件
	SIPermission.CloseFrame( playerIndex )
end )
.Add( SIEvents.on_gui_click , function( event , functionID )
	local element = event.element
	if not element.valid then
		return
	end
	local name = element.name
	local playerIndex = event.player_index
	-- 权限管理窗口事件
	if name:StartsWith( SIPermission.Names.Prefix ) then
		if name == SIPermission.Names.Close then
			SIPermission.CloseFrame( playerIndex )
			return
		end
		if name == SIPermission.Names.GlobalSave then
			SIPermission.SaveSettings_Global( playerIndex )
			return
		end
		if name == SIPermission.Names.GlobalBack then
			SIPermission.BackSettings_Global( playerIndex )
			return
		end
		if name == SIPermission.Names.GlobalReset then
			SIPermission.ResetSettings_Global( playerIndex )
			return
		end
		if name == SIPermission.Names.PlayerSave then
			SIPermission.SaveSettings_Player( playerIndex )
			return
		end
		if name == SIPermission.Names.PlayerBack then
			SIPermission.BackSettings_Player( playerIndex )
			return
		end
		if name == SIPermission.Names.PlayerClear then
			SIPermission.ClearSettings_Player( playerIndex )
			return
		end
		if name == SIPermission.Names.CheckSave then
			SIPermission.SaveSettings_Check( playerIndex )
			return
		end
		if name == SIPermission.Names.CheckBack then
			SIPermission.BackSettings_Check( playerIndex )
			return
		end
		if name == SIPermission.Names.CheckClear then
			SIPermission.ClearSettings_Check( playerIndex )
			return
		end
		if name:StartsWith( SIPermission.Names.GlobalItemWhitePrefix ) then
			SIPermission.DeleteGlobalItemWhite( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIPermission.Names.GlobalItemBlackPrefix ) then
			SIPermission.DeleteGlobalItemBlack( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIPermission.Names.GlobalItemBluePrefix ) then
			SIPermission.AddGlobalItemWhite( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIPermission.Names.GlobalItemOrangePrefix ) then
			SIPermission.AddGlobalItemBlack( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIPermission.Names.PlayerItemPrefix ) then
			SIPermission.SelectPlayer( playerIndex , name )
			return
		end
		if name:StartsWith( SIPermission.Names.PlayerItemWhitePrefix ) then
			SIPermission.DeletePlayerItemWhite( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIPermission.Names.PlayerItemBlackPrefix ) then
			SIPermission.DeletePlayerItemBlack( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIPermission.Names.PlayerItemBluePrefix ) then
			SIPermission.AddPlayerItemWhite( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIPermission.Names.PlayerItemOrangePrefix ) then
			SIPermission.AddPlayerItemBlack( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIPermission.Names.CheckItemPrefix ) then
			SIPermission.SelectCheck( playerIndex , name )
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
	-- 权限管理窗口事件
	if name:StartsWith( SIPermission.Names.Prefix ) then
		if name == SIPermission.Names.GlobalItemFindTextWhite then
			SIPermission.FindAddGlobalItemWhite( playerIndex )
			return
		end
		if name == SIPermission.Names.GlobalItemFindTextBlack then
			SIPermission.FindAddGlobalItemBlack( playerIndex )
			return
		end
		if name == SIPermission.Names.PlayerItemFindTextWhite then
			SIPermission.FindAddPlayerItemWhite( playerIndex )
			return
		end
		if name == SIPermission.Names.PlayerItemFindTextBlack then
			SIPermission.FindAddPlayerItemBlack( playerIndex )
			return
		end
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
	-- 权限管理窗口事件
	if name:StartsWith( SIPermission.Names.Prefix ) then
		if name:StartsWith( SIPermission.Names.GlobalRadioPrefix ) then
			SIPermission.SwitchRadio_Global( playerIndex , name )
			return
		end
		if name:StartsWith( SIPermission.Names.PlayerRadioPrefix ) then
			SIPermission.SwitchRadio_Player( playerIndex , name )
			return
		end
		if name:StartsWith( SIPermission.Names.CheckRadioPrefix ) then
			SIPermission.SwitchRadio_Check( playerIndex , name )
			return
		end
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
	-- 权限管理窗口事件
	if name:StartsWith( SIPermission.Names.Prefix ) then
		if name == SIPermission.Names.GlobalItemFindWhite then
			SIPermission.AddGlobalItemWhite( playerIndex , element.elem_value , element , true )
			return
		end
		if name == SIPermission.Names.GlobalItemFindBlack then
			SIPermission.AddGlobalItemBlack( playerIndex , element.elem_value , element , true )
			return
		end
		if name == SIPermission.Names.PlayerItemFindWhite then
			SIPermission.AddPlayerItemWhite( playerIndex , element.elem_value , element , true )
			return
		end
		if name == SIPermission.Names.PlayerItemFindBlack then
			SIPermission.AddPlayerItemBlack( playerIndex , element.elem_value , element , true )
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
	-- 权限管理窗口事件
	if name == SIPermission.Names.Frame then
		SIPermission.MoveFrame( playerIndex )
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

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 外部接口 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================
-- 接口注册
-- ======================================================================
SINeed( "RemoteInterface" )
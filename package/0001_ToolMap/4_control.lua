-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 定义信息 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIControl.Init
{
	[SICommon.Types.Items.SelectionTool] =
	{
		DeleteMap  = "粉图" ,
		OreMap     = "黄图" ,
		RequestMap = "紫图"
	} ,
	[SICommon.Types.Input] =
	{
		OreMapFrame     = "黄图窗口" ,
		RequestMapFrame = "紫图窗口"
	} ,
	Styles =
	{
		-- 黄图控件样式
		OreMap_Frame = "黄图-窗口" ,
		OreMap_LabelTop = "黄图-标签顶部" ,
		OreMap_Check = "黄图-复选" ,
		OreMap_FlowShort = "黄图-布局短" ,
		OreMap_LabelShort = "黄图-标签短" ,
		OreMap_Number = "黄图-数字框" ,
		OreMap_ButtonGreen = "黄图-绿色按钮" ,
		OreMap_ListTitleIcon = "黄图-列表标题图标" ,
		OreMap_ListTitleLong = "黄图-列表标题长" ,
		OreMap_ListIcon = "黄图-列表图标" ,
		OreMap_ListLabelLong = "黄图-列表标签长" ,
		OreMap_LabelBottom = "黄图-标签底部" ,
		-- 紫图控件样式
		RequestMap_Frame = "紫图-窗口" ,
		RequestMap_TabPane = "紫图-分页面板" ,
		RequestMap_Label = "紫图-标签" ,
		RequestMap_Text = "紫图-文本条" ,
		RequestMap_EmptyFlow = "紫图-空布局" ,
		RequestMap_DropDown = "紫图-下拉列表" ,
		RequestMap_ListButtonFlow = "紫图-列表定位按钮布局" ,
		RequestMap_ListButton = "紫图-列表定位按钮" ,
		RequestMap_BlankFlow = "紫图-空白区" ,
		RequestMap_ListCheck = "紫图-列表复选" ,
		RequestMap_ListPanelFlow = "紫图-列表面板布局" ,
		RequestMap_SubList = "紫图-子列表" ,
		RequestMap_SelectList = "紫图-选择列表" ,
		RequestMap_ListChooser = "紫图-列表选择" ,
		RequestMap_ListFlow = "紫图-列表布局" ,
		RequestMap_ListLabel = "紫图-列表标签" ,
		RequestMap_ListText = "紫图-列表文本条" ,
		RequestMap_ListDropDown = "紫图-列表下拉列表" ,
		RequestMap_ListEmptyFlow = "紫图-列表占位布局"
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
SINeed( "GUI/OreMap" )
SINeed( "GUI/RequestMap" )
SIGlobal.CreateSettings( SIOreMap.Settings )
SIGlobal.CreateSettings( SIRequestMap.Settings )

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
	-- 黄图的管理窗口事件
	SIMainbar.RegisterToolbarButton( SIOreMap.Toolbar )
	SIMainbarSetting.RegisterSettingsData( SIOreMap.SettingsData )
	-- 紫图的管理窗口事件
	SIMainbar.RegisterToolbarButton( SIRequestMap.Toolbar )
	SIMainbarSetting.RegisterSettingsData( SIRequestMap.SettingsData )
end )
.Load( function( functionID )
	-- 黄图的管理窗口事件
	SIMainbar.RegisterToolbarButton( SIOreMap.Toolbar )
	SIMainbarSetting.RegisterSettingsData( SIOreMap.SettingsData )
	-- 紫图的管理窗口事件
	SIMainbar.RegisterToolbarButton( SIRequestMap.Toolbar )
	SIMainbarSetting.RegisterSettingsData( SIRequestMap.SettingsData )
end )
.Add( SIConstants_ToolMap.raw.Inputs.OreMapFrame , function( event , functionID )
	local playerIndex = event.player_index
	-- 黄图的管理窗口事件
	if SIPermission.HasPermission( SIPermission.PermissionIDs.OreMap , playerIndex ) then
		SIOreMap.OpenFrame( playerIndex )
	end
end )
.Add( SIConstants_ToolMap.raw.Inputs.RequestMapFrame , function( event , functionID )
	local playerIndex = event.player_index
	-- 紫图的管理窗口事件
	if SIPermission.HasPermission( SIPermission.PermissionIDs.RequestMap , playerIndex ) then
		SIRequestMap.OpenFrame( playerIndex )
	end
end )
.Add( SIEvents.on_player_left_game , function( event , functionID )
	local playerIndex = event.player_index
	-- 黄图的管理窗口事件
	SIOreMap.CloseFrame( playerIndex )
	-- 紫图的管理窗口事件
	SIRequestMap.CloseFrame( playerIndex )
end )
.Add( SIEvents.on_gui_click , function( event , functionID )
	local element = event.element
	if not element.valid then
		return
	end
	local name = element.name
	local playerIndex = event.player_index
	-- 黄图的管理窗口事件
	if name:StartsWith( SIOreMap.Names.Prefix ) then
		if name == SIOreMap.Names.SortName then
			SIOreMap.SortOreDataName( playerIndex )
			return
		end
		if name == SIOreMap.Names.SortCount then
			SIOreMap.SortOreDataCount( playerIndex )
			return
		end
		if name == SIOreMap.Names.Fresh then
			SIOreMap.Fresh( playerIndex )
			return
		end
		if name == SIOreMap.Names.Clean then
			SIOreMap.CleanOreData( playerIndex )
			return
		end
		if name == SIOreMap.Names.Spawn then
			SIOreMap.CreateOre( playerIndex )
			return
		end
		if name == SIOreMap.Names.Close then
			SIOreMap.CloseFrame( playerIndex )
			return
		end
		if name:StartsWith( SIOreMap.Names.IconNamePrefix ) then
			SIOreMap.SelectOre( playerIndex , name )
			return
		end
		return
	end
	-- 紫图的管理窗口事件
	if name:StartsWith( SIRequestMap.Names.Prefix ) then
		if name == SIRequestMap.Names.Close then
			SIRequestMap.CloseFrame( playerIndex )
			return
		end
		if name == SIRequestMap.Names.Add then
			SIRequestMap.Out_AddTabSettings( playerIndex )
			return
		end
		if name == SIRequestMap.Names.Delete then
			SIRequestMap.Out_DeleteTabSettings( playerIndex )
			return
		end
		if name:StartsWith( SIRequestMap.Names.ListButtonPrefix ) then
			SIRequestMap.ListScroll( playerIndex , name )
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
	-- 黄图的管理窗口事件
	if name:StartsWith( SIOreMap.Names.Prefix ) then
		if name == SIOreMap.Names.Count then
			SIOreMap.Set_Count( playerIndex , element )
			return
		end
		return
	end
	-- 紫图的管理窗口事件
	if name:StartsWith( SIRequestMap.Names.Prefix ) then
		if name:StartsWith( SIRequestMap.Names.MaxSlot_Count_Prefix ) then
			SIRequestMap.Set_MaxSlot_Count( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIRequestMap.Names.InsertFuel_Count_Prefix ) then
			SIRequestMap.Set_InsertFuel_Count( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIRequestMap.Names.InsertAmmo_Count_Prefix ) then
			SIRequestMap.Set_InsertAmmo_Count( playerIndex , name , element )
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
	-- 紫图的管理窗口事件
	if name == SIRequestMap.Names.TabSettingsName then
		SIRequestMap.Set_TabSettingsName( playerIndex , element )
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
	-- 黄图的管理窗口事件
	if name:StartsWith( SIOreMap.Names.Prefix ) then
		if name == SIOreMap.Names.AsDefault then
			SIOreMap.Set_AsDefault( playerIndex , element )
			return
		end
		if name == SIOreMap.Names.TotalMode then
			SIOreMap.Set_TotalMode( playerIndex , element )
			return
		end
		return
	end
	-- 紫图的管理窗口事件
	if name:StartsWith( SIRequestMap.Names.Prefix ) then
		if name == SIRequestMap.Names.GreenToBlue_Check then
			SIRequestMap.Set_GreenToBlue_Check( playerIndex , element )
			return
		end
		if name == SIRequestMap.Names.SetModule_FromInventory then
			SIRequestMap.Set_SetModule_FromInventory( playerIndex , element )
			return
		end
		if name == SIRequestMap.Names.RemoveModule_ToInventory then
			SIRequestMap.Set_RemoveModule_ToInventory( playerIndex , element )
			return
		end
		if name == SIRequestMap.Names.RemoveModule_Invert then
			SIRequestMap.Set_RemoveModule_Invert( playerIndex , element )
			return
		end
		if name:StartsWith( SIRequestMap.Names.EnablePrefix ) then
			SIRequestMap.EnableFunction( playerIndex , name , element )
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
	-- 紫图的管理窗口事件
	if name:StartsWith( SIRequestMap.Names.Prefix ) then
		if name == SIRequestMap.Names.DefaultIndex then
			SIRequestMap.Set_DefaultIndex( playerIndex , element )
			return
		end
		if name:StartsWith( SIRequestMap.Names.InsertFuel_Mode_Prefix ) then
			SIRequestMap.Set_InsertFuel_Mode( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIRequestMap.Names.InsertAmmo_Mode_Prefix ) then
			SIRequestMap.Set_InsertAmmo_Mode( playerIndex , name , element )
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
	-- 紫图的管理窗口事件
	if name:StartsWith( SIRequestMap.Names.Prefix ) then
		if name:StartsWith( SIRequestMap.Names.RequestSlot_Entity_Prefix ) then
			SIRequestMap.Set_RequestSlot_Entity( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIRequestMap.Names.RequestSlot_Item_Prefix ) then
			SIRequestMap.Set_RequestSlot_Item( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIRequestMap.Names.MaxSlot_Entity_Prefix ) then
			SIRequestMap.Set_MaxSlot_Entity( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIRequestMap.Names.SetModule_Entity_Prefix ) then
			SIRequestMap.Set_SetModule_Entity( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIRequestMap.Names.SetModule_Item_Prefix ) then
			SIRequestMap.Set_SetModule_Item( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIRequestMap.Names.RemoveModule_Entity_Prefix ) then
			SIRequestMap.Set_RemoveModule_Entity( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIRequestMap.Names.RemoveModule_Item_Prefix ) then
			SIRequestMap.Set_RemoveModule_Item( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIRequestMap.Names.InsertFuel_Entity_Prefix ) then
			SIRequestMap.Set_InsertFuel_Entity( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIRequestMap.Names.InsertFuel_Item_Prefix ) then
			SIRequestMap.Set_InsertFuel_Item( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIRequestMap.Names.InsertAmmo_Entity_Prefix ) then
			SIRequestMap.Set_InsertAmmo_Entity( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIRequestMap.Names.InsertAmmo_Item_Prefix ) then
			SIRequestMap.Set_InsertAmmo_Item( playerIndex , name , element )
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
	-- 紫图的管理窗口事件
	if name == SIRequestMap.Names.TabPane then
		SIRequestMap.SwitchTab( playerIndex )
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
	-- 黄图的管理窗口事件
	if name == SIOreMap.Names.Frame then
		SIOreMap.MoveFrame( playerIndex )
		return
	end
	-- 紫图的管理窗口事件
	if name == SIRequestMap.Names.Frame then
		SIRequestMap.MoveFrame( playerIndex )
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
-- ========== 特殊工具触发 ====================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================
-- 事件
-- ======================================================================
SIEventBus
.Add( SIEvents.on_player_selected_area , function( event , functionID )
	local itemName = event.item
	local item = prototypes.item[itemName]
	if not item or item.flags[SICommon.Flags.Item.OnlyInCursor] then
		return
	end
	local playerIndex = event.player_index
	-- 粉图
	if itemName == SIConstants_ToolMap.raw.Items.DeleteMap then
		if SIPermission.HasPermission( SIPermission.PermissionIDs.DeleteMap , playerIndex ) then
			local explosionCount = 0
			for index , entity in pairs( event.entities ) do
				if entity.valid and entity.type ~= "character" then
					local surface = entity.surface
					if entity.health then
						if explosionCount < 200 then
							surface.create_entity{ name = "medium-explosion" , position = entity.position }
							explosionCount = explosionCount + 1
						end
						if entity.prototype.corpses then
							for corpseIndex , corpsePrototype in pairs( entity.prototype.corpses ) do
								surface.create_entity{ name = corpsePrototype.name , direction = entity.direction , position = entity.position }
							end
						else
							surface.create_entity{ name = "small-scorchmark" , direction = entity.direction , position = entity.position }
						end
						entity.destroy{ raise_destroy = true }
					elseif entity.type == SICommon.Types.Entities.Cliff then
						if explosionCount < 200 then
							surface.create_entity{ name = "ground-explosion" , position = entity.position }
							explosionCount = explosionCount + 1
						end
						surface.create_entity{ name = "small-scorchmark" , direction = entity.direction , position = entity.position }
						entity.destroy{ do_cliff_correction = true , raise_destroy = true }
					elseif entity.type == SICommon.Types.Entities.Resource then
						if explosionCount < 200 then
							surface.create_entity{ name = "medium-explosion" , position = entity.position }
							explosionCount = explosionCount + 1
						end
						surface.create_entity{ name = "small-scorchmark" , direction = entity.direction , position = entity.position }
						entity.destroy{ raise_destroy = true }
					else
						entity.destroy{ raise_destroy = true }
					end
				end
			end
		else
			SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.DeleteMap ) )
		end
		return
	end
	-- 黄图
	if itemName == SIConstants_ToolMap.raw.Items.OreMap then
		if SIPermission.HasPermission( SIPermission.PermissionIDs.OreMap , playerIndex ) then
			SIOreMap.SaveOre( playerIndex , event.entities )
		else
			SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.OreMap ) )
		end
		return
	end
	-- 紫图
	if itemName == SIConstants_ToolMap.raw.Items.RequestMap then
		if SIPermission.HasPermission( SIPermission.PermissionIDs.RequestMap , playerIndex ) then
			SIRequestMap.EffectSelect1( playerIndex , event.entities )
		else
			SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.RequestMap ) )
		end
		return
	end
end )
.Add( SIEvents.on_player_reverse_selected_area , function( event , functionID )
	local itemName = event.item
	local item = prototypes.item[itemName]
	if not item or item.flags[SICommon.Flags.Item.OnlyInCursor] then
		return
	end
	local playerIndex = event.player_index
	-- 粉图
	if itemName == SIConstants_ToolMap.raw.Items.DeleteMap then
		if SIPermission.HasPermission( SIPermission.PermissionIDs.DeleteMap , playerIndex ) then
			local explosionCount = 0
			for index , entity in pairs( event.entities ) do
				if entity.valid and entity.type ~= "character" and entity.health then
					local surface = entity.surface
					if explosionCount < 200 then
						surface.create_entity{ name = "medium-explosion" , position = entity.position }
						explosionCount = explosionCount + 1
					end
					if entity.prototype.corpses then
						for corpseIndex , corpsePrototype in pairs( entity.prototype.corpses ) do
							surface.create_entity{ name = corpsePrototype.name , direction = entity.direction , position = entity.position }
						end
					else
						surface.create_entity{ name = "small-scorchmark" , direction = entity.direction , position = entity.position }
					end
					entity.destroy{ raise_destroy = true }
				end
			end
		else
			SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.DeleteMap ) )
		end
		return
	end
	-- 紫图
	if itemName == SIConstants_ToolMap.raw.Items.RequestMap then
		if SIPermission.HasPermission( SIPermission.PermissionIDs.RequestMap , playerIndex ) then
			SIRequestMap.EffectSelect2( playerIndex , event.entities )
		else
			SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.RequestMap ) )
		end
		return
	end
end )
.Add( SIEvents.on_player_alt_selected_area , function( event , functionID )
	local itemName = event.item
	local item = prototypes.item[itemName]
	if not item or item.flags[SICommon.Flags.Item.OnlyInCursor] then
		return
	end
	local playerIndex = event.player_index
	-- 粉图
	if itemName == SIConstants_ToolMap.raw.Items.DeleteMap then
		if SIPermission.HasPermission( SIPermission.PermissionIDs.DeleteMap , playerIndex ) then
			local surface = game.get_player( playerIndex ).surface
			local positionList = {}
			local totalCount = #event.tiles
			for index , tile in pairs( event.tiles ) do
				if #surface.find_entities_filtered{ area = { { tile.position.x , tile.position.y } , { tile.position.x+1 , tile.position.y+1 } } } < 1 then
					if surface.get_tile( tile.position.x , tile.position.y ).name ~= "deepwater" then
						surface.set_tiles( { { name = "deepwater" , position = tile.position } } , true , false , true , false )
						if math.random() < 0.07 or index == totalCount then
							table.insert( positionList , { tile.position.x + 0.5 , tile.position.y + 0.5 } )
						end
					end
				end
			end
			local explosionCount = 0
			for index , position in pairs( positionList ) do
				if explosionCount > 200 then
					break
				end
				surface.create_entity{ name = "medium-explosion" , position = position }
				explosionCount = explosionCount + 1
			end
		else
			SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.DeleteMap ) )
		end
		return
	end
	-- 黄图
	if itemName == SIConstants_ToolMap.raw.Items.OreMap then
		if SIPermission.HasPermission( SIPermission.PermissionIDs.OreMap , playerIndex ) then
			SIOreMap.CreateOreByMap( playerIndex , event.tiles )
		else
			SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.OreMap ) )
		end
		return
	end
	-- 紫图
	if itemName == SIConstants_ToolMap.raw.Items.RequestMap then
		if SIPermission.HasPermission( SIPermission.PermissionIDs.RequestMap , playerIndex ) then
			SIRequestMap.EffectSelect3( playerIndex , event.entities )
		else
			SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.RequestMap ) )
		end
		return
	end
end )
.Add( SIEvents.on_player_alt_reverse_selected_area , function( event , functionID )
	local itemName = event.item
	local item = prototypes.item[itemName]
	if not item or item.flags[SICommon.Flags.Item.OnlyInCursor] then
		return
	end
	local playerIndex = event.player_index
	-- 粉图
	if itemName == SIConstants_ToolMap.raw.Items.DeleteMap then
		if SIPermission.HasPermission( SIPermission.PermissionIDs.DeleteMap , playerIndex ) then
			local surface = game.get_player( playerIndex ).surface
			for index , tile in pairs( event.tiles ) do
				surface.set_tiles( { { name = "refined-concrete" , position = tile.position } } , true , false , true , false )
			end
		else
			SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.DeleteMap ) )
		end
		return
	end
	-- 紫图
	if itemName == SIConstants_ToolMap.raw.Items.RequestMap then
		if SIPermission.HasPermission( SIPermission.PermissionIDs.RequestMap , playerIndex ) then
			SIRequestMap.EffectSelect4( playerIndex , event.entities )
		else
			SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.RequestMap ) )
		end
		return
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
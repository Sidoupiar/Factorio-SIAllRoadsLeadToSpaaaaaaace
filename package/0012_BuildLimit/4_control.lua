-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 定义信息 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIControl.Init
{
	[SICommon.Types.Sprite] =
	{
		Beacon = "提示插件塔过载" ,
		Module = "提示插件过载"
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
SINeed( "System/BuildLimit" )
SIGlobal.CreateSettings( SIBuildLimit.Settings )

-- ======================================================================<br>
-- 事件<br>
-- ======================================================================<br>
SIEventBus
.Init( function( functionID )
	-- 初始化数据
	SIBuildLimit.InitData()
end )
.ConfigurationChange( function( functionID )
	-- 初始化数据
	SIBuildLimit.InitData()
end )

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 操作事件 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================<br>
-- 事件<br>
-- ======================================================================<br>
SIEventBus
.Add( SIEvents.on_built_entity , function( event , functionID )
	local entity = event.created_entity
	if not entity or not entity.valid then
		return
	end
	local playerIndex = event.player_index
	if entity.type == SICommon.Types.Entities.GhostEntity or entity.type == SICommon.Types.Entities.ProxyItemRequest then
		SIBuildLimit.CheckModule( playerIndex , entity , true )
	else
		SIBuildLimit.BuildEntity( playerIndex , entity )
	end
end )
.Add( SIEvents.on_robot_built_entity , function( event , functionID )
	local entity = event.created_entity
	if not entity or not entity.valid then
		return
	end
	if entity.type == SICommon.Types.Entities.GhostEntity or entity.type == SICommon.Types.Entities.ProxyItemRequest then
		SIBuildLimit.CheckModule( nil , entity , true )
	else
		SIBuildLimit.BuildEntity( nil , entity )
	end
end )
.Add( SIEvents.on_trigger_created_entity , function( event , functionID )
	local entity = event.entity
	if not entity or not entity.valid then
		return
	end
	if entity.type == SICommon.Types.Entities.GhostEntity or entity.type == SICommon.Types.Entities.ProxyItemRequest then
		SIBuildLimit.CheckModule( nil , entity , true )
	else
		SIBuildLimit.BuildEntity( nil , entity )
	end
end )
.Add( SIEvents.script_raised_built , function( event , functionID )
	local entity = event.entity
	if not entity or not entity.valid then
		return
	end
	if entity.type == SICommon.Types.Entities.GhostEntity or entity.type == SICommon.Types.Entities.ProxyItemRequest then
		SIBuildLimit.CheckModule( nil , entity , true )
	else
		SIBuildLimit.BuildEntity( nil , entity )
	end
end )
.Add( SIEvents.on_player_mined_entity , function( event , functionID )
	local entity = event.entity
	if not entity or not entity.valid then
		return
	end
	local playerIndex = event.player_index
	SIBuildLimit.DestroyEntity( playerIndex , entity )
end )
.Add( SIEvents.on_robot_mined_entity , function( event , functionID )
	local entity = event.entity
	if not entity or not entity.valid then
		return
	end
	SIBuildLimit.DestroyEntity( nil , entity )
end )
.Add( SIEvents.on_entity_died , function( event , functionID )
	local entity = event.entity
	if not entity or not entity.valid then
		return
	end
	SIBuildLimit.DestroyEntity( nil , entity )
end )
.Add( SIEvents.script_raised_destroy , function( event , functionID )
	local entity = event.entity
	if not entity or not entity.valid then
		return
	end
	SIBuildLimit.DestroyEntity( nil , entity )
end )
.Add( SIEvents.on_tick , function( event , functionID )
	for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIBuildLimit.Settings.Name ) ) do
		local entity = settings.CurrentEntity
		if entity then
			SIBuildLimit.CheckModule( playerIndex , entity , false )
		end
	end
end )
.Add( SIEvents.on_entity_destroyed , function( event , functionID )
	local unitNumber = event.unit_number
	if not unitNumber then
		return
	end
	SIBuildLimit.DestroyEntityIcons( unitNumber )
end )
.Add( SIRequestMap.GetModuleEventID() , function( event , functionID )
	local entity = event.entity
	if not entity or not entity.valid then
		return
	end
	local playerIndex = event.player_index
	SIBuildLimit.CheckModule( playerIndex , entity , true )
end )
.Add( SIAutoInsert.GetModuleEventID() , function( event , functionID )
	local entity = event.entity
	if not entity or not entity.valid then
		return
	end
	local playerIndex = event.player_index
	SIBuildLimit.CheckModule( playerIndex , entity , true )
end )

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 玩家操作事件 ====================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================<br>
-- 事件<br>
-- ======================================================================<br>
SIEventBus
.Add( SIEvents.on_gui_opened , function( event , functionID )
	local entity = event.entity
	if not entity or not entity.valid then
		return
	end
	local playerIndex = event.player_index
	SIBuildLimit.PlayerOpenEntity( playerIndex , entity )
end )
.Add( SIEvents.on_gui_closed , function( event , functionID )
	local entity = event.entity
	if not entity or not entity.valid then
		return
	end
	local playerIndex = event.player_index
	SIBuildLimit.PlayerCloseEntity( playerIndex , entity )
end )
.Add( SIEvents.on_player_main_inventory_changed , function( event , functionID )
	local playerIndex = event.player_index
	local player = game.get_player( playerIndex )
	local entity = player.selected
	if not entity or not entity.valid then
		return
	end
	SIBuildLimit.CheckModule( playerIndex , entity , true )
end )
.Add( SIEvents.on_selected_entity_changed , function( event , functionID )
	local entity = event.last_entity
	if not entity or not entity.valid then
		return
	end
	local playerIndex = event.player_index
	SIBuildLimit.CheckModule( playerIndex , entity , true )
end )
.Add( SIEvents.on_marked_for_upgrade , function( event , functionID )
	local entity = event.entity
	if not entity or not entity.valid then
		return
	end
	local playerIndex = event.player_index
	SIBuildLimit.CheckModule( playerIndex , entity , true )
end )
-- ======================================================================<br>
-- 移除绿图中选择的插件
-- 当前为硬限制
-- 记录 : 与上方的事件重复定义 , 按需合并
-- ======================================================================<br>
.Add( SIEvents.on_gui_closed , function( event , functionID )
	local itemStack = event.item
	if not itemStack or not itemStack.valid or not itemStack.valid_for_read or not itemStack.is_upgrade_item then
		return
	end
	local showMessageFlag = false
	for index = 1 , SICommon.Numbers.UpgradeMapSlotCount , 1 do
		local filter = itemStack.get_mapper( index , "from" )
		if filter and filter.type == "item" then
			local itemPrototype = prototypes.item[filter.name]
			if itemPrototype and itemPrototype.type == SICommon.Types.Items.Module then
				itemStack.set_mapper( index , "from" , nil )
				itemStack.set_mapper( index , "to" , nil )
				showMessageFlag = true
			end
		end
	end
	if showMessageFlag then
		SIPrint.Warning( event.player_index , { "SIBuildLimit.不能使用绿图更换插件" , itemStack.prototype.name } )
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
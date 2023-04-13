-- ------------------------------------------------------------------------------------------------
-- ---------- 定义信息 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIControl.Init
{
	[SICommon.Types.Sprite] =
	{
		Beacon = "提示插件塔过载" ,
		Module = "提示插件过载"
	}
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 初始化
-- ----------------------------------------
SINeed( "System/SIBuildLimit" )
SIGlobal.CreateSettings( SIBuildLimit.Settings )

-- ----------------------------------------
-- 事件
-- ----------------------------------------
SIEventBus
.Init( function( functionID )
	-- 初始化数据
	SIBuildLimit.InitData()
end )
.ConfigurationChange( function( functionID )
	-- 初始化数据
	SIBuildLimit.InitData()
end )

-- ------------------------------------------------------------------------------------------------
-- ---------- 操作事件 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 事件
-- ----------------------------------------
SIEventBus
.Add( SIEvents.on_built_entity , function( event , functionID )
	local entity = event.created_entity
	if not entity or not entity.valid then
		return
	end
	local playerIndex = event.player_index
	if entity.type == SICommon.Types.Entities.GhostEntity or entity.type == SICommon.Types.Entities.ProxyItemRequest then
		SIBuildLimit.CheckModule( playerIndex , entity )
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
		SIBuildLimit.CheckModule( nil , entity )
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
		SIBuildLimit.CheckModule( nil , entity )
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
		SIBuildLimit.CheckModule( nil , entity )
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
			SIBuildLimit.CheckModule( playerIndex , entity )
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
	SIBuildLimit.CheckModule( playerIndex , entity )
end )

-- ------------------------------------------------------------------------------------------------
-- -------- 玩家操作事件 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 事件
-- ----------------------------------------
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
.Add( SIEvents.on_marked_for_upgrade , function( event , functionID )
	local entity = event.entity
	if not entity or not entity.valid then
		return
	end
	local playerIndex = event.player_index
	SIPrint.Print( entity.name )
	SIBuildLimit.CheckModule( playerIndex , entity )
end )

-- ------------------------------------------------------------------------------------------------
-- ---------- 外部接口 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 接口注册
-- ----------------------------------------
SINeed( "RemoteInterface" )
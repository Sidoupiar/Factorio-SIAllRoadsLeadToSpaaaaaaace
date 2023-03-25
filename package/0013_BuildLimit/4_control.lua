-- ------------------------------------------------------------------------------------------------
-- ---------- 定义信息 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

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
	if entity.type == SICommon.Types.Entities.GhostEntity then
		SIBuildLimit.CheckModule( entity )
	else
		SIBuildLimit.BuildEntity( entity )
	end
end )
.Add( SIEvents.on_robot_built_entity , function( event , functionID )
	local entity = event.created_entity
	if not entity or not entity.valid then
		return
	end
	if entity.type == SICommon.Types.Entities.GhostEntity then
		SIBuildLimit.CheckModule( entity )
	else
		SIBuildLimit.BuildEntity( entity )
	end
end )
.Add( SIEvents.on_trigger_created_entity , function( event , functionID )
	local entity = event.entity
	if not entity or not entity.valid then
		return
	end
	if entity.type == SICommon.Types.Entities.GhostEntity then
		SIBuildLimit.CheckModule( entity )
	else
		SIBuildLimit.BuildEntity( entity )
	end
end )
.Add( SIEvents.script_raised_built , function( event , functionID )
	local entity = event.entity
	if not entity or not entity.valid then
		return
	end
	if entity.type == SICommon.Types.Entities.GhostEntity then
		SIBuildLimit.CheckModule( entity )
	else
		SIBuildLimit.BuildEntity( entity )
	end
end )
.Add( SIEvents.on_player_mined_entity , function( event , functionID )
	local entity = event.entity
	if not entity or not entity.valid then
		return
	end
	SIBuildLimit.DestroyEntity( entity )
end )
.Add( SIEvents.on_robot_mined_entity , function( event , functionID )
	local entity = event.entity
	if not entity or not entity.valid then
		return
	end
	SIBuildLimit.DestroyEntity( entity )
end )
.Add( SIEvents.on_entity_died , function( event , functionID )
	local entity = event.entity
	if not entity or not entity.valid then
		return
	end
	SIBuildLimit.DestroyEntity( entity )
end )
.Add( SIEvents.script_raised_destroy , function( event , functionID )
	local entity = event.entity
	if not entity or not entity.valid then
		return
	end
	SIBuildLimit.DestroyEntity( entity )
end )
.Add( SIEvents.on_gui_closed , function( event , functionID )
	local entity = event.entity
	if not entity or not entity.valid then
		return
	end
	SIBuildLimit.CheckModule( entity )
end )
.Add( SIRequestMap.GetModuleEventID() , function( event , functionID )
	local entity = event.entity
	if not entity or not entity.valid then
		return
	end
	SIBuildLimit.CheckModule( entity )
end )

-- ------------------------------------------------------------------------------------------------
-- ---------- 外部接口 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 接口注册
-- ----------------------------------------
SINeed( "RemoteInterface" )
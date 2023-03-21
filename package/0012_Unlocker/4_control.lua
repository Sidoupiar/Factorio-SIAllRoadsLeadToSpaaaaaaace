-- ------------------------------------------------------------------------------------------------
-- ---------- 定义信息 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 初始化
-- ----------------------------------------
SINeed( "System/SIUnlocker" )
SIGlobal.CreateSettings( SIUnlocker.Settings )

-- ----------------------------------------
-- 事件
-- ----------------------------------------
SIEventBus
.Init( function( functionID )
	-- 初始化数据
	SIUnlocker.InitData()
end )
.ConfigurationChange( function( functionID )
	-- 初始化数据
	SIUnlocker.InitData()
end )

-- ------------------------------------------------------------------------------------------------
-- ---------- 操作事件 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 事件
-- ----------------------------------------
SIEventBus
.Add( SIEvents.on_player_mined_entity , function( event , functionID )
	local entity = event.entity
	if not entity.valid then
		return
	end
	local playerIndex = event.player_index
	local player = game.get_player( playerIndex )
	local forceIndex = player.force.index
	SIUnlocker.FreshMined( forceIndex , playerIndex , entity.name )
	for itemName , count in pairs( event.inventory.get_contents() ) do
		SIUnlocker.FreshMinedResult( forceIndex , playerIndex , itemName , count )
	end
end )
.Add( SIEvents.on_player_crafted_item , function( event , functionID )
end )
.Add( SIEvents.on_built_entity , function( event , functionID )
end )
.Add( SIEvents.on_entity_died , function( event , functionID )
end )
.Add( SIEvents.on_player_used_capsule , function( event , functionID )
end )

-- ------------------------------------------------------------------------------------------------
-- ---------- 外部接口 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 接口注册
-- ----------------------------------------
SINeed( "RemoteInterface" )
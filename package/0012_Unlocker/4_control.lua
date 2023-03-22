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
.Add( SIEvents.on_force_created , function( event , functionID )
	local force = event.force
	SIUnlocker.InitForce( force.index )
end )
.Add( SIEvents.on_force_reset , function( event , functionID )
	local force = event.force
	SIUnlocker.ResetForce( force.index )
end )
.Add( SIEvents.on_forces_merged , function( event , functionID )
	local forceIndex = event.source_index
	SIUnlocker.ResetForce( forceIndex )
end )
.Add( SIEvents.on_player_mined_entity , function( event , functionID )
	local entity = event.entity
	if not entity.valid then
		return
	end
	local playerIndex = event.player_index
	local player = game.get_player( playerIndex )
	local forceIndex = player.force.index
	SIUnlocker.EffectMined( forceIndex , playerIndex , entity.name )
	local inventory = event.buffer
	if inventory then
		for itemName , count in pairs( inventory.get_contents() ) do
			SIUnlocker.EffectMinedResult( forceIndex , playerIndex , itemName , count )
		end
	end
end )
.Add( SIEvents.on_player_crafted_item , function( event , functionID )
	local recipe = event.recipe
	local playerIndex = event.player_index
	local player = game.get_player( playerIndex )
	local forceIndex = player.force.index
	SIUnlocker.EffectCraft( forceIndex , playerIndex , recipe.name )
end )
.Add( SIEvents.on_built_entity , function( event , functionID )
	local entity = event.created_entity
	if not entity.valid then
		return
	end
	local playerIndex = event.player_index
	local player = game.get_player( playerIndex )
	local forceIndex = player.force.index
	SIUnlocker.EffectBuild( forceIndex , playerIndex , entity.name )
end )
.Add( SIEvents.on_entity_died , function( event , functionID )
	local entity = event.entity
	if not entity.valid then
		return
	end
	local causeEntity = event.cause
	if not causeEntity or not causeEntity.valid then
		return
	end
	local player = nil
	if causeEntity.is_player() then
		player = causeEntity
	elseif causeEntity.type == SICommon.Types.Entities.Character then
		local causePlayer = causeEntity.player
		if causePlayer and causePlayer.valid and causePlayer.is_player() then
			player = causePlayer
		end
	elseif causeEntity.type == SICommon.Types.Entities.Car or causeEntity.type == SICommon.Types.Entities.SpiderVehicle then
		local driver = causeEntity.get_driver()
		if driver and driver.valid then
			if driver.is_player() then
				player = driver
			elseif driver.type == SICommon.Types.Entities.Character then
				local causePlayer = driver.player
				if causePlayer and causePlayer.valid and causePlayer.is_player() then
					player = causePlayer
				end
			end
		end
	end
	if not player then
		return
	end
	local forceIndex = player.force.index
	SIUnlocker.EffectDestroy( forceIndex , player.index , entity.name )
end )
.Add( SIEvents.on_player_used_capsule , function( event , functionID )
	local item = event.item
	local playerIndex = event.player_index
	local player = game.get_player( playerIndex )
	local forceIndex = player.force.index
	SIUnlocker.EffectCapsule( forceIndex , playerIndex , item.name )
end )

-- ------------------------------------------------------------------------------------------------
-- ---------- 外部接口 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 接口注册
-- ----------------------------------------
SINeed( "RemoteInterface" )
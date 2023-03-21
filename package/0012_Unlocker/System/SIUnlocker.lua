SIUnlocker =
{
	ID = "SIUnlocker" ,
	Name = "解锁逻辑" ,
	InterfaceID = "SIUnlocker" ,
	Settings =
	{
		Name = "SIUnlocker" ,
		DefaultGlobal =
		{
			UnlockData = {}
		} ,
		DefaultForce =
		{
			UnlockData = {} ,
			Mined = {} ,
			MinedResult = {} ,
			Craft = {} ,
			Build = {} ,
			Destroy = {} ,
			Capsule = {}
		}
	} ,
	-- ------------------------------------------------------------------------------------------------
	-- ----------- 初始化 -----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	InitData = function()
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 功能函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	EffectUnlockData = function( unlockData , forceIndex , playerIndex )
		for triggerType , triggerList in pairs( unlockData.Triggers ) do
			for triggerName , trigger in pairs( triggerList ) do
				if not trigger.Finish then
					return
				end
			end
		end
		local gameTick = game.tick
		for resultType , result in pairs( unlockData.Results ) do
			if resultType == SIUnlocker.ResultTypeID.AddRecipe then
				local force = game.forces[forceIndex]
				for index , recipeName in pairs( result.Recipes ) do
					force.recipes[recipeName].enabled = true
				end
			elseif resultType == SIUnlocker.ResultTypeID.RemoveRecipe then
				local force = game.forces[forceIndex]
				for index , recipeName in pairs( result.Recipes ) do
					force.recipes[recipeName].enabled = false
				end
			elseif resultType == SIUnlocker.ResultTypeID.AddTechnology then
				local force = game.forces[forceIndex]
				for index , technologyName in pairs( result.Technologies ) do
					local technology = force.technologies[technologyName]
					technology.enabled = true
					technology.visible_when_disabled = true
				end
			elseif resultType == SIUnlocker.ResultTypeID.RemoveTechnology then
				local force = game.forces[forceIndex]
				for index , technologyName in pairs( result.Technologies ) do
					local technology = force.technologies[technologyName]
					technology.enabled = false
					technology.visible_when_disabled = false
				end
			elseif resultType == SIUnlocker.ResultTypeID.AddItem then
				local outItemStacks = {}
				local player = game.get_player( playerIndex )
				local inventory = player.get_main_inventory()
				for itemName , count in pairs( result.Items ) do
					local itemStack = { name = itemName , count = count }
					if inventory and inventory.can_insert( itemStack ) then
						local innerCount = inventory.insert( itemStack )
						if innerCount < count then
							table.insert( outItemStacks , { name = itemName , count = count - innerCount } )
						end
					else
						table.insert( outItemStacks , itemStack )
					end
				end
				if #outItemStacks > 0 then
					local surface = player.surface
					local force = player.force
					local position = force.get_spawn_position( surface )
					for index , itemStack in pairs( outItemStacks ) do
						surface.spill_item_stack( position , itemStack , true , force , false )
					end
				end
			elseif resultType == SIUnlocker.ResultTypeID.MessageForce then
				game.forces[forceIndex].print( result.Message )
			elseif resultType == SIUnlocker.ResultTypeID.MessagePlayer then
				game.get_player( playerIndex ).print( result.Message )
			elseif resultType == SIUnlocker.ResultTypeID.Interface then
				if remote.interfaces[result.RemoteInterfaceID] and remote.interfaces[result.RemoteInterfaceID][result.RemoteFunctionName] then
					remote.call( result.RemoteInterfaceID , result.RemoteFunctionName , unlockData.ID , result.Data , forceIndex , playerIndex , gameTick )
				end
			end
		end
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 事件函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	FreshMined = function( forceIndex , playerIndex , entityName )
		local forceSettings = SIGlobal.GetForceSettings( SIUnlocker.Settings.Name , forceIndex )
		local minedDataList = forceSettings.Mined[entityName]
		if not minedDataList then
			return
		end
		for index , unlockDataID in pairs( SIUtils.table.deepcopy( minedDataList ) ) do
			local unlockData = forceSettings.UnlockData[unlockDataID]
			local minedData = unlockData.Triggers.Mined[entityName]
			minedData.Count = minedData.Count + 1
			if minedData.Count > minedData.Max then
				minedData.Finish = true
				table.remove( minedDataList , index )
				SIUnlocker.EffectUnlockData( unlockData , forceIndex , playerIndex )
			end
		end
	end ,
	FreshMinedResult = function( forceIndex , playerIndex , itemName , count )
		local forceSettings = SIGlobal.GetForceSettings( SIUnlocker.Settings.Name , forceIndex )
		local minedResultDataList = forceSettings.MinedResult[itemName]
		if not minedResultDataList then
			return
		end
		for index , unlockDataID in pairs( SIUtils.table.deepcopy( minedResultDataList ) ) do
			local unlockData = forceSettings.UnlockData[unlockDataID]
			local minedResultData = unlockData.Triggers.MinedResult[itemName]
			if minedResultData.Mode == SIUnlocker.MinedResultMode.Total then
				minedResultData.Count = minedResultData.Count + count
			else
				minedResultData.Count = minedResultData.Count + 1
			end
			if minedResultData.Count > minedResultData.Max then
				minedResultData.Finish = true
				table.remove( minedResultDataList , index )
				SIUnlocker.EffectUnlockData( unlockData , forceIndex , playerIndex )
			end
		end
	end ,
	FreshCraft = function( forceIndex , playerIndex , recipeName )
		local forceSettings = SIGlobal.GetForceSettings( SIUnlocker.Settings.Name , forceIndex )
		local craftDataList = forceSettings.Craft[recipeName]
		if not craftDataList then
			return
		end
		for index , unlockDataID in pairs( SIUtils.table.deepcopy( craftDataList ) ) do
			local unlockData = forceSettings.UnlockData[unlockDataID]
			local craftData = unlockData.Triggers.Craft[recipeName]
			craftData.Count = craftData.Count + 1
			if craftData.Count > craftData.Max then
				craftData.Finish = true
				table.remove( craftDataList , index )
				SIUnlocker.EffectUnlockData( unlockData , forceIndex , playerIndex )
			end
		end
	end ,
	FreshBuild = function( forceIndex , playerIndex , entityName )
		local forceSettings = SIGlobal.GetForceSettings( SIUnlocker.Settings.Name , forceIndex )
		local buildDataList = forceSettings.Build[entityName]
		if not buildDataList then
			return
		end
		for index , unlockDataID in pairs( SIUtils.table.deepcopy( buildDataList ) ) do
			local unlockData = forceSettings.UnlockData[unlockDataID]
			local buildData = unlockData.Triggers.Build[entityName]
			buildData.Count = buildData.Count + 1
			if buildData.Count > buildData.Max then
				buildData.Finish = true
				table.remove( buildDataList , index )
				SIUnlocker.EffectUnlockData( unlockData , forceIndex , playerIndex )
			end
		end
	end ,
	FreshDestroy = function( forceIndex , playerIndex , entityName )
		local forceSettings = SIGlobal.GetForceSettings( SIUnlocker.Settings.Name , forceIndex )
		local destroyDataList = forceSettings.Destroy[entityName]
		if not destroyDataList then
			return
		end
		for index , unlockDataID in pairs( SIUtils.table.deepcopy( destroyDataList ) ) do
			local unlockData = forceSettings.UnlockData[unlockDataID]
			local destroyData = unlockData.Triggers.Destroy[entityName]
			destroyData.Count = destroyData.Count + 1
			if destroyData.Count > destroyData.Max then
				destroyData.Finish = true
				table.remove( destroyDataList , index )
				SIUnlocker.EffectUnlockData( unlockData , forceIndex , playerIndex )
			end
		end
	end ,
	FreshCapsule = function( forceIndex , playerIndex , itemName )
		local forceSettings = SIGlobal.GetForceSettings( SIUnlocker.Settings.Name , forceIndex )
		local capsuleDataList = forceSettings.Capsule[itemName]
		if not capsuleDataList then
			return
		end
		for index , unlockDataID in pairs( SIUtils.table.deepcopy( capsuleDataList ) ) do
			local unlockData = forceSettings.UnlockData[unlockDataID]
			local capsuleData = unlockData.Triggers.Capsule[itemName]
			capsuleData.Count = capsuleData.Count + 1
			if capsuleData.Count > capsuleData.Max then
				capsuleData.Finish = true
				table.remove( capsuleDataList , index )
				SIUnlocker.EffectUnlockData( unlockData , forceIndex , playerIndex )
			end
		end
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ------ 接口函数 -- 注册 ------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	AddUnlockData = function()
	end ,
	AddUnlockDataList = function()
	end ,
	FreshUnlockData = function()
	end ,
	FreshUnlockDataList = function()
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ------ 接口函数 -- 控制 ------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	Unlock = function( forceIndex , unlockDataID )
		local forceSettings = SIGlobal.GetForceSettings( SIUnlocker.Settings.Name , forceIndex )
	end
}

SIUnlocker.TriggerTypeID =
{
	Mined       = "Mined" ,
	MinedResult = "MinedResult" ,
	Craft       = "Craft" ,
	Build       = "Build" ,
	Destroy     = "Destroy" ,
	Capsule     = "Capsule"
}
SIUnlocker.ResultTypeID =
{
	AddRecipe        = "AddRecipe"        , -- 解锁配方
	RemoveRecipe     = "RemoveRecipe"     , -- 锁定配方
	AddTechnology    = "AddTechnology"    , -- 解锁科技
	RemoveTechnology = "RemoveTechnology" , -- 锁定科技
	AddItem          = "AddItem"          , -- 添加物品 , 阵营内如果有多个玩家 , 则只有最终触发玩家会获得物品
	MessageForce     = "MessageForce"     , -- 向阵营发送消息
	MessagePlayer    = "MessagePlayer"    , -- 向最终触发的玩家发送消息
	Interface        = "Interface"          -- 执行 remote 接口函数 , 有五个参数 , 第 1 个参数是解锁数据的 ID , 第 2 个参数是保存在其中的数据包 , 第 3 个参数是触发的阵营编号 , 第 4 个参数是最终触发的玩家编号 , 第 5 个参数是当前游戏刻
}
SIUnlocker.MinedResultMode =
{
	Single = 1 ,
	Total = 2
}
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
			Init = false ,
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
		for forceIndex , force in pairs( game.forces ) do
			SIUnlocker.InitForce( forceIndex )
		end
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 功能函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	InitForce = function( forceIndex )
		local globalSettings = SIGlobal.GetGlobalSettings( SIUnlocker.Settings.Name )
		local forceSettings = SIGlobal.GetForceSettings( SIUnlocker.Settings.Name , forceIndex )
		if forceSettings.Init then
			return
		end
		forceSettings.Init = true
		for index , unlockData in pairs( globalSettings.UnlockData ) do
			local unlockDataID = unlockData.ID
			local forceUnlockData = SIUtils.table.deepcopy( unlockData )
			forceSettings.UnlockData[unlockDataID] = forceUnlockData
			for triggerType , triggerList in pairs( forceUnlockData.Triggers ) do
				local triggerIDListPack = forceSettings[triggerType]
				for triggerName , trigger in pairs( triggerList ) do
					trigger.Count = 0
					trigger.Finish = false
					local triggerIDList = triggerIDListPack[triggerName]
					if not triggerIDList then
						triggerIDList = {}
						triggerIDListPack[triggerName] = triggerIDList
					end
					table.insert( triggerIDList , unlockDataID )
				end
			end
		end
	end ,
	ResetForce = function( forceIndex )
		local forceSettings = SIGlobal.GetForceSettings( SIUnlocker.Settings.Name , forceIndex )
		forceSettings.Init = false
		forceSettings.UnlockData = {}
		for triggerTypeName , triggerType in pairs( SIUnlocker.TriggerTypeID ) do
			forceSettings[triggerType] = {}
		end
	end ,
	EffectUnlockData = function( unlockData , forceIndex , playerIndex )
		for triggerType , triggerList in pairs( unlockData.Triggers ) do
			for triggerName , trigger in pairs( triggerList ) do
				if not trigger.Finish then
					return
				end
			end
		end
		local gameTick = game.tick
		for resultIndex , result in pairs( unlockData.Results ) do
			local resultType = result.Type
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
			elseif resultType == SIUnlocker.ResultTypeID.GiveItem then
				local outItemStacks = {}
				local player = nil
				if playerIndex then
					player = game.get_player( playerIndex )
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
				else
					for itemName , count in pairs( result.Items ) do
						local itemStack = { name = itemName , count = count }
						table.insert( outItemStacks , itemStack )
					end
				end
				if #outItemStacks > 0 then
					local surface = player and player.surface or game.get_surface( "nauvis" )
					local force = game.forces[forceIndex]
					local position = force.get_spawn_position( surface )
					for index , itemStack in pairs( outItemStacks ) do
						surface.spill_item_stack( position , itemStack , true , force , false )
					end
				end
			elseif resultType == SIUnlocker.ResultTypeID.MessageForce then
				game.forces[forceIndex].print( result.Message )
			elseif resultType == SIUnlocker.ResultTypeID.MessagePlayer then
				if playerIndex then
					game.get_player( playerIndex ).print( result.Message )
				end
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

	-- ----------------------------------------
	-- 添加一个解锁数据包<br>
	-- ----------------------------------------
	-- unlockData     = 解锁数据包 , 结构见文件末尾的注释<br>
	-- ----------------------------------------
	AddUnlockData = function( unlockData )
		local globalSettings = SIGlobal.GetGlobalSettings( SIUnlocker.Settings.Name )
		local unlockDataID = unlockData.ID
		if not unlockDataID or globalSettings.UnlockData[unlockDataID] then
			return
		end
		if not unlockData.Triggers or not unlockData.Results or SITable.Size( unlockData.Triggers ) < 1 or SITable.Size( unlockData.Results ) < 1 then
			return
		end
		globalSettings.UnlockData[unlockDataID] = unlockData
		for forceIndex , forceSettings in pairs( SIGlobal.GetAllForceSettings( SIUnlocker.Settings.Name ) ) do
			local forceUnlockData = SIUtils.table.deepcopy( unlockData )
			forceSettings.UnlockData[unlockDataID] = forceUnlockData
			for triggerType , triggerList in pairs( forceUnlockData.Triggers ) do
				local triggerIDListPack = forceSettings[triggerType]
				for triggerName , trigger in pairs( triggerList ) do
					trigger.Count = 0
					trigger.Finish = false
					local triggerIDList = triggerIDListPack[triggerName]
					if not triggerIDList then
						triggerIDList = {}
						triggerIDListPack[triggerName] = triggerIDList
					end
					table.insert( triggerIDList , unlockDataID )
				end
			end
		end
	end ,

	-- ----------------------------------------
	-- 添加多个解锁数据包<br>
	-- ----------------------------------------
	-- unlockDataList = 解锁数据包数组 , 其中包含多个解锁数据包 , 结构见文件末尾的注释<br>
	-- ----------------------------------------
	AddUnlockDataList = function( unlockDataList )
		local globalSettings = SIGlobal.GetGlobalSettings( SIUnlocker.Settings.Name )
		for index , unlockData in pairs( unlockDataList ) do
			local unlockDataID = unlockData.ID
			if unlockDataID and not globalSettings.UnlockData[unlockDataID] then
				if unlockData.Triggers and unlockData.Results and SITable.Size( unlockData.Triggers ) > 0 and SITable.Size( unlockData.Results ) > 0 then
					globalSettings.UnlockData[unlockDataID] = unlockData
					for forceIndex , forceSettings in pairs( SIGlobal.GetAllForceSettings( SIUnlocker.Settings.Name ) ) do
						local forceUnlockData = SIUtils.table.deepcopy( unlockData )
						forceSettings.UnlockData[unlockDataID] = forceUnlockData
						for triggerType , triggerList in pairs( forceUnlockData.Triggers ) do
							local triggerIDListPack = forceSettings[triggerType]
							for triggerName , trigger in pairs( triggerList ) do
								trigger.Count = 0
								trigger.Finish = false
								local triggerIDList = triggerIDListPack[triggerName]
								if not triggerIDList then
									triggerIDList = {}
									triggerIDListPack[triggerName] = triggerIDList
								end
								table.insert( triggerIDList , unlockDataID )
							end
						end
					end
				end
			end
		end
	end ,

	-- ----------------------------------------
	-- 更新一个解锁数据包<br>
	-- ----------------------------------------
	-- unlockData     = 解锁数据包 , 结构见文件末尾的注释<br>
	-- ----------------------------------------
	FreshUnlockData = function( unlockData )
		local globalSettings = SIGlobal.GetGlobalSettings( SIUnlocker.Settings.Name )
		local unlockDataID = unlockData.ID
		if not unlockDataID or not globalSettings.UnlockData[unlockDataID] then
			return
		end
		if not unlockData.Triggers or not unlockData.Results or SITable.Size( unlockData.Triggers ) < 1 or SITable.Size( unlockData.Results ) < 1 then
			return
		end
		globalSettings.UnlockData[unlockDataID] = unlockData
		for forceIndex , forceSettings in pairs( SIGlobal.GetAllForceSettings( SIUnlocker.Settings.Name ) ) do
			local newForceUnlockData = SIUtils.table.deepcopy( unlockData )
			local oldForceUnlockData = forceSettings.UnlockData[unlockDataID]
			forceSettings.UnlockData[unlockDataID] = newForceUnlockData
			for triggerType , triggerList in pairs( oldForceUnlockData.Triggers ) do
				local triggerIDListPack = forceSettings[triggerType]
				for triggerName , trigger in pairs( triggerList ) do
					local triggerIDList = triggerIDListPack[triggerName]
					for index , innerUnlockDataID in pairs( triggerIDList ) do
						if innerUnlockDataID == unlockDataID then
							table.remove( triggerIDList , index )
							break
						end
					end
				end
			end
			for triggerType , newTriggerList in pairs( newForceUnlockData.Triggers ) do
				local oldTriggerList = oldForceUnlockData.Triggers[triggerType]
				local triggerIDListPack = forceSettings[triggerType]
				for triggerName , newTrigger in pairs( newTriggerList ) do
					local oldTrigger = oldTriggerList and oldTriggerList[triggerName] or nil
					newTrigger.Count = oldTrigger and oldTrigger.Count or 0
					newTrigger.Finish = oldTrigger and oldTrigger.Finish or false
					if not newTrigger.Finish then
						local triggerIDList = triggerIDListPack[triggerName]
						if not triggerIDList then
							triggerIDList = {}
							triggerIDListPack[triggerName] = triggerIDList
						end
						table.insert( triggerIDList , unlockDataID )
					end
				end
			end
		end
	end ,

	-- ----------------------------------------
	-- 更新多个解锁数据包<br>
	-- ----------------------------------------
	-- unlockDataList = 解锁数据包数组 , 其中包含多个解锁数据包 , 结构见文件末尾的注释<br>
	-- ----------------------------------------
	FreshUnlockDataList = function( unlockDataList )
		local globalSettings = SIGlobal.GetGlobalSettings( SIUnlocker.Settings.Name )
		for index , unlockData in pairs( unlockDataList ) do
			local unlockDataID = unlockData.ID
			if unlockDataID and globalSettings.UnlockData[unlockDataID] then
				if unlockData.Triggers and unlockData.Results and SITable.Size( unlockData.Triggers ) > 0 and SITable.Size( unlockData.Results ) > 0 then
					globalSettings.UnlockData[unlockDataID] = unlockData
					for forceIndex , forceSettings in pairs( SIGlobal.GetAllForceSettings( SIUnlocker.Settings.Name ) ) do
						local newForceUnlockData = SIUtils.table.deepcopy( unlockData )
						local oldForceUnlockData = forceSettings.UnlockData[unlockDataID]
						forceSettings.UnlockData[unlockDataID] = newForceUnlockData
						for triggerType , triggerList in pairs( oldForceUnlockData.Triggers ) do
							local triggerIDListPack = forceSettings[triggerType]
							for triggerName , trigger in pairs( triggerList ) do
								local triggerIDList = triggerIDListPack[triggerName]
								for index , innerUnlockDataID in pairs( triggerIDList ) do
									if innerUnlockDataID == unlockDataID then
										table.remove( triggerIDList , index )
										break
									end
								end
							end
						end
						for triggerType , newTriggerList in pairs( newForceUnlockData.Triggers ) do
							local oldTriggerList = oldForceUnlockData.Triggers[triggerType]
							local triggerIDListPack = forceSettings[triggerType]
							for triggerName , newTrigger in pairs( newTriggerList ) do
								local oldTrigger = oldTriggerList and oldTriggerList[triggerName] or nil
								newTrigger.Count = oldTrigger and oldTrigger.Count or 0
								newTrigger.Finish = oldTrigger and oldTrigger.Finish or false
								if not newTrigger.Finish then
									local triggerIDList = triggerIDListPack[triggerName]
									if not triggerIDList then
										triggerIDList = {}
										triggerIDListPack[triggerName] = triggerIDList
									end
									table.insert( triggerIDList , unlockDataID )
								end
							end
						end
					end
				end
			end
		end
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ------ 接口函数 -- 控制 ------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------

	-- ----------------------------------------
	-- 强制解锁<br>
	-- 就算是已经解锁过的 , 依然可以重复解锁<br>
	-- ----------------------------------------
	-- forceIndex     = 阵营索引 , 不可以是阵营的名称<br>
	-- unlockDataID   = 解锁数据包的 ID<br>
	-- ----------------------------------------
	Unlock = function( forceIndex , unlockDataID )
		local forceSettings = SIGlobal.GetForceSettings( SIUnlocker.Settings.Name , forceIndex )
		local unlockData = forceSettings.UnlockData[unlockDataID]
		for triggerType , triggerList in pairs( unlockData.Triggers ) do
			local triggerIDListPack = forceSettings[triggerType]
			for triggerName , trigger in pairs( triggerList ) do
				trigger.Finish = true
				local triggerIDList = triggerIDListPack[triggerName]
				for index , innerUnlockDataID in pairs( triggerIDList ) do
					if innerUnlockDataID == unlockDataID then
						table.remove( triggerIDList , index )
						break
					end
				end
			end
		end
		SIUnlocker.EffectUnlockData( unlockData , forceIndex , nil )
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
	GiveItem         = "GiveItem"         , -- 赠予物品 , 阵营内如果有多个玩家 , 则只有最终触发玩家会获得物品
	MessageForce     = "MessageForce"     , -- 向阵营所有玩家发送一个消息
	MessagePlayer    = "MessagePlayer"    , -- 向最终触发的玩家发送一个消息
	Interface        = "Interface"          -- 执行 remote 接口函数 , 有五个参数 , 第 1 个参数是解锁数据的 ID , 第 2 个参数是保存在其中的数据包 , 第 3 个参数是触发的阵营编号 , 第 4 个参数是最终触发的玩家编号 , 可能为 nil , 第 5 个参数是当前游戏刻
}
SIUnlocker.MinedResultMode =
{
	Single = 1 ,
	Total = 2
}

-- ----------------------------------------
-- 注意 :
-- 1. ID 不可以为 nil
-- 2. Triggers 和 Results 不能为空 , 且长度不能小于 1
-- ----------------------------------------
-- 解锁数据包的数据结构如下 :
-- ID          = "解锁数据包的 ID , 用于各种事件判断" ,
-- Name        = { "解锁数据包的名称 , 本地化字符串" } ,
-- Description = { "解锁数据包的名称 , 本地化字符串" } ,
-- Triggers =    -- 触发器列表 , 需要满足所有触发器的条件 , 才会执行解锁操作
-- {
--     Mined =
--     {
--          ["实体原型的 name 属性值"] =
--          {
--              Max = 数字    -- 需要挖掘的这种实体的数量 , 实际挖掘的数量要超过这个值才算完成 , 也就是说要求挖 1 个实体 , 这里要填写 0 , 最少要求挖 1 个实体
--          }
--     } ,
--     MinedResult =
--     {
--          ["物品原型的 name 属性值"] =
--          {
--              Max = 数字    -- 需要挖掘出来的这种物品的数量 , 实际挖掘出来的数量要超过这个值才算完成 , 也就是说要求挖 1 个物品 , 这里要填写 0 , 最少要求挖 1 个物品
--              Mode = 数字   -- 需填写 SIUnlocker.MinedResultMode 的值之一 , 默认 SIUnlocker.MinedResultMode.Single , 决定记录实际挖到的数量还是只计算 1 次
--          }
--     } ,
--     Craft =
--     {
--          ["配方原型的 name 属性值"] =
--          {
--              Max = 数字    -- 需要手搓的这种配方的数量 , 实际手搓的数量要超过这个值才算完成 , 也就是说要求错 1 遍配方 , 这里要填写 0 , 最少要求搓 1 遍配方
--          }
--     } ,
--     Build =
--     {
--          ["实体原型的 name 属性值"] =
--          {
--              Max = 数字    -- 需要建造的这种实体的数量 , 实际建造的数量要超过这个值才算完成 , 也就是说要求铺 1 个实体 , 这里要填写 0 , 最少要求铺 1 个实体
--          }
--     } ,
--     Destroy =
--     {
--          ["实体原型的 name 属性值"] =
--          {
--              Max = 数字    -- 需要摧毁的这种实体的数量 , 实际摧毁的数量要超过这个值才算完成 , 也就是说要求崩 1 个实体 , 这里要填写 0 , 最少要求崩 1 个实体
--          }
--     } ,
--     Capsule =
--     {
--          ["胶囊物品原型的 name 属性值"] =
--          {
--              Max = 数字    -- 需要投掷的这种胶囊物品的数量 , 实际投掷的数量要超过这个值才算完成 , 也就是说要求扔 1 个胶囊物品 , 这里要填写 0 , 最少要求扔 1 个胶囊物品
--          }
--     }
-- } ,
-- Results =    -- 成功触发后 , 解锁的内容 , 不同于 Trigger , 这是一个数组 , 由 Type 属性决定类型 , Type 值取自 SIUnlocker.ResultTypeID , 无 Type 则无实际效果 , 以下是每种类型的栗子
-- {
--     {
--         Type = SIUnlocker.ResultTypeID.AddRecipe , -- 解锁配方
--         Recipes =                                  -- 配方原型的 name 值数组 , 位于其中的配方都会被解锁 , 无论是否符合时宜
--         {
--             "配方原型的 name 值 1" ,
--             "配方原型的 name 值 2"
--         }
--     } ,
--     {
--         Type = SIUnlocker.ResultTypeID.RemoveRecipe , -- 锁定配方
--         Recipes =                                     -- 配方原型的 name 值数组 , 位于其中的配方都会被重新锁定 , 无法使用 , 即使已经研究了相关的科技
--         {
--             "配方原型的 name 值 1" ,
--             "配方原型的 name 值 2"
--         }
--     } ,
--     {
--         Type = SIUnlocker.ResultTypeID.AddTechnology , -- 解锁科技 , 可能会与 SIConfigs.SIOverhaul.HideTechnology 项冲突 , 记得把这些科技加入黑名单
--         Technologies =                                 -- 科技原型的 name 值数组 , 位于其中的科技都会被解锁 , 解锁意味着它可以被研究 , 并非直接研究完成
--         {
--             "科技原型的 name 值 1" ,
--             "科技原型的 name 值 2"
--         }
--     } ,
--     {
--         Type = SIUnlocker.ResultTypeID.RemoveTechnology , -- 锁定科技 , 锁定的科技会被隐藏 , 无法直接查看 , 可能会与 SIConfigs.SIOverhaul.HideTechnology 项冲突 , 记得把这些科技加入黑名单
--         Technologies =                                    -- 科技原型的 name 值数组 , 位于其中的科技都会被锁定 , 锁定意味着它无法被研究 , 已研究完成的不受影响
--         {
--             "科技原型的 name 值 1" ,
--             "科技原型的 name 值 2"
--         }
--     } ,
--     {
--         Type = SIUnlocker.ResultTypeID.GiveItem , -- 赠予物品
--         Items =                                   -- 物品原型的 name 值数组 , 它们会被塞进最后触发的那个玩家的背包中 , 如果背包满了或玩家不存在 , 则会把它们丢在阵营的出生点的地上
--         {
--             "物品原型的 name 值 1" ,
--             "物品原型的 name 值 2"
--         }
--     } ,
--     {
--         Type = SIUnlocker.ResultTypeID.MessageForce , -- 向阵营所有玩家发送一个消息
--         Message = { "本地化字符串" }
--     } ,
--     {
--         Type = SIUnlocker.ResultTypeID.MessagePlayer , -- 向最终触发的玩家发送一个消息 , 如果玩家不存在则取消发送
--         Message = { "本地化字符串" }
--     } ,
--     {
--         Type = SIUnlocker.ResultTypeID.Interface , -- 执行 remote 接口函数 , 有五个参数 , 第 1 个参数是解锁数据的 ID , 第 2 个参数是保存在其中的数据包 , 第 3 个参数是触发的阵营编号 , 第 4 个参数是最终触发的玩家编号 , 可能为 nil , 第 5 个参数是当前游戏刻
--         RemoteInterfaceID = "remote 接口函数集的名称" ,
--         RemoteFunctionName = "remote 接口函数的名称"
--     }
-- }
-- ----------------------------------------
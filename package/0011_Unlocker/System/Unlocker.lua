---@class SIUnlocker : SIBaseClass
SIUnlocker =
{
	ID = "Unlocker" ,
	Code = "Unlocker" ,
	Show = "触发解锁" ,
	InterfaceID = "SIUnlocker" ,
	Settings =
	{
		Name = "SIUnlocker" ,
		DefaultGlobal =
		{
			UnlockData = {} ,
			SavedForceEffects = {}
		} ,
		DefaultForce =
		{
			Init = false ,
			UnlockData = {} ,
			-- 分类触发条件
			Mined = {} ,
			MinedResult = {} ,
			Craft = {} ,
			Build = {} ,
			Destroy = {} ,
			Capsule = {}
		}
	} ,
	DefaultMessage_AddRecipe = { "SIUnlocker.添加配方" } ,
	DefaultMessage_AddTechnology = { "SIUnlocker.添加科技" } ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 初始化 ==========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	InitData = function()
		for forceIndex , force in pairs( game.forces ) do
			SIUnlocker.InitForce( forceIndex )
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 功能函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	InitForce = function( forceIndex )
		local globalSettings = SIGlobal.GetGlobalSettings( SIUnlocker.Settings.Name )
		local forceSettings = SIGlobal.GetForceSettings( SIUnlocker.Settings.Name , forceIndex )
		if forceSettings.Init then
			return
		end
		forceSettings.Init = true
		for index , unlockData in pairs( globalSettings.UnlockData ) do
			local forceUnlockData = SIUtils.table.deepcopy( unlockData )
			forceSettings.UnlockData[unlockData.ID] = forceUnlockData
			SIUnlocker.InitUnlockData( forceSettings , forceUnlockData )
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
	InitUnlockData = function( forceSettings , unlockData )
		local unlockDataID = unlockData.ID
		unlockData.FireCount = unlockData.FireCount or 0
		for triggerType , triggerList in pairs( unlockData.Triggers ) do
			local triggerIDListPack = forceSettings[triggerType]
			for triggerName , triggerData in pairs( triggerList ) do
				triggerData.Count = 0
				triggerData.TotalCount = triggerData.TotalCount or 0
				triggerData.Finish = false
				local triggerIDList = triggerIDListPack[triggerName]
				if not triggerIDList then
					triggerIDList = {}
					triggerIDListPack[triggerName] = triggerIDList
				end
				table.insert( triggerIDList , unlockDataID )
			end
		end
	end ,
	MergeUnlockData = function( forceSettings , newUnlockData , oldUnlockData )
		local unlockDataID = newUnlockData.ID
		newUnlockData.FireCount = oldUnlockData.FireCount or newUnlockData.FireCount or 0
		for triggerType , triggerList in pairs( oldUnlockData.Triggers ) do
			local triggerIDListPack = forceSettings[triggerType]
			for triggerName , triggerData in pairs( triggerList ) do
				SITable.Remove( triggerIDListPack[triggerName] , unlockDataID )
			end
		end
		for triggerType , newTriggerList in pairs( newUnlockData.Triggers ) do
			local oldTriggerList = oldUnlockData.Triggers[triggerType]
			local triggerIDListPack = forceSettings[triggerType]
			for triggerName , newTriggerData in pairs( newTriggerList ) do
				local oldTriggerData = oldTriggerList and oldTriggerList[triggerName] or nil
				newTriggerData.Count = oldTriggerData and oldTriggerData.Count or 0
				newTriggerData.TotalCount = oldTriggerData and oldTriggerData.TotalCount or newTriggerData.TotalCount or 0
				newTriggerData.Finish = oldTriggerData and oldTriggerData.Finish or false
				if not newTriggerData.Finish then
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
	EffectUnlockData = function( unlockData , forceIndex , playerIndex )
		for triggerType , triggerList in pairs( unlockData.Triggers ) do
			for triggerName , triggerData in pairs( triggerList ) do
				if not triggerData.Finish then
					return
				end
			end
		end
		unlockData.FireCount = unlockData.FireCount + 1
		local globalSettings = SIGlobal.GetGlobalSettings( SIUnlocker.Settings.Name )
		local gameTick = game.tick
		for resultIndex , result in pairs( unlockData.Results ) do
			local resultType = result.Type
			if resultType == SIUnlocker.ResultTypeID.AddRecipe then
				local force = game.forces[forceIndex]
				for index , recipeName in pairs( result.Recipes ) do
					local recipe = force.recipes[recipeName]
					if recipe then
						recipe.enabled = true
					else
						SIPrint.Debug{ "SIUnlocker.无效配方" , recipeName }
						table.insert( globalSettings.SavedForceEffects ,
						{
							Type = SIUnlocker.ResultTypeID.AddRecipe ,
							Force = forceIndex ,
							Thing = recipeName
						} )
					end
				end
			elseif resultType == SIUnlocker.ResultTypeID.RemoveRecipe then
				local force = game.forces[forceIndex]
				for index , recipeName in pairs( result.Recipes ) do
					local recipe = force.recipes[recipeName]
					if recipe then
						recipe.enabled = false
					else
						SIPrint.Debug{ "SIUnlocker.无效配方" , recipeName }
						table.insert( globalSettings.SavedForceEffects ,
						{
							Type = SIUnlocker.ResultTypeID.RemoveRecipe ,
							Force = forceIndex ,
							Thing = recipeName
						} )
					end
				end
			elseif resultType == SIUnlocker.ResultTypeID.AddTechnology then
				local force = game.forces[forceIndex]
				for index , technologyName in pairs( result.Technologies ) do
					local technology = force.technologies[technologyName]
					if technology then
						technology.enabled = true
						technology.visible_when_disabled = true
					else
						SIPrint.Debug{ "SIUnlocker.无效科技" , technologyName }
						table.insert( globalSettings.SavedForceEffects ,
						{
							Type = SIUnlocker.ResultTypeID.AddTechnology ,
							Force = forceIndex ,
							Thing = technologyName
						} )
					end
				end
			elseif resultType == SIUnlocker.ResultTypeID.RemoveTechnology then
				local force = game.forces[forceIndex]
				for index , technologyName in pairs( result.Technologies ) do
					local technology = force.technologies[technologyName]
					if technology then
						technology.enabled = false
						technology.visible_when_disabled = false
					else
						SIPrint.Debug{ "SIUnlocker.无效科技" , technologyName }
						table.insert( globalSettings.SavedForceEffects ,
						{
							Type = SIUnlocker.ResultTypeID.RemoveTechnology ,
							Force = forceIndex ,
							Thing = technologyName
						} )
					end
				end
			elseif resultType == SIUnlocker.ResultTypeID.GiveItem then
				local outItemStacks = {}
				local player = nil
				if playerIndex then
					player = game.get_player( playerIndex )
					local inventory = player.get_main_inventory()
					for itemName , count in pairs( result.Items ) do
						local item = prototypes.item[itemName]
						if item then
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
					end
				else
					for itemName , count in pairs( result.Items ) do
						local item = prototypes.item[itemName]
						if item then
							table.insert( outItemStacks , { name = itemName , count = count } )
						end
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
				local output = result.Message
				if result.ShowTimeAndPlayer then
					local player = game.get_player( playerIndex )
					local playerName = player and player.name or { "SIUnlocker.显示玩家和时间-无玩家" }
					local day , hour , minute , second = SIDate.FormatDateByTickReal( game.tick )
					output = { "SIUnlocker.显示玩家和时间" , output , playerName , { "SICommon.实际日期" , day , hour , minute , second } }
				end
				game.forces[forceIndex].print( output )
			elseif resultType == SIUnlocker.ResultTypeID.MessagePlayer then
				if playerIndex then
					local output = result.Message
					if result.ShowTimeAndPlayer then
						local player = game.get_player( playerIndex )
						local playerName = player and player.name or { "SIUnlocker.显示玩家和时间-无玩家" }
						local day , hour , minute , second = SIDate.FormatDateByTickReal( game.tick )
						output = { "SIUnlocker.显示玩家和时间" , output , playerName , { "SICommon.实际日期" , day , hour , minute , second } }
					end
					game.get_player( playerIndex ).print( output )
				end
			elseif resultType == SIUnlocker.ResultTypeID.Interface then
				if remote.interfaces[result.RemoteInterfaceID] and remote.interfaces[result.RemoteInterfaceID][result.RemoteFunctionName] then
					remote.call( result.RemoteInterfaceID , result.RemoteFunctionName , unlockData.ID , result.Data , forceIndex , playerIndex , unlockData.FireCount , gameTick )
				end
			end
		end
	end ,
	EffectOnConfigurationChange = function()
		local globalSettings = SIGlobal.GetGlobalSettings( SIUnlocker.Settings.Name )
		local newSavedForceEffects = {}
		for index , effect in pairs( globalSettings.SavedForceEffects ) do
			local forceIndex = effect.Force
			local force = game.forces[forceIndex]
			if force then
				local effectType = effect.Type
				local thingName = effect.Thing
				if effectType == SIUnlocker.ResultTypeID.AddRecipe then
					local recipe = force.recipes[thingName]
					if recipe then
						recipe.enabled = true
					else
						SIPrint.Debug{ "SIUnlocker.无效配方" , thingName }
						table.insert( newSavedForceEffects ,
						{
							Type = SIUnlocker.ResultTypeID.AddRecipe ,
							Force = forceIndex ,
							Thing = thingName
						} )
					end
				elseif effectType == SIUnlocker.ResultTypeID.RemoveRecipe then
					local recipe = force.recipes[thingName]
					if recipe then
						recipe.enabled = false
					else
						SIPrint.Debug{ "SIUnlocker.无效配方" , thingName }
						table.insert( globalSettings.SavedForceEffects ,
						{
							Type = SIUnlocker.ResultTypeID.RemoveRecipe ,
							Force = forceIndex ,
							Thing = thingName
						} )
					end
				elseif effectType == SIUnlocker.ResultTypeID.AddTechnology then
					local technology = force.technologies[thingName]
					if technology then
						technology.enabled = true
						technology.visible_when_disabled = true
					else
						SIPrint.Debug{ "SIUnlocker.无效科技" , thingName }
						table.insert( globalSettings.SavedForceEffects ,
						{
							Type = SIUnlocker.ResultTypeID.AddTechnology ,
							Force = forceIndex ,
							Thing = thingName
						} )
					end
				elseif effectType == SIUnlocker.ResultTypeID.RemoveTechnology then
					local technology = force.technologies[thingName]
					if technology then
						technology.enabled = false
						technology.visible_when_disabled = false
					else
						SIPrint.Debug{ "SIUnlocker.无效科技" , thingName }
						table.insert( globalSettings.SavedForceEffects ,
						{
							Type = SIUnlocker.ResultTypeID.RemoveTechnology ,
							Force = forceIndex ,
							Thing = thingName
						} )
					end
				end
			end
		end
		globalSettings.SavedForceEffects = newSavedForceEffects
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 事件函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	EffectMined = function( forceIndex , playerIndex , entityName )
		local forceSettings = SIGlobal.GetForceSettings( SIUnlocker.Settings.Name , forceIndex )
		local minedDataList = forceSettings.Mined[entityName]
		if not minedDataList then
			return
		end
		for index , unlockDataID in pairs( SIUtils.table.deepcopy( minedDataList ) ) do
			local unlockData = forceSettings.UnlockData[unlockDataID]
			local triggerData = unlockData.Triggers.Mined[entityName]
			triggerData.Count = triggerData.Count + 1
			if triggerData.Count > triggerData.Max then
				triggerData.TotalCount = triggerData.TotalCount + triggerData.Count
				triggerData.Finish = true
				table.remove( minedDataList , index )
				SIUnlocker.EffectUnlockData( unlockData , forceIndex , playerIndex )
			end
		end
	end ,
	EffectMinedResult = function( forceIndex , playerIndex , itemName , count )
		local forceSettings = SIGlobal.GetForceSettings( SIUnlocker.Settings.Name , forceIndex )
		local minedResultDataList = forceSettings.MinedResult[itemName]
		if not minedResultDataList then
			return
		end
		for index , unlockDataID in pairs( SIUtils.table.deepcopy( minedResultDataList ) ) do
			local unlockData = forceSettings.UnlockData[unlockDataID]
			local triggerData = unlockData.Triggers.MinedResult[itemName]
			if triggerData.Mode == SIUnlocker.CountMode.Total then
				triggerData.Count = triggerData.Count + count
			else
				triggerData.Count = triggerData.Count + 1
			end
			if triggerData.Count > triggerData.Max then
				triggerData.TotalCount = triggerData.TotalCount + triggerData.Count
				triggerData.Finish = true
				table.remove( minedResultDataList , index )
				SIUnlocker.EffectUnlockData( unlockData , forceIndex , playerIndex )
			end
		end
	end ,
	EffectCraft = function( forceIndex , playerIndex , recipeName )
		local forceSettings = SIGlobal.GetForceSettings( SIUnlocker.Settings.Name , forceIndex )
		local craftDataList = forceSettings.Craft[recipeName]
		if not craftDataList then
			return
		end
		for index , unlockDataID in pairs( SIUtils.table.deepcopy( craftDataList ) ) do
			local unlockData = forceSettings.UnlockData[unlockDataID]
			local triggerData = unlockData.Triggers.Craft[recipeName]
			triggerData.Count = triggerData.Count + 1
			if triggerData.Count > triggerData.Max then
				triggerData.TotalCount = triggerData.TotalCount + triggerData.Count
				triggerData.Finish = true
				table.remove( craftDataList , index )
				SIUnlocker.EffectUnlockData( unlockData , forceIndex , playerIndex )
			end
		end
	end ,
	EffectBuild = function( forceIndex , playerIndex , entityName )
		local forceSettings = SIGlobal.GetForceSettings( SIUnlocker.Settings.Name , forceIndex )
		local buildDataList = forceSettings.Build[entityName]
		if not buildDataList then
			return
		end
		for index , unlockDataID in pairs( SIUtils.table.deepcopy( buildDataList ) ) do
			local unlockData = forceSettings.UnlockData[unlockDataID]
			local triggerData = unlockData.Triggers.Build[entityName]
			triggerData.Count = triggerData.Count + 1
			if triggerData.Count > triggerData.Max then
				triggerData.TotalCount = triggerData.TotalCount + triggerData.Count
				triggerData.Finish = true
				table.remove( buildDataList , index )
				SIUnlocker.EffectUnlockData( unlockData , forceIndex , playerIndex )
			end
		end
	end ,
	EffectDestroy = function( forceIndex , playerIndex , entityName )
		local forceSettings = SIGlobal.GetForceSettings( SIUnlocker.Settings.Name , forceIndex )
		local destroyDataList = forceSettings.Destroy[entityName]
		if not destroyDataList then
			return
		end
		for index , unlockDataID in pairs( SIUtils.table.deepcopy( destroyDataList ) ) do
			local unlockData = forceSettings.UnlockData[unlockDataID]
			local triggerData = unlockData.Triggers.Destroy[entityName]
			triggerData.Count = triggerData.Count + 1
			if triggerData.Count > triggerData.Max then
				triggerData.TotalCount = triggerData.TotalCount + triggerData.Count
				triggerData.Finish = true
				table.remove( destroyDataList , index )
				SIUnlocker.EffectUnlockData( unlockData , forceIndex , playerIndex )
			end
		end
	end ,
	EffectCapsule = function( forceIndex , playerIndex , itemName )
		local forceSettings = SIGlobal.GetForceSettings( SIUnlocker.Settings.Name , forceIndex )
		local capsuleDataList = forceSettings.Capsule[itemName]
		if not capsuleDataList then
			return
		end
		for index , unlockDataID in pairs( SIUtils.table.deepcopy( capsuleDataList ) ) do
			local unlockData = forceSettings.UnlockData[unlockDataID]
			local triggerData = unlockData.Triggers.Capsule[itemName]
			triggerData.Count = triggerData.Count + 1
			if triggerData.Count > triggerData.Max then
				triggerData.TotalCount = triggerData.TotalCount + triggerData.Count
				triggerData.Finish = true
				table.remove( capsuleDataList , index )
				SIUnlocker.EffectUnlockData( unlockData , forceIndex , playerIndex )
			end
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 接口函数 - 注册 =================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================<br>
	-- 添加一个解锁数据包<br>
	-- ======================================================================<br>
	---@param unlockData table -- 解锁数据包 , 其结构见文件末尾的注释
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
			SIUnlocker.InitUnlockData( forceSettings , forceUnlockData )
		end
	end ,

	-- ======================================================================<br>
	-- 添加多个解锁数据包<br>
	-- ======================================================================<br>
	---@param unlockDataList table -- 解锁数据包数组 , 其中包含多个解锁数据包 , 其结构见文件末尾的注释
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
						SIUnlocker.InitUnlockData( forceSettings , forceUnlockData )
					end
				end
			end
		end
	end ,

	-- ======================================================================<br>
	-- 更新一个解锁数据包<br>
	-- ======================================================================<br>
	---@param unlockData table -- 解锁数据包 , 其结构见文件末尾的注释
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
			SIUnlocker.MergeUnlockData( forceSettings , newForceUnlockData , oldForceUnlockData )
		end
	end ,

	-- ======================================================================<br>
	-- 更新多个解锁数据包<br>
	-- ======================================================================<br>
	---@param unlockDataList table -- 解锁数据包数组 , 其中包含多个解锁数据包 , 其结构见文件末尾的注释
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
						SIUnlocker.MergeUnlockData( forceSettings , newForceUnlockData , oldForceUnlockData )
					end
				end
			end
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 接口函数 - 控制 =================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================<br>
	-- 强制解锁<br>
	-- 就算是已经解锁过的 , 依然可以重复解锁<br>
	-- ======================================================================<br>
	---@param forceIndex integer -- 阵营索引 , 不可以是阵营的名称
	---@param unlockDataID string -- 解锁数据包的 ID
	Unlock = function( forceIndex , unlockDataID )
		local forceSettings = SIGlobal.GetForceSettings( SIUnlocker.Settings.Name , forceIndex )
		local unlockData = forceSettings.UnlockData[unlockDataID]
		for triggerType , triggerList in pairs( unlockData.Triggers ) do
			local triggerIDListPack = forceSettings[triggerType]
			for triggerName , triggerData in pairs( triggerList ) do
				triggerData.TotalCount = triggerData.TotalCount + triggerData.Count
				triggerData.Finish = true
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
	GiveItem         = "GiveItem"         , -- 赠予物品 , 阵营内如果有多个玩家 , 则只有最终触发解锁的玩家会获得物品
	MessageForce     = "MessageForce"     , -- 向阵营所有玩家发送一条消息
	MessagePlayer    = "MessagePlayer"    , -- 向最终触发解锁的玩家发送一条消息
	Interface        = "Interface"          -- 执行 remote 接口函数 , 有六个参数 , 第 1 个参数是解锁数据的 ID , 第 2 个参数是保存在其中的数据包 , 第 3 个参数是触发的阵营编号 , 第 4 个参数是最终触发的玩家编号 , 可能为 nil , 第 5 个参数是触发的次数 , 第 6 个参数是当前游戏刻
}

SIUnlocker.CountMode =
{
	Single = 1 ,
	Total = 2
}

-- ======================================================================
-- 注意 :
-- 1. ID 不可以为 nil
-- 2. Triggers 和 Results 不能为空 , 且长度不能小于 1
-- ======================================================================
-- 解锁数据包的数据结构如下 :
-- ID          = "解锁数据包的 ID , 用于各种事件的判断" ,
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
--              Mode = 数字   -- 需填写 SIUnlocker.CountMode 的值之一 , 默认 SIUnlocker.CountMode.Single , 决定记录实际挖到的数量还是只计算 1 次
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
-- Results =    -- 成功触发后 , 解锁的内容 , 不同于 Triggers 表 , 这是一个数组 , 由 Type 属性决定类型 , Type 值取自 SIUnlocker.ResultTypeID , 无 Type 则无实际效果 , 以下是每种类型的栗子
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
--         Message = { "本地化字符串" } ,
--         ShowTimeAndPlayer = false
--     } ,
--     {
--         Type = SIUnlocker.ResultTypeID.MessagePlayer , -- 向最终触发的玩家发送一个消息 , 如果玩家不存在则取消发送
--         Message = { "本地化字符串" } ,
--         ShowTimeAndPlayer = false
--     } ,
--     {
--         Type = SIUnlocker.ResultTypeID.Interface , -- 执行 remote 接口函数 , 有五个参数 , 第 1 个参数是解锁数据的 ID , 第 2 个参数是保存在其中的数据包 , 第 3 个参数是触发的阵营编号 , 第 4 个参数是最终触发的玩家编号 , 可能为 nil , 第 5 个参数是触发的次数 , 第 6 个参数是当前游戏刻
--         RemoteInterfaceID = "remote 接口函数集的名称" ,
--         RemoteFunctionName = "remote 接口函数的名称"
--     }
-- }
-- ======================================================================
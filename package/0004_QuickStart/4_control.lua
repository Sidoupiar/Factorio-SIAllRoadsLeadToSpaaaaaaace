-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 定义信息 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIQuickStartSettingName = "QuickStart"
SIQuickStartMaxCheck = 16384

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 基础数据 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================<br>
-- 初始化<br>
-- ======================================================================<br>
SIGlobal.CreateSettings
{
	Name = SIQuickStartSettingName ,
	DefaultGlobal =
	{
		SendOnce = false ,
		PlayerIndex = {} ,
		ProcessList =
		{
			-- {
			-- 	SavedPlayerIndex = nil ,
			-- 	SavedPosition = { x = 0 , y = 0 } ,
			-- 	SavedForce = nil ,
			-- 	SacedSurface = nil ,
			-- 	SavedChestEntity = nil ,
			-- 	CreateCount = 0 ,
			-- 	LoopIndex = 0 ,
			-- 	ItemIndex = nil ,
			-- 	CurrentItemData = { Name = nil , CountLeft = nil , Quality = nil }
			-- }
		}
	}
}

-- ======================================================================<br>
-- 事件<br>
-- ======================================================================<br>

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 操作事件 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

function SIQuickStart_GetRandomChest( chestList , totalChestWeight )
	local currentWeight = math.random() * totalChestWeight
	for chestIndex , chestData in pairs( chestList ) do
		currentWeight = currentWeight - chestData.RandomWeight
		if currentWeight < 0 then
			return chestData
		end
	end
	return { Name = "logistic-chest-storage" , RandomWeight = 1000 , Quality = nil } -- 这是特殊情况下返回的默认值
end

function SIQuickStart_CreateChest( chestList , totalChestWeight , player , itemName , loopIndex , chestSpaceSize )
	-- 如果偏移过大则取消放置 , 限制为 128 格 , 即 4 个区块
	if loopIndex > SIQuickStartMaxCheck then
		if player and player.valid then
			player.print{ "SIQuickStart.箱子距离过远" , itemName , SICommon.Colors.Print.ORANGE }
		end
		return loopIndex , nil
	end
	local playerPosition = player.position
	local playerSurface = player.surface
	local playerForce = player.force
	-- 计算箱子的坐标
	local chestData = SIQuickStart_GetRandomChest( chestList , totalChestWeight )
	local chestPosition = nil
	local isLoopCheck = true
	while isLoopCheck do
		loopIndex = loopIndex + 1
		-- 如果偏移过大则取消放置 , 限制为 128 格 , 即 4 个区块
		if loopIndex > SIQuickStartMaxCheck then
			if player and player.valid then
				player.print{ "SIQuickStart.箱子距离过远" , itemName , SICommon.Colors.Print.ORANGE }
			end
			return loopIndex , nil
		end
		-- 计算放置坐标并检测
		local x
		local y
		local sideLength = math.ceil( ( math.sqrt( loopIndex ) - 1 ) / 2 )
		local leftIndex = loopIndex - ( sideLength - 1 ) * sideLength * 4 - 1
		local doubleLength = sideLength * 2
		if leftIndex < doubleLength then
			x = sideLength - leftIndex
			y = sideLength
		else
			leftIndex = leftIndex - doubleLength
			if leftIndex < doubleLength then
				x = -sideLength
				y = sideLength - leftIndex
			else
				leftIndex = leftIndex - doubleLength
				if leftIndex < doubleLength then
					x = leftIndex - sideLength
					y = -sideLength
				else
					x = sideLength
					y = leftIndex - doubleLength - sideLength
				end
			end
		end
		if x % chestSpaceSize ~= 0 and y % chestSpaceSize ~= 0 then
			chestPosition = { x = playerPosition.x + x , y = playerPosition.y + y}
			if playerSurface.can_place_entity{ name = chestData.Name , position = chestPosition , force = playerForce , forced = false } then
				isLoopCheck = false
			end
		end
	end
	if chestPosition then
		return loopIndex , playerSurface.create_entity{ name = chestData.Name , position = chestPosition , quality = chestData.Quality , force = playerForce , raise_built = false }
	else
		if player and player.valid then
			player.print{ "SIQuickStart.箱子距离过远" , itemName , SICommon.Colors.Print.ORANGE }
		end
		return loopIndex , nil
	end
end

function SIQuickStart_StartUp_SpawnGift( event )
	-- 取得保存的数据
	local globalSettings = SIGlobal.GetGlobalSettings( SIQuickStartSettingName )
	if #globalSettings.ProcessList < 1 then
		script.on_nth_tick( 1 , nil )
		return
	end
	local processData = globalSettings.ProcessList[1]
	local playerIndex = processData.SavedPlayerIndex
	table.remove( globalSettings.ProcessList , 1 )
	-- 检测数据
	if not SIConfigs.SIQuickStart.StartUp_ChestList then
		return
	end
	if not SIConfigs.SIQuickStart.StartUp_ItemList then
		return
	end
	-- 统计箱子列表
	local chestList = {}
	local totalChestWeight = 0
	for chestIndex , chestData in pairs( SIConfigs.SIQuickStart.StartUp_ChestList ) do
		if chestData and chestData.Name then
			local chestRandomWeight = SITools.AsNumber_Min( chestData.RandomWeight , 0 )
			if chestRandomWeight > 0 then
				totalChestWeight = totalChestWeight + chestRandomWeight
				table.insert( chestList , { Name = chestData.Name , RandomWeight = chestRandomWeight , Quality = chestData.Quality } )
			end
		end
	end
	if totalChestWeight < 1 then
		return
	end
	-- 放置物品
	local isOneChestOneItem = SIConfigs.SIQuickStart.StartUp_OneChestOneItem
	local chestSpaceSize = SITools.AsNumber( SIConfigs.SIQuickStart.StartUp_ChestSpaceSize or 8 , 2 , 32 )
	local itemCreateCount = 0
	local player = game.players[playerIndex]
	local loopIndex = 1 -- 玩家脚下的格子不判断 , 因此从第 2 个格子的索引开始处理
	local chestEntity = nil
	local chestInventory = nil
	for itemIndex , itemData in pairs( SIConfigs.SIQuickStart.StartUp_ItemList ) do
		if itemData and itemData.Name then
			local itemName = itemData.Name
			local itemPrototype = prototypes.item[itemName]
			if itemPrototype then
				local itemCountLeft = SITools.AsNumberInt_Min( itemData.Count , 0 )
				while itemCountLeft > 0 do
					if isOneChestOneItem then
						loopIndex , chestEntity = SIQuickStart_CreateChest( chestList , totalChestWeight , player , itemName , loopIndex , chestSpaceSize )
						if chestEntity then
							chestInventory = chestEntity.get_inventory( defines.inventory.chest )
							if SIConfigs.SIQuickStart.StartUp_AutoChestFilter then
								if chestEntity.type == SICommon.Types.Entities.ContainerLogic and chestEntity.prototype.logistic_mode == SICommon.Flags.LogisticMode.Storage then
									chestEntity.set_filter( 1 , { name = itemName , quality = itemData.Quality } )
								end
							end
						else
							chestInventory = nil
							itemCountLeft = 0
							if player and player.valid then
								player.print{ "SIQuickStart.未能创建合适的箱子" , itemName , SICommon.Colors.Print.ORANGE }
							end
						end
					else
						if not chestInventory or not chestInventory.can_insert{ name = itemName , count = itemCountLeft , quality = itemData.Quality } then
							loopIndex , chestEntity = SIQuickStart_CreateChest( chestList , totalChestWeight , player , itemName , loopIndex , chestSpaceSize )
							if chestEntity then
								chestInventory = chestEntity.get_inventory( defines.inventory.chest )
							else
								chestInventory = nil
								itemCountLeft = 0
								if player and player.valid then
									player.print{ "SIQuickStart.未能创建合适的箱子" , itemName , SICommon.Colors.Print.ORANGE }
								end
							end
						end
					end
					if chestInventory then
						itemCreateCount = itemCreateCount + 1
						itemCountLeft = itemCountLeft - chestInventory.insert{ name = itemName , count = itemCountLeft , quality = itemData.Quality }
					else
						itemCountLeft = 0
						if player and player.valid then
							player.print{ "SIQuickStart.未能创建合适的箱子" , itemName , SICommon.Colors.Print.ORANGE }
						end
					end
				end
			else
				if SIConfigs.SIQuickStart.ErrorWhenItemNotExist then
					if player and player.valid then
						player.print{ "SIQuickStart.不存在的物品" , itemName , SICommon.Colors.Print.RED }
					end
				end
			end
		end
	end
	if player and player.valid then
		if itemCreateCount > 0 then
			player.print( { "SIQuickStart.开局物品已送达" } , SICommon.Colors.Print.GREEN )
		else
			player.print( { "SIQuickStart.未创建开局物品" } , SICommon.Colors.Print.ORANGE )
		end
	end
end

-- ======================================================================<br>
-- 事件<br>
-- ======================================================================<br>
SIEventBus
.Add( SIEvents.on_player_joined_game , function( event , functionID )
	local playerIndex = event.player_index
	local globalSettings = SIGlobal.GetGlobalSettings( SIQuickStartSettingName )
	if SIConfigs.SIQuickStart.SendOnce then
		if globalSettings.SendOnce then
			return
		end
		globalSettings.SendOnce = true
	else
		if globalSettings.PlayerIndex[playerIndex] then
			return
		end
		globalSettings.PlayerIndex[playerIndex] = true
	end
	local processData =
	{
		SavedPlayerIndex = playerIndex ,
		SavedPosition = { x = 0 , y = 0 } ,
		SavedForce = nil ,
		SacedSurface = nil ,
		SavedChestEntity = nil ,
		CreateCount = 0 ,
		LoopIndex = 0 ,
		ItemIndex = nil ,
		CurrentItemData = { Name = nil , CountLeft = nil , Quality = nil }
	}
	table.insert( globalSettings.ProcessList , processData )
	script.on_nth_tick( 1 , nil )
	script.on_nth_tick( 1 , SIQuickStart_StartUp_SpawnGift )
end )

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 外部接口 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================<br>
-- 接口注册<br>
-- ======================================================================<br>
-- SINeed( "RemoteInterface" )
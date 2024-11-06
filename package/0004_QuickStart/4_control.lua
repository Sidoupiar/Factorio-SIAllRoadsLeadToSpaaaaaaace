-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 定义信息 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIQuickStartSettingName = "QuickStart"

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 基础数据 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================
-- 初始化
-- ======================================================================
SIGlobal.CreateSettings
{
	Name = SIQuickStartSettingName ,
	DefaultGlobal =
	{
		SendOnce = false ,
		PlayerIndex = {}
	}
}

-- ======================================================================
-- 事件
-- ======================================================================

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 操作事件 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

function SIQuickStart_GetRandomChest( chestList , totalChestWeight )
	local currentWeight = math.random() * totalChestWeight
	for chestName , chestWeight in pairs( chestList ) do
		currentWeight = currentWeight - chestWeight
		if currentWeight < 0 then
			return chestName
		end
	end
	return "logistic-chest-storage" -- 这是特殊情况下返回的默认值
end

function SIQuickStart_SpawnStartUpGift( playerIndex )
	-- 检测箱子列表
	local chestList = SIConfigs.SIQuickStart.StartUpChestList
	if not chestList then
		return
	end
	local totalChestWeight = 0
	for chestName , chestWeight in pairs( chestList ) do
		totalChestWeight = totalChestWeight + chestWeight
	end
	if totalChestWeight < 1 then
		return
	end
	-- 放置物品
	if not SIConfigs.SIQuickStart.StartUpItemList then
		return
	end
	local itemCreateCount = 0
	local player = game.players[playerIndex]
	local playerSurface = player.surface
	local playerPosition = player.position
	local playerForce = player.force
	local chestInventory = nil
	for itemName , itemCount in pairs( SIConfigs.SIQuickStart.StartUpItemList ) do
		local itemPrototype = prototypes.item[itemName]
		if itemPrototype then
			local itemCountLeft = itemCount
			while itemCountLeft > 0 do
				if SIConfigs.SIQuickStart.OneChestOneItem then
					-- 如果偏移过大则取消放置 , 限制为 1024 格 , 即 32 个区块
					-- TODO : 寻找可以放置箱子的位置
					local chestPosition = playerPosition
					if math.abs( chestPosition.X - playerPosition.X ) < 1024 and math.abs( chestPosition.Y - playerPosition.Y ) < 1024 then
						local chestName = SIQuickStart_GetRandomChest( chestList , totalChestWeight )
						local chestEntity = playerSurface.create_entity{ name = chestName , position = chestPosition , force = playerForce }
						if chestEntity then
							if SIConfigs.SIQuickStart.AutoChestFilter then
								-- TODO : 设置黄箱请求
								if chestEntity.type == SICommon.Types.Entities.ContainerLogic and chestEntity.prototype.logistic_mode == SICommon.Flags.LogisticMode.Storage then
									chestEntity.set_filter{}
								end
							end
							chestInventory = chestEntity.get_inventory( defines.inventory.chest )
						else
							chestInventory = nil
							itemCountLeft = 0
							player.print{ "SIQuickStart.未能创建合适的箱子" , itemName , SICommon.Colors.Print.ORANGE }
						end
					else
						chestInventory = nil
						itemCountLeft = 0
						player.print{ "SIQuickStart.箱子距离过远" , itemName , SICommon.Colors.Print.ORANGE }
					end
				else
					-- TODO : 如果箱子没有空间
					if not chestInventory or not chestInventory.can_insert{ name = itemName , count = itemCountLeft } then
						-- 如果偏移过大则取消放置 , 限制为 1024 格 , 即 32 个区块
						-- TODO : 寻找可以放置箱子的位置
						local chestPosition = playerPosition
						if math.abs( chestPosition.X - playerPosition.X ) < 1024 and math.abs( chestPosition.Y - playerPosition.Y ) < 1024 then
							local chestName = SIQuickStart_GetRandomChest( chestList , totalChestWeight )
							local chestEntity = playerSurface.create_entity{ name = chestName , position = chestPosition , force = playerForce }
							if chestEntity then
								chestInventory = chestEntity.get_inventory( defines.inventory.chest )
							else
								chestInventory = nil
								itemCountLeft = 0
								player.print{ "SIQuickStart.未能创建合适的箱子" , itemName , SICommon.Colors.Print.ORANGE }
							end
						else
							chestInventory = nil
							itemCountLeft = 0
							player.print{ "SIQuickStart.箱子距离过远" , itemName , SICommon.Colors.Print.ORANGE }
						end
					end
				end
				if chestInventory then
					itemCreateCount = itemCreateCount + 1
					itemCountLeft = itemCountLeft - chestInventory.insert{ name = itemName , count = itemCountLeft }
				else
					itemCountLeft = 0
					player.print{ "SIQuickStart.未能创建合适的箱子" , itemName , SICommon.Colors.Print.ORANGE }
				end
			end
		else
			if SIConfigs.SIQuickStart.ErrorWhenItemNotExist then
				player.print{ "SIQuickStart.不存在的物品" , itemName , SICommon.Colors.Print.RED }
			end
		end
	end
	if itemCreateCount > 0 then
		player.print( { "SIQuickStart.开局物品已送达" } , SICommon.Colors.Print.GREEN )
	end
end

-- ======================================================================
-- 事件
-- ======================================================================
SIEventBus
.Add( SIEvents.on_player_joined_game , function( event , functionID )
	local playerIndex = event.player_index
	local globalSettings = SIGlobal.GetGlobalSettings( SIQuickStartSettingName )
	if SIConfigs.SIQuickStart.SendOnce then
		if not globalSettings.SendOnce then
			globalSettings.SendOnce = true
			SIQuickStart_SpawnStartUpGift( playerIndex )
		end
	else
		if not globalSettings.PlayerIndex[playerIndex] then
			globalSettings.PlayerIndex[playerIndex] = true
			SIQuickStart_SpawnStartUpGift( playerIndex )
		end
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
-- SINeed( "RemoteInterface" )
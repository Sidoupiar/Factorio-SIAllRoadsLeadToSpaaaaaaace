-- ------------------------------------------------------------------------------------------------
-- ----- 修改部分实体的属性 -----------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local function AppendFlag( prototypeData , newFlag )
	local flags = prototypeData.flags
	if flags then
		if not SITable.Has( flags , newFlag ) then
			table.insert( flags , newFlag )
		end
	else
		prototypeData.flags = { newFlag }
	end
end

SIGen
-- 修改水蒸气的最高温度
-- 此项不可以禁用或删除
.Find( SICommon.Types.Fluid , "steam" , function( prototypeName , prototypeData )
	if prototypeData then
		prototypeData.max_temperature = 5000
	end
end )

-- 修改树木血量
if SIConfigs.SIOverhaul.TreeHealth then
	SIGen.ForEach( SICommon.Types.Entities.Tree , function( prototypeName , prototypeData )
		if prototypeData and prototypeData.max_health then
			prototypeData.max_health = prototypeData.max_health * 30
			prototypeData.healing_per_tick = ( prototypeData.healing_per_tick or 0.017 ) * 30
		end
	end )
end

-- ------------------------------------------------------------------------------------------------
-- ------- 降低晚上的亮度 -------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

if SIConfigs.SIOverhaul.TotalEvening then
	SIGen.Find( SICommon.Types.Constants , "default" , function( prototypeName , prototypeData )
		if prototypeData then
			prototypeData.daytime_color_lookup =
			{
				{ 0.00 , "identity" } ,
				{ 0.15 , "identity" } ,
				{ 0.20 , "identity" } ,
				{ 0.45 , SIGen.MakeRawPicturePath( "世界光线-夜晚" ) } ,
				{ 0.55 , SIGen.MakeRawPicturePath( "世界光线-夜晚" ) } ,
				{ 0.80 , "identity" } ,
				{ 0.85 , "identity" }
			}
			prototypeData.zoom_to_world_daytime_color_lookup =
			{
				{ 0.25 , "identity" } ,
				{ 0.45 , SIGen.MakeRawPicturePath( "世界光线-夜晚" ) } ,
				{ 0.55 , SIGen.MakeRawPicturePath( "世界光线-夜晚" ) } ,
				{ 0.75 , "identity" }
			}
		end
	end )
end

-- ------------------------------------------------------------------------------------------------
-- ---- 修改虫子尸体存在时间 ----------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

if SIConfigs.SIOverhaul.EnemyCorpseDuration then
	SIGen.ForEach( SICommon.Types.Entities.Unit , function( unitPrototypeName , unitPrototypeData )
		if unitPrototypeData and unitPrototypeData.corpse then
			SIGen.Find( SICommon.Types.Entities.Corpse , unitPrototypeData.corpse , function( corpsePrototypeName , corpsePrototypeData )
				if corpsePrototypeData then
					local realDuration = math.min( corpsePrototypeData.time_before_removed , SIConfigs.SIOverhaul.EnemyCorpseDuration )
					corpsePrototypeData.time_before_removed = realDuration
					if corpsePrototypeData.ground_patch_fade_out_start then
						corpsePrototypeData.ground_patch_fade_out_start = realDuration / 16
					end
					if corpsePrototypeData.ground_patch_fade_out_duration then
						corpsePrototypeData.ground_patch_fade_out_duration = realDuration / 40
					end
				end
			end )
		end
	end )
end

-- ------------------------------------------------------------------------------------------------
-- ------- 调整物品的堆叠 -------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

if SIConfigs.SIOverhaul.ItemStackSizeModify and SIConfigs.SIOverhaul.ItemStackSizeModify.Enable then
	local config = SIConfigs.SIOverhaul.ItemStackSizeModify
	-- ----------------------------------------
	-- 倍率修改堆叠
	-- ----------------------------------------
	if config.EnableItemStackSizeMultiplier and config.ItemStackSizeMultiplier then
		local min = config.ItemStackSizeMultiplier.Min == 0 and SICommon.Numbers.StackSizeMin or SITools.AsNumberInt( config.ItemStackSizeMultiplier.Min , SICommon.Numbers.StackSizeMin , SICommon.Numbers.StackSizeMax )
		local max = config.ItemStackSizeMultiplier.Max == 0 and SICommon.Numbers.StackSizeMax or SITools.AsNumberInt( config.ItemStackSizeMultiplier.Max , SICommon.Numbers.StackSizeMin , SICommon.Numbers.StackSizeMax )
		min = math.min( min , max )
		local multiplier = config.ItemStackSizeMultiplier.Multiplier == 0 and 1 or SITools.AsNumber( config.ItemStackSizeMultiplier.Multiplier , SICommon.Numbers.MultiplierMin , SICommon.Numbers.MultiplierMax )
		if config.ItemStackSizeMultiplier.TypeList then
			for itemType , itemTypeMultiplier in pairs( config.ItemStackSizeMultiplier.TypeList ) do
				local itemStackSizeMultiplier = SITools.AsNumber( itemTypeMultiplier , SICommon.Numbers.MultiplierMin , SICommon.Numbers.MultiplierMax )
				if itemStackSizeMultiplier == 0 then
					itemStackSizeMultiplier = multiplier
				end
				if itemStackSizeMultiplier > 0 and itemStackSizeMultiplier ~= 1 then
					SIGen.ForEach( itemType , function( prototypeName , prototypeData )
						if prototypeData then
							local itemStackSize = SITools.Round( math.floor( ( prototypeData.stack_size or 1 ) * itemStackSizeMultiplier ) , min , max )
							if config.IgnoreCannotStack then
								if itemStackSize == 1 or not prototypeData.flags or not SITable.Has( prototypeData.flags , SICommon.Flags.Item.NotStackable ) then
									prototypeData.stack_size = itemStackSize
									if prototypeData.default_request_amount then
										prototypeData.default_request_amount = math.min( prototypeData.default_request_amount , itemStackSize )
									end
								end
							else
								if itemStackSize > 1 and prototypeData.flags then
									while SITable.Has( prototypeData.flags , SICommon.Flags.Item.NotStackable ) do
										SITable.Remove( prototypeData.flags , SICommon.Flags.Item.NotStackable )
									end
								end
								prototypeData.stack_size = itemStackSize
								if prototypeData.default_request_amount then
									prototypeData.default_request_amount = math.min( prototypeData.default_request_amount , itemStackSize )
								end
							end
						end
					end )
				end
			end
		end
	end
	-- ----------------------------------------
	-- 加法修改堆叠
	-- ----------------------------------------
	if config.EnableItemStackSizeAddition and config.ItemStackSizeAddition then
		local min = config.ItemStackSizeAddition.Min == 0 and SICommon.Numbers.StackSizeMin or SITools.AsNumberInt( config.ItemStackSizeAddition.Min , SICommon.Numbers.StackSizeMin , SICommon.Numbers.StackSizeMax )
		local max = config.ItemStackSizeAddition.Max == 0 and SICommon.Numbers.StackSizeMax or SITools.AsNumberInt( config.ItemStackSizeAddition.Max , SICommon.Numbers.StackSizeMin , SICommon.Numbers.StackSizeMax )
		min = math.min( min , max )
		local addition = SITools.AsNumberInt( config.ItemStackSizeAddition.Addition , SICommon.Numbers.StackSizeAdditionMin , SICommon.Numbers.StackSizeAdditionMax )
		if config.ItemStackSizeAddition.TypeList then
			for itemType , itemTypeAddition in pairs( config.ItemStackSizeAddition.TypeList ) do
				local itemStackSizeAddition = SITools.AsNumberInt( itemTypeAddition , SICommon.Numbers.StackSizeAdditionMin , SICommon.Numbers.StackSizeAdditionMax )
				if itemStackSizeAddition == 0 then
					itemStackSizeAddition = addition
				end
				if itemStackSizeAddition ~= 0 then
					SIGen.ForEach( itemType , function( prototypeName , prototypeData )
						if prototypeData then
							local itemStackSize = SITools.Round( math.floor( ( prototypeData.stack_size or 1 ) + itemStackSizeAddition ) , min , max )
							if config.IgnoreCannotStack then
								if itemStackSize == 1 or not prototypeData.flags or not SITable.Has( prototypeData.flags , SICommon.Flags.Item.NotStackable ) then
									prototypeData.stack_size = itemStackSize
									if prototypeData.default_request_amount then
										prototypeData.default_request_amount = math.min( prototypeData.default_request_amount , itemStackSize )
									end
								end
							else
								if itemStackSize > 1 and prototypeData.flags then
									while SITable.Has( prototypeData.flags , SICommon.Flags.Item.NotStackable ) do
										SITable.Remove( prototypeData.flags , SICommon.Flags.Item.NotStackable )
									end
								end
								prototypeData.stack_size = itemStackSize
								if prototypeData.default_request_amount then
									prototypeData.default_request_amount = math.min( prototypeData.default_request_amount , itemStackSize )
								end
							end
						end
					end )
				end
			end
		end
	end
	-- ----------------------------------------
	-- 单独修改堆叠
	-- ----------------------------------------
	if config.EnableItemStackSizeList and config.ItemStackSizeList then
		for itemType , itemList in pairs( config.ItemStackSizeList ) do
			if itemList then
				for itemName , stackSize in pairs( itemList ) do
					SIGen.Find( itemType , itemName , function( prototypeName , prototypeData )
						if prototypeData then
							local itemStackSize = SITools.AsNumberInt( math.floor( stackSize ) , SICommon.Numbers.StackSizeMin , SICommon.Numbers.StackSizeMax )
							if config.IgnoreCannotStack then
								if itemStackSize == 1 or not prototypeData.flags or not SITable.Has( prototypeData.flags , SICommon.Flags.Item.NotStackable ) then
									prototypeData.stack_size = itemStackSize
									if prototypeData.default_request_amount then
										prototypeData.default_request_amount = math.min( prototypeData.default_request_amount , itemStackSize )
									end
								end
							else
								if itemStackSize > 1 and prototypeData.flags then
									while SITable.Has( prototypeData.flags , SICommon.Flags.Item.NotStackable ) do
										SITable.Remove( prototypeData.flags , SICommon.Flags.Item.NotStackable )
									end
								end
								prototypeData.stack_size = itemStackSize
								if prototypeData.default_request_amount then
									prototypeData.default_request_amount = math.min( prototypeData.default_request_amount , itemStackSize )
								end
							end
						elseif config.ErrorWhenItemNotExist then
							E( "不存在的物品 : " .. itemName )
						end
					end )
				end
			end
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ----- 其他形式的数值修改 -----------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

if SIConfigs.SIOverhaul.ItemPropertyModify and SIConfigs.SIOverhaul.ItemPropertyModify.Enable then
	local config = SIConfigs.SIOverhaul.ItemPropertyModify
	-- 维修工具耐久度倍率
	if config.RepairToolDurabilityMultiplier then
		local multiplier = SITools.AsNumber( config.RepairToolDurabilityMultiplier , SICommon.Numbers.MultiplierMin , SICommon.Numbers.MultiplierMax )
		if multiplier > 0 and multiplier ~= 1 then
			SIGen.ForEach( SICommon.Types.Items.ToolRepair , function( prototypeName , prototypeData )
				if prototypeData then
					prototypeData.durability = SITools.Round( ( prototypeData.durability or 1 ) * multiplier , SICommon.Numbers.DurabilityMin , SICommon.Numbers.DurabilityMax )
				end
			end )
		end
	end
	-- 维修工具维修速度倍率
	if config.RepairToolSpeedMultiplier then
		local multiplier = SITools.AsNumber( config.RepairToolSpeedMultiplier , SICommon.Numbers.MultiplierMin , SICommon.Numbers.MultiplierMax )
		if multiplier > 0 and multiplier ~= 1 then
			SIGen.ForEach( SICommon.Types.Items.ToolRepair , function( prototypeName , prototypeData )
				if prototypeData then
					prototypeData.speed = SITools.Round( ( prototypeData.speed or 1 ) * multiplier , SICommon.Numbers.SpeedMin , SICommon.Numbers.SpeedMax )
				end
			end )
		end
	end
	-- 工具 ( 科技包 ) 耐久度倍率
	if config.ToolDurabilityMultiplier then
		local multiplier = SITools.AsNumber( config.ToolDurabilityMultiplier , SICommon.Numbers.MultiplierMin , SICommon.Numbers.MultiplierMax )
		if multiplier > 0 and multiplier ~= 1 then
			SIGen.ForEach( SICommon.Types.Items.Tool , function( prototypeName , prototypeData )
				if prototypeData then
					prototypeData.durability = SITools.Round( ( prototypeData.durability or 1 ) * multiplier , SICommon.Numbers.DurabilityMin , SICommon.Numbers.DurabilityMax )
				end
			end )
		end
	end
	-- 研究球速度倍率
	if config.LabSpeedMultiplier then
		local multiplier = SITools.AsNumber( config.LabSpeedMultiplier , SICommon.Numbers.MultiplierMin , SICommon.Numbers.MultiplierMax )
		if multiplier > 0 and multiplier ~= 1 then
			SIGen.ForEach( SICommon.Types.Entities.Lab , function( prototypeName , prototypeData )
				if prototypeData then
					prototypeData.researching_speed = SITools.Round( ( prototypeData.researching_speed or 1 ) * multiplier , SICommon.Numbers.SpeedMin , SICommon.Numbers.SpeedMax )
				end
			end )
		end
	end
	-- 子弹弹夹数量倍率
	if config.MagazineAmmoSizeMultiplier then
		local multiplier = SITools.AsNumber( config.MagazineAmmoSizeMultiplier , SICommon.Numbers.MultiplierMin , SICommon.Numbers.MultiplierMax )
		if multiplier > 0 and multiplier ~= 1 then
			SIGen.ForEach( SICommon.Types.Items.Ammo , function( prototypeName , prototypeData )
				if prototypeData then
					prototypeData.magazine_size = SITools.Round( math.floor( ( prototypeData.magazine_size or 1 ) * multiplier ) , SICommon.Numbers.StackSizeMin , SICommon.Numbers.StackSizeMax )
				end
			end )
		end
	end
	-- 电路接线距离倍率
	if config.CircuitDistanceMultiplier then
		local multiplier = SITools.AsNumber( config.CircuitDistanceMultiplier , SICommon.Numbers.MultiplierMin , SICommon.Numbers.MultiplierMax )
		if multiplier > 0 and multiplier ~= 1 then
			SIGen.ForEachType( SICommon.Types.HealthEntities , function( prototypeName , prototypeData )
				if prototypeData and prototypeData.circuit_wire_max_distance then
					prototypeData.circuit_wire_max_distance = SITools.Round( math.floor( prototypeData.circuit_wire_max_distance * multiplier ) , SICommon.Numbers.DistanceMin , SICommon.Numbers.DistanceMax )
				end
			end )
		end
	end
	-- 地下传送带距离倍率
	if config.UndergrundBeltDistanceMultiplier then
		local multiplier = SITools.AsNumber( config.UndergrundBeltDistanceMultiplier , SICommon.Numbers.MultiplierMin , SICommon.Numbers.MultiplierMax )
		if multiplier > 0 and multiplier ~= 1 then
			SIGen.ForEach( SICommon.Types.Entities.BeltGround , function( prototypeName , prototypeData )
				if prototypeData then
					prototypeData.max_distance = SITools.Round( math.floor( ( prototypeData.max_distance or 1 ) * multiplier ) , SICommon.Numbers.DistanceMin , SICommon.Numbers.DistanceMax )
				end
			end )
		end
	end
	-- 地下管道距离倍率
	if config.UndergrundPipeDistanceMultiplier then
		local multiplier = SITools.AsNumber( config.UndergrundPipeDistanceMultiplier , SICommon.Numbers.MultiplierMin , SICommon.Numbers.MultiplierMax )
		if multiplier > 0 and multiplier ~= 1 then
			SIGen.ForEach( SICommon.Types.Entities.PipeGround , function( prototypeName , prototypeData )
				if prototypeData then
					for index , pipeData in pairs( prototypeData.fluid_box.pipe_connections ) do
						if pipeData.max_underground_distance then
							pipeData.max_underground_distance = SITools.Round( math.floor( pipeData.max_underground_distance * multiplier ) , SICommon.Numbers.DistanceMin , SICommon.Numbers.DistanceMax )
						end
					end
				end
			end )
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ------ 显示物品堆叠数量 ------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

if SIConfigs.SIOverhaul.ShowItemStackData then
	local forceFlag = SIConfigs.SIOverhaul.ShowItemStackDataForce
	SIGen.ForEachType( SICommon.Types.StackableItems , function( prototypeName , prototypeData )
		if prototypeData then
			local localDescription = prototypeData.localised_description
			if not localDescription then
				if prototypeData.place_result then
					SIGen.ForEach( SICommon.Types.Entities , function( entityPrototypeName , entityPrototypeData )
						if entityPrototypeName == prototypeData.place_result and entityPrototypeData then
							localDescription = entityPrototypeData.localised_description or { "entity-description." .. entityPrototypeName }
						end
					end )
				end
			end
			prototypeData.localised_description =
			{
				"SICommon.物品信息" ,
				localDescription or forceFlag and { "SICommon.物品信息-无" } or { "item-description." .. prototypeName } ,
				prototypeData.stack_size or 1
			}
		end
	end )
end

-- ------------------------------------------------------------------------------------------------
-- ------ 修改原版 UI 样式 ------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local function SetStyleProperty( style , propertyID , value )
	if style and style[propertyID] then
		style[propertyID] = value
	end
end

SIGen
-- 此项不可以禁用或删除
.Find( SICommon.Types.Style , "default" , function( prototypeName , prototypeData )
	if prototypeData then
		-- 修改弹出说明的窗口的最大宽度
		SetStyleProperty( prototypeData.tooltip_title_label , "maximal_width" , 406 )
		SetStyleProperty( prototypeData.tooltip_label , "maximal_width" , 406 )
		-- 修改插件槽列表的最大高度
		SetStyleProperty( prototypeData.module_inventory_scroll_pane , "maximal_height" , 350 )
		-- 修改装甲模块区域的最大宽度
		SetStyleProperty( prototypeData.horizontally_limited_equipment_grid_scroll_pane , "maximal_width" , 812 )
	end
end )

-- 此项不可以禁用或删除
.Find( SICommon.Types.Constants , "default" , function( prototypeName , prototypeData )
	if prototypeData then
		-- 修改配方栏的宽度以及每行的配方数量 (包括筛选器)
		local filterLine = SISettings.Startup.SIOverhaul.ChangeFilterLine() or 20
		prototypeData.select_group_row_count = math.floor( filterLine * 0.6 + 0.001 )
		prototypeData.select_slot_row_count = filterLine
		-- 修改背包每行的格子数量
		prototypeData.inventory_width = SISettings.Startup.SIOverhaul.ChangeInventoryLine() or 15
		-- 修改插件槽每行的格子数量
		prototypeData.module_inventory_width = SISettings.Startup.SIOverhaul.ChangeModuleLine() or 15
	end
end )

-- ------------------------------------------------------------------------------------------------
-- ---------- 隐藏科技 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

if SIConfigs.SIOverhaul.HideTechnology then
	SIGen.ForEachInner( SICommon.Types.Technology , function( prototypeName , prototypeData )
		if prototypeData then
			if SIConfigs.SIOverhaul.HideTechnologyBlackList[prototypeName] then
				return
			end
			if not prototypeData.SIGenData then
				return
			end
			if not prototypeData.prerequisites or #prototypeData.prerequisites < 1 then
				return
			end
			prototypeData.enabled = false
			prototypeData.visible_when_disabled = false
		end
	end )
end
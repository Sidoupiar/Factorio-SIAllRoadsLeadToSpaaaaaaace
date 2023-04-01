-- ------------------------------------------------------------------------------------------------
-- ----- 修改部分实体的属性 -----------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local function ModifyBurnerSource( source )
	if source and source.type == SICommon.Flags.EnergySourceType.Burner then
		if not source.burnt_inventory_size or source.burnt_inventory_size < 1 then
			source.burnt_inventory_size = 1
		end
		if source.fuel_categories then
			if not SITable.Has( source.fuel_categories , SIConstants_Core.raw.Categories.Fuel.Special ) then
				table.insert( source.fuel_categories , SIConstants_Core.raw.Categories.Fuel.Special )
			end
		else
			if source.fuel_category then
				if source.fuel_category == SIConstants_Core.raw.Categories.Fuel.Special then
					source.fuel_categories = { SIConstants_Core.raw.Categories.Fuel.Special }
					source.fuel_category = nil
				else
					source.fuel_categories =
					{
						source.fuel_category ,
						SIConstants_Core.raw.Categories.Fuel.Special
					}
					source.fuel_category = nil
				end
			else
				source.fuel_categories = { SIConstants_Core.raw.Categories.Fuel.Special }
			end
		end
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

-- 修改燃烧炉子的产物空间 , 以及燃料类型
-- 此项不可以禁用或删除
.ForEachType( SICommon.Types.Entities , function( prototypeName , prototypeData )
	if prototypeData then
		ModifyBurnerSource( prototypeData.energy_source )
		ModifyBurnerSource( prototypeData.burner )
	end
end )

-- 修改火箭发射井的产出空间
-- 此项不可以禁用或删除
.ForEach( SICommon.Types.Entities.RocketSilo , function( prototypeName , prototypeData )
	if prototypeData and prototypeData.rocket_result_inventory_size and prototypeData.rocket_result_inventory_size < 5 then
		prototypeData.rocket_result_inventory_size = 5
	end
end )

-- 给所有模块区域添加支持的模块类型
-- 此项不可以禁用或删除
.ForEach( SICommon.Types.EquipmentGrid , function( prototypeName , prototypeData )
	if prototypeData then
		local equipmentCategories = prototypeData.equipment_categories
		if equipmentCategories then
			if not SITable.Has( equipmentCategories , SIConstants_Core.raw.Categories.Equipment.Special ) then
				table.insert( equipmentCategories , SIConstants_Core.raw.Categories.Equipment.Special )
			end
		else
			prototypeData.equipment_categories = { SIConstants_Core.raw.Categories.Equipment.Special }
		end
	end
end )

-- 修改树木血量
if SIConfigs.SIOverhaul.TreeHealth then
	SIGen.ForEach( SICommon.Types.Entities.Tree , function( prototypeName , prototypeData )
		if prototypeData and prototypeData.max_health then
			prototypeData.max_health = prototypeData.max_health * 30
		end
	end )
end

-- ------------------------------------------------------------------------------------------------
-- ------- 阻止在矿上建造 -------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

if SIConfigs.SIOverhaul.OreCollision then
	local resourceLayer = SIUtils.CollisionMask.get_first_unused_layer()
	-- 修改矿物的碰撞信息
	local resourceMaskList = SIUtils.CollisionMask.get_default_mask( SICommon.Types.Entities.Resource )
	table.insert( resourceMaskList , resourceLayer )
	SIGen.ForEachInner( SICommon.Types.Entities.Resource , function( prototypeName , prototypeData )
		if prototypeData then
			if prototypeData.collision_mask then
				if not SITable.Has( prototypeData.collision_mask , resourceLayer ) then
					table.insert( prototypeData.collision_mask , resourceLayer )
				end
			else
				prototypeData.collision_mask = resourceMaskList
			end
		end
	end )
	-- 工具函数
	local function FixNextUpgrade( upgradeEntityName , entityMask )
		SIGen.ForEachType( SICommon.Types.Entities , function( prototypeName , prototypeData )
			if prototypeName == upgradeEntityName and prototypeData then
				if prototypeData.collision_mask then
					if not SITable.Has( prototypeData.collision_mask , resourceLayer ) then
						table.insert( prototypeData.collision_mask , resourceLayer )
					end
				else
					prototypeData.collision_mask = entityMask
				end
				if prototypeData.next_upgrade then
					FixNextUpgrade( prototypeData.next_upgrade , entityMask )
				end
			end
		end )
	end
	-- 修改实体的碰撞信息
	local maskTypeList =
	{
		SICommon.Types.Entities.Boiler ,
		SICommon.Types.Entities.Generator ,
		SICommon.Types.Entities.BurnerGenerator ,
		SICommon.Types.Entities.Solar ,
		SICommon.Types.Entities.Reactor ,
		SICommon.Types.Entities.Accumulator ,
		SICommon.Types.Entities.AccumulatorInfinity ,
		SICommon.Types.Entities.Pump ,
		SICommon.Types.Entities.Furnace ,
		SICommon.Types.Entities.Machine ,
		SICommon.Types.Entities.Lab ,
		SICommon.Types.Entities.Beacon ,
		SICommon.Types.Entities.RocketSilo ,
		SICommon.Types.Entities.Belt ,
		SICommon.Types.Entities.BeltGround ,
		SICommon.Types.Entities.BeltLinked ,
		SICommon.Types.Entities.BeltLoader ,
		SICommon.Types.Entities.BeltLoaderSmall ,
		SICommon.Types.Entities.BeltSplitter ,
		SICommon.Types.Entities.Pipe ,
		SICommon.Types.Entities.PipeGround ,
		SICommon.Types.Entities.PipeHeat ,
		SICommon.Types.Entities.RailStraight ,
		SICommon.Types.Entities.RailCurved ,
		SICommon.Types.Entities.RailStop ,
		SICommon.Types.Entities.RailSign ,
		SICommon.Types.Entities.RailChain ,
		SICommon.Types.Entities.Inserter ,
		SICommon.Types.Entities.Container ,
		SICommon.Types.Entities.ContainerLogic ,
		SICommon.Types.Entities.ContainerLinked ,
		SICommon.Types.Entities.ContainerFluid ,
		SICommon.Types.Entities.Pole ,
		SICommon.Types.Entities.PowerSwitch ,
		SICommon.Types.Entities.Lamp ,
		SICommon.Types.Entities.Roboport ,
		SICommon.Types.Entities.PlayerPort ,
		SICommon.Types.Entities.Radar ,
		SICommon.Types.Entities.Wall ,
		SICommon.Types.Entities.Gate ,
		SICommon.Types.Entities.TurretAmmo ,
		SICommon.Types.Entities.TurretElectric ,
		SICommon.Types.Entities.TurretArtillery ,
		SICommon.Types.Entities.CombArithmetic ,
		SICommon.Types.Entities.CombDecider ,
		SICommon.Types.Entities.CombConstant ,
		SICommon.Types.Entities.Speaker
	}
	for index , maskType in pairs( maskTypeList ) do
		local maskList = SIUtils.CollisionMask.get_default_mask( maskType )
		table.insert( maskList , resourceLayer )
		SIGen.ForEach( maskType , function( prototypeName , prototypeData )
			if prototypeData then
				if SIConfigs.SIOverhaul.OreCollisionBlackList[prototypeName] then
					return
				end
				local entityMask = nil
				if prototypeData.collision_mask then
					if not SITable.Has( prototypeData.collision_mask , resourceLayer ) then
						table.insert( prototypeData.collision_mask , resourceLayer )
						entityMask = prototypeData.collision_mask
					end
				else
					prototypeData.collision_mask = maskList
					entityMask = maskList
				end
				if prototypeData.next_upgrade then
					FixNextUpgrade( prototypeData.next_upgrade , entityMask )
				end
			end
		end )
	end
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
				{ 0.45 , SIGen.MakeRawPicturePath( "night" ) } ,
				{ 0.55 , SIGen.MakeRawPicturePath( "night" ) } ,
				{ 0.80 , "identity" } ,
				{ 0.85 , "identity" }
			}
			prototypeData.zoom_to_world_daytime_color_lookup =
			{
				{ 0.25 , "identity" } ,
				{ 0.45 , SIGen.MakeRawPicturePath( "night" ) } ,
				{ 0.55 , SIGen.MakeRawPicturePath( "night" ) } ,
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
-- ------ 修改原版 UI 样式 ------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local function SetProperty( style , propertyID , value )
	if style and style[propertyID] then
		style[propertyID] = value
	end
end

-- 修改弹出说明的窗口的最大宽度
-- 此项不可以禁用或删除
SIGen.Find( SICommon.Types.Style , "default" , function( prototypeName , prototypeData )
	if prototypeData then
		SetProperty( prototypeData.tooltip_title_label , "maximal_width" , 406 )
		SetProperty( prototypeData.tooltip_label , "maximal_width" , 406 )
		SetProperty( prototypeData.module_inventory_scroll_pane , "maximal_height" , 350 )
		SetProperty( prototypeData.horizontally_limited_equipment_grid_scroll_pane , "maximal_width" , 408 )
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
-- ------------------------------------------------------------------------------------------------
-- - 修改炉子空间并添加燃料类型 --------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local function ModifyBurnerSource( source , callBurner )
	if source then
		if callBurner then
			if not source.type then
				source.type = SICommon.Flags.EnergySourceType.Burner
			end
		end
		if source.type == SICommon.Flags.EnergySourceType.Burner then
			if source.fuel_inventory_size and source.fuel_inventory_size < 2 then
				source.fuel_inventory_size = 2
			end
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
end

-- 修改燃烧炉子的燃料和产物空间 , 以及燃料类型
SIGen.ForEachType( SICommon.Types.Entities , function( prototypeName , prototypeData )
	if prototypeData then
		ModifyBurnerSource( prototypeData.energy_source , false )
		ModifyBurnerSource( prototypeData.burner , true )
	end
end )

-- ------------------------------------------------------------------------------------------------
-- -- 修改火箭发射井的产物空间 ---------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- 修改火箭发射井的产出空间
SIGen.ForEach( SICommon.Types.Entities.RocketSilo , function( prototypeName , prototypeData )
	if prototypeData and prototypeData.rocket_result_inventory_size and prototypeData.rocket_result_inventory_size < 5 then
		prototypeData.rocket_result_inventory_size = 5
	end
end )

-- ------------------------------------------------------------------------------------------------
-- ------- 添加特殊碰撞层 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local TankCollisionMaskLayer = SIUtils.CollisionMask.get_first_unused_layer()
local NoCollisionTypeList =
{
	[SICommon.Types.HealthEntities.Fish]           = true ,
	[SICommon.Types.HealthEntities.Market]         = true ,
	[SICommon.Types.HealthEntities.Belt]           = true ,
	[SICommon.Types.HealthEntities.BeltGround]     = true ,
	[SICommon.Types.HealthEntities.BeltLinked]     = true ,
	[SICommon.Types.HealthEntities.BeltSplitter]   = true ,
	[SICommon.Types.HealthEntities.RailStraight]   = true ,
	[SICommon.Types.HealthEntities.RailCurved]     = true ,
	[SICommon.Types.HealthEntities.SpiderVehicle]  = true ,
	[SICommon.Types.HealthEntities.SpiderLeg]      = true ,
	[SICommon.Types.HealthEntities.RobotConstruct] = true ,
	[SICommon.Types.HealthEntities.RobotLogistic]  = true ,
	[SICommon.Types.HealthEntities.RobotCombat]    = true ,
	[SICommon.Types.HealthEntities.PlayerPort]     = true
}
local MustCollisionTypeList =
{
	SICommon.Types.Entities.WagonLocomotive ,
	SICommon.Types.Entities.WagonCargo ,
	SICommon.Types.Entities.WagonFluid ,
	SICommon.Types.Entities.WagonArtillery ,
	SICommon.Types.Entities.BeltLoader ,
	SICommon.Types.Entities.BeltLoaderSmall ,
	SICommon.Types.Entities.PipeHeat
}
local TrainTypeList =
{
	SICommon.Types.Entities.WagonLocomotive ,
	SICommon.Types.Entities.WagonCargo ,
	SICommon.Types.Entities.WagonFluid ,
	SICommon.Types.Entities.WagonArtillery
}

-- 排除 MustCollisionTypeList 中的类型 , 它们会在下面独立添加碰撞层
for index , typeCode in pairs( MustCollisionTypeList ) do
	NoCollisionTypeList[typeCode] = true
end

SIGen
-- 给所有有生命值的实体添加特殊碰撞层
.ForEachType( SICommon.Types.HealthEntities , function( prototypeName , prototypeData )
	if prototypeData and not NoCollisionTypeList[prototypeData.type] then
		local collisionMask = prototypeData.collision_mask
		if not collisionMask then
			collisionMask = SIUtils.CollisionMask.get_default_mask( prototypeData.type ) or {}
			prototypeData.collision_mask = collisionMask
		end
		if SITable.Has( collisionMask , SICommon.Flags.CollisionMask.Player ) and not SITable.Has( collisionMask , TankCollisionMaskLayer ) then
			table.insert( collisionMask , TankCollisionMaskLayer )
		end
	end
end )
-- 给必须添加的实体添加特殊碰撞层
.ForEachType( MustCollisionTypeList , function( prototypeName , prototypeData )
	if prototypeData then
		local collisionMask = prototypeData.collision_mask
		if not collisionMask then
			collisionMask = SIUtils.CollisionMask.get_default_mask( prototypeData.type ) or {}
			prototypeData.collision_mask = collisionMask
		end
		if not SITable.Has( collisionMask , TankCollisionMaskLayer ) then
			table.insert( collisionMask , TankCollisionMaskLayer )
		end
	end
end )
-- 给指定坦克实体添加特殊碰撞层
.Find( SICommon.Types.Entities.Car , SIConstants_Core.raw.Entities.Tank , function( prototypeName , prototypeData )
	if prototypeData then
		local collisionMask = prototypeData.collision_mask
		if not SITable.Has( collisionMask , TankCollisionMaskLayer ) then
			table.insert( collisionMask , TankCollisionMaskLayer )
		end
	end
end )
-- 由于添加了特殊的碰撞层 , 因此火车的各个组件需要更高的选择等级 , 不然会选择不到
.ForEachType( TrainTypeList , function( prototypeName , prototypeData )
	if prototypeData then
		if not prototypeData.selection_priority or prototypeData.selection_priority < SICommon.SelectPriority.Train then
			prototypeData.selection_priority = SICommon.SelectPriority.Train
		end
	end
end )

-- ------------------------------------------------------------------------------------------------
-- ------ 添加特殊模块类型 -------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- 给所有模块区域添加支持的模块类型
SIGen.ForEach( SICommon.Types.EquipmentGrid , function( prototypeName , prototypeData )
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
-- ------------------------------------------------------------------------------------------------
-- ---------- 处理数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- 调整矿山磐岩的碰撞层
for stoneIndex = 1 , 3 , 1 do
	SIGen.Find( SICommon.Types.Entities.SimpleEntity , "Stone_" .. stoneIndex , function( prototypeName , prototypeData )
		if prototypeData then
			local mask = prototypeData.collision_mask
			if mask then
				if not SITable.Has( mask , SICommon.Flags.CollisionMask.NotCollidingWithItself ) then
					table.insert( mask , SICommon.Flags.CollisionMask.NotCollidingWithItself )
				end
			else
				mask = SIUtils.CollisionMask.get_default_mask( SICommon.Types.Entities.SimpleEntity )
				if not SITable.Has( mask , SICommon.Flags.CollisionMask.NotCollidingWithItself ) then
					table.insert( mask , SICommon.Flags.CollisionMask.NotCollidingWithItself )
				end
				prototypeData.collision_mask = mask
			end
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
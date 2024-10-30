-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 修改各种物品属性 ================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

local settingPack = SISettings.Startup.SIItemPropertyModify

-- 维修工具耐久度倍率
if SIConfigs.SIItemPropertyModify.RepairToolDurabilityMultiplier ~= nil then
	local settingRepairToolDurabilityMultiplier = settingPack.RepairToolDurabilityMultiplier()
	if settingRepairToolDurabilityMultiplier > 0 and settingRepairToolDurabilityMultiplier ~= 1 then
		SIGen.ForEach( SICommon.Types.Items.ToolRepair , function( prototypeName , prototypeData )
			if prototypeData then
				prototypeData.durability = SITools.Round( ( prototypeData.durability or 1 ) * settingRepairToolDurabilityMultiplier , SICommon.Numbers.DurabilityMin , SICommon.Numbers.DurabilityMax )
			end
		end )
	end
end

-- 维修工具维修速度倍率
if SIConfigs.SIItemPropertyModify.RepairToolSpeedMultiplier ~= nil then
	local settingRepairToolSpeedMultiplier = settingPack.RepairToolSpeedMultiplier()
	if settingRepairToolSpeedMultiplier > 0 and settingRepairToolSpeedMultiplier ~= 1 then
		SIGen.ForEach( SICommon.Types.Items.ToolRepair , function( prototypeName , prototypeData )
			if prototypeData then
				prototypeData.speed = SITools.Round( ( prototypeData.speed or 1 ) * settingRepairToolSpeedMultiplier , SICommon.Numbers.SpeedMin , SICommon.Numbers.SpeedMax )
			end
		end )
	end
end

-- 工具 ( 科技包 ) 耐久度倍率
if SIConfigs.SIItemPropertyModify.ToolDurabilityMultiplier ~= nil then
	local settingToolDurabilityMultiplier = settingPack.ToolDurabilityMultiplier()
	if settingToolDurabilityMultiplier > 0 and settingToolDurabilityMultiplier ~= 1 then
		SIGen.ForEach( SICommon.Types.Items.Tool , function( prototypeName , prototypeData )
			if prototypeData then
				prototypeData.durability = SITools.Round( ( prototypeData.durability or 1 ) * settingToolDurabilityMultiplier , SICommon.Numbers.DurabilityMin , SICommon.Numbers.DurabilityMax )
			end
		end )
	end
end

-- 研究球速度倍率
if SIConfigs.SIItemPropertyModify.LabSpeedMultiplier ~= nil then
	local settingLabSpeedMultiplier = settingPack.LabSpeedMultiplier()
	if settingLabSpeedMultiplier > 0 and settingLabSpeedMultiplier ~= 1 then
		SIGen.ForEach( SICommon.Types.Entities.Lab , function( prototypeName , prototypeData )
			if prototypeData then
				prototypeData.researching_speed = SITools.Round( ( prototypeData.researching_speed or 1 ) * settingLabSpeedMultiplier , SICommon.Numbers.SpeedMin , SICommon.Numbers.SpeedMax )
			end
		end )
	end
end

-- 子弹弹夹数量倍率
if SIConfigs.SIItemPropertyModify.MagazineAmmoSizeMultiplier ~= nil then
	local settingMagazineAmmoSizeMultiplier = settingPack.MagazineAmmoSizeMultiplier()
	if settingMagazineAmmoSizeMultiplier > 0 and settingMagazineAmmoSizeMultiplier ~= 1 then
		SIGen.ForEach( SICommon.Types.Items.Ammo , function( prototypeName , prototypeData )
			if prototypeData then
				prototypeData.magazine_size = SITools.Round( math.floor( ( prototypeData.magazine_size or 1 ) * settingMagazineAmmoSizeMultiplier ) , SICommon.Numbers.StackSizeMin , SICommon.Numbers.StackSizeMax )
			end
		end )
	end
end

-- 电路接线距离倍率
if SIConfigs.SIItemPropertyModify.CircuitDistanceMultiplier ~= nil then
	local settingCircuitDistanceMultiplier = settingPack.CircuitDistanceMultiplier()
	if settingCircuitDistanceMultiplier > 0 and settingCircuitDistanceMultiplier ~= 1 then
		SIGen.ForEachType( SICommon.Types.HealthEntities , function( prototypeName , prototypeData )
			if prototypeData and prototypeData.circuit_wire_max_distance then
				prototypeData.circuit_wire_max_distance = SITools.Round( math.floor( prototypeData.circuit_wire_max_distance * settingCircuitDistanceMultiplier ) , SICommon.Numbers.DistanceMin , SICommon.Numbers.DistanceMax )
			end
		end )
	end
end

-- 地下传送带距离倍率
if SIConfigs.SIItemPropertyModify.UndergrundBeltDistanceMultiplier ~= nil then
	local settingUndergrundBeltDistanceMultiplier = settingPack.UndergrundBeltDistanceMultiplier()
	if settingUndergrundBeltDistanceMultiplier > 0 and settingUndergrundBeltDistanceMultiplier ~= 1 then
		SIGen.ForEach( SICommon.Types.Entities.BeltGround , function( prototypeName , prototypeData )
			if prototypeData then
				prototypeData.max_distance = SITools.Round( math.floor( ( prototypeData.max_distance or 1 ) * settingUndergrundBeltDistanceMultiplier ) , SICommon.Numbers.DistanceMin , SICommon.Numbers.DistanceMax )
			end
		end )
	end
end

-- 地下管道距离倍率
if SIConfigs.SIItemPropertyModify.UndergrundPipeDistanceMultiplier ~= nil then
	local settingUndergrundPipeDistanceMultiplier = settingPack.UndergrundPipeDistanceMultiplier()
	if settingUndergrundPipeDistanceMultiplier > 0 and settingUndergrundPipeDistanceMultiplier ~= 1 then
		SIGen.ForEach( SICommon.Types.Entities.PipeGround , function( prototypeName , prototypeData )
			if prototypeData then
				for index , pipeData in pairs( prototypeData.fluid_box.pipe_connections ) do
					if pipeData.max_underground_distance then
						pipeData.max_underground_distance = SITools.Round( math.floor( pipeData.max_underground_distance * settingUndergrundPipeDistanceMultiplier ) , SICommon.Numbers.DistanceMin , SICommon.Numbers.DistanceMax )
					end
				end
			end
		end )
	end
end
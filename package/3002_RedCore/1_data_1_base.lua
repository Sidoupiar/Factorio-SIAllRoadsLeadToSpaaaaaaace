-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 基础功能 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIRedCore_Level3_MultiplierEnergyUsage = -0.7      + 1.0
SIRedCore_Level3_MultiplierCraftSpeed  = 1.0       + 1.0
SIRedCore_Level3_CountModuleSlot       = 2
SIRedCore_Level4_MultiplierIngredients = -0.7      + 1.0
SIRedCore_Level4_CountModuleSlot       = 2
SIRedCore_Level5_MultiplierProducts    = 1.0       + 1.0

local difficultyLevel = SIConfigs.SIRedCore.DifficultyLevel ~= nil and SITools.Round( math.floor( SISettings.Startup.SIRedCore.DifficultyLevel() ) , 1 , 5 ) or 1

-- ======================================================================<br>
---@return table
function SIRedCore_MakeSettings_Machine()
	return
	{
		AllowModify_EnergyUsage = true ,
		AllowModify_Module = true
	}
end

-- ======================================================================<br>
---@param ingredients boolean|nil
---@param products boolean|nil
---@return table
function SIRedCore_MakeSettings_Recipe( ingredients , products )
	return
	{
		AllowModify_Ingredients = ingredients ~= nil and ingredients or true ,
		AllowModify_Products    = products ~= nil and products or true
	}
end

-- ======================================================================<br>
---@param machineData table
---@return table
function SIRedCore_CheckData_Machine( machineData )
	if machineData.SIRedCoreSettings.AllowModify_EnergyUsage then
		local usage = machineData.energy_usage
		if usage then
			machineData.energy_usage = SITools.Energy_Mult( usage , SIRedCore_Level3_MultiplierEnergyUsage )
		end
	end
	if machineData.SIRedCoreSettings.AllowModify_Module then
		local defaultModuleSlot = machineData.module_slots
		if defaultModuleSlot then
			if difficultyLevel > 2 then
				defaultModuleSlot = defaultModuleSlot + SIRedCore_Level3_CountModuleSlot
			end
			if difficultyLevel > 3 then
				defaultModuleSlot = defaultModuleSlot + SIRedCore_Level4_CountModuleSlot
			end
			machineData.module_slots = defaultModuleSlot
		end
	end
	return machineData
end

-- ======================================================================<br>
---@param recipeData table
---@return table
function SIRedCore_CheckData_Recipe( recipeData )
	return recipeData
end
-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 基础功能 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIRedCore_Level2_UnlockLimitMachineUsage = true
SIRedCore_Level3_MultiplierEnergyUsage   = -0.7      + 1.0
SIRedCore_Level3_MultiplierCraftSpeed    = 1.0       + 1.0
SIRedCore_Level3_CountModuleSlot         = 2
SIRedCore_Level4_MultiplierIngredients   = -0.7      + 1.0
SIRedCore_Level4_CountModuleSlot         = 2
SIRedCore_Level5_MultiplierProducts      = 1.0       + 1.0
SIRedCore_Level5_RemoveHardProducts      = true

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
	local redCoreSettings = machineData.SIRedCoreSettings
	if redCoreSettings.AllowModify_EnergyUsage then
		local usage = machineData.energy_usage
		if usage then
			machineData.energy_usage = SITools.Energy_Mult( usage , SIRedCore_Level3_MultiplierEnergyUsage )
		end
	end
	if redCoreSettings.AllowModify_Module then
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
	local redCoreSettings = recipeData.SIRedCoreSettings
	if redCoreSettings.AllowModify_Ingredients and recipeData.ingredients and difficultyLevel > 3 then
		for index , ingredientData in pairs( recipeData.ingredients ) do
			if ingredientData and ingredientData.amount then
				ingredientData.amount = math.max( math.floor( ingredientData.amount * SIRedCore_Level4_MultiplierIngredients ) , 1 )
			end
		end
	end
	if redCoreSettings.AllowModify_Products and recipeData.results and difficultyLevel > 4 then
		local realResultList = {}
		for index , resultData in pairs( recipeData.results ) do
			if resultData then
				if SIRedCore_Level5_RemoveHardProducts then
					if resultData.SIRedCoreNotHard then
						if resultData.amount then
							resultData.amount = math.max( math.ceil( resultData.amount * SIRedCore_Level5_MultiplierProducts ) , 1 )
						end
						if resultData.amount_min then
							resultData.amount_min = math.max( math.ceil( resultData.amount_min * SIRedCore_Level5_MultiplierProducts ) , 1 )
						end
						if resultData.amount_max then
							resultData.amount_max = math.max( math.ceil( resultData.amount_max * SIRedCore_Level5_MultiplierProducts ) , 1 )
						end
						table.insert( realResultList , resultData )
					end
				else
					if resultData.amount then
						resultData.amount = math.max( math.ceil( resultData.amount * SIRedCore_Level5_MultiplierProducts ) , 1 )
					end
					if resultData.amount_min then
						resultData.amount_min = math.max( math.ceil( resultData.amount_min * SIRedCore_Level5_MultiplierProducts ) , 1 )
					end
					if resultData.amount_max then
						resultData.amount_max = math.max( math.ceil( resultData.amount_max * SIRedCore_Level5_MultiplierProducts ) , 1 )
					end
					table.insert( realResultList , resultData )
				end
			end
		end
		recipeData.results = realResultList
	end
	return recipeData
end
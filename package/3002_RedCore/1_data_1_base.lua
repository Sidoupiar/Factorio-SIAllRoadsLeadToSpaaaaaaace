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
SIRedCore_Level6_ProductsChance          = 0.02
SIRedCore_Level7_RandomRecipe            = true

local difficultyLevel = SIConstants_RedCore.MinLevel
if SIConfigs.SIRedCore.DifficultyLevel ~= nil then
	difficultyLevel = SITools.Range( math.floor( SISettings.Startup.SIRedCore.DifficultyLevel() ) , SIConstants_RedCore.MinLevel , SIConstants_RedCore.MaxLevel )
end

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
	if redCoreSettings.AllowModify_Products and recipeData.results then
		local isLevel5 = difficultyLevel > 4
		local isLevel6 = difficultyLevel > 5
		local realResultList = {}
		for index , resultData in pairs( recipeData.results ) do
			if resultData then
				if SIRedCore_Level5_RemoveHardProducts then
					if resultData.SIRedCoreNotHard then
						if isLevel5 then
							if resultData.amount then
								resultData.amount = math.max( math.ceil( resultData.amount * SIRedCore_Level5_MultiplierProducts ) , 1 )
							end
							if resultData.amount_min then
								resultData.amount_min = math.max( math.ceil( resultData.amount_min * SIRedCore_Level5_MultiplierProducts ) , 1 )
							end
							if resultData.amount_max then
								resultData.amount_max = math.max( math.ceil( resultData.amount_max * SIRedCore_Level5_MultiplierProducts ) , 1 )
							end
						end
						if isLevel6 then
							if resultData.probability then
								resultData.probability = math.max( math.min( resultData.probability + SIRedCore_Level6_ProductsChance , 1.0 ) , 0.0 )
							end
						end
						table.insert( realResultList , resultData )
					end
				else
					if isLevel5 then
						if resultData.amount then
							resultData.amount = math.max( math.ceil( resultData.amount * SIRedCore_Level5_MultiplierProducts ) , 1 )
						end
						if resultData.amount_min then
							resultData.amount_min = math.max( math.ceil( resultData.amount_min * SIRedCore_Level5_MultiplierProducts ) , 1 )
						end
						if resultData.amount_max then
							resultData.amount_max = math.max( math.ceil( resultData.amount_max * SIRedCore_Level5_MultiplierProducts ) , 1 )
						end
					end
					if isLevel6 then
						if resultData.probability then
							resultData.probability = math.max( math.min( resultData.probability + SIRedCore_Level6_ProductsChance , 1.0 ) , 0.0 )
						end
					end
					table.insert( realResultList , resultData )
				end
			end
		end
		recipeData.results = realResultList
	end
	return recipeData
end
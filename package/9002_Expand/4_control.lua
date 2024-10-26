-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 定义信息 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIControl.Init
{
	[SICommon.Types.Recipe] =
	{
		BarrelFullPrefix = "灌装-"
	} ,
	[SICommon.Types.Technology] =
	{
		Barrel_1 = "灌装技术-1" ,
		Barrel_2 = "灌装技术-2" ,
		Barrel_3 = "灌装技术-3"
	}
}

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 装桶 ============================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================
-- 事件
-- ======================================================================
SIEventBus
.ConfigurationChange( function( functionID )
	for forceIndex , force in pairs( game.forces ) do
		local recipeList = {}
		local technology_1 = force.technologies[SIConstants_Expand.raw.Technologies.Barrel_1]
		if technology_1 and technology_1.researched then
			for effectIndex , effect in pairs( technology_1.effects ) do
				if effect.type == SICommon.Flags.TechnologyModifier.UnlockRecipe then
					local recipe = force.recipes[effect.recipe]
					if recipe then
						if recipe.name:StartsWith( SIConstants_Expand.raw.Recipes.BarrelFullPrefix ) then
							table.insert( recipeList, recipe )
						end
						if not recipe.enabled then
							recipe.enabled = true
						end
					end
				end
			end
		end
		local technology_2 = force.technologies[SIConstants_Expand.raw.Technologies.Barrel_2]
		if technology_2 and technology_2.researched then
			for recipeIndex , recipe in pairs( recipeList ) do
				recipe.enabled = false
			end
			recipeList = {}
			for effectIndex , effect in pairs( technology_2.effects ) do
				if effect.type == SICommon.Flags.TechnologyModifier.UnlockRecipe then
					local recipe = force.recipes[effect.recipe]
					if recipe then
						if recipe.name:StartsWith( SIConstants_Expand.raw.Recipes.BarrelFullPrefix ) then
							table.insert( recipeList , recipe )
						end
						if not recipe.enabled then
							recipe.enabled = true
						end
					end
				end
			end
		end
		local technology_3 = force.technologies[SIConstants_Expand.raw.Technologies.Barrel_3]
		if technology_3 and technology_3.researched then
			for recipeIndex , recipe in pairs( recipeList ) do
				recipe.enabled = false
			end
			for effectIndex , effect in pairs( technology_3.effects ) do
				if effect.type == SICommon.Flags.TechnologyModifier.UnlockRecipe then
					local recipe = force.recipes[effect.recipe]
					if recipe then
						if not recipe.enabled then
							recipe.enabled = true
						end
					end
				end
			end
		end
	end
end )
.Add( SIEvents.on_research_finished , function( event , functionID )
	local technology = event.research
	if not technology or not technology.valid then
		return
	end
	local name = technology.name
	local force = technology.force
	if name == SIConstants_Expand.raw.Technologies.Barrel_2 then
		-- 移除上一级科技的配方
		local technology_1 = force.technologies[SIConstants_Expand.raw.Technologies.Barrel_1]
		if technology_1 and technology_1.researched then
			for effectIndex , effect in pairs( technology_1.effects ) do
				if effect.type == SICommon.Flags.TechnologyModifier.UnlockRecipe then
					local recipe = force.recipes[effect.recipe]
					if recipe and recipe.name:StartsWith( SIConstants_Expand.raw.Recipes.BarrelFullPrefix ) then
						recipe.enabled = false
					end
				end
			end
		end
		return
	end
	if name == SIConstants_Expand.raw.Technologies.Barrel_3 then
		-- 移除上一级科技的配方
		local technology_1 = force.technologies[SIConstants_Expand.raw.Technologies.Barrel_1]
		if technology_1 and technology_1.researched then
			for effectIndex , effect in pairs( technology_1.effects ) do
				if effect.type == SICommon.Flags.TechnologyModifier.UnlockRecipe then
					local recipe = force.recipes[effect.recipe]
					if recipe and recipe.name:StartsWith( SIConstants_Expand.raw.Recipes.BarrelFullPrefix ) then
						recipe.enabled = false
					end
				end
			end
		end
		local technology_2 = force.technologies[SIConstants_Expand.raw.Technologies.Barrel_2]
		if technology_2 and technology_2.researched then
			for effectIndex , effect in pairs( technology_2.effects ) do
				if effect.type == SICommon.Flags.TechnologyModifier.UnlockRecipe then
					local recipe = force.recipes[effect.recipe]
					if recipe and recipe.name:StartsWith( SIConstants_Expand.raw.Recipes.BarrelFullPrefix ) then
						recipe.enabled = false
					end
				end
			end
		end
		return
	end
end )
.Add( SIEvents.on_research_reversed , function( event , functionID )
	local technology = event.research
	if not technology or not technology.valid then
		return
	end
	local name = technology.name
	local force = technology.force
	if name == SIConstants_Expand.raw.Technologies.Barrel_2 then
		-- 恢复上一级科技的配方
		local technology_1 = force.technologies[SIConstants_Expand.raw.Technologies.Barrel_1]
		if technology_1 and technology_1.researched then
			for effectIndex , effect in pairs( technology_1.effects ) do
				if effect.type == SICommon.Flags.TechnologyModifier.UnlockRecipe then
					local recipe = force.recipes[effect.recipe]
					if recipe and recipe.name:StartsWith( SIConstants_Expand.raw.Recipes.BarrelFullPrefix ) then
						recipe.enabled = true
					end
				end
			end
		end
		return
	end
	if name == SIConstants_Expand.raw.Technologies.Barrel_3 then
		-- 恢复上一级科技的配方
		local technology_2 = force.technologies[SIConstants_Expand.raw.Technologies.Barrel_2]
		if technology_2 and technology_2.researched then
			for effectIndex , effect in pairs( technology_2.effects ) do
				if effect.type == SICommon.Flags.TechnologyModifier.UnlockRecipe then
					local recipe = force.recipes[effect.recipe]
					if recipe and recipe.name:StartsWith( SIConstants_Expand.raw.Recipes.BarrelFullPrefix ) then
						recipe.enabled = true
					end
				end
			end
			return
		end
		local technology_1 = force.technologies[SIConstants_Expand.raw.Technologies.Barrel_1]
		if technology_1 and technology_1.researched then
			for effectIndex , effect in pairs( technology_1.effects ) do
				if effect.type == SICommon.Flags.TechnologyModifier.UnlockRecipe then
					local recipe = force.recipes[effect.recipe]
					if recipe and recipe.name:StartsWith( SIConstants_Expand.raw.Recipes.BarrelFullPrefix ) then
						recipe.enabled = true
					end
				end
			end
			return
		end
		return
	end
end )
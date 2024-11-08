-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 遗迹配方 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIGen
.SetGroup( SIConstants_RuinSystem.raw.Groups.Hidden.RuinRecipes )

-- ======================================================================<br>
-- 资源类配方
-- ======================================================================<br>
for index , data in pairs( SIConstants_RuinSystem.RuinRecipeData ) do
	SIGen
	.New( SICommon.Types.Recipe , "RuinRecipe_" .. data.ID , "遗迹配方-" .. data.Alias ,
	{
		category = SIConstants_RuinSystem.raw.Categories.Recipe.RuinMachine ,
		crafting_machine_tint =
		{
			primary = { r = 0.70 , g = 0.70 , b = 0.70 } ,
			secondary = { r = 0.70 , g = 0.70 , b = 0.70 } ,
			tertiary = { r = 0.70 , g = 0.70 , b = 0.70 } ,
			quaternary = { r = 0.70 , g = 0.70 , b = 0.70 }
		} ,
		enabled = false ,
		hidden = true ,
		hide_from_stats = true ,
		hide_from_player_crafting = true ,
		energy_required = data.Time * 24.0 ,
		ingredients = {} ,
		results =
		{
			{
				type = SICommon.Types.Items.Item ,
				name = data.result ,
				amount = 2 ,
				catalyst_amount = 2
			}
		} ,
		main_product = data.Result ,
		emissions_multiplier = 0.4 ,
		requester_paste_multiplier = 10 ,
		overload_multiplier = 5 ,
		allow_inserter_overload = true ,
		allow_decomposition = true ,
		allow_intermediates = true ,
		allow_as_intermediate = true ,
		always_show_products = true ,
		always_show_made_in = true ,
		show_amount_in_title = false ,
		unlock_results = false
	} )
	.AutoIcon()
end
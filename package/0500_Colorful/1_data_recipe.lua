-- ------------------------------------------------------------------------------------------------
-- ---------- 条件判断 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

if not SIConstants_Resource then
	return
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 多彩母版 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen
.SetGroup( SIConstants_Colorful.raw.Groups.Colorful.Pixel )
-- 像素块母板
.New( SICommon.Types.Recipe , "Pixel" , "像素块母板" ,
{
	category = "crafting" ,
	crafting_machine_tint =
	{
		primary = { r = 0.95 , g = 0.95 , b = 0.95 } ,
		secondary = { r = 0.95 , g = 0.95 , b = 0.95 } ,
		tertiary = { r = 0.95 , g = 0.95 , b = 0.95 } ,
		quaternary = { r = 0.95 , g = 0.95 , b = 0.95 }
	} ,
	enabled = true ,
	hidden = false ,
	hide_from_stats = false ,
	hide_from_player_crafting = false ,
	energy_required = 9.0 ,
	ingredients =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Resource.raw.Items.RockHard ,
			amount = 1
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Resource.raw.Items.OreMilk ,
			amount = 5
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Resource.raw.Items.OreFour ,
			amount = 3
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Resource.raw.Items.OreUpper ,
			amount = 10
		}
	} ,
	results =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Resource.raw.Items.RockHard ,
			probability = 0.92 ,
			amount = 1 ,
			catalyst_amount = 1
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Colorful.raw.Items.Pixel ,
			amount = 12 ,
			catalyst_amount = 12
		}
	} ,
	main_product = SIConstants_Colorful.raw.Items.Pixel ,
	emissions_multiplier = 1.0 ,
	requester_paste_multiplier = 10 ,
	overload_multiplier = 5 ,
	allow_inserter_overload = true ,
	allow_decomposition = true ,
	allow_intermediates = true ,
	allow_as_intermediate = true ,
	always_show_products = true ,
	always_show_made_in = true ,
	show_amount_in_title = false ,
	unlock_results = true
} )

-- ------------------------------------------------------------------------------------------------
-- --------- 多彩调色盘 ---------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen
.SetGroup( SIConstants_Colorful.raw.Groups.Colorful.Tool )
-- 多彩调色盘
.New( SICommon.Types.Recipe , "ColorPanel" , "多彩调色盘" ,
{
	category = "crafting" ,
	crafting_machine_tint =
	{
		primary = { r = 0.95 , g = 0.95 , b = 0.95 } ,
		secondary = { r = 0.95 , g = 0.95 , b = 0.95 } ,
		tertiary = { r = 0.95 , g = 0.95 , b = 0.95 } ,
		quaternary = { r = 0.95 , g = 0.95 , b = 0.95 }
	} ,
	enabled = true ,
	hidden = false ,
	hide_from_stats = false ,
	hide_from_player_crafting = false ,
	energy_required = 6.0 ,
	ingredients =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Resource.raw.Items.RockHard ,
			amount = 1
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Resource.raw.Items.OreEgg ,
			amount = 45
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Resource.raw.Items.OreShine ,
			amount = 45
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Colorful.raw.Items.Pixel ,
			amount = 27
		}
	} ,
	results =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Resource.raw.Items.RockHard ,
			probability = 0.92 ,
			amount = 1 ,
			catalyst_amount = 1
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Colorful.raw.Items.ColorPanel ,
			amount = 1 ,
			catalyst_amount = 1
		}
	} ,
	main_product = SIConstants_Colorful.raw.Items.ColorPanel ,
	emissions_multiplier = 1.0 ,
	requester_paste_multiplier = 10 ,
	overload_multiplier = 5 ,
	allow_inserter_overload = true ,
	allow_decomposition = true ,
	allow_intermediates = true ,
	allow_as_intermediate = true ,
	always_show_products = true ,
	always_show_made_in = true ,
	show_amount_in_title = false ,
	unlock_results = true
} )
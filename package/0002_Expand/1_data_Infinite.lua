-- ------------------------------------------------------------------------------------------------
-- -------- 扩展无尽科技 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen
.SetGroup( SIConstants_Expand.raw.Groups.Expand.InfiniteTech )

-- ----------------------------------------
-- 研究包
-- ----------------------------------------
.New( SICommon.Types.Items.Tool , "FirstPack" , "第一代产业研究包" ,
{
	stack_size = 1000 ,
	default_request_amount = 1000 ,
	durability = 1.0 ,
	durability_description_key = SICommon.Flags.SciencePack.Key ,
	durability_description_value = SICommon.Flags.SciencePack.Value
} )
.AutoIcon()
.New( SICommon.Types.Recipe , "FirstPack" , "第一代产业研究包" ,
{
	category = "crafting" ,
	crafting_machine_tint =
	{
		primary = { r = 0.80 , g = 0.35 , b = 0.51 } ,
		secondary = { r = 0.80 , g = 0.35 , b = 0.51 } ,
		tertiary = { r = 0.80 , g = 0.35 , b = 0.51 } ,
		quaternary = { r = 0.80 , g = 0.35 , b = 0.51 }
	} ,
	enabled = false ,
	hidden = false ,
	hide_from_stats = false ,
	hide_from_player_crafting = false ,
	energy_required = 60.0 ,
	ingredients =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = "stone" ,
			amount = 6
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "iron-stick" ,
			amount = 5
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "wooden-chest" ,
			amount = 1
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "burner-mining-drill" ,
			amount = 1
		}
	} ,
	results =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Expand.raw.Items.FirstPack ,
			amount = 3 ,
			catalyst_amount = 3
		}
	} ,
	main_product = SIConstants_Expand.raw.Items.FirstPack ,
	emissions_multiplier = 3.5 ,
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
.AutoIcon()
.New( SICommon.Types.Items.Tool , "SecondPack" , "第二代产业研究包" ,
{
	stack_size = 1000 ,
	default_request_amount = 1000 ,
	durability = 1.0 ,
	durability_description_key = SICommon.Flags.SciencePack.Key ,
	durability_description_value = SICommon.Flags.SciencePack.Value
} )
.AutoIcon()
.New( SICommon.Types.Recipe , "SecondPack" , "第二代产业研究包" ,
{
	category = "crafting" ,
	crafting_machine_tint =
	{
		primary = { r = 0.66 , g = 0.80 , b = 0.35 } ,
		secondary = { r = 0.66 , g = 0.80 , b = 0.35 } ,
		tertiary = { r = 0.66 , g = 0.80 , b = 0.35 } ,
		quaternary = { r = 0.66 , g = 0.80 , b = 0.35 }
	} ,
	enabled = false ,
	hidden = false ,
	hide_from_stats = false ,
	hide_from_player_crafting = false ,
	energy_required = 60.0 ,
	ingredients =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = "landfill" ,
			amount = 2
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "iron-chest" ,
			amount = 3
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "empty-barrel" ,
			amount = 3
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "small-electric-pole" ,
			amount = 2
		}
	} ,
	results =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Expand.raw.Items.SecondPack ,
			amount = 3 ,
			catalyst_amount = 3
		}
	} ,
	main_product = SIConstants_Expand.raw.Items.SecondPack ,
	emissions_multiplier = 3.5 ,
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
.AutoIcon()
.New( SICommon.Types.Items.Tool , "ThirdPack" , "第三代产业研究包" ,
{
	stack_size = 1000 ,
	default_request_amount = 1000 ,
	durability = 1.0 ,
	durability_description_key = SICommon.Flags.SciencePack.Key ,
	durability_description_value = SICommon.Flags.SciencePack.Value
} )
.AutoIcon()
.New( SICommon.Types.Recipe , "ThirdPack" , "第三代产业研究包" ,
{
	category = "crafting" ,
	crafting_machine_tint =
	{
		primary = { r = 0.37 , g = 0.82 , b = 0.81 } ,
		secondary = { r = 0.37 , g = 0.82 , b = 0.81 } ,
		tertiary = { r = 0.37 , g = 0.82 , b = 0.81 } ,
		quaternary = { r = 0.37 , g = 0.82 , b = 0.81 }
	} ,
	enabled = false ,
	hidden = false ,
	hide_from_stats = false ,
	hide_from_player_crafting = false ,
	energy_required = 60.0 ,
	ingredients =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = "hazard-concrete" ,
			amount = 10
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "solid-fuel" ,
			amount = 3
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "offshore-pump" ,
			amount = 2
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "burner-inserter" ,
			amount = 5
		}
	} ,
	results =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Expand.raw.Items.ThirdPack ,
			amount = 3 ,
			catalyst_amount = 3
		}
	} ,
	main_product = SIConstants_Expand.raw.Items.ThirdPack ,
	emissions_multiplier = 3.5 ,
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
.AutoIcon()
.New( SICommon.Types.Items.Tool , "ForthPack" , "第四代产业研究包" ,
{
	stack_size = 1000 ,
	default_request_amount = 1000 ,
	durability = 1.0 ,
	durability_description_key = SICommon.Flags.SciencePack.Key ,
	durability_description_value = SICommon.Flags.SciencePack.Value
} )
.AutoIcon()
.New( SICommon.Types.Recipe , "ForthPack" , "第四代产业研究包" ,
{
	category = "crafting" ,
	crafting_machine_tint =
	{
		primary = { r = 0.79 , g = 0.35 , b = 0.80 } ,
		secondary = { r = 0.79 , g = 0.35 , b = 0.80 } ,
		tertiary = { r = 0.79 , g = 0.35 , b = 0.80 } ,
		quaternary = { r = 0.79 , g = 0.35 , b = 0.80 }
	} ,
	enabled = false ,
	hidden = false ,
	hide_from_stats = false ,
	hide_from_player_crafting = false ,
	energy_required = 60.0 ,
	ingredients =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = "uranium-238" ,
			amount = 20
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "refined-hazard-concrete" ,
			amount = 12
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "land-mine" ,
			amount = 5
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "piercing-shotgun-shell" ,
			amount = 8
		}
	} ,
	results =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Expand.raw.Items.ForthPack ,
			amount = 3 ,
			catalyst_amount = 3
		}
	} ,
	main_product = SIConstants_Expand.raw.Items.ForthPack ,
	emissions_multiplier = 3.5 ,
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
.AutoIcon()
.New( SICommon.Types.Items.Tool , "FifthPack" , "第五代产业研究包" ,
{
	stack_size = 1000 ,
	default_request_amount = 1000 ,
	durability = 1.0 ,
	durability_description_key = SICommon.Flags.SciencePack.Key ,
	durability_description_value = SICommon.Flags.SciencePack.Value
} )
.AutoIcon()
.New( SICommon.Types.Recipe , "FifthPack" , "第五代产业研究包" ,
{
	category = "crafting" ,
	crafting_machine_tint =
	{
		primary = { r = 0.80 , g = 0.71 , b = 0.35 } ,
		secondary = { r = 0.80 , g = 0.71 , b = 0.35 } ,
		tertiary = { r = 0.80 , g = 0.71 , b = 0.35 } ,
		quaternary = { r = 0.80 , g = 0.71 , b = 0.35 }
	} ,
	enabled = false ,
	hidden = false ,
	hide_from_stats = false ,
	hide_from_player_crafting = false ,
	energy_required = 60.0 ,
	ingredients =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = "copper-ore" ,
			amount = 40
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "low-density-structure" ,
			amount = 6
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "energy-shield-equipment" ,
			amount = 1
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "atomic-bomb" ,
			amount = 1
		}
	} ,
	results =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Expand.raw.Items.FifthPack ,
			amount = 3 ,
			catalyst_amount = 3
		}
	} ,
	main_product = SIConstants_Expand.raw.Items.FifthPack ,
	emissions_multiplier = 3.5 ,
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
.AutoIcon()

-- ----------------------------------------
-- 无尽研究球
-- ----------------------------------------
.New( SICommon.Types.Items.Item , "Lab" , "无尽研究球" ,
{
	stack_size = 100 ,
	default_request_amount = 100 ,
	place_result = nil
} )
.AutoIcon()
.New( SICommon.Types.Recipe , "Lab" , "无尽研究球" ,
{
	category = "crafting" ,
	crafting_machine_tint =
	{
		primary = { r = 0.89 , g = 0.12 , b = 0.20 } ,
		secondary = { r = 0.89 , g = 0.12 , b = 0.20 } ,
		tertiary = { r = 0.89 , g = 0.12 , b = 0.20 } ,
		quaternary = { r = 0.89 , g = 0.12 , b = 0.20 }
	} ,
	enabled = false ,
	hidden = false ,
	hide_from_stats = false ,
	hide_from_player_crafting = false ,
	energy_required = 120.0 ,
	ingredients =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = "stone-wall" ,
			amount = 28
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "burner-mining-drill" ,
			amount = 12
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "transport-belt" ,
			amount = 22
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "small-lamp" ,
			amount = 8
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "assembling-machine-1" ,
			amount = 12
		}
	} ,
	results =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Expand.raw.Items.Lab ,
			amount = 1 ,
			catalyst_amount = 1
		}
	} ,
	main_product = SIConstants_Expand.raw.Items.Lab ,
	emissions_multiplier = 5.0 ,
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
.AutoIcon()
.New( SICommon.Types.Entities.Corpse , "LabRemnants" , "无尽研究球-残骸" )
.AutoIcon()
.SetSizeScale( 3 , 3 , 0 )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceableNeutral , SICommon.Flags.Entity.NotOnMap } ,
	time_before_removed = 54000 , -- 15 分钟
	tile_width = 3 ,
	tile_height = 3 ,
	selectable_in_game = false ,
	remove_on_tile_placement = false ,
	final_render_layer = SICommon.Flags.RenderLayer.Remnants ,
	animation = SIGraphics.MakeRemnantsAnimation( 2 ,
	{
		{
			filename = SIGen.MakeSelfPicturePath( "无尽研究球-残骸" ) ,
			priority = "extra-high" ,
			width = 134 ,
			height = 100 ,
			frame_count = 1 ,
			line_length = 1 ,
			variation_count = 1 ,
			direction_count = 1 ,
			shift = SIUtils.by_pixel( 7 , 6 ) ,
			axially_symmetrical = false
		}
	} )
}
.New( SICommon.Types.Entities.Lab , "Lab" , "无尽研究球" )
.AutoIcon()
.SetSize( 3 , 3 )
.ReferencePlaceResult( SICommon.Types.Items.Item , SIConstants_Expand.raw.Items.Lab )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceablePlayer , SICommon.Flags.Entity.PlayerCreation } ,
	minable =
	{
		mining_time = 5.0 ,
		results =
		{
			{
				type = SICommon.Types.Items.item ,
				name = SIConstants_Expand.raw.Items.Lab ,
				amount = 1
			}
		}
	} ,
	max_health = 185 ,
	corpse = SIConstants_Expand.raw.Entities.LabRemnants ,
	dying_explosion = "lab-explosion" ,
	map_color = { r = 1.00 , g = 1.00 , b = 1.00 } ,
	friendly_map_color = { r = 0.40 , g = 0.40 , b = 1.00 } ,
	enemy_map_color = { r = 1.00 , g = 0.40 , b = 0.40 } ,
	alert_when_damaged = true ,
	create_ghost_on_death = true ,
	hide_resistances = true ,
	resistances =
	{
		SITools.Resistance( "fire" , 0 , 25 )
	} ,
	damaged_trigger_effect =
	{
		type = "create-entity" ,
		entity_name = "spark-explosion" ,
		offset_deviation = { { -0.5 , -0.5 } , { 0.5 , 0.5 } } ,
		offsets = { { 0 , 1 } } ,
		damage_type_filters = "fire"
	} ,
	repair_speed_modifier = 1.0 ,
	energy_source =
	{
		type = SICommon.Flags.EnergySourceType.Electric ,
		emissions_per_minute = 2 ,
		render_no_power_icon = true ,
		render_no_network_icon = true ,
		usage_priority = SICommon.Flags.ElectricUsagePriority.InputSecondary ,
		buffer_capacity = "1MJ" ,
		input_flow_limit = "50KW" ,
		output_flow_limit = "50KW" ,
		drain = "0J"
	} ,
	energy_usage = "115KW" ,
	allowed_effects =
	{
		"speed" ,
		"consumption" ,
		"pollution"
	} ,
	module_specification =
	{
		module_slots = 6 ,
		module_info_icon_shift = { 0.0 , 0.9 }
	} ,
	base_productivity = 0 ,
	researching_speed = 1 ,
	inputs =
	{
		SIConstants_Expand.raw.Items.FirstPack ,
		SIConstants_Expand.raw.Items.SecondPack ,
		SIConstants_Expand.raw.Items.ThirdPack ,
		SIConstants_Expand.raw.Items.ForthPack ,
		SIConstants_Expand.raw.Items.FifthPack
	} ,
	entity_info_icon_shift = { 0 , 0 } ,
	alert_icon_shift = { 0 , 0 } ,
	on_animation =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "无尽研究球" ) ,
				priority = "extra-high" ,
				width = 98 ,
				height = 87 ,
				frame_count = 33 ,
				line_length = 11 ,
				animation_speed = 0.3333 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 0 , 1.5 )
			} ,
			{
				filename = SIGen.MakeSelfPicturePath( "无尽研究球-交互" ) ,
				priority = "extra-high" ,
				width = 122 ,
				height = 81 ,
				frame_count = 1 ,
				line_length = 1 ,
				repeat_count = 33 ,
				animation_speed = 0.3333 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 0 , 15.5 )
			} ,
			{
				filename = SIGen.MakeSelfPicturePath( "无尽研究球-灯光" ) ,
				priority = "extra-high" ,
				blend_mode = "additive" ,
				width = 106 ,
				height = 100 ,
				frame_count = 33 ,
				line_length = 11 ,
				animation_speed = 0.3333 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( -1 , 1 ) ,
				draw_as_light = true ,
			} ,
			{
				filename = SIGen.MakeSelfPicturePath( "无尽研究球-影子" ) ,
				priority = "extra-high" ,
				width = 122 ,
				height = 68 ,
				frame_count = 1 ,
				line_length = 1 ,
				repeat_count = 33 ,
				animation_speed = 0.3333 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 13 , 11 ) ,
				draw_as_shadow = true
			}
		}
	} ,
	off_animation =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "无尽研究球" ) ,
				priority = "extra-high" ,
				width = 98 ,
				height = 87 ,
				frame_count = 33 ,
				line_length = 11 ,
				animation_speed = 0.3333 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 0 , 1.5 )
			} ,
			{
				filename = SIGen.MakeSelfPicturePath( "无尽研究球-交互" ) ,
				priority = "extra-high" ,
				width = 122 ,
				height = 81 ,
				frame_count = 1 ,
				line_length = 1 ,
				repeat_count = 33 ,
				animation_speed = 0.3333 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 0 , 15.5 )
			} ,
			{
				filename = SIGen.MakeSelfPicturePath( "无尽研究球-影子" ) ,
				priority = "extra-high" ,
				width = 122 ,
				height = 68 ,
				frame_count = 1 ,
				line_length = 1 ,
				repeat_count = 33 ,
				animation_speed = 0.3333 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 13 , 11 ) ,
				draw_as_shadow = true
			}
		}
	} ,
	mined_sound =
	{
		SISound.Core( "deconstruct-large" , 1 )
	} ,
	vehicle_impact_sound =
	{
		SISound.Base( "car-metal-impact" , 1 )
	} ,
	repair_sound =
	{
		SISound.Core( "manual-repair-advanced-1" , 0.5 ) ,
		SISound.Core( "manual-repair-advanced-2" , 0.5 )
	} ,
	open_sound =
	{
		SISound.Base( "machine-open" , 0.5 )
	} ,
	close_sound =
	{
		SISound.Base( "machine-close" , 0.5 )
	} ,
	working_sound =
	{
		sound =
		{
			SISound.Base( "lab" , 0.7 )
		} ,
		audible_distance_modifier = 0.7 ,
		fade_in_ticks = 4 ,
		fade_out_ticks = 20
	}
}

-- ----------------------------------------
-- 无尽科技 - 前置科技
-- ----------------------------------------
.New( SICommon.Types.Technology , "InfiniteStart" , "无尽研究入门" ,
{
	enabled = true ,
	hidden = false ,
	visible_when_disabled = true ,
	ignore_tech_cost_multiplier = true ,
	upgrade = false ,
	prerequisites = {} ,
	unit =
	{
		count = 25 ,
		time = 60 ,
		ingredients = {}
	} ,
	effects = {}
} )
.AutoIcon()
.New( SICommon.Types.Technology , "Infinite_1" , "第一代产业研究" ,
{
	enabled = true ,
	hidden = false ,
	visible_when_disabled = true ,
	ignore_tech_cost_multiplier = true ,
	upgrade = false ,
	prerequisites =
	{
		SIConstants_Expand.raw.Technologies.InfiniteStart
	} ,
	unit =
	{
		count = 100 ,
		time = 60 ,
		ingredients = {}
	} ,
	effects =
	{
		{
			type = SICommon.Flags.TechnologyModifier.UnlockRecipe ,
			recipe = SIConstants_Expand.raw.Recipes.FirstPack
		} ,
		{
			type = SICommon.Flags.TechnologyModifier.UnlockRecipe ,
			recipe = SIConstants_Expand.raw.Recipes.Lab
		}
	}
} )
.AutoIcon()
.New( SICommon.Types.Technology , "Infinite_2" , "第二代产业研究" ,
{
	enabled = true ,
	hidden = false ,
	visible_when_disabled = true ,
	ignore_tech_cost_multiplier = true ,
	upgrade = false ,
	prerequisites =
	{
		SIConstants_Expand.raw.Technologies.Infinite_1
	} ,
	unit =
	{
		count = 100 ,
		time = 60 ,
		ingredients =
		{
			{
				type = SICommon.Types.Items.Item ,
				name = SIConstants_Expand.raw.Items.FirstPack ,
				amount = 1
			}
		}
	} ,
	effects =
	{
		{
			type = SICommon.Flags.TechnologyModifier.UnlockRecipe ,
			recipe = SIConstants_Expand.raw.Recipes.SecondPack
		}
	}
} )
.AutoIcon()
.New( SICommon.Types.Technology , "Infinite_3" , "第三代产业研究" ,
{
	enabled = true ,
	hidden = false ,
	visible_when_disabled = true ,
	ignore_tech_cost_multiplier = true ,
	upgrade = false ,
	prerequisites =
	{
		SIConstants_Expand.raw.Technologies.Infinite_2
	} ,
	unit =
	{
		count = 100 ,
		time = 60 ,
		ingredients =
		{
			{
				type = SICommon.Types.Items.Item ,
				name = SIConstants_Expand.raw.Items.SecondPack ,
				amount = 1
			}
		}
	} ,
	effects =
	{
		{
			type = SICommon.Flags.TechnologyModifier.UnlockRecipe ,
			recipe = SIConstants_Expand.raw.Recipes.ThirdPack
		}
	}
} )
.AutoIcon()
.New( SICommon.Types.Technology , "Infinite_4" , "第四代产业研究" ,
{
	enabled = true ,
	hidden = false ,
	visible_when_disabled = true ,
	ignore_tech_cost_multiplier = true ,
	upgrade = false ,
	prerequisites =
	{
		SIConstants_Expand.raw.Technologies.Infinite_3
	} ,
	unit =
	{
		count = 100 ,
		time = 60 ,
		ingredients =
		{
			{
				type = SICommon.Types.Items.Item ,
				name = SIConstants_Expand.raw.Items.ThirdPack ,
				amount = 1
			}
		}
	} ,
	effects =
	{
		{
			type = SICommon.Flags.TechnologyModifier.UnlockRecipe ,
			recipe = SIConstants_Expand.raw.Recipes.ForthPack
		}
	}
} )
.AutoIcon()
.New( SICommon.Types.Technology , "Infinite_5" , "第五代产业研究" ,
{
	enabled = true ,
	hidden = false ,
	visible_when_disabled = true ,
	ignore_tech_cost_multiplier = true ,
	upgrade = false ,
	prerequisites =
	{
		SIConstants_Expand.raw.Technologies.Infinite_4
	} ,
	unit =
	{
		count = 100 ,
		time = 60 ,
		ingredients =
		{
			{
				type = SICommon.Types.Items.Item ,
				name = SIConstants_Expand.raw.Items.ForthPack ,
				amount = 1
			}
		}
	} ,
	effects =
	{
		{
			type = SICommon.Flags.TechnologyModifier.UnlockRecipe ,
			recipe = SIConstants_Expand.raw.Recipes.FifthPack
		}
	}
} )
.AutoIcon()

local function InfiniteTech( ID , alias , maxLevel , subIcon , effects )
	local IDPrefix = "Infinite_" .. ID
	local aliasPrefix = "无尽科技-" .. alias
	local baseValue = math.max( math.floor( 110 / ( maxLevel * ( maxLevel + 1 ) ) ) , 1 ) * 100
	SIGen
	-- ----------------------------------------
	-- 无尽科技 - 第一产业
	-- ----------------------------------------
	.New( SICommon.Types.Technology , IDPrefix .. "_" .. 1 , aliasPrefix .. "-" .. 1 )
	.Append
	{
		localised_name = SIGen.MakeSelfLocalisedName( aliasPrefix ) ,
		localised_description = SIGen.MakeSelfLocalisedDescription( aliasPrefix ) ,
		icons =
		{
			{
				icon = SIGen.MakeSelfPicturePath( "无尽科技" .. SICommon.ShowNameSuffix.ICON ) ,
				icon_size = 256 ,
				icon_mipmaps = 4
			} ,
			{
				icon = SIGen.MakeSelfPicturePath( aliasPrefix .. SICommon.ShowNameSuffix.ICON ) ,
				icon_size = 256 ,
				icon_mipmaps = 4
			} ,
			subIcon
		} ,
		icon_size = 256 ,
		icon_mipmaps = 4 ,
		enabled = true ,
		hidden = false ,
		visible_when_disabled = true ,
		ignore_tech_cost_multiplier = true ,
		upgrade = true ,
		max_level = maxLevel ,
		prerequisites =
		{
			SIConstants_Expand.raw.Technologies.Infinite_1
		} ,
		unit =
		{
			count_formula = baseValue .. "*L" ,
			time = 60 ,
			ingredients =
			{
				{
					type = SICommon.Types.Items.Item ,
					name = SIConstants_Expand.raw.Items.FirstPack ,
					amount = 1
				}
			}
		} ,
		effects = effects
	}
	-- ----------------------------------------
	-- 无尽科技 - 第二产业
	-- ----------------------------------------
	.New( SICommon.Types.Technology , IDPrefix .. "_" .. 2 , aliasPrefix .. "-" .. ( maxLevel + 1 ) )
	.Append
	{
		localised_name = SIGen.MakeSelfLocalisedName( aliasPrefix ) ,
		localised_description = SIGen.MakeSelfLocalisedDescription( aliasPrefix ) ,
		icons =
		{
			{
				icon = SIGen.MakeSelfPicturePath( "无尽科技" .. SICommon.ShowNameSuffix.ICON ) ,
				icon_size = 256 ,
				icon_mipmaps = 4
			} ,
			{
				icon = SIGen.MakeSelfPicturePath( aliasPrefix .. SICommon.ShowNameSuffix.ICON ) ,
				icon_size = 256 ,
				icon_mipmaps = 4
			} ,
			subIcon
		} ,
		icon_size = 256 ,
		icon_mipmaps = 4 ,
		enabled = true ,
		hidden = false ,
		visible_when_disabled = true ,
		ignore_tech_cost_multiplier = true ,
		upgrade = true ,
		max_level = maxLevel * 2 ,
		prerequisites =
		{
			SIConstants_Expand.raw.Technologies[IDPrefix .. "_" .. 1] ,
			SIConstants_Expand.raw.Technologies.Infinite_2
		} ,
		unit =
		{
			count_formula = baseValue .. "*(L-" .. maxLevel .. ")" ,
			time = 75 ,
			ingredients =
			{
				{
					type = SICommon.Types.Items.Item ,
					name = SIConstants_Expand.raw.Items.SecondPack ,
					amount = 1
				}
			}
		} ,
		effects = effects
	}
	-- ----------------------------------------
	-- 无尽科技 - 第三产业
	-- ----------------------------------------
	.New( SICommon.Types.Technology , IDPrefix .. "_" .. 3 , aliasPrefix .. "-" .. ( maxLevel * 2 + 1 ) )
	.Append
	{
		localised_name = SIGen.MakeSelfLocalisedName( aliasPrefix ) ,
		localised_description = SIGen.MakeSelfLocalisedDescription( aliasPrefix ) ,
		icons =
		{
			{
				icon = SIGen.MakeSelfPicturePath( "无尽科技" .. SICommon.ShowNameSuffix.ICON ) ,
				icon_size = 256 ,
				icon_mipmaps = 4
			} ,
			{
				icon = SIGen.MakeSelfPicturePath( aliasPrefix .. SICommon.ShowNameSuffix.ICON ) ,
				icon_size = 256 ,
				icon_mipmaps = 4
			} ,
			subIcon
		} ,
		icon_size = 256 ,
		icon_mipmaps = 4 ,
		enabled = true ,
		hidden = false ,
		visible_when_disabled = true ,
		ignore_tech_cost_multiplier = true ,
		upgrade = true ,
		max_level = maxLevel * 3 ,
		prerequisites =
		{
			SIConstants_Expand.raw.Technologies[IDPrefix .. "_" .. 2] ,
			SIConstants_Expand.raw.Technologies.Infinite_3
		} ,
		unit =
		{
			count_formula = baseValue .. "*(L-" .. ( maxLevel * 2 ) .. ")" ,
			time = 95 ,
			ingredients =
			{
				{
					type = SICommon.Types.Items.Item ,
					name = SIConstants_Expand.raw.Items.ThirdPack ,
					amount = 1
				}
			}
		} ,
		effects = effects
	}
	-- ----------------------------------------
	-- 无尽科技 - 第四产业
	-- ----------------------------------------
	.New( SICommon.Types.Technology , IDPrefix .. "_" .. 4 , aliasPrefix .. "-" .. ( maxLevel * 3 + 1 ) )
	.Append
	{
		localised_name = SIGen.MakeSelfLocalisedName( aliasPrefix ) ,
		localised_description = SIGen.MakeSelfLocalisedDescription( aliasPrefix ) ,
		icons =
		{
			{
				icon = SIGen.MakeSelfPicturePath( "无尽科技" .. SICommon.ShowNameSuffix.ICON ) ,
				icon_size = 256 ,
				icon_mipmaps = 4
			} ,
			{
				icon = SIGen.MakeSelfPicturePath( aliasPrefix .. SICommon.ShowNameSuffix.ICON ) ,
				icon_size = 256 ,
				icon_mipmaps = 4
			} ,
			subIcon
		} ,
		icon_size = 256 ,
		icon_mipmaps = 4 ,
		enabled = true ,
		hidden = false ,
		visible_when_disabled = true ,
		ignore_tech_cost_multiplier = true ,
		upgrade = true ,
		max_level = maxLevel * 4 ,
		prerequisites =
		{
			SIConstants_Expand.raw.Technologies[IDPrefix .. "_" .. 3] ,
			SIConstants_Expand.raw.Technologies.Infinite_4
		} ,
		unit =
		{
			count_formula = baseValue .. "*(L-" .. ( maxLevel * 3 ) .. ")" ,
			time = 120 ,
			ingredients =
			{
				{
					type = SICommon.Types.Items.Item ,
					name = SIConstants_Expand.raw.Items.ForthPack ,
					amount = 1
				}
			}
		} ,
		effects = effects
	}
	-- ----------------------------------------
	-- 无尽科技 - 第五产业
	-- ----------------------------------------
	.New( SICommon.Types.Technology , IDPrefix .. "_" .. 5 , aliasPrefix .. "-" .. ( maxLevel * 4 + 1 ) )
	.Append
	{
		localised_name = SIGen.MakeSelfLocalisedName( aliasPrefix ) ,
		localised_description = SIGen.MakeSelfLocalisedDescription( aliasPrefix ) ,
		icons =
		{
			{
				icon = SIGen.MakeSelfPicturePath( "无尽科技" .. SICommon.ShowNameSuffix.ICON ) ,
				icon_size = 256 ,
				icon_mipmaps = 4
			} ,
			{
				icon = SIGen.MakeSelfPicturePath( aliasPrefix .. SICommon.ShowNameSuffix.ICON ) ,
				icon_size = 256 ,
				icon_mipmaps = 4
			} ,
			subIcon
		} ,
		icon_size = 256 ,
		icon_mipmaps = 4 ,
		enabled = true ,
		hidden = false ,
		visible_when_disabled = true ,
		ignore_tech_cost_multiplier = true ,
		upgrade = true ,
		max_level = maxLevel * 5 ,
		prerequisites =
		{
			SIConstants_Expand.raw.Technologies[IDPrefix .. "_" .. 4] ,
			SIConstants_Expand.raw.Technologies.Infinite_5
		} ,
		unit =
		{
			count_formula = baseValue .. "*(L-" .. ( maxLevel * 4 ) .. ")" ,
			time = 150 ,
			ingredients =
			{
				{
					type = SICommon.Types.Items.Item ,
					name = SIConstants_Expand.raw.Items.FifthPack ,
					amount = 1
				}
			}
		} ,
		effects = effects
	}
	-- ----------------------------------------
	-- 无尽科技 - 无尽产业
	-- ----------------------------------------
	.New( SICommon.Types.Technology , IDPrefix .. "_" .. 6 , aliasPrefix .. "-" .. ( maxLevel * 5 + 1 ) )
	.Append
	{
		localised_name = SIGen.MakeSelfLocalisedName( aliasPrefix ) ,
		localised_description = SIGen.MakeSelfLocalisedDescription( aliasPrefix ) ,
		icons =
		{
			{
				icon = SIGen.MakeSelfPicturePath( "无尽科技" .. SICommon.ShowNameSuffix.ICON ) ,
				icon_size = 256 ,
				icon_mipmaps = 4
			} ,
			{
				icon = SIGen.MakeSelfPicturePath( aliasPrefix .. SICommon.ShowNameSuffix.ICON ) ,
				icon_size = 256 ,
				icon_mipmaps = 4
			} ,
			subIcon
		} ,
		icon_size = 256 ,
		icon_mipmaps = 4 ,
		enabled = true ,
		hidden = false ,
		visible_when_disabled = true ,
		ignore_tech_cost_multiplier = true ,
		upgrade = true ,
		max_level = "infinite" ,
		prerequisites =
		{
			SIConstants_Expand.raw.Technologies[IDPrefix .. "_" .. 5] ,
			"space-science-pack"
		} ,
		unit =
		{
			count_formula = ( baseValue * 10 ) .. "*(L-" .. ( maxLevel * 5 ) .. ")^2" ,
			time = 200 ,
			ingredients =
			{
				{
					type = SICommon.Types.Items.Item ,
					name = SIConstants_Expand.raw.Items.FirstPack ,
					amount = 1
				} ,
				{
					type = SICommon.Types.Items.Item ,
					name = SIConstants_Expand.raw.Items.SecondPack ,
					amount = 1
				} ,
				{
					type = SICommon.Types.Items.Item ,
					name = SIConstants_Expand.raw.Items.ThirdPack ,
					amount = 1
				} ,
				{
					type = SICommon.Types.Items.Item ,
					name = SIConstants_Expand.raw.Items.ForthPack ,
					amount = 1
				} ,
				{
					type = SICommon.Types.Items.Item ,
					name = SIConstants_Expand.raw.Items.FifthPack ,
					amount = 1
				}
			}
		} ,
		effects = effects
	}
end

-- ----------------------------------------
-- 无尽科技 - 具体科技
-- ----------------------------------------
InfiniteTech( "Inserter" , "普通爪子" , 1 , SIGraphics.TechnologyIcon_Stack() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.InserterStackSizeBonus ,
		modifier = 1.0
	}
} )
InfiniteTech( "StackInserter" , "集装爪子" , 4 , SIGraphics.TechnologyIcon_Stack() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.StackInserterCapacityBonus ,
		modifier = 1.0
	}
} )
InfiniteTech( "Mining" , "开采" , 10 , SIGraphics.TechnologyIcon_Productivity() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.MiningDrillProductivityBonus ,
		modifier = 0.01
	}
} )
InfiniteTech( "Train" , "火车" , 10 , SIGraphics.TechnologyIcon_BrakingForce() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.TrainBrakingForceBonus ,
		modifier = 0.01
	}
} )
InfiniteTech( "LabSpeed" , "研究球速度" , 20 , SIGraphics.TechnologyIcon_Speed() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.LaboratorySpeed ,
		modifier = 0.02
	}
} )
InfiniteTech( "LabProductivity" , "研究球产能" , 5 , SIGraphics.TechnologyIcon_Productivity() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.LaboratoryProductivity ,
		modifier = 0.02
	}
} )
InfiniteTech( "RobotLifeTime" , "机器人存活时间" , 10 , SIGraphics.TechnologyIcon_Time() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.FollowerRobotLifetime ,
		modifier = 1.0
	}
} )
InfiniteTech( "RobotSpeed" , "机器人速度" , 20 , SIGraphics.TechnologyIcon_Move() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.WorkerRobotSpeed ,
		modifier = 0.02
	}
} )
InfiniteTech( "RobotContainer" , "机器人运货量" , 2 , SIGraphics.TechnologyIcon_Stack() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.WorkerRobotStorage ,
		modifier = 1.0
	}
} )
InfiniteTech( "RobotBattery" , "机器人电池容量" , 10 , SIGraphics.TechnologyIcon_Battery() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.WorkerRobotBattery ,
		modifier = 0.03
	}
} )
InfiniteTech( "CharacterHealth" , "角色生命" , 10 , SIGraphics.TechnologyIcon_Health() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.CharacterHealthBonus ,
		modifier = 4.0
	}
} )
InfiniteTech( "CharacterInventory" , "角色背包" , 10 , SIGraphics.TechnologyIcon_Stack() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.CharacterInventorySlotsBonus ,
		modifier = 1.0
	}
} )
InfiniteTech( "CharacterCrafting" , "角色组装" , 10 , SIGraphics.TechnologyIcon_Speed() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.CharacterCraftingSpeed ,
		modifier = 0.06
	}
} )
InfiniteTech( "CharacterMining" , "角色开采" , 10 , SIGraphics.TechnologyIcon_Speed() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.CharacterMiningSpeed ,
		modifier = 0.06
	}
} )
InfiniteTech( "CharacterMove" , "角色移动" , 10 , SIGraphics.TechnologyIcon_Move() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.CharacterRunningSpeed ,
		modifier = 0.01
	}
} )
InfiniteTech( "CharacterBuildDistance" , "角色建造距离" , 2 , SIGraphics.TechnologyIcon_Add() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.CharacterBuildDistance ,
		modifier = 1.0
	}
} )
InfiniteTech( "CharacterReachDistance" , "角色操作距离" , 2 , SIGraphics.TechnologyIcon_Add() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.CharacterReachDistance ,
		modifier = 1.0
	}
} )
InfiniteTech( "CharacterResourceDistance" , "角色资源距离" , 2 , SIGraphics.TechnologyIcon_Add() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.CharacterResourceReachDistance ,
		modifier = 1.0
	}
} )
InfiniteTech( "CharacterDropDistance" , "角色丢弃距离" , 2 , SIGraphics.TechnologyIcon_Add() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.CharacterItemDropDistance ,
		modifier = 1.0
	}
} )
InfiniteTech( "CharacterPickupDistance" , "角色拾取距离" , 2 , SIGraphics.TechnologyIcon_Add() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.CharacterItemPickupDistance ,
		modifier = 1.0
	}
} )
InfiniteTech( "CharacterLootDistance" , "角色战利品距离" , 2 , SIGraphics.TechnologyIcon_Add() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.CharacterLootPickupDistance ,
		modifier = 1.0
	}
} )
InfiniteTech( "WeaponAmmoDamage" , "武器子弹伤害" , 10 , SIGraphics.TechnologyIcon_Damage() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.AmmoDamage ,
		ammo_category = "bullet" ,
		modifier = 0.02
	} ,
	{
		type = SICommon.Flags.TechnologyModifier.AmmoDamage ,
		ammo_category = "shotgun-shell" ,
		modifier = 0.02
	}
} )
InfiniteTech( "WeaponAmmoTurret" , "武器子弹炮塔" , 10 , SIGraphics.TechnologyIcon_Robot() , {} )
InfiniteTech( "WeaponAmmoSpeed" , "武器子弹射速" , 10 , SIGraphics.TechnologyIcon_Speed() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.GunSpeed ,
		ammo_category = "bullet" ,
		modifier = 0.02
	} ,
	{
		type = SICommon.Flags.TechnologyModifier.GunSpeed ,
		ammo_category = "shotgun-shell" ,
		modifier = 0.02
	}
} )
InfiniteTech( "WeaponLaserDamage" , "武器激光伤害" , 10 , SIGraphics.TechnologyIcon_Damage() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.AmmoDamage ,
		ammo_category = "laser" ,
		modifier = 0.02
	} ,
	{
		type = SICommon.Flags.TechnologyModifier.AmmoDamage ,
		ammo_category = "beam" ,
		modifier = 0.02
	}
} )
InfiniteTech( "WeaponLaserTurret" , "武器激光炮塔" , 10 , SIGraphics.TechnologyIcon_Robot() , {} )
InfiniteTech( "WeaponLaserSpeed" , "武器激光射速" , 10 , SIGraphics.TechnologyIcon_Speed() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.GunSpeed ,
		ammo_category = "laser" ,
		modifier = 0.02
	} ,
	{
		type = SICommon.Flags.TechnologyModifier.GunSpeed ,
		ammo_category = "beam" ,
		modifier = 0.02
	}
} )
InfiniteTech( "WeaponExplosiveDamage" , "武器爆炸伤害" , 10 , SIGraphics.TechnologyIcon_Damage() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.AmmoDamage ,
		ammo_category = "rocket" ,
		modifier = 0.02
	} ,
	{
		type = SICommon.Flags.TechnologyModifier.AmmoDamage ,
		ammo_category = "grenade" ,
		modifier = 0.02
	} ,
	{
		type = SICommon.Flags.TechnologyModifier.AmmoDamage ,
		ammo_category = "cannon-shell" ,
		modifier = 0.02
	} ,
	{
		type = SICommon.Flags.TechnologyModifier.AmmoDamage ,
		ammo_category = "landmine" ,
		modifier = 0.02
	}
} )
InfiniteTech( "WeaponExplosiveTurret" , "武器爆炸炮塔" , 10 , SIGraphics.TechnologyIcon_Robot() , {} )
InfiniteTech( "WeaponExplosiveSpeed" , "武器爆炸射速" , 10 , SIGraphics.TechnologyIcon_Speed() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.GunSpeed ,
		ammo_category = "rocket" ,
		modifier = 0.02
	} ,
	{
		type = SICommon.Flags.TechnologyModifier.GunSpeed ,
		ammo_category = "grenade" ,
		modifier = 0.02
	} ,
	{
		type = SICommon.Flags.TechnologyModifier.GunSpeed ,
		ammo_category = "cannon-shell" ,
		modifier = 0.02
	} ,
	{
		type = SICommon.Flags.TechnologyModifier.GunSpeed ,
		ammo_category = "landmine" ,
		modifier = 0.02
	}
} )
InfiniteTech( "WeaponFlameDamage" , "武器燃烧伤害" , 10 , SIGraphics.TechnologyIcon_Damage() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.AmmoDamage ,
		ammo_category = "flamethrower" ,
		modifier = 0.02
	}
} )
InfiniteTech( "WeaponFlameTurret" , "武器燃烧炮塔" , 10 , SIGraphics.TechnologyIcon_Robot() , {} )
InfiniteTech( "WeaponFlameSpeed" , "武器燃烧射速" , 10 , SIGraphics.TechnologyIcon_Speed() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.GunSpeed ,
		ammo_category = "flamethrower" ,
		modifier = 0.02
	}
} )
InfiniteTech( "WeaponEnergyDamage" , "武器能量伤害" , 10 , SIGraphics.TechnologyIcon_Damage() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.AmmoDamage ,
		ammo_category = "electric" ,
		modifier = 0.02
	}
} )
InfiniteTech( "WeaponEnergyTurret" , "武器能量炮塔" , 10 , SIGraphics.TechnologyIcon_Robot() , {} )
InfiniteTech( "WeaponEnergySpeed" , "武器能量射速" , 10 , SIGraphics.TechnologyIcon_Speed() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.GunSpeed ,
		ammo_category = "electric" ,
		modifier = 0.02
	}
} )
InfiniteTech( "WeaponArtilleryDamage" , "武器重炮伤害" , 10 , SIGraphics.TechnologyIcon_Damage() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.AmmoDamage ,
		ammo_category = "artillery-shell" ,
		modifier = 0.02
	}
} )
InfiniteTech( "WeaponArtilleryTurret" , "武器重炮炮塔" , 10 , SIGraphics.TechnologyIcon_Robot() , {} )
InfiniteTech( "WeaponArtillerySpeed" , "武器重炮射速" , 10 , SIGraphics.TechnologyIcon_Speed() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.GunSpeed ,
		ammo_category = "artillery-shell" ,
		modifier = 0.02
	}
} )
InfiniteTech( "WeaponArtilleryRange" , "武器重炮射程" , 10 , SIGraphics.TechnologyIcon_Range() ,
{
	{
		type = SICommon.Flags.TechnologyModifier.ArtilleryRange ,
		modifier = 0.02
	}
} )
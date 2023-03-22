-- ------------------------------------------------------------------------------------------------
-- ------------ 装桶 ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local pipeDistance = 6
local animationShift = SIUtils.by_pixel( 0 , 0 )
local animationShadowShift = SIUtils.by_pixel( 2 , 0 )
local moduleSlot = 6

SIGen
.SetGroup( SIConstants_Expand.raw.Groups.Expand.MakeBarrel )

-- ----------------------------------------
-- 桶物品
-- ----------------------------------------
.New( SICommon.Types.Items.Item , "WoodenBarrel" , "木桶" ,
{
	stack_size = 100 ,
	place_result = nil
} )
.AutoIcon()
.New( SICommon.Types.Recipe , "WoodenBarrel" , "木桶" ,
{
	category = "crafting" ,
	crafting_machine_tint =
	{
		primary = { r = 0.70 , g = 0.40 , b = 0.10 } ,
		secondary = { r = 0.70 , g = 0.40 , b = 0.10 } ,
		tertiary = { r = 0.70 , g = 0.40 , b = 0.10 } ,
		quaternary = { r = 0.70 , g = 0.40 , b = 0.10 }
	} ,
	enabled = false ,
	hidden = false ,
	hide_from_stats = false ,
	hide_from_player_crafting = false ,
	energy_required = 8.0 ,
	ingredients =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = "wood" ,
			amount = 3
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "iron-plate" ,
			amount = 1
		}
	} ,
	results =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Expand.raw.Items.WoodenBarrel ,
			amount = 2 ,
			catalyst_amount = 2
		}
	} ,
	main_product = SIConstants_Expand.raw.Items.WoodenBarrel ,
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
	unlock_results = true
} )
.AutoIcon()
.New( SICommon.Types.Entities.SimpleOwner , "WoodenBarrel" , "木桶" )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceablePlayer , SICommon.Flags.Entity.PlayerCreation , SICommon.Flags.Entity.HideAltInfo } ,
	minable =
	{
		mining_time = 0.3 ,
		results =
		{
			{
				type = SICommon.Types.Items.item ,
				name = SIConstants_Expand.raw.Items.WoodenBarrel ,
				amount = 1
			}
		}
	} ,
	max_health = 35 ,
	corpse = "small-remnants" ,
	dying_explosion = "wall-explosion" ,
	map_color = { r = 0.70 , g = 0.70 , b = 0.70 } ,
	friendly_map_color = { r = 0.70 , g = 0.70 , b = 0.70 } ,
	enemy_map_color = { r = 0.70 , g = 0.70 , b = 0.70 } ,
	alert_when_damaged = true ,
	hide_resistances = true ,
	return_ingredients_on_change = false ,
	render_layer = SICommon.Flags.RenderLayer.Object ,
	alert_icon_shift = { 0 , 0 } ,
	pictures =
	{
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "木桶" ) ,
					priority = "extra-high" ,
					width = 32 ,
					height = 47 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 0 , -8.5 )
				} ,
				{
					filename = SIGen.MakeSelfPicturePath( "木桶-影子" ) ,
					priority = "extra-high" ,
					width = 65 ,
					height = 32 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 16.5 , 0 ) ,
					draw_as_shadow = true
				}
			}
		}
	} ,
	mined_sound =
	{
		{
			filename = "__core__/sound/deconstruct-small.ogg" ,
			volume = 1
		}
	} ,
	vehicle_impact_sound =
	{
		{
			filename = "__base__/sound/car-metal-impact.ogg" ,
			volume = 1
		}
	} ,
	repair_sound =
	{
		{
			filename = "__base__/sound/manual-repair-simple-1.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/manual-repair-simple-2.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/manual-repair-simple-3.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/manual-repair-simple-4.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/manual-repair-simple-5.ogg" ,
			volume = 0.5
		}
	} ,
	open_sound =
	{
		{
			filename = "__base__/sound/machine-open.ogg" ,
			volume = 0.5
		}
	} ,
	close_sound =
	{
		{
			filename = "__base__/sound/machine-close.ogg" ,
			volume = 0.5
		}
	}
}
.AutoIcon()
.SetSize( 1 , 1 )
.ReferencePlaceResult( SICommon.Types.Items.Item , SIConstants_Expand.raw.Items.WoodenBarrel )
.New( SICommon.Types.Items.Item , "PlasticCapable" , "塑料胶囊" ,
{
	stack_size = 1000
} )
.AutoIcon()
.New( SICommon.Types.Recipe , "PlasticCapable" , "塑料胶囊" ,
{
	category = "crafting" ,
	crafting_machine_tint =
	{
		primary = { r = 1.00 , g = 1.00 , b = 1.00 } ,
		secondary = { r = 1.00 , g = 1.00 , b = 1.00 } ,
		tertiary = { r = 1.00 , g = 1.00 , b = 1.00 } ,
		quaternary = { r = 1.00 , g = 1.00 , b = 1.00 }
	} ,
	enabled = false ,
	hidden = false ,
	hide_from_stats = false ,
	hide_from_player_crafting = false ,
	energy_required = 16.0 ,
	ingredients =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = "plastic-bar" ,
			amount = 1
		}
	} ,
	results =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Expand.raw.Items.PlasticCapable ,
			amount = 8 ,
			catalyst_amount = 8
		}
	} ,
	main_product = SIConstants_Expand.raw.Items.PlasticCapable ,
	emissions_multiplier = 0.6 ,
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
.New( SICommon.Types.Entities.SimpleOwner , "PlasticCapable" , "塑料胶囊" )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceablePlayer , SICommon.Flags.Entity.PlayerCreation , SICommon.Flags.Entity.HideAltInfo } ,
	minable =
	{
		mining_time = 0.2 ,
		results =
		{
			{
				type = SICommon.Types.Items.item ,
				name = SIConstants_Expand.raw.Items.PlasticCapable ,
				amount = 1
			}
		}
	} ,
	max_health = 35 ,
	corpse = "small-remnants" ,
	dying_explosion = "wall-explosion" ,
	map_color = { r = 0.80 , g = 0.80 , b = 0.80 } ,
	friendly_map_color = { r = 0.80 , g = 0.80 , b = 0.80 } ,
	enemy_map_color = { r = 0.80 , g = 0.80 , b = 0.80 } ,
	alert_when_damaged = true ,
	hide_resistances = true ,
	return_ingredients_on_change = false ,
	render_layer = SICommon.Flags.RenderLayer.Object ,
	alert_icon_shift = { 0 , 0 } ,
	pictures =
	{
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "塑料胶囊-1" ) ,
					priority = "extra-high" ,
					width = 32 ,
					height = 32 ,
					scale = 1.0
				} ,
				{
					filename = SIGen.MakeSelfPicturePath( "塑料胶囊-影子-1" ) ,
					priority = "extra-high" ,
					width = 48 ,
					height = 32 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 8 , 0 ) ,
					draw_as_shadow = true
				}
			}
		} ,
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "塑料胶囊-2" ) ,
					priority = "extra-high" ,
					width = 32 ,
					height = 32 ,
					scale = 1.0
				} ,
				{
					filename = SIGen.MakeSelfPicturePath( "塑料胶囊-影子-2" ) ,
					priority = "extra-high" ,
					width = 40 ,
					height = 32 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 4 , 0 ) ,
					draw_as_shadow = true
				}
			}
		} ,
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "塑料胶囊-3" ) ,
					priority = "extra-high" ,
					width = 32 ,
					height = 32 ,
					scale = 1.0
				} ,
				{
					filename = SIGen.MakeSelfPicturePath( "塑料胶囊-影子-3" ) ,
					priority = "extra-high" ,
					width = 40 ,
					height = 32 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 4 , 0 ) ,
					draw_as_shadow = true
				}
			}
		} ,
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "塑料胶囊-4" ) ,
					priority = "extra-high" ,
					width = 32 ,
					height = 32 ,
					scale = 1.0
				} ,
				{
					filename = SIGen.MakeSelfPicturePath( "塑料胶囊-影子-4" ) ,
					priority = "extra-high" ,
					width = 35 ,
					height = 32 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 1.5 , 0 ) ,
					draw_as_shadow = true
				}
			}
		}
	} ,
	mined_sound =
	{
		{
			filename = "__core__/sound/deconstruct-small.ogg" ,
			volume = 1
		}
	} ,
	vehicle_impact_sound =
	{
		{
			filename = "__base__/sound/car-metal-impact.ogg" ,
			volume = 1
		}
	} ,
	repair_sound =
	{
		{
			filename = "__base__/sound/manual-repair-simple-1.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/manual-repair-simple-2.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/manual-repair-simple-3.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/manual-repair-simple-4.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/manual-repair-simple-5.ogg" ,
			volume = 0.5
		}
	} ,
	open_sound =
	{
		{
			filename = "__base__/sound/machine-open.ogg" ,
			volume = 0.5
		}
	} ,
	close_sound =
	{
		{
			filename = "__base__/sound/machine-close.ogg" ,
			volume = 0.5
		}
	}
}
.AutoIcon()
.SetSizeSize( 1 , 1 , 0.5 )
.ReferencePlaceResult( SICommon.Types.Items.Item , SIConstants_Expand.raw.Items.PlasticCapable )

-- ----------------------------------------
-- 灌装和倾倒设备
-- ----------------------------------------
.New( SICommon.Types.Items.Item , "BarrelMaker" , "灌装设备" ,
{
	stack_size = 100 ,
	place_result = nil
} )
.AutoIcon()
.New( SICommon.Types.Recipe , "BarrelMaker" , "灌装设备" ,
{
	category = "crafting" ,
	crafting_machine_tint =
	{
		primary = { r = 0.50 , g = 0.50 , b = 0.50 } ,
		secondary = { r = 0.50 , g = 0.50 , b = 0.50 } ,
		tertiary = { r = 0.50 , g = 0.50 , b = 0.50 } ,
		quaternary = { r = 0.50 , g = 0.50 , b = 0.50 }
	} ,
	enabled = false ,
	hidden = false ,
	hide_from_stats = false ,
	hide_from_player_crafting = false ,
	energy_required = 5.0 ,
	ingredients =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = "iron-plate" ,
			amount = 8
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "iron-stick" ,
			amount = 4
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "iron-gear-wheel" ,
			amount = 4
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "copper-cable" ,
			amount = 9
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "electronic-circuit" ,
			amount = 3
		}
	} ,
	results =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Expand.raw.Items.BarrelMaker ,
			amount = 1 ,
			catalyst_amount = 1
		}
	} ,
	main_product = SIConstants_Expand.raw.Items.BarrelMaker ,
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
.AutoIcon()
.New( SICommon.Types.Entities.Furnace , "BarrelMaker" , "灌装设备" )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceablePlayer , SICommon.Flags.Entity.PlayerCreation } ,
	minable =
	{
		mining_time = 3.0 ,
		results =
		{
			{
				type = SICommon.Types.Items.item ,
				name = SIConstants_Expand.raw.Items.BarrelMaker ,
				amount = 1
			}
		}
	} ,
	max_health = 225 ,
	corpse = "small-scorchmark" ,
	dying_explosion = "medium-explosion" ,
	map_color = { r = 1.00 , g = 1.00 , b = 1.00 } ,
	friendly_map_color = { r = 0.40 , g = 0.40 , b = 1.00 } ,
	enemy_map_color = { r = 1.00 , g = 0.40 , b = 0.40 } ,
	alert_when_damaged = true ,
	create_ghost_on_death = true ,
	hide_resistances = true ,
	resistances =
	{
		{
			type = "fire" ,
			percent = 70
		} ,
		{
			type = "acid" ,
			percent = 50 ,
		}
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
		drain = "50J"
	} ,
	energy_usage = "22KW" ,
	allowed_effects =
	{
		"speed" ,
		"consumption" ,
		"pollution"
	} ,
	module_specification =
	{
		module_slots = moduleSlot ,
		module_info_icon_shift = { 0.0 , 0.8 }
	} ,
	base_productivity = 0 ,
	crafting_categories = { SIConstants_Expand.raw.Categories.Recipe.MakeBarrel } ,
	crafting_speed = 1.0 ,
	source_inventory_size = 1 ,
	result_inventory_size = 2 ,
	return_ingredients_on_change = false ,
	fluid_boxes =
	{
		off_when_no_fluid_recipe = false ,
		{
			production_type = SICommon.Flags.FluidBoxProductionType.Input ,
			base_area = 35 ,
			height = 1 ,
			base_level = 0 ,
			render_layer = SICommon.Flags.RenderLayer.Object ,
			hide_connection_info = true ,
			pipe_picture = nil ,
			pipe_covers = nil ,
			pipe_connections =
			{
				{
					type = SICommon.Flags.FluidBoxConnectionType.InputOutput ,
					max_underground_distance = pipeDistance ,
					position = { -0.5 , 1.5 }
				} ,
				{
					type = SICommon.Flags.FluidBoxConnectionType.InputOutput ,
					max_underground_distance = pipeDistance ,
					position = { 0.5 , 1.5 }
				} ,
				{
					type = SICommon.Flags.FluidBoxConnectionType.InputOutput ,
					max_underground_distance = pipeDistance ,
					position = { 1.5 , -0.5 }
				} ,
				{
					type = SICommon.Flags.FluidBoxConnectionType.InputOutput ,
					max_underground_distance = pipeDistance ,
					position = { 1.5 , 0.5 }
				} ,
				{
					type = SICommon.Flags.FluidBoxConnectionType.InputOutput ,
					max_underground_distance = pipeDistance ,
					position = { -1.5 , -0.5 }
				} ,
				{
					type = SICommon.Flags.FluidBoxConnectionType.InputOutput ,
					max_underground_distance = pipeDistance ,
					position = { -1.5 , 0.5 }
				} ,
				{
					type = SICommon.Flags.FluidBoxConnectionType.InputOutput ,
					max_underground_distance = pipeDistance ,
					position = { -0.5 , -1.5 }
				} ,
				{
					type = SICommon.Flags.FluidBoxConnectionType.InputOutput ,
					max_underground_distance = pipeDistance ,
					position = { 0.5 , -1.5 }
				}
			}
		}
	} ,
	show_recipe_icon = true ,
	scale_entity_info_icon = false ,
	show_recipe_icon_on_map = true ,
	entity_info_icon_shift = { 0.0 , -0.2 } ,
	alert_icon_shift = { 0 , 0 } ,
	animation =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "灌装设备" ) ,
				priority = "extra-high" ,
				width = 64 ,
				height = 64 ,
				frame_count = 6 ,
				line_length = 6 ,
				animation_speed = 1 ,
				scale = 1.0 ,
				shift = animationShift
			} ,
			{
				filename = SIGen.MakeSelfPicturePath( "灌装设备-影子" ) ,
				priority = "extra-high" ,
				width = 68 ,
				height = 64 ,
				frame_count = 1 ,
				line_length = 1 ,
				repeat_count = 6 ,
				animation_speed = 1 ,
				scale = 1.0 ,
				shift = animationShadowShift ,
				draw_as_shadow = true
			}
		}
	} ,
	always_draw_idle_animation = false ,
	idle_animation = nil ,
	working_visualisations =
	{
		{
			apply_recipe_tint = "primary" ,
			animation =
			{
				filename = SIGen.MakeSelfPicturePath( "灌装设备-罐子" ) ,
				priority = "high" ,
				width = 64 ,
				height = 64 ,
				frame_count = 1 ,
				line_length = 1 ,
				animation_speed = 1 ,
				scale = 1.0 ,
				shift = animationShift
			}
		}
	} ,
	default_recipe_tint =
	{
		primary = { r = 0.00 , g = 0.00 , b = 0.00 } ,
		secondary = { r = 0.00 , g = 0.00 , b = 0.00 } ,
		tertiary = { r = 0.00 , g = 0.00 , b = 0.00 } ,
		quaternary = { r = 0.00 , g = 0.00 , b = 0.00 }
	} ,
	mined_sound =
	{
		{
			filename = "__core__/sound/deconstruct-large.ogg" ,
			volume = 1
		}
	} ,
	vehicle_impact_sound =
	{
		{
			filename = "__base__/sound/car-metal-impact.ogg" ,
			volume = 1
		}
	} ,
	repair_sound =
	{
		{
			filename = "__core__/sound/manual-repair-advanced-1.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__core__/sound/manual-repair-advanced-2.ogg" ,
			volume = 0.5
		}
	} ,
	open_sound =
	{
		{
			filename = "__base__/sound/machine-open.ogg" ,
			volume = 0.5
		}
	} ,
	close_sound =
	{
		{
			filename = "__base__/sound/machine-close.ogg" ,
			volume = 0.5
		}
	} ,
	working_sound =
	{
		sound =
		{
			{
				filename = "__base__/sound/assembling-machine-t1-1.ogg" ,
				volume = 0.5
			}
		} ,
		audible_distance_modifier = 0.5 ,
		fade_in_ticks = 4 ,
		fade_out_ticks = 20
	}
}
.AutoIcon()
.SetSize( 2 , 2 )
.ReferencePlaceResult( SICommon.Types.Items.Item , SIConstants_Expand.raw.Items.BarrelMaker )
.New( SICommon.Types.Items.Item , "BarrelDropper" , "倾倒设备" ,
{
	stack_size = 100 ,
	place_result = nil
} )
.AutoIcon()
.New( SICommon.Types.Recipe , "BarrelDropper" , "倾倒设备" ,
{
	category = "crafting" ,
	crafting_machine_tint =
	{
		primary = { r = 0.50 , g = 0.50 , b = 0.50 } ,
		secondary = { r = 0.50 , g = 0.50 , b = 0.50 } ,
		tertiary = { r = 0.50 , g = 0.50 , b = 0.50 } ,
		quaternary = { r = 0.50 , g = 0.50 , b = 0.50 }
	} ,
	enabled = false ,
	hidden = false ,
	hide_from_stats = false ,
	hide_from_player_crafting = false ,
	energy_required = 5.0 ,
	ingredients =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = "iron-plate" ,
			amount = 8
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "iron-stick" ,
			amount = 4
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "iron-gear-wheel" ,
			amount = 4
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "copper-cable" ,
			amount = 9
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "electronic-circuit" ,
			amount = 3
		}
	} ,
	results =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Expand.raw.Items.BarrelDropper ,
			amount = 1 ,
			catalyst_amount = 1
		}
	} ,
	main_product = SIConstants_Expand.raw.Items.BarrelDropper ,
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
.AutoIcon()
.New( SICommon.Types.Entities.Furnace , "BarrelDropper" , "倾倒设备" )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceablePlayer , SICommon.Flags.Entity.PlayerCreation } ,
	minable =
	{
		mining_time = 3.0 ,
		results =
		{
			{
				type = SICommon.Types.Items.item ,
				name = SIConstants_Expand.raw.Items.BarrelDropper ,
				amount = 1
			}
		}
	} ,
	max_health = 225 ,
	corpse = "small-scorchmark" ,
	dying_explosion = "medium-explosion" ,
	map_color = { r = 1.00 , g = 1.00 , b = 1.00 } ,
	friendly_map_color = { r = 0.40 , g = 0.40 , b = 1.00 } ,
	enemy_map_color = { r = 1.00 , g = 0.40 , b = 0.40 } ,
	alert_when_damaged = true ,
	create_ghost_on_death = true ,
	hide_resistances = true ,
	resistances =
	{
		{
			type = "fire" ,
			percent = 70
		} ,
		{
			type = "acid" ,
			percent = 50 ,
		}
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
		drain = "50J"
	} ,
	energy_usage = "22KW" ,
	allowed_effects =
	{
		"speed" ,
		"consumption" ,
		"pollution"
	} ,
	module_specification =
	{
		module_slots = moduleSlot ,
		module_info_icon_shift = { 0.0 , 0.8 }
	} ,
	base_productivity = 0 ,
	crafting_categories = { SIConstants_Expand.raw.Categories.Recipe.DropBarrel } ,
	crafting_speed = 1.0 ,
	source_inventory_size = 1 ,
	result_inventory_size = 2 ,
	return_ingredients_on_change = false ,
	fluid_boxes =
	{
		off_when_no_fluid_recipe = false ,
		{
			production_type = SICommon.Flags.FluidBoxProductionType.Output ,
			base_area = 35 ,
			height = 1 ,
			base_level = 0 ,
			render_layer = SICommon.Flags.RenderLayer.Object ,
			hide_connection_info = true ,
			pipe_picture = nil ,
			pipe_covers = nil ,
			pipe_connections =
			{
				{
					type = SICommon.Flags.FluidBoxConnectionType.InputOutput ,
					max_underground_distance = pipeDistance ,
					position = { -0.5 , 1.5 }
				} ,
				{
					type = SICommon.Flags.FluidBoxConnectionType.InputOutput ,
					max_underground_distance = pipeDistance ,
					position = { 0.5 , 1.5 }
				} ,
				{
					type = SICommon.Flags.FluidBoxConnectionType.InputOutput ,
					max_underground_distance = pipeDistance ,
					position = { 1.5 , -0.5 }
				} ,
				{
					type = SICommon.Flags.FluidBoxConnectionType.InputOutput ,
					max_underground_distance = pipeDistance ,
					position = { 1.5 , 0.5 }
				} ,
				{
					type = SICommon.Flags.FluidBoxConnectionType.InputOutput ,
					max_underground_distance = pipeDistance ,
					position = { -1.5 , -0.5 }
				} ,
				{
					type = SICommon.Flags.FluidBoxConnectionType.InputOutput ,
					max_underground_distance = pipeDistance ,
					position = { -1.5 , 0.5 }
				} ,
				{
					type = SICommon.Flags.FluidBoxConnectionType.InputOutput ,
					max_underground_distance = pipeDistance ,
					position = { -0.5 , -1.5 }
				} ,
				{
					type = SICommon.Flags.FluidBoxConnectionType.InputOutput ,
					max_underground_distance = pipeDistance ,
					position = { 0.5 , -1.5 }
				}
			}
		}
	} ,
	show_recipe_icon = true ,
	scale_entity_info_icon = false ,
	show_recipe_icon_on_map = true ,
	entity_info_icon_shift = { 0.0 , -0.2 } ,
	alert_icon_shift = { 0 , 0 } ,
	animation =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "倾倒设备" ) ,
				priority = "extra-high" ,
				width = 64 ,
				height = 64 ,
				frame_count = 6 ,
				line_length = 6 ,
				animation_speed = 1 ,
				scale = 1.0 ,
				shift = animationShift
			} ,
			{
				filename = SIGen.MakeSelfPicturePath( "倾倒设备-影子" ) ,
				priority = "extra-high" ,
				width = 68 ,
				height = 64 ,
				frame_count = 1 ,
				line_length = 1 ,
				repeat_count = 6 ,
				animation_speed = 1 ,
				scale = 1.0 ,
				shift = animationShadowShift ,
				draw_as_shadow = true
			}
		}
	} ,
	always_draw_idle_animation = false ,
	idle_animation = nil ,
	working_visualisations =
	{
		{
			apply_recipe_tint = "primary" ,
			animation =
			{
				filename = SIGen.MakeSelfPicturePath( "倾倒设备-罐子" ) ,
				priority = "high" ,
				width = 64 ,
				height = 64 ,
				frame_count = 1 ,
				line_length = 1 ,
				animation_speed = 1 ,
				scale = 1.0 ,
				shift = animationShift
			}
		}
	} ,
	default_recipe_tint =
	{
		primary = { r = 0.00 , g = 0.00 , b = 0.00 } ,
		secondary = { r = 0.00 , g = 0.00 , b = 0.00 } ,
		tertiary = { r = 0.00 , g = 0.00 , b = 0.00 } ,
		quaternary = { r = 0.00 , g = 0.00 , b = 0.00 }
	} ,
	mined_sound =
	{
		{
			filename = "__core__/sound/deconstruct-large.ogg" ,
			volume = 1
		}
	} ,
	vehicle_impact_sound =
	{
		{
			filename = "__base__/sound/car-metal-impact.ogg" ,
			volume = 1
		}
	} ,
	repair_sound =
	{
		{
			filename = "__core__/sound/manual-repair-advanced-1.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__core__/sound/manual-repair-advanced-2.ogg" ,
			volume = 0.5
		}
	} ,
	open_sound =
	{
		{
			filename = "__base__/sound/machine-open.ogg" ,
			volume = 0.5
		}
	} ,
	close_sound =
	{
		{
			filename = "__base__/sound/machine-close.ogg" ,
			volume = 0.5
		}
	} ,
	working_sound =
	{
		sound =
		{
			{
				filename = "__base__/sound/assembling-machine-t1-1.ogg" ,
				volume = 0.5
			}
		} ,
		audible_distance_modifier = 0.5 ,
		fade_in_ticks = 4 ,
		fade_out_ticks = 20
	}
}
.AutoIcon()
.SetSize( 2 , 2 )
.ReferencePlaceResult( SICommon.Types.Items.Item , SIConstants_Expand.raw.Items.BarrelDropper )

-- ----------------------------------------
-- 灌装科技
-- ----------------------------------------
.New( SICommon.Types.Technology , "Barrel_1" , "灌装技术-1" ,
{
	enabled = true ,
	hidden = false ,
	visible_when_disabled = true ,
	ignore_tech_cost_multiplier = true ,
	upgrade = true ,
	prerequisites =
	{
		"steel-processing" ,
		"logistic-science-pack"
	} ,
	unit =
	{
		count = 100 ,
		time = 20 ,
		ingredients =
		{
			{
				type = SICommon.Types.Items.Item ,
				name = "automation-science-pack" ,
				amount = 2
			} ,
			{
				type = SICommon.Types.Items.Item ,
				name = "logistic-science-pack" ,
				amount = 1
			}
		}
	} ,
	effects =
	{
		{
			type = SICommon.Flags.TechnologyModifier.UnlockRecipe ,
			recipe = SIConstants_Expand.raw.Recipes.WoodenBarrel
		} ,
		{
			type = SICommon.Flags.TechnologyModifier.UnlockRecipe ,
			recipe = SIConstants_Expand.raw.Recipes.BarrelMaker
		} ,
		{
			type = SICommon.Flags.TechnologyModifier.UnlockRecipe ,
			recipe = SIConstants_Expand.raw.Recipes.BarrelDropper
		}
	}
} )
.AutoIcon()
.New( SICommon.Types.Technology , "Barrel_2" , "灌装技术-2" ,
{
	enabled = true ,
	hidden = false ,
	visible_when_disabled = true ,
	ignore_tech_cost_multiplier = true ,
	upgrade = true ,
	prerequisites =
	{
		"military-science-pack" ,
		"plastics" ,
		SIConstants_Expand.raw.Technologies.Barrel_1
	} ,
	unit =
	{
		count = 200 ,
		time = 40 ,
		ingredients =
		{
			{
				type = SICommon.Types.Items.Item ,
				name = "automation-science-pack" ,
				amount = 1
			} ,
			{
				type = SICommon.Types.Items.Item ,
				name = "logistic-science-pack" ,
				amount = 2
			} ,
			{
				type = SICommon.Types.Items.Item ,
				name = "military-science-pack" ,
				amount = 2
			}
		}
	} ,
	effects =
	{
		{
			type = SICommon.Flags.TechnologyModifier.UnlockRecipe ,
			recipe = SIConstants_Expand.raw.Recipes.PlasticCapable
		}
	}
} )
.AutoIcon()
.New( SICommon.Types.Technology , "Barrel_3" , "灌装技术-3" ,
{
	enabled = true ,
	hidden = false ,
	visible_when_disabled = true ,
	ignore_tech_cost_multiplier = true ,
	upgrade = true ,
	prerequisites =
	{
		"production-science-pack" ,
		SIConstants_Expand.raw.Technologies.Barrel_2
	} ,
	unit =
	{
		count = 400 ,
		time = 80 ,
		ingredients =
		{
			{
				type = SICommon.Types.Items.Item ,
				name = "automation-science-pack" ,
				amount = 1
			} ,
			{
				type = SICommon.Types.Items.Item ,
				name = "logistic-science-pack" ,
				amount = 1
			} ,
			{
				type = SICommon.Types.Items.Item ,
				name = "military-science-pack" ,
				amount = 1
			} ,
			{
				type = SICommon.Types.Items.Item ,
				name = "chemical-science-pack" ,
				amount = 2
			} ,
			{
				type = SICommon.Types.Items.Item ,
				name = "production-science-pack" ,
				amount = 4
			}
		}
	} ,
	effects = {}
} )
.AutoIcon()
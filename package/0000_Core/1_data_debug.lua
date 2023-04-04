-- ------------------------------------------------------------------------------------------------
-- -------- 创建调试物品 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local LaserSmallDamage = 6
local LaserLargeDamage = 10
local LaserLargeDamageDirect = 14

local maxHealth = 26000
local defaultResistances =
{
	SITools.Resistance( "physical" , 10 , 25 ) ,
	SITools.Resistance( "impact" , 0 , 98 ) ,
	SITools.Resistance( "poison" , 0 , 100 ) ,
	SITools.Resistance( "explosion" , 5 , 65 ) ,
	SITools.Resistance( "fire" , 0 , 100 ) ,
	SITools.Resistance( "laser" , 25 , 0 ) ,
	SITools.Resistance( "acid" , 0 , 100 ) ,
	SITools.Resistance( "electric" , 0 , 100 ) ,
}

local tankSize = SIConfigs.SICore.TankSize
local tankScale = 0.5 * tankSize
local tankShiftY = 6

SIGen
.SetGroup( SIConstants_Core.raw.Groups.Hidden.Debug )

-- ----------------------------------------
-- 量产之酥皮夹心糖果
-- ----------------------------------------
.New( SICommon.Types.Items.Tool , "Candy" , "量产之酥皮夹心糖果" )
.AutoIcon()
.Append
{
	flags = { SICommon.Flags.Item.Hidden } ,
	stack_size = 1000 ,
	default_request_amount = 1000 ,
	fuel_category = SIConstants_Core.raw.Categories.Fuel.Special ,
	fuel_value = "1J" ,
	fuel_acceleration_multiplier = 1.00 ,
	fuel_top_speed_multiplier = 1.00 ,
	fuel_emissions_multiplier = 520.00 ,
	fuel_glow_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	burnt_result = SIConstants_Core.raw.Items.Candy ,
	place_result = nil ,
	placed_as_equipment_result = nil ,
	rocket_launch_products =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			amount = 2 ,
			catalyst_amount = 2
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.2 ,
			amount_min = 0 ,
			amount_max = 20 ,
			catalyst_amount = 20
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.06 ,
			amount_min = 0 ,
			amount_max = 200 ,
			catalyst_amount = 200
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.02 ,
			amount_min = 0 ,
			amount_max = 2000 ,
			catalyst_amount = 2000
		}
	} ,
	durability = 1.0 ,
	durability_description_key = SICommon.Flags.SciencePack.Key ,
	durability_description_value = SICommon.Flags.SciencePack.Value
}
.New( SICommon.Types.Entities.SimpleOwner , "Candy" , "量产之酥皮夹心糖果" )
.AutoIcon()
.SetSize( 1 , 1 )
.ReferencePlaceResult( SICommon.Types.Items.Tool , SIConstants_Core.raw.Items.Candy )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceablePlayer , SICommon.Flags.Entity.PlayerCreation , SICommon.Flags.Entity.HideAltInfo , SICommon.Flags.Entity.Hidden } ,
	minable =
	{
		mining_time = 1.0 ,
		results =
		{
			{
				type = SICommon.Types.Items.Item ,
				name = SIConstants_Core.raw.Items.Candy ,
				amount = 1
			}
		}
	} ,
	max_health = 45 ,
	corpse = "small-remnants" ,
	dying_explosion = "nuke-explosion" ,
	map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	friendly_map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	enemy_map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	is_military_target = true ,
	allow_run_time_change_of_is_military_target = true ,
	alert_when_damaged = true ,
	create_ghost_on_death = false ,
	hide_resistances = true ,
	resistances = defaultResistances ,
	pictures =
	{
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "量产之酥皮夹心糖果" ) ,
					priority = "medium" ,
					width = 32 ,
					height = 32 ,
					scale = 1.0
				} ,
				{
					filename = SIGen.MakeSelfPicturePath( "量产之酥皮夹心糖果-影子" ) ,
					priority = "medium" ,
					width = 53 ,
					height = 36 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 10.5 , 2.5 ) ,
					draw_as_shadow = true
				}
			}
		}
	} ,
	mined_sound =
	{
		SISound.Core( "deconstruct-small" , 1 )
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
	}
}
.New( SICommon.Types.Equipments.Battery , "Candy" , "量产之酥皮夹心糖果" ,
{
	take_result = SIConstants_Core.raw.Items.Candy ,
	categories =
	{
		SIConstants_Core.raw.Categories.Equipment.Special
	} ,
	background_color = SICommon.Colors.Equipment.Building ,
	background_border_color = SICommon.Colors.Equipment.Border ,
	grabbed_background_color = SICommon.Colors.Equipment.BuildingHover ,
	shape =
	{
		type = SICommon.Flags.EquipmentShapeType.Full ,
		width = 2 ,
		height = 2
	} ,
	energy_source =
	{
		type = SICommon.Flags.EnergySourceType.Electric ,
		emissions_per_minute = 0 ,
		render_no_power_icon = false ,
		render_no_network_icon = false ,
		usage_priority = SICommon.Flags.ElectricUsagePriority.Tertiary ,
		buffer_capacity = "1EJ" ,
		input_flow_limit = "10TW" ,
		output_flow_limit = "10TW" ,
		drain = "0J"
	} ,
	sprite =
	{
		filename = SIGen.MakePicturePath( SICommon.Types.Items.Tool , "量产之酥皮夹心糖果" .. SICommon.ShowNameSuffix.ICON ) ,
		priority = "medium" ,
		width = 64 ,
		height = 64 ,
		scale = 1.0
	}
} )
.MakeIcon( SICommon.Types.Items.Tool , "量产之酥皮夹心糖果" , 64 , 4 )
.ReferenceEquipmentResult( SICommon.Types.Items.Tool , SIConstants_Core.raw.Items.Candy )

-- ----------------------------------------
-- 璀璨之闪耀能量罐头
-- ----------------------------------------
.New( SICommon.Types.Items.Item , "BrightBar" , "璀璨之闪耀能量罐头" )
.AutoIcon()
.Append
{
	flags = { SICommon.Flags.Item.Hidden } ,
	stack_size = 100 ,
	default_request_amount = 100 ,
	fuel_category = SIConstants_Core.raw.Categories.Fuel.Special ,
	fuel_value = "7.42EJ" ,
	fuel_acceleration_multiplier = 4.22 ,
	fuel_top_speed_multiplier = 1.47 ,
	fuel_emissions_multiplier = 1.18 ,
	fuel_glow_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	burnt_result = SIConstants_Core.raw.Items.Candy ,
	place_result = nil ,
	placed_as_equipment_result = nil ,
	rocket_launch_products =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			amount = 2 ,
			catalyst_amount = 2
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.2 ,
			amount_min = 0 ,
			amount_max = 20 ,
			catalyst_amount = 20
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.06 ,
			amount_min = 0 ,
			amount_max = 200 ,
			catalyst_amount = 200
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.02 ,
			amount_min = 0 ,
			amount_max = 2000 ,
			catalyst_amount = 2000
		}
	} ,
	pictures =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "璀璨之闪耀能量罐头-图标" ) ,
				size = 64 ,
				mipmap_count = 4 ,
				scale = 0.25
			} ,
			{
				filename = SIGen.MakeSelfPicturePath( "璀璨之闪耀能量罐头-光效" ) ,
				size = 64 ,
				mipmap_count = 4 ,
				scale = 0.25 ,
				draw_as_light = true ,
				flags = { "light" }
			}
		}
	}
}
.New( SICommon.Types.Entities.BurnerGenerator , "BrightBar" , "璀璨之闪耀能量罐头" )
.AutoIcon()
.SetSize( 5 , 5 )
.ReferencePlaceResult( SICommon.Types.Items.Item , SIConstants_Core.raw.Items.BrightBar )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceablePlayer , SICommon.Flags.Entity.PlayerCreation , SICommon.Flags.Entity.HideAltInfo , SICommon.Flags.Entity.Hidden } ,
	minable =
	{
		mining_time = 5.0 ,
		results =
		{
			{
				type = SICommon.Types.Items.Item ,
				name = SIConstants_Core.raw.Items.BrightBar ,
				amount = 1
			}
		}
	} ,
	max_health = maxHealth ,
	corpse = "nuclear-reactor-remnants" ,
	dying_explosion = "nuke-explosion" ,
	map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	friendly_map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	enemy_map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	is_military_target = false ,
	allow_run_time_change_of_is_military_target = true ,
	alert_when_damaged = true ,
	create_ghost_on_death = false ,
	hide_resistances = true ,
	resistances = defaultResistances ,
	damaged_trigger_effect =
	{
		type = "create-entity" ,
		entity_name = "spark-explosion" ,
		offset_deviation = { { -0.5 , -0.5 } , { 0.5 , 0.5 } } ,
		offsets = { { 0 , 1 } } ,
		damage_type_filters = "fire"
	} ,
	repair_speed_modifier = 12.0 ,
	energy_source =
	{
		type = SICommon.Flags.EnergySourceType.Electric ,
		emissions_per_minute = 10 ,
		render_no_power_icon = true ,
		render_no_network_icon = true ,
		usage_priority = SICommon.Flags.ElectricUsagePriority.OutputPrimary ,
		buffer_capacity = "5PJ" ,
		input_flow_limit = "5PW" ,
		output_flow_limit = "5PW" ,
		drain = "0J"
	} ,
	max_power_output = "3.35PW" ,
	burner =
	{
		type = SICommon.Flags.EnergySourceType.Burner ,
		emissions_per_minute = 10 ,
		render_no_power_icon = true ,
		render_no_network_icon = true ,
		fuel_inventory_size = 3 ,
		burnt_inventory_size = 3 ,
		effectivity = 2.5 ,
		fuel_categories =
		{
			"chemical" ,
			"nuclear" ,
			SIConstants_Core.raw.Categories.Fuel.Special
		} ,
		smoke =
		{
			{
				name = "tank-smoke" ,
				deviation = { 0.25 , 0.25 } ,
				frequency = 50 ,
				position = { 0 , 1.5 } ,
				starting_frame = 0 ,
				starting_frame_deviation = 60
			}
		} ,
		light_flicker = nil
	} ,
	animation =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "璀璨之闪耀能量罐头" ) ,
				priority = "extra-high" ,
				width = 160 ,
				height = 160 ,
				frame_count = 12 ,
				line_length = 6 ,
				animation_speed = 1 ,
				scale = 1.0
			} ,
			{
				filename = SIGen.MakeSelfPicturePath( "璀璨之闪耀能量罐头-影子" ) ,
				priority = "extra-high" ,
				width = 263 ,
				height = 162 ,
				frame_count = 1 ,
				line_length = 1 ,
				repeat_count = 12 ,
				animation_speed = 1 ,
				scale = 1.0 ,
				shift = { 1.625 , 0 } ,
				draw_as_shadow = true
			}
		}
	} ,
	always_draw_idle_animation = false ,
	idle_animation = nil ,
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
			SISound.Base( "nuclear-reactor-1" , 0.65 ) ,
			SISound.Base( "nuclear-reactor-2" , 0.65 )
		} ,
		max_sounds_per_type = 3 ,
		fade_in_ticks = 4 ,
		fade_out_ticks = 20
	}
}
.New( SICommon.Types.Equipments.GeneratorEquip , "BrightBar" , "璀璨之闪耀能量罐头" ,
{
	take_result = SIConstants_Core.raw.Items.BrightBar ,
	categories =
	{
		SIConstants_Core.raw.Categories.Equipment.Special
	} ,
	background_color = SICommon.Colors.Equipment.Generator ,
	background_border_color = SICommon.Colors.Equipment.Border ,
	grabbed_background_color = SICommon.Colors.Equipment.GeneratorHover ,
	shape =
	{
		type = SICommon.Flags.EquipmentShapeType.Full ,
		width = 2 ,
		height = 2
	} ,
	energy_source =
	{
		type = SICommon.Flags.EnergySourceType.Electric ,
		emissions_per_minute = 0 ,
		render_no_power_icon = false ,
		render_no_network_icon = false ,
		usage_priority = SICommon.Flags.ElectricUsagePriority.OutputPrimary ,
		buffer_capacity = "50TJ" ,
		input_flow_limit = "50TW" ,
		output_flow_limit = "50TW" ,
		drain = "0J"
	} ,
	power = "33.5TW" ,
	burner = nil ,
	sprite =
	{
		filename = SIGen.MakePicturePath( SICommon.Types.Items.Item , "璀璨之闪耀能量罐头" .. SICommon.ShowNameSuffix.ICON ) ,
		priority = "medium" ,
		width = 64 ,
		height = 64 ,
		scale = 1.0
	}
} )
.MakeIcon( SICommon.Types.Items.Item , "璀璨之闪耀能量罐头" , 64 , 4 )
.ReferenceEquipmentResult( SICommon.Types.Items.Item , SIConstants_Core.raw.Items.BrightBar )

-- ----------------------------------------
-- 奇妙之双鱼螺旋插件
-- ----------------------------------------
.New( SICommon.Types.Items.Module , "FishModule" , "奇妙之双鱼螺旋插件" )
.AutoIcon()
.Append
{
	flags = { SICommon.Flags.Item.Hidden } ,
	stack_size = 100 ,
	default_request_amount = 100 ,
	fuel_category = SIConstants_Core.raw.Categories.Fuel.Special ,
	fuel_value = "520KJ" ,
	fuel_acceleration_multiplier = 4.91 ,
	fuel_top_speed_multiplier = 1.76 ,
	fuel_emissions_multiplier = 74.45 ,
	fuel_glow_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	burnt_result = SIConstants_Core.raw.Items.Candy ,
	place_result = nil ,
	placed_as_equipment_result = nil ,
	rocket_launch_products =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			amount = 2 ,
			catalyst_amount = 2
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.2 ,
			amount_min = 0 ,
			amount_max = 20 ,
			catalyst_amount = 20
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.06 ,
			amount_min = 0 ,
			amount_max = 200 ,
			catalyst_amount = 200
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.02 ,
			amount_min = 0 ,
			amount_max = 2000 ,
			catalyst_amount = 2000
		}
	} ,
	category = SIConstants_Core.raw.Categories.Module.FishModule ,
	tier = 1 ,
	effect =
	{
		speed = { bonus = 14 } ,
		productivity = { bonus = 3 } ,
		consumption = { bonus = -9 } ,
		pollution = { bonus = -9 }
	} ,
	beacon_tint =
	{
		primary = { 0.441 , 0.714 , 1 , 1 } ,
		secondary = { 0.388 , 0.976 , 1 , 1 }
	} ,
	art_style = "vanilla" ,
	requires_beacon_alt_mode = false
}
.New( SICommon.Types.Entities.Beacon , "FishModule" , "奇妙之双鱼螺旋插件" )
.AutoIcon()
.SetSize( 3 , 3 )
.ReferencePlaceResult( SICommon.Types.Items.Module , SIConstants_Core.raw.Items.FishModule )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceablePlayer , SICommon.Flags.Entity.PlayerCreation , SICommon.Flags.Entity.Hidden } ,
	minable =
	{
		mining_time = 5.0 ,
		results =
		{
			{
				type = SICommon.Types.Items.Item ,
				name = SIConstants_Core.raw.Items.FishModule ,
				amount = 1
			}
		}
	} ,
	max_health = maxHealth ,
	corpse = "beacon-remnants" ,
	dying_explosion = "nuke-explosion" ,
	map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	friendly_map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	enemy_map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	is_military_target = false ,
	allow_run_time_change_of_is_military_target = true ,
	alert_when_damaged = true ,
	create_ghost_on_death = false ,
	hide_resistances = true ,
	resistances = defaultResistances ,
	damaged_trigger_effect =
	{
		type = "create-entity" ,
		entity_name = "spark-explosion" ,
		offset_deviation = { { -0.5 , -0.5 } , { 0.5 , 0.5 } } ,
		offsets = { { 0 , 1 } } ,
		damage_type_filters = "fire"
	} ,
	repair_speed_modifier = 12.0 ,
	energy_source =
	{
		type = SICommon.Flags.EnergySourceType.Void
	} ,
	energy_usage = "1TW" ,
	allowed_effects =
	{
		"speed" ,
		"productivity" ,
		"consumption" ,
		"pollution"
	} ,
	module_specification =
	{
		module_slots = 105 , -- 插件槽界面每行 15 个 , 物品信息概要存储每行 7 个 , 取最小公约数 15 * 7 = 105 个
		module_info_icon_shift = { 0.0 , 0.0 } ,
		module_info_multi_row_initial_height_modifier = -0.3 ,
		module_info_max_icons_per_row = 4
	} ,
	supply_area_distance = 64 ,
	distribution_effectivity = 1.0 ,
	graphics_set =
	{
		module_icons_suppressed = true ,
		animation_progress = 1 ,
		min_animation_progress = 0 ,
		module_tint_mode = "mix" ,
		no_modules_tint = { r = 1.00 , g = 0.00 , b = 0.00 } ,
		random_animation_offset = true ,
		apply_module_tint = "secondary" ,
		apply_module_tint_to_light = "none" ,
		animation_list =
		{
			{
				render_layer = SICommon.Flags.RenderLayer.FloorMechanics ,
				always_draw = true ,
				animation =
				{
					layers =
					{
						{
							filename = SIGen.MakeSelfPicturePath( "奇妙之双鱼螺旋插件" ) ,
							priority = "medium" ,
							width = 106 ,
							height = 96 ,
							shift = SIUtils.by_pixel( 0 , 1 )
						} ,
						{
							filename = SIGen.MakeSelfPicturePath( "奇妙之双鱼螺旋插件-影子" ) ,
							priority = "medium" ,
							width = 122 ,
							height = 90 ,
							shift = SIUtils.by_pixel( 12 , 1 ) ,
							draw_as_shadow = true
						}
					}
				}
			} ,
			{
				render_layer = SICommon.Flags.RenderLayer.Object ,
				always_draw = true ,
				animation =
				{
					layers =
					{
						{
							filename = SIGen.MakeSelfPicturePath( "奇妙之双鱼螺旋插件-顶部" ) ,
							priority = "medium" ,
							width = 48 ,
							height = 70 ,
							repeat_count = 45 ,
							animation_speed = 0.5 ,
							shift = SIUtils.by_pixel( 3 , -19 )
						}
					}
				}
			} ,
			{
				render_layer = SICommon.Flags.RenderLayer.Object ,
				always_draw = false ,
				apply_tint = true ,
				draw_as_sprite = true ,
				draw_as_light = true ,
				animation =
				{
					layers =
					{
						{
							filename = SIGen.MakeSelfPicturePath( "奇妙之双鱼螺旋插件-光效" ) ,
							priority = "medium" ,
							blend_mode = "additive" ,
							width = 56 ,
							height = 94 ,
							frame_count = 45 ,
							line_length = 9 ,
							animation_speed = 0.5 ,
							shift = SIUtils.by_pixel( 1 , -18 )
						}
					}
				}
			}
		} ,
		module_visualisations =
		{
			{
				art_style = "vanilla" ,
				use_for_empty_slots = true ,
				tier_offset = 0 ,
				slots =
				{
					-- 格子 1
					{
						{
							render_layer = SICommon.Flags.RenderLayer.LowerObject ,
							has_empty_slot = true ,
							pictures =
							{
								{
									layers =
									{
										{
											filename = SIGen.MakeSelfPicturePath( "奇妙之双鱼螺旋插件-插件-格子-1" ) ,
											priority = "medium" ,
											width = 26 ,
											height = 34 ,
											line_length = 4 ,
											variation_count = 4 ,
											shift = SIUtils.by_pixel( -16 , 15 )
										}
									}
								}
							}
						} ,
						{
							render_layer = SICommon.Flags.RenderLayer.LowerObject ,
							apply_module_tint = "primary" ,
							pictures =
							{
								{
									layers =
									{
										{
											filename = SIGen.MakeSelfPicturePath( "奇妙之双鱼螺旋插件-插件-盒子-1" ) ,
											priority = "medium" ,
											width = 18 ,
											height = 16 ,
											line_length = 3 ,
											variation_count = 3 ,
											shift = SIUtils.by_pixel( -17 , 15 )
										}
									}
								}
							}
						} ,
						{
							render_layer = SICommon.Flags.RenderLayer.LowerObjectAboveShadow ,
							apply_module_tint = "secondary" ,
							pictures =
							{
								{
									layers =
									{
										{
											filename = SIGen.MakeSelfPicturePath( "奇妙之双鱼螺旋插件-插件-灯泡-1" ) ,
											priority = "medium" ,
											width = 14 ,
											height = 6 ,
											line_length = 3 ,
											variation_count = 3 ,
											shift = SIUtils.by_pixel( -18 , 13 )
										}
									}
								}
							}
						} ,
						{
							apply_module_tint = "secondary" ,
							draw_as_light = true ,
							draw_as_sprite = false ,
							pictures =
							{
								{
									layers =
									{
										{
											filename = SIGen.MakeSelfPicturePath( "奇妙之双鱼螺旋插件-插件-光效-1" ) ,
											priority = "medium" ,
											width = 28 ,
											height = 22 ,
											line_length = 3 ,
											variation_count = 3 ,
											shift = SIUtils.by_pixel( -18 , 13 )
										}
									}
								}
							}
						}
					} ,
					-- 格子 2
					{
						{
							render_layer = SICommon.Flags.RenderLayer.LowerObject ,
							has_empty_slot = true ,
							pictures =
							{
								{
									layers =
									{
										{
											filename = SIGen.MakeSelfPicturePath( "奇妙之双鱼螺旋插件-插件-格子-2" ) ,
											priority = "medium" ,
											width = 24 ,
											height = 22 ,
											line_length = 4 ,
											variation_count = 4 ,
											shift = SIUtils.by_pixel( 19 , -12 )
										}
									}
								}
							}
						} ,
						{
							render_layer = SICommon.Flags.RenderLayer.LowerObject ,
							apply_module_tint = "primary" ,
							pictures =
							{
								{
									layers =
									{
										{
											filename = SIGen.MakeSelfPicturePath( "奇妙之双鱼螺旋插件-插件-盒子-2" ) ,
											priority = "medium" ,
											width = 18 ,
											height = 14 ,
											line_length = 3 ,
											variation_count = 3 ,
											shift = SIUtils.by_pixel( 20 , -12 )
										}
									}
								}
							}
						} ,
						{
							render_layer = SICommon.Flags.RenderLayer.LowerObjectAboveShadow ,
							apply_module_tint = "secondary" ,
							pictures =
							{
								{
									layers =
									{
										{
											filename = SIGen.MakeSelfPicturePath( "奇妙之双鱼螺旋插件-插件-灯泡-2" ) ,
											priority = "medium" ,
											width = 12 ,
											height = 8 ,
											line_length = 3 ,
											variation_count = 3 ,
											shift = SIUtils.by_pixel( 22 , -15 )
										}
									}
								}
							}
						} ,
						{
							apply_module_tint = "secondary" ,
							draw_as_light = true ,
							draw_as_sprite = false ,
							pictures =
							{
								{
									layers =
									{
										{
											filename = SIGen.MakeSelfPicturePath( "奇妙之双鱼螺旋插件-插件-光效-2" ) ,
											priority = "medium" ,
											width = 34 ,
											height = 24 ,
											line_length = 3 ,
											variation_count = 3 ,
											shift = SIUtils.by_pixel( 22 , -16 )
										}
									}
								}
							}
						}
					}
				}
			}
		}
	} ,
	radius_visualisation_picture =
	{
		filename = SIGen.MakeSelfPicturePath( "奇妙之双鱼螺旋插件-范围" ) ,
		priority = "extra-high-no-scale" ,
		width = 10 ,
		height = 10
	} ,
	water_reflection =
	{
		rotate = false ,
		orientation_to_variation = false ,
		pictures =
		{
			filename = SIGen.MakeSelfPicturePath( "奇妙之双鱼螺旋插件-反射" ) ,
			priority = "extra-high" ,
			width = 24 ,
			height = 28 ,
			variation_count = 1 ,
			scale = 5.0 ,
			shift = SIUtils.by_pixel( 0 , 55 )
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
			SISound.Base( "beacon-1" , 0.25 ) ,
			SISound.Base( "beacon-2" , 0.25 )
		} ,
		audible_distance_modifier = 0.33 ,
		max_sounds_per_type = 3
	}
}
.New( SICommon.Types.Equipments.Movement , "FishModule" , "奇妙之双鱼螺旋插件" ,
{
	take_result = SIConstants_Core.raw.Items.FishModule ,
	categories =
	{
		SIConstants_Core.raw.Categories.Equipment.Special
	} ,
	background_color = SICommon.Colors.Equipment.Modify ,
	background_border_color = SICommon.Colors.Equipment.Border ,
	grabbed_background_color = SICommon.Colors.Equipment.ModifyHover ,
	shape =
	{
		type = SICommon.Flags.EquipmentShapeType.Full ,
		width = 2 ,
		height = 2
	} ,
	energy_source =
	{
		type = SICommon.Flags.EnergySourceType.Electric ,
		emissions_per_minute = 0 ,
		render_no_power_icon = false ,
		render_no_network_icon = false ,
		usage_priority = SICommon.Flags.ElectricUsagePriority.InputSecondary ,
		buffer_capacity = "50TJ" ,
		input_flow_limit = "10TW" ,
		output_flow_limit = "10TW" ,
		drain = "0J"
	} ,
	energy_consumption = "1TW" ,
	movement_bonus = 1.0 ,
	sprite =
	{
		filename = SIGen.MakePicturePath( SICommon.Types.Items.Module , "奇妙之双鱼螺旋插件" .. SICommon.ShowNameSuffix.ICON ) ,
		priority = "medium" ,
		width = 64 ,
		height = 64 ,
		scale = 1.0
	}
} )
.MakeIcon( SICommon.Types.Items.Module , "奇妙之双鱼螺旋插件" , 64 , 4 )
.ReferenceEquipmentResult( SICommon.Types.Items.Module , SIConstants_Core.raw.Items.FishModule )

-- ----------------------------------------
-- 洞察之一览无余雷达
-- ----------------------------------------
.New( SICommon.Types.Items.Item , "LookRadar" , "洞察之一览无余雷达" )
.AutoIcon()
.Append
{
	flags = { SICommon.Flags.Item.Hidden } ,
	stack_size = 100 ,
	default_request_amount = 100 ,
	fuel_category = SIConstants_Core.raw.Categories.Fuel.Special ,
	fuel_value = "1MJ" ,
	fuel_acceleration_multiplier = 1.20 ,
	fuel_top_speed_multiplier = 1.20 ,
	fuel_emissions_multiplier = 85.55 ,
	fuel_glow_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	burnt_result = SIConstants_Core.raw.Items.Candy ,
	place_result = nil ,
	placed_as_equipment_result = nil ,
	rocket_launch_products =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			amount = 2 ,
			catalyst_amount = 2
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.2 ,
			amount_min = 0 ,
			amount_max = 20 ,
			catalyst_amount = 20
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.06 ,
			amount_min = 0 ,
			amount_max = 200 ,
			catalyst_amount = 200
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.02 ,
			amount_min = 0 ,
			amount_max = 2000 ,
			catalyst_amount = 2000
		}
	}
}
.New( SICommon.Types.Entities.Radar , "LookRadar" , "洞察之一览无余雷达" )
.AutoIcon()
.SetSize( 4 , 4 )
.ReferencePlaceResult( SICommon.Types.Items.Item , SIConstants_Core.raw.Items.LookRadar )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceablePlayer , SICommon.Flags.Entity.PlayerCreation , SICommon.Flags.Entity.Hidden } ,
	minable =
	{
		mining_time = 5.0 ,
		results =
		{
			{
				type = SICommon.Types.Items.Item ,
				name = SIConstants_Core.raw.Items.LookRadar ,
				amount = 1
			}
		}
	} ,
	max_health = maxHealth ,
	corpse = "radar-remnants" ,
	dying_explosion = "nuke-explosion" ,
	map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	friendly_map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	enemy_map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	is_military_target = false ,
	allow_run_time_change_of_is_military_target = true ,
	alert_when_damaged = true ,
	create_ghost_on_death = false ,
	hide_resistances = true ,
	resistances = defaultResistances ,
	damaged_trigger_effect =
	{
		type = "create-entity" ,
		entity_name = "spark-explosion" ,
		offset_deviation = { { -0.5 , -0.5 } , { 0.5 , 0.5 } } ,
		offsets = { { 0 , 1 } } ,
		damage_type_filters = "fire"
	} ,
	repair_speed_modifier = 12.0 ,
	energy_source =
	{
		type = SICommon.Flags.EnergySourceType.Void
	} ,
	energy_usage = "1TW" ,
	energy_per_nearby_scan = "2TJ" ,
	energy_per_sector = "1EJ" ,
	max_distance_of_nearby_sector_revealed = 160 ,
	max_distance_of_sector_revealed = 0 ,
	rotation_speed = 0.01 ,
	radius_minimap_visualisation_color = { r = 1.00 , g = 0.94 , b = 0.46 , a = 0.28 } ,
	pictures =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "洞察之一览无余雷达" ) ,
				priority = "low" ,
				width = 98 ,
				height = 128 ,
				line_length = 8 ,
				direction_count = 64 ,
				shift = SIUtils.by_pixel( 1 , -16 ) ,
				apply_projection = false
			} ,
			{
				filename = SIGen.MakeSelfPicturePath( "洞察之一览无余雷达-影子" ) ,
				priority = "low" ,
				width = 172 ,
				height = 94 ,
				line_length = 8 ,
				direction_count = 64 ,
				shift = SIUtils.by_pixel( 39 , 3 ) ,
				draw_as_shadow = true ,
				apply_projection = false
			}
		}
	} ,
	integration_patch =
	{
		filename = SIGen.MakeSelfPicturePath( "洞察之一览无余雷达-结合" ) ,
		priority = "low" ,
		width = 119 ,
		height = 108 ,
		direction_count = 1 ,
		shift = SIUtils.by_pixel( 1.5 , 4 )
	} ,
	water_reflection =
	{
		rotate = false ,
		orientation_to_variation = false ,
		pictures =
		{
			filename = SIGen.MakeSelfPicturePath( "洞察之一览无余雷达-反射" ) ,
			priority = "extra-high" ,
			width = 28 ,
			height = 32 ,
			variation_count = 1 ,
			scale = 5.0 ,
			shift = SIUtils.by_pixel( 5 , 35 )
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
			SISound.Base( "radar" , 0.7 )
		} ,
		use_doppler_shift = false ,
		max_sounds_per_type = 3
	}
}
.New( SICommon.Types.Equipments.Night , "LookRadar" , "洞察之一览无余雷达" ,
{
	take_result = SIConstants_Core.raw.Items.LookRadar ,
	categories =
	{
		SIConstants_Core.raw.Categories.Equipment.Special
	} ,
	background_color = SICommon.Colors.Equipment.Building ,
	background_border_color = SICommon.Colors.Equipment.Border ,
	grabbed_background_color = SICommon.Colors.Equipment.BuildingHover ,
	shape =
	{
		type = SICommon.Flags.EquipmentShapeType.Full ,
		width = 2 ,
		height = 2
	} ,
	energy_source =
	{
		type = SICommon.Flags.EnergySourceType.Electric ,
		emissions_per_minute = 0 ,
		render_no_power_icon = false ,
		render_no_network_icon = false ,
		usage_priority = SICommon.Flags.ElectricUsagePriority.InputSecondary ,
		buffer_capacity = "50TJ" ,
		input_flow_limit = "10TW" ,
		output_flow_limit = "10TW" ,
		drain = "0J"
	} ,
	energy_input = "1TW" ,
	darkness_to_turn_on = 0.7 ,
	color_lookup =
	{
		{
			1.0 ,
			SIGen.MakeRawPicturePath( "世界光线-洞察之一览无余雷达" )
		}
	} ,
	sprite =
	{
		filename = SIGen.MakePicturePath( SICommon.Types.Items.Item , "洞察之一览无余雷达" .. SICommon.ShowNameSuffix.ICON ) ,
		priority = "medium" ,
		width = 64 ,
		height = 64 ,
		scale = 1.0
	} ,
	activate_sound =
	{
		SISound.Base( "nightvision-on" , 0.6 )
	} ,
	deactivate_sound =
	{
		SISound.Base( "nightvision-off" , 0.6 )
	}
} )
.MakeIcon( SICommon.Types.Items.Item , "洞察之一览无余雷达" , 64 , 4 )
.ReferenceEquipmentResult( SICommon.Types.Items.Item , SIConstants_Core.raw.Items.LookRadar )

-- ----------------------------------------
-- 集成之指点江山平台
-- ----------------------------------------
.New( SICommon.Types.Items.Item , "Roboport" , "集成之指点江山平台" )
.AutoIcon()
.Append
{
	flags = { SICommon.Flags.Item.Hidden } ,
	stack_size = 10 ,
	default_request_amount = 10 ,
	fuel_category = SIConstants_Core.raw.Categories.Fuel.Special ,
	fuel_value = "1MJ" ,
	fuel_acceleration_multiplier = 1.24 ,
	fuel_top_speed_multiplier = 1.12 ,
	fuel_emissions_multiplier = 99.99 ,
	fuel_glow_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	burnt_result = SIConstants_Core.raw.Items.Candy ,
	place_result = nil ,
	placed_as_equipment_result = nil ,
	rocket_launch_products =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			amount = 2 ,
			catalyst_amount = 2
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.2 ,
			amount_min = 0 ,
			amount_max = 20 ,
			catalyst_amount = 20
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.06 ,
			amount_min = 0 ,
			amount_max = 200 ,
			catalyst_amount = 200
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.02 ,
			amount_min = 0 ,
			amount_max = 2000 ,
			catalyst_amount = 2000
		}
	}
}
.New( SICommon.Types.Entities.Roboport , "Roboport" , "集成之指点江山平台" )
.AutoIcon()
.SetSize( 4 , 4 )
.ReferencePlaceResult( SICommon.Types.Items.Item , SIConstants_Core.raw.Items.Roboport )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceablePlayer , SICommon.Flags.Entity.PlayerCreation , SICommon.Flags.Entity.Hidden } ,
	minable =
	{
		mining_time = 5.0 ,
		results =
		{
			{
				type = SICommon.Types.Items.Item ,
				name = SIConstants_Core.raw.Items.Roboport ,
				amount = 1
			}
		}
	} ,
	max_health = maxHealth ,
	corpse = "roboport-remnants" ,
	dying_explosion = "nuke-explosion" ,
	map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	friendly_map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	enemy_map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	is_military_target = false ,
	allow_run_time_change_of_is_military_target = true ,
	alert_when_damaged = true ,
	create_ghost_on_death = false ,
	hide_resistances = true ,
	resistances = defaultResistances ,
	damaged_trigger_effect =
	{
		type = "create-entity" ,
		entity_name = "spark-explosion" ,
		offset_deviation = { { -0.5 , -0.5 } , { 0.5 , 0.5 } } ,
		offsets = { { 0 , 1 } } ,
		damage_type_filters = "fire"
	} ,
	repair_speed_modifier = 12.0 ,
	energy_source =
	{
		type = SICommon.Flags.EnergySourceType.Void
	} ,
	energy_usage = "1TW" ,
	construction_radius = 3000 ,
	logistics_radius = 60 ,
	logistics_connection_distance = 60 ,
	robot_slots_count = 7 ,
	material_slots_count = 7 ,
	stationing_offset = { 0.0 , 0.0 } ,
	robot_limit = 10000 ,
	robot_vertical_acceleration = 0.01 ,
	robots_shrink_when_entering_and_exiting = true ,
	spawn_and_station_height = -0.1 ,
	spawn_and_station_shadow_height_offset = 0 ,
	recharge_minimum = "1TJ" ,
	charge_approach_distance = 3 ,
	charging_energy = "1GW" ,
	charging_station_count = 50 ,
	charging_station_shift = { 0.0 , 0.0 } ,
	charging_distance = 2.5 ,
	charging_threshold_distance = 10.0 ,
	charging_offsets = { { 0.0 , 0.0 } } ,
	request_to_open_door_timeout = 15 ,
	circuit_wire_connection_point = circuit_connector_definitions.roboport.points ,
	circuit_connector_sprites = circuit_connector_definitions.roboport.sprites ,
	circuit_wire_max_distance = 10 ,
	default_available_logistic_output_signal = { type = "virtual" , name = "signal-X" } ,
	default_total_logistic_output_signal = { type = "virtual" , name = "signal-Y" } ,
	default_available_construction_output_signal = { type = "virtual" , name = "signal-Z" } ,
	default_total_construction_output_signal = { type = "virtual" , name = "signal-T" } ,
	draw_circuit_wires = true ,
	draw_copper_wires = true ,
	draw_construction_radius_visualization = true ,
	draw_logistic_radius_visualization = true ,
	open_door_trigger_effect =
	{
		{
			type = "play-sound" ,
			sound =
			{
				SISound.Base( "roboport-door" , 0.3 , 1 , 1.5 )
			}
		}
	} ,
	close_door_trigger_effect =
	{
		{
			type = "play-sound" ,
			sound =
			{
				SISound.Base( "roboport-door-close" , 0.2 , 1 , 1.5 )
			}
		}
	} ,
	base =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "集成之指点江山平台" ) ,
				priority = "medium" ,
				width = 143 ,
				height = 135 ,
				shift = { 0.5 , 0.25 }
			} ,
			{
				filename = SIGen.MakeSelfPicturePath( "集成之指点江山平台-影子" ) ,
				priority = "medium" ,
				width = 147 ,
				height = 101 ,
				shift = SIUtils.by_pixel( 28.5 , 19.25 ) ,
				draw_as_shadow = true
			}
		}
	} ,
	base_patch =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "集成之指点江山平台-顶部" ) ,
				priority = "medium" ,
				width = 69 ,
				height = 50 ,
				frame_count = 1 ,
				shift = { 0.03125 , 0.203125 }
			}
		}
	} ,
	base_animation =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "集成之指点江山平台-动画" ) ,
				priority = "medium" ,
				width = 42 ,
				height = 31 ,
				frame_count = 8 ,
				animation_speed = 0.5 ,
				shift = { -0.5315 , -1.9375 }
			}
		}
	} ,
	door_animation_up =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "集成之指点江山平台-门-顶部" ) ,
				priority = "medium" ,
				width = 52 ,
				height = 20 ,
				frame_count = 16 ,
				shift = { 0.015625 , -0.890625 }
			}
		}
	} ,
	door_animation_down =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "集成之指点江山平台-门-底部" ) ,
				priority = "medium" ,
				width = 52 ,
				height = 22 ,
				frame_count = 16 ,
				shift = { 0.015625 , -0.234375 }
			}
		}
	} ,
	recharging_animation =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "集成之指点江山平台-充电" ) ,
				priority = "high" ,
				width = 37 ,
				height = 35 ,
				frame_count = 16 ,
				animation_speed = 0.5 ,
				scale = 1.5 ,
				draw_as_glow = true
			}
		}
	} ,
	recharging_light =
	{
		intensity = 0.2 ,
		size = 3 ,
		color = { r = 0.50 , g = 0.50 , b = 1.00 }
	} ,
	water_reflection =
	{
		rotate = false ,
		orientation_to_variation = false ,
		pictures =
		{
			filename = SIGen.MakeSelfPicturePath( "集成之指点江山平台-反射" ) ,
			priority = "extra-high" ,
			width = 28 ,
			height = 28 ,
			variation_count = 1 ,
			scale = 5.0 ,
			shift = SIUtils.by_pixel( 0 , 75 )
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
			SISound.Base( "roboport-working" , 0.4 )
		} ,
		max_sounds_per_type = 3 ,
		audible_distance_modifier = 0.75
	}
}
.New( SICommon.Types.Equipments.Roboport , "Roboport" , "集成之指点江山平台" ,
{
	take_result = SIConstants_Core.raw.Items.Roboport ,
	categories =
	{
		SIConstants_Core.raw.Categories.Equipment.Special
	} ,
	background_color = SICommon.Colors.Equipment.Building ,
	background_border_color = SICommon.Colors.Equipment.Border ,
	grabbed_background_color = SICommon.Colors.Equipment.BuildingHover ,
	shape =
	{
		type = SICommon.Flags.EquipmentShapeType.Full ,
		width = 2 ,
		height = 2
	} ,
	energy_source =
	{
		type = SICommon.Flags.EnergySourceType.Electric ,
		emissions_per_minute = 0 ,
		render_no_power_icon = false ,
		render_no_network_icon = false ,
		usage_priority = SICommon.Flags.ElectricUsagePriority.InputSecondary ,
		buffer_capacity = "50TJ" ,
		input_flow_limit = "10TW" ,
		output_flow_limit = "10TW" ,
		drain = "0J"
	} ,
	burner = nil ,
	power = nil ,
	spawn_minimum = "1TJ" ,
	construction_radius = 200 ,
	stationing_offset = { 0.0 , -0.6 } ,
	robot_limit = 1000 ,
	robot_vertical_acceleration = 0.01 ,
	robots_shrink_when_entering_and_exiting = true ,
	spawn_and_station_height = 0.4 ,
	spawn_and_station_shadow_height_offset = 0.5 ,
	charge_approach_distance = 2.5 ,
	charging_energy = "1GW" ,
	charging_station_count = 25 ,
	charging_station_shift = { 0.0 , 0.5 } ,
	charging_distance = 2.0 ,
	charging_threshold_distance = 10.0 ,
	charging_offsets = { { 0 , 0 } } ,
	draw_logistic_radius_visualization = true ,
	draw_construction_radius_visualization = true ,
	sprite =
	{
		filename = SIGen.MakePicturePath( SICommon.Types.Items.Item , "集成之指点江山平台" .. SICommon.ShowNameSuffix.ICON ) ,
		priority = "medium" ,
		width = 64 ,
		height = 64 ,
		scale = 1.0
	} ,
	recharging_animation =
	{
		layers =
		{
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Roboport , "集成之指点江山平台-充电" ) ,
				priority = "high" ,
				width = 37 ,
				height = 35 ,
				frame_count = 16 ,
				animation_speed = 0.5 ,
				scale = 1.5 ,
				draw_as_glow = true
			}
		}
	} ,
	recharging_light =
	{
		intensity = 0.2 ,
		size = 3 ,
		color = { r = 0.50 , g = 0.50 , b = 1.00 }
	}
} )
.MakeIcon( SICommon.Types.Items.Item , "集成之指点江山平台" , 64 , 4 )
.ReferenceEquipmentResult( SICommon.Types.Items.Item , SIConstants_Core.raw.Items.Roboport )

-- ----------------------------------------
-- 伟力之移山填海建设单元
-- ----------------------------------------
.New( SICommon.Types.Items.Item , "Construction" , "伟力之移山填海建设单元" )
.AutoIcon()
.Append
{
	flags = { SICommon.Flags.Item.Hidden } ,
	stack_size = 100 ,
	default_request_amount = 100 ,
	fuel_category = SIConstants_Core.raw.Categories.Fuel.Special ,
	fuel_value = "200KJ" ,
	fuel_acceleration_multiplier = 1.05 ,
	fuel_top_speed_multiplier = 1.05 ,
	fuel_emissions_multiplier = 62.21 ,
	fuel_glow_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	burnt_result = SIConstants_Core.raw.Items.Candy ,
	place_result = nil ,
	placed_as_equipment_result = nil ,
	rocket_launch_products =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			amount = 2 ,
			catalyst_amount = 2
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.2 ,
			amount_min = 0 ,
			amount_max = 20 ,
			catalyst_amount = 20
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.06 ,
			amount_min = 0 ,
			amount_max = 200 ,
			catalyst_amount = 200
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.02 ,
			amount_min = 0 ,
			amount_max = 2000 ,
			catalyst_amount = 2000
		}
	}
}
.New( SICommon.Types.Entities.RobotConstruct , "Construction" , "伟力之移山填海建设单元" )
.AutoIcon()
.ReferencePlaceResult( SICommon.Types.Items.Item , SIConstants_Core.raw.Items.Construction )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceablePlayer , SICommon.Flags.Entity.PlayerCreation , SICommon.Flags.Entity.PlaceableOffGrid , SICommon.Flags.Entity.NotOnMap , SICommon.Flags.Entity.Hidden } ,
	minable =
	{
		mining_time = 5.0 ,
		results =
		{
			{
				type = SICommon.Types.Items.Item ,
				name = SIConstants_Core.raw.Items.Construction ,
				amount = 1
			}
		}
	} ,
	selection_box = { { -0.5 , -1.5 } , { 0.5 , -0.5 } } ,
	collision_box = { { 0 , 0 } , { 0 , 0 } } ,
	hit_visualization_box = { { -0.1 , -1.1 } , { 0.1 , -1.0 } } ,
	max_health = maxHealth ,
	corpse = nil ,
	dying_explosion = "nuke-explosion" ,
	map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	friendly_map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	enemy_map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	is_military_target = false ,
	allow_run_time_change_of_is_military_target = true ,
	alert_when_damaged = true ,
	create_ghost_on_death = false ,
	hide_resistances = true ,
	resistances = defaultResistances ,
	damaged_trigger_effect =
	{
		type = "create-entity" ,
		entity_name = "flying-robot-damaged-explosion" ,
		offset_deviation = { { -0.25 , -0.25 } , { 0.25 , 0.25 } } ,
		offsets = { { 0 , 0 } } ,
		damage_type_filters = "fire"
	} ,
	repair_speed_modifier = 12.0 ,
	max_energy = "10TJ" ,
	energy_per_tick = "0J" ,
	energy_per_move = "0J" ,
	speed_multiplier_when_out_of_energy = 1.0 ,
	min_to_charge = 0.2 ,
	max_to_charge = 0.95 ,
	max_payload_size = 10 ,
	speed = 0.24 ,
	cargo_centered = { 0.0 , 0.2 } ,
	construction_vector = { 0.30 , 0.22 } ,
	dying_trigger_effect =
	{
		{
			type = "create-particle" ,
			particle_name = "construction-robot-dying-particle" ,
			initial_height = 1.8 ,
			initial_vertical_speed = 0 ,
			frame_speed = 1 ,
			frame_speed_deviation = 0.5 ,
			speed_from_center = 0 ,
			speed_from_center_deviation = 0.2 ,
			offset_deviation = { { -0.01 , -0.01 } , { 0.01 , 0.01 } } ,
			offsets = { { 0 , 0.5 } }
		} ,
		{
			type = "play-sound" ,
			sound =
			{
				SISound.Base( "fight/robot-die-whoosh-01" , 0.5 ) ,
				SISound.Base( "fight/robot-die-whoosh-02" , 0.5 ) ,
				SISound.Base( "fight/robot-die-whoosh-03" , 0.5 )
			}
		} ,
		{
			type = "play-sound" ,
			sound =
			{
				SISound.Base( "fight/robot-die-vox-01" , 0.5 ) ,
				SISound.Base( "fight/robot-die-vox-02" , 0.5 ) ,
				SISound.Base( "fight/robot-die-vox-03" , 0.5 ) ,
				SISound.Base( "fight/robot-die-vox-04" , 0.5 ) ,
				SISound.Base( "fight/robot-die-vox-05" , 0.5 ) ,
				SISound.Base( "fight/robot-die-vox-06" , 0.5 )
			}
		}
	} ,
	idle =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "伟力之移山填海建设单元" ) ,
				priority = "high" ,
				width = 32 ,
				height = 36 ,
				frame_count = 1 ,
				line_length = 16 ,
				direction_count = 16 ,
				shift = SIUtils.by_pixel( 0 , -4.5 )
			}
		}
	} ,
	in_motion =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "伟力之移山填海建设单元" ) ,
				priority = "high" ,
				width = 32 ,
				height = 36 ,
				frame_count = 1 ,
				line_length = 16 ,
				direction_count = 16 ,
				shift = SIUtils.by_pixel( 0 , -4.5 )
			}
		}
	} ,
	shadow_idle =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "伟力之移山填海建设单元-影子" ) ,
				priority = "high" ,
				width = 53 ,
				height = 25 ,
				frame_count = 1 ,
				line_length = 16 ,
				direction_count = 16 ,
				shift = SIUtils.by_pixel( 33.5 , 18.5 ) ,
				draw_as_shadow = true
			}
		}
	} ,
	shadow_in_motion =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "伟力之移山填海建设单元-影子" ) ,
				priority = "high" ,
				width = 53 ,
				height = 25 ,
				frame_count = 1 ,
				line_length = 16 ,
				direction_count = 16 ,
				shift = SIUtils.by_pixel( 33.5 , 18.5 ) ,
				draw_as_shadow = true
			}
		}
	} ,
	working =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "伟力之移山填海建设单元-工作" ) ,
				priority = "high" ,
				width = 28 ,
				height = 36 ,
				frame_count = 2 ,
				line_length = 2 ,
				direction_count = 16 ,
				animation_speed = 0.3 ,
				shift = SIUtils.by_pixel( -0.25 , -5 )
			}
		}
	} ,
	shadow_working =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "伟力之移山填海建设单元-影子" ) ,
				priority = "high" ,
				width = 53 ,
				height = 25 ,
				frame_count = 1 ,
				repeat_count = 2 ,
				line_length = 16 ,
				direction_count = 16 ,
				shift = SIUtils.by_pixel( 33.5 , 18.5 ) ,
				draw_as_shadow = true
			}
		}
	} ,
	smoke =
	{
		layers =
		{
			{
				filename = "__base__/graphics/entity/smoke-construction/smoke-01.png" ,
				width = 39 ,
				height = 32 ,
				frame_count = 19 ,
				line_length = 19 ,
				animation_speed = 0.3 ,
				shift = { 0.078125 , -0.15625 }
			}
		}
	} ,
	sparks =
	{
		{
			layers =
			{
				{
					filename = "__base__/graphics/entity/sparks/sparks-01.png" ,
					width = 39 ,
					height = 34 ,
					frame_count = 19 ,
					line_length = 19 ,
					animation_speed = 0.3 ,
					tint = { r = 1.00 , g = 0.90 , b = 0.00 , a = 1.00 } ,
					shift = { -0.109375 , 0.3125 } ,
					draw_as_glow = true
				}
			}
		} ,
		{
			layers =
			{
				{
					filename = "__base__/graphics/entity/sparks/sparks-02.png" ,
					width = 36 ,
					height = 32 ,
					frame_count = 19 ,
					line_length = 19 ,
					animation_speed = 0.3 ,
					tint = { r = 1.00 , g = 0.90 , b = 0.00 , a = 1.00 } ,
					shift = { 0.03125 , 0.125 } ,
					draw_as_glow = true
				}
			}
		} ,
		{
			layers =
			{
				{
					filename = "__base__/graphics/entity/sparks/sparks-03.png" ,
					width = 42 ,
					height = 29 ,
					frame_count = 19 ,
					line_length = 19 ,
					animation_speed = 0.3 ,
					tint = { r = 1.00 , g = 0.90 , b = 0.00 , a = 1.00 } ,
					shift = { -0.0625 , 0.203125 } ,
					draw_as_glow = true
				}
			}
		} ,
		{
			layers =
			{
				{
					filename = "__base__/graphics/entity/sparks/sparks-04.png" ,
					width = 40 ,
					height = 35 ,
					frame_count = 19 ,
					line_length = 19 ,
					animation_speed = 0.3 ,
					shift = { -0.0625 , 0.234375 } ,
					tint = { r = 1.00 , g = 0.90 , b = 0.00 , a = 1.00 } ,
					draw_as_glow = true
				}
			}
		} ,
		{
			layers =
			{
				{
					filename = "__base__/graphics/entity/sparks/sparks-05.png" ,
					width = 39 ,
					height = 29 ,
					frame_count = 19 ,
					line_length = 19 ,
					animation_speed = 0.3 ,
					tint = { r = 1.00 , g = 0.90 , b = 0.00 , a = 1.00 } ,
					shift = { -0.109375 , 0.171875 } ,
					draw_as_glow = true
				}
			}
		} ,
		{
			layers =
			{
				{
					filename = "__base__/graphics/entity/sparks/sparks-06.png" ,
					width = 44 ,
					height = 36 ,
					frame_count = 19 ,
					line_length = 19 ,
					animation_speed = 0.3 ,
					tint = { r = 1.00 , g = 0.90 , b = 0.00 , a = 1.00 } ,
					shift = { 0.03125 , 0.3125 } ,
					draw_as_glow = true
				}
			}
		}
	} ,
	working_light =
	{
		intensity = 0.8 ,
		size = 3 ,
		color = { r = 0.80 , g = 0.80 , b = 0.80 }
	} ,
	water_reflection =
	{
		rotate = false ,
		orientation_to_variation = false ,
		pictures =
		{
			filename = SIGen.MakeSelfPicturePath( "伟力之移山填海建设单元-反射" ) ,
			priority = "extra-high" ,
			width = 12 ,
			height = 12 ,
			variation_count = 1 ,
			scale = 5.0 ,
			shift = SIUtils.by_pixel( 0 , 105 )
		}
	} ,
	mined_sound =
	{
		SISound.Core( "deconstruct-small" , 1 )
	} ,
	repair_sound =
	{
		SISound.Core( "manual-repair-advanced-1" , 0.5 ) ,
		SISound.Core( "manual-repair-advanced-2" , 0.5 )
	} ,
	working_sound =
	{
		sound =
		{
			SISound.Base( "construction-robot-1" , 0.42 ) ,
			SISound.Base( "construction-robot-2" , 0.42 ) ,
			SISound.Base( "construction-robot-3" , 0.42 ) ,
			SISound.Base( "construction-robot-4" , 0.42 ) ,
			SISound.Base( "construction-robot-5" , 0.42 ) ,
			SISound.Base( "construction-robot-6" , 0.42 ) ,
			SISound.Base( "construction-robot-7" , 0.42 ) ,
			SISound.Base( "construction-robot-8" , 0.42 ) ,
			SISound.Base( "construction-robot-9" , 0.42 ) ,
			SISound.Base( "flying-robot-1" , 0.42 ) ,
			SISound.Base( "flying-robot-2" , 0.42 ) ,
			SISound.Base( "flying-robot-3" , 0.42 ) ,
			SISound.Base( "flying-robot-4" , 0.42 ) ,
			SISound.Base( "flying-robot-5" , 0.42 )
		} ,
		max_sounds_per_type = 20 ,
		audible_distance_modifier = 1 ,
		fade_in_ticks = 8 ,
		fade_out_ticks = 8 ,
		probability = 1 / ( 10 * 60 )
	}
}
.New( SICommon.Types.Equipments.Shield , "Construction" , "伟力之移山填海建设单元" ,
{
	take_result = SIConstants_Core.raw.Items.Construction ,
	categories =
	{
		SIConstants_Core.raw.Categories.Equipment.Special
	} ,
	background_color = SICommon.Colors.Equipment.Modify ,
	background_border_color = SICommon.Colors.Equipment.Border ,
	grabbed_background_color = SICommon.Colors.Equipment.ModifyHover ,
	shape =
	{
		type = SICommon.Flags.EquipmentShapeType.Full ,
		width = 2 ,
		height = 2
	} ,
	energy_source =
	{
		type = SICommon.Flags.EnergySourceType.Electric ,
		emissions_per_minute = 0 ,
		render_no_power_icon = false ,
		render_no_network_icon = false ,
		usage_priority = SICommon.Flags.ElectricUsagePriority.InputSecondary ,
		buffer_capacity = "50TJ" ,
		input_flow_limit = "10TW" ,
		output_flow_limit = "10TW" ,
		drain = "0J"
	} ,
	energy_per_shield = "1GJ" ,
	max_shield_value = 10000 ,
	sprite =
	{
		filename = SIGen.MakePicturePath( SICommon.Types.Items.Item , "伟力之移山填海建设单元" .. SICommon.ShowNameSuffix.ICON ) ,
		priority = "medium" ,
		width = 64 ,
		height = 64 ,
		scale = 1.0
	}
} )
.MakeIcon( SICommon.Types.Items.Item , "伟力之移山填海建设单元" , 64 , 4 )
.ReferenceEquipmentResult( SICommon.Types.Items.Item , SIConstants_Core.raw.Items.Construction )

-- ----------------------------------------
-- 伟力之移山填海物流单元
-- ----------------------------------------
.New( SICommon.Types.Items.Item , "Logistic" , "伟力之移山填海物流单元" )
.AutoIcon()
.Append
{
	flags = { SICommon.Flags.Item.Hidden } ,
	stack_size = 100 ,
	default_request_amount = 100 ,
	fuel_category = SIConstants_Core.raw.Categories.Fuel.Special ,
	fuel_value = "200KJ" ,
	fuel_acceleration_multiplier = 1.05 ,
	fuel_top_speed_multiplier = 1.05 ,
	fuel_emissions_multiplier = 62.21 ,
	fuel_glow_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	burnt_result = SIConstants_Core.raw.Items.Candy ,
	place_result = nil ,
	placed_as_equipment_result = nil ,
	rocket_launch_products =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			amount = 2 ,
			catalyst_amount = 2
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.2 ,
			amount_min = 0 ,
			amount_max = 20 ,
			catalyst_amount = 20
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.06 ,
			amount_min = 0 ,
			amount_max = 200 ,
			catalyst_amount = 200
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.02 ,
			amount_min = 0 ,
			amount_max = 2000 ,
			catalyst_amount = 2000
		}
	}
}
.New( SICommon.Types.Entities.RobotLogistic , "Logistic" , "伟力之移山填海物流单元" )
.AutoIcon()
.ReferencePlaceResult( SICommon.Types.Items.Item , SIConstants_Core.raw.Items.Logistic )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceablePlayer , SICommon.Flags.Entity.PlayerCreation , SICommon.Flags.Entity.PlaceableOffGrid , SICommon.Flags.Entity.NotOnMap , SICommon.Flags.Entity.Hidden } ,
	minable =
	{
		mining_time = 5.0 ,
		results =
		{
			{
				type = SICommon.Types.Items.Item ,
				name = SIConstants_Core.raw.Items.Logistic ,
				amount = 1
			}
		}
	} ,
	selection_box = { { -0.5 , -1.5 } , { 0.5 , -0.5 } } ,
	collision_box = { { 0 , 0 } , { 0 , 0 } } ,
	hit_visualization_box = { { -0.1 , -1.1 } , { 0.1 , -1.0 } } ,
	max_health = maxHealth ,
	corpse = nil ,
	dying_explosion = "nuke-explosion" ,
	map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	friendly_map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	enemy_map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	is_military_target = false ,
	allow_run_time_change_of_is_military_target = true ,
	alert_when_damaged = true ,
	create_ghost_on_death = false ,
	hide_resistances = true ,
	resistances = defaultResistances ,
	damaged_trigger_effect =
	{
		type = "create-entity" ,
		entity_name = "flying-robot-damaged-explosion" ,
		offset_deviation = { { -0.25 , -0.25 } , { 0.25 , 0.25 } } ,
		offsets = { { 0 , 0 } } ,
		damage_type_filters = "fire"
	} ,
	repair_speed_modifier = 12.0 ,
	max_energy = "10TJ" ,
	energy_per_tick = "0J" ,
	energy_per_move = "0J" ,
	speed_multiplier_when_out_of_energy = 1.0 ,
	min_to_charge = 0.2 ,
	max_to_charge = 0.95 ,
	max_payload_size = 10 ,
	speed = 0.24 ,
	cargo_centered = { 0.0 , 0.2 } ,
	dying_trigger_effect =
	{
		{
			type = "create-particle" ,
			particle_name = "logistic-robot-dying-particle" ,
			initial_height = 1.8 ,
			initial_vertical_speed = 0 ,
			frame_speed = 1 ,
			frame_speed_deviation = 0.5 ,
			speed_from_center = 0 ,
			speed_from_center_deviation = 0.2 ,
			offset_deviation = { { -0.01 , -0.01 } , { 0.01 , 0.01 } } ,
			offsets = { { 0 , 0.5 } }
		} ,
		{
			type = "play-sound" ,
			sound =
			{
				SISound.Base( "fight/robot-die-whoosh-01" , 0.5 ) ,
				SISound.Base( "fight/robot-die-whoosh-02" , 0.5 ) ,
				SISound.Base( "fight/robot-die-whoosh-03" , 0.5 )
			}
		} ,
		{
			type = "play-sound" ,
			sound =
			{
				SISound.Base( "fight/robot-die-vox-01" , 0.5 ) ,
				SISound.Base( "fight/robot-die-vox-02" , 0.5 ) ,
				SISound.Base( "fight/robot-die-vox-03" , 0.5 ) ,
				SISound.Base( "fight/robot-die-vox-04" , 0.5 ) ,
				SISound.Base( "fight/robot-die-vox-05" , 0.5 ) ,
				SISound.Base( "fight/robot-die-vox-06" , 0.5 )
			}
		}
	} ,
	idle =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "伟力之移山填海物流单元" ) ,
				priority = "high" ,
				width = 41 ,
				height = 42 ,
				frame_count = 1 ,
				line_length = 16 ,
				direction_count = 16 ,
				y = 42 ,
				shift = SIUtils.by_pixel( 0 , -3 )
			}
		}
	} ,
	idle_with_cargo =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "伟力之移山填海物流单元" ) ,
				priority = "high" ,
				width = 41 ,
				height = 42 ,
				frame_count = 1 ,
				line_length = 16 ,
				direction_count = 16 ,
				y = 0 ,
				shift = SIUtils.by_pixel( 0 , -3 )
			}
		}
	} ,
	in_motion =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "伟力之移山填海物流单元" ) ,
				priority = "high" ,
				width = 41 ,
				height = 42 ,
				frame_count = 1 ,
				line_length = 16 ,
				direction_count = 16 ,
				y = 126 ,
				shift = SIUtils.by_pixel( 0 , -3 )
			}
		}
	} ,
	in_motion_with_cargo =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "伟力之移山填海物流单元" ) ,
				priority = "high" ,
				width = 41 ,
				height = 42 ,
				frame_count = 1 ,
				line_length = 16 ,
				direction_count = 16 ,
				y = 84 ,
				shift = SIUtils.by_pixel( 0 , -3 )
			}
		}
	} ,
	shadow_idle =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "伟力之移山填海物流单元-影子" ) ,
				priority = "high" ,
				width = 58 ,
				height = 29 ,
				frame_count = 1 ,
				line_length = 16 ,
				direction_count = 16 ,
				y = 29 ,
				shift = SIUtils.by_pixel( 32 , 19.5 ) ,
				draw_as_shadow = true
			}
		}
	} ,
	shadow_idle_with_cargo =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "伟力之移山填海物流单元-影子" ) ,
				priority = "high" ,
				width = 58 ,
				height = 29 ,
				frame_count = 1 ,
				line_length = 16 ,
				direction_count = 16 ,
				y = 0 ,
				shift = SIUtils.by_pixel( 32 , 19.5 ) ,
				draw_as_shadow = true
			}
		}
	} ,
	shadow_in_motion =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "伟力之移山填海物流单元-影子" ) ,
				priority = "high" ,
				width = 58 ,
				height = 29 ,
				frame_count = 1 ,
				line_length = 16 ,
				direction_count = 16 ,
				y = 87 ,
				shift = SIUtils.by_pixel( 32 , 19.5 ) ,
				draw_as_shadow = true
			}
		}
	} ,
	shadow_in_motion_with_cargo =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "伟力之移山填海物流单元-影子" ) ,
				priority = "high" ,
				width = 58 ,
				height = 29 ,
				frame_count = 1 ,
				line_length = 16 ,
				direction_count = 16 ,
				y = 58 ,
				shift = SIUtils.by_pixel( 32 , 19.5 ) ,
				draw_as_shadow = true
			}
		}
	} ,
	water_reflection =
	{
		rotate = false ,
		orientation_to_variation = false ,
		pictures =
		{
			filename = SIGen.MakeSelfPicturePath( "伟力之移山填海物流单元-反射" ) ,
			priority = "extra-high" ,
			width = 12 ,
			height = 12 ,
			variation_count = 1 ,
			scale = 5.0 ,
			shift = SIUtils.by_pixel( 0 , 105 )
		}
	} ,
	mined_sound =
	{
		SISound.Core( "deconstruct-small" , 1 )
	} ,
	repair_sound =
	{
		SISound.Core( "manual-repair-advanced-1" , 0.5 ) ,
		SISound.Core( "manual-repair-advanced-2" , 0.5 )
	} ,
	working_sound =
	{
		sound =
		{
			SISound.Base( "construction-robot-11" , 0.42 ) ,
			SISound.Base( "construction-robot-12" , 0.42 ) ,
			SISound.Base( "construction-robot-13" , 0.42 ) ,
			SISound.Base( "construction-robot-14" , 0.42 ) ,
			SISound.Base( "construction-robot-15" , 0.42 ) ,
			SISound.Base( "construction-robot-16" , 0.42 ) ,
			SISound.Base( "construction-robot-17" , 0.42 ) ,
			SISound.Base( "construction-robot-18" , 0.42 ) ,
			SISound.Base( "construction-robot-19" , 0.42 ) ,
			SISound.Base( "flying-robot-1" , 0.42 ) ,
			SISound.Base( "flying-robot-2" , 0.42 ) ,
			SISound.Base( "flying-robot-3" , 0.42 ) ,
			SISound.Base( "flying-robot-4" , 0.42 ) ,
			SISound.Base( "flying-robot-5" , 0.42 )
		} ,
		max_sounds_per_type = 20 ,
		audible_distance_modifier = 1 ,
		fade_in_ticks = 8 ,
		fade_out_ticks = 10 ,
		probability = 1 / ( 10 * 60 )
	}
}
.New( SICommon.Types.Equipments.BeltImmunity , "Logistic" , "伟力之移山填海物流单元" ,
{
	take_result = SIConstants_Core.raw.Items.Logistic ,
	categories =
	{
		SIConstants_Core.raw.Categories.Equipment.Special
	} ,
	background_color = SICommon.Colors.Equipment.Building ,
	background_border_color = SICommon.Colors.Equipment.Border ,
	grabbed_background_color = SICommon.Colors.Equipment.BuildingHover ,
	shape =
	{
		type = SICommon.Flags.EquipmentShapeType.Full ,
		width = 2 ,
		height = 2
	} ,
	energy_source =
	{
		type = SICommon.Flags.EnergySourceType.Electric ,
		emissions_per_minute = 0 ,
		render_no_power_icon = false ,
		render_no_network_icon = false ,
		usage_priority = SICommon.Flags.ElectricUsagePriority.InputSecondary ,
		buffer_capacity = "50TJ" ,
		input_flow_limit = "10TW" ,
		output_flow_limit = "10TW" ,
		drain = "0J"
	} ,
	energy_consumption = "1TW" ,
	sprite =
	{
		filename = SIGen.MakePicturePath( SICommon.Types.Items.Item , "伟力之移山填海物流单元" .. SICommon.ShowNameSuffix.ICON ) ,
		priority = "medium" ,
		width = 64 ,
		height = 64 ,
		scale = 1.0
	}
} )
.MakeIcon( SICommon.Types.Items.Item , "伟力之移山填海物流单元" , 64 , 4 )
.ReferenceEquipmentResult( SICommon.Types.Items.Item , SIConstants_Core.raw.Items.Logistic )

-- ----------------------------------------
-- 终末之横扫千军光束
-- ----------------------------------------
.New( SICommon.Types.Entities.Beam , "Laser_BeamSmall" , "终末之横扫千军光束-激光细" )
.Append
{
	flags = { SICommon.Flags.Entity.NotOnMap , SICommon.Flags.Entity.Hidden } ,
	selectable_in_game = false ,
	width = 2.5 ,
	damage_interval = 4 ,
	random_target_offset = false ,
	transparent_start_end_animations = true ,
	action_triggered_automatically = true ,
	action =
	{
		{
			type = "area" ,
			force = "enemy" ,
			ignore_collision_condition = true ,
			show_in_tooltip = true ,
			radius = 1.3 ,
			trigger_from_target = false ,
			target_entities = true ,
			collision_mode = "distance-from-collision-box" ,
			action_delivery =
			{
				{
					type = "instant" ,
					target_effects =
					{
						{
							type = "damage" ,
							show_in_tooltip = true ,
							damage =
							{
								type = "physical" ,
								amount = LaserSmallDamage
							}
						} ,
						{
							type = "damage" ,
							show_in_tooltip = true ,
							damage =
							{
								type = "impact" ,
								amount = LaserSmallDamage
							}
						} ,
						{
							type = "damage" ,
							show_in_tooltip = true ,
							damage =
							{
								type = "poison" ,
								amount = LaserSmallDamage
							}
						} ,
						{
							type = "damage" ,
							show_in_tooltip = true ,
							damage =
							{
								type = "explosion" ,
								amount = LaserSmallDamage
							}
						} ,
						{
							type = "damage" ,
							show_in_tooltip = true ,
							damage =
							{
								type = "fire" ,
								amount = LaserSmallDamage
							}
						} ,
						{
							type = "damage" ,
							show_in_tooltip = true ,
							damage =
							{
								type = "laser" ,
								amount = LaserSmallDamage
							}
						}
					}
				}
			}
		}
	} ,
	body =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "终末之横扫千军光束-激光-身体" ) ,
				priority = "medium" ,
				blend_mode = "additive" ,
				flags = { "trilinear-filtering" } ,
				width = 64 ,
				height = 12 ,
				frame_count = 8 ,
				line_length = 8 ,
				animation_speed = 0.5 ,
				scale = 0.5
			}
		}
	} ,
	head =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "终末之横扫千军光束-激光-身体" ) ,
				priority = "medium" ,
				blend_mode = "additive" ,
				flags = { "trilinear-filtering" } ,
				width = 64 ,
				height = 12 ,
				frame_count = 8 ,
				line_length = 8 ,
				animation_speed = 0.5 ,
				scale = 0.5
			}
		}
	} ,
	tail =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "终末之横扫千军光束-激光-尾部" ) ,
				priority = "medium" ,
				blend_mode = "additive" ,
				flags = { "trilinear-filtering" } ,
				width = 110 ,
				height = 62 ,
				frame_count = 8 ,
				line_length = 8 ,
				animation_speed = 0.5 ,
				scale = 0.5 ,
				shift = SIUtils.by_pixel( 11.5 , 1 )
			}
		}
	} ,
	light_animations =
	{
		body =
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "终末之横扫千军光束-激光-身体-光效" ) ,
					priority = "medium" ,
					width = 64 ,
					height = 12 ,
					frame_count = 8 ,
					line_length = 8 ,
					animation_speed = 0.5 ,
					scale = 0.5
				}
			}
		} ,
		head =
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "终末之横扫千军光束-激光-身体-光效" ) ,
					priority = "medium" ,
					width = 64 ,
					height = 12 ,
					frame_count = 8 ,
					line_length = 8 ,
					animation_speed = 0.5 ,
					scale = 0.5
				}
			}
		} ,
		tail =
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "终末之横扫千军光束-激光-尾部-光效" ) ,
					priority = "medium" ,
					width = 110 ,
					height = 62 ,
					frame_count = 8 ,
					line_length = 8 ,
					animation_speed = 0.5 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 11.5 , 1 )
				}
			}
		}
	} ,
	ground_light_animations =
	{
		body =
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "终末之横扫千军光束-激光-地面-身体" ) ,
					priority = "medium" ,
					width = 64 ,
					height = 256 ,
					frame_count = 1 ,
					line_length = 1 ,
					repeat_count = 8 ,
					animation_speed = 0.5 ,
					scale = 0.5 ,
					tint = { r = 0.50 , g = 0.50 , b = 0.05 }
				}
			}
		} ,
		head =
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "终末之横扫千军光束-激光-地面-头部" ) ,
					priority = "medium" ,
					width = 256 ,
					height = 256 ,
					frame_count = 1 ,
					line_length = 1 ,
					repeat_count = 8 ,
					animation_speed = 0.5 ,
					scale = 0.5 ,
					tint = { r = 0.50 , g = 0.50 , b = 0.05 } ,
					shift = SIUtils.by_pixel( -32 , 0 )
				}
			}
		} ,
		tail =
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "终末之横扫千军光束-激光-地面-尾部" ) ,
					priority = "medium" ,
					width = 256 ,
					height = 256 ,
					frame_count = 1 ,
					line_length = 1 ,
					repeat_count = 8 ,
					animation_speed = 0.5 ,
					scale = 0.5 ,
					tint = { r = 0.50 , g = 0.50 , b = 0.05 } ,
					shift = SIUtils.by_pixel( 32 , 0 )
				}
			}
		}
	}
}
.New( SICommon.Types.Entities.Beam , "Laser_BeamMedium" , "终末之横扫千军光束-激光中" )
.Append
{
	flags = { SICommon.Flags.Entity.NotOnMap , SICommon.Flags.Entity.Hidden } ,
	selectable_in_game = false ,
	width = 2.5 ,
	damage_interval = 4 ,
	random_target_offset = false ,
	transparent_start_end_animations = true ,
	action_triggered_automatically = true ,
	action =
	{
		{
			type = "area" ,
			force = "enemy" ,
			ignore_collision_condition = true ,
			show_in_tooltip = true ,
			radius = 1.3 ,
			trigger_from_target = false ,
			target_entities = true ,
			collision_mode = "distance-from-collision-box" ,
			action_delivery =
			{
				{
					type = "instant" ,
					target_effects =
					{
						{
							type = "damage" ,
							show_in_tooltip = true ,
							damage =
							{
								type = "physical" ,
								amount = LaserSmallDamage
							}
						} ,
						{
							type = "damage" ,
							show_in_tooltip = true ,
							damage =
							{
								type = "impact" ,
								amount = LaserSmallDamage
							}
						} ,
						{
							type = "damage" ,
							show_in_tooltip = true ,
							damage =
							{
								type = "poison" ,
								amount = LaserSmallDamage
							}
						} ,
						{
							type = "damage" ,
							show_in_tooltip = true ,
							damage =
							{
								type = "explosion" ,
								amount = LaserSmallDamage
							}
						} ,
						{
							type = "damage" ,
							show_in_tooltip = true ,
							damage =
							{
								type = "fire" ,
								amount = LaserSmallDamage
							}
						} ,
						{
							type = "damage" ,
							show_in_tooltip = true ,
							damage =
							{
								type = "laser" ,
								amount = LaserSmallDamage
							}
						}
					}
				}
			}
		}
	} ,
	body =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "终末之横扫千军光束-激光-身体" ) ,
				priority = "medium" ,
				blend_mode = "additive" ,
				flags = { "trilinear-filtering" } ,
				width = 64 ,
				height = 12 ,
				frame_count = 8 ,
				line_length = 8 ,
				animation_speed = 0.5 ,
				scale = 0.9
			}
		}
	} ,
	head =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "终末之横扫千军光束-激光-身体" ) ,
				priority = "medium" ,
				blend_mode = "additive" ,
				flags = { "trilinear-filtering" } ,
				width = 64 ,
				height = 12 ,
				frame_count = 8 ,
				line_length = 8 ,
				animation_speed = 0.5 ,
				scale = 0.9
			}
		}
	} ,
	tail =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "终末之横扫千军光束-激光-尾部" ) ,
				priority = "medium" ,
				blend_mode = "additive" ,
				flags = { "trilinear-filtering" } ,
				width = 110 ,
				height = 62 ,
				frame_count = 8 ,
				line_length = 8 ,
				animation_speed = 0.5 ,
				scale = 0.9 ,
				shift = SIUtils.by_pixel( 11.5 , 1 )
			}
		}
	} ,
	light_animations =
	{
		body =
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "终末之横扫千军光束-激光-身体-光效" ) ,
					priority = "medium" ,
					width = 64 ,
					height = 12 ,
					frame_count = 8 ,
					line_length = 8 ,
					animation_speed = 0.5 ,
					scale = 0.9
				}
			}
		} ,
		head =
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "终末之横扫千军光束-激光-身体-光效" ) ,
					priority = "medium" ,
					width = 64 ,
					height = 12 ,
					frame_count = 8 ,
					line_length = 8 ,
					animation_speed = 0.5 ,
					scale = 0.9
				}
			}
		} ,
		tail =
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "终末之横扫千军光束-激光-尾部-光效" ) ,
					priority = "medium" ,
					width = 110 ,
					height = 62 ,
					frame_count = 8 ,
					line_length = 8 ,
					animation_speed = 0.5 ,
					scale = 0.9 ,
					shift = SIUtils.by_pixel( 11.5 , 1 )
				}
			}
		}
	} ,
	ground_light_animations =
	{
		body =
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "终末之横扫千军光束-激光-地面-身体" ) ,
					priority = "medium" ,
					width = 64 ,
					height = 256 ,
					frame_count = 1 ,
					line_length = 1 ,
					repeat_count = 8 ,
					animation_speed = 0.5 ,
					scale = 0.9 ,
					tint = { r = 0.50 , g = 0.50 , b = 0.05 }
				}
			}
		} ,
		head =
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "终末之横扫千军光束-激光-地面-头部" ) ,
					priority = "medium" ,
					width = 256 ,
					height = 256 ,
					frame_count = 1 ,
					line_length = 1 ,
					repeat_count = 8 ,
					animation_speed = 0.5 ,
					scale = 0.9 ,
					tint = { r = 0.50 , g = 0.50 , b = 0.05 } ,
					shift = SIUtils.by_pixel( -32 , 0 )
				}
			}
		} ,
		tail =
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "终末之横扫千军光束-激光-地面-尾部" ) ,
					priority = "medium" ,
					width = 256 ,
					height = 256 ,
					frame_count = 1 ,
					line_length = 1 ,
					repeat_count = 8 ,
					animation_speed = 0.5 ,
					scale = 0.9 ,
					tint = { r = 0.50 , g = 0.50 , b = 0.05 } ,
					shift = SIUtils.by_pixel( 32 , 0 )
				}
			}
		}
	}
}
.New( SICommon.Types.Entities.Beam , "Laser_BeamLarge" , "终末之横扫千军光束-激光粗" )
.Append
{
	flags = { SICommon.Flags.Entity.NotOnMap , SICommon.Flags.Entity.Hidden } ,
	selectable_in_game = false ,
	width = 2.5 ,
	damage_interval = 4 ,
	random_target_offset = false ,
	transparent_start_end_animations = true ,
	action_triggered_automatically = true ,
	action =
	{
		{
			type = "area" ,
			force = "enemy" ,
			ignore_collision_condition = true ,
			show_in_tooltip = true ,
			radius = 3.5 ,
			trigger_from_target = false ,
			target_entities = true ,
			collision_mode = "distance-from-collision-box" ,
			action_delivery =
			{
				{
					type = "instant" ,
					target_effects =
					{
						{
							type = "damage" ,
							show_in_tooltip = true ,
							damage =
							{
								type = "physical" ,
								amount = LaserLargeDamage
							}
						} ,
						{
							type = "damage" ,
							show_in_tooltip = true ,
							damage =
							{
								type = "impact" ,
								amount = LaserLargeDamage
							}
						} ,
						{
							type = "damage" ,
							show_in_tooltip = true ,
							damage =
							{
								type = "poison" ,
								amount = LaserLargeDamage
							}
						} ,
						{
							type = "damage" ,
							show_in_tooltip = true ,
							damage =
							{
								type = "explosion" ,
								amount = LaserLargeDamage
							}
						} ,
						{
							type = "damage" ,
							show_in_tooltip = true ,
							damage =
							{
								type = "fire" ,
								amount = LaserLargeDamage
							}
						} ,
						{
							type = "damage" ,
							show_in_tooltip = true ,
							damage =
							{
								type = "laser" ,
								amount = LaserLargeDamage
							}
						}
					}
				}
			}
		} ,
		{
			type = "direct" ,
			force = "enemy" ,
			ignore_collision_condition = true ,
			show_in_tooltip = false ,
			action_delivery =
			{
				{
					type = "instant" ,
					target_effects =
					{
						{
							type = "damage" ,
							show_in_tooltip = false ,
							damage =
							{
								type = "physical" ,
								amount = LaserLargeDamageDirect
							}
						} ,
						{
							type = "damage" ,
							show_in_tooltip = false ,
							damage =
							{
								type = "impact" ,
								amount = LaserLargeDamageDirect
							}
						} ,
						{
							type = "damage" ,
							show_in_tooltip = false ,
							damage =
							{
								type = "poison" ,
								amount = LaserLargeDamageDirect
							}
						} ,
						{
							type = "damage" ,
							show_in_tooltip = false ,
							damage =
							{
								type = "explosion" ,
								amount = LaserLargeDamageDirect
							}
						} ,
						{
							type = "damage" ,
							show_in_tooltip = false ,
							damage =
							{
								type = "fire" ,
								amount = LaserLargeDamageDirect
							}
						} ,
						{
							type = "damage" ,
							show_in_tooltip = false ,
							damage =
							{
								type = "laser" ,
								amount = LaserLargeDamageDirect
							}
						}
					}
				}
			}
		} ,
		{
			type = "area" ,
			force = "enemy" ,
			ignore_collision_condition = true ,
			show_in_tooltip = false ,
			radius = 24 ,
			trigger_from_target = true ,
			target_entities = true ,
			collision_mode = "distance-from-collision-box" ,
			action_delivery =
			{
				{
					type = "beam" ,
					beam = SIConstants_Core.raw.Entities.Laser_BeamMedium ,
					max_length = 0 ,
					duration = 4 ,
					source_offset = { 0 , 0 } ,
					add_to_shooter = true ,
					target_effects =
					{
						{
							type = "nested-result" ,
							probability = 0.34 ,
							show_in_tooltip = true ,
							action =
							{
								{
									type = "area" ,
									force = "enemy" ,
									ignore_collision_condition = true ,
									show_in_tooltip = false ,
									radius = 15 ,
									trigger_from_target = true ,
									target_entities = false ,
									collision_mode = "distance-from-collision-box" ,
									action_delivery =
									{
										{
											type = "beam" ,
											beam = SIConstants_Core.raw.Entities.Laser_BeamSmall ,
											max_length = 0 ,
											duration = 12 ,
											source_offset = { 0 , 0 } ,
											add_to_shooter = true
										}
									}
								}
							}
						}
					}
				}
			}
		}
	} ,
	body =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "终末之横扫千军光束-激光-身体" ) ,
				priority = "medium" ,
				blend_mode = "additive" ,
				flags = { "trilinear-filtering" } ,
				width = 64 ,
				height = 12 ,
				frame_count = 8 ,
				line_length = 8 ,
				animation_speed = 0.5 ,
				scale = 1.5
			}
		}
	} ,
	head =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "终末之横扫千军光束-激光-身体" ) ,
				priority = "medium" ,
				blend_mode = "additive" ,
				flags = { "trilinear-filtering" } ,
				width = 64 ,
				height = 12 ,
				frame_count = 8 ,
				line_length = 8 ,
				animation_speed = 0.5 ,
				scale = 1.5
			}
		}
	} ,
	tail =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "终末之横扫千军光束-激光-尾部" ) ,
				priority = "medium" ,
				blend_mode = "additive" ,
				flags = { "trilinear-filtering" } ,
				width = 110 ,
				height = 62 ,
				frame_count = 8 ,
				line_length = 8 ,
				animation_speed = 0.5 ,
				scale = 1.5 ,
				shift = SIUtils.by_pixel( 11.5 , 1 )
			}
		}
	} ,
	light_animations =
	{
		body =
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "终末之横扫千军光束-激光-身体-光效" ) ,
					priority = "medium" ,
					width = 64 ,
					height = 12 ,
					frame_count = 8 ,
					line_length = 8 ,
					animation_speed = 0.5 ,
					scale = 1.5
				}
			}
		} ,
		head =
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "终末之横扫千军光束-激光-身体-光效" ) ,
					priority = "medium" ,
					width = 64 ,
					height = 12 ,
					frame_count = 8 ,
					line_length = 8 ,
					animation_speed = 0.5 ,
					scale = 1.5
				}
			}
		} ,
		tail =
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "终末之横扫千军光束-激光-尾部-光效" ) ,
					priority = "medium" ,
					width = 110 ,
					height = 62 ,
					frame_count = 8 ,
					line_length = 8 ,
					animation_speed = 0.5 ,
					scale = 1.5 ,
					shift = SIUtils.by_pixel( 11.5 , 1 )
				}
			}
		}
	} ,
	ground_light_animations =
	{
		body =
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "终末之横扫千军光束-激光-地面-身体" ) ,
					priority = "medium" ,
					width = 64 ,
					height = 256 ,
					frame_count = 1 ,
					line_length = 1 ,
					repeat_count = 8 ,
					animation_speed = 0.5 ,
					scale = 1.5 ,
					tint = { r = 0.50 , g = 0.50 , b = 0.05 }
				}
			}
		} ,
		head =
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "终末之横扫千军光束-激光-地面-头部" ) ,
					priority = "medium" ,
					width = 256 ,
					height = 256 ,
					frame_count = 1 ,
					line_length = 1 ,
					repeat_count = 8 ,
					animation_speed = 0.5 ,
					scale = 1.5 ,
					tint = { r = 0.50 , g = 0.50 , b = 0.05 } ,
					shift = SIUtils.by_pixel( -32 , 0 )
				}
			}
		} ,
		tail =
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "终末之横扫千军光束-激光-地面-尾部" ) ,
					priority = "medium" ,
					width = 256 ,
					height = 256 ,
					frame_count = 1 ,
					line_length = 1 ,
					repeat_count = 8 ,
					animation_speed = 0.5 ,
					scale = 1.5 ,
					tint = { r = 0.50 , g = 0.50 , b = 0.05 } ,
					shift = SIUtils.by_pixel( 32 , 0 )
				}
			}
		}
	} ,
	working_sound =
	{
		sound =
		{
			SISound.Base( "fight/laser-beam" , 0.75 )
		} ,
		max_sounds_per_type = 1
	}
}
.New( SICommon.Types.Items.Item , "Laser" , "终末之横扫千军光束" )
.AutoIcon()
.Append
{
	flags = { SICommon.Flags.Item.Hidden } ,
	stack_size = 10 ,
	default_request_amount = 10 ,
	fuel_category = SIConstants_Core.raw.Categories.Fuel.Special ,
	fuel_value = "2MJ" ,
	fuel_acceleration_multiplier = 1.32 ,
	fuel_top_speed_multiplier = 1.24 ,
	fuel_emissions_multiplier = 115.65 ,
	fuel_glow_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	burnt_result = SIConstants_Core.raw.Items.Candy ,
	place_result = nil ,
	placed_as_equipment_result = nil ,
	rocket_launch_products =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			amount = 2 ,
			catalyst_amount = 2
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.2 ,
			amount_min = 0 ,
			amount_max = 20 ,
			catalyst_amount = 20
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.06 ,
			amount_min = 0 ,
			amount_max = 200 ,
			catalyst_amount = 200
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.02 ,
			amount_min = 0 ,
			amount_max = 2000 ,
			catalyst_amount = 2000
		}
	}
}
.New( SICommon.Types.Entities.Turret , "Laser" , "终末之横扫千军光束" )
.AutoIcon()
.SetSize( 2 , 2 )
.ReferencePlaceResult( SICommon.Types.Items.Item , SIConstants_Core.raw.Items.Laser )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceablePlayer , SICommon.Flags.Entity.PlayerCreation , SICommon.Flags.Entity.Hidden } ,
	minable =
	{
		mining_time = 5.0 ,
		results =
		{
			{
				type = SICommon.Types.Items.Item ,
				name = SIConstants_Core.raw.Items.Laser ,
				amount = 1
			}
		}
	} ,
	max_health = maxHealth ,
	corpse = "laser-turret-remnants" ,
	dying_explosion = "nuke-explosion" ,
	map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	friendly_map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	enemy_map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	is_military_target = true ,
	allow_run_time_change_of_is_military_target = true ,
	alert_when_damaged = true ,
	create_ghost_on_death = false ,
	hide_resistances = true ,
	resistances = defaultResistances ,
	damaged_trigger_effect =
	{
		type = "create-entity" ,
		entity_name = "spark-explosion" ,
		offset_deviation = { { -0.5 , -0.5 } , { 0.5 , 0.5 } } ,
		offsets = { { 0 , 1 } } ,
		damage_type_filters = "fire"
	} ,
	repair_speed_modifier = 12.0 ,
	alert_when_attacking = true ,
	rotation_speed = 0.02 ,
	preparing_speed = 0.08 ,
	folding_speed = 0.08 ,
	attacking_speed = 1.0 ,
	call_for_help_radius = 30 ,
	attack_parameters =
	{
		type = "beam" ,
		cooldown = 4 ,
		range = 74 ,
		damage_modifier = 1 ,
		movement_slow_down_factor = 0.5 ,
		source_direction_count = 64 ,
		source_offset = { 0 , -0.85587225 } ,
		ammo_type =
		{
			category = SIConstants_Core.raw.Categories.Ammo.Special ,
			target_type = "entity" ,
			action =
			{
				{
					type = "direct" ,
					force = "enemy" ,
					show_in_tooltip = true ,
					action_delivery =
					{
						{
							type = "beam" ,
							beam = SIConstants_Core.raw.Entities.Laser_BeamLarge ,
							max_length = 0 ,
							duration = 4 ,
							source_offset = { 0 , -1.31439 } ,
							add_to_shooter = true
						}
					}
				}
			}
		}
	} ,
	base_picture =
	{
		layers =
		{
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "终末之横扫千军光束" ) ,
				priority = "high" ,
				width = 70 ,
				height = 52 ,
				frame_count = 1 ,
				line_length = 1 ,
				direction_count = 1 ,
				shift = SIUtils.by_pixel( 0 , 2 )
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "终末之横扫千军光束-影子" ) ,
				priority = "medium" ,
				width = 66 ,
				height = 42 ,
				frame_count = 1 ,
				line_length = 1 ,
				direction_count = 1 ,
				shift = SIUtils.by_pixel( 6 , 3 ) ,
				draw_as_shadow = true
			}
		}
	} ,
	preparing_animation =
	{
		layers =
		{
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "终末之横扫千军光束-升起" ) ,
				priority = "medium" ,
				run_mode = "forward" ,
				width = 66 ,
				height = 64 ,
				frame_count = 15 ,
				line_length = 15 ,
				direction_count = 4 ,
				shift = SIUtils.by_pixel( 0 , -32 ) ,
				axially_symmetrical = false
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "终末之横扫千军光束-升起-遮盖" ) ,
				priority = "medium" ,
				run_mode = "forward" ,
				flags = { "mask" } ,
				width = 44 ,
				height = 40 ,
				frame_count = 15 ,
				line_length = 15 ,
				direction_count = 4 ,
				shift = SIUtils.by_pixel( 0 , -43 ) ,
				axially_symmetrical = false ,
				apply_runtime_tint = true
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "终末之横扫千军光束-升起-影子" ) ,
				priority = "medium" ,
				run_mode = "forward" ,
				width = 92 ,
				height = 50 ,
				frame_count = 15 ,
				line_length = 15 ,
				direction_count = 4 ,
				shift = SIUtils.by_pixel( 47 , 3 ) ,
				draw_as_shadow = true ,
				axially_symmetrical = false
			}
		}
	} ,
	prepared_animation =
	{
		layers =
		{
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "终末之横扫千军光束-射击" ) ,
				priority = "medium" ,
				width = 64 ,
				height = 60 ,
				frame_count = 1 ,
				line_length = 8 ,
				direction_count = 64 ,
				shift = SIUtils.by_pixel( 0 , -35 )
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "终末之横扫千军光束-射击-遮盖" ) ,
				priority = "medium" ,
				flags = { "mask" } ,
				width = 46 ,
				height = 42 ,
				frame_count = 1 ,
				line_length = 8 ,
				direction_count = 64 ,
				shift = SIUtils.by_pixel( 0 , -43 ) ,
				apply_runtime_tint = true
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "终末之横扫千军光束-射击-影子" ) ,
				priority = "medium" ,
				width = 86 ,
				height = 46 ,
				frame_count = 1 ,
				line_length = 8 ,
				direction_count = 64 ,
				shift = SIUtils.by_pixel( 51 , 2 ) ,
				draw_as_shadow = true
			}
		}
	} ,
	folding_animation =
	{
		layers =
		{
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "终末之横扫千军光束-升起" ) ,
				priority = "medium" ,
				run_mode = "backward" ,
				width = 66 ,
				height = 64 ,
				frame_count = 15 ,
				line_length = 15 ,
				direction_count = 4 ,
				shift = SIUtils.by_pixel( 0 , -32 ) ,
				axially_symmetrical = false
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "终末之横扫千军光束-升起-遮盖" ) ,
				priority = "medium" ,
				run_mode = "backward" ,
				flags = { "mask" } ,
				width = 44 ,
				height = 40 ,
				frame_count = 15 ,
				line_length = 15 ,
				direction_count = 4 ,
				shift = SIUtils.by_pixel( 0 , -43 ) ,
				axially_symmetrical = false ,
				apply_runtime_tint = true
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "终末之横扫千军光束-升起-影子" ) ,
				priority = "medium" ,
				run_mode = "backward" ,
				width = 92 ,
				height = 50 ,
				frame_count = 15 ,
				line_length = 15 ,
				direction_count = 4 ,
				shift = SIUtils.by_pixel( 47 , 3 ) ,
				draw_as_shadow = true ,
				axially_symmetrical = false
			}
		}
	} ,
	folded_animation =
	{
		layers =
		{
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "终末之横扫千军光束-升起" ) ,
				priority = "medium" ,
				run_mode = "forward" ,
				width = 66 ,
				height = 64 ,
				frame_count = 1 ,
				line_length = 1 ,
				direction_count = 4 ,
				shift = SIUtils.by_pixel( 0 , -32 ) ,
				axially_symmetrical = false
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "终末之横扫千军光束-升起-遮盖" ) ,
				priority = "medium" ,
				run_mode = "forward" ,
				flags = { "mask" } ,
				width = 44 ,
				height = 40 ,
				frame_count = 1 ,
				line_length = 1 ,
				direction_count = 4 ,
				shift = SIUtils.by_pixel( 0 , -43 ) ,
				axially_symmetrical = false ,
				apply_runtime_tint = true
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "终末之横扫千军光束-升起-影子" ) ,
				priority = "medium" ,
				run_mode = "forward" ,
				width = 92 ,
				height = 50 ,
				frame_count = 1 ,
				line_length = 1 ,
				direction_count = 4 ,
				shift = SIUtils.by_pixel( 47 , 3 ) ,
				draw_as_shadow = true ,
				axially_symmetrical = false
			}
		}
	} ,
	glow_light_intensity = 0.5 ,
	energy_glow_animation =
	{
		layers =
		{
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "终末之横扫千军光束-射击-光效" ) ,
				priority = "medium" ,
				blend_mode = "additive" ,
				width = 62 ,
				height = 58 ,
				frame_count = 1 ,
				line_length = 8 ,
				direction_count = 64 ,
				shift = SIUtils.by_pixel( 0 , -35 )
			}
		}
	} ,
	water_reflection =
	{
		rotate = false ,
		orientation_to_variation = false ,
		pictures =
		{
			filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "终末之横扫千军光束-反射" ) ,
			priority = "extra-high" ,
			width = 20 ,
			height = 32 ,
			variation_count = 1 ,
			scale = 5.0 ,
			shift = SIUtils.by_pixel( 0 , 40 )
		}
	} ,
	mined_sound =
	{
		SISound.Core( "deconstruct-small" , 1 )
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
	preparing_sound =
	{
		SISound.Base( "fight/laser-turret-activate-01" , 0.3 ) ,
		SISound.Base( "fight/laser-turret-activate-02" , 0.3 ) ,
		SISound.Base( "fight/laser-turret-activate-03" , 0.3 )
	} ,
	folding_sound =
	{
		SISound.Base( "fight/laser-turret-deactivate-01" , 0.3 ) ,
		SISound.Base( "fight/laser-turret-deactivate-02" , 0.3 ) ,
		SISound.Base( "fight/laser-turret-deactivate-03" , 0.3 ) ,
		SISound.Base( "fight/laser-turret-deactivate-04" , 0.3 )
	}
}
.New( SICommon.Types.Equipments.ActiveDefense , "Laser" , "终末之横扫千军光束" ,
{
	take_result = SIConstants_Core.raw.Items.Laser ,
	categories =
	{
		SIConstants_Core.raw.Categories.Equipment.Special
	} ,
	background_color = SICommon.Colors.Equipment.Attack ,
	background_border_color = SICommon.Colors.Equipment.Border ,
	grabbed_background_color = SICommon.Colors.Equipment.AttackHover ,
	shape =
	{
		type = SICommon.Flags.EquipmentShapeType.Full ,
		width = 2 ,
		height = 2
	} ,
	energy_source =
	{
		type = SICommon.Flags.EnergySourceType.Electric ,
		emissions_per_minute = 0 ,
		render_no_power_icon = false ,
		render_no_network_icon = false ,
		usage_priority = SICommon.Flags.ElectricUsagePriority.InputSecondary ,
		buffer_capacity = "50TJ" ,
		input_flow_limit = "10TW" ,
		output_flow_limit = "10TW" ,
		drain = "0J"
	} ,
	automatic = true ,
	attack_parameters =
	{
		type = "beam" ,
		cooldown = 4 ,
		range = 50 ,
		damage_modifier = 1.5 ,
		source_direction_count = 64 ,
		source_offset = { 0 , -0.5 } ,
		ammo_type =
		{
			category = SIConstants_Core.raw.Categories.Ammo.Special ,
			energy_consumption = "60GJ" ,
			action =
			{
				{
					type = "direct" ,
					force = "enemy" ,
					action_delivery =
					{
						{
							type = "beam" ,
							beam = SIConstants_Core.raw.Entities.Laser_BeamSmall ,
							max_length = 0 ,
							duration = 4 ,
							source_offset = { 0 , -1 } ,
							add_to_shooter = true
						}
					}
				}
			}
		}
	} ,
	sprite =
	{
		filename = SIGen.MakePicturePath( SICommon.Types.Items.Item , "终末之横扫千军光束" .. SICommon.ShowNameSuffix.ICON ) ,
		priority = "medium" ,
		width = 64 ,
		height = 64 ,
		scale = 1.0
	}
} )
.MakeIcon( SICommon.Types.Items.Item , "终末之横扫千军光束" , 64 , 4 )
.ReferenceEquipmentResult( SICommon.Types.Items.Item , SIConstants_Core.raw.Items.Laser )

-- ----------------------------------------
-- 超越之安如磐石战车
-- ----------------------------------------
.New( SICommon.Types.Items.Gun , "Tank_Gun" , "超越之安如磐石战车-机枪" )
.AutoIcon()
.Append
{
	flags = { SICommon.Flags.Item.Hidden } ,
	stack_size = 1 ,
	default_request_amount = 1 ,
	fuel_category = SIConstants_Core.raw.Categories.Fuel.Special ,
	fuel_value = "4MJ" ,
	fuel_acceleration_multiplier = 2.65 ,
	fuel_top_speed_multiplier = 1.14 ,
	fuel_emissions_multiplier = 46.22 ,
	fuel_glow_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	burnt_result = SIConstants_Core.raw.Items.Candy ,
	rocket_launch_products =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			amount = 2 ,
			catalyst_amount = 2
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.2 ,
			amount_min = 0 ,
			amount_max = 20 ,
			catalyst_amount = 20
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.06 ,
			amount_min = 0 ,
			amount_max = 200 ,
			catalyst_amount = 200
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.02 ,
			amount_min = 0 ,
			amount_max = 2000 ,
			catalyst_amount = 2000
		}
	} ,
	attack_parameters =
	{
		type = "projectile" ,
		cooldown = 4 ,
		range = 60 ,
		movement_slow_down_factor = 1.0 ,
		projectile_creation_distance = 1 ,
		projectile_center = { -0.15625 , -0.07812 } ,
		ammo_categories =
		{
			"bullet"
		} ,
		shell_particle =
		{
			name = "shell-particle" ,
			direction_deviation = 0.1 ,
			speed = 0.1 ,
			speed_deviation = 0.03 ,
			center = { 0 , 0 } ,
			creation_distance = -0.6875 ,
			starting_frame_speed = 0.4 ,
			starting_frame_speed_deviation = 0.1
		} ,
		sound =
		{
			SISound.Base( "fight/heavy-gunshot-1" , 0.4 ) ,
			SISound.Base( "fight/heavy-gunshot-2" , 0.4 ) ,
			SISound.Base( "fight/heavy-gunshot-3" , 0.4 ) ,
			SISound.Base( "fight/heavy-gunshot-4" , 0.4 )
		}
	}
}
.New( SICommon.Types.Items.Gun , "Tank_Shut" , "超越之安如磐石战车-霰弹" )
.AutoIcon()
.Append
{
	flags = { SICommon.Flags.Item.Hidden } ,
	stack_size = 1 ,
	default_request_amount = 1 ,
	fuel_category = SIConstants_Core.raw.Categories.Fuel.Special ,
	fuel_value = "4MJ" ,
	fuel_acceleration_multiplier = 2.65 ,
	fuel_top_speed_multiplier = 1.14 ,
	fuel_emissions_multiplier = 46.22 ,
	fuel_glow_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	burnt_result = SIConstants_Core.raw.Items.Candy ,
	rocket_launch_products =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			amount = 2 ,
			catalyst_amount = 2
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.2 ,
			amount_min = 0 ,
			amount_max = 20 ,
			catalyst_amount = 20
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.06 ,
			amount_min = 0 ,
			amount_max = 200 ,
			catalyst_amount = 200
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.02 ,
			amount_min = 0 ,
			amount_max = 2000 ,
			catalyst_amount = 2000
		}
	} ,
	attack_parameters =
	{
		type = "projectile" ,
		cooldown = 10 ,
		range = 60 ,
		movement_slow_down_factor = 1.0 ,
		projectile_creation_distance = 1.125 ,
		projectile_center = { -0.15625 , -0.07812 } ,
		ammo_categories =
		{
			"shotgun-shell"
		} ,
		shell_particle =
		{
			name = "shell-particle" ,
			direction_deviation = 0.1 ,
			speed = 0.1 ,
			speed_deviation = 0.03 ,
			center = { 0 , 0 } ,
			creation_distance = -0.6875 ,
			starting_frame_speed = 0.4 ,
			starting_frame_speed_deviation = 0.1
		} ,
		sound =
		{
			SISound.Base( "fight/pump-shotgun-1" , 0.4 ) ,
			SISound.Base( "fight/pump-shotgun-2" , 0.4 ) ,
			SISound.Base( "fight/pump-shotgun-3" , 0.4 ) ,
			SISound.Base( "fight/pump-shotgun-4" , 0.4 ) ,
			SISound.Base( "fight/pump-shotgun-5" , 0.4 )
		}
	}
}
.New( SICommon.Types.Items.Gun , "Tank_Cannon" , "超越之安如磐石战车-炮塔" )
.AutoIcon()
.Append
{
	flags = { SICommon.Flags.Item.Hidden } ,
	stack_size = 1 ,
	default_request_amount = 1 ,
	fuel_category = SIConstants_Core.raw.Categories.Fuel.Special ,
	fuel_value = "4MJ" ,
	fuel_acceleration_multiplier = 2.65 ,
	fuel_top_speed_multiplier = 1.14 ,
	fuel_emissions_multiplier = 46.22 ,
	fuel_glow_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	burnt_result = SIConstants_Core.raw.Items.Candy ,
	rocket_launch_products =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			amount = 2 ,
			catalyst_amount = 2
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.2 ,
			amount_min = 0 ,
			amount_max = 20 ,
			catalyst_amount = 20
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.06 ,
			amount_min = 0 ,
			amount_max = 200 ,
			catalyst_amount = 200
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.02 ,
			amount_min = 0 ,
			amount_max = 2000 ,
			catalyst_amount = 2000
		}
	} ,
	attack_parameters =
	{
		type = "projectile" ,
		cooldown = 25 ,
		range = 95 ,
		movement_slow_down_factor = 1.0 ,
		projectile_creation_distance = 1.6 ,
		projectile_center = { -0.15625 , -0.07812 } ,
		ammo_categories =
		{
			"cannon-shell"
		} ,
		shell_particle =
		{
			name = "shell-particle" ,
			direction_deviation = 0.1 ,
			speed = 0.1 ,
			speed_deviation = 0.03 ,
			center = { 0 , 0 } ,
			creation_distance = -0.6875 ,
			starting_frame_speed = 0.4 ,
			starting_frame_speed_deviation = 0.1
		} ,
		sound =
		{
			SISound.Base( "fight/tank-cannon-1" , 0.6 ) ,
			SISound.Base( "fight/tank-cannon-2" , 0.6 ) ,
			SISound.Base( "fight/tank-cannon-3" , 0.6 ) ,
			SISound.Base( "fight/tank-cannon-4" , 0.6 ) ,
			SISound.Base( "fight/tank-cannon-5" , 0.6 )
		}
	}
}
.New( SICommon.Types.Items.Gun , "Tank_Rocket" , "超越之安如磐石战车-火箭" )
.AutoIcon()
.Append
{
	flags = { SICommon.Flags.Item.Hidden } ,
	stack_size = 1 ,
	default_request_amount = 1 ,
	fuel_category = SIConstants_Core.raw.Categories.Fuel.Special ,
	fuel_value = "4MJ" ,
	fuel_acceleration_multiplier = 2.65 ,
	fuel_top_speed_multiplier = 1.14 ,
	fuel_emissions_multiplier = 46.22 ,
	fuel_glow_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	burnt_result = SIConstants_Core.raw.Items.Candy ,
	rocket_launch_products =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			amount = 2 ,
			catalyst_amount = 2
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.2 ,
			amount_min = 0 ,
			amount_max = 20 ,
			catalyst_amount = 20
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.06 ,
			amount_min = 0 ,
			amount_max = 200 ,
			catalyst_amount = 200
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.02 ,
			amount_min = 0 ,
			amount_max = 2000 ,
			catalyst_amount = 2000
		}
	} ,
	attack_parameters =
	{
		type = "projectile" ,
		cooldown = 20 ,
		range = 95 ,
		movement_slow_down_factor = 1.0 ,
		projectile_creation_distance = 0.5 ,
		projectile_orientation_offset = -0.0625 ,
		projectile_center = { -0.15625 , -0.07812 } ,
		ammo_categories =
		{
			"rocket"
		} ,
		shell_particle =
		{
			name = "shell-particle" ,
			direction_deviation = 0.1 ,
			speed = 0.1 ,
			speed_deviation = 0.03 ,
			center = { 0 , 0 } ,
			creation_distance = -0.6875 ,
			starting_frame_speed = 0.4 ,
			starting_frame_speed_deviation = 0.1
		} ,
		sound =
		{
			SISound.Base( "fight/rocket-launcher" , 0.7 )
		}
	}
}
.New( SICommon.Types.Items.Gun , "Tank_Flame" , "超越之安如磐石战车-喷火" )
.AutoIcon()
.Append
{
	flags = { SICommon.Flags.Item.Hidden } ,
	stack_size = 1 ,
	default_request_amount = 1 ,
	fuel_category = SIConstants_Core.raw.Categories.Fuel.Special ,
	fuel_value = "4MJ" ,
	fuel_acceleration_multiplier = 2.65 ,
	fuel_top_speed_multiplier = 1.14 ,
	fuel_emissions_multiplier = 46.22 ,
	fuel_glow_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	burnt_result = SIConstants_Core.raw.Items.Candy ,
	rocket_launch_products =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			amount = 2 ,
			catalyst_amount = 2
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.2 ,
			amount_min = 0 ,
			amount_max = 20 ,
			catalyst_amount = 20
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.06 ,
			amount_min = 0 ,
			amount_max = 200 ,
			catalyst_amount = 200
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.02 ,
			amount_min = 0 ,
			amount_max = 2000 ,
			catalyst_amount = 2000
		}
	} ,
	attack_parameters =
	{
		type = "stream" ,
		cooldown = 1 ,
		range = 60 ,
		min_range = 5 ,
		movement_slow_down_factor = 1.0 ,
		gun_barrel_length = 1.4 ,
		gun_center_shift = { -0.17 , -1.15 } ,
		ammo_categories =
		{
			"flamethrower"
		} ,
		cyclic_sound =
		{
			begin_sound =
			{
				SISound.Base( "fight/flamethrower-start" , 1 )
			} ,
			middle_sound =
			{
				SISound.Base( "fight/flamethrower-mid" , 1 )
			} ,
			end_sound =
			{
				SISound.Base( "fight/flamethrower-end" , 1 )
			}
		}
	}
}
.New( SICommon.Types.Items.Gun , "Tank_Heavy" , "超越之安如磐石战车-重炮" )
.AutoIcon()
.Append
{
	flags = { SICommon.Flags.Item.Hidden } ,
	stack_size = 1 ,
	default_request_amount = 1 ,
	fuel_category = SIConstants_Core.raw.Categories.Fuel.Special ,
	fuel_value = "4MJ" ,
	fuel_acceleration_multiplier = 2.65 ,
	fuel_top_speed_multiplier = 1.14 ,
	fuel_emissions_multiplier = 46.22 ,
	fuel_glow_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	burnt_result = SIConstants_Core.raw.Items.Candy ,
	rocket_launch_products =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			amount = 2 ,
			catalyst_amount = 2
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.2 ,
			amount_min = 0 ,
			amount_max = 20 ,
			catalyst_amount = 20
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.06 ,
			amount_min = 0 ,
			amount_max = 200 ,
			catalyst_amount = 200
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.02 ,
			amount_min = 0 ,
			amount_max = 2000 ,
			catalyst_amount = 2000
		}
	} ,
	attack_parameters =
	{
		type = "projectile" ,
		cooldown = 120 ,
		range = 288 , -- 9 * 32 格
		min_range = 5 ,
		movement_slow_down_factor = 1.0 ,
		projectile_creation_distance = 1.6 ,
		projectile_center = { -0.15625 , -0.07812 } ,
		ammo_categories =
		{
			"artillery-shell"
		} ,
		projectile_creation_parameters = SINeed( "Gen/HeavyGunParameter" ) ,
		shell_particle =
		{
			name = "artillery-shell-particle" ,
			direction_deviation = 0.05 ,
			direction = 0.4 ,
			speed = 0.10 ,
			speed_deviation = 0.1 ,
			vertical_speed = 0.05 ,
			vertical_speed_deviation = 0.01 ,
			center = { 0 , -0.5 } ,
			creation_distance = 0.5 ,
			creation_distance_orientation = 0.4 ,
			starting_frame_speed = 0.5 ,
			starting_frame_speed_deviation = 0.5 ,
			use_source_position = true ,
			height = 1
		} ,
		sound =
		{
			SISound.Base( "fight/artillery-shoots-1" , 0.7 )
		}
	}
}
.New( SICommon.Types.EquipmentGrid , "Tank_Grid" , "超越之安如磐石战车-区域" ,
{
	width = 20 ,
	height = 20 ,
	equipment_categories =
	{
		"armor" ,
		SIConstants_Core.raw.Categories.Equipment.Special
	}
} )
.New( SICommon.Types.Items.ItemEntity , "Tank" , "超越之安如磐石战车" )
.AutoIcon()
.Append
{
	flags = { SICommon.Flags.Item.Hidden } ,
	stack_size = 1 ,
	default_request_amount = 1 ,
	fuel_category = SIConstants_Core.raw.Categories.Fuel.Special ,
	fuel_value = "15MJ" ,
	fuel_acceleration_multiplier = 4.85 ,
	fuel_top_speed_multiplier = 1.02 ,
	fuel_emissions_multiplier = 175.65 ,
	fuel_glow_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	burnt_result = SIConstants_Core.raw.Items.Candy ,
	place_result = nil ,
	placed_as_equipment_result = nil ,
	rocket_launch_products =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			amount = 2 ,
			catalyst_amount = 2
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.2 ,
			amount_min = 0 ,
			amount_max = 20 ,
			catalyst_amount = 20
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.06 ,
			amount_min = 0 ,
			amount_max = 200 ,
			catalyst_amount = 200
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.02 ,
			amount_min = 0 ,
			amount_max = 2000 ,
			catalyst_amount = 2000
		}
	}
}
.New( SICommon.Types.Entities.Car , "Tank" , "超越之安如磐石战车" )
.AutoIcon()
.ReferencePlaceResult( SICommon.Types.Items.ItemEntity , SIConstants_Core.raw.Items.Tank )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceablePlayer , SICommon.Flags.Entity.PlayerCreation , SICommon.Flags.Entity.PlaceableOffGrid , SICommon.Flags.Entity.NotFlammable , SICommon.Flags.Entity.Hidden } ,
	minable =
	{
		mining_time = 10.0 ,
		results =
		{
			{
				type = SICommon.Types.Items.Item ,
				name = SIConstants_Core.raw.Items.Tank ,
				amount = 1
			}
		}
	} ,
	selection_box = { { -0.9 * tankSize , -1.3 * tankSize } , { 0.9 * tankSize , 1.3 * tankSize } } ,
	collision_box = { { -0.9 * tankSize , -1.3 * tankSize } , { 0.9 * tankSize , 1.3 * tankSize } } ,
	drawing_box = { { -1.8 * tankSize , -1.8 * tankSize } , { 1.8 * tankSize , 1.5 * tankSize } } ,
	collision_mask = { SICommon.Flags.CollisionMask.ConsiderTileTransitions } ,
	max_health = maxHealth * 20 ,
	corpse = "tank-remnants" ,
	dying_explosion = "nuke-explosion" ,
	map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	friendly_map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	enemy_map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	is_military_target = true ,
	allow_run_time_change_of_is_military_target = true ,
	alert_when_damaged = true ,
	create_ghost_on_death = false ,
	hide_resistances = true ,
	resistances =
	{
		SITools.Resistance( "physical" , 22 , 35 ) ,
		SITools.Resistance( "impact" , 0 , 100 ) ,
		SITools.Resistance( "poison" , 0 , 100 ) ,
		SITools.Resistance( "explosion" , 0 , 100 ) ,
		SITools.Resistance( "fire" , 0 , 96 ) ,
		SITools.Resistance( "laser" , 22 , 35 ) ,
		SITools.Resistance( "acid" , 4 , 90 ) ,
		SITools.Resistance( "electric" , 4 , 96 ) ,
	} ,
	damaged_trigger_effect =
	{
		type = "create-entity" ,
		entity_name = "spark-explosion" ,
		offset_deviation = { { -0.5 , -0.5 } , { 0.5 , 0.5 } } ,
		offsets = { { 0 , 1 } } ,
		damage_type_filters = "fire"
	} ,
	repair_speed_modifier = 26.0 ,
	burner =
	{
		type = SICommon.Flags.EnergySourceType.Burner ,
		emissions_per_minute = 10 ,
		render_no_power_icon = true ,
		render_no_network_icon = true ,
		fuel_inventory_size = 3 ,
		burnt_inventory_size = 3 ,
		effectivity = 1 ,
		fuel_categories =
		{
			"chemical" ,
			"nuclear" ,
			SIConstants_Core.raw.Categories.Fuel.Special
		} ,
		smoke =
		{
			{
				name = "tank-smoke" ,
				deviation = { 0.25 , 0.25 } ,
				frequency = 50 ,
				position = { 0 , 1.5 } ,
				starting_frame = 0 ,
				starting_frame_deviation = 60
			}
		} ,
		light_flicker = nil
	} ,
	weight = 2000000000 ,
	braking_power = "200TW" ,
	consumption = "3TW" ,
	effectivity = 1.0 ,
	terrain_friction_modifier = 0.1 ,
	friction = 0.0001 ,
	stop_trigger_speed = 0.1 ,
	stop_trigger =
	{
		{
			type = "play-sound" ,
			sound =
			{
				SISound.Base( "fight/tank-brakes" , 0.3 )
			}
		}
	} ,
	tank_driving = true ,
	energy_per_hit_point = 0 ,
	has_belt_immunity = true ,
	immune_to_tree_impacts = true ,
	immune_to_rock_impacts = true ,
	inventory_size = 200 ,
	equipment_grid = SIConstants_Core.raw.EquipmentGrids.Tank_Grid ,
	guns =
	{
		SIConstants_Core.raw.Items.Tank_Gun ,
		SIConstants_Core.raw.Items.Tank_Shut ,
		SIConstants_Core.raw.Items.Tank_Cannon ,
		SIConstants_Core.raw.Items.Tank_Rocket ,
		SIConstants_Core.raw.Items.Tank_Flame ,
		SIConstants_Core.raw.Items.Tank_Heavy
	} ,
	track_particle_triggers = SINeed( "Gen/TankTrack" ) ,
	rotation_speed = 0.012 ,
	turret_rotation_speed = 0.02 ,
	turret_return_timeout = 600 ,
	alert_icon_shift = SIUtils.by_pixel( 0 , -13 ) ,
	light =
	{
		{
			type = "oriented" ,
			minimum_darkness = 0.35 ,
			size = 5.0 ,
			intensity = 0.8 ,
			source_orientation_offset = -0.02 ,
			shift = { -0.1 , -14 + tankShiftY / 32 } ,
			color = { r = 1.00 , g = 1.00 , b = 0.8 } ,
			picture =
			{
				layers =
				{
					{
						filename = "__core__/graphics/light-cone.png" ,
						priority = "extra-high" ,
						flags = { "light" } ,
						width = 200 ,
						height = 200 ,
						scale = 5.0
					}
				}
			}
		} ,
		{
			type = "oriented" ,
			minimum_darkness = 0.35 ,
			size = 5.0 ,
			intensity = 0.8 ,
			source_orientation_offset = 0.02 ,
			shift = { 0.1 , -14 + tankShiftY / 32 } ,
			color = { r = 1.00 , g = 1.00 , b = 0.8 } ,
			picture =
			{
				layers =
				{
					{
						filename = "__core__/graphics/light-cone.png" ,
						priority = "extra-high" ,
						flags = { "light" } ,
						width = 200 ,
						height = 200 ,
						scale = 5.0
					}
				}
			}
		}
	} ,
	light_animation =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "超越之安如磐石战车-光效" ) ,
				priority = "low" ,
				blend_mode = "additive" ,
				width = 260 ,
				height = 210 ,
				frame_count = 1 ,
				repeat_count = 2 ,
				line_length = 8 ,
				direction_count = 64 ,
				scale = tankScale ,
				shift = SIUtils.by_pixel( -1 * tankSize , ( -17 + tankShiftY ) * tankSize ) ,
				draw_as_glow = true
			}
		}
	} ,
	animation =
	{
		layers =
		{
			{
				stripes =
				{
					{
						filename = SIGen.MakeSelfPicturePath( "超越之安如磐石战车-1" ) ,
						width_in_frames = 2 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakeSelfPicturePath( "超越之安如磐石战车-2" ) ,
						width_in_frames = 2 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakeSelfPicturePath( "超越之安如磐石战车-3" ) ,
						width_in_frames = 2 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakeSelfPicturePath( "超越之安如磐石战车-4" ) ,
						width_in_frames = 2 ,
						height_in_frames = 16
					}
				} ,
				priority = "low" ,
				width = 270 ,
				height = 212 ,
				frame_count = 2 ,
				animation_speed = 8 ,
				direction_count = 64 ,
				max_advance = 1 ,
				scale = tankScale ,
				shift = SIUtils.by_pixel( 0 * tankSize , ( -16 + tankShiftY ) * tankSize )
			} ,
			{
				stripes = SIUtils.multiplystripes( 2 ,
				{
					{
						filename = SIGen.MakeSelfPicturePath( "超越之安如磐石战车-遮盖-1" ) ,
						width_in_frames = 1 ,
						height_in_frames = 22
					} ,
					{
						filename = SIGen.MakeSelfPicturePath( "超越之安如磐石战车-遮盖-2" ) ,
						width_in_frames = 1 ,
						height_in_frames = 22
					} ,
					{
						filename = SIGen.MakeSelfPicturePath( "超越之安如磐石战车-遮盖-3" ) ,
						width_in_frames = 1 ,
						height_in_frames = 20
					}
				} ) ,
				priority = "low" ,
				width = 208 ,
				height = 166 ,
				frame_count = 2 ,
				line_length = 2 ,
				direction_count = 64 ,
				max_advance = 1 ,
				scale = tankScale ,
				shift = SIUtils.by_pixel( 0 * tankSize , ( -22.5 + tankShiftY ) * tankSize ) ,
				apply_runtime_tint = true
			} ,
			{
				stripes = SIUtils.multiplystripes( 2 ,
				{
					{
						filename = SIGen.MakeSelfPicturePath( "超越之安如磐石战车-影子-1" ) ,
						width_in_frames = 1 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakeSelfPicturePath( "超越之安如磐石战车-影子-2" ) ,
						width_in_frames = 1 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakeSelfPicturePath( "超越之安如磐石战车-影子-3" ) ,
						width_in_frames = 1 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakeSelfPicturePath( "超越之安如磐石战车-影子-4" ) ,
						width_in_frames = 1 ,
						height_in_frames = 16
					}
				} ) ,
				priority = "low" ,
				width = 302 ,
				height = 194 ,
				frame_count = 2 ,
				direction_count = 64 ,
				max_advance = 1 ,
				scale = tankScale ,
				shift = SIUtils.by_pixel( 21.5 * tankSize , ( 1 + tankShiftY ) * tankSize ) ,
				draw_as_shadow = true
			}
		}
	} ,
	turret_animation =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "超越之安如磐石战车-炮塔" ) ,
				priority = "low" ,
				width = 179 ,
				height = 132 ,
				frame_count = 1 ,
				line_length = 8 ,
				animation_speed = 8 ,
				direction_count = 64 ,
				scale = tankScale ,
				shift = SIUtils.by_pixel( 0.25 * tankSize , ( -40.5 + tankShiftY ) * tankSize )
			} ,
			{
				filename = SIGen.MakeSelfPicturePath( "超越之安如磐石战车-炮塔-遮盖" ) ,
				priority = "low" ,
				width = 72 ,
				height = 66 ,
				frame_count = 1 ,
				line_length = 8 ,
				direction_count = 64 ,
				scale = tankScale ,
				shift = SIUtils.by_pixel( 0 * tankSize , ( -41.5 + tankShiftY ) * tankSize ) ,
				apply_runtime_tint = true
			} ,
			{
				filename = SIGen.MakeSelfPicturePath( "超越之安如磐石战车-炮塔-影子" ) ,
				priority = "low" ,
				width = 193 ,
				height = 134 ,
				frame_count = 1 ,
				line_length = 8 ,
				direction_count = 64 ,
				scale = tankScale ,
				shift = SIUtils.by_pixel( 56.25 * tankSize , ( 0.5 + tankShiftY ) * tankSize ) ,
				draw_as_shadow = true
			}
		}
	} ,
	water_reflection =
	{
		rotate = true ,
		orientation_to_variation = false ,
		pictures =
		{
			filename = SIGen.MakeSelfPicturePath( "超越之安如磐石战车-反射" ) ,
			priority = "extra-high" ,
			width = 20 ,
			height = 24 ,
			variation_count = 1 ,
			scale = 6.0 * tankSize ,
			shift = SIUtils.by_pixel( 0 , 35 )
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
		SISound.Base( "fight/tank-door-open" , 0.5 )
	} ,
	close_sound =
	{
		SISound.Base( "fight/tank-door-close" , 0.5 )
	} ,
	sound_no_fuel =
	{
		SISound.Base( "fight/tank-no-fuel-1" , 0.4 )
	} ,
	sound_minimum_speed = 0.2 ,
	sound_scaling_ratio = 0.8 ,
	working_sound =
	{
		sound =
		{
			SISound.Base( "fight/tank-engine" , 0.25 )
		} ,
		activate_sound =
		{
			SISound.Base( "fight/tank-engine-start" , 0.25 )
		} ,
		deactivate_sound =
		{
			SISound.Base( "fight/tank-engine-stop" , 0.25 )
		} ,
		match_speed_to_activity = true
	}
}
.New( SICommon.Types.Equipments.ActiveDefense , "Tank" , "超越之安如磐石战车" ,
{
	take_result = SIConstants_Core.raw.Items.Tank ,
	categories =
	{
		SIConstants_Core.raw.Categories.Equipment.Special
	} ,
	background_color = SICommon.Colors.Equipment.Attack ,
	background_border_color = SICommon.Colors.Equipment.Border ,
	grabbed_background_color = SICommon.Colors.Equipment.AttackHover ,
	shape =
	{
		type = SICommon.Flags.EquipmentShapeType.Full ,
		width = 2 ,
		height = 2
	} ,
	energy_source =
	{
		type = SICommon.Flags.EnergySourceType.Electric ,
		emissions_per_minute = 0 ,
		render_no_power_icon = false ,
		render_no_network_icon = false ,
		usage_priority = SICommon.Flags.ElectricUsagePriority.InputSecondary ,
		buffer_capacity = "50TJ" ,
		input_flow_limit = "10TW" ,
		output_flow_limit = "10TW" ,
		drain = "0J"
	} ,
	automatic = true ,
	attack_parameters =
	{
		type = "beam" ,
		cooldown = 4 ,
		range = 50 ,
		damage_modifier = 1.5 ,
		source_direction_count = 64 ,
		source_offset = { 0 , -0.5 } ,
		ammo_type =
		{
			category = SIConstants_Core.raw.Categories.Ammo.Special ,
			energy_consumption = "60GJ" ,
			action =
			{
				{
					type = "direct" ,
					force = "enemy" ,
					action_delivery =
					{
						{
							type = "beam" ,
							beam = SIConstants_Core.raw.Entities.Laser_BeamSmall ,
							max_length = 0 ,
							duration = 4 ,
							source_offset = { 0 , -1 } ,
							add_to_shooter = true
						}
					}
				}
			}
		}
	} ,
	sprite =
	{
		filename = SIGen.MakePicturePath( SICommon.Types.Items.ItemEntity , "超越之安如磐石战车" .. SICommon.ShowNameSuffix.ICON ) ,
		priority = "medium" ,
		width = 64 ,
		height = 64 ,
		scale = 1.0
	}
} )
.MakeIcon( SICommon.Types.Items.ItemEntity , "超越之安如磐石战车" , 64 , 4 )
.ReferenceEquipmentResult( SICommon.Types.Items.ItemEntity , SIConstants_Core.raw.Items.Tank )
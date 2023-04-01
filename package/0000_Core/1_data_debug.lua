-- ------------------------------------------------------------------------------------------------
-- -------- 创建调试物品 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

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
			amount = 1 ,
			catalyst_amount = 1
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
.MakeIcon( SICommon.Types.Items.Tool , "量产之酥皮夹心糖果" , 64 , 4 )
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
				type = SICommon.Types.Items.item ,
				name = SIConstants_Core.raw.Items.Candy ,
				amount = 1
			}
		}
	} ,
	max_health = 50 ,
	corpse = "small-remnants" ,
	dying_explosion = "wall-explosion" ,
	map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	friendly_map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	enemy_map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	alert_when_damaged = true ,
	create_ghost_on_death = false ,
	hide_resistances = true ,
	pictures =
	{
		{
			layers =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Items.Tool , "量产之酥皮夹心糖果" .. SICommon.ShowNameSuffix.ICON ) ,
					priority = "medium" ,
					width = 64 ,
					height = 64 ,
					scale = 0.5
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
.New( SICommon.Types.Equipments.Battery , "Candy" , "量产之酥皮夹心糖果" ,
{
	take_result = SIConstants_Core.raw.Items.Candy ,
	categories =
	{
		SIConstants_Core.raw.Categories.Equipment.Special
	} ,
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
	fuel_value = "7.4EJ" ,
	fuel_acceleration_multiplier = 4.22 ,
	fuel_top_speed_multiplier = 1.47 ,
	fuel_emissions_multiplier = 1.18 ,
	fuel_glow_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	burnt_result = "landfill" ,
	place_result = nil ,
	placed_as_equipment_result = nil ,
	rocket_launch_products =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = "explosives" ,
			amount_min = 0 ,
			amount_max = 24 ,
			catalyst_amount = 24
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "sulfur" ,
			amount_min = 0 ,
			amount_max = 46 ,
			catalyst_amount = 46
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "battery" ,
			amount_min = 0 ,
			amount_max = 8 ,
			catalyst_amount = 8
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "empty-barrel" ,
			probability = 0.75 ,
			amount = 1 ,
			catalyst_amount = 1
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "boiler" ,
			probability = 0.15 ,
			amount = 1 ,
			catalyst_amount = 1
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
				type = SICommon.Types.Items.item ,
				name = SIConstants_Core.raw.Items.BrightBar ,
				amount = 1
			}
		}
	} ,
	max_health = 21000 ,
	corpse = "nuclear-reactor-remnants" ,
	dying_explosion = "nuke-explosion" ,
	map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	friendly_map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	enemy_map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	alert_when_damaged = true ,
	create_ghost_on_death = false ,
	hide_resistances = true ,
	resistances = nil ,
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
		smoke = nil ,
		light_flicker = nil ,
		effectivity = 2.5 ,
		fuel_categories = { SIConstants_Core.raw.Categories.Fuel.Special }
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
	} ,
	working_sound =
	{
		sound =
		{
			{
				filename = "__base__/sound/nuclear-reactor-1.ogg" ,
				volume = 0.55
			} ,
			{
				filename = "__base__/sound/nuclear-reactor-2.ogg" ,
				volume = 0.55
			}
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
	burnt_result = "solar-panel" ,
	place_result = nil ,
	placed_as_equipment_result = nil ,
	rocket_launch_products =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = "substation" ,
			amount_min = 0 ,
			amount_max = 4 ,
			catalyst_amount = 4
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "burner-mining-drill" ,
			amount_min = 0 ,
			amount_max = 2 ,
			catalyst_amount = 2
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "hazard-concrete" ,
			amount_min = 0 ,
			amount_max = 444 ,
			catalyst_amount = 444
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = "grenade" ,
			amount_min = 0 ,
			amount_max = 12 ,
			catalyst_amount = 12
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
				type = SICommon.Types.Items.item ,
				name = SIConstants_Core.raw.Items.FishModule ,
				amount = 1
			}
		}
	} ,
	max_health = 21000 ,
	corpse = "beacon-remnants" ,
	dying_explosion = "nuke-explosion" ,
	map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	friendly_map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	enemy_map_color = { r = 1.00 , g = 0.94 , b = 0.46 } ,
	alert_when_damaged = true ,
	create_ghost_on_death = false ,
	hide_resistances = true ,
	resistances = nil ,
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
		usage_priority = SICommon.Flags.ElectricUsagePriority.InputSecondary ,
		buffer_capacity = "50TJ" ,
		input_flow_limit = "10TW" ,
		output_flow_limit = "10TW" ,
		drain = "0J"
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
		module_slots = 140 , -- 插件槽界面每行 10 个 , 物品信息概要存储每行 7 个 , 取最小公约数 10 * 7 = 70 个 , 70 太少变成 2 倍 , 总数 70 * 2 = 140 个
		module_info_icon_shift = { 0.0 , 0.0 } ,
		module_info_multi_row_initial_height_modifier = -0.3 ,
		module_info_max_icons_per_row = 4
	} ,
	supply_area_distance = 64 ,
	distribution_effectivity = 10.0 ,
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
	} ,
	working_sound =
	{
		sound =
		{
			{
				filename = "__base__/sound/beacon-1.ogg" ,
				volume = 0.2
			} ,
			{
				filename = "__base__/sound/beacon-2.ogg" ,
				volume = 0.2
			}
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
	movement_bonus = 3.0 ,
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
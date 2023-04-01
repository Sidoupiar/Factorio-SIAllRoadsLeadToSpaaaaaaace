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
	fuel_category = "chemical" ,
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
	hide_resistances = true ,
	return_ingredients_on_change = false ,
	render_layer = SICommon.Flags.RenderLayer.FloorMechanics ,
	pictures =
	{
		{
			layers =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Items.Tool , "量产之酥皮夹心糖果" .. SICommon.ShowNameSuffix.ICON ) ,
					width = 64 ,
					height = 64 ,
					scale = 0.5 ,
					priority = "medium" ,
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
	fuel_category = "chemical" ,
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
	fuel_category = "chemical" ,
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
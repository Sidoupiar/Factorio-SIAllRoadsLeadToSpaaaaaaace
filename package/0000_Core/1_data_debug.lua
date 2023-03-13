-- ------------------------------------------------------------------------------------------------
-- -------- 创建调试物品 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen
.SetGroup( SIConstants_Core.raw.Groups.Hidden.Debug )
.New( SICommon.Types.Entities.Projectile , "BrightBarProjectile" , "扔出去的璀璨之闪耀能量罐头" )
.MakeIcon( SICommon.Types.Items.Capsule , "璀璨之闪耀能量罐头" )
.Append
{
	flags = { SICommon.Flags.Entity.NotOnMap } ,
	light =
	{
		intensity = 0.5 ,
		size = 4
	} ,
	animation =
	{
		filename = SIGen.MakePicturePath( SICommon.Types.Items.Capsule , "璀璨之闪耀能量罐头-图标" ) ,
		priority = "high" ,
		scale = 0.25 ,
		draw_as_glow = true ,
		frame_count = 1 ,
		line_length = 1 ,
		animation_speed = 1 ,
		width = 64 ,
		height = 64
	} ,
	acceleration = 0 ,
	action =
	{
		{
			type = "direct" ,
			action_delivery =
			{
				{
					type = "instant" ,
					target_effects =
					{
						{
							type = "script" ,
							effect_id = SIConstants_Core.TriggerID.BrightBar
						}
					}
				}
			}
		}
	}
}
.New( SICommon.Types.Items.Capsule , "BrightBar" , "璀璨之闪耀能量罐头" )
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
	fuel_glow_color = { 1 , 0.94 , 0.46 } ,
	burnt_result = "landfill" ,
	--place_result = nil ,
	placed_as_equipment_result = nil ,
	rocket_launch_products =
	{
		{
			name = "explosives" ,
			amount_min = 0 ,
			amount_max = 24 ,
			catalyst_amount = 24
		} ,
		{
			name = "sulfur" ,
			amount_min = 0 ,
			amount_max = 46 ,
			catalyst_amount = 46
		} ,
		{
			name = "battery" ,
			amount_min = 0 ,
			amount_max = 8 ,
			catalyst_amount = 8
		} ,
		{
			name = "empty-barrel" ,
			amount = 1 ,
			probability = 0.75 ,
			catalyst_amount = 1
		} ,
		{
			name = "boiler" ,
			amount = 1 ,
			probability = 0.15 ,
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
	} ,
	capsule_action =
	{
		type = "throw" ,
		uses_stack = true ,
		attack_parameters =
		{
			type = "projectile" ,
			range = 16.5 ,
			cooldown = 42 ,
			activation_type = "throw" ,
			ammo_type =
			{
				category = "capsule" ,
				target_type = "position" ,
				action =
				{
					{
						type = "direct" ,
						action_delivery =
						{
							{
								type = "projectile" ,
								projectile = SIConstants_Core.raw.Entities.BrightBarProjectile ,
								starting_speed = 0.25 ,
								target_effects =
								{
									{
										type = "play-sound" ,
										sound = SITools.SoundList_Base( "fight/throw-projectile" , 6 , 0.4 )
									}
								}
							}
						}
					}
				}
			}
		}
	}
}
.New( SICommon.Types.Equipments.GeneratorEquip , "BrightBar" , "璀璨之闪耀能量罐头" ,
{
	take_result = SIConstants_Core.raw.Items.BrightBar ,
	categories =
	{
		"armor"
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
		filename = SIGen.MakePicturePath( SICommon.Types.Items.Capsule , "璀璨之闪耀能量罐头" .. SICommon.ShowNameSuffix.ICON ) ,
		priority = "medium" ,
		width = 64 ,
		height = 64 ,
		scale = 1.0
	}
} )
.MakeIcon( SICommon.Types.Items.Capsule , "璀璨之闪耀能量罐头" , 64 , 4 )
.ReferenceEquipmentResult( SICommon.Types.Items.Capsule , SIConstants_Core.raw.Items.BrightBar )
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
	fuel_glow_color = { 1 , 0.94 , 0.46 } ,
	burnt_result = "solar-panel" ,
	--place_result = nil ,
	placed_as_equipment_result = nil ,
	rocket_launch_products =
	{
		{
			name = "substation" ,
			amount_min = 0 ,
			amount_max = 4 ,
			catalyst_amount = 4
		} ,
		{
			name = "burner-mining-drill" ,
			amount_min = 0 ,
			amount_max = 2 ,
			catalyst_amount = 2
		} ,
		{
			name = "hazard-concrete" ,
			amount_min = 0 ,
			amount_max = 444 ,
			catalyst_amount = 444
		} ,
		{
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
.New( SICommon.Types.Equipments.Movement , "FishModule" , "奇妙之双鱼螺旋插件" ,
{
	take_result = SIConstants_Core.raw.Items.FishModule ,
	categories =
	{
		"armor"
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
		buffer_capacity = "1PJ" ,
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
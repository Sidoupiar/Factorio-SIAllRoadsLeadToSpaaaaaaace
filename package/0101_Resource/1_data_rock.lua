-- ------------------------------------------------------------------------------------------------
-- ----------- 矿山石 -----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local rockDataList =
{
	{ IDSuffix = "Base" , AliasSuffix = "" } ,
	{ IDSuffix = "Hard" , AliasSuffix = "-致密" } ,
	{ IDSuffix = "Soft" , AliasSuffix = "-多孔" } ,
	{ IDSuffix = "Acti" , AliasSuffix = "-活性" } ,
	{ IDSuffix = "Cata" , AliasSuffix = "-催化" }
}

SIGen.SetGroup( SIConstants_Resource.raw.Groups.Resource.Rock )
for rockIndex , rockData in pairs( rockDataList ) do
	SIGen
	.New( SICommon.Types.Entities.Projectile , "Rock" .. rockData.IDSuffix , "扔出去的矿山石" .. rockData.AliasSuffix )
	.MakeIcon( SICommon.Types.Items.Capsule , "矿山石" .. rockData.AliasSuffix )
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
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "扔出去的矿山石" .. rockData.AliasSuffix ) ,
					priority = "high" ,
					width = 32 ,
					height = 32 ,
					frame_count = 16 ,
					line_length = 8 ,
					animation_speed = 1 ,
					scale = 0.5
				}
			}
		} ,
		acceleration = 0 ,
		action =
		{
			{
				type = "area" ,
				radius = 1.6 ,
				action_delivery =
				{
					{
						type = "instant" ,
						target_effects =
						{
							{
								type = "damage" ,
								damage =
								{
									type = "physical" ,
									amount = 3
								}
							} ,
							{
								type = "create-particle" ,
								particle_name = "stone-particle" ,
								repeat_count = 5 ,
								initial_height = 0.5 ,
								initial_vertical_speed = 0.05 ,
								initial_vertical_speed_deviation = 0.1 ,
								speed_from_center = 0.05 ,
								speed_from_center_deviation = 0.1 ,
								offset_deviation = { { -0.8984 , -0.5 } , { 0.8984 , 0.5 } }
							}
						}
					}
				}
			}
		}
	}
	.New( SICommon.Types.Items.Capsule , "Rock" .. rockData.IDSuffix , "矿山石" .. rockData.AliasSuffix ,
	{
		stack_size = 10000 ,
		default_request_amount = 100 ,
		radius_color = nil ,
		capsule_action =
		{
			type = "throw" ,
			uses_stack = true ,
			attack_parameters =
			{
				type = "projectile" ,
				range = 24.5 ,
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
									projectile = SIConstants_Resource.raw.Entities["Rock" .. rockData.IDSuffix] ,
									starting_speed = 0.25 ,
									target_effects =
									{
										{
											type = "play-sound" ,
											sound = SITools.SoundList_Base( "fight/throw-projectile" , 25 , 0.4 )
										}
									}
								}
							}
						}
					}
				}
			}
		}
	} )
	.AutoIcon()
end

local stoneDataList =
{
	{
		X = 3.5 ,
		Y = 2.7 ,
		SizeList =
		{
			{ 101 ,  90 , {  0.25     ,  0.0625   } } ,
			{ 117 ,  86 , {  0.4375   ,  0.046875 } } ,
			{ 120 ,  96 , {  0.390625 ,  0.03125  } } ,
			{ 110 ,  88 , {  0.140625 ,  0.125    } } ,
			{ 120 , 104 , {  0.3125   ,  0.0625   } } ,
			{ 122 ,  95 , {  0.1875   ,  0.046875 } } ,
			{ 125 ,  93 , {  0.390625 ,  0.0625   } } ,
			{ 137 ,  82 , {  0.34375  ,  0.03125  } } ,
			{ 138 ,  88 , {  0.265625 ,  0.03125  } } ,
			{ 121 , 108 , {  0.203125 ,  0.046875 } } ,
			{ 159 ,  91 , {  0.515625 ,  0.03125  } } ,
			{ 109 , 112 , {  0.046875 ,  0.015625 } } ,
			{ 166 , 114 , {  0.234375 ,  0.046875 } } ,
			{ 145 , 122 , {  0.203125 ,  0.03125  } } ,
			{ 175 , 113 , {  0.609375 ,  0.015625 } } ,
			{ 144 , 125 , {  0.140625 ,  0.03125  } }
		}
	} ,
	{
		X = 2.6 ,
		Y = 2.3 ,
		SizeList =
		{
			{  94 ,  64 , { -0.046875 ,  0.171875 } } ,
			{  98 ,  68 , {  0.4375   ,  0.125    } } ,
			{ 103 ,  66 , {  0.484375 ,  0.0625   } } ,
			{  72 ,  71 , {  0.21875  ,  0.046875 } } ,
			{  65 ,  54 , {  0.015625 ,  0.21875  } } ,
			{  83 ,  55 , {  0.15625  ,  0.234375 } } ,
			{  75 ,  67 , {  0.265625 ,  0.15625  } } ,
			{  78 ,  56 , {  0.09375  ,  0.171875 } } ,
			{  94 ,  60 , {  0.078125 ,  0.09375  } } ,
			{ 113 ,  64 , { -0.15625  ,  0.078125 } } ,
			{  92 ,  72 , {  0.203125 ,  0.265625 } } ,
			{  79 ,  69 , {  0.046875 ,  0.15625  } } ,
			{  94 ,  75 , {  0.21875  ,  0.21875  } } ,
			{  93 ,  80 , {  0.125    ,  0.0625   } } ,
			{  91 ,  87 , {  0.3125   , -0.09375  } } ,
			{ 106 ,  75 , {  0.34375  ,  0.125    } } ,
			{  78 ,  59 , {  0.25     ,  0.03125  } } ,
			{  71 ,  64 , {  0.3125   ,  0.046875 } } ,
			{  88 ,  57 , {  0.390625 ,  0.03125  } } ,
			{  60 ,  63 , {  0.140625 ,  0.03125  } }
		}
	} ,
	{
		X = 2.2 ,
		Y = 1.7 ,
		SizeList =
		{
			{ 105 ,  69 , {  0.296875 , -0.4      } } ,
			{  82 ,  65 , {  0.0      ,  0.046875 } } ,
			{  76 ,  69 , {  0.14375  ,  0.0      } } ,
			{ 108 ,  55 , {  0.398438 ,  0.0      } } ,
			{  77 ,  74 , {  0.328125 ,  0.0625   } } ,
			{  77 ,  66 , {  0.16875  , -0.1      } } ,
			{  96 ,  65 , {  0.3      , -0.2      } } ,
			{  68 ,  59 , {  0.0      ,  0.0      } } ,
			{  78 ,  58 , {  0.2      ,  0.0      } } ,
			{  99 ,  77 , {  0.325    , -0.1      } } ,
			{  95 ,  58 , {  0.453125 ,  0.0      } } ,
			{ 115 ,  63 , {  0.546875 , -0.015625 } } ,
			{  75 ,  63 , {  0.0625   ,  0.171875 } } ,
			{  69 ,  59 , {  0.153125 ,  0.0      } } ,
			{ 100 ,  71 , {  0.234375 , -0.203125 } } ,
			{ 104 ,  77 , {  0.359375 , -0.1      } }
		}
	}
}

for stoneIndex , stoneData in pairs( stoneDataList ) do
	local pictureList = {}
	for index = 1 , #stoneData.SizeList , 1 do
		local size = stoneData.SizeList[index]
		table.insert( pictureList ,
		{
			layers =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.SimpleOwner , "矿山磐石-" .. stoneIndex .. "-" .. index ) ,
					priority = "extra-high" ,
					width = size[1] ,
					height = size[2] ,
					scale = 1.0 ,
					shift = size[3]
				}
			}
		} )
	end
	SIGen
	.New( SICommon.Types.Entities.SimpleEntity , "Stone_" .. stoneIndex , "矿山磐石-" .. stoneIndex )
	.AutoIcon()
	.SetSize( stoneData.X , stoneData.Y )
	.Append
	{
		flags = { SICommon.Flags.Entity.PlaceableNeutral , SICommon.Flags.Entity.PlaceableOffGrid , SICommon.Flags.Entity.NotOnMap , SICommon.Flags.Entity.HideAltInfo , SICommon.Flags.Entity.Hidden } ,
		minable =
		{
			mining_time = 12.0 ,
			results =
			{
				{
					type = SICommon.Types.Items.Item ,
					name = SIConstants_Resource.raw.Items.RockBase ,
					amount = 1 ,
					catalyst_amount = 1
				} ,
				{
					type = SICommon.Types.Items.Item ,
					name = SIConstants_Resource.raw.Items.RockBase ,
					probability = 0.1 ,
					amount_min = 0 ,
					amount_max = 20 ,
					catalyst_amount = 20
				} ,
				{
					type = SICommon.Types.Items.Item ,
					name = SIConstants_Resource.raw.Items.RockBase ,
					probability = 0.02 ,
					amount_min = 0 ,
					amount_max = 50 ,
					catalyst_amount = 50
				} ,
				{
					type = SICommon.Types.Items.Item ,
					name = SIConstants_Resource.raw.Items.RockHard ,
					probability = 0.1 ,
					amount_min = 0 ,
					amount_max = 5 ,
					catalyst_amount = 5 ,
					show_details_in_recipe_tooltip = false
				} ,
				{
					type = SICommon.Types.Items.Item ,
					name = SIConstants_Resource.raw.Items.RockHard ,
					probability = 0.01 ,
					amount_min = 0 ,
					amount_max = 26 ,
					catalyst_amount = 26 ,
					show_details_in_recipe_tooltip = false
				}
			}
		} ,
		loot =
		{
			{
				name = SIConstants_Resource.raw.Items.RockBase ,
				count_min = 1 ,
				count_max = 1
			} ,
			{
				name = SIConstants_Resource.raw.Items.RockBase ,
				probability = 0.1 ,
				count_min = 0 ,
				count_max = 20
			} ,
			{
				name = SIConstants_Resource.raw.Items.RockBase ,
				probability = 0.02 ,
				count_min = 0 ,
				count_max = 50
			} ,
			{
				name = SIConstants_Resource.raw.Items.RockSoft ,
				probability = 0.1 ,
				amount_min = 0 ,
				amount_max = 4 ,
				catalyst_amount = 4
			} ,
			{
				name = SIConstants_Resource.raw.Items.RockSoft ,
				probability = 0.01 ,
				amount_min = 0 ,
				amount_max = 22 ,
				catalyst_amount = 22
			}
		} ,
		max_health = 12000 ,
		corpse = nil ,
		dying_explosion = nil ,
		map_color = { r = 0.50 , g = 0.40 , b = 0.30 } ,
		friendly_map_color = { r = 0.50 , g = 0.40 , b = 0.30 } ,
		enemy_map_color = { r = 0.50 , g = 0.40 , b = 0.30 } ,
		is_military_target = false ,
		allow_run_time_change_of_is_military_target = true ,
		alert_when_damaged = false ,
		create_ghost_on_death = false ,
		hide_resistances = true ,
		resistances =
		{
			SITools.Resistance( "physical" , 2 , 45 ) ,
			SITools.Resistance( "impact" , 2 , 92 ) ,
			SITools.Resistance( "poison" , 0 , 100 ) ,
			SITools.Resistance( "explosion" , 0 , 100 ) ,
			SITools.Resistance( "fire" , 0 , 100 ) ,
			SITools.Resistance( "laser" , 2 , 45 ) ,
			SITools.Resistance( "acid" , 0 , 100 ) ,
			SITools.Resistance( "electric" , 2 , 45 )
		} ,
		damaged_trigger_effect =
		{
			type = "create-entity" ,
			entity_name = "rock-damaged-explosion" ,
			offset_deviation = { { -0.5 , -0.5 } , { 0.5 , 0.5 } } ,
			offsets = { { 0 , 1 } } ,
			damage_type_filters = "fire"
		} ,
		dying_trigger_effect =
		{
			{
				type = "create-particle" ,
				particle_name = "huge-rock-stone-particle-small" ,
				repeat_count = 15 ,
				repeat_count_deviation = 2 ,
				probability = 1 ,
				affects_target = false ,
				show_in_tooltip = false ,
				offsets = { { 0 , 0 } } ,
				offset_deviation = { { -0.0789 , -0.1 } , { 0.0789 , 0.1 } } ,
				tile_collision_mask = nil ,
				initial_height = 0.3 ,
				initial_height_deviation = 0.5 ,
				initial_vertical_speed = 0.115 ,
				initial_vertical_speed_deviation = 0.05 ,
				speed_from_center = 0.04 ,
				speed_from_center_deviation = 0.03 ,
				frame_speed = 1 ,
				frame_speed_deviation = 0
			} ,
			{
				type = "create-particle" ,
				particle_name = "huge-rock-stone-particle-big" ,
				repeat_count = 5 ,
				repeat_count_deviation = 3 ,
				probability = 1 ,
				affects_target = false ,
				show_in_tooltip = false ,
				offsets = { { 0 , 0 } } ,
				offset_deviation = { { -0.0789 , -0.1 } , { 0.0789 , 0.1 } } ,
				tile_collision_mask = nil ,
				initial_height = 0.5 ,
				initial_height_deviation = 0.5 ,
				initial_vertical_speed = 0.086 ,
				initial_vertical_speed_deviation = 0.05 ,
				speed_from_center = 0.04 ,
				speed_from_center_deviation = 0.05 ,
				frame_speed = 1 ,
				frame_speed_deviation = 0
			} ,
			{
				type = "create-particle" ,
				particle_name = "huge-rock-stone-particle-tiny" ,
				repeat_count = 10 ,
				repeat_count_deviation = 10 ,
				probability = 1 ,
				affects_target = false ,
				show_in_tooltip = false ,
				offsets = { { 0 , 0 } } ,
				offset_deviation = { { -0.1 , -0.0789 } , { 0.1 , 0.0789 } } ,
				tile_collision_mask = nil ,
				initial_height = 0.4 ,
				initial_height_deviation = 0.5 ,
				initial_vertical_speed = 0.069 ,
				initial_vertical_speed_deviation = 0.05 ,
				speed_from_center = 0.02 ,
				speed_from_center_deviation = 0.05 ,
				frame_speed = 1 ,
				frame_speed_deviation = 0
			} ,
			{
				type = "create-particle" ,
				particle_name = "huge-rock-stone-particle-medium" ,
				repeat_count = 15 ,
				repeat_count_deviation = 10 ,
				probability = 1 ,
				affects_target = false ,
				show_in_tooltip = false ,
				offsets = { { 0 , 0 } } ,
				offset_deviation = { { -0.1 , -0.0789 } , { 0.1 , 0.0789 } } ,
				tile_collision_mask = nil ,
				initial_height = 0.4 ,
				initial_height_deviation = 0.61 ,
				initial_vertical_speed = 0.085 ,
				initial_vertical_speed_deviation = 0.05 ,
				speed_from_center = 0.05 ,
				speed_from_center_deviation = 0.05 ,
				frame_speed = 1 ,
				frame_speed_deviation = 0
			}
		} ,
		count_as_rock_for_filtered_deconstruction = false ,
		random_animation_offset = true ,
		random_variation_on_create = true ,
		render_layer = SICommon.Flags.RenderLayer.Object ,
		alert_icon_shift = { 0 , 0 } ,
		pictures = pictureList ,
		mined_sound =
		{
			SISound.Base( "deconstruct-bricks" , 1 )
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
end
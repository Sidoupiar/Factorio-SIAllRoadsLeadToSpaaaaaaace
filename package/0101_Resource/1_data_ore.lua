-- ------------------------------------------------------------------------------------------------
-- ------------ 矿物 ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local oreList =
{
	OreSky    = "蓝天岩" ,
	OreFire   = "赤云核" ,
	OreMilk   = "奶黄膏" ,
	OreIron   = "铁辉玉" ,
	OreEgg    = "蛋白壳" ,
	OreShine  = "耀晶洞" ,
	OreBabble = "泡沫硝" ,
	OreOrigin = "原质束" ,
	OreFour   = "四彩金" ,
	OreUpper  = "上界碤"
}
local miningResultList = {}

SIGen.SetGroup( SIConstants_Resource.raw.Groups.Resource.Ore )
for oreID , oreAlias in pairs( oreList ) do
	SIGen
	.New( SICommon.Types.Entities.Projectile , oreID , "扔出去的" .. oreAlias )
	.MakeIcon( SICommon.Types.Items.Capsule , oreAlias )
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
					filename = SIGen.MakeSelfPicturePath( "扔出去的" .. oreAlias ) ,
					priority = "high" ,
					scale = 0.5 ,
					draw_as_glow = true ,
					frame_count = 1 ,
					line_length = 1 ,
					animation_speed = 1 ,
					width = 64 ,
					height = 64
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
	.New( SICommon.Types.Items.Capsule , oreID , oreAlias ,
	{
		stack_size = 10000 ,
		default_request_amount = 100 ,
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
									projectile = SIConstants_Resource.raw.Entities[oreID] ,
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
	} )
	.AutoIcon()
	table.insert( miningResultList ,
	{
		type = SICommon.Types.Items.Item ,
		name = SIConstants_Resource.raw.Items[oreID] ,
		probability = 0.001 ,
		amount_min = 0 ,
		amount_max = 200 ,
		catalyst_amount = 200
	} )
end

SIGen
.New( SICommon.Types.Entities.Resource , "OreBase" , "矿山岩" )
.AutoIcon()
.SetSize( 1 , 1 )
.Append
{
	flags = { SICommon.Flags.Entity.NotOnMap } ,
	minable =
	{
		mining_time = 12.0 ,
		mining_particle = "stone-particle" ,
		results = miningResultList
	} ,
	map_color = { r = 1.00 , g = 1.00 , b = 1.00 } ,
	friendly_map_color = { r = 1.00 , g = 1.00 , b = 1.00 } ,
	enemy_map_color = { r = 1.00 , g = 1.00 , b = 1.00 } ,
	mining_visualisation_tint = { r = 0.98 , g = 0.88 , b = 0.65 } ,
	tree_removal_probability = 0.6 ,
    tree_removal_max_distance = 1024 ,
	autoplace = SIAutoPlace.Create
	{
		Name = "" ,
		BaseDensity = 4 ,
		RegularMultiplier = 1.0 ,
		StartingMultiplier = 1.1 ,
		HasStarting = false
	} ,
	stage_counts = { 100000 , 33333 , 10000 , 3333 , 1000 , 333 , 100 , 33 } ,
	stages =
	{
		sheet =
		{
			filename = SIGen.MakeSelfPicturePath( "矿山岩" ) ,
			priority = "extra-high" ,
			size = 64 ,
			frame_count = 8 ,
			variation_count = 8
		}
	} ,
	mining_sound =
	{
		{
			filename = "__core__/sound/axe-mining-ore-1.ogg" ,
			volume = 0.8
		} ,
		{
			filename = "__core__/sound/axe-mining-ore-2.ogg" ,
			volume = 0.8
		} ,
		{
			filename = "__core__/sound/axe-mining-ore-3.ogg" ,
			volume = 0.8
		} ,
		{
			filename = "__core__/sound/axe-mining-ore-4.ogg" ,
			volume = 0.8
		} ,
		{
			filename = "__core__/sound/axe-mining-ore-5.ogg" ,
			volume = 0.8
		} ,
		{
			filename = "__core__/sound/axe-mining-ore-6.ogg" ,
			volume = 0.8
		} ,
		{
			filename = "__core__/sound/axe-mining-ore-7.ogg" ,
			volume = 0.8
		} ,
		{
			filename = "__core__/sound/axe-mining-ore-8.ogg" ,
			volume = 0.8
		} ,
		{
			filename = "__core__/sound/axe-mining-ore-9.ogg" ,
			volume = 0.8
		} ,
		{
			filename = "__core__/sound/axe-mining-ore-10.ogg" ,
			volume = 0.8
		}
	} ,
	walking_sound =
	{
		{
			filename = "__base__/sound/walking/resources/ore-01.ogg" ,
			volume = 0.7
		} ,
		{
			filename = "__base__/sound/walking/resources/ore-02.ogg" ,
			volume = 0.7
		} ,
		{
			filename = "__base__/sound/walking/resources/ore-03.ogg" ,
			volume = 0.7
		} ,
		{
			filename = "__base__/sound/walking/resources/ore-04.ogg" ,
			volume = 0.7
		} ,
		{
			filename = "__base__/sound/walking/resources/ore-05.ogg" ,
			volume = 0.7
		} ,
		{
			filename = "__base__/sound/walking/resources/ore-06.ogg" ,
			volume = 0.7
		} ,
		{
			filename = "__base__/sound/walking/resources/ore-07.ogg" ,
			volume = 0.7
		} ,
		{
			filename = "__base__/sound/walking/resources/ore-08.ogg" ,
			volume = 0.7
		} ,
		{
			filename = "__base__/sound/walking/resources/ore-09.ogg" ,
			volume = 0.7
		} ,
		{
			filename = "__base__/sound/walking/resources/ore-10.ogg" ,
			volume = 0.7
		}
	}
}

TableE( SIAutoPlace.Create
{
	Name = SIConstants_Resource.raw.Entities.OreBase ,
	BaseDensity = 4 ,
	RegularMultiplier = 1.0 ,
	StartingMultiplier = 1.1 ,
	HasStarting = false
} )
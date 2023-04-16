-- ------------------------------------------------------------------------------------------------
-- ------------ 矿物 ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local miningResultList =
{
	-- 添加矿山石
	{
		type = SICommon.Types.Items.Item ,
		name = SIConstants_Resource.raw.Items.RockBase ,
		amount = 1 ,
		catalyst_amount = 1
	} ,
	{
		type = SICommon.Types.Items.Item ,
		name = SIConstants_Resource.raw.Items.RockBase ,
		probability = 0.02 ,
		amount_min = 0 ,
		amount_max = 50 ,
		catalyst_amount = 50
	}
}

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

SIGen.SetGroup( SIConstants_Resource.raw.Groups.Resource.Ore )
for oreID , oreAlias in pairs( oreList ) do
	local oreProjectile = nil
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
					width = 32 ,
					height = 32 ,
					frame_count = 8 ,
					line_length = 8 ,
					animation_speed = 1 ,
					scale = 0.4
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
									amount = 13.5
								}
							} ,
							{
								type = "create-particle" ,
								particle_name = "stone-particle" ,
								repeat_count = 6 ,
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
	.AddFunction( function( prototypeName , prototypeData )
		oreProjectile = prototypeData
	end )
	.New( SICommon.Types.Items.Capsule , oreID , oreAlias )
	.AutoIcon()
	.Append
	{
		stack_size = 10000 ,
		default_request_amount = 100 ,
		pictures =
		{
			{
				layers =
				{
					{
						filename = SIGen.MakeSelfPicturePath( oreAlias .. "-1" ) ,
						size = 64 ,
						mipmap_count = 4 ,
						scale = 0.25
					}
				}
			} ,
			{
				layers =
				{
					{
						filename = SIGen.MakeSelfPicturePath( oreAlias .. "-2" ) ,
						size = 64 ,
						mipmap_count = 4 ,
						scale = 0.25
					}
				}
			} ,
			{
				layers =
				{
					{
						filename = SIGen.MakeSelfPicturePath( oreAlias .. "-3" ) ,
						size = 64 ,
						mipmap_count = 4 ,
						scale = 0.25
					}
				}
			} ,
			{
				layers =
				{
					{
						filename = SIGen.MakeSelfPicturePath( oreAlias .. "-4" ) ,
						size = 64 ,
						mipmap_count = 4 ,
						scale = 0.25
					}
				}
			}
		} ,
		radius_color = nil ,
		capsule_action =
		{
			type = "throw" ,
			uses_stack = true ,
			attack_parameters =
			{
				type = "projectile" ,
				range = 18.2 ,
				cooldown = 65 ,
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
									starting_speed = 0.21 ,
									target_effects =
									{
										{
											type = "play-sound" ,
											sound =
											{
												SISound.Base( "fight/throw-projectile-1" , 0.4 ) ,
												SISound.Base( "fight/throw-projectile-2" , 0.4 ) ,
												SISound.Base( "fight/throw-projectile-3" , 0.4 ) ,
												SISound.Base( "fight/throw-projectile-4" , 0.4 ) ,
												SISound.Base( "fight/throw-projectile-5" , 0.4 ) ,
												SISound.Base( "fight/throw-projectile-6" , 0.4 )
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
	}
	table.insert( oreProjectile.action ,
	{
		type = "direct" ,
		action_delivery =
		{
			{
				type = "instant" ,
				target_effects =
				{
					{
						type = "insert-item" ,
						item = SIConstants_Resource.raw.Items[oreID] ,
						count = 1 ,
						repeat_count = 1 ,
						probability = 0.42 ,
						show_in_tooltip = false
					}
				}
			}
		}
	} )
	table.insert( miningResultList ,
	{
		type = SICommon.Types.Items.Item ,
		name = SIConstants_Resource.raw.Items[oreID] ,
		probability = 0.00002 ,
		amount_min = 0 ,
		amount_max = 15000 ,
		catalyst_amount = 15000 ,
		show_details_in_recipe_tooltip = false
	} )
end

SIGen
.New( SICommon.Types.Entities.Resource , "OreStone" , "矿山岩" )
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
		SISound.Core( "axe-mining-ore-1" , 0.8 ) ,
		SISound.Core( "axe-mining-ore-2" , 0.8 ) ,
		SISound.Core( "axe-mining-ore-3" , 0.8 ) ,
		SISound.Core( "axe-mining-ore-4" , 0.8 ) ,
		SISound.Core( "axe-mining-ore-5" , 0.8 ) ,
		SISound.Core( "axe-mining-ore-6" , 0.8 ) ,
		SISound.Core( "axe-mining-ore-7" , 0.8 ) ,
		SISound.Core( "axe-mining-ore-8" , 0.8 ) ,
		SISound.Core( "axe-mining-ore-9" , 0.8 ) ,
		SISound.Core( "axe-mining-ore-10" , 0.8 )
	} ,
	walking_sound =
	{
		SISound.Base( "walking/resources/ore-01" , 0.7 ) ,
		SISound.Base( "walking/resources/ore-02" , 0.7 ) ,
		SISound.Base( "walking/resources/ore-03" , 0.7 ) ,
		SISound.Base( "walking/resources/ore-04" , 0.7 ) ,
		SISound.Base( "walking/resources/ore-05" , 0.7 ) ,
		SISound.Base( "walking/resources/ore-06" , 0.7 ) ,
		SISound.Base( "walking/resources/ore-07" , 0.7 ) ,
		SISound.Base( "walking/resources/ore-08" , 0.7 ) ,
		SISound.Base( "walking/resources/ore-09" , 0.7 ) ,
		SISound.Base( "walking/resources/ore-10" , 0.7 )
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
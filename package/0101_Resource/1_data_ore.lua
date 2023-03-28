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

SIGen.SetGroup( SIConstants_Resource.raw.Groups.Resource.Ore )
for oreID , oreAlias in pairs( oreList ) do
	local projectileID = nil
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
					filename = SIGen.MakeSelfPicturePath( oreAlias ) ,
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
	.AddFunction( function( prototypeID , prototypeData )
		projectileID = prototypeID
	end )
	.New( SICommon.Types.Items.Capsule , oreID , oreAlias ,
	{
		stack_size = 6000 ,
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
									projectile = projectileID ,
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
end
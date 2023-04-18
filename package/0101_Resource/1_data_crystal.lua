-- ------------------------------------------------------------------------------------------------
-- ---------- 魔力结晶 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local crystalList =
{
	CrystalWater = { Alias = "清水石" , DamageType1 = SIConstants_Core.raw.DamageTypes.PhysicWater , DamageType2 = SIConstants_Core.raw.DamageTypes.MagicCorrosion } ,
	CrystalFire  = { Alias = "火苗石" , DamageType1 = SIConstants_Core.raw.DamageTypes.PhysicRadiation , DamageType2 = SIConstants_Core.raw.DamageTypes.MagicPower } ,
	CrystalAgent = { Alias = "悠远石" , DamageType1 = SIConstants_Core.raw.DamageTypes.PhysicCorrosion , DamageType2 = SIConstants_Core.raw.DamageTypes.MagicTwist } ,
	CrystalQuiet = { Alias = "宁寂石" , DamageType1 = SIConstants_Core.raw.DamageTypes.PhysicEnergy , DamageType2 = SIConstants_Core.raw.DamageTypes.MagicVoid }
}
local orderOffset = SITable.Size( crystalList ) * 3 + 5

local sheelProjectile = nil
local shellPartProjectile = nil

SIGen
.SetGroup( SIConstants_Resource.raw.Groups.Resource.Crystal )
.New( SICommon.Types.Entities.Projectile , "Shell" , "扔出去的矿石壳" , { OrderOffset = orderOffset } )
.MakeIcon( SICommon.Types.Items.Capsule , "Shell" )
.SetSize( 0.4 , 0.4 )
.Append
{
	flags = { SICommon.Flags.Entity.NotOnMap } ,
	light =
	{
		type = "basic" ,
		intensity = 0.5 ,
		size = 4
	} ,
	animation =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "扔出去的矿石壳" ) ,
				priority = "high" ,
				width = 32 ,
				height = 32 ,
				frame_count = 16 ,
				line_length = 8 ,
				animation_speed = 1 ,
				scale = 0.4
			}
		}
	} ,
	acceleration = 0 ,
	height = 1 ,
	piercing_damage = 0 ,
	action =
	{
		{
			type = "area" ,
			show_in_tooltip = true ,
			radius = 1.8 ,
			action_delivery =
			{
				{
					type = "instant" ,
					target_effects =
					{
						{
							type = "damage" ,
							show_in_tooltip = true ,
							lower_damage_modifier = 1.0 ,
							upper_damage_modifier = 1.0 ,
							apply_damage_to_trees = true ,
							damage =
							{
								type = "physical" ,
								amount = 8.5
							}
						} ,
						{
							type = "create-particle" ,
							particle_name = "stone-particle" ,
							repeat_count = 8 ,
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
	} ,
	final_action = nil
}
.AddFunction( function( prototypeName , prototypeData )
	sheelProjectile = prototypeData
end )
.New( SICommon.Types.Items.Capsule , "Shell" , "矿石壳" ,
{
	-- 排序偏移
	OrderOffset = orderOffset ,
	-- 属性
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
			range = 15.5 ,
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
								projectile = SIConstants_Resource.raw.Entities.Shell ,
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
} )
.AutoIcon()
.New( SICommon.Types.Entities.Projectile , "ShellPart" , "扔出去的矿石壳屑" , { OrderOffset = orderOffset } )
.MakeIcon( SICommon.Types.Items.Capsule , "ShellPart" )
.SetSize( 0.4 , 0.4 )
.Append
{
	flags = { SICommon.Flags.Entity.NotOnMap } ,
	light =
	{
		type = "basic" ,
		intensity = 0.5 ,
		size = 4
	} ,
	animation =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "扔出去的矿石壳屑" ) ,
				priority = "high" ,
				width = 32 ,
				height = 32 ,
				frame_count = 16 ,
				line_length = 8 ,
				animation_speed = 1 ,
				scale = 0.4
			}
		}
	} ,
	acceleration = 0 ,
	height = 1 ,
	piercing_damage = 0 ,
	action =
	{
		{
			type = "area" ,
			show_in_tooltip = true ,
			radius = 2.2 ,
			action_delivery =
			{
				{
					type = "instant" ,
					target_effects =
					{
						{
							type = "damage" ,
							show_in_tooltip = true ,
							lower_damage_modifier = 1.0 ,
							upper_damage_modifier = 1.0 ,
							apply_damage_to_trees = true ,
							damage =
							{
								type = "physical" ,
								amount = 3.3
							}
						} ,
						{
							type = "create-particle" ,
							particle_name = "stone-particle" ,
							repeat_count = 3 ,
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
	} ,
	final_action = nil
}
.AddFunction( function( prototypeName , prototypeData )
	shellPartProjectile = prototypeData
end )
.New( SICommon.Types.Items.Capsule , "ShellPart" , "矿石壳屑" ,
{
	-- 排序偏移
	OrderOffset = orderOffset ,
	-- 属性
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
			cooldown = 35 ,
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
								projectile = SIConstants_Resource.raw.Entities.ShellPart ,
								starting_speed = 0.25 ,
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
} )
.AutoIcon()
.New( SICommon.Types.Entities.Sticker , "CrystalSlow" , "晶石减速" )
.Append
{
	flags = { SICommon.Flags.Entity.NotOnMap } ,
	duration_in_ticks = 600 ,
	target_movement_modifier_from = 0.5 ,
	target_movement_modifier_to = 1 ,
	vehicle_speed_modifier_from = 0.5 ,
	vehicle_speed_modifier_to = 1 ,
	vehicle_friction_modifier_from = 1.8 ,
	vehicle_friction_modifier_to = 1 ,
	animation =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "晶石减速" ) ,
				priority = "high" ,
				width = 32 ,
				height = 32 ,
				frame_count = 16 ,
				line_length = 8 ,
				animation_speed = 1 ,
				scale = 1.0
			}
		}
	}
}

table.insert( sheelProjectile.action ,
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
					show_in_tooltip = false ,
					item = SIConstants_Resource.raw.Items.Shell ,
					count = 1 ,
					repeat_count = 1 ,
					probability = 0.28
				} ,
				{
					type = "insert-item" ,
					show_in_tooltip = false ,
					item = SIConstants_Resource.raw.Items.ShellPart ,
					count = 1 ,
					repeat_count = 4 ,
					probability = 0.19
				}
			}
		}
	}
} )
table.insert( shellPartProjectile.action ,
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
					show_in_tooltip = false ,
					item = SIConstants_Resource.raw.Items.ShellPart ,
					count = 1 ,
					repeat_count = 1 ,
					probability = 0.35
				}
			}
		}
	}
} )

for crystalID , crystalData in pairs( crystalList ) do
	local crystalAlias = crystalData.Alias
	local crystalProjectile = nil
	SIGen
	.New( SICommon.Types.Entities.Projectile , crystalID , "扔出去的" .. crystalAlias )
	.MakeIcon( SICommon.Types.Items.Capsule , crystalID )
	.SetSize( 0.4 , 0.4 )
	.Append
	{
		flags = { SICommon.Flags.Entity.NotOnMap } ,
		light =
		{
			type = "basic" ,
			intensity = 0.5 ,
			size = 4
		} ,
		animation =
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "扔出去的" .. crystalAlias ) ,
					priority = "high" ,
					width = 32 ,
					height = 32 ,
					frame_count = 16 ,
					line_length = 8 ,
					animation_speed = 1 ,
					scale = 0.4
				}
			}
		} ,
		acceleration = 0 ,
		height = 1 ,
		piercing_damage = 0 ,
		action =
		{
			{
				type = "area" ,
				show_in_tooltip = true ,
				radius = 1.6 ,
				action_delivery =
				{
					{
						type = "instant" ,
						target_effects =
						{
							{
								type = "damage" ,
								show_in_tooltip = true ,
								lower_damage_modifier = 1.0 ,
								upper_damage_modifier = 1.0 ,
								apply_damage_to_trees = true ,
								damage =
								{
									type = "physical" ,
									amount = 15.5
								}
							} ,
							{
								type = "create-particle" ,
								particle_name = "stone-particle" ,
								repeat_count = 8 ,
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
		} ,
		final_action = nil
	}
	.AddFunction( function( prototypeName , prototypeData )
		crystalProjectile = prototypeData
	end )
	.New( SICommon.Types.Entities.Fire , crystalID .. "Fluid" , "洒出来的" .. crystalAlias )
	.MakeIcon( SICommon.Types.Items.Capsule , crystalID )
	.SetSize( 1.5 , 1.5 )
	.Append
	{
		flags = { SICommon.Flags.Entity.PlaceableOffGrid , SICommon.Flags.Entity.NotOnMap } ,
		damage_per_tick =
		{
			type = "physical" ,
			amount = 0 ,
		} ,
		damage_multiplier_increase_per_added_fuel = 1 ,
		damage_multiplier_decrease_per_tick = 0.005 ,
		maximum_damage_multiplier = 10 ,
		add_fuel_cooldown = 1 ,
		emissions_per_second = 1.2 ,
		spawn_entity = nil ,
		light =
		{
			type = "basic" ,
			intensity = 0.5 ,
			size = 4
		} ,
		on_damage_tick_effect =
		{
			{
				type = "direct" ,
				ignore_collision_condition = true ,
				trigger_target_mask = { "ground-unit" } ,
				filter_enabled = true ,
				action_delivery =
				{
					{
						type = "instant" ,
						target_effects =
						{
							{
								type = "create-sticker" ,
								sticker = SIConstants_Resource.raw.Entities.CrystalSlow ,
								trigger_created_entity = false
							} ,
							{
								type = "damage" ,
								show_in_tooltip = true ,
								lower_damage_modifier = 1.0 ,
								upper_damage_modifier = 1.0 ,
								apply_damage_to_trees = false ,
								damage =
								{
									type = "physical" ,
									amount = 0.5
								}
							} ,
							{
								type = "damage" ,
								show_in_tooltip = false ,
								lower_damage_modifier = 1.0 ,
								upper_damage_modifier = 1.0 ,
								apply_damage_to_trees = false ,
								damage =
								{
									type = crystalData.DamageType1 ,
									amount = 4.0
								}
							} ,
							{
								type = "damage" ,
								show_in_tooltip = false ,
								lower_damage_modifier = 1.0 ,
								upper_damage_modifier = 1.0 ,
								apply_damage_to_trees = false ,
								damage =
								{
									type = crystalData.DamageType2 ,
									amount = 4.0
								}
							}
						}
					}
				}
			}
		} ,
		delay_between_initial_flames = 10 ,
		initial_flame_count = 1 ,
		initial_lifetime = 2000 ,
		lifetime_increase_by = 0 ,
		lifetime_increase_cooldown = 4 ,
		maximum_lifetime = 2000 ,
		burnt_patch_lifetime = 0 ,
		fade_in_duration = 1 ,
		fade_out_duration = 30 ,
		spread_delay = 300 ,
		spread_delay_deviation = 180 ,
		maximum_spread_count = 100 ,
		limit_overlapping_particles = true ,
		particle_alpha = 0.6 ,
		particle_alpha_blend_duration = 300 ,
		initial_render_layer = SICommon.Flags.RenderLayer.Object ,
		render_layer = SICommon.Flags.RenderLayer.LowerObjectAboveShadow ,
		secondary_render_layer = SICommon.Flags.RenderLayer.HigherObjectAbove ,
		secondary_picture_fade_out_start = 30 ,
		secondary_picture_fade_out_duration = 60 ,
		uses_alternative_behavior = true ,
		pictures =
		{
			{
				layers =
				{
					{
						filename = SIGen.MakeSelfPicturePath( "洒出来的" .. crystalAlias .. "-创建-1" ) ,
						priority = "high" ,
						width = 48 ,
						height = 48 ,
						frame_count = 16 ,
						line_length = 8 ,
						animation_speed = 1 ,
						scale = 1.0 ,
						draw_as_glow = true
					}
				}
			} ,
			{
				layers =
				{
					{
						filename = SIGen.MakeSelfPicturePath( "洒出来的" .. crystalAlias .. "-创建-2" ) ,
						priority = "high" ,
						width = 48 ,
						height = 48 ,
						frame_count = 16 ,
						line_length = 8 ,
						animation_speed = 1 ,
						scale = 1.0 ,
						draw_as_glow = true
					}
				}
			} ,
			{
				layers =
				{
					{
						filename = SIGen.MakeSelfPicturePath( "洒出来的" .. crystalAlias .. "-创建-3" ) ,
						priority = "high" ,
						width = 48 ,
						height = 48 ,
						frame_count = 16 ,
						line_length = 8 ,
						animation_speed = 1 ,
						scale = 1.0 ,
						draw_as_glow = true
					}
				}
			} ,
			{
				layers =
				{
					{
						filename = SIGen.MakeSelfPicturePath( "洒出来的" .. crystalAlias .. "-创建-4" ) ,
						priority = "high" ,
						width = 48 ,
						height = 48 ,
						frame_count = 16 ,
						line_length = 8 ,
						animation_speed = 1 ,
						scale = 1.0 ,
						draw_as_glow = true
					}
				}
			}
		} ,
		secondary_pictures =
		{
			{
				layers =
				{
					{
						filename = SIGen.MakeSelfPicturePath( "洒出来的" .. crystalAlias .. "-消失-1" ) ,
						priority = "high" ,
						width = 48 ,
						height = 48 ,
						frame_count = 16 ,
						line_length = 8 ,
						animation_speed = 1 ,
						scale = 1.0 ,
						draw_as_glow = true
					}
				}
			} ,
			{
				layers =
				{
					{
						filename = SIGen.MakeSelfPicturePath( "洒出来的" .. crystalAlias .. "-消失-2" ) ,
						priority = "high" ,
						width = 48 ,
						height = 48 ,
						frame_count = 16 ,
						line_length = 8 ,
						animation_speed = 1 ,
						scale = 1.0 ,
						draw_as_glow = true
					}
				}
			} ,
			{
				layers =
				{
					{
						filename = SIGen.MakeSelfPicturePath( "洒出来的" .. crystalAlias .. "-消失-3" ) ,
						priority = "high" ,
						width = 48 ,
						height = 48 ,
						frame_count = 16 ,
						line_length = 8 ,
						animation_speed = 1 ,
						scale = 1.0 ,
						draw_as_glow = true
					}
				}
			} ,
			{
				layers =
				{
					{
						filename = SIGen.MakeSelfPicturePath( "洒出来的" .. crystalAlias .. "-消失-4" ) ,
						priority = "high" ,
						width = 48 ,
						height = 48 ,
						frame_count = 16 ,
						line_length = 8 ,
						animation_speed = 1 ,
						scale = 1.0 ,
						draw_as_glow = true
					}
				}
			}
		}
	}
	.New( SICommon.Types.Items.Capsule , crystalID , crystalAlias )
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
						filename = SIGen.MakeSelfPicturePath( crystalAlias .. "-1" ) ,
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
						filename = SIGen.MakeSelfPicturePath( crystalAlias .. "-2" ) ,
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
						filename = SIGen.MakeSelfPicturePath( crystalAlias .. "-3" ) ,
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
						filename = SIGen.MakeSelfPicturePath( crystalAlias .. "-4" ) ,
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
				range = 17.5 ,
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
									projectile = SIConstants_Resource.raw.Entities[crystalID] ,
									starting_speed = 0.22 ,
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
	table.insert( crystalProjectile.action ,
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
						show_in_tooltip = false ,
						item = SIConstants_Resource.raw.Items.Shell ,
						count = 1 ,
						repeat_count = 1 ,
						probability = 0.28
					} ,
					{
						type = "insert-item" ,
						show_in_tooltip = false ,
						item = SIConstants_Resource.raw.Items.ShellPart ,
						count = 1 ,
						repeat_count = 4 ,
						probability = 0.19
					} ,
					{
						type = "create-entity" ,
						entity_name = SIConstants_Resource.raw.Entities[crystalID .. "Fluid"] ,
						offset_deviation = { { 0 , 0 } , { 0 , 0 } } ,
						trigger_created_entity = false ,
						check_buildability = false ,
						tile_collision_mask = nil ,
						offsets =
						{
							{ 0 , 0 }
						}
					}
				}
			}
		}
	} )
end
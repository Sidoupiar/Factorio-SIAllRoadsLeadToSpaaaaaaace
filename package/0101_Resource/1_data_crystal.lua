-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 魔力结晶 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

local crystalList =
{
	CrystalWater = { Alias = "清水石" , DamageType1 = SIConstants_Core.raw.DamageTypes.PhysicWater     , DamageType2 = SIConstants_Core.raw.DamageTypes.MagicCorrosion } ,
	CrystalFire  = { Alias = "火苗石" , DamageType1 = SIConstants_Core.raw.DamageTypes.PhysicRadiation , DamageType2 = SIConstants_Core.raw.DamageTypes.MagicPower     } ,
	CrystalAgent = { Alias = "悠远石" , DamageType1 = SIConstants_Core.raw.DamageTypes.PhysicCorrosion , DamageType2 = SIConstants_Core.raw.DamageTypes.MagicTwist     } ,
	CrystalQuiet = { Alias = "宁寂石" , DamageType1 = SIConstants_Core.raw.DamageTypes.PhysicEnergy    , DamageType2 = SIConstants_Core.raw.DamageTypes.MagicVoid      }
}
local orderOffset = SITable.Size( crystalList ) * 3 + 6

local crystalOreList =
{
	CrystalOreWater       = { Alias = "清水矿" , Item = "CrystalWater" , Color = SITools.MakeColor256( 31 , 173 , 225 ) , Autoplace = true } ,
	CrystalOreFire        = { Alias = "火苗矿" , Item = "CrystalFire" , Color = SITools.MakeColor256( 237 , 111 , 8 ) , Autoplace = true } ,
	CrystalOreAgent       = { Alias = "悠远矿" , Item = "CrystalAgent" , Color = SITools.MakeColor256( 240 , 36 , 129 ) , Autoplace = true } ,
	CrystalOreQuiet       = { Alias = "宁寂矿" , Item = "CrystalQuiet" , Color = SITools.MakeColor256( 102 , 10 , 138 ) , Autoplace = true } ,
	CrystalOreQuietActive = { Alias = "宁寂矿-活化" , Item = "CrystalQuiet" , Color = SITools.MakeColor256( 169 , 33 , 222 ) , Autoplace = false }
}
local crystalManaList =
{
	CrystalManaWater = { Alias = "清水" , Color = crystalOreList.CrystalOreWater.Color , Heat = "700J" , FuelValue = nil     } ,
	CrystalManaFire  = { Alias = "火苗" , Color = crystalOreList.CrystalOreFire.Color  , Heat = "100J" , FuelValue = "120KJ" } ,
	CrystalManaAgent = { Alias = "呼唤" , Color = crystalOreList.CrystalOreAgent.Color , Heat = "200J" , FuelValue = nil     } ,
	CrystalManaQuiet = { Alias = "安宁" , Color = crystalOreList.CrystalOreQuiet.Color , Heat = "400J" , FuelValue = "5KJ"   }
}

local sheelProjectile = {}
local shellPartProjectile = {}

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
.New( SICommon.Types.Entities.Sticker , "QuietSlow" , "宁寂减速" )
.Append
{
	flags = { SICommon.Flags.Entity.NotOnMap } ,
	duration_in_ticks = 600 ,
	target_movement_modifier_from = 0.85 ,
	target_movement_modifier_to = 1 ,
	vehicle_speed_modifier_from = 0.85 ,
	vehicle_speed_modifier_to = 1 ,
	vehicle_friction_modifier_from = 8.0 ,
	vehicle_friction_modifier_to = 1 ,
	animation =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "宁寂减速" ) ,
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
	local crystalProjectile = {}
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

for crystalOreID , crystalOreData in pairs( crystalOreList ) do
	SIGen
	.New( SICommon.Types.Entities.Resource , crystalOreID , crystalOreData.Alias )
	.AutoIcon()
	.SetSizeScale( 1 , 1 , 0.5 )
	.Append
	{
		flags = { SICommon.Flags.Entity.NotOnMap } ,
		minable =
		{
			mining_time = 18.0 ,
			mining_particle = "stone-particle" ,
			results =
			{
				{
					type = SICommon.Types.Items.Item ,
					name = SIConstants_Resource.raw.Items.Shell ,
					probability = 0.2 ,
					amount_min = 0 ,
					amount_max = 2 ,
					catalyst_amount = 2
				} ,
				{
					type = SICommon.Types.Items.Item ,
					name = SIConstants_Resource.raw.Items.ShellPart ,
					probability = 0.2 ,
					amount_min = 0 ,
					amount_max = 8 ,
					catalyst_amount = 8
				} ,
				{
					type = SICommon.Types.Items.Item ,
					name = SIConstants_Resource.raw.Items[crystalOreData.Item] ,
					probability = 0.05 ,
					amount_min = 0 ,
					amount_max = 20 ,
					catalyst_amount = 20 ,
					show_details_in_recipe_tooltip = false
				} ,
				{
					type = SICommon.Types.Items.Item ,
					name = SIConstants_Resource.raw.Items[crystalOreData.Item] ,
					probability = 0.0001 ,
					amount_min = 0 ,
					amount_max = 4000 ,
					catalyst_amount = 4000 ,
					show_details_in_recipe_tooltip = false
				}
			}
		} ,
		map_color = crystalOreData.Color ,
		friendly_map_color = crystalOreData.Color ,
		enemy_map_color = crystalOreData.Color ,
		mining_visualisation_tint = crystalOreData.Color ,
		tree_removal_probability = 0.05 ,
		tree_removal_max_distance = 0 ,
		autoplace = crystalOreData.Autoplace and SIAutoPlace.Create
		{
			Name = "" ,
			BaseDensity = 4 ,
			RegularMultiplier = 1.0 ,
			StartingMultiplier = 1.1 ,
			HasStarting = false
		} or nil ,
		stage_counts = { 100000 , 33333 , 10000 , 3333 , 1000 , 333 , 100 , 33 } ,
		stages =
		{
			sheets =
			{
				{
					filename = SIGen.MakeSelfPicturePath( crystalOreData.Alias ) ,
					priority = "extra-high" ,
					width = 64 ,
					height = 64 ,
					frame_count = 8 ,
					variation_count = 8
				}
			}
		} ,
		effect_animation_period = 5 ,
		effect_animation_period_deviation = 1 ,
		effect_darkness_multiplier = 3.6 ,
		min_effect_alpha = 0.2 ,
		max_effect_alpha = 0.3 ,
		stages_effect =
		{
			sheet =
			{
				filename = SIGen.MakeSelfPicturePath( crystalOreData.Alias .. "-光效" ) ,
				priority = "extra-high" ,
				blend_mode = "additive" ,
				flags = {" light" } ,
				width = 64 ,
				height = 64 ,
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
end

local blackProjectile = {}

SIGen
.New( SICommon.Types.Entities.Projectile , "BlackHard" , "扔出去的黑硬的物质" )
.MakeIcon( SICommon.Types.Items.Capsule , "BlackHard" )
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
				filename = SIGen.MakeSelfPicturePath( "扔出去的黑硬的物质" ) ,
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
								amount = 46
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
	blackProjectile = prototypeData
end )
.New( SICommon.Types.Items.Capsule , "BlackHard" , "黑硬的物质" )
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
					filename = SIGen.MakeSelfPicturePath( "黑硬的物质-1" ) ,
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
					filename = SIGen.MakeSelfPicturePath( "黑硬的物质-2" ) ,
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
					filename = SIGen.MakeSelfPicturePath( "黑硬的物质-3" ) ,
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
					filename = SIGen.MakeSelfPicturePath( "黑硬的物质-4" ) ,
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
			range = 27.5 ,
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
								projectile = SIConstants_Resource.raw.Entities.BlackHard ,
								starting_speed = 0.28 ,
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
.New( SICommon.Types.Entities.Resource , "BlackHard" , "黑硬的物质" )
.AutoIcon()
.SetSizeScale( 1 , 1 , 0.5 )
.Append
{
	flags = { SICommon.Flags.Entity.NotOnMap } ,
	minable =
	{
		mining_time = 478.0 ,
		mining_particle = "stone-particle" ,
		results =
		{
			{
				type = SICommon.Types.Items.Item ,
				name = SIConstants_Resource.raw.Items.BlackHard ,
				probability = 0.5 ,
				amount_min = 0 ,
				amount_max = 4 ,
				catalyst_amount = 4
			}
		}
	} ,
	map_color = { r = 0.00 , g = 0.00 , b = 0.00 } ,
	friendly_map_color = { r = 0.00 , g = 0.00 , b = 0.00 } ,
	enemy_map_color = { r = 0.00 , g = 0.00 , b = 0.00 } ,
	mining_visualisation_tint = { r = 0.00 , g = 0.00 , b = 0.00 } ,
	tree_removal_probability = 1.0 ,
	tree_removal_max_distance = 25 ,
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
		sheets =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "黑硬的物质" ) ,
				priority = "extra-high" ,
				width = 64 ,
				height = 64 ,
				frame_count = 8 ,
				variation_count = 8
			}
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

table.insert( blackProjectile.action ,
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
					item = SIConstants_Resource.raw.Items.BlackHard ,
					count = 1 ,
					repeat_count = 1 ,
					probability = 0.54
				}
			}
		}
	}
} )

SIGen
.SetGroup( SIConstants_Resource.raw.Groups.Resource.CrystalMana )
for manaID , manaData in pairs( crystalManaList ) do
	SIGen
	.New( SICommon.Types.Fluid , manaID , manaData.Alias ,
	{
		default_temperature = 15 ,
		max_temperature = 1000000000 ,
		gas_temperature = 1000000000 ,
		base_color = manaData.Color ,
		flow_color = SITools.TransColor_Light( manaData.Color , 0.25 ) ,
		heat_capacity = manaData.Heat ,
		fuel_value = manaData.FuelValue ,
		emissions_multiplier = 1.4 ,
		-- 不使用默认装桶
		auto_barrel = false
	} )
	.AutoIcon()
end
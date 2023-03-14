---@diagnostic disable: newfield-call
-- ------------------------------------------------------------------------------------------------
-- ---------- 遗迹建筑 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen
.SetGroup( SIConstants_RuinControl.raw.Groups.Hidden.RuinBuildings )

-- ----------------------------------------
-- 根据等级创建遗迹建筑
-- ----------------------------------------
local Range_GunTurret = 14
local Range_LaserTurret = 16
local Range_FlameTurret = 25
local CallForHelpRadius = 30
local UtilFunctions = {}

function UtilFunctions.ModifyActions( actions , levelValue )
	if actions then
		for actionIndex , action in pairs( actions ) do
			if action.range then
				action.range = action.range * levelValue.Range
			end
			if action.action_delivery then
				for deliveryIndex , delivery in pairs( action.action_delivery ) do
					UtilFunctions.ModifyEffects( delivery.source_effects , levelValue )
					UtilFunctions.ModifyEffects( delivery.target_effects , levelValue )
				end
			end
		end
	end
end

function UtilFunctions.ModifyEffects( effects , levelValue )
	if effects then
		for effectIndex , effect in pairs( effects ) do
			UtilFunctions.ModifyActions( effect.action , levelValue )
			if effect.damage and effect.damage.amount then
				effect.damage.amount = effect.damage.amount * levelValue.Damage
			end
		end
	end
end

local function CreateRuinBuildings( type , IDPrefix , aliasPrefix , size , levelValueList , basePrototypeData )
	IDPrefix = IDPrefix .. "_"
	aliasPrefix = aliasPrefix .. "-"
	for level , levelValue in pairs( levelValueList ) do
		SIGen
		.New( type , IDPrefix .. level , aliasPrefix .. level , basePrototypeData )
		.SetSize( size , size )
		.AddFunction( function( prototypeName , prototypeData )
			prototypeData.max_health = prototypeData.max_health * levelValue.Health
			if prototypeData.call_for_help_radius then
				prototypeData.call_for_help_radius = prototypeData.call_for_help_radius * levelValue.Range
			end
			if prototypeData.prepare_range then
				prototypeData.prepare_range = prototypeData.prepare_range * levelValue.Range
			end
			if prototypeData.attack_parameters then
				local parameters = prototypeData.attack_parameters
				if parameters.cooldown then
					parameters.cooldown = parameters.cooldown / levelValue.Speed
				end
				if parameters.range then
					parameters.range = parameters.range * levelValue.Range
				end
				if parameters.damage_modifier then
					parameters.damage_modifier = parameters.damage_modifier * levelValue.Damage
				end
			end
			if prototypeData.energy_source then
				local source = prototypeData.energy_source
				if source.buffer_capacity then
					local value = tonumber( source.buffer_capacity:sub( 1 , source.buffer_capacity:len() - 2 ) )
					source.buffer_capacity = ( value * levelValue.Damage ) .. "MJ"
				end
				if source.input_flow_limit then
					local value = tonumber( source.input_flow_limit:sub( 1 , source.input_flow_limit:len() - 2 ) )
					source.input_flow_limit = ( value * levelValue.Damage ) .. "MW"
				end
				if source.output_flow_limit then
					local value = tonumber( source.output_flow_limit:sub( 1 , source.output_flow_limit:len() - 2 ) )
					source.output_flow_limit = ( value * levelValue.Damage ) .. "MW"
				end
			end
			if prototypeData.energy_usage then
				local value = tonumber( prototypeData.energy_usage:sub( 1 , prototypeData.energy_usage:len() - 2 ) )
				prototypeData.energy_usage = ( value * levelValue.Damage ) .. "MW"
			end
			if prototypeData.crafting_speed then
				prototypeData.crafting_speed = prototypeData.crafting_speed * levelValue.Speed
			end
			UtilFunctions.ModifyActions( prototypeData.action , levelValue )
		end )
		.AddCallback( function( prototypeName , prototypeData )
			local resistances = prototypeData.resistances or {}
			prototypeData.resistances = SIUtils.table.deepcopy( resistances )
			SIGen.ForEach( SICommon.Types.DamageType , function( damagePrototypeName , damagePrototypeData )
				if damagePrototypeData then
					for index , resistance in pairs( resistances ) do
						if resistance.type == damagePrototypeName then
							return
						end
					end
					table.insert( prototypeData.resistances ,
					{
						type = damagePrototypeName ,
						decrease = levelValue.Decrease ,
						percent = levelValue.Defence
					} )
				end
			end )
		end )
	end
end

-- ----------------------------------------
-- 遗迹围墙
-- ----------------------------------------
SIGen
.New( SICommon.Types.Entities.Corpse , "RuinWallRemnants" , "遗迹围墙-残骸" )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceableNeutral , SICommon.Flags.Entity.NotOnMap , SICommon.Flags.Entity.Hidden } ,
	time_before_removed = 54000 , -- 15 分钟
	tile_width = 1 ,
	tile_height = 1 ,
	selectable_in_game = false ,
	remove_on_tile_placement = false ,
	final_render_layer = SICommon.Flags.RenderLayer.Remnants ,
	animation = SIGraphics.MakeRemnantsAnimation( 4 ,
	{
		{
			filename = SIGen.MakeSelfPicturePath( "遗迹围墙-残骸" ) ,
			priority = "extra-high" ,
			width = 60 ,
			height = 58 ,
			frame_count = 1 ,
			line_length = 1 ,
			variation_count = 1 ,
			direction_count = 2 ,
			shift = SIUtils.by_pixel( 3 , 7.5 )
		}
	} )
}
.AutoIcon()
.SetSizeScale( 1 , 1 , 0 )
CreateRuinBuildings( SICommon.Types.Entities.Wall , "RuinWall" , "遗迹围墙" , 0.85 , SIConstants_RuinControl.LevelValueList ,
{
	localised_name = SIGen.MakeLocalisedName( SICommon.Types.Entities.Wall , "遗迹围墙" ) ,
	localised_description = SIGen.MakeLocalisedDescription( SICommon.Types.Entities.Wall , "遗迹围墙" ) ,
	icons =
	{
		{
			icon = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "遗迹围墙" .. SICommon.ShowNameSuffix.ICON ) ,
			icon_size = 64 ,
			icon_mipmaps = 4
		}
	} ,
	icon_size = 64 ,
	icon_mipmaps = 4 ,
	flags = { SICommon.Flags.Entity.PlaceableEnemy , SICommon.Flags.Entity.Hidden } ,
	minable =
	{
		mining_time = 6000.0 ,
		results = {}
	} ,
	max_health = 550 ,
	corpse = SIConstants_RuinControl.raw.Entities.RuinWallRemnants ,
	dying_explosion = "wall-explosion" ,
	map_color = { r = 1.0 , g = 1.0 , b = 1.0 } ,
	friendly_map_color = { r = 0.4 , g = 0.4 , b = 1.0 } ,
	enemy_map_color = { r = 1.0 , g = 0.4 , b = 0.4 } ,
	alert_when_damaged = true ,
	create_ghost_on_death = false ,
	hide_resistances = false ,
	resistances =
	{
		{
			type = "fire" ,
			percent = 100
		}
	} ,
	damaged_trigger_effect =
	{
		type = "create-entity" ,
		entity_name = "wall-damaged-explosion" ,
		offset_deviation = { { -0.5 , -0.5 } , { 0.5 , 0.5 } } ,
		offsets = { { 0 , 1 } } ,
		damage_type_filters = "fire"
	} ,
	repair_speed_modifier = 10.0 ,
	default_output_signal =
	{
		type = "virtual" ,
		name = "signal-G"
	} ,
	circuit_wire_connection_point = circuit_connector_definitions.gate.points ,
	circuit_connector_sprites = circuit_connector_definitions.gate.sprites ,
	circuit_wire_max_distance = 9 ,
	visual_merge_group = 996 , -- 编号相同的围墙会在视觉上互相连接A
	alert_icon_shift = { 0 , 0 } ,
	pictures =
	{
		single =
		{
			layers =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "遗迹围墙-独立" ) ,
					priority = "extra-high" ,
					width = 32 ,
					height = 46 ,
					line_length = 2 ,
					variation_count = 2 ,
					shift = SIUtils.by_pixel( 0 , -6 )
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "遗迹围墙-独立-影子" ) ,
					priority = "extra-high" ,
					width = 50 ,
					height = 32 ,
					repeat_count = 2 ,
					shift = SIUtils.by_pixel( 10 , 16 ) ,
					draw_as_shadow = true
				}
			}
		} ,
		straight_horizontal =
		{
			layers =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "遗迹围墙-横向" ) ,
					priority = "extra-high" ,
					width = 32 ,
					height = 50 ,
					line_length = 6 ,
					variation_count = 6 ,
					shift = SIUtils.by_pixel( 0 , -4 )
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "遗迹围墙-横向-影子" ) ,
					priority = "extra-high" ,
					width = 62 ,
					height = 36 ,
					repeat_count = 6 ,
					shift = SIUtils.by_pixel( 14 , 14 ) ,
					draw_as_shadow = true
				}
			}
		} ,
		straight_vertical =
		{
			layers =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "遗迹围墙-纵向" ) ,
					priority = "extra-high" ,
					width = 32 ,
					height = 68 ,
					line_length = 5 ,
					variation_count = 5 ,
					shift = SIUtils.by_pixel( 0 , 8 )
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "遗迹围墙-纵向-影子" ) ,
					priority = "extra-high" ,
					width = 50 ,
					height = 58 ,
					repeat_count = 5 ,
					shift = SIUtils.by_pixel( 10 , 28 ) ,
					draw_as_shadow = true
				}
			}
		} ,
		corner_left_down =
		{
			layers =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "遗迹围墙-拐角左" ) ,
					priority = "extra-high" ,
					width = 32 ,
					height = 68 ,
					line_length = 2 ,
					variation_count = 2 ,
					shift = SIUtils.by_pixel( 0 , 6 )
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "遗迹围墙-拐角左-影子" ) ,
					priority = "extra-high" ,
					width = 54 ,
					height = 60 ,
					repeat_count = 2 ,
					shift = SIUtils.by_pixel( 8 , 28 ) ,
					draw_as_shadow = true
				}
			}
		} ,
		corner_right_down =
		{
			layers =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "遗迹围墙-拐角右" ) ,
					priority = "extra-high",
					width = 32 ,
					height = 64 ,
					line_length = 2 ,
					variation_count = 2 ,
					shift = SIUtils.by_pixel( 0 , 6 )
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "遗迹围墙-拐角右-影子" ) ,
					priority = "extra-high" ,
					width = 62 ,
					height = 60 ,
					repeat_count = 2 ,
					shift = SIUtils.by_pixel( 14 , 28 ) ,
					draw_as_shadow = true
				}
			}
		} ,
		t_up =
		{
			layers =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "遗迹围墙-中分" ) ,
					priority = "extra-high" ,
					width = 32 ,
					height = 68 ,
					line_length = 4 ,
					variation_count = 4 ,
					shift = SIUtils.by_pixel( 0 , 6 )
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "遗迹围墙-中分-影子" ) ,
					priority = "extra-high" ,
					width = 62 ,
					height = 60 ,
					repeat_count = 4 ,
					shift = SIUtils.by_pixel( 14 , 28 ) ,
					draw_as_shadow = true
				}
			}
		} ,
		ending_left =
		{
			layers =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "遗迹围墙-尽头左" ) ,
					priority = "extra-high" ,
					width = 32 ,
					height = 48 ,
					line_length = 2 ,
					variation_count = 2 ,
					shift = SIUtils.by_pixel( 0 , -4 )
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "遗迹围墙-尽头左-影子" ) ,
					priority = "extra-high" ,
					width = 54 ,
					height = 36 ,
					repeat_count = 2 ,
					shift = SIUtils.by_pixel( 8 , 14 ) ,
					draw_as_shadow = true
				}
			}
		} ,
		ending_right =
		{
			layers =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "遗迹围墙-尽头右" ) ,
					priority = "extra-high" ,
					width = 32 ,
					height = 48 ,
					line_length = 2 ,
					variation_count = 2 ,
					shift = SIUtils.by_pixel( 0 , -4 )
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "遗迹围墙-尽头右-影子" ) ,
					priority = "extra-high" ,
					width = 62 ,
					height = 36 ,
					repeat_count = 2 ,
					shift = SIUtils.by_pixel( 14 , 14 ) ,
					draw_as_shadow = true
				}
			}
		} ,
		filling =
		{
			layers =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "遗迹围墙-填充" ) ,
					priority = "extra-high" ,
					width = 24 ,
					height = 30 ,
					line_length = 8 ,
					variation_count = 8 ,
					shift = SIUtils.by_pixel( 0 , -2 )
				}
			}
		} ,
		water_connection_patch =
		{
			sheets =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "遗迹围墙-拼接" ) ,
					priority = "extra-high" ,
					width = 58 ,
					height = 64 ,
					shift = SIUtils.by_pixel( 0 , -2 )
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "遗迹围墙-拼接-影子" ) ,
					priority = "extra-high" ,
					width = 74 ,
					height = 52 ,
					shift = SIUtils.by_pixel( 8 , 14 ) ,
					draw_as_shadow = true
				}
			}
		} ,
		gate_connection_patch =
		{
			sheets =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "遗迹围墙-闸门" ) ,
					priority = "extra-high" ,
					width = 42 ,
					height = 56 ,
					shift = SIUtils.by_pixel( 0 , -8 )
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "遗迹围墙-闸门-影子" ) ,
					priority = "extra-high" ,
					width = 66 ,
					height = 40 ,
					shift = SIUtils.by_pixel( 14 , 18 ) ,
					draw_as_shadow = true
				}
			}
		}
	} ,
	connected_gate_visualization =
	{
		filename = "__core__/graphics/arrows/underground-lines.png" ,
		priority = "high" ,
		width = 64 ,
		height = 64 ,
		scale = 0.5
	} ,
	wall_diode_green =
	{
		sheet =
		{
			filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "遗迹围墙-信号灯-绿" ) ,
			priority = "extra-high" ,
			width = 38 ,
			height = 24 ,
			shift = SIUtils.by_pixel( -2 , -24 ) ,
			draw_as_glow = true
		}
	} ,
	wall_diode_green_light_top =
	{
		minimum_darkness = 0.3 ,
		color = { r = 0.00 , g = 1.00 , b = 0.00 } ,
		size = 1 ,
		intensity = 0.2 ,
		shift = SIUtils.by_pixel( 0 , -30 )
	} ,
	wall_diode_green_light_right =
	{
		minimum_darkness = 0.3 ,
		color = { r = 0.00 , g = 1.00 , b = 0.00 } ,
		size = 1 ,
		intensity = 0.2 ,
		shift = SIUtils.by_pixel( 12 , -23 )
	} ,
	wall_diode_green_light_bottom =
	{
		minimum_darkness = 0.3 ,
		color = { r = 0.00 , g = 1.00 , b = 0.00 } ,
		size = 1 ,
		intensity = 0.2 ,
		shift = SIUtils.by_pixel( 0 , -17 )
	} ,
	wall_diode_green_light_left =
	{
		minimum_darkness = 0.3 ,
		color = { r = 0.00 , g = 1.00 , b = 0.00 } ,
		size = 1 ,
		intensity = 0.2 ,
		shift = SIUtils.by_pixel( -12 , -23 )
	} ,
	wall_diode_red =
	{
		sheet =
		{
			filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "遗迹围墙-信号灯-红" ) ,
			priority = "extra-high" ,
			width = 38 ,
			height = 24 ,
			shift = SIUtils.by_pixel( -2 , -24 ) ,
			draw_as_glow = true
		}
	} ,
	wall_diode_red_light_top =
	{
		minimum_darkness = 0.3 ,
		color = { r = 1.00 , g = 0.00 , b = 0.00 } ,
		size = 1 ,
		intensity = 0.2 ,
		shift = SIUtils.by_pixel( 0 , -30 )
	} ,
	wall_diode_red_light_right =
	{
		minimum_darkness = 0.3 ,
		color = { r = 1.00 , g = 0.00 , b = 0.00 } ,
		size = 1 ,
		intensity = 0.2 ,
		shift = SIUtils.by_pixel( 12 , -23 )
	} ,
	wall_diode_red_light_bottom =
	{
		minimum_darkness = 0.3 ,
		color = { r = 1.00 , g = 0.00 , b = 0.00 } ,
		size = 1 ,
		intensity = 0.2 ,
		shift = SIUtils.by_pixel( 0 , -17 )
	} ,
	wall_diode_red_light_left =
	{
		minimum_darkness = 0.3 ,
		color = { r = 1.00 , g = 0.00 , b = 0.00 } ,
		size = 1 ,
		intensity = 0.2 ,
		shift = SIUtils.by_pixel( -12 , -23 )
	} ,
	mined_sound =
	{
		filename = "__base__/sound/deconstruct-bricks.ogg" ,
		volume = 0.8
	} ,
	vehicle_impact_sound =
	{
		{
			filename = "__base__/sound/car-stone-impact.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/car-stone-impact-2.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/car-stone-impact-3.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/car-stone-impact-4.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/car-stone-impact-5.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/car-stone-impact-6.ogg" ,
			volume = 0.5
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
} )

-- ----------------------------------------
-- 遗迹地雷
-- ----------------------------------------
SIGen
.New( SICommon.Types.Entities.Corpse , "RuinLandMineRemnants" , "遗迹地雷-残骸" )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceableNeutral , SICommon.Flags.Entity.NotOnMap , SICommon.Flags.Entity.Hidden } ,
	time_before_removed = 54000 , -- 15 分钟
	tile_width = 1 ,
	tile_height = 1 ,
	selectable_in_game = false ,
	remove_on_tile_placement = false ,
	final_render_layer = SICommon.Flags.RenderLayer.Remnants ,
	animation = SIGraphics.MakeRemnantsAnimation( 3 ,
	{
		{
			filename = SIGen.MakeSelfPicturePath( "遗迹地雷-残骸" ) ,
			priority = "extra-high" ,
			width = 68 ,
			height = 66 ,
			frame_count = 1 ,
			line_length = 1 ,
			variation_count = 1 ,
			direction_count = 1 ,
			shift = SIUtils.by_pixel( 2 , 5 ) ,
			axially_symmetrical = false
		}
	} )
}
.AutoIcon()
.SetSizeScale( 1 , 1 , 0 )
CreateRuinBuildings( SICommon.Types.Entities.LandMine , "RuinLandMine" , "遗迹地雷" , 1 , SIConstants_RuinControl.LevelValueList ,
{
	localised_name = SIGen.MakeLocalisedName( SICommon.Types.Entities.LandMine , "遗迹地雷" ) ,
	localised_description = SIGen.MakeLocalisedDescription( SICommon.Types.Entities.LandMine , "遗迹地雷" ) ,
	icons =
	{
		{
			icon = SIGen.MakePicturePath( SICommon.Types.Entities.LandMine , "遗迹地雷" .. SICommon.ShowNameSuffix.ICON ) ,
			icon_size = 64 ,
			icon_mipmaps = 4
		}
	} ,
	icon_size = 64 ,
	icon_mipmaps = 4 ,
	flags = { SICommon.Flags.Entity.PlaceableEnemy , SICommon.Flags.Entity.PlaceableOffGrid , SICommon.Flags.Entity.NotOnMap , SICommon.Flags.Entity.Hidden } ,
	minable =
	{
		mining_time = 6000.0 ,
		results = {}
	} ,
	max_health = 15 ,
	corpse = SIConstants_RuinControl.raw.Entities.RuinLandMineRemnants ,
	dying_explosion = "land-mine-explosion" ,
	map_color = { r = 1.0 , g = 1.0 , b = 1.0 } ,
	friendly_map_color = { r = 0.4 , g = 0.4 , b = 1.0 } ,
	enemy_map_color = { r = 1.0 , g = 0.4 , b = 0.4 } ,
	alert_when_damaged = true ,
	create_ghost_on_death = false ,
	hide_resistances = false ,
	resistances = nil ,
	damaged_trigger_effect =
	{
		type = "create-entity" ,
		entity_name = "spark-explosion" ,
		offset_deviation = { { -0.5 , -0.5 } , { 0.5 , 0.5 } } ,
		offsets = { { 0 , 1 } } ,
		damage_type_filters = "fire"
	} ,
	repair_speed_modifier = 1.0 ,
	trigger_radius = 1.35 ,
	ammo_category = SIConstants_RuinControl.raw.Categories.Ammo.RuinTurret ,
	action =
	{
		{
			type = "direct" ,
			action_delivery =
			{
				{
					type = "instant" ,
					source_effects =
					{
						{
							type = "nested-result" ,
							affects_target = true ,
							action =
							{
								{
									type = "area" ,
									radius = 6 ,
									force = "enemy" ,
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
														type = "explosion" ,
														amount = 100
													}
												}
											}
										}
									}
								}
							}
						} ,
						{
							type = "create-entity" ,
							entity_name = "explosion"
						} ,
						{
							type = "damage" ,
							damage =
							{
								type = "explosion" ,
								amount = 1000000
							}
						}
					}
				}
			}
		}
	} ,
	picture_safe =
	{
		filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹地雷" ) ,
		priority = "medium" ,
		width = 32 ,
		height = 32 ,
		scale = 1.0
	} ,
	picture_set =
	{
		filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹地雷-部署" ) ,
		priority = "medium" ,
		width = 32 ,
		height = 32 ,
		scale = 1.0
	} ,
	picture_set_enemy =
	{
		filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹地雷-部署敌对" ) ,
		priority = "medium" ,
		width = 32 ,
		height = 32 ,
		scale = 1.0
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
			filename = "__core__/sound/manual-repair-advanced-1.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__core__/sound/manual-repair-advanced-2.ogg" ,
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
} )

-- ----------------------------------------
-- 遗迹机枪炮塔
-- ----------------------------------------
SIGen
.New( SICommon.Types.Entities.Corpse , "RuinGunTurretRemnants" , "遗迹机枪炮塔-残骸" )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceableNeutral , SICommon.Flags.Entity.NotOnMap , SICommon.Flags.Entity.Hidden } ,
	time_before_removed = 54000 , -- 15 分钟
	tile_width = 2 ,
	tile_height = 2 ,
	selectable_in_game = false ,
	remove_on_tile_placement = false ,
	final_render_layer = SICommon.Flags.RenderLayer.Remnants ,
	animation = SIGraphics.MakeRemnantsAnimation( 3 ,
	{
		{
			filename = SIGen.MakeSelfPicturePath( "遗迹机枪炮塔-残骸" ) ,
			priority = "extra-high" ,
			width = 126 ,
			height = 122 ,
			frame_count = 1 ,
			line_length = 1 ,
			variation_count = 1 ,
			direction_count = 1 ,
			shift = SIUtils.by_pixel( 3 , -1 ) ,
			axially_symmetrical = false
		} ,
		{
			filename = SIGen.MakeSelfPicturePath( "遗迹机枪炮塔-残骸-遮盖" ) ,
			priority = "low" ,
			width = 34 ,
			height = 32 ,
			frame_count = 1 ,
			line_length = 1 ,
			variation_count = 1 ,
			direction_count = 1 ,
			shift = SIUtils.by_pixel( -1 , -11 ) ,
			apply_runtime_tint = true
		}
	} )
}
.AutoIcon()
.SetSizeScale( 2 , 2 , 0 )
CreateRuinBuildings( SICommon.Types.Entities.Turret , "RuinGunTurret" , "遗迹机枪炮塔" , 2 , SIConstants_RuinControl.LevelValueList ,
{
	localised_name = SIGen.MakeLocalisedName( SICommon.Types.Entities.Turret , "遗迹机枪炮塔" ) ,
	localised_description = SIGen.MakeLocalisedDescription( SICommon.Types.Entities.Turret , "遗迹机枪炮塔" ) ,
	icons =
	{
		{
			icon = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔" .. SICommon.ShowNameSuffix.ICON ) ,
			icon_size = 64 ,
			icon_mipmaps = 4
		}
	} ,
	icon_size = 64 ,
	icon_mipmaps = 4 ,
	flags = { SICommon.Flags.Entity.PlaceableEnemy , SICommon.Flags.Entity.Hidden } ,
	minable =
	{
		mining_time = 6000.0 ,
		results = {}
	} ,
	max_health = 190 ,
	corpse = SIConstants_RuinControl.raw.Entities.RuinGunTurretRemnants ,
	dying_explosion = "gun-turret-explosion" ,
	map_color = { r = 1.0 , g = 1.0 , b = 1.0 } ,
	friendly_map_color = { r = 0.4 , g = 0.4 , b = 1.0 } ,
	enemy_map_color = { r = 1.0 , g = 0.4 , b = 0.4 } ,
	alert_when_damaged = true ,
	create_ghost_on_death = false ,
	hide_resistances = false ,
	resistances = nil ,
	damaged_trigger_effect =
	{
		type = "create-entity" ,
		entity_name = "spark-explosion" ,
		offset_deviation = { { -0.5 , -0.5 } , { 0.5 , 0.5 } } ,
		offsets = { { 0 , 1 } } ,
		damage_type_filters = "fire"
	} ,
	repair_speed_modifier = 10.0 ,
	alert_when_attacking = true ,
	rotation_speed = 0.015 ,
	preparing_speed = 0.08 ,
	folding_speed = 0.08 ,
	attacking_speed = 0.5 ,
	call_for_help_radius = CallForHelpRadius ,
	attack_parameters =
	{
		type = "projectile" ,
		cooldown = 6 ,
		range = Range_GunTurret ,
		damage_modifier = 1 ,
		projectile_creation_distance = 1.39375 ,
		projectile_center = { 0 , -0.0875 } ,
		ammo_type =
		{
			category = SIConstants_RuinControl.raw.Categories.Ammo.RuinTurret ,
			action =
			{
				{
					type = "direct" ,
					action_delivery =
					{
						{
							type = "instant",
							source_effects =
							{
								{
									type = "create-explosion" ,
									entity_name = "explosion-gunshot"
								}
							} ,
							target_effects =
							{
								{
									type = "create-entity" ,
									entity_name = "explosion-hit" ,
									offsets = { { 0 , 1 } } ,
									offset_deviation = { { -0.5 , -0.5 } , { 0.5 , 0.5 } }
								} ,
								{
									type = "damage" ,
									damage =
									{
										type = "physical" ,
										amount = 3
									}
								}
							}
						}
					}
				}
			}
		} ,
		shell_particle =
		{
			name = "shell-particle" ,
			direction_deviation = 0.1 ,
			speed = 0.1 ,
			speed_deviation = 0.03 ,
			center = { -0.0625 , 0 } ,
			creation_distance = -1.925 ,
			starting_frame_speed = 0.2 ,
			starting_frame_speed_deviation = 0.1
		} ,
		sound =
		{
			{
				filename = "__base__/sound/fight/gun-turret-gunshot-01.ogg" ,
				volume = 0.4
			} ,
			{
				filename = "__base__/sound/fight/gun-turret-gunshot-02.ogg" ,
				volume = 0.4
			} ,
			{
				filename = "__base__/sound/fight/gun-turret-gunshot-03.ogg" ,
				volume = 0.4
			} ,
			{
				filename = "__base__/sound/fight/gun-turret-gunshot-04.ogg" ,
				volume = 0.4
			}
		}
	} ,
	base_picture =
	{
		layers =
		{
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔" ) ,
				priority = "high" ,
				width = 76 ,
				height = 60 ,
				frame_count = 1 ,
				line_length = 1 ,
				direction_count = 1 ,
				shift = SIUtils.by_pixel( 1 , -1 ) ,
				axially_symmetrical = false
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-遮盖" ) ,
				priority = "medium" ,
				flags = { "mask" , "low-object" } ,
				width = 62 ,
				height = 52 ,
				frame_count = 1 ,
				line_length = 1 ,
				direction_count = 1 ,
				shift = SIUtils.by_pixel( 0 , -4 ) ,
				axially_symmetrical = false ,
				apply_runtime_tint = true
			}
		}
	} ,
	preparing_animation =
	{
		layers =
		{
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-升起" ) ,
				priority = "medium" ,
				run_mode = "forward" ,
				width = 66 ,
				height = 64 ,
				frame_count = 5 ,
				line_length = 5 ,
				direction_count = 4 ,
				shift = SIUtils.by_pixel( 0 , -26 ) ,
				axially_symmetrical = false
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-升起-遮盖" ) ,
				priority = "medium" ,
				run_mode = "forward" ,
				flags = { "mask" } ,
				width = 24 ,
				height = 32 ,
				frame_count = 5 ,
				line_length = 5 ,
				direction_count = 4 ,
				shift = SIUtils.by_pixel( 0 , -28 ) ,
				axially_symmetrical = false ,
				apply_runtime_tint = true
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-升起-影子" ) ,
				priority = "medium" ,
				run_mode = "forward" ,
				width = 126 ,
				height = 62 ,
				frame_count = 5 ,
				line_length = 5 ,
				direction_count = 4 ,
				shift = SIUtils.by_pixel( 19 , 2 ) ,
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
				stripes =
				{
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-射击-1" ) ,
						width_in_frames = 1 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-射击-2" ) ,
						width_in_frames = 1 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-射击-3" ) ,
						width_in_frames = 1 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-射击-4" ) ,
						width_in_frames = 1 ,
						height_in_frames = 16
					}
				} ,
				priority = "medium" ,
				width = 66 ,
				height = 66 ,
				frame_count = 1 ,
				direction_count = 64 ,
				shift = SIUtils.by_pixel( 0 , -27 ) ,
				axially_symmetrical = false
			} ,
			{
				stripes =
				{
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-射击-遮盖-1" ) ,
						width_in_frames = 1 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-射击-遮盖-2" ) ,
						width_in_frames = 1 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-射击-遮盖-3" ) ,
						width_in_frames = 1 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-射击-遮盖-4" ) ,
						width_in_frames = 1 ,
						height_in_frames = 16
					}
				} ,
				priority = "medium" ,
				flags = { "mask" } ,
				width = 30 ,
				height = 28 ,
				frame_count = 1 ,
				line_length = 1 ,
				direction_count = 64 ,
				shift = SIUtils.by_pixel( 0 , -32 ) ,
				axially_symmetrical = false ,
				apply_runtime_tint = true
			} ,
			{
				stripes =
				{
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-射击-影子-1" ) ,
						width_in_frames = 1 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-射击-影子-2" ) ,
						width_in_frames = 1 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-射击-影子-3" ) ,
						width_in_frames = 1 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-射击-影子-4" ) ,
						width_in_frames = 1 ,
						height_in_frames = 16
					}
				} ,
				priority = "medium" ,
				width = 126 ,
				height = 62 ,
				frame_count = 1 ,
				direction_count = 64 ,
				shift = SIUtils.by_pixel( 23 , 2 ) ,
				draw_as_shadow = true ,
				axially_symmetrical = false
			}
		}
	} ,
	folding_animation =
	{
		layers =
		{
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-升起" ) ,
				priority = "medium" ,
				run_mode = "backward" ,
				width = 66 ,
				height = 64 ,
				frame_count = 5 ,
				line_length = 5 ,
				direction_count = 4 ,
				shift = SIUtils.by_pixel( 0 , -26 ) ,
				axially_symmetrical = false
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-升起-遮盖" ) ,
				priority = "medium" ,
				run_mode = "backward" ,
				flags = { "mask" } ,
				width = 24 ,
				height = 32 ,
				frame_count = 5 ,
				line_length = 5 ,
				direction_count = 4 ,
				shift = SIUtils.by_pixel( 0 , -28 ) ,
				axially_symmetrical = false ,
				apply_runtime_tint = true
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-升起-影子" ) ,
				priority = "medium" ,
				run_mode = "backward" ,
				width = 126 ,
				height = 62 ,
				frame_count = 5 ,
				line_length = 5 ,
				direction_count = 4 ,
				shift = SIUtils.by_pixel( 19 , 2 ) ,
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
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-升起" ) ,
				priority = "medium" ,
				run_mode = "forward" ,
				width = 66 ,
				height = 64 ,
				frame_count = 1 ,
				line_length = 1 ,
				direction_count = 4 ,
				shift = SIUtils.by_pixel( 0 , -26 ) ,
				axially_symmetrical = false
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-升起-遮盖" ) ,
				priority = "medium" ,
				run_mode = "forward" ,
				flags = { "mask" } ,
				width = 24 ,
				height = 32 ,
				frame_count = 1 ,
				line_length = 1 ,
				direction_count = 4 ,
				shift = SIUtils.by_pixel( 0 , -28 ) ,
				axially_symmetrical = false ,
				apply_runtime_tint = true
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-升起-影子" ) ,
				priority = "medium" ,
				run_mode = "forward" ,
				width = 126 ,
				height = 62 ,
				frame_count = 1 ,
				line_length = 1 ,
				direction_count = 4 ,
				shift = SIUtils.by_pixel( 19 , 2 ) ,
				draw_as_shadow = true ,
				axially_symmetrical = false
			}
		}
	} ,
	attacking_animation =
	{
		layers =
		{
			{
				stripes =
				{
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-射击-1" ) ,
						width_in_frames = 2 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-射击-2" ) ,
						width_in_frames = 2 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-射击-3" ) ,
						width_in_frames = 2 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-射击-4" ) ,
						width_in_frames = 2 ,
						height_in_frames = 16
					}
				} ,
				priority = "medium" ,
				width = 66 ,
				height = 66 ,
				frame_count = 2 ,
				direction_count = 64 ,
				shift = SIUtils.by_pixel( 0 , -27 ) ,
				axially_symmetrical = false
			} ,
			{
				stripes =
				{
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-射击-遮盖-1" ) ,
						width_in_frames = 2 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-射击-遮盖-2" ) ,
						width_in_frames = 2 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-射击-遮盖-3" ) ,
						width_in_frames = 2 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-射击-遮盖-4" ) ,
						width_in_frames = 2 ,
						height_in_frames = 16
					}
				} ,
				priority = "medium" ,
				flags = { "mask" } ,
				width = 30 ,
				height = 28 ,
				frame_count = 2 ,
				line_length = 2 ,
				direction_count = 64 ,
				shift = SIUtils.by_pixel( 0 , -32 ) ,
				axially_symmetrical = false ,
				apply_runtime_tint = true
			} ,
			{
				stripes =
				{
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-射击-影子-1" ) ,
						width_in_frames = 2 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-射击-影子-2" ) ,
						width_in_frames = 2 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-射击-影子-3" ) ,
						width_in_frames = 2 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-射击-影子-4" ) ,
						width_in_frames = 2 ,
						height_in_frames = 16
					}
				} ,
				priority = "medium" ,
				width = 126 ,
				height = 62 ,
				frame_count = 2 ,
				direction_count = 64 ,
				shift = SIUtils.by_pixel( 23 , 2 ) ,
				draw_as_shadow = true ,
				axially_symmetrical = false
			}
		}
	} ,
	water_reflection =
	{
		rotate = false ,
		orientation_to_variation = false ,
		pictures =
		{
			filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹机枪炮塔-反射" ) ,
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
			filename = "__core__/sound/manual-repair-advanced-1.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__core__/sound/manual-repair-advanced-2.ogg" ,
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
	preparing_sound =
	{
		{
			filename = "__base__/sound/fight/gun-turret-activate-01.ogg" ,
			volume = 0.3
		} ,
		{
			filename = "__base__/sound/fight/gun-turret-activate-02.ogg" ,
			volume = 0.3
		} ,
		{
			filename = "__base__/sound/fight/gun-turret-activate-03.ogg" ,
			volume = 0.3
		} ,
		{
			filename = "__base__/sound/fight/gun-turret-activate-04.ogg" ,
			volume = 0.3
		}
	} ,
	folding_sound =
	{
		{
			filename = "__base__/sound/fight/gun-turret-deactivate-01.ogg" ,
			volume = 0.3
		} ,
		{
			filename = "__base__/sound/fight/gun-turret-deactivate-02.ogg" ,
			volume = 0.3
		} ,
		{
			filename = "__base__/sound/fight/gun-turret-deactivate-03.ogg" ,
			volume = 0.3
		} ,
		{
			filename = "__base__/sound/fight/gun-turret-deactivate-04.ogg" ,
			volume = 0.3
		}
	}
} )

-- ----------------------------------------
-- 遗迹激光炮塔
-- ----------------------------------------
SIGen
.New( SICommon.Types.Entities.Corpse , "RuinLaserTurretRemnants" , "遗迹激光炮塔-残骸" )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceableNeutral , SICommon.Flags.Entity.NotOnMap , SICommon.Flags.Entity.Hidden } ,
	time_before_removed = 54000 , -- 15 分钟
	tile_width = 2 ,
	tile_height = 2 ,
	selectable_in_game = false ,
	remove_on_tile_placement = false ,
	final_render_layer = SICommon.Flags.RenderLayer.Remnants ,
	animation = SIGraphics.MakeRemnantsAnimation( 3 ,
	{
		{
			filename = SIGen.MakeSelfPicturePath( "遗迹激光炮塔-残骸" ) ,
			priority = "extra-high" ,
			width = 100 ,
			height = 98 ,
			frame_count = 1 ,
			line_length = 1 ,
			variation_count = 1 ,
			direction_count = 1 ,
			shift = SIUtils.by_pixel( 3 , -2 ) ,
			axially_symmetrical = false
		} ,
		{
			filename = SIGen.MakeSelfPicturePath( "遗迹激光炮塔-残骸-遮盖" ) ,
			priority = "low" ,
			width = 58 ,
			height = 48 ,
			frame_count = 1 ,
			line_length = 1 ,
			variation_count = 1 ,
			direction_count = 1 ,
			shift = SIUtils.by_pixel( 4 , -2 ) ,
			apply_runtime_tint = true
		}
	} )
}
.AutoIcon()
.SetSizeScale( 2 , 2 , 0 )
.New( SICommon.Types.Entities.Beam , "RuinLaserTurret_Beam" , "遗迹激光炮塔-激光" )
.Append
{
	flags = { SICommon.Flags.Entity.NotOnMap , SICommon.Flags.Entity.Hidden } ,
	width = 2.5 ,
	damage_interval = 15 ,
	random_target_offset = true ,
	action_triggered_automatically = false ,
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
							type = "damage" ,
							damage =
							{
								type = "laser" ,
								amount = 7
							}
						}
					}
				}
			}
		}
	} ,
	body =
	{
		filename = SIGen.MakePicturePath( SICommon.Types.Entities.Beam , "遗迹激光炮塔-激光-身体" ) ,
		priority = "medium" ,
		blend_mode = "additive" ,
		flags = { "trilinear-filtering" } ,
		width = 64 ,
		height = 12 ,
		frame_count = 8 ,
		line_length = 8 ,
		animation_speed = 0.5 ,
		scale = 0.5
	} ,
	head =
	{
		filename = SIGen.MakePicturePath( SICommon.Types.Entities.Beam , "遗迹激光炮塔-激光-身体" ) ,
		priority = "medium" ,
		blend_mode = "additive" ,
		flags = { "trilinear-filtering" } ,
		width = 64 ,
		height = 12 ,
		frame_count = 8 ,
		line_length = 8 ,
		animation_speed = 0.5 ,
		scale = 0.5
	} ,
	tail =
	{
		filename = SIGen.MakePicturePath( SICommon.Types.Entities.Beam , "遗迹激光炮塔-激光-尾部" ) ,
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
	} ,
	light_animations =
	{
		body =
		{
			filename = SIGen.MakePicturePath( SICommon.Types.Entities.Beam , "遗迹激光炮塔-激光-身体-光效" ) ,
			priority = "medium" ,
			width = 64 ,
			height = 12 ,
			frame_count = 8 ,
			line_length = 8 ,
			animation_speed = 0.5 ,
			scale = 0.5
		} ,
		head =
		{
			filename = SIGen.MakePicturePath( SICommon.Types.Entities.Beam , "遗迹激光炮塔-激光-身体-光效" ) ,
			priority = "medium" ,
			width = 64 ,
			height = 12 ,
			frame_count = 8 ,
			line_length = 8 ,
			animation_speed = 0.5 ,
			scale = 0.5
		} ,
		tail =
		{
			filename = SIGen.MakePicturePath( SICommon.Types.Entities.Beam , "遗迹激光炮塔-激光-尾部-光效" ) ,
			priority = "medium" ,
			width = 110 ,
			height = 62 ,
			frame_count = 8 ,
			line_length = 8 ,
			animation_speed = 0.5 ,
			scale = 0.5 ,
			shift = SIUtils.by_pixel( 11.5 , 1 )
		}
	} ,
	ground_light_animations =
	{
		body =
		{
			filename = SIGen.MakePicturePath( SICommon.Types.Entities.Beam , "遗迹激光炮塔-激光-地面-身体" ) ,
			priority = "medium" ,
			width = 64 ,
			height = 256 ,
			frame_count = 1 ,
			line_length = 1 ,
			repeat_count = 8 ,
			animation_speed = 0.5 ,
			scale = 0.5 ,
			tint = { r = 0.50 , g = 0.05 , b = 0.05 }
		} ,
		head =
		{
			filename = SIGen.MakePicturePath( SICommon.Types.Entities.Beam , "遗迹激光炮塔-激光-地面-头部" ) ,
			priority = "medium" ,
			width = 256 ,
			height = 256 ,
			frame_count = 1 ,
			line_length = 1 ,
			repeat_count = 8 ,
			animation_speed = 0.5 ,
			scale = 0.5 ,
			tint = { r = 0.50 , g = 0.05 , b = 0.05 } ,
			shift = SIUtils.by_pixel( -32 , 0 )
		} ,
		tail =
		{
			filename = SIGen.MakePicturePath( SICommon.Types.Entities.Beam , "遗迹激光炮塔-激光-地面-尾部" ) ,
			priority = "medium" ,
			width = 256 ,
			height = 256 ,
			frame_count = 1 ,
			line_length = 1 ,
			repeat_count = 8 ,
			animation_speed = 0.5 ,
			scale = 0.5 ,
			tint = { r = 0.50 , g = 0.05 , b = 0.05 } ,
			shift = SIUtils.by_pixel( 32 , 0 )
		}
	} ,
	working_sound =
	{
		sound =
		{
			filename = "__base__/sound/fight/laser-beam.ogg" ,
			volume = 0.75
		} ,
		max_sounds_per_type = 1
	}
}
CreateRuinBuildings( SICommon.Types.Entities.Turret , "RuinLaserTurret" , "遗迹激光炮塔" , 2 , SIConstants_RuinControl.LevelValueList ,
{
	localised_name = SIGen.MakeLocalisedName( SICommon.Types.Entities.Turret , "遗迹激光炮塔" ) ,
	localised_description = SIGen.MakeLocalisedDescription( SICommon.Types.Entities.Turret , "遗迹激光炮塔" ) ,
	icons =
	{
		{
			icon = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹激光炮塔" .. SICommon.ShowNameSuffix.ICON ) ,
			icon_size = 64 ,
			icon_mipmaps = 4
		}
	} ,
	icon_size = 64 ,
	icon_mipmaps = 4 ,
	flags = { SICommon.Flags.Entity.PlaceableEnemy , SICommon.Flags.Entity.Hidden } ,
	minable =
	{
		mining_time = 6000.0 ,
		results = {}
	} ,
	max_health = 250 ,
	corpse = SIConstants_RuinControl.raw.Entities.RuinLaserTurretRemnants ,
	dying_explosion = "laser-turret-explosion" ,
	map_color = { r = 1.0 , g = 1.0 , b = 1.0 } ,
	friendly_map_color = { r = 0.4 , g = 0.4 , b = 1.0 } ,
	enemy_map_color = { r = 1.0 , g = 0.4 , b = 0.4 } ,
	alert_when_damaged = true ,
	create_ghost_on_death = false ,
	hide_resistances = false ,
	resistances = nil ,
	damaged_trigger_effect =
	{
		type = "create-entity" ,
		entity_name = "spark-explosion" ,
		offset_deviation = { { -0.5 , -0.5 } , { 0.5 , 0.5 } } ,
		offsets = { { 0 , 1 } } ,
		damage_type_filters = "fire"
	} ,
	repair_speed_modifier = 10.0 ,
	alert_when_attacking = true ,
	rotation_speed = 0.01 ,
	preparing_speed = 0.05 ,
	folding_speed = 0.05 ,
	attacking_speed = 1.0 ,
	call_for_help_radius = CallForHelpRadius ,
	attack_parameters =
	{
		type = "beam" ,
		cooldown = 15 ,
		range = Range_LaserTurret ,
		damage_modifier = 1 ,
		source_direction_count = 64 ,
		source_offset = { 0 , -0.85587225 } ,
		ammo_type =
		{
			category = SIConstants_RuinControl.raw.Categories.Ammo.RuinTurret ,
			action =
			{
				{
					type = "direct" ,
					action_delivery =
					{
						{
							type = "beam" ,
							beam = SIConstants_RuinControl.raw.Entities.RuinLaserTurret_Beam ,
							max_length = 0 ,
							duration = 15 ,
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
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹激光炮塔" ) ,
				priority = "high" ,
				width = 70 ,
				height = 52 ,
				frame_count = 1 ,
				line_length = 1 ,
				direction_count = 1 ,
				shift = SIUtils.by_pixel( 0 , 2 )
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹激光炮塔-影子" ) ,
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
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹激光炮塔-升起" ) ,
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
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹激光炮塔-升起-遮盖" ) ,
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
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹激光炮塔-升起-影子" ) ,
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
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹激光炮塔-射击" ) ,
				priority = "medium" ,
				width = 64 ,
				height = 60 ,
				frame_count = 1 ,
				line_length = 8 ,
				direction_count = 64 ,
				shift = SIUtils.by_pixel( 0 , -35 )
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹激光炮塔-射击-遮盖" ) ,
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
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹激光炮塔-射击-影子" ) ,
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
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹激光炮塔-升起" ) ,
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
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹激光炮塔-升起-遮盖" ) ,
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
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹激光炮塔-升起-影子" ) ,
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
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹激光炮塔-升起" ) ,
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
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹激光炮塔-升起-遮盖" ) ,
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
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹激光炮塔-升起-影子" ) ,
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
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹激光炮塔-射击-光效" ) ,
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
			filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹激光炮塔-反射" ) ,
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
			filename = "__core__/sound/manual-repair-advanced-1.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__core__/sound/manual-repair-advanced-2.ogg" ,
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
	preparing_sound =
	{
		{
			filename = "__base__/sound/fight/laser-turret-activate-01.ogg" ,
			volume = 0.3
		} ,
		{
			filename = "__base__/sound/fight/laser-turret-activate-02.ogg" ,
			volume = 0.3
		} ,
		{
			filename = "__base__/sound/fight/laser-turret-activate-03.ogg" ,
			volume = 0.3
		}
	} ,
	folding_sound =
	{
		{
			filename = "__base__/sound/fight/laser-turret-deactivate-01.ogg" ,
			volume = 0.3
		} ,
		{
			filename = "__base__/sound/fight/laser-turret-deactivate-02.ogg" ,
			volume = 0.3
		} ,
		{
			filename = "__base__/sound/fight/laser-turret-deactivate-03.ogg" ,
			volume = 0.3
		} ,
		{
			filename = "__base__/sound/fight/laser-turret-deactivate-04.ogg" ,
			volume = 0.3
		}
	}
} )

-- ----------------------------------------
-- 遗迹喷火炮塔
-- ----------------------------------------
SIGen
.New( SICommon.Types.Entities.Corpse , "RuinFlameTurretRemnants" , "遗迹喷火炮塔-残骸" )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceableNeutral , SICommon.Flags.Entity.NotOnMap , SICommon.Flags.Entity.Hidden } ,
	time_before_removed = 54000 , -- 15 分钟
	tile_width = 2 ,
	tile_height = 2 ,
	selectable_in_game = false ,
	remove_on_tile_placement = false ,
	final_render_layer = SICommon.Flags.RenderLayer.Remnants ,
	animation =
	{
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "遗迹喷火炮塔-残骸" ) ,
					priority = "extra-high" ,
					width = 152 ,
					height = 164 ,
					frame_count = 1 ,
					line_length = 1 ,
					variation_count = 1 ,
					direction_count = 4 ,
					shift = SIUtils.by_pixel( -1 , -4 ) ,
					axially_symmetrical = false
				} ,
				{
					filename = SIGen.MakeSelfPicturePath( "遗迹喷火炮塔-残骸-遮盖" ) ,
					priority = "low" ,
					width = 82 ,
					height = 82 ,
					frame_count = 1 ,
					line_length = 1 ,
					variation_count = 1 ,
					direction_count = 4 ,
					shift = SIUtils.by_pixel( 0 , -4 ) ,
					apply_runtime_tint = true
				}
			}
		}
	}
}
.AutoIcon()
.SetSizeScale( 2 , 2 , 0 )
local function RuinFlameTurretGunAnimationSingle( shift , attacking )
	local layers =
	{
		{
			filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹喷火炮塔-枪" ) ,
			priority = "medium" ,
			width = 82 ,
			height = 66 ,
			frame_count = 1 ,
			line_length = 8 ,
			direction_count = 64 ,
			shift = SIUtils.by_pixel( -2 , -26 ) ,
			axially_symmetrical = false ,
			counterclockwise = true
		}
	}
	if attacking then
		table.insert( layers ,
		{
			filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹喷火炮塔-枪-激活" ) ,
			priority = "medium" ,
			blend_mode = "additive" ,
			width = 82 ,
			height = 66 ,
			frame_count = 1 ,
			line_length = 8 ,
			direction_count = 64 ,
			tint = SIUtils.premul_color{ 1 , 1 , 1 , 0.5 } ,
			shift = SIUtils.by_pixel( -2 , -26 ) ,
			axially_symmetrical = false ,
			counterclockwise = true
		} )
		table.insert( layers ,
		{
			filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹喷火炮塔-枪-激活" ) ,
			priority = "medium" ,
			blend_mode = "additive" ,
			width = 82 ,
			height = 66 ,
			frame_count = 1 ,
			line_length = 8 ,
			direction_count = 64 ,
			tint = SIUtils.premul_color{ 1 , 1 , 1 , 0.5 } ,
			shift = SIUtils.by_pixel( -2 , -26 ) ,
			draw_as_light = true ,
			axially_symmetrical = false ,
			counterclockwise = true
		} )
	end
	table.insert( layers ,
	{
		filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹喷火炮塔-枪-遮盖" ) ,
		priority = "medium" ,
		flags = { "mask" } ,
		width = 74 ,
		height = 56 ,
		frame_count = 1 ,
		line_length = 8 ,
		direction_count = 64 ,
		shift = SIUtils.by_pixel( -2 , -28 ) ,
		axially_symmetrical = false ,
		apply_runtime_tint = true ,
		counterclockwise = true
	} )
	table.insert( layers ,
	{
		filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹喷火炮塔-枪-影子" ) ,
		priority = "medium" ,
		width = 90 ,
		height = 56 ,
		frame_count = 1 ,
		line_length = 8 ,
		direction_count = 64 ,
		shift = SIUtils.by_pixel( 32 , 0 ) ,
		draw_as_shadow = true ,
		axially_symmetrical = false ,
		counterclockwise = true
	} )
	for layerIndex , layer in pairs( layers ) do
		if layer.shift then
			layer.shift = { layer.shift[1] + shift[1] , layer.shift[2] + shift[2] }
		end
	end
	return { layers = layers }
end
local function RuinFlameTurretGunAnimation( attacking )
	return
	{
		north = RuinFlameTurretGunAnimationSingle( SIUtils.by_pixel( 0 , -6 ) , attacking ) ,
		east = RuinFlameTurretGunAnimationSingle( SIUtils.by_pixel( 18.5 , 9.5 ) , attacking ) ,
		south = RuinFlameTurretGunAnimationSingle( SIUtils.by_pixel( 0 , 19 ) , attacking ) ,
		west = RuinFlameTurretGunAnimationSingle( SIUtils.by_pixel( -12 , 5.5 ) , attacking )
	}
end
local function RuinFlameTurretExtensionAnimationSingle( runMode , frameCount , lineLength , yCount , shift )
	local layers =
	{
		{
			filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹喷火炮塔-枪-扩展" ) ,
			priority = "medium" ,
			run_mode = runMode or "forward" ,
			width = 80 ,
			height = 64 ,
			frame_count = frameCount or 15 ,
			line_length = lineLength or 5 ,
			direction_count = 1 ,
			y = 192 * yCount ,
			shift = SIUtils.by_pixel( -2 , -26 ) ,
			axially_symmetrical = false
		} ,
		{
			filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹喷火炮塔-枪-扩展-遮盖" ) ,
			priority = "medium" ,
			run_mode = runMode or "forward" ,
			flags = { "mask" } ,
			width = 76 ,
			height = 60 ,
			frame_count = frameCount or 15 ,
			line_length = lineLength or 5 ,
			direction_count = 1 ,
			y = 180 * yCount ,
			shift = SIUtils.by_pixel( -2 , -26 ) ,
			axially_symmetrical = false ,
			apply_runtime_tint = true
		} ,
		{
			filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹喷火炮塔-枪-扩展-影子" ) ,
			priority = "medium" ,
			run_mode = runMode or "forward" ,
			width = 92 ,
			height = 60 ,
			frame_count = frameCount or 15 ,
			line_length = lineLength or 5 ,
			direction_count = 1 ,
			y = 180 * yCount ,
			shift = SIUtils.by_pixel( 32 , -2 ) ,
			draw_as_shadow = true ,
			axially_symmetrical = false
		}
	}
	for layerIndex , layer in pairs( layers ) do
		if layer.shift then
			layer.shift = { layer.shift[1] + shift[1] , layer.shift[2] + shift[2] }
		end
	end
	return { layers = layers }
end
local function RuinFlameTurretExtensionAnimation( runMode , frameCount , lineLength )
	return
	{
		north = RuinFlameTurretExtensionAnimationSingle( runMode , frameCount , lineLength , 0 , SIUtils.by_pixel( 0 , -6 ) ) ,
		east = RuinFlameTurretExtensionAnimationSingle( runMode , frameCount , lineLength , 3 , SIUtils.by_pixel( 18.5 , 9.5 ) ) ,
		south = RuinFlameTurretExtensionAnimationSingle( runMode , frameCount , lineLength , 2 , SIUtils.by_pixel( 0 , 19 ) ) ,
		west = RuinFlameTurretExtensionAnimationSingle( runMode , frameCount , lineLength , 1 , SIUtils.by_pixel( -12 , 5.5 ) )
	}
end
CreateRuinBuildings( SICommon.Types.Entities.Turret , "RuinFlameTurret" , "遗迹喷火炮塔" , 2 , SIConstants_RuinControl.LevelValueList ,
{
	localised_name = SIGen.MakeLocalisedName( SICommon.Types.Entities.Turret , "遗迹喷火炮塔" ) ,
	localised_description = SIGen.MakeLocalisedDescription( SICommon.Types.Entities.Turret , "遗迹喷火炮塔" ) ,
	icons =
	{
		{
			icon = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹喷火炮塔" .. SICommon.ShowNameSuffix.ICON ) ,
			icon_size = 64 ,
			icon_mipmaps = 4
		}
	} ,
	icon_size = 64 ,
	icon_mipmaps = 4 ,
	flags = { SICommon.Flags.Entity.PlaceableEnemy , SICommon.Flags.Entity.Hidden } ,
	minable =
	{
		mining_time = 6000.0 ,
		results = {}
	} ,
	max_health = 410 ,
	corpse = SIConstants_RuinControl.raw.Entities.RuinFlameTurretRemnants ,
	dying_explosion = "medium-explosion" ,
	map_color = { r = 1.0 , g = 1.0 , b = 1.0 } ,
	friendly_map_color = { r = 0.4 , g = 0.4 , b = 1.0 } ,
	enemy_map_color = { r = 1.0 , g = 0.4 , b = 0.4 } ,
	alert_when_damaged = true ,
	create_ghost_on_death = false ,
	hide_resistances = false ,
	resistances =
	{
		{
			type = "fire" ,
			percent = 100
		}
	} ,
	damaged_trigger_effect =
	{
		type = "create-entity" ,
		entity_name = "spark-explosion" ,
		offset_deviation = { { -0.5 , -0.5 } , { 0.5 , 0.5 } } ,
		offsets = { { 0 , 1 } } ,
		damage_type_filters = "fire"
	} ,
	repair_speed_modifier = 10.0 ,
	alert_when_attacking = true ,
	turret_base_has_direction = true ,
	rotation_speed = 0.015 ,
	preparing_speed = 0.08 ,
	folding_speed = 0.08 ,
	attacking_speed = 1 ,
	ending_attack_speed = 0.2 ,
	call_for_help_radius = CallForHelpRadius ,
	shoot_in_prepare_state = false ,
	prepare_range = Range_FlameTurret + 5 ,
	attack_parameters =
	{
		type = "stream" ,
		cooldown = 4 ,
		range = Range_FlameTurret ,
		min_range = 2 ,
		damage_modifier = 1.2 ,
		turn_range = 0.3333 ,
		fire_penalty = 15 ,
		fluid_consumption = 0.2 ,
		ammo_type =
		{
			category = SIConstants_RuinControl.raw.Categories.Ammo.RuinTurret ,
			action =
			{
				{
					type = "direct" ,
					action_delivery =
					{
						{
							type = "stream" ,
							stream = "flamethrower-fire-stream" ,
							source_offset = { 0.15 , -0.5 }
						}
					}
				}
			}
		} ,
		gun_barrel_length = 0.4 ,
		gun_center_shift =
		{
			north = { 0 , -1.50625 } ,
			east = { 0.578125 , -1.021875 } ,
			south = { 0 , -0.725 } ,
			west = { -0.375 , -1.146875 }
		} ,
		cyclic_sound =
		{
			begin_sound =
			{
				{
					filename = "__base__/sound/fight/flamethrower-turret-start-01.ogg" ,
					volume = 0.5
				} ,
				{
					filename = "__base__/sound/fight/flamethrower-turret-start-02.ogg" ,
					volume = 0.5
				} ,
				{
					filename = "__base__/sound/fight/flamethrower-turret-start-03.ogg" ,
					volume = 0.5
				}
			} ,
			middle_sound =
			{
				{
					filename = "__base__/sound/fight/flamethrower-turret-mid-01.ogg" ,
					volume = 0.5
				} ,
				{
					filename = "__base__/sound/fight/flamethrower-turret-mid-02.ogg" ,
					volume = 0.5
				} ,
				{
					filename = "__base__/sound/fight/flamethrower-turret-mid-03.ogg" ,
					volume = 0.5
				}
			} ,
			end_sound =
			{
				{
					filename = "__base__/sound/fight/flamethrower-turret-end-01.ogg" ,
					volume = 0.5
				} ,
				{
					filename = "__base__/sound/fight/flamethrower-turret-end-02.ogg" ,
					volume = 0.5
				} ,
				{
					filename = "__base__/sound/fight/flamethrower-turret-end-03.ogg" ,
					volume = 0.5
				}
			}
		}
	} ,
	base_picture_render_layer = SICommon.Flags.RenderLayer.LowerObjectAboveShadow ,
	base_picture_secondary_draw_order = 1 ,
	gun_animation_render_layer = SICommon.Flags.RenderLayer.Object ,
	gun_animation_secondary_draw_order = 1 ,
	base_picture =
	{
		north =
		{
			layers =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹喷火炮塔-上" ) ,
					priority = "medium" ,
					width = 80 ,
					height = 96 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 1 ,
					shift = SIUtils.by_pixel( -2 , 14 ) ,
					axially_symmetrical = false
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹喷火炮塔-上-遮盖" ) ,
					priority = "medium" ,
					flags = { "mask" } ,
					width = 36 ,
					height = 38 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 1 ,
					shift = SIUtils.by_pixel( 0 , 32 ) ,
					axially_symmetrical = false ,
					apply_runtime_tint = true
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹喷火炮塔-上-影子" ) ,
					priority = "medium" ,
					width = 70 ,
					height = 78 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 1 ,
					shift = SIUtils.by_pixel( 2 , 14 ) ,
					draw_as_shadow = true ,
					axially_symmetrical = false
				}
			}
		} ,
		east =
		{
			layers =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹喷火炮塔-右" ) ,
					priority = "medium" ,
					width = 106 ,
					height = 72 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 1 ,
					shift = SIUtils.by_pixel( -6 , 2 ) ,
					axially_symmetrical = false
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹喷火炮塔-右-遮盖" ) ,
					priority = "medium" ,
					flags = { "mask" } ,
					width = 32 ,
					height = 42 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 1 ,
					shift = SIUtils.by_pixel( -32 , 0 ) ,
					axially_symmetrical = false ,
					apply_runtime_tint = true
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹喷火炮塔-右-影子" ) ,
					priority = "medium" ,
					width = 72 ,
					height = 46 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 1 ,
					shift = SIUtils.by_pixel( 14 , 8 ) ,
					draw_as_shadow = true ,
					axially_symmetrical = false
				}
			}
		} ,
		south =
		{
			layers =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹喷火炮塔-下" ) ,
					priority = "medium" ,
					width = 64 ,
					height = 84 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 1 ,
					shift = SIUtils.by_pixel( 0 , -8 ) ,
					axially_symmetrical = false
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹喷火炮塔-下-遮盖" ) ,
					priority = "medium" ,
					flags = { "mask" } ,
					width = 36 ,
					height = 38 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 1 ,
					shift = SIUtils.by_pixel( 0 , -32 ) ,
					axially_symmetrical = false ,
					apply_runtime_tint = true
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹喷火炮塔-下-影子" ) ,
					priority = "medium" ,
					width = 70 ,
					height = 52 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 1 ,
					shift = SIUtils.by_pixel( 2 , 8 ) ,
					draw_as_shadow = true ,
					axially_symmetrical = false
				}
			}
		} ,
		west =
		{
			layers =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹喷火炮塔-左" ) ,
					priority = "medium" ,
					width = 100 ,
					height = 74 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 1 ,
					shift = SIUtils.by_pixel( 8 , -2 ) ,
					axially_symmetrical = false
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹喷火炮塔-左-遮盖" ) ,
					priority = "medium" ,
					flags = { "mask" } ,
					width = 32 ,
					height = 40 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 1 ,
					shift = SIUtils.by_pixel( 32 , -2 ) ,
					axially_symmetrical = false ,
					apply_runtime_tint = true
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "遗迹喷火炮塔-左-影子" ) ,
					priority = "medium" ,
					width = 104 ,
					height = 44 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 1 ,
					shift = SIUtils.by_pixel( 14 , 4 ) ,
					draw_as_shadow = true ,
					axially_symmetrical = false
				}
			}
		}
	} ,
	preparing_animation = RuinFlameTurretExtensionAnimation( "forward" , 15 , 5 ) ,
	prepared_animation = RuinFlameTurretGunAnimation( false ) ,
	folding_animation = RuinFlameTurretExtensionAnimation( "backward" , 15 , 5 ) ,
	folded_animation = RuinFlameTurretExtensionAnimation( "forward" , 1 , 1 ) ,
	attacking_animation = RuinFlameTurretGunAnimation( true ) ,
	ending_attack_animation = RuinFlameTurretGunAnimation( true ) ,
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
			filename = "__core__/sound/manual-repair-advanced-1.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__core__/sound/manual-repair-advanced-2.ogg" ,
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
	preparing_sound =
	{
		{
			filename = "__base__/sound/fight/flamethrower-turret-activate-01.ogg" ,
			volume = 0.3
		} ,
		{
			filename = "__base__/sound/fight/flamethrower-turret-activate-02.ogg" ,
			volume = 0.3
		} ,
		{
			filename = "__base__/sound/fight/flamethrower-turret-activate-03.ogg" ,
			volume = 0.3
		} ,
		{
			filename = "__base__/sound/fight/flamethrower-turret-activate-04.ogg" ,
			volume = 0.3
		}
	} ,
	folding_sound =
	{
		{
			filename = "__base__/sound/fight/flamethrower-turret-deactivate-01.ogg" ,
			volume = 0.2
		} ,
		{
			filename = "__base__/sound/fight/flamethrower-turret-deactivate-02.ogg" ,
			volume = 0.2
		} ,
		{
			filename = "__base__/sound/fight/flamethrower-turret-deactivate-03.ogg" ,
			volume = 0.2
		} ,
		{
			filename = "__base__/sound/fight/flamethrower-turret-deactivate-04.ogg" ,
			volume = 0.2
		}
	}
} )

-- ----------------------------------------
-- 遗迹箱子
-- ----------------------------------------
SIGen
.New( SICommon.Types.Entities.Corpse , "RuinChestRemnants" , "遗迹箱子-残骸" )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceableNeutral , SICommon.Flags.Entity.Building8Way , SICommon.Flags.Entity.NotOnMap , SICommon.Flags.Entity.Hidden } ,
	time_before_removed = 54000 , -- 15 分钟
	tile_width = 1 ,
	tile_height = 1 ,
	selectable_in_game = false ,
	remove_on_tile_placement = false ,
	final_render_layer = SICommon.Flags.RenderLayer.Remnants ,
	animation =
	{
		filename = SIGen.MakeSelfPicturePath( "遗迹箱子-残骸" ) ,
		priority = "extra-high" ,
		width = 56 ,
		height = 38 ,
		frame_count = 1 ,
		line_length = 1 ,
		variation_count = 1 ,
		direction_count = 1 ,
		shift = SIUtils.by_pixel( 8 , -1 )
	}
}
.AutoIcon()
.SetSizeScale( 1 , 1 , 0 )
CreateRuinBuildings( SICommon.Types.Entities.Container , "RuinChest" , "遗迹箱子" , 1 , SIConstants_RuinControl.LevelValueList ,
{
	localised_name = SIGen.MakeLocalisedName( SICommon.Types.Entities.Container , "遗迹箱子" ) ,
	localised_description = SIGen.MakeLocalisedDescription( SICommon.Types.Entities.Container , "遗迹箱子" ) ,
	icons =
	{
		{
			icon = SIGen.MakePicturePath( SICommon.Types.Entities.Container , "遗迹箱子" .. SICommon.ShowNameSuffix.ICON ) ,
			icon_size = 64 ,
			icon_mipmaps = 4
		}
	} ,
	icon_size = 64 ,
	icon_mipmaps = 4 ,
	flags = { SICommon.Flags.Entity.PlaceableEnemy , SICommon.Flags.Entity.NotOnMap , SICommon.Flags.Entity.Hidden } ,
	minable =
	{
		mining_time = 6000.0 ,
		results = {}
	} ,
	max_health = 8 ,
	corpse = SIConstants_RuinControl.raw.Entities.RuinChestRemnants ,
	dying_explosion = "wooden-chest-explosion" ,
	map_color = { r = 1.0 , g = 1.0 , b = 1.0 } ,
	friendly_map_color = { r = 0.4 , g = 0.4 , b = 1.0 } ,
	enemy_map_color = { r = 1.0 , g = 0.4 , b = 0.4 } ,
	alert_when_damaged = false ,
	create_ghost_on_death = false ,
	hide_resistances = false ,
	resistances = nil ,
	damaged_trigger_effect =
	{
		type = "create-entity" ,
		entity_name = "spark-explosion" ,
		offset_deviation = { { -0.5 , -0.5 } , { 0.5 , 0.5 } } ,
		offsets = { { 0 , 1 } } ,
		damage_type_filters = "fire"
	} ,
	repair_speed_modifier = 0.1 ,
	inventory_size = 99 ,
	circuit_wire_connection_point = circuit_connector_definitions.chest.points ,
	circuit_connector_sprites = circuit_connector_definitions.chest.sprites ,
	circuit_wire_max_distance = 9 ,
	alert_icon_shift = { 0 , 0 } ,
	picture =
	{
		layers =
		{
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Container , "遗迹箱子" ) ,
				priority = "extra-high" ,
				width = 32 ,
				height = 36 ,
				shift = SIUtils.by_pixel( 0.5 , -2 )
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Container , "遗迹箱子-影子" ) ,
				priority = "extra-high" ,
				width = 52 ,
				height = 20 ,
				shift = SIUtils.by_pixel( 10 , 6.5 ) ,
				draw_as_shadow = true
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
			filename = "__base__/sound/car-wood-impact.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/car-wood-impact-02.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/car-wood-impact-03.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/car-wood-impact-04.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/car-wood-impact-05.ogg" ,
			volume = 0.5
		}
	} ,
	repair_sound =
	{
		{
			filename = "__core__/sound/manual-repair-advanced-1.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__core__/sound/manual-repair-advanced-2.ogg" ,
			volume = 0.5
		}
	} ,
	open_sound =
	{
		{
			filename = "__base__/sound/wooden-chest-open.ogg" ,
			volume = 0.5
		}
	} ,
	close_sound =
	{
		{
			filename = "__base__/sound/wooden-chest-close.ogg" ,
			volume = 0.5
		}
	}
} )

-- ----------------------------------------
-- 遗迹组装机
-- ----------------------------------------
SIGen
.New( SICommon.Types.Entities.Corpse , "RuinMachineRemnants" , "遗迹组装机-残骸" )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceableNeutral , SICommon.Flags.Entity.NotOnMap , SICommon.Flags.Entity.Hidden } ,
	time_before_removed = 54000 , -- 15 分钟
	tile_width = 3 ,
	tile_height = 3 ,
	selectable_in_game = false ,
	remove_on_tile_placement = false ,
	final_render_layer = SICommon.Flags.RenderLayer.Remnants ,
	animation = SIGraphics.MakeRemnantsAnimation( 3 ,
	{
		{
			filename = SIGen.MakeSelfPicturePath( "遗迹组装机-残骸" ) ,
			priority = "extra-high" ,
			width = 164 ,
			height = 142 ,
			frame_count = 1 ,
			line_length = 1 ,
			variation_count = 1 ,
			direction_count = 1 ,
			scale = 0.66 ,
			shift = SIUtils.by_pixel( 0 , 10 ) ,
			axially_symmetrical = false
		}
	} )
}
.AutoIcon()
.SetSizeScale( 2 , 2 , 0 )
CreateRuinBuildings( SICommon.Types.Entities.Machine , "RuinMachine" , "遗迹组装机" , 2 , SIConstants_RuinControl.LevelValueList ,
{
	localised_name = SIGen.MakeLocalisedName( SICommon.Types.Entities.Machine , "遗迹组装机" ) ,
	localised_description = SIGen.MakeLocalisedDescription( SICommon.Types.Entities.Machine , "遗迹组装机" ) ,
	icons =
	{
		{
			icon = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹组装机" .. SICommon.ShowNameSuffix.ICON ) ,
			icon_size = 64 ,
			icon_mipmaps = 4
		}
	} ,
	icon_size = 64 ,
	icon_mipmaps = 4 ,
	flags = { SICommon.Flags.Entity.PlaceableEnemy , SICommon.Flags.Entity.NotOnMap , SICommon.Flags.Entity.Hidden } ,
	minable =
	{
		mining_time = 6000.0 ,
		results = {}
	} ,
	max_health = 24 ,
	corpse = SIConstants_RuinControl.raw.Entities.RuinMachineRemnants ,
	dying_explosion = "assembling-machine-3-explosion" ,
	map_color = { r = 1.0 , g = 1.0 , b = 1.0 } ,
	friendly_map_color = { r = 0.4 , g = 0.4 , b = 1.0 } ,
	enemy_map_color = { r = 1.0 , g = 0.4 , b = 0.4 } ,
	alert_when_damaged = true ,
	create_ghost_on_death = false ,
	hide_resistances = false ,
	resistances = nil ,
	damaged_trigger_effect =
	{
		type = "create-entity" ,
		entity_name = "spark-explosion" ,
		offset_deviation = { { -0.5 , -0.5 } , { 0.5 , 0.5 } } ,
		offsets = { { 0 , 1 } } ,
		damage_type_filters = "fire"
	} ,
	repair_speed_modifier = 0.1 ,
	energy_source =
	{
		type = SICommon.Flags.EnergySourceType.Electric ,
		emissions_per_minute = 15 ,
		render_no_power_icon = true ,
		render_no_network_icon = true ,
		usage_priority = SICommon.Flags.ElectricUsagePriority.InputSecondary ,
		buffer_capacity = "100MJ" ,
		input_flow_limit = "4MW" ,
		output_flow_limit = "4MW" ,
		drain = "0J"
	} ,
	energy_usage = "2MW" ,
	allowed_effects =
	{
		"consumption" ,
		"pollution"
	} ,
	module_specification =
	{
		module_slots = 8 ,
		module_info_icon_shift = { 0.0 , 0.8 }
	} ,
	base_productivity = 0 ,
	crafting_categories = { SIConstants_RuinControl.raw.Categories.Recipe.RuinMachine } ,
	crafting_speed = 1.0 ,
	ingredient_count = 10 ,
	return_ingredients_on_change = false ,
	fluid_boxes =
	{
		off_when_no_fluid_recipe = true ,
		{
			production_type = SICommon.Flags.FluidBoxProductionType.Input ,
			base_area = 10 ,
			height = 1 ,
			base_level = -1 ,
			hide_connection_info = false ,
			pipe_picture =
			{
				north =
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹组装机-管道上" ) ,
							priority = "extra-high" ,
							width = 35 ,
							height = 18 ,
							scale = 0.66 ,
							shift = SIUtils.by_pixel( 2.5 , 14 )
						}
					}
				} ,
				east =
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹组装机-管道右" ) ,
							priority = "extra-high" ,
							width = 20 ,
							height = 38 ,
							scale = 0.66 ,
							shift = SIUtils.by_pixel( -25 , 1 )
						}
					}
				} ,
				south =
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹组装机-管道下" ) ,
							priority = "extra-high" ,
							width = 44 ,
							height = 31 ,
							scale = 0.66 ,
							shift = SIUtils.by_pixel( 0 , -31.5 )
						}
					}
				} ,
				west =
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹组装机-管道左" ) ,
							priority = "extra-high" ,
							width = 19 ,
							height = 37 ,
							scale = 0.66 ,
							shift = SIUtils.by_pixel( 25.5 , 1.5 )
						}
					}
				}
			} ,
			pipe_covers =
			{
				north =
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹组装机-管道上盖" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66
						} ,
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹组装机-管道上盖-影子" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66 ,
							draw_as_shadow = true
						}
					}
				} ,
				east =
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹组装机-管道右盖" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66
						} ,
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹组装机-管道右盖-影子" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66 ,
							draw_as_shadow = true
						}
					}
				} ,
				south =
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹组装机-管道下盖" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66
						} ,
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹组装机-管道下盖-影子" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66 ,
							draw_as_shadow = true
						}
					}
				} ,
				west =
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹组装机-管道左盖" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66
						} ,
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹组装机-管道左盖-影子" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66 ,
							draw_as_shadow = true
						}
					}
				}
			} ,
			pipe_connections =
			{
				{
					type = SICommon.Flags.FluidBoxConnectionType.Input ,
					position = { 0 , -1.5 }
				}
			} ,
			secondary_draw_orders = { north = -1 }
		} ,
		{
			production_type = SICommon.Flags.FluidBoxProductionType.Output ,
			base_area = 10 ,
			height = 1 ,
			base_level = 1 ,
			hide_connection_info = false ,
			pipe_picture =
			{
				north =
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹组装机-管道上" ) ,
							priority = "extra-high" ,
							width = 35 ,
							height = 18 ,
							scale = 0.66 ,
							shift = SIUtils.by_pixel( 2.5 , 14 )
						}
					}
				} ,
				east =
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹组装机-管道右" ) ,
							priority = "extra-high" ,
							width = 20 ,
							height = 38 ,
							scale = 0.66 ,
							shift = SIUtils.by_pixel( -25 , 1 )
						}
					}
				} ,
				south =
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹组装机-管道下" ) ,
							priority = "extra-high" ,
							width = 44 ,
							height = 31 ,
							scale = 0.66 ,
							shift = SIUtils.by_pixel( 0 , -31.5 )
						}
					}
				} ,
				west =
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹组装机-管道左" ) ,
							priority = "extra-high" ,
							width = 19 ,
							height = 37 ,
							scale = 0.66 ,
							shift = SIUtils.by_pixel( 25.5 , 1.5 )
						}
					}
				}
			} ,
			pipe_covers =
			{
				north =
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹组装机-管道上盖" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66
						} ,
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹组装机-管道上盖-影子" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66 ,
							draw_as_shadow = true
						}
					}
				} ,
				east =
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹组装机-管道右盖" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66
						} ,
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹组装机-管道右盖-影子" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66 ,
							draw_as_shadow = true
						}
					}
				} ,
				south =
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹组装机-管道下盖" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66
						} ,
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹组装机-管道下盖-影子" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66 ,
							draw_as_shadow = true
						}
					}
				} ,
				west =
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹组装机-管道左盖" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66
						} ,
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹组装机-管道左盖-影子" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66 ,
							draw_as_shadow = true
						}
					}
				}
			} ,
			pipe_connections =
			{
				{
					type = SICommon.Flags.FluidBoxConnectionType.Output ,
					position = { 0 , 1.5 }
				}
			} ,
			secondary_draw_orders = { north = -1 }
		}
	} ,
	show_recipe_icon = true ,
	scale_entity_info_icon = false ,
	show_recipe_icon_on_map = true ,
	entity_info_icon_shift = { 0.0 , -0.2 } ,
	alert_icon_shift = SIUtils.by_pixel( -3 , -12 ) ,
	animation =
	{
		layers =
		{
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹组装机" ) ,
				priority = "high" ,
				width = 108 ,
				height = 119 ,
				frame_count = 32 ,
				line_length = 8 ,
				scale = 0.66 ,
				shift = SIUtils.by_pixel( 0 , -0.5 )
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "遗迹组装机-影子" ) ,
				priority = "high" ,
				width = 130 ,
				height = 82 ,
				frame_count = 32 ,
				line_length = 8 ,
				scale = 0.66 ,
				shift = SIUtils.by_pixel( 28 , 4 ) ,
				draw_as_shadow = true
			}
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
			filename = "__core__/sound/manual-repair-advanced-1.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__core__/sound/manual-repair-advanced-2.ogg" ,
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
				filename = "__base__/sound/assembling-machine-t3-1.ogg" ,
				volume = 0.5
			}
		} ,
		audible_distance_modifier = 0.5 ,
		fade_in_ticks = 4 ,
		fade_out_ticks = 20
	}
} )

-- ----------------------------------------
-- 遗迹爪子
-- ----------------------------------------
SIGen
.New( SICommon.Types.Entities.Corpse , "RuinInserterRemnants" , "遗迹爪子-残骸" )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceableNeutral , SICommon.Flags.Entity.NotOnMap , SICommon.Flags.Entity.Hidden } ,
	time_before_removed = 54000 , -- 15 分钟
	tile_width = 1 ,
	tile_height = 1 ,
	selectable_in_game = false ,
	remove_on_tile_placement = false ,
	final_render_layer = SICommon.Flags.RenderLayer.Remnants ,
	animation = SIGraphics.MakeRemnantsAnimation( 4 ,
	{
		{
			filename = SIGen.MakeSelfPicturePath( "遗迹爪子-残骸" ) ,
			priority = "extra-high" ,
			width = 68 ,
			height = 48 ,
			frame_count = 1 ,
			line_length = 1 ,
			variation_count = 1 ,
			direction_count = 1 ,
			shift = SIUtils.by_pixel( 4 , -2 ) ,
			axially_symmetrical = false
		}
	} )
}
.AutoIcon()
.SetSizeScale( 1 , 1 , 0 )
.New( SICommon.Types.Entities.Inserter , "RuinInserter" , "遗迹爪子" )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceableEnemy , SICommon.Flags.Entity.NotOnMap , SICommon.Flags.Entity.Hidden } ,
	minable =
	{
		mining_time = 6000.0 ,
		results = {}
	} ,
	max_health = 270 ,
	corpse = SIConstants_RuinControl.raw.Entities.RuinInserterRemnants ,
	dying_explosion = "inserter-explosion" ,
	map_color = { r = 1.0 , g = 1.0 , b = 1.0 } ,
	friendly_map_color = { r = 0.4 , g = 0.4 , b = 1.0 } ,
	enemy_map_color = { r = 1.0 , g = 0.4 , b = 0.4 } ,
	alert_when_damaged = false ,
	create_ghost_on_death = false ,
	hide_resistances = false ,
	resistances =
	{
		{
			type = "fire" ,
			percent = 25
		}
	} ,
	damaged_trigger_effect =
	{
		type = "create-entity" ,
		entity_name = "spark-explosion" ,
		offset_deviation = { { -0.5 , -0.5 } , { 0.5 , 0.5 } } ,
		offsets = { { 0 , 1 } } ,
		damage_type_filters = "fire"
	} ,
	repair_speed_modifier = 0.1 ,
	default_stack_control_input_signal =
	{
		type = "virtual" ,
		name = "signal-S"
	} ,
	circuit_wire_connection_points = circuit_connector_definitions.inserter.points ,
	circuit_connector_sprites = circuit_connector_definitions.inserter.sprites ,
	circuit_wire_max_distance = 9 ,
	energy_source =
	{
		type = SICommon.Flags.EnergySourceType.Electric ,
		emissions_per_minute = 1 ,
		render_no_power_icon = true ,
		render_no_network_icon = true ,
		usage_priority = SICommon.Flags.ElectricUsagePriority.InputSecondary ,
		buffer_capacity = "100MJ" ,
		input_flow_limit = "4MW" ,
		output_flow_limit = "4MW" ,
		drain = "0J"
	} ,
	energy_per_movement = "85KJ" ,
	energy_per_rotation = "85KJ" ,
	extension_speed = 0.35 ,
	rotation_speed = 0.16 ,
	pickup_position = { 0 , -1 } ,
	insert_position = { 0 , 1.2 } ,
	allow_custom_vectors = true ,
	platform_picture =
	{
		sheet =
		{
			filename = SIGen.MakeSelfPicturePath( "遗迹爪子-底座" ) ,
			priority = "extra-high" ,
			width = 46 ,
			height = 46 ,
			shift = { 0.09375 , 0 }
		}
	} ,
	hand_base_picture =
	{
		filename = SIGen.MakeSelfPicturePath( "遗迹爪子-基础" ) ,
		priority = "extra-high" ,
		width = 8 ,
		height = 33
	} ,
	hand_base_shadow =
	{
		filename = SIGen.MakeSelfPicturePath( "遗迹爪子-基础-影子" ) ,
		priority = "extra-high" ,
		width = 8 ,
		height = 33
	} ,
	hand_open_picture =
	{
		filename = SIGen.MakeSelfPicturePath( "遗迹爪子-打开" ) ,
		priority = "extra-high" ,
		width = 18 ,
		height = 41
	} ,
	hand_open_shadow =
	{
		filename = SIGen.MakeSelfPicturePath( "遗迹爪子-打开-影子" ) ,
		priority = "extra-high" ,
		width = 18 ,
		height = 41
	} ,
	hand_closed_picture =
	{
		filename = SIGen.MakeSelfPicturePath( "遗迹爪子-关闭" ) ,
		priority = "extra-high" ,
		width = 18 ,
		height = 41
	} ,
	hand_closed_shadow =
	{
		filename = SIGen.MakeSelfPicturePath( "遗迹爪子-关闭-影子" ) ,
		priority = "extra-high" ,
		width = 18 ,
		height = 41
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
			filename = "__base__/sound/car-wood-impact.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/car-wood-impact-02.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/car-wood-impact-03.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/car-wood-impact-04.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/car-wood-impact-05.ogg" ,
			volume = 0.5
		}
	} ,
	repair_sound =
	{
		{
			filename = "__core__/sound/manual-repair-advanced-1.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__core__/sound/manual-repair-advanced-2.ogg" ,
			volume = 0.5
		}
	} ,
	open_sound =
	{
		{
			filename = "__base__/sound/wooden-chest-open.ogg" ,
			volume = 0.5
		}
	} ,
	close_sound =
	{
		{
			filename = "__base__/sound/wooden-chest-close.ogg" ,
			volume = 0.5
		}
	} ,
	working_sound =
	{
		sound =
		{
			{
				filename = "__base__/sound/inserter-basic-1.ogg" ,
				volume = 0.5
			} ,
			{
				filename = "__base__/sound/inserter-basic-2.ogg" ,
				volume = 0.5
			} ,
			{
				filename = "__base__/sound/inserter-basic-3.ogg" ,
				volume = 0.5
			} ,
			{
				filename = "__base__/sound/inserter-basic-4.ogg" ,
				volume = 0.5
			} ,
			{
				filename = "__base__/sound/inserter-basic-5.ogg" ,
				volume = 0.5
			}
		} ,
		match_progress_to_activity = true ,
		audible_distance_modifier = 0.3
	}
}
.AutoIcon()
.SetSize( 1 , 1 )

-- ----------------------------------------
-- 遗迹地板
-- ----------------------------------------
local DefaultTransitionGroupID = 0
local WaterTransitionGroupID = 1
local OutOfMapTransitionGroupID = 2
local function MakeTileTransitionPicture( src_x , src_y , cnt_ , line_len_ , is_tall , picture )
	return
	{
		picture = picture,
		count = cnt_,
		line_length = line_len_,
		x = src_x,
		y = src_y,
		tall = is_tall
	}
end
local function MakeTileTransition( options )
	local data = options.base or {}
	data.to_tiles = options.to_tiles
	data.transition_group = options.group1
	data.transition_group1 = options.group2 and options.group1 or nil
	data.transition_group2 = options.group2
	local default_count = options.count or 16
	for k , y in pairs{ inner_corner = 0 , outer_corner = 288 , side = 576 , u_transition = 864 , o_transition = 1152 } do
		local count = options[k .. "_count"] or default_count
		if count > 0 then
			local line_length = options[k .. "_line_length"] or count
			local is_tall = true
			if options[k .. "_tall"] == false then
				is_tall = false
			end
			data[k] = MakeTileTransitionPicture( 0 , y , count , line_length , is_tall , options.picture )
			data[k .. "_mask"] = MakeTileTransitionPicture( 1088 , y , count , line_length , nil , options.picture )
			if options.background then
				data[k .. "_background"] = MakeTileTransitionPicture( 544 , y , count , line_length , is_tall , options.picture )
			end
			if options.effect_map then
				local effect_default_count = options.effect_map.count or 16
				local effect_count = options.effect_map[k .. "_count"] or effect_default_count
				if effect_count > 0 then
					local effect_line_length = options.effect_map[k .. "_line_length"] or effect_count
					local effect_is_tall = true
					if options.effect_map[k .. "_tall"] == false then
						effect_is_tall = false
					end
					data[k .. "_effect_map"] = MakeTileTransitionPicture( 0 , y , effect_count , effect_line_length , effect_is_tall , options.effect_map.filename_norm )
				end
			end
		end
	end
	return data
end
SIGen
.New( SICommon.Types.Tile , "RuinFloor" , "遗迹地板" )
.Append
{
	minable =
	{
		mining_time = 6000.0 ,
		results = {}
	} ,
	collision_mask = { SICommon.Flags.CollisionMask.Ground } ,
	needs_correction = false ,
	walking_speed_modifier = 0.75 ,
	vehicle_friction_modifier = 1.9 ,
	decorative_removal_probability = 1.0 ,
	pollution_absorption_per_second = 0 ,
	map_color = { r = 49 , g = 48 , b = 45 } ,
	scorch_mark_color = { r = 0.37 , g = 0.30 , b = 0.24 , a = 1.00 } ,
	trigger_effect =
	{
		{
			type = "create-particle" ,
			particle_name = "concrete-stone-particle-small" ,
			tile_collision_mask = nil ,
			affects_target = false ,
			show_in_tooltip = false ,
			probability = 1 ,
			repeat_count = 20 ,
			repeat_count_deviation = 5 ,
			initial_height = 0.2 ,
			initial_height_deviation = 0.22 ,
			initial_vertical_speed = 0.1 ,
			initial_vertical_speed_deviation = 0.041 ,
			speed_from_center = 0.05 ,
			speed_from_center_deviation = 0.05 ,
			frame_speed = 1 ,
			frame_speed_deviation = 0 ,
			offsets = { { 0 , 0 } } ,
			offset_deviation = { { -0.5 , -0.5977 } , { 0.5 , 0.5977 } }
		} ,
		{
			type = "create-particle" ,
			particle_name = "concrete-stone-particle-medium" ,
			tile_collision_mask = nil ,
			affects_target = false ,
			show_in_tooltip = false ,
			probability = 1 ,
			repeat_count = 7 ,
			repeat_count_deviation = 2 ,
			initial_height = 0.2 ,
			initial_height_deviation = 0.5 ,
			initial_vertical_speed = 0.125 ,
			initial_vertical_speed_deviation = 0.042 ,
			speed_from_center = 0.03 ,
			speed_from_center_deviation = 0.05 ,
			frame_speed = 1 ,
			frame_speed_deviation = 0 ,
			offsets = { { 0 , 0 } } ,
			offset_deviation = { { -0.2 , -0.2 } , { 0.3 , 0.3 } }
		} ,
		{
			type = "create-particle" ,
			particle_name = "concrete-stone-lower-particle-medium" ,
			tile_collision_mask = nil ,
			affects_target = false ,
			show_in_tooltip = false ,
			probability = 1 ,
			repeat_count = 7 ,
			repeat_count_deviation = 2 ,
			initial_height = 0.2 ,
			initial_height_deviation = 0.2 ,
			initial_vertical_speed = 0.125 ,
			initial_vertical_speed_deviation = 0.042 ,
			speed_from_center = 0.03 ,
			speed_from_center_deviation = 0.05 ,
			frame_speed = 1 ,
			frame_speed_deviation = 0 ,
			offsets = { { 0 , 0 } } ,
			offset_deviation = { { -0.3984 , -0.7969 } , { 0.3984 , 0.7969 } }
		} ,
		{
			type = "create-particle" ,
			particle_name = "concrete-stone-particle-tiny" ,
			tile_collision_mask = nil ,
			affects_target = false ,
			show_in_tooltip = false ,
			probability = 1 ,
			repeat_count = 15 ,
			repeat_count_deviation = 4 ,
			initial_height = 0.2 ,
			initial_height_deviation = 0.5 ,
			initial_vertical_speed = 0.1 ,
			initial_vertical_speed_deviation = 0.05 ,
			speed_from_center = 0.03 ,
			speed_from_center_deviation = 0.02 ,
			frame_speed = 1 ,
			frame_speed_deviation = 0 ,
			offsets = { { 0 , 0 } } ,
			offset_deviation = { { -0.4 , -0.4 } , { 0.4 , 0.4 } }
		}
	} ,
	layer = 64 ,
	transition_overlay_layer_offset = 2 ,
	variants =
	{
		main =
		{
			{
				picture = SIGen.MakePicturePath( SICommon.Types.Tile , "遗迹地板-形状" ) ,
				count = 1 ,
				size = 1
			} ,
			{
				picture = SIGen.MakePicturePath( SICommon.Types.Tile , "遗迹地板-形状" ) ,
				count = 1 ,
				size = 2 ,
				probability = 0.39
			} ,
			{
				picture = SIGen.MakePicturePath( SICommon.Types.Tile , "遗迹地板-形状" ) ,
				count = 1 ,
				size = 4 ,
				probability = 1
			}
		} ,
		inner_corner =
		{
			picture = SIGen.MakePicturePath( SICommon.Types.Tile , "遗迹地板-内角" ) ,
			count = 16
		} ,
		inner_corner_mask =
		{
			picture = SIGen.MakePicturePath( SICommon.Types.Tile , "遗迹地板-内角-遮盖" ) ,
			count = 16
		} ,
		outer_corner =
		{
			picture = SIGen.MakePicturePath( SICommon.Types.Tile , "遗迹地板-外角" ) ,
			count = 8
		} ,
		outer_corner_mask =
		{
			picture = SIGen.MakePicturePath( SICommon.Types.Tile , "遗迹地板-外角-遮盖" ) ,
			count = 8
		} ,
		side =
		{
			picture = SIGen.MakePicturePath( SICommon.Types.Tile , "遗迹地板-侧边" ) ,
			count = 16
		} ,
		side_mask =
		{
			picture = SIGen.MakePicturePath( SICommon.Types.Tile , "遗迹地板-侧边-遮盖" ) ,
			count = 16
		} ,
		u_transition =
		{
			picture = SIGen.MakePicturePath( SICommon.Types.Tile , "遗迹地板-凹形" ) ,
			count = 8
		} ,
		u_transition_mask =
		{
			picture = SIGen.MakePicturePath( SICommon.Types.Tile , "遗迹地板-凹形-遮盖" ) ,
			count = 8
		} ,
		o_transition =
		{
			picture = SIGen.MakePicturePath( SICommon.Types.Tile , "遗迹地板-圆形" ) ,
			count = 4
		} ,
		o_transition_mask =
		{
			picture = SIGen.MakePicturePath( SICommon.Types.Tile , "遗迹地板-圆形-遮盖" ) ,
			count = 4
		} ,
		material_background =
		{
			picture = SIGen.MakePicturePath( SICommon.Types.Tile , "遗迹地板" ) ,
			count = 8
		}
	} ,
	transitions =
	{
		MakeTileTransition
		{
			picture = SIGen.MakePicturePath( SICommon.Types.Tile , "遗迹地板-过渡" ) ,
			effect_map =
			{
				filename_norm = "__base__/graphics/terrain/effect-maps/water-stone-mask.png" ,
				count = 1 ,
				o_transition_tall = false
			} ,
			to_tiles = water_tile_type_names ,
			group1 = WaterTransitionGroupID ,
			group2 = nil ,
			inner_corner_count = 8 ,
			outer_corner_count = 8 ,
			side_count = 8 ,
			u_transition_count = 4 ,
			o_transition_count = 4 ,
			o_transition_tall = false ,
			background = false
		} ,
		MakeTileTransition
		{
			picture = SIGen.MakePicturePath( SICommon.Types.Tile , "遗迹地板-地图外-过渡" ) ,
			to_tiles = { "out-of-map" } ,
			group1 = OutOfMapTransitionGroupID ,
			group2 = nil ,
			inner_corner_count = 4 ,
			outer_corner_count = 4 ,
			side_count = 8 ,
			u_transition_count = 1 ,
			o_transition_count = 1 ,
			o_transition_tall = false ,
			background = true ,
			base =
			{
				background_layer_offset = 1 ,
				background_layer_group = "zero" ,
				offset_background_layer_by_tile_layer = true
			}
		}
	} ,
	transitions_between_transitions =
	{
		MakeTileTransition
		{
			picture = SIGen.MakePicturePath( SICommon.Types.Tile , "遗迹地板-过渡的过渡" ) ,
			effect_map =
			{
				filename_norm = "__base__/graphics/terrain/effect-maps/water-stone-to-land-mask.png" ,
				count = 3 ,
				u_transition_count = 1 ,
				o_transition_count = 0
			} ,
			to_tiles = nil ,
			group1 = DefaultTransitionGroupID ,
			group2 = WaterTransitionGroupID ,
			inner_corner_count = 3 ,
			inner_corner_tall = true ,
			outer_corner_count = 3 ,
			side_count = 3 ,
			u_transition_count = 1 ,
			o_transition_count = 0 ,
			background = false
		} ,
		MakeTileTransition
		{
			picture = SIGen.MakePicturePath( SICommon.Types.Tile , "遗迹地板-地图外-过渡2" ) ,
			to_tiles = nil ,
			group1 = DefaultTransitionGroupID ,
			group2 = OutOfMapTransitionGroupID ,
			inner_corner_count = 3 ,
			inner_corner_tall = true ,
			outer_corner_count = 3 ,
			side_count = 3 ,
			u_transition_count = 1 ,
			o_transition_count = 0 ,
			background = true ,
			base =
			{
				background_layer_offset = 1 ,
				background_layer_group = "zero" ,
				offset_background_layer_by_tile_layer = true
			}
		} ,
		MakeTileTransition
		{
			picture = SIGen.MakePicturePath( SICommon.Types.Tile , "遗迹地板-地图外岸边-过渡" ) ,
			effect_map =
			{
				filename_norm = "__base__/graphics/terrain/effect-maps/water-stone-to-out-of-map-mask.png" ,
				count = 3 ,
				u_transition_count = 0 ,
				o_transition_count = 0
			} ,
			to_tiles = nil ,
			group1 = WaterTransitionGroupID ,
			group2 = OutOfMapTransitionGroupID ,
			inner_corner_count = 3 ,
			outer_corner_count = 3 ,
			side_count = 3 ,
			u_transition_count = 1 ,
			o_transition_count = 0 ,
			o_transition_tall = false ,
			background = true ,
			base =
			{
				background_layer_offset = 1 ,
				background_layer_group = "zero" ,
				offset_background_layer_by_tile_layer = true
			}
		}
	} ,
	mined_sound =
	{
		{
			filename = "__base__/sound/deconstruct-bricks.ogg" ,
			volume = 0.8
		}
	} ,
	build_sound =
	{
		small =
		{
			{
				filename = "__core__/sound/build-concrete-small.ogg" ,
				volume = 0.4
			} ,
			{
				filename = "__core__/sound/build-concrete-small-1.ogg" ,
				volume = 0.4
			} ,
			{
				filename = "__core__/sound/build-concrete-small-2.ogg" ,
				volume = 0.4
			} ,
			{
				filename = "__core__/sound/build-concrete-small-3.ogg" ,
				volume = 0.4
			} ,
			{
				filename = "__core__/sound/build-concrete-small-4.ogg" ,
				volume = 0.4
			} ,
			{
				filename = "__core__/sound/build-concrete-small-5.ogg" ,
				volume = 0.4
			}
		} ,
		medium =
		{
			{
				filename = "__core__/sound/build-concrete-medium.ogg" ,
				volume = 0.5
			} ,
			{
				filename = "__core__/sound/build-concrete-medium-1.ogg" ,
				volume = 0.5
			} ,
			{
				filename = "__core__/sound/build-concrete-medium-2.ogg" ,
				volume = 0.5
			} ,
			{
				filename = "__core__/sound/build-concrete-medium-3.ogg" ,
				volume = 0.5
			} ,
			{
				filename = "__core__/sound/build-concrete-medium-4.ogg" ,
				volume = 0.5
			} ,
			{
				filename = "__core__/sound/build-concrete-medium-5.ogg" ,
				volume = 0.5
			}
		} ,
		large =
		{
			{
				filename = "__core__/sound/build-concrete-large.ogg" ,
				volume = 0.5
			} ,
			{
				filename = "__core__/sound/build-concrete-large-1.ogg" ,
				volume = 0.5
			} ,
			{
				filename = "__core__/sound/build-concrete-large-2.ogg" ,
				volume = 0.5
			} ,
			{
				filename = "__core__/sound/build-concrete-large-3.ogg" ,
				volume = 0.5
			} ,
			{
				filename = "__core__/sound/build-concrete-large-4.ogg" ,
				volume = 0.5
			} ,
			{
				filename = "__core__/sound/build-concrete-large-5.ogg" ,
				volume = 0.5
			}
		}
	} ,
	walking_sound =
	{
		{
			filename = "__base__/sound/walking/refined-concrete-01.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/walking/refined-concrete-02.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/walking/refined-concrete-03.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/walking/refined-concrete-04.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/walking/refined-concrete-05.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/walking/refined-concrete-06.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/walking/refined-concrete-07.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/walking/refined-concrete-08.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/walking/refined-concrete-09.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/walking/refined-concrete-10.ogg" ,
			volume = 0.5
		} ,
		{
			filename = "__base__/sound/walking/refined-concrete-11.ogg" ,
			volume = 0.5
		}
	}
}
.AutoIcon()
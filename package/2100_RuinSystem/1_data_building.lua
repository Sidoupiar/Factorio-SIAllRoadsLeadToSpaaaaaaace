-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 遗迹建筑 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIGen
.SetGroup( SIConstants_RuinSystem.raw.Groups.Hidden.RuinBuildings )

-- ======================================================================
-- 根据等级创建遗迹建筑
-- ======================================================================
local Range_GunTurret = 14
local Range_LaserTurret = 16
local Range_FlameTurret = 25
local CallForHelpRadius = 30
local UtilFunctions = {}

-- ======================================================================<br>
---@param actions table
---@param levelValue table
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

-- ======================================================================<br>
---@param effects table
---@param levelValue table
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

-- ======================================================================<br>
---@param type string
---@param IDPrefix string
---@param aliasPrefix string
---@param size number
---@param levelValueList table
---@param basePrototypeData table
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
					table.insert( prototypeData.resistances , SITools.Resistance( damagePrototypeName , levelValue.Decrease , levelValue.Defence ) )
				end
			end )
		end )
	end
end

-- ======================================================================
-- 遗迹围墙
-- ======================================================================
SIGen
.New( SICommon.Types.Entities.Corpse , "RuinWall_Corpse" , "遗迹围墙-残骸" )
.AutoIcon()
.SetSizeScale( 1 , 1 , 0 )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceableNeutral , SICommon.Flags.Entity.NotOnMap } ,
	time_before_removed = 54000 , -- 15 分钟
	tile_width = 1 ,
	tile_height = 1 ,
	selectable_in_game = false ,
	remove_on_tile_placement = false ,
	final_render_layer = SICommon.Flags.RenderLayer.Remnants ,
	animation = SIGraphics.MakeRemnantsAnimation( 4 ,
	{
		{
			filename = SIGen.MakeSelfPicturePath( "RuinWall-Corpse" , "遗迹围墙-残骸" ) ,
			priority = "extra-high" ,
			width = 60 ,
			height = 58 ,
			frame_count = 1 ,
			line_length = 1 ,
			variation_count = 1 ,
			direction_count = 2 ,
			scale = 1.0 ,
			shift = SIUtils.by_pixel( 3 , 7.5 ) ,
			hr_version =
			{
				filename = SIGen.MakeSelfPicturePathHr( "RuinWall-Corpse" , "遗迹围墙-残骸" ) ,
				priority = "extra-high" ,
				width = 118 ,
				height = 114 ,
				frame_count = 1 ,
				line_length = 1 ,
				variation_count = 1 ,
				direction_count = 2 ,
				scale = 0.5 ,
				shift = SIUtils.by_pixel( 3 , 7.5 )
			}
		}
	} )
}
CreateRuinBuildings( SICommon.Types.Entities.Wall , "RuinWall" , "遗迹围墙" , 0.85 , SIConstants_RuinSystem.LevelValueList ,
{
	localised_name = SIGen.MakeLocalisedName( SICommon.Types.Entities.Wall , "遗迹围墙" ) ,
	localised_description = SIGen.MakeLocalisedDescription( SICommon.Types.Entities.Wall , "遗迹围墙" ) ,
	icons =
	{
		{
			icon = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "RuinWall" .. SICommon.CodeNameSuffix.ICON , "遗迹围墙" .. SICommon.ShowNameSuffix.ICON ) ,
			icon_size = 64 ,
			icon_mipmaps = 4
		}
	} ,
	icon_size = 64 ,
	icon_mipmaps = 4 ,
	flags = { SICommon.Flags.Entity.PlaceableEnemy } ,
	minable =
	{
		mining_time = 6000.0 ,
		results = {}
	} ,
	max_health = 550 ,
	corpse = SIConstants_RuinSystem.raw.Entities.RuinWall_Corpse ,
	dying_explosion = "wall-explosion" ,
	map_color = { r = 1.0 , g = 1.0 , b = 1.0 } ,
	friendly_map_color = { r = 0.4 , g = 0.4 , b = 1.0 } ,
	enemy_map_color = { r = 1.0 , g = 0.4 , b = 0.4 } ,
	is_military_target = true ,
	allow_run_time_change_of_is_military_target = true ,
	alert_when_damaged = true ,
	create_ghost_on_death = false ,
	hide_resistances = false ,
	resistances =
	{
		SITools.Resistance( "fire" , 0 , 100 )
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
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "RuinWall-single" , "遗迹围墙-独立" ) ,
					priority = "extra-high" ,
					width = 32 ,
					height = 46 ,
					line_length = 2 ,
					variation_count = 2 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 0 , -6 ) ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Wall , "RuinWall-Single" , "遗迹围墙-独立" ) ,
						priority = "extra-high" ,
						width = 64 ,
						height = 86 ,
						line_length = 2 ,
						variation_count = 2 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 0 , -5 )
					}
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "RuinWall-Single-Shadow" , "遗迹围墙-独立-影子" ) ,
					priority = "extra-high" ,
					width = 50 ,
					height = 32 ,
					repeat_count = 2 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 10 , 16 ) ,
					draw_as_shadow = true ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Wall , "RuinWall-Single-Shadow" , "遗迹围墙-独立-影子" ) ,
						priority = "extra-high" ,
						width = 98 ,
						height = 60 ,
						repeat_count = 2 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 10 , 17 ) ,
						draw_as_shadow = true
					}
				}
			}
		} ,
		straight_horizontal =
		{
			layers =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "RuinWall-Horizontal" , "遗迹围墙-横向" ) ,
					priority = "extra-high" ,
					width = 32 ,
					height = 50 ,
					line_length = 6 ,
					variation_count = 6 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 0 , -4 ) ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Wall , "RuinWall-Horizontal" , "遗迹围墙-横向" ) ,
						priority = "extra-high" ,
						width = 64 ,
						height = 92 ,
						line_length = 6 ,
						variation_count = 6 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 0 , -2 )
					}
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "RuinWall-Horizontal-Shadow" , "遗迹围墙-横向-影子" ) ,
					priority = "extra-high" ,
					width = 62 ,
					height = 36 ,
					repeat_count = 6 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 14 , 14 ) ,
					draw_as_shadow = true ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Wall , "RuinWall-Horizontal-Shadow" , "遗迹围墙-横向-影子" ) ,
						priority = "extra-high" ,
						width = 124 ,
						height = 68 ,
						repeat_count = 6 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 14 , 15 ) ,
						draw_as_shadow = true
					}
				}
			}
		} ,
		straight_vertical =
		{
			layers =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "RuinWall-Vertical" , "遗迹围墙-纵向" ) ,
					priority = "extra-high" ,
					width = 32 ,
					height = 68 ,
					line_length = 5 ,
					variation_count = 5 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 0 , 8 ) ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Wall , "RuinWall-Vertical" , "遗迹围墙-纵向" ) ,
						priority = "extra-high" ,
						width = 64 ,
						height = 134 ,
						line_length = 5 ,
						variation_count = 5 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 0 , 8 )
					}
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "RuinWall-Vertical-Shadow" , "遗迹围墙-纵向-影子" ) ,
					priority = "extra-high" ,
					width = 50 ,
					height = 58 ,
					repeat_count = 5 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 10 , 28 ) ,
					draw_as_shadow = true ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Wall , "RuinWall-Vertical-Shadow" , "遗迹围墙-纵向-影子" ) ,
						priority = "extra-high" ,
						width = 98 ,
						height = 110 ,
						repeat_count = 5 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 10 , 29 ) ,
						draw_as_shadow = true
					}
				}
			}
		} ,
		corner_left_down =
		{
			layers =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "RuinWall-LeftDown" , "遗迹围墙-拐角左" ) ,
					priority = "extra-high" ,
					width = 32 ,
					height = 68 ,
					line_length = 2 ,
					variation_count = 2 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 0 , 6 ) ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Wall , "RuinWall-LeftDown" , "遗迹围墙-拐角左" ) ,
						priority = "extra-high" ,
						width = 64 ,
						height = 134 ,
						line_length = 2 ,
						variation_count = 2 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 0 , 7 )
					}
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "RuinWall-LeftDown-Shadow" , "遗迹围墙-拐角左-影子" ) ,
					priority = "extra-high" ,
					width = 54 ,
					height = 60 ,
					repeat_count = 2 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 8 , 28 ) ,
					draw_as_shadow = true ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Wall , "RuinWall-LeftDown-Shadow" , "遗迹围墙-拐角左-影子" ) ,
						priority = "extra-high" ,
						width = 102 ,
						height = 120 ,
						repeat_count = 2 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 9 , 28 ) ,
						draw_as_shadow = true
					}
				}
			}
		} ,
		corner_right_down =
		{
			layers =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "RuinWall-RightDown" , "遗迹围墙-拐角右" ) ,
					priority = "extra-high",
					width = 32 ,
					height = 64 ,
					line_length = 2 ,
					variation_count = 2 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 0 , 6 ) ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Wall , "RuinWall-RightDown" , "遗迹围墙-拐角右" ) ,
						priority = "extra-high",
						width = 64 ,
						height = 128 ,
						line_length = 2 ,
						variation_count = 2 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 0 , 7 )
					}
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "RuinWall-RightDown-Shadow" , "遗迹围墙-拐角右-影子" ) ,
					priority = "extra-high" ,
					width = 62 ,
					height = 60 ,
					repeat_count = 2 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 14 , 28 ) ,
					draw_as_shadow = true ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Wall , "RuinWall-RightDown-Shadow" , "遗迹围墙-拐角右-影子" ) ,
						priority = "extra-high" ,
						width = 124 ,
						height = 120 ,
						repeat_count = 2 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 17 , 28 ) ,
						draw_as_shadow = true
					}
				}
			}
		} ,
		t_up =
		{
			layers =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "RuinWall-TUp" , "遗迹围墙-中分" ) ,
					priority = "extra-high" ,
					width = 32 ,
					height = 68 ,
					line_length = 4 ,
					variation_count = 4 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 0 , 6 ) ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Wall , "RuinWall-TUp" , "遗迹围墙-中分" ) ,
						priority = "extra-high" ,
						width = 64 ,
						height = 134 ,
						line_length = 4 ,
						variation_count = 4 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 0 , 7 )
					}
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "RuinWall-TUp-Shadow" , "遗迹围墙-中分-影子" ) ,
					priority = "extra-high" ,
					width = 62 ,
					height = 60 ,
					repeat_count = 4 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 14 , 28 ) ,
					draw_as_shadow = true ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Wall , "RuinWall-TUp-Shadow" , "遗迹围墙-中分-影子" ) ,
						priority = "extra-high" ,
						width = 124 ,
						height = 120 ,
						repeat_count = 4 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 14 , 28 ) ,
						draw_as_shadow = true
					}
				}
			}
		} ,
		ending_left =
		{
			layers =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "RuinWall-EndLeft" , "遗迹围墙-尽头左" ) ,
					priority = "extra-high" ,
					width = 32 ,
					height = 48 ,
					line_length = 2 ,
					variation_count = 2 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 0 , -4 ) ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Wall , "RuinWall-EndLeft" , "遗迹围墙-尽头左" ) ,
						priority = "extra-high" ,
						width = 64 ,
						height = 92 ,
						line_length = 2 ,
						variation_count = 2 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 0 , -3 )
					}
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "RuinWall-EndLeft-Shadow" , "遗迹围墙-尽头左-影子" ) ,
					priority = "extra-high" ,
					width = 54 ,
					height = 36 ,
					repeat_count = 2 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 8 , 14 ) ,
					draw_as_shadow = true ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Wall , "RuinWall-EndLeft-Shadow" , "遗迹围墙-尽头左-影子" ) ,
						priority = "extra-high" ,
						width = 102 ,
						height = 68 ,
						repeat_count = 2 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 9 , 15 ) ,
						draw_as_shadow = true
					}
				}
			}
		} ,
		ending_right =
		{
			layers =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "RuinWall-EndRight" , "遗迹围墙-尽头右" ) ,
					priority = "extra-high" ,
					width = 32 ,
					height = 48 ,
					line_length = 2 ,
					variation_count = 2 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 0 , -4 ) ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Wall , "RuinWall-EndRight" , "遗迹围墙-尽头右" ) ,
						priority = "extra-high" ,
						width = 64 ,
						height = 92 ,
						line_length = 2 ,
						variation_count = 2 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 0 , -3 )
					}
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "RuinWall-EndRight-Shadow" , "遗迹围墙-尽头右-影子" ) ,
					priority = "extra-high" ,
					width = 62 ,
					height = 36 ,
					repeat_count = 2 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 14 , 14 ) ,
					draw_as_shadow = true ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Wall , "RuinWall-EndRight-Shadow" , "遗迹围墙-尽头右-影子" ) ,
						priority = "extra-high" ,
						width = 124 ,
						height = 68 ,
						repeat_count = 2 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 17 , 15 ) ,
						draw_as_shadow = true
					}
				}
			}
		} ,
		filling =
		{
			layers =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "RuinWall-Fill" , "遗迹围墙-填充" ) ,
					priority = "extra-high" ,
					width = 24 ,
					height = 30 ,
					line_length = 8 ,
					variation_count = 8 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 0 , -2 ) ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Wall , "RuinWall-Fill-Shadow" , "遗迹围墙-填充" ) ,
						priority = "extra-high" ,
						width = 48 ,
						height = 56 ,
						line_length = 8 ,
						variation_count = 8 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 0 , -1 )
					}
				}
			}
		} ,
		water_connection_patch =
		{
			sheets =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "RuinWall-Water" , "遗迹围墙-拼接" ) ,
					priority = "extra-high" ,
					width = 58 ,
					height = 64 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 0 , -2 ) ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Wall , "RuinWall-Water" , "遗迹围墙-拼接" ) ,
						priority = "extra-high" ,
						width = 116 ,
						height = 128 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 0 , -2 )
					}
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "RuinWall-Water-Shadow" , "遗迹围墙-拼接-影子" ) ,
					priority = "extra-high" ,
					width = 74 ,
					height = 52 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 8 , 14 ) ,
					draw_as_shadow = true ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Wall , "RuinWall-Water-Shadow" , "遗迹围墙-拼接-影子" ) ,
						priority = "extra-high" ,
						width = 144 ,
						height = 100 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 9 , 15 ) ,
						draw_as_shadow = true
					}
				}
			}
		} ,
		gate_connection_patch =
		{
			sheets =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "RuinWall-Gate" , "遗迹围墙-闸门" ) ,
					priority = "extra-high" ,
					width = 42 ,
					height = 56 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 0 , -8 ) ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Wall , "RuinWall-Gate" , "遗迹围墙-闸门" ) ,
						priority = "extra-high" ,
						width = 82 ,
						height = 108 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 0 , -7 )
					}
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "RuinWall-Gate-Shadow" , "遗迹围墙-闸门-影子" ) ,
					priority = "extra-high" ,
					width = 66 ,
					height = 40 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 14 , 18 ) ,
					draw_as_shadow = true ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Wall , "RuinWall-Gate-Shadow" , "遗迹围墙-闸门-影子" ) ,
						priority = "extra-high" ,
						width = 130 ,
						height = 78 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 14 , 18 ) ,
						draw_as_shadow = true
					}
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
			filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "RuinWall-Diode-Green" , "遗迹围墙-信号灯-绿" ) ,
			priority = "extra-high" ,
			width = 38 ,
			height = 24 ,
			scale = 1.0 ,
			shift = SIUtils.by_pixel( -2 , -24 ) ,
			draw_as_glow = true ,
			hr_version =
			{
				filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Wall , "RuinWall-Diode-Green" , "遗迹围墙-信号灯-绿" ) ,
				priority = "extra-high" ,
				width = 72 ,
				height = 44 ,
				scale = 0.5 ,
				shift = SIUtils.by_pixel( -1 , -23 ) ,
				draw_as_glow = true
			}
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
			filename = SIGen.MakePicturePath( SICommon.Types.Entities.Wall , "RuinWall-Diode-Red" , "遗迹围墙-信号灯-红" ) ,
			priority = "extra-high" ,
			width = 38 ,
			height = 24 ,
			scale = 1.0 ,
			shift = SIUtils.by_pixel( -2 , -24 ) ,
			draw_as_glow = true ,
			hr_version =
			{
				filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Wall , "RuinWall-Diode-Red" , "遗迹围墙-信号灯-红" ) ,
				priority = "extra-high" ,
				width = 72 ,
				height = 44 ,
				scale = 0.5 ,
				shift = SIUtils.by_pixel( -1 , -23 ) ,
				draw_as_glow = true
			}
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
		SISound.Base( "deconstruct-bricks" , 0.8 )
	} ,
	vehicle_impact_sound =
	{
		SISound.Base( "car-stone-impact" , 0.5 ) ,
		SISound.Base( "car-stone-impact-2" , 0.5 ) ,
		SISound.Base( "car-stone-impact-3" , 0.5 ) ,
		SISound.Base( "car-stone-impact-4" , 0.5 ) ,
		SISound.Base( "car-stone-impact-5" , 0.5 ) ,
		SISound.Base( "car-stone-impact-6" , 0.5 )
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
} )

-- ======================================================================
-- 遗迹地雷
-- ======================================================================
SIGen
.New( SICommon.Types.Entities.Corpse , "RuinLandMine_Corpse" , "遗迹地雷-残骸" )
.AutoIcon()
.SetSizeScale( 1 , 1 , 0 )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceableNeutral , SICommon.Flags.Entity.NotOnMap } ,
	time_before_removed = 54000 , -- 15 分钟
	tile_width = 1 ,
	tile_height = 1 ,
	selectable_in_game = false ,
	remove_on_tile_placement = false ,
	final_render_layer = SICommon.Flags.RenderLayer.Remnants ,
	animation = SIGraphics.MakeRemnantsAnimation( 3 ,
	{
		{
			filename = SIGen.MakeSelfPicturePath( "RuinLandMine-Corpse" , "遗迹地雷-残骸" ) ,
			priority = "extra-high" ,
			width = 68 ,
			height = 66 ,
			frame_count = 1 ,
			line_length = 1 ,
			variation_count = 1 ,
			direction_count = 1 ,
			scale = 1.0 ,
			shift = SIUtils.by_pixel( 2 , 5 ) ,
			axially_symmetrical = false ,
			hr_version =
			{
				filename = SIGen.MakeSelfPicturePathHr( "RuinLandMine-Corpse" , "遗迹地雷-残骸" ) ,
				priority = "extra-high" ,
				width = 68 ,
				height = 66 ,
				frame_count = 1 ,
				line_length = 1 ,
				variation_count = 1 ,
				direction_count = 1 ,
				scale = 0.5 ,
				shift = SIUtils.by_pixel( 2 , 5 ) ,
				axially_symmetrical = false
			}
		}
	} )
}
CreateRuinBuildings( SICommon.Types.Entities.LandMine , "RuinLandMine" , "遗迹地雷" , 1 , SIConstants_RuinSystem.LevelValueList ,
{
	localised_name = SIGen.MakeLocalisedName( SICommon.Types.Entities.LandMine , "遗迹地雷" ) ,
	localised_description = SIGen.MakeLocalisedDescription( SICommon.Types.Entities.LandMine , "遗迹地雷" ) ,
	icons =
	{
		{
			icon = SIGen.MakePicturePath( SICommon.Types.Entities.LandMine , "RuinLandMine" .. SICommon.CodeNameSuffix.ICON , "遗迹地雷" .. SICommon.ShowNameSuffix.ICON ) ,
			icon_size = 64 ,
			icon_mipmaps = 4
		}
	} ,
	icon_size = 64 ,
	icon_mipmaps = 4 ,
	flags = { SICommon.Flags.Entity.PlaceableEnemy , SICommon.Flags.Entity.NotOnMap } ,
	minable =
	{
		mining_time = 6000.0 ,
		results = {}
	} ,
	max_health = 15 ,
	corpse = SIConstants_RuinSystem.raw.Entities.RuinLandMine_Corpse ,
	dying_explosion = "land-mine-explosion" ,
	map_color = { r = 1.0 , g = 1.0 , b = 1.0 } ,
	friendly_map_color = { r = 0.4 , g = 0.4 , b = 1.0 } ,
	enemy_map_color = { r = 1.0 , g = 0.4 , b = 0.4 } ,
	is_military_target = true ,
	allow_run_time_change_of_is_military_target = true ,
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
	ammo_category = SIConstants_RuinSystem.raw.Categories.Ammo.RuinTurret ,
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
									show_in_tooltip = true ,
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
													show_in_tooltip = true ,
													lower_damage_modifier = 1.0 ,
													upper_damage_modifier = 1.0 ,
													apply_damage_to_trees = true ,
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
							show_in_tooltip = true ,
							lower_damage_modifier = 1.0 ,
							upper_damage_modifier = 1.0 ,
							apply_damage_to_trees = true ,
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
		layers =
		{
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.LandMine , "RuinLandMine" , "遗迹地雷" ) ,
				priority = "medium" ,
				width = 32 ,
				height = 32 ,
				scale = 1.0 ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.LandMine , "RuinLandMine" , "遗迹地雷" ) ,
					priority = "medium" ,
					width = 64 ,
					height = 64 ,
					scale = 0.5
				}
			}
		}
	} ,
	picture_set =
	{
		layers =
		{
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.LandMine , "RuinLandMine-Set" , "遗迹地雷-部署" ) ,
				priority = "medium" ,
				width = 32 ,
				height = 32 ,
				scale = 1.0 ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.LandMine , "RuinLandMine-Set" , "遗迹地雷-部署" ) ,
					priority = "medium" ,
					width = 64 ,
					height = 64 ,
					scale = 0.5
				}
			}
		}
	} ,
	picture_set_enemy =
	{
		layers =
		{
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.LandMine , "RuinLandMine-Set-Enemy" , "遗迹地雷-部署敌对" ) ,
				priority = "medium" ,
				width = 32 ,
				height = 32 ,
				scale = 1.0
			}
		}
	} ,
	mined_sound =
	{
		SISound.Core( "deconstruct-small" , 1 )
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
} )

-- ======================================================================
-- 遗迹机枪炮塔
-- ======================================================================
SIGen
.New( SICommon.Types.Entities.Corpse , "RuinGunTurret_Corpse" , "遗迹机枪炮塔-残骸" )
.AutoIcon()
.SetSizeScale( 2 , 2 , 0 )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceableNeutral , SICommon.Flags.Entity.NotOnMap } ,
	time_before_removed = 54000 , -- 15 分钟
	tile_width = 2 ,
	tile_height = 2 ,
	selectable_in_game = false ,
	remove_on_tile_placement = false ,
	final_render_layer = SICommon.Flags.RenderLayer.Remnants ,
	animation = SIGraphics.MakeRemnantsAnimation( 3 ,
	{
		{
			filename = SIGen.MakeSelfPicturePath( "RuinGunTurret-Corpse" , "遗迹机枪炮塔-残骸" ) ,
			priority = "extra-high" ,
			width = 126 ,
			height = 122 ,
			frame_count = 1 ,
			line_length = 1 ,
			variation_count = 1 ,
			direction_count = 1 ,
			scale = 1.0 ,
			shift = SIUtils.by_pixel( 3 , -1 ) ,
			axially_symmetrical = false ,
			hr_version =
			{
				filename = SIGen.MakeSelfPicturePathHr( "RuinGunTurret-Corpse" , "遗迹机枪炮塔-残骸" ) ,
				priority = "extra-high" ,
				width = 252 ,
				height = 242 ,
				frame_count = 1 ,
				line_length = 1 ,
				variation_count = 1 ,
				direction_count = 1 ,
				scale = 0.5 ,
				shift = SIUtils.by_pixel( 3 , -1.5 ) ,
				axially_symmetrical = false
			}
		} ,
		{
			filename = SIGen.MakeSelfPicturePath( "RuinGunTurret-Corpse-Cover" , "遗迹机枪炮塔-残骸-遮盖" ) ,
			priority = "low" ,
			width = 34 ,
			height = 32 ,
			frame_count = 1 ,
			line_length = 1 ,
			variation_count = 1 ,
			direction_count = 1 ,
			scale = 1.0 ,
			shift = SIUtils.by_pixel( -1 , -11 ) ,
			apply_runtime_tint = true ,
			hr_version =
			{
				filename = SIGen.MakeSelfPicturePathHr( "RuinGunTurret-Corpse-Cover" , "遗迹机枪炮塔-残骸-遮盖" ) ,
				priority = "low" ,
				width = 68 ,
				height = 64 ,
				frame_count = 1 ,
				line_length = 1 ,
				variation_count = 1 ,
				direction_count = 1 ,
				scale = 0.5 ,
				shift = SIUtils.by_pixel( -1 , -11 ) ,
				apply_runtime_tint = true
			}
		}
	} )
}
CreateRuinBuildings( SICommon.Types.Entities.Turret , "RuinGunTurret" , "遗迹机枪炮塔" , 2 , SIConstants_RuinSystem.LevelValueList ,
{
	localised_name = SIGen.MakeLocalisedName( SICommon.Types.Entities.Turret , "遗迹机枪炮塔" ) ,
	localised_description = SIGen.MakeLocalisedDescription( SICommon.Types.Entities.Turret , "遗迹机枪炮塔" ) ,
	icons =
	{
		{
			icon = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret" .. SICommon.CodeNameSuffix.ICON , "遗迹机枪炮塔" .. SICommon.ShowNameSuffix.ICON ) ,
			icon_size = 64 ,
			icon_mipmaps = 4
		}
	} ,
	icon_size = 64 ,
	icon_mipmaps = 4 ,
	flags = { SICommon.Flags.Entity.PlaceableEnemy } ,
	minable =
	{
		mining_time = 6000.0 ,
		results = {}
	} ,
	max_health = 190 ,
	corpse = SIConstants_RuinSystem.raw.Entities.RuinGunTurret_Corpse ,
	dying_explosion = "gun-turret-explosion" ,
	map_color = { r = 1.0 , g = 1.0 , b = 1.0 } ,
	friendly_map_color = { r = 0.4 , g = 0.4 , b = 1.0 } ,
	enemy_map_color = { r = 1.0 , g = 0.4 , b = 0.4 } ,
	is_military_target = true ,
	allow_run_time_change_of_is_military_target = true ,
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
			category = SIConstants_RuinSystem.raw.Categories.Ammo.RuinTurret ,
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
									show_in_tooltip = true ,
									lower_damage_modifier = 1.0 ,
									upper_damage_modifier = 1.0 ,
									apply_damage_to_trees = true ,
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
			SISound.Base( "fight/gun-turret-gunshot-01" , 0.4 ) ,
			SISound.Base( "fight/gun-turret-gunshot-02" , 0.4 ) ,
			SISound.Base( "fight/gun-turret-gunshot-03" , 0.4 ) ,
			SISound.Base( "fight/gun-turret-gunshot-04" , 0.4 )
		}
	} ,
	base_picture =
	{
		layers =
		{
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret" , "遗迹机枪炮塔" ) ,
				priority = "high" ,
				width = 76 ,
				height = 60 ,
				frame_count = 1 ,
				line_length = 1 ,
				direction_count = 1 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 1 , -1 ) ,
				axially_symmetrical = false ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret" , "遗迹机枪炮塔" ) ,
					priority = "high" ,
					width = 150 ,
					height = 118 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 1 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 0.5 , -1 ) ,
					axially_symmetrical = false
				}
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Cover" , "遗迹机枪炮塔-遮盖" ) ,
				priority = "medium" ,
				flags = { "mask" , "low-object" } ,
				width = 62 ,
				height = 52 ,
				frame_count = 1 ,
				line_length = 1 ,
				direction_count = 1 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 0 , -4 ) ,
				axially_symmetrical = false ,
				apply_runtime_tint = true ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Cover" , "遗迹机枪炮塔-遮盖" ) ,
					priority = "medium" ,
					flags = { "mask" , "low-object" } ,
					width = 122 ,
					height = 102 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 1 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 0 , -4.5 ) ,
					axially_symmetrical = false ,
					apply_runtime_tint = true
				}
			}
		}
	} ,
	preparing_animation =
	{
		layers =
		{
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Raise" , "遗迹机枪炮塔-升起" ) ,
				priority = "medium" ,
				run_mode = "forward" ,
				width = 66 ,
				height = 64 ,
				frame_count = 5 ,
				line_length = 5 ,
				direction_count = 4 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 0 , -26 ) ,
				axially_symmetrical = false ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Raise" , "遗迹机枪炮塔-升起" ) ,
					priority = "medium" ,
					run_mode = "forward" ,
					width = 130 ,
					height = 126 ,
					frame_count = 5 ,
					line_length = 5 ,
					direction_count = 4 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 0 , -26.5 ) ,
					axially_symmetrical = false
				}
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Raise-Cover" , "遗迹机枪炮塔-升起-遮盖" ) ,
				priority = "medium" ,
				run_mode = "forward" ,
				flags = { "mask" } ,
				width = 24 ,
				height = 32 ,
				frame_count = 5 ,
				line_length = 5 ,
				direction_count = 4 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 0 , -28 ) ,
				axially_symmetrical = false ,
				apply_runtime_tint = true ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Raise-Cover" , "遗迹机枪炮塔-升起-遮盖" ) ,
					priority = "medium" ,
					run_mode = "forward" ,
					flags = { "mask" } ,
					width = 48 ,
					height = 62 ,
					frame_count = 5 ,
					line_length = 5 ,
					direction_count = 4 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 0 , -28 ) ,
					axially_symmetrical = false ,
					apply_runtime_tint = true
				}
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Raise-Shadow" , "遗迹机枪炮塔-升起-影子" ) ,
				priority = "medium" ,
				run_mode = "forward" ,
				width = 126 ,
				height = 62 ,
				frame_count = 5 ,
				line_length = 5 ,
				direction_count = 4 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 19 , 2 ) ,
				draw_as_shadow = true ,
				axially_symmetrical = false ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Raise-Shadow" , "遗迹机枪炮塔-升起-影子" ) ,
					priority = "medium" ,
					run_mode = "forward" ,
					width = 250 ,
					height = 124 ,
					frame_count = 5 ,
					line_length = 5 ,
					direction_count = 4 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 19 , 2.5 ) ,
					draw_as_shadow = true ,
					axially_symmetrical = false
				}
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
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-1" , "遗迹机枪炮塔-射击-1" ) ,
						width_in_frames = 1 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-2" , "遗迹机枪炮塔-射击-2" ) ,
						width_in_frames = 1 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-3" , "遗迹机枪炮塔-射击-3" ) ,
						width_in_frames = 1 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-4" , "遗迹机枪炮塔-射击-4" ) ,
						width_in_frames = 1 ,
						height_in_frames = 16
					}
				} ,
				priority = "medium" ,
				width = 66 ,
				height = 66 ,
				frame_count = 1 ,
				direction_count = 64 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 0 , -27 ) ,
				axially_symmetrical = false ,
				hr_version =
				{
					stripes =
					{
						{
							filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-1" , "遗迹机枪炮塔-射击-1" ) ,
							width_in_frames = 1 ,
							height_in_frames = 16
						} ,
						{
							filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-2" , "遗迹机枪炮塔-射击-2" ) ,
							width_in_frames = 1 ,
							height_in_frames = 16
						} ,
						{
							filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-3" , "遗迹机枪炮塔-射击-3" ) ,
							width_in_frames = 1 ,
							height_in_frames = 16
						} ,
						{
							filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-4" , "遗迹机枪炮塔-射击-4" ) ,
							width_in_frames = 1 ,
							height_in_frames = 16
						}
					} ,
					priority = "medium" ,
					width = 132 ,
					height = 130 ,
					frame_count = 1 ,
					direction_count = 64 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 0 , -27.5 ) ,
					axially_symmetrical = false
				}
			} ,
			{
				stripes =
				{
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Cover-1" , "遗迹机枪炮塔-射击-遮盖-1" ) ,
						width_in_frames = 1 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Cover-2" , "遗迹机枪炮塔-射击-遮盖-2" ) ,
						width_in_frames = 1 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Cover-3" , "遗迹机枪炮塔-射击-遮盖-3" ) ,
						width_in_frames = 1 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Cover-4" , "遗迹机枪炮塔-射击-遮盖-4" ) ,
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
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 0 , -32 ) ,
				axially_symmetrical = false ,
				apply_runtime_tint = true ,
				hr_version =
				{
					stripes =
					{
						{
							filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Cover-1" , "遗迹机枪炮塔-射击-遮盖-1" ) ,
							width_in_frames = 1 ,
							height_in_frames = 16
						} ,
						{
							filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Cover-2" , "遗迹机枪炮塔-射击-遮盖-2" ) ,
							width_in_frames = 1 ,
							height_in_frames = 16
						} ,
						{
							filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Cover-3" , "遗迹机枪炮塔-射击-遮盖-3" ) ,
							width_in_frames = 1 ,
							height_in_frames = 16
						} ,
						{
							filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Cover-4" , "遗迹机枪炮塔-射击-遮盖-4" ) ,
							width_in_frames = 1 ,
							height_in_frames = 16
						}
					} ,
					priority = "medium" ,
					flags = { "mask" } ,
					width = 58 ,
					height = 54 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 64 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 0 , -32.5 ) ,
					axially_symmetrical = false ,
					apply_runtime_tint = true
				}
			} ,
			{
				stripes =
				{
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Shadow-1" , "遗迹机枪炮塔-射击-影子-1" ) ,
						width_in_frames = 1 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Shadow-2" , "遗迹机枪炮塔-射击-影子-2" ) ,
						width_in_frames = 1 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Shadow-3" , "遗迹机枪炮塔-射击-影子-3" ) ,
						width_in_frames = 1 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Shadow-4" , "遗迹机枪炮塔-射击-影子-4" ) ,
						width_in_frames = 1 ,
						height_in_frames = 16
					}
				} ,
				priority = "medium" ,
				width = 126 ,
				height = 62 ,
				frame_count = 1 ,
				direction_count = 64 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 23 , 2 ) ,
				draw_as_shadow = true ,
				axially_symmetrical = false ,
				hr_version =
				{
					stripes =
					{
						{
							filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Shadow-1" , "遗迹机枪炮塔-射击-影子-1" ) ,
							width_in_frames = 1 ,
							height_in_frames = 16
						} ,
						{
							filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Shadow-2" , "遗迹机枪炮塔-射击-影子-2" ) ,
							width_in_frames = 1 ,
							height_in_frames = 16
						} ,
						{
							filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Shadow-3" , "遗迹机枪炮塔-射击-影子-3" ) ,
							width_in_frames = 1 ,
							height_in_frames = 16
						} ,
						{
							filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Shadow-4" , "遗迹机枪炮塔-射击-影子-4" ) ,
							width_in_frames = 1 ,
							height_in_frames = 16
						}
					} ,
					priority = "medium" ,
					width = 250 ,
					height = 124 ,
					frame_count = 1 ,
					direction_count = 64 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 22 , 2.5 ) ,
					draw_as_shadow = true ,
					axially_symmetrical = false
				}
			}
		}
	} ,
	folding_animation =
	{
		layers =
		{
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Raise" , "遗迹机枪炮塔-升起" ) ,
				priority = "medium" ,
				run_mode = "backward" ,
				width = 66 ,
				height = 64 ,
				frame_count = 5 ,
				line_length = 5 ,
				direction_count = 4 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 0 , -26 ) ,
				axially_symmetrical = false ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Raise" , "遗迹机枪炮塔-升起" ) ,
					priority = "medium" ,
					run_mode = "backward" ,
					width = 130 ,
					height = 126 ,
					frame_count = 5 ,
					line_length = 5 ,
					direction_count = 4 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 0 , -26.5 ) ,
					axially_symmetrical = false
				}
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Raise-Cover" , "遗迹机枪炮塔-升起-遮盖" ) ,
				priority = "medium" ,
				run_mode = "backward" ,
				flags = { "mask" } ,
				width = 24 ,
				height = 32 ,
				frame_count = 5 ,
				line_length = 5 ,
				direction_count = 4 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 0 , -28 ) ,
				axially_symmetrical = false ,
				apply_runtime_tint = true ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Raise-Cover" , "遗迹机枪炮塔-升起-遮盖" ) ,
					priority = "medium" ,
					run_mode = "backward" ,
					flags = { "mask" } ,
					width = 48 ,
					height = 62 ,
					frame_count = 5 ,
					line_length = 5 ,
					direction_count = 4 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 0 , -28 ) ,
					axially_symmetrical = false ,
					apply_runtime_tint = true
				}
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Raise-Shadow" , "遗迹机枪炮塔-升起-影子" ) ,
				priority = "medium" ,
				run_mode = "backward" ,
				width = 126 ,
				height = 62 ,
				frame_count = 5 ,
				line_length = 5 ,
				direction_count = 4 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 19 , 2 ) ,
				draw_as_shadow = true ,
				axially_symmetrical = false ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Raise-Shadow" , "遗迹机枪炮塔-升起-影子" ) ,
					priority = "medium" ,
					run_mode = "backward" ,
					width = 250 ,
					height = 124 ,
					frame_count = 5 ,
					line_length = 5 ,
					direction_count = 4 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 19 , 2.5 ) ,
					draw_as_shadow = true ,
					axially_symmetrical = false
				}
			}
		}
	} ,
	folded_animation =
	{
		layers =
		{
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Raise" , "遗迹机枪炮塔-升起" ) ,
				priority = "medium" ,
				run_mode = "forward" ,
				width = 66 ,
				height = 64 ,
				frame_count = 1 ,
				line_length = 1 ,
				direction_count = 4 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 0 , -26 ) ,
				axially_symmetrical = false ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Raise" , "遗迹机枪炮塔-升起" ) ,
					priority = "medium" ,
					run_mode = "forward" ,
					width = 130 ,
					height = 126 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 4 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 0 , -26.5 ) ,
					axially_symmetrical = false
				}
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Raise-Cover" , "遗迹机枪炮塔-升起-遮盖" ) ,
				priority = "medium" ,
				run_mode = "forward" ,
				flags = { "mask" } ,
				width = 24 ,
				height = 32 ,
				frame_count = 1 ,
				line_length = 1 ,
				direction_count = 4 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 0 , -28 ) ,
				axially_symmetrical = false ,
				apply_runtime_tint = true ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Raise-Cover" , "遗迹机枪炮塔-升起-遮盖" ) ,
					priority = "medium" ,
					run_mode = "forward" ,
					flags = { "mask" } ,
					width = 48 ,
					height = 62 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 4 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 0 , -28 ) ,
					axially_symmetrical = false ,
					apply_runtime_tint = true
				}
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Raise-Shadow" , "遗迹机枪炮塔-升起-影子" ) ,
				priority = "medium" ,
				run_mode = "forward" ,
				width = 126 ,
				height = 62 ,
				frame_count = 1 ,
				line_length = 1 ,
				direction_count = 4 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 19 , 2 ) ,
				draw_as_shadow = true ,
				axially_symmetrical = false ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Raise-Shadow" , "遗迹机枪炮塔-升起-影子" ) ,
					priority = "medium" ,
					run_mode = "forward" ,
					width = 250 ,
					height = 124 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 4 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 19 , 2.5 ) ,
					draw_as_shadow = true ,
					axially_symmetrical = false
				}
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
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-1" , "遗迹机枪炮塔-射击-1" ) ,
						width_in_frames = 2 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-2" , "遗迹机枪炮塔-射击-2" ) ,
						width_in_frames = 2 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-3" , "遗迹机枪炮塔-射击-3" ) ,
						width_in_frames = 2 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-4" , "遗迹机枪炮塔-射击-4" ) ,
						width_in_frames = 2 ,
						height_in_frames = 16
					}
				} ,
				priority = "medium" ,
				width = 66 ,
				height = 66 ,
				frame_count = 2 ,
				direction_count = 64 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 0 , -27 ) ,
				axially_symmetrical = false ,
				hr_version =
				{
					stripes =
					{
						{
							filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-1" , "遗迹机枪炮塔-射击-1" ) ,
							width_in_frames = 2 ,
							height_in_frames = 16
						} ,
						{
							filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-2" , "遗迹机枪炮塔-射击-2" ) ,
							width_in_frames = 2 ,
							height_in_frames = 16
						} ,
						{
							filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-3" , "遗迹机枪炮塔-射击-3" ) ,
							width_in_frames = 2 ,
							height_in_frames = 16
						} ,
						{
							filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-4" , "遗迹机枪炮塔-射击-4" ) ,
							width_in_frames = 2 ,
							height_in_frames = 16
						}
					} ,
					priority = "medium" ,
					width = 132 ,
					height = 130 ,
					frame_count = 2 ,
					direction_count = 64 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 0 , -27.5 ) ,
					axially_symmetrical = false
				}
			} ,
			{
				stripes =
				{
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Cover-1" , "遗迹机枪炮塔-射击-遮盖-1" ) ,
						width_in_frames = 2 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Cover-2" , "遗迹机枪炮塔-射击-遮盖-2" ) ,
						width_in_frames = 2 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Cover-3" , "遗迹机枪炮塔-射击-遮盖-3" ) ,
						width_in_frames = 2 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Cover-4" , "遗迹机枪炮塔-射击-遮盖-4" ) ,
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
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 0 , -32 ) ,
				axially_symmetrical = false ,
				apply_runtime_tint = true ,
				hr_version =
				{
					stripes =
					{
						{
							filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Cover-1" , "遗迹机枪炮塔-射击-遮盖-1" ) ,
							width_in_frames = 2 ,
							height_in_frames = 16
						} ,
						{
							filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Cover-2" , "遗迹机枪炮塔-射击-遮盖-2" ) ,
							width_in_frames = 2 ,
							height_in_frames = 16
						} ,
						{
							filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Cover-3" , "遗迹机枪炮塔-射击-遮盖-3" ) ,
							width_in_frames = 2 ,
							height_in_frames = 16
						} ,
						{
							filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Cover-4" , "遗迹机枪炮塔-射击-遮盖-4" ) ,
							width_in_frames = 2 ,
							height_in_frames = 16
						}
					} ,
					priority = "medium" ,
					flags = { "mask" } ,
					width = 58 ,
					height = 54 ,
					frame_count = 2 ,
					line_length = 2 ,
					direction_count = 64 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 0 , -32.5 ) ,
					axially_symmetrical = false ,
					apply_runtime_tint = true
				}
			} ,
			{
				stripes =
				{
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Shadow-1" , "遗迹机枪炮塔-射击-影子-1" ) ,
						width_in_frames = 2 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Shadow-2" , "遗迹机枪炮塔-射击-影子-2" ) ,
						width_in_frames = 2 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Shadow-3" , "遗迹机枪炮塔-射击-影子-3" ) ,
						width_in_frames = 2 ,
						height_in_frames = 16
					} ,
					{
						filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Shadow-4" , "遗迹机枪炮塔-射击-影子-4" ) ,
						width_in_frames = 2 ,
						height_in_frames = 16
					}
				} ,
				priority = "medium" ,
				width = 126 ,
				height = 62 ,
				frame_count = 2 ,
				direction_count = 64 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 23 , 2 ) ,
				draw_as_shadow = true ,
				axially_symmetrical = false ,
				hr_version =
				{
					stripes =
					{
						{
							filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Shadow-1" , "遗迹机枪炮塔-射击-影子-1" ) ,
							width_in_frames = 2 ,
							height_in_frames = 16
						} ,
						{
							filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Shadow-2" , "遗迹机枪炮塔-射击-影子-2" ) ,
							width_in_frames = 2 ,
							height_in_frames = 16
						} ,
						{
							filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Shadow-3" , "遗迹机枪炮塔-射击-影子-3" ) ,
							width_in_frames = 2 ,
							height_in_frames = 16
						} ,
						{
							filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinGunTurret-Shoot-Shadow-4" , "遗迹机枪炮塔-射击-影子-4" ) ,
							width_in_frames = 2 ,
							height_in_frames = 16
						}
					} ,
					priority = "medium" ,
					width = 250 ,
					height = 124 ,
					frame_count = 2 ,
					direction_count = 64 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 22 , 2.5 ) ,
					draw_as_shadow = true ,
					axially_symmetrical = false
				}
			}
		}
	} ,
	water_reflection =
	{
		rotate = false ,
		orientation_to_variation = false ,
		pictures =
		{
			filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinGunTurret-Reflect" , "遗迹机枪炮塔-反射" ) ,
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
		SISound.Core( "deconstruct-small" , 1 )
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
	} ,
	preparing_sound =
	{
		SISound.Base( "fight/gun-turret-activate-01" , 0.3 ) ,
		SISound.Base( "fight/gun-turret-activate-02" , 0.3 ) ,
		SISound.Base( "fight/gun-turret-activate-03" , 0.3 ) ,
		SISound.Base( "fight/gun-turret-activate-04" , 0.3 )
	} ,
	folding_sound =
	{
		SISound.Base( "fight/gun-turret-deactivate-01" , 0.3 ) ,
		SISound.Base( "fight/gun-turret-deactivate-02" , 0.3 ) ,
		SISound.Base( "fight/gun-turret-deactivate-03" , 0.3 ) ,
		SISound.Base( "fight/gun-turret-deactivate-04" , 0.3 )
	}
} )

-- ======================================================================
-- 遗迹激光炮塔
-- ======================================================================
SIGen
.New( SICommon.Types.Entities.Beam , "RuinLaserTurret_Beam" , "遗迹激光炮塔-激光" )
.Append
{
	flags = { SICommon.Flags.Entity.NotOnMap } ,
	selectable_in_game = false ,
	width = 2.5 ,
	damage_interval = 15 ,
	random_target_offset = true ,
	transparent_start_end_animations = true ,
	action_triggered_automatically = true ,
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
							show_in_tooltip = true ,
							lower_damage_modifier = 1.0 ,
							upper_damage_modifier = 1.0 ,
							apply_damage_to_trees = true ,
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
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "RuinLaserTurret-Beam-Body" , "遗迹激光炮塔-激光-身体" ) ,
				priority = "medium" ,
				blend_mode = "additive" ,
				flags = { "trilinear-filtering" } ,
				width = 64 ,
				height = 12 ,
				frame_count = 8 ,
				line_length = 8 ,
				animation_speed = 0.5 ,
				scale = 0.5
			}
		}
	} ,
	head =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "RuinLaserTurret-Beam-Body" , "遗迹激光炮塔-激光-身体" ) ,
				priority = "medium" ,
				blend_mode = "additive" ,
				flags = { "trilinear-filtering" } ,
				width = 64 ,
				height = 12 ,
				frame_count = 8 ,
				line_length = 8 ,
				animation_speed = 0.5 ,
				scale = 0.5
			}
		}
	} ,
	tail =
	{
		layers =
		{
			{
				filename = SIGen.MakeSelfPicturePath( "RuinLaserTurret-Beam-Tail" , "遗迹激光炮塔-激光-尾部" ) ,
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
			}
		}
	} ,
	light_animations =
	{
		body =
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "RuinLaserTurret-Beam-Body-Light" , "遗迹激光炮塔-激光-身体-光效" ) ,
					priority = "medium" ,
					width = 64 ,
					height = 12 ,
					frame_count = 8 ,
					line_length = 8 ,
					animation_speed = 0.5 ,
					scale = 0.5
				}
			}
		} ,
		head =
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "RuinLaserTurret-Beam-Body-Light" , "遗迹激光炮塔-激光-身体-光效" ) ,
					priority = "medium" ,
					width = 64 ,
					height = 12 ,
					frame_count = 8 ,
					line_length = 8 ,
					animation_speed = 0.5 ,
					scale = 0.5
				}
			}
		} ,
		tail =
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "RuinLaserTurret-Beam-Tail" , "遗迹激光炮塔-激光-尾部-光效" ) ,
					priority = "medium" ,
					width = 110 ,
					height = 62 ,
					frame_count = 8 ,
					line_length = 8 ,
					animation_speed = 0.5 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 11.5 , 1 )
				}
			}
		}
	} ,
	ground_light_animations =
	{
		body =
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "RuinLaserTurret-Beam-Ground-Body" , "遗迹激光炮塔-激光-地面-身体" ) ,
					priority = "medium" ,
					width = 64 ,
					height = 256 ,
					frame_count = 1 ,
					line_length = 1 ,
					repeat_count = 8 ,
					animation_speed = 0.5 ,
					scale = 0.5 ,
					tint = { r = 0.05 , g = 0.50 , b = 0.05 }
				}
			}
		} ,
		head =
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "RuinLaserTurret-Beam-Ground-Head" , "遗迹激光炮塔-激光-地面-头部" ) ,
					priority = "medium" ,
					width = 256 ,
					height = 256 ,
					frame_count = 1 ,
					line_length = 1 ,
					repeat_count = 8 ,
					animation_speed = 0.5 ,
					scale = 0.5 ,
					tint = { r = 0.05 , g = 0.50 , b = 0.05 } ,
					shift = SIUtils.by_pixel( -32 , 0 )
				}
			}
		} ,
		tail =
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "RuinLaserTurret-Beam-Ground-Tail" , "遗迹激光炮塔-激光-地面-尾部" ) ,
					priority = "medium" ,
					width = 256 ,
					height = 256 ,
					frame_count = 1 ,
					line_length = 1 ,
					repeat_count = 8 ,
					animation_speed = 0.5 ,
					scale = 0.5 ,
					tint = { r = 0.05 , g = 0.50 , b = 0.05 } ,
					shift = SIUtils.by_pixel( 32 , 0 )
				}
			}
		}
	} ,
	working_sound =
	{
		sound =
		{
			SISound.Base( "fight/laser-beam" , 0.75 )
		} ,
		max_sounds_per_type = 1
	}
}
.New( SICommon.Types.Entities.Corpse , "RuinLaserTurret_Corpse" , "遗迹激光炮塔-残骸" )
.AutoIcon()
.SetSizeScale( 2 , 2 , 0 )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceableNeutral , SICommon.Flags.Entity.NotOnMap } ,
	time_before_removed = 54000 , -- 15 分钟
	tile_width = 2 ,
	tile_height = 2 ,
	selectable_in_game = false ,
	remove_on_tile_placement = false ,
	final_render_layer = SICommon.Flags.RenderLayer.Remnants ,
	animation = SIGraphics.MakeRemnantsAnimation( 3 ,
	{
		{
			filename = SIGen.MakeSelfPicturePath( "RuinLaserTurret-Corpse" , "遗迹激光炮塔-残骸" ) ,
			priority = "extra-high" ,
			width = 100 ,
			height = 98 ,
			frame_count = 1 ,
			line_length = 1 ,
			variation_count = 1 ,
			direction_count = 1 ,
			scale = 1.0 ,
			shift = SIUtils.by_pixel( 3 , -2 ) ,
			axially_symmetrical = false ,
			hr_version =
			{
				filename = SIGen.MakeSelfPicturePathHr( "RuinLaserTurret-Corpse" , "遗迹激光炮塔-残骸" ) ,
				priority = "extra-high" ,
				width = 198 ,
				height = 194 ,
				frame_count = 1 ,
				line_length = 1 ,
				variation_count = 1 ,
				direction_count = 1 ,
				scale = 0.5 ,
				shift = SIUtils.by_pixel( 2.5 , -2 ) ,
				axially_symmetrical = false
			}
		} ,
		{
			filename = SIGen.MakeSelfPicturePath( "RuinLaserTurret-Corpse-Cover" , "遗迹激光炮塔-残骸-遮盖" ) ,
			priority = "low" ,
			width = 58 ,
			height = 48 ,
			frame_count = 1 ,
			line_length = 1 ,
			variation_count = 1 ,
			direction_count = 1 ,
			scale = 1.0 ,
			shift = SIUtils.by_pixel( 4 , -2 ) ,
			apply_runtime_tint = true ,
			hr_version =
			{
				filename = SIGen.MakeSelfPicturePathHr( "RuinLaserTurret-Corpse-Cover" , "遗迹激光炮塔-残骸-遮盖" ) ,
				priority = "low" ,
				width = 114 ,
				height = 94 ,
				frame_count = 1 ,
				line_length = 1 ,
				variation_count = 1 ,
				direction_count = 1 ,
				scale = 0.5 ,
				shift = SIUtils.by_pixel( 4 , -2.5 ) ,
				apply_runtime_tint = true
			}
		}
	} )
}
CreateRuinBuildings( SICommon.Types.Entities.Turret , "RuinLaserTurret" , "遗迹激光炮塔" , 2 , SIConstants_RuinSystem.LevelValueList ,
{
	localised_name = SIGen.MakeLocalisedName( SICommon.Types.Entities.Turret , "遗迹激光炮塔" ) ,
	localised_description = SIGen.MakeLocalisedDescription( SICommon.Types.Entities.Turret , "遗迹激光炮塔" ) ,
	icons =
	{
		{
			icon = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinLaserTurret" .. SICommon.CodeNameSuffix.ICON , "遗迹激光炮塔" .. SICommon.ShowNameSuffix.ICON ) ,
			icon_size = 64 ,
			icon_mipmaps = 4
		}
	} ,
	icon_size = 64 ,
	icon_mipmaps = 4 ,
	flags = { SICommon.Flags.Entity.PlaceableEnemy } ,
	minable =
	{
		mining_time = 6000.0 ,
		results = {}
	} ,
	max_health = 250 ,
	corpse = SIConstants_RuinSystem.raw.Entities.RuinLaserTurret_Corpse ,
	dying_explosion = "laser-turret-explosion" ,
	map_color = { r = 1.0 , g = 1.0 , b = 1.0 } ,
	friendly_map_color = { r = 0.4 , g = 0.4 , b = 1.0 } ,
	enemy_map_color = { r = 1.0 , g = 0.4 , b = 0.4 } ,
	is_military_target = true ,
	allow_run_time_change_of_is_military_target = true ,
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
			category = SIConstants_RuinSystem.raw.Categories.Ammo.RuinTurret ,
			action =
			{
				{
					type = "direct" ,
					action_delivery =
					{
						{
							type = "beam" ,
							beam = SIConstants_RuinSystem.raw.Entities.RuinLaserTurret_Beam ,
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
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinLaserTurret" , "遗迹激光炮塔" ) ,
				priority = "high" ,
				width = 70 ,
				height = 52 ,
				frame_count = 1 ,
				line_length = 1 ,
				direction_count = 1 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 0 , 2 ) ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinLaserTurret" , "遗迹激光炮塔" ) ,
					priority = "high" ,
					width = 138 ,
					height = 104 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 1 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( -0.5 , 2 )
				}
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinLaserTurret-Shadow" , "遗迹激光炮塔-影子" ) ,
				priority = "medium" ,
				width = 66 ,
				height = 42 ,
				frame_count = 1 ,
				line_length = 1 ,
				direction_count = 1 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 6 , 3 ) ,
				draw_as_shadow = true ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinLaserTurret-Shadow" , "遗迹激光炮塔-影子" ) ,
					priority = "medium" ,
					width = 132 ,
					height = 82 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 1 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 6 , 3 ) ,
					draw_as_shadow = true
				}
			}
		}
	} ,
	preparing_animation =
	{
		layers =
		{
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinLaserTurret-Raise" , "遗迹激光炮塔-升起" ) ,
				priority = "medium" ,
				run_mode = "forward" ,
				width = 66 ,
				height = 64 ,
				frame_count = 15 ,
				line_length = 15 ,
				direction_count = 4 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 0 , -32 ) ,
				axially_symmetrical = false ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinLaserTurret-Raise" , "遗迹激光炮塔-升起" ) ,
					priority = "medium" ,
					run_mode = "forward" ,
					width = 130 ,
					height = 126 ,
					frame_count = 15 ,
					line_length = 15 ,
					direction_count = 4 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 0 , -32.5 ) ,
					axially_symmetrical = false
				}
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinLaserTurret-Raise-Cover" , "遗迹激光炮塔-升起-遮盖" ) ,
				priority = "medium" ,
				run_mode = "forward" ,
				flags = { "mask" } ,
				width = 44 ,
				height = 40 ,
				frame_count = 15 ,
				line_length = 15 ,
				direction_count = 4 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 0 , -43 ) ,
				axially_symmetrical = false ,
				apply_runtime_tint = true ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinLaserTurret-Raise-Cover" , "遗迹激光炮塔-升起-遮盖" ) ,
					priority = "medium" ,
					run_mode = "forward" ,
					flags = { "mask" } ,
					width = 86 ,
					height = 80 ,
					frame_count = 15 ,
					line_length = 15 ,
					direction_count = 4 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 0 , -43 ) ,
					axially_symmetrical = false ,
					apply_runtime_tint = true
				}
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinLaserTurret-Raise-Shadow" , "遗迹激光炮塔-升起-影子" ) ,
				priority = "medium" ,
				run_mode = "forward" ,
				width = 92 ,
				height = 50 ,
				frame_count = 15 ,
				line_length = 15 ,
				direction_count = 4 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 47 , 3 ) ,
				draw_as_shadow = true ,
				axially_symmetrical = false ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinLaserTurret-Raise-Shadow" , "遗迹激光炮塔-升起-影子" ) ,
					priority = "medium" ,
					run_mode = "forward" ,
					width = 182 ,
					height = 96 ,
					frame_count = 15 ,
					line_length = 15 ,
					direction_count = 4 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 47 , 2.5 ) ,
					draw_as_shadow = true ,
					axially_symmetrical = false
				}
			}
		}
	} ,
	prepared_animation =
	{
		layers =
		{
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinLaserTurret-Shoot" , "遗迹激光炮塔-射击" ) ,
				priority = "medium" ,
				width = 64 ,
				height = 60 ,
				frame_count = 1 ,
				line_length = 8 ,
				direction_count = 64 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 0 , -35 ) ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinLaserTurret-Shoot" , "遗迹激光炮塔-射击" ) ,
					priority = "medium" ,
					width = 126 ,
					height = 120 ,
					frame_count = 1 ,
					line_length = 8 ,
					direction_count = 64 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 0 , -35 )
				}
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinLaserTurret-Shoot-Cover" , "遗迹激光炮塔-射击-遮盖" ) ,
				priority = "medium" ,
				flags = { "mask" } ,
				width = 46 ,
				height = 42 ,
				frame_count = 1 ,
				line_length = 8 ,
				direction_count = 64 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 0 , -43 ) ,
				apply_runtime_tint = true ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinLaserTurret-Shoot-Cover" , "遗迹激光炮塔-射击-遮盖" ) ,
					priority = "medium" ,
					flags = { "mask" } ,
					width = 92 ,
					height = 80 ,
					frame_count = 1 ,
					line_length = 8 ,
					direction_count = 64 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 0 , -43.5 ) ,
					apply_runtime_tint = true
				}
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinLaserTurret-Shoot-Shadow" , "遗迹激光炮塔-射击-影子" ) ,
				priority = "medium" ,
				width = 86 ,
				height = 46 ,
				frame_count = 1 ,
				line_length = 8 ,
				direction_count = 64 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 51 , 2 ) ,
				draw_as_shadow = true ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinLaserTurret-Shoot-Shadow" , "遗迹激光炮塔-射击-影子" ) ,
					priority = "medium" ,
					width = 170 ,
					height = 92 ,
					frame_count = 1 ,
					line_length = 8 ,
					direction_count = 64 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 50.5 , 2.5 ) ,
					draw_as_shadow = true
				}
			}
		}
	} ,
	folding_animation =
	{
		layers =
		{
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinLaserTurret-Raise" , "遗迹激光炮塔-升起" ) ,
				priority = "medium" ,
				run_mode = "backward" ,
				width = 66 ,
				height = 64 ,
				frame_count = 15 ,
				line_length = 15 ,
				direction_count = 4 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 0 , -32 ) ,
				axially_symmetrical = false ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinLaserTurret-Raise" , "遗迹激光炮塔-升起" ) ,
					priority = "medium" ,
					run_mode = "backward" ,
					width = 130 ,
					height = 126 ,
					frame_count = 15 ,
					line_length = 15 ,
					direction_count = 4 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 0 , -32.5 ) ,
					axially_symmetrical = false
				}
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinLaserTurret-Raise-Cover" , "遗迹激光炮塔-升起-遮盖" ) ,
				priority = "medium" ,
				run_mode = "backward" ,
				flags = { "mask" } ,
				width = 44 ,
				height = 40 ,
				frame_count = 15 ,
				line_length = 15 ,
				direction_count = 4 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 0 , -43 ) ,
				axially_symmetrical = false ,
				apply_runtime_tint = true ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinLaserTurret-Raise-Cover" , "遗迹激光炮塔-升起-遮盖" ) ,
					priority = "medium" ,
					run_mode = "backward" ,
					flags = { "mask" } ,
					width = 86 ,
					height = 80 ,
					frame_count = 15 ,
					line_length = 15 ,
					direction_count = 4 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 0 , -43 ) ,
					axially_symmetrical = false ,
					apply_runtime_tint = true
				}
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinLaserTurret-Raise-Shadow" , "遗迹激光炮塔-升起-影子" ) ,
				priority = "medium" ,
				run_mode = "backward" ,
				width = 92 ,
				height = 50 ,
				frame_count = 15 ,
				line_length = 15 ,
				direction_count = 4 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 47 , 3 ) ,
				draw_as_shadow = true ,
				axially_symmetrical = false ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinLaserTurret-Raise-Shadow" , "遗迹激光炮塔-升起-影子" ) ,
					priority = "medium" ,
					run_mode = "backward" ,
					width = 182 ,
					height = 96 ,
					frame_count = 15 ,
					line_length = 15 ,
					direction_count = 4 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 47 , 2.5 ) ,
					draw_as_shadow = true ,
					axially_symmetrical = false
				}
			}
		}
	} ,
	folded_animation =
	{
		layers =
		{
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinLaserTurret-Raise" , "遗迹激光炮塔-升起" ) ,
				priority = "medium" ,
				run_mode = "forward" ,
				width = 66 ,
				height = 64 ,
				frame_count = 1 ,
				line_length = 1 ,
				direction_count = 4 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 0 , -32 ) ,
				axially_symmetrical = false ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinLaserTurret-Raise" , "遗迹激光炮塔-升起" ) ,
					priority = "medium" ,
					run_mode = "forward" ,
					width = 130 ,
					height = 126 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 4 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 0 , -32.5 ) ,
					axially_symmetrical = false
				}
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinLaserTurret-Raise-Cover" , "遗迹激光炮塔-升起-遮盖" ) ,
				priority = "medium" ,
				run_mode = "forward" ,
				flags = { "mask" } ,
				width = 44 ,
				height = 40 ,
				frame_count = 1 ,
				line_length = 1 ,
				direction_count = 4 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 0 , -43 ) ,
				axially_symmetrical = false ,
				apply_runtime_tint = true ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinLaserTurret-Raise-Cover" , "遗迹激光炮塔-升起-遮盖" ) ,
					priority = "medium" ,
					run_mode = "forward" ,
					flags = { "mask" } ,
					width = 86 ,
					height = 80 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 4 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 0 , -43 ) ,
					axially_symmetrical = false ,
					apply_runtime_tint = true
				}
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinLaserTurret-Raise-Shadow" , "遗迹激光炮塔-升起-影子" ) ,
				priority = "medium" ,
				run_mode = "forward" ,
				width = 92 ,
				height = 50 ,
				frame_count = 1 ,
				line_length = 1 ,
				direction_count = 4 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 47 , 3 ) ,
				draw_as_shadow = true ,
				axially_symmetrical = false ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinLaserTurret-Raise-Shadow" , "遗迹激光炮塔-升起-影子" ) ,
					priority = "medium" ,
					run_mode = "forward" ,
					width = 182 ,
					height = 96 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 4 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 47 , 2.5 ) ,
					draw_as_shadow = true ,
					axially_symmetrical = false
				}
			}
		}
	} ,
	glow_light_intensity = 0.5 ,
	energy_glow_animation =
	{
		layers =
		{
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinLaserTurret-Shoot-Light" , "遗迹激光炮塔-射击-光效" ) ,
				priority = "medium" ,
				blend_mode = "additive" ,
				width = 62 ,
				height = 58 ,
				frame_count = 1 ,
				line_length = 8 ,
				direction_count = 64 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 0 , -35 ) ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinLaserTurret-Shoot-Light" , "遗迹激光炮塔-射击-光效" ) ,
					priority = "medium" ,
					blend_mode = "additive" ,
					width = 122 ,
					height = 116 ,
					frame_count = 1 ,
					line_length = 8 ,
					direction_count = 64 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( -0.5 , -35 )
				}
			}
		}
	} ,
	water_reflection =
	{
		rotate = false ,
		orientation_to_variation = false ,
		pictures =
		{
			filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinLaserTurret-Reflect" , "遗迹激光炮塔-反射" ) ,
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
		SISound.Core( "deconstruct-small" , 1 )
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
	} ,
	preparing_sound =
	{
		SISound.Base( "fight/laser-turret-activate-01" , 0.3 ) ,
		SISound.Base( "fight/laser-turret-activate-02" , 0.3 ) ,
		SISound.Base( "fight/laser-turret-activate-03" , 0.3 )
	} ,
	folding_sound =
	{
		SISound.Base( "fight/laser-turret-deactivate-01" , 0.3 ) ,
		SISound.Base( "fight/laser-turret-deactivate-02" , 0.3 ) ,
		SISound.Base( "fight/laser-turret-deactivate-03" , 0.3 ) ,
		SISound.Base( "fight/laser-turret-deactivate-04" , 0.3 )
	}
} )

-- ======================================================================
-- 遗迹喷火炮塔
-- ======================================================================
local function RuinFlameTurretGunAnimationSingle( shift , attacking )
	local layers =
	{
		{
			filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinFlameTurret-Gun" , "遗迹喷火炮塔-枪" ) ,
			priority = "medium" ,
			width = 82 ,
			height = 66 ,
			frame_count = 1 ,
			line_length = 8 ,
			direction_count = 64 ,
			scale = 1.0 ,
			shift = SIUtils.by_pixel( -2 , -26 ) ,
			axially_symmetrical = false ,
			counterclockwise = true ,
			hr_version =
			{
				filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinFlameTurret-Gun" , "遗迹喷火炮塔-枪" ) ,
				priority = "medium" ,
				width = 158 ,
				height = 128 ,
				frame_count = 1 ,
				line_length = 8 ,
				direction_count = 64 ,
				scale = 0.5 ,
				shift = SIUtils.by_pixel( -1 , -25 ) ,
				axially_symmetrical = false ,
				counterclockwise = true
			}
		}
	}
	if attacking then
		table.insert( layers ,
		{
			filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinFlameTurret-Gun-Active" , "遗迹喷火炮塔-枪-激活" ) ,
			priority = "medium" ,
			blend_mode = "additive" ,
			width = 82 ,
			height = 66 ,
			frame_count = 1 ,
			line_length = 8 ,
			direction_count = 64 ,
			scale = 1.0 ,
			tint = SIUtils.premul_color{ 1 , 1 , 1 , 0.5 } ,
			shift = SIUtils.by_pixel( -2 , -26 ) ,
			axially_symmetrical = false ,
			counterclockwise = true ,
			hr_version =
			{
				filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinFlameTurret-Gun-Active" , "遗迹喷火炮塔-枪-激活" ) ,
				priority = "medium" ,
				blend_mode = "additive" ,
				width = 158 ,
				height = 126 ,
				frame_count = 1 ,
				line_length = 8 ,
				direction_count = 64 ,
				scale = 0.5 ,
				tint = SIUtils.premul_color{ 1 , 1 , 1 , 0.5 } ,
				shift = SIUtils.by_pixel( -1 , -25 ) ,
				axially_symmetrical = false ,
				counterclockwise = true
			}
		} )
		table.insert( layers ,
		{
			filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinFlameTurret-Gun-Active" , "遗迹喷火炮塔-枪-激活" ) ,
			priority = "medium" ,
			blend_mode = "additive" ,
			width = 82 ,
			height = 66 ,
			frame_count = 1 ,
			line_length = 8 ,
			direction_count = 64 ,
			scale = 1.0 ,
			tint = SIUtils.premul_color{ 1 , 1 , 1 , 0.5 } ,
			shift = SIUtils.by_pixel( -2 , -26 ) ,
			draw_as_light = true ,
			axially_symmetrical = false ,
			counterclockwise = true ,
			hr_version =
			{
				filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinFlameTurret-Gun-Active" , "遗迹喷火炮塔-枪-激活" ) ,
				priority = "medium" ,
				blend_mode = "additive" ,
				width = 158 ,
				height = 126 ,
				frame_count = 1 ,
				line_length = 8 ,
				direction_count = 64 ,
				scale = 0.5 ,
				tint = SIUtils.premul_color{ 1 , 1 , 1 , 0.5 } ,
				shift = SIUtils.by_pixel( -1 , -25 ) ,
				draw_as_light = true ,
				axially_symmetrical = false ,
				counterclockwise = true
			}
		} )
	end
	table.insert( layers ,
	{
		filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinFlameTurret-Gun-Cover" , "遗迹喷火炮塔-枪-遮盖" ) ,
		priority = "medium" ,
		flags = { "mask" } ,
		width = 74 ,
		height = 56 ,
		frame_count = 1 ,
		line_length = 8 ,
		direction_count = 64 ,
		scale = 1.0 ,
		shift = SIUtils.by_pixel( -2 , -28 ) ,
		axially_symmetrical = false ,
		apply_runtime_tint = true ,
		counterclockwise = true ,
		hr_version =
		{
			filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinFlameTurret-Gun-Cover" , "遗迹喷火炮塔-枪-遮盖" ) ,
			priority = "medium" ,
			flags = { "mask" } ,
			width = 144 ,
			height = 112 ,
			frame_count = 1 ,
			line_length = 8 ,
			direction_count = 64 ,
			scale = 0.5 ,
			shift = SIUtils.by_pixel( -1 , -28 ) ,
			axially_symmetrical = false ,
			apply_runtime_tint = true ,
			counterclockwise = true
		}
	} )
	table.insert( layers ,
	{
		filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinFlameTurret-Gun-Shadow" , "遗迹喷火炮塔-枪-影子" ) ,
		priority = "medium" ,
		width = 90 ,
		height = 56 ,
		frame_count = 1 ,
		line_length = 8 ,
		direction_count = 64 ,
		scale = 1.0 ,
		shift = SIUtils.by_pixel( 32 , 0 ) ,
		draw_as_shadow = true ,
		axially_symmetrical = false ,
		counterclockwise = true ,
		hr_version =
		{
			filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinFlameTurret-Gun-Shadow" , "遗迹喷火炮塔-枪-影子" ) ,
			priority = "medium" ,
			width = 182 ,
			height = 116 ,
			frame_count = 1 ,
			line_length = 8 ,
			direction_count = 64 ,
			scale = 0.5 ,
			shift = SIUtils.by_pixel( 31 , -1 ) ,
			draw_as_shadow = true ,
			axially_symmetrical = false ,
			counterclockwise = true
		}
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
			filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinFlameTurret-Gun-Expand" , "遗迹喷火炮塔-枪-扩展" ) ,
			priority = "medium" ,
			run_mode = runMode or "forward" ,
			width = 80 ,
			height = 64 ,
			frame_count = frameCount or 15 ,
			line_length = lineLength or 5 ,
			direction_count = 1 ,
			y = 192 * yCount ,
			scale = 1.0 ,
			shift = SIUtils.by_pixel( -2 , -26 ) ,
			axially_symmetrical = false ,
			hr_version =
			{
				filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinFlameTurret-Gun-Expand" , "遗迹喷火炮塔-枪-扩展" ) ,
				priority = "medium" ,
				run_mode = runMode or "forward" ,
				width = 152 ,
				height = 128 ,
				frame_count = frameCount or 15 ,
				line_length = lineLength or 5 ,
				direction_count = 1 ,
				y = 384 * yCount ,
				scale = 0.5 ,
				shift = SIUtils.by_pixel( 0 , -26 ) ,
				axially_symmetrical = false
			}
		} ,
		{
			filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinFlameTurret-Gun-Expand-Cover" , "遗迹喷火炮塔-枪-扩展-遮盖" ) ,
			priority = "medium" ,
			run_mode = runMode or "forward" ,
			flags = { "mask" } ,
			width = 76 ,
			height = 60 ,
			frame_count = frameCount or 15 ,
			line_length = lineLength or 5 ,
			direction_count = 1 ,
			y = 180 * yCount ,
			scale = 1.0 ,
			shift = SIUtils.by_pixel( -2 , -26 ) ,
			axially_symmetrical = false ,
			apply_runtime_tint = true ,
			hr_version =
			{
				filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinFlameTurret-Gun-Expand-Cover" , "遗迹喷火炮塔-枪-扩展-遮盖" ) ,
				priority = "medium" ,
				run_mode = runMode or "forward" ,
				flags = { "mask" } ,
				width = 144 ,
				height = 120 ,
				frame_count = frameCount or 15 ,
				line_length = lineLength or 5 ,
				direction_count = 1 ,
				y = 360 * yCount ,
				scale = 0.5 ,
				shift = SIUtils.by_pixel( 0 , -26 ) ,
				axially_symmetrical = false ,
				apply_runtime_tint = true
			}
		} ,
		{
			filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinFlameTurret-Gun-Expand-Shadow" , "遗迹喷火炮塔-枪-扩展-影子" ) ,
			priority = "medium" ,
			run_mode = runMode or "forward" ,
			width = 92 ,
			height = 60 ,
			frame_count = frameCount or 15 ,
			line_length = lineLength or 5 ,
			direction_count = 1 ,
			y = 180 * yCount ,
			scale = 1.0 ,
			shift = SIUtils.by_pixel( 32 , -2 ) ,
			draw_as_shadow = true ,
			axially_symmetrical = false ,
			hr_version =
			{
				filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinFlameTurret-Gun-Expand-Shadow" , "遗迹喷火炮塔-枪-扩展-影子" ) ,
				priority = "medium" ,
				run_mode = runMode or "forward" ,
				width = 180 ,
				height = 114 ,
				frame_count = frameCount or 15 ,
				line_length = lineLength or 5 ,
				direction_count = 1 ,
				y = 342 * yCount ,
				scale = 0.5 ,
				shift = SIUtils.by_pixel( 33 , -1 ) ,
				draw_as_shadow = true ,
				axially_symmetrical = false
			}
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
SIGen
.New( SICommon.Types.Entities.Corpse , "RuinFlameTurret_Corpse" , "遗迹喷火炮塔-残骸" )
.AutoIcon()
.SetSizeScale( 2 , 2 , 0 )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceableNeutral , SICommon.Flags.Entity.NotOnMap } ,
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
					filename = SIGen.MakeSelfPicturePath( "RuinFlameTurret-Corpse" , "遗迹喷火炮塔-残骸" ) ,
					priority = "extra-high" ,
					width = 152 ,
					height = 164 ,
					frame_count = 1 ,
					line_length = 1 ,
					variation_count = 1 ,
					direction_count = 4 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( -1 , -4 ) ,
					axially_symmetrical = false ,
					hr_version =
					{
						filename = SIGen.MakeSelfPicturePathHr( "RuinFlameTurret-Corpse" , "遗迹喷火炮塔-残骸" ) ,
						priority = "extra-high" ,
						width = 302 ,
						height = 326 ,
						frame_count = 1 ,
						line_length = 1 ,
						variation_count = 1 ,
						direction_count = 4 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( -1.5 , -4 ) ,
						axially_symmetrical = false
					}
				} ,
				{
					filename = SIGen.MakeSelfPicturePath( "RuinFlameTurret-Corpse-Cover" , "遗迹喷火炮塔-残骸-遮盖" ) ,
					priority = "low" ,
					width = 82 ,
					height = 82 ,
					frame_count = 1 ,
					line_length = 1 ,
					variation_count = 1 ,
					direction_count = 4 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 0 , -4 ) ,
					apply_runtime_tint = true ,
					hr_version =
					{
						filename = SIGen.MakeSelfPicturePathHr( "RuinFlameTurret-Corpse-Cover" , "遗迹喷火炮塔-残骸-遮盖" ) ,
						priority = "low" ,
						width = 164 ,
						height = 164 ,
						frame_count = 1 ,
						line_length = 1 ,
						variation_count = 1 ,
						direction_count = 4 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 0 , -3.5 ) ,
						apply_runtime_tint = true
					}
				}
			}
		}
	}
}
CreateRuinBuildings( SICommon.Types.Entities.Turret , "RuinFlameTurret" , "遗迹喷火炮塔" , 2 , SIConstants_RuinSystem.LevelValueList ,
{
	localised_name = SIGen.MakeLocalisedName( SICommon.Types.Entities.Turret , "遗迹喷火炮塔" ) ,
	localised_description = SIGen.MakeLocalisedDescription( SICommon.Types.Entities.Turret , "遗迹喷火炮塔" ) ,
	icons =
	{
		{
			icon = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinFlameTurret" .. SICommon.CodeNameSuffix.ICON , "遗迹喷火炮塔" .. SICommon.ShowNameSuffix.ICON ) ,
			icon_size = 64 ,
			icon_mipmaps = 4
		}
	} ,
	icon_size = 64 ,
	icon_mipmaps = 4 ,
	flags = { SICommon.Flags.Entity.PlaceableEnemy } ,
	minable =
	{
		mining_time = 6000.0 ,
		results = {}
	} ,
	max_health = 410 ,
	corpse = SIConstants_RuinSystem.raw.Entities.RuinFlameTurret_Corpse ,
	dying_explosion = "medium-explosion" ,
	map_color = { r = 1.0 , g = 1.0 , b = 1.0 } ,
	friendly_map_color = { r = 0.4 , g = 0.4 , b = 1.0 } ,
	enemy_map_color = { r = 1.0 , g = 0.4 , b = 0.4 } ,
	is_military_target = true ,
	allow_run_time_change_of_is_military_target = true ,
	alert_when_damaged = true ,
	create_ghost_on_death = false ,
	hide_resistances = false ,
	resistances =
	{
		SITools.Resistance( "fire" , 0 , 100 )
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
			category = SIConstants_RuinSystem.raw.Categories.Ammo.RuinTurret ,
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
				SISound.Base( "fight/flamethrower-turret-start-01" , 0.5 ) ,
				SISound.Base( "fight/flamethrower-turret-start-02" , 0.5 ) ,
				SISound.Base( "fight/flamethrower-turret-start-03" , 0.5 )
			} ,
			middle_sound =
			{
				SISound.Base( "fight/flamethrower-turret-mid-01" , 0.5 ) ,
				SISound.Base( "fight/flamethrower-turret-mid-02" , 0.5 ) ,
				SISound.Base( "fight/flamethrower-turret-mid-03" , 0.5 )
			} ,
			end_sound =
			{
				SISound.Base( "fight/flamethrower-turret-end-01" , 0.5 ) ,
				SISound.Base( "fight/flamethrower-turret-end-02" , 0.5 ) ,
				SISound.Base( "fight/flamethrower-turret-end-03" , 0.5 )
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
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinFlameTurret-Up" , "遗迹喷火炮塔-上" ) ,
					priority = "medium" ,
					width = 80 ,
					height = 96 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 1 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( -2 , 14 ) ,
					axially_symmetrical = false ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinFlameTurret-Up" , "遗迹喷火炮塔-上" ) ,
						priority = "medium" ,
						width = 158 ,
						height = 196 ,
						frame_count = 1 ,
						line_length = 1 ,
						direction_count = 1 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( -1 , 13 ) ,
						axially_symmetrical = false
					}
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinFlameTurret-Up-Cover" , "遗迹喷火炮塔-上-遮盖" ) ,
					priority = "medium" ,
					flags = { "mask" } ,
					width = 36 ,
					height = 38 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 1 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 0 , 32 ) ,
					axially_symmetrical = false ,
					apply_runtime_tint = true ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinFlameTurret-Up-Cover" , "遗迹喷火炮塔-上-遮盖" ) ,
						priority = "medium" ,
						flags = { "mask" } ,
						width = 74 ,
						height = 70 ,
						frame_count = 1 ,
						line_length = 1 ,
						direction_count = 1 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( -1 , 33 ) ,
						axially_symmetrical = false ,
						apply_runtime_tint = true
					}
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinFlameTurret-Up-Shadow" , "遗迹喷火炮塔-上-影子" ) ,
					priority = "medium" ,
					width = 70 ,
					height = 78 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 1 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 2 , 14 ) ,
					draw_as_shadow = true ,
					axially_symmetrical = false ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinFlameTurret-Up-Shadow" , "遗迹喷火炮塔-上-影子" ) ,
						priority = "medium" ,
						width = 134 ,
						height = 152 ,
						frame_count = 1 ,
						line_length = 1 ,
						direction_count = 1 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 3 , 15 ) ,
						draw_as_shadow = true ,
						axially_symmetrical = false
					}
				}
			}
		} ,
		east =
		{
			layers =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinFlameTurret-Right" , "遗迹喷火炮塔-右" ) ,
					priority = "medium" ,
					width = 106 ,
					height = 72 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 1 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( -6 , 2 ) ,
					axially_symmetrical = false ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinFlameTurret-Right" , "遗迹喷火炮塔-右" ) ,
						priority = "medium" ,
						width = 216 ,
						height = 146 ,
						frame_count = 1 ,
						line_length = 1 ,
						direction_count = 1 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( -6 , 3 ) ,
						axially_symmetrical = false
					}
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinFlameTurret-Right-Cover" , "遗迹喷火炮塔-右-遮盖" ) ,
					priority = "medium" ,
					flags = { "mask" } ,
					width = 32 ,
					height = 42 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 1 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( -32 , 0 ) ,
					axially_symmetrical = false ,
					apply_runtime_tint = true ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinFlameTurret-Right-Cover" , "遗迹喷火炮塔-右-遮盖" ) ,
						priority = "medium" ,
						flags = { "mask" } ,
						width = 66 ,
						height = 82 ,
						frame_count = 1 ,
						line_length = 1 ,
						direction_count = 1 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( -33 , 1 ) ,
						axially_symmetrical = false ,
						apply_runtime_tint = true
					}
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinFlameTurret-Right-Shadow" , "遗迹喷火炮塔-右-影子" ) ,
					priority = "medium" ,
					width = 72 ,
					height = 46 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 1 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 14 , 8 ) ,
					draw_as_shadow = true ,
					axially_symmetrical = false ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinFlameTurret-Right-Shadow" , "遗迹喷火炮塔-右-影子" ) ,
						priority = "medium" ,
						width = 144 ,
						height = 86 ,
						frame_count = 1 ,
						line_length = 1 ,
						direction_count = 1 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 14 , 9 ) ,
						draw_as_shadow = true ,
						axially_symmetrical = false
					}
				}
			}
		} ,
		south =
		{
			layers =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinFlameTurret-Down" , "遗迹喷火炮塔-下" ) ,
					priority = "medium" ,
					width = 64 ,
					height = 84 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 1 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 0 , -8 ) ,
					axially_symmetrical = false ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinFlameTurret-Down" , "遗迹喷火炮塔-下" ) ,
						priority = "medium" ,
						width = 128 ,
						height = 166 ,
						frame_count = 1 ,
						line_length = 1 ,
						direction_count = 1 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 0 , -8 ) ,
						axially_symmetrical = false
					}
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinFlameTurret-Down-Cover" , "遗迹喷火炮塔-下-遮盖" ) ,
					priority = "medium" ,
					flags = { "mask" } ,
					width = 36 ,
					height = 38 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 1 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 0 , -32 ) ,
					axially_symmetrical = false ,
					apply_runtime_tint = true ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinFlameTurret-Down-Cover" , "遗迹喷火炮塔-下-遮盖" ) ,
						priority = "medium" ,
						flags = { "mask" } ,
						width = 72 ,
						height = 72 ,
						frame_count = 1 ,
						line_length = 1 ,
						direction_count = 1 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 0 , -31 ) ,
						axially_symmetrical = false ,
						apply_runtime_tint = true
					}
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinFlameTurret-Down-Shadow" , "遗迹喷火炮塔-下-影子" ) ,
					priority = "medium" ,
					width = 70 ,
					height = 52 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 1 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 2 , 8 ) ,
					draw_as_shadow = true ,
					axially_symmetrical = false ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinFlameTurret-Down-Shadow" , "遗迹喷火炮塔-下-影子" ) ,
						priority = "medium" ,
						width = 134 ,
						height = 98 ,
						frame_count = 1 ,
						line_length = 1 ,
						direction_count = 1 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 3 , 9 ) ,
						draw_as_shadow = true ,
						axially_symmetrical = false
					}
				}
			}
		} ,
		west =
		{
			layers =
			{
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinFlameTurret-Left" , "遗迹喷火炮塔-左" ) ,
					priority = "medium" ,
					width = 100 ,
					height = 74 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 1 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 8 , -2 ) ,
					axially_symmetrical = false ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinFlameTurret-Left" , "遗迹喷火炮塔-左" ) ,
						priority = "medium" ,
						width = 208 ,
						height = 144 ,
						frame_count = 1 ,
						line_length = 1 ,
						direction_count = 1 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 7 , -1 ) ,
						axially_symmetrical = false
					}
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinFlameTurret-Left-Cover" , "遗迹喷火炮塔-左-遮盖" ) ,
					priority = "medium" ,
					flags = { "mask" } ,
					width = 32 ,
					height = 40 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 1 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 32 , -2 ) ,
					axially_symmetrical = false ,
					apply_runtime_tint = true ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinFlameTurret-Left-Cover" , "遗迹喷火炮塔-左-遮盖" ) ,
						priority = "medium" ,
						flags = { "mask" } ,
						width = 64 ,
						height = 74 ,
						frame_count = 1 ,
						line_length = 1 ,
						direction_count = 1 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 32 , -1 ) ,
						axially_symmetrical = false ,
						apply_runtime_tint = true
					}
				} ,
				{
					filename = SIGen.MakePicturePath( SICommon.Types.Entities.Turret , "RuinFlameTurret-Left-Shadow" , "遗迹喷火炮塔-左-影子" ) ,
					priority = "medium" ,
					width = 104 ,
					height = 44 ,
					frame_count = 1 ,
					line_length = 1 ,
					direction_count = 1 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 14 , 4 ) ,
					draw_as_shadow = true ,
					axially_symmetrical = false ,
					hr_version =
					{
						filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Turret , "RuinFlameTurret-Left-Shadow" , "遗迹喷火炮塔-左-影子" ) ,
						priority = "medium" ,
						width = 206 ,
						height = 88 ,
						frame_count = 1 ,
						line_length = 1 ,
						direction_count = 1 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 15 , 4 ) ,
						draw_as_shadow = true ,
						axially_symmetrical = false
					}
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
		SISound.Core( "deconstruct-small" , 1 )
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
	} ,
	preparing_sound =
	{
		SISound.Base( "fight/flamethrower-turret-activate-01" , 0.3 ) ,
		SISound.Base( "fight/flamethrower-turret-activate-02" , 0.3 ) ,
		SISound.Base( "fight/flamethrower-turret-activate-03" , 0.3 ) ,
		SISound.Base( "fight/flamethrower-turret-activate-04" , 0.3 )
	} ,
	folding_sound =
	{
		SISound.Base( "fight/flamethrower-turret-deactivate-01" , 0.3 ) ,
		SISound.Base( "fight/flamethrower-turret-deactivate-02" , 0.3 ) ,
		SISound.Base( "fight/flamethrower-turret-deactivate-03" , 0.3 ) ,
		SISound.Base( "fight/flamethrower-turret-deactivate-04" , 0.3 )
	}
} )

-- ======================================================================
-- 遗迹箱子
-- ======================================================================
SIGen
.New( SICommon.Types.Entities.Corpse , "RuinChest_Corpse" , "遗迹箱子-残骸" )
.AutoIcon()
.SetSizeScale( 1 , 1 , 0 )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceableNeutral , SICommon.Flags.Entity.Building8Way , SICommon.Flags.Entity.NotOnMap } ,
	time_before_removed = 54000 , -- 15 分钟
	tile_width = 1 ,
	tile_height = 1 ,
	selectable_in_game = false ,
	remove_on_tile_placement = false ,
	final_render_layer = SICommon.Flags.RenderLayer.Remnants ,
	animation =
	{
		{
			layers =
			{
				{
					filename = SIGen.MakeSelfPicturePath( "RuinChest-Corpse" , "遗迹箱子-残骸" ) ,
					priority = "extra-high" ,
					width = 56 ,
					height = 38 ,
					frame_count = 1 ,
					line_length = 1 ,
					variation_count = 1 ,
					direction_count = 1 ,
					scale = 1.0 ,
					shift = SIUtils.by_pixel( 8 , -1 ) ,
					hr_version =
					{
						filename = SIGen.MakeSelfPicturePathHr( "RuinChest-Corpse" , "遗迹箱子-残骸" ) ,
						priority = "extra-high" ,
						width = 110 ,
						height = 74 ,
						frame_count = 1 ,
						line_length = 1 ,
						variation_count = 1 ,
						direction_count = 1 ,
						scale = 0.5 ,
						shift = SIUtils.by_pixel( 7.5 , -1 )
					}
				}
			}
		}
	}
}
CreateRuinBuildings( SICommon.Types.Entities.Container , "RuinChest" , "遗迹箱子" , 1 , SIConstants_RuinSystem.LevelValueList ,
{
	localised_name = SIGen.MakeLocalisedName( SICommon.Types.Entities.Container , "遗迹箱子" ) ,
	localised_description = SIGen.MakeLocalisedDescription( SICommon.Types.Entities.Container , "遗迹箱子" ) ,
	icons =
	{
		{
			icon = SIGen.MakePicturePath( SICommon.Types.Entities.Container , "RuinChest" .. SICommon.CodeNameSuffix.ICON , "遗迹箱子" .. SICommon.ShowNameSuffix.ICON ) ,
			icon_size = 64 ,
			icon_mipmaps = 4
		}
	} ,
	icon_size = 64 ,
	icon_mipmaps = 4 ,
	flags = { SICommon.Flags.Entity.PlaceableEnemy , SICommon.Flags.Entity.NotOnMap } ,
	minable =
	{
		mining_time = 6000.0 ,
		results = {}
	} ,
	max_health = 8 ,
	corpse = SIConstants_RuinSystem.raw.Entities.RuinChest_Corpse ,
	dying_explosion = "wooden-chest-explosion" ,
	map_color = { r = 1.0 , g = 1.0 , b = 1.0 } ,
	friendly_map_color = { r = 0.4 , g = 0.4 , b = 1.0 } ,
	enemy_map_color = { r = 1.0 , g = 0.4 , b = 0.4 } ,
	is_military_target = false ,
	allow_run_time_change_of_is_military_target = true ,
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
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Container , "RuinChest" , "遗迹箱子" ) ,
				priority = "extra-high" ,
				width = 32 ,
				height = 36 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 0.5 , -2 ) ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Container , "RuinChest" , "遗迹箱子" ) ,
					priority = "extra-high" ,
					width = 62 ,
					height = 72 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 0.5 , -2 )
				}
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Container , "RuinChest-Shadow" , "遗迹箱子-影子" ) ,
				priority = "extra-high" ,
				width = 52 ,
				height = 20 ,
				scale = 1.0 ,
				shift = SIUtils.by_pixel( 10 , 6.5 ) ,
				draw_as_shadow = true ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Container , "RuinChest-Shadow" , "遗迹箱子-影子" ) ,
					priority = "extra-high" ,
					width = 104 ,
					height = 40 ,
					scale = 0.5 ,
					shift = SIUtils.by_pixel( 10 , 6.5 ) ,
					draw_as_shadow = true
				}
			}
		}
	} ,
	mined_sound =
	{
		SISound.Core( "deconstruct-small" , 1 )
	} ,
	vehicle_impact_sound =
	{
		SISound.Base( "car-wood-impact" , 0.5 ) ,
		SISound.Base( "car-wood-impact-02" , 0.5 ) ,
		SISound.Base( "car-wood-impact-03" , 0.5 ) ,
		SISound.Base( "car-wood-impact-04" , 0.5 ) ,
		SISound.Base( "car-wood-impact-05" , 0.5 )
	} ,
	repair_sound =
	{
		SISound.Core( "manual-repair-advanced-1" , 0.5 ) ,
		SISound.Core( "manual-repair-advanced-2" , 0.5 )
	} ,
	open_sound =
	{
		SISound.Base( "wooden-chest-open" , 0.5 )
	} ,
	close_sound =
	{
		SISound.Base( "wooden-chest-close" , 0.5 )
	}
} )

-- ======================================================================
-- 遗迹组装机
-- ======================================================================
SIGen
.New( SICommon.Types.Entities.Corpse , "RuinMachine_Corpse" , "遗迹组装机-残骸" )
.AutoIcon()
.SetSizeScale( 2 , 2 , 0 )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceableNeutral , SICommon.Flags.Entity.NotOnMap } ,
	time_before_removed = 54000 , -- 15 分钟
	tile_width = 3 ,
	tile_height = 3 ,
	selectable_in_game = false ,
	remove_on_tile_placement = false ,
	final_render_layer = SICommon.Flags.RenderLayer.Remnants ,
	animation = SIGraphics.MakeRemnantsAnimation( 3 ,
	{
		{
			filename = SIGen.MakeSelfPicturePath( "RuinMachine-Corpse" , "遗迹组装机-残骸" ) ,
			priority = "extra-high" ,
			width = 164 ,
			height = 142 ,
			frame_count = 1 ,
			line_length = 1 ,
			variation_count = 1 ,
			direction_count = 1 ,
			scale = 0.66 ,
			shift = SIUtils.by_pixel( 0 , 10 ) ,
			axially_symmetrical = false ,
			hr_version =
			{
				filename = SIGen.MakeSelfPicturePathHr( "RuinMachine-Corpse" , "遗迹组装机-残骸" ) ,
				priority = "extra-high" ,
				width = 328 ,
				height = 282 ,
				frame_count = 1 ,
				line_length = 1 ,
				variation_count = 1 ,
				direction_count = 1 ,
				scale = 0.33 ,
				shift = SIUtils.by_pixel( 0 , 9.5 ) ,
				axially_symmetrical = false
			}
		}
	} )
}
CreateRuinBuildings( SICommon.Types.Entities.Machine , "RuinMachine" , "遗迹组装机" , 2 , SIConstants_RuinSystem.LevelValueList ,
{
	localised_name = SIGen.MakeLocalisedName( SICommon.Types.Entities.Machine , "遗迹组装机" ) ,
	localised_description = SIGen.MakeLocalisedDescription( SICommon.Types.Entities.Machine , "遗迹组装机" ) ,
	icons =
	{
		{
			icon = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "RuinMachine" .. SICommon.CodeNameSuffix.ICON , "遗迹组装机" .. SICommon.ShowNameSuffix.ICON ) ,
			icon_size = 64 ,
			icon_mipmaps = 4
		}
	} ,
	icon_size = 64 ,
	icon_mipmaps = 4 ,
	flags = { SICommon.Flags.Entity.PlaceableEnemy , SICommon.Flags.Entity.NotOnMap } ,
	minable =
	{
		mining_time = 6000.0 ,
		results = {}
	} ,
	max_health = 24 ,
	corpse = SIConstants_RuinSystem.raw.Entities.RuinMachine_Corpse ,
	dying_explosion = "assembling-machine-3-explosion" ,
	map_color = { r = 1.0 , g = 1.0 , b = 1.0 } ,
	friendly_map_color = { r = 0.4 , g = 0.4 , b = 1.0 } ,
	enemy_map_color = { r = 1.0 , g = 0.4 , b = 0.4 } ,
	is_military_target = false ,
	allow_run_time_change_of_is_military_target = true ,
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
	crafting_categories = { SIConstants_RuinSystem.raw.Categories.Recipe.RuinMachine } ,
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
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "RuinMachine-PipeUp" , "遗迹组装机-管道上" ) ,
							priority = "extra-high" ,
							width = 35 ,
							height = 18 ,
							scale = 0.66 ,
							shift = SIUtils.by_pixel( 2.5 , 14 ) ,
							hr_version =
							{
								filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Machine , "RuinMachine-PipeUp" , "遗迹组装机-管道上" ) ,
								priority = "extra-high" ,
								width = 71 ,
								height = 38 ,
								scale = 0.33 ,
								shift = SIUtils.by_pixel( 2.25 , 13.5 )
							}
						}
					}
				} ,
				east =
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "RuinMachine-PipeRight" , "遗迹组装机-管道右" ) ,
							priority = "extra-high" ,
							width = 20 ,
							height = 38 ,
							scale = 0.66 ,
							shift = SIUtils.by_pixel( -25 , 1 ) ,
							hr_version =
							{
								filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Machine , "RuinMachine-PipeRight" , "遗迹组装机-管道右" ) ,
								priority = "extra-high" ,
								width = 42 ,
								height = 76 ,
								scale = 0.33 ,
								shift = SIUtils.by_pixel( -24.5 , 1 )
							}
						}
					}
				} ,
				south =
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "RuinMachine-PipeDown" , "遗迹组装机-管道下" ) ,
							priority = "extra-high" ,
							width = 44 ,
							height = 31 ,
							scale = 0.66 ,
							shift = SIUtils.by_pixel( 0 , -31.5 ) ,
							hr_version =
							{
								filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Machine , "RuinMachine-PipeDown" , "遗迹组装机-管道下" ) ,
								priority = "extra-high" ,
								width = 88 ,
								height = 61 ,
								scale = 0.33 ,
								shift = SIUtils.by_pixel( 0 , -31.25 )
							}
						}
					}
				} ,
				west =
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "RuinMachine-PipeLeft" , "遗迹组装机-管道左" ) ,
							priority = "extra-high" ,
							width = 19 ,
							height = 37 ,
							scale = 0.66 ,
							shift = SIUtils.by_pixel( 25.5 , 1.5 ) ,
							hr_version =
							{
								filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Machine , "RuinMachine-PipeLeft" , "遗迹组装机-管道左" ) ,
								priority = "extra-high" ,
								width = 39 ,
								height = 73 ,
								scale = 0.33 ,
								shift = SIUtils.by_pixel( 25.75 , 1.25 )
							}
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
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "RuinMachine-PipeUpCover" , "遗迹组装机-管道上盖" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66 ,
							hr_version =
							{
								filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Machine , "RuinMachine-PipeUpCover" , "遗迹组装机-管道上盖" ) ,
								priority = "extra-high" ,
								width = 128 ,
								height = 128 ,
								scale = 0.33
							}
						} ,
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "RuinMachine-PipeUpCover-Shadow" , "遗迹组装机-管道上盖-影子" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66 ,
							draw_as_shadow = true ,
							hr_version =
							{
								filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Machine , "RuinMachine-PipeUpCover-Shadow" , "遗迹组装机-管道上盖-影子" ) ,
								priority = "extra-high" ,
								width = 128 ,
								height = 128 ,
								scale = 0.33 ,
								draw_as_shadow = true
							}
						}
					}
				} ,
				east =
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "RuinMachine-PipeRightCover" , "遗迹组装机-管道右盖" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66 ,
							hr_version =
							{
								filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Machine , "RuinMachine-PipeRightCover" , "遗迹组装机-管道右盖" ) ,
								priority = "extra-high" ,
								width = 128 ,
								height = 128 ,
								scale = 0.33
							}
						} ,
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "RuinMachine-PipeRightCover-Shadow" , "遗迹组装机-管道右盖-影子" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66 ,
							draw_as_shadow = true ,
							hr_version =
							{
								filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Machine , "RuinMachine-PipeRightCover-Shadow" , "遗迹组装机-管道右盖-影子" ) ,
								priority = "extra-high" ,
								width = 128 ,
								height = 128 ,
								scale = 0.33 ,
								draw_as_shadow = true
							}
						}
					}
				} ,
				south =
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "RuinMachine-PipeDownCover" , "遗迹组装机-管道下盖" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66 ,
							hr_version =
							{
								filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Machine , "RuinMachine-PipeDownCover" , "遗迹组装机-管道下盖" ) ,
								priority = "extra-high" ,
								width = 128 ,
								height = 128 ,
								scale = 0.33
							}
						} ,
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "RuinMachine-PipeDownCover-Shadow" , "遗迹组装机-管道下盖-影子" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66 ,
							draw_as_shadow = true ,
							hr_version =
							{
								filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Machine , "RuinMachine-PipeDownCover-Shadow" , "遗迹组装机-管道下盖-影子" ) ,
								priority = "extra-high" ,
								width = 128 ,
								height = 128 ,
								scale = 0.33 ,
								draw_as_shadow = true
							}
						}
					}
				} ,
				west =
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "RuinMachine-PipeLeftCover" , "遗迹组装机-管道左盖" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66 ,
							hr_version =
							{
								filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Machine , "RuinMachine-PipeLeftCover" , "遗迹组装机-管道左盖" ) ,
								priority = "extra-high" ,
								width = 128 ,
								height = 128 ,
								scale = 0.33
							}
						} ,
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "RuinMachine-PipeLeftCover-Shadow" , "遗迹组装机-管道左盖-影子" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66 ,
							draw_as_shadow = true ,
							hr_version =
							{
								filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Machine , "RuinMachine-PipeLeftCover-Shadow" , "遗迹组装机-管道左盖-影子" ) ,
								priority = "extra-high" ,
								width = 128 ,
								height = 128 ,
								scale = 0.33 ,
								draw_as_shadow = true
							}
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
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "RuinMachine-PipeUp" , "遗迹组装机-管道上" ) ,
							priority = "extra-high" ,
							width = 35 ,
							height = 18 ,
							scale = 0.66 ,
							shift = SIUtils.by_pixel( 2.5 , 14 ) ,
							hr_version =
							{
								filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Machine , "RuinMachine-PipeUp" , "遗迹组装机-管道上" ) ,
								priority = "extra-high" ,
								width = 71 ,
								height = 38 ,
								scale = 0.33 ,
								shift = SIUtils.by_pixel( 2.25 , 13.5 )
							}
						}
					}
				} ,
				east =
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "RuinMachine-PipeRight" , "遗迹组装机-管道右" ) ,
							priority = "extra-high" ,
							width = 20 ,
							height = 38 ,
							scale = 0.66 ,
							shift = SIUtils.by_pixel( -25 , 1 ) ,
							hr_version =
							{
								filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Machine , "RuinMachine-PipeRight" , "遗迹组装机-管道右" ) ,
								priority = "extra-high" ,
								width = 42 ,
								height = 76 ,
								scale = 0.33 ,
								shift = SIUtils.by_pixel( -24.5 , 1 )
							}
						}
					}
				} ,
				south =
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "RuinMachine-PipeDown" , "遗迹组装机-管道下" ) ,
							priority = "extra-high" ,
							width = 44 ,
							height = 31 ,
							scale = 0.66 ,
							shift = SIUtils.by_pixel( 0 , -31.5 ) ,
							hr_version =
							{
								filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Machine , "RuinMachine-PipeDown" , "遗迹组装机-管道下" ) ,
								priority = "extra-high" ,
								width = 88 ,
								height = 61 ,
								scale = 0.33 ,
								shift = SIUtils.by_pixel( 0 , -31.25 )
							}
						}
					}
				} ,
				west =
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "RuinMachine-PipeLeft" , "遗迹组装机-管道左" ) ,
							priority = "extra-high" ,
							width = 19 ,
							height = 37 ,
							scale = 0.66 ,
							shift = SIUtils.by_pixel( 25.5 , 1.5 ) ,
							hr_version =
							{
								filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Machine , "RuinMachine-PipeLeft" , "遗迹组装机-管道左" ) ,
								priority = "extra-high" ,
								width = 39 ,
								height = 73 ,
								scale = 0.33 ,
								shift = SIUtils.by_pixel( 25.75 , 1.25 )
							}
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
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "RuinMachine-PipeUpCover" , "遗迹组装机-管道上盖" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66 ,
							hr_version =
							{
								filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Machine , "RuinMachine-PipeUpCover" , "遗迹组装机-管道上盖" ) ,
								priority = "extra-high" ,
								width = 128 ,
								height = 128 ,
								scale = 0.33
							}
						} ,
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "RuinMachine-PipeUpCover-Shadow" , "遗迹组装机-管道上盖-影子" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66 ,
							draw_as_shadow = true ,
							hr_version =
							{
								filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Machine , "RuinMachine-PipeUpCover-Shadow" , "遗迹组装机-管道上盖-影子" ) ,
								priority = "extra-high" ,
								width = 128 ,
								height = 128 ,
								scale = 0.33 ,
								draw_as_shadow = true
							}
						}
					}
				} ,
				east =
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "RuinMachine-PipeRightCover" , "遗迹组装机-管道右盖" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66 ,
							hr_version =
							{
								filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Machine , "RuinMachine-PipeRightCover" , "遗迹组装机-管道右盖" ) ,
								priority = "extra-high" ,
								width = 128 ,
								height = 128 ,
								scale = 0.33
							}
						} ,
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "RuinMachine-PipeRightCover-Shadow" , "遗迹组装机-管道右盖-影子" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66 ,
							draw_as_shadow = true ,
							hr_version =
							{
								filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Machine , "RuinMachine-PipeRightCover-Shadow" , "遗迹组装机-管道右盖-影子" ) ,
								priority = "extra-high" ,
								width = 128 ,
								height = 128 ,
								scale = 0.33 ,
								draw_as_shadow = true
							}
						}
					}
				} ,
				south =
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "RuinMachine-PipeDownCover" , "遗迹组装机-管道下盖" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66 ,
							hr_version =
							{
								filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Machine , "RuinMachine-PipeDownCover" , "遗迹组装机-管道下盖" ) ,
								priority = "extra-high" ,
								width = 128 ,
								height = 128 ,
								scale = 0.33
							}
						} ,
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "RuinMachine-PipeDownCover-Shadow" , "遗迹组装机-管道下盖-影子" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66 ,
							draw_as_shadow = true ,
							hr_version =
							{
								filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Machine , "RuinMachine-PipeDownCover-Shadow" , "遗迹组装机-管道下盖-影子" ) ,
								priority = "extra-high" ,
								width = 128 ,
								height = 128 ,
								scale = 0.33 ,
								draw_as_shadow = true
							}
						}
					}
				} ,
				west =
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "RuinMachine-PipeLeftCover" , "遗迹组装机-管道左盖" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66 ,
							hr_version =
							{
								filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Machine , "RuinMachine-PipeLeftCover" , "遗迹组装机-管道左盖" ) ,
								priority = "extra-high" ,
								width = 128 ,
								height = 128 ,
								scale = 0.33
							}
						} ,
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "RuinMachine-PipeLeftCover-Shadow" , "遗迹组装机-管道左盖-影子" ) ,
							priority = "extra-high" ,
							width = 64 ,
							height = 64 ,
							scale = 0.66 ,
							draw_as_shadow = true ,
							hr_version =
							{
								filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Machine , "RuinMachine-PipeLeftCover-Shadow" , "遗迹组装机-管道左盖-影子" ) ,
								priority = "extra-high" ,
								width = 128 ,
								height = 128 ,
								scale = 0.33 ,
								draw_as_shadow = true
							}
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
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "RuinMachine" , "遗迹组装机" ) ,
				priority = "high" ,
				width = 108 ,
				height = 119 ,
				frame_count = 32 ,
				line_length = 8 ,
				scale = 0.66 ,
				shift = SIUtils.by_pixel( 0 , -0.5 ) ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Machine , "RuinMachine" , "遗迹组装机" ) ,
					priority = "high" ,
					width = 214 ,
					height = 237 ,
					frame_count = 32 ,
					line_length = 8 ,
					scale = 0.33 ,
					shift = SIUtils.by_pixel( 0 , -0.75 )
				}
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Machine , "RuinMachine-Shadow" , "遗迹组装机-影子" ) ,
				priority = "high" ,
				width = 130 ,
				height = 82 ,
				frame_count = 32 ,
				line_length = 8 ,
				scale = 0.66 ,
				shift = SIUtils.by_pixel( 28 , 4 ) ,
				draw_as_shadow = true ,
				hr_version =
				{
					filename = SIGen.MakePicturePathHr( SICommon.Types.Entities.Machine , "RuinMachine-Shadow" , "遗迹组装机-影子" ) ,
					priority = "high" ,
					width = 260 ,
					height = 162 ,
					frame_count = 32 ,
					line_length = 8 ,
					scale = 0.33 ,
					shift = SIUtils.by_pixel( 28 , 4 ) ,
					draw_as_shadow = true
				}
			}
		}
	} ,
	mined_sound =
	{
		SISound.Core( "deconstruct-large" , 1 )
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
	} ,
	working_sound =
	{
		sound =
		{
			SISound.Base( "assembling-machine-t3-1" , 0.5 )
		} ,
		audible_distance_modifier = 0.5 ,
		fade_in_ticks = 4 ,
		fade_out_ticks = 20
	}
} )

-- ======================================================================
-- 遗迹爪子
-- ======================================================================
SIGen
.New( SICommon.Types.Entities.Corpse , "RuinInserter_Corpse" , "遗迹爪子-残骸" )
.AutoIcon()
.SetSizeScale( 1 , 1 , 0 )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceableNeutral , SICommon.Flags.Entity.NotOnMap } ,
	time_before_removed = 54000 , -- 15 分钟
	tile_width = 1 ,
	tile_height = 1 ,
	selectable_in_game = false ,
	remove_on_tile_placement = false ,
	final_render_layer = SICommon.Flags.RenderLayer.Remnants ,
	animation = SIGraphics.MakeRemnantsAnimation( 4 ,
	{
		{
			filename = SIGen.MakeSelfPicturePath( "RuinInserter-Corpse" , "遗迹爪子-残骸" ) ,
			priority = "extra-high" ,
			width = 68 ,
			height = 48 ,
			frame_count = 1 ,
			line_length = 1 ,
			variation_count = 1 ,
			direction_count = 1 ,
			scale = 1.0 ,
			shift = SIUtils.by_pixel( 4 , -2 ) ,
			axially_symmetrical = false ,
			hr_version =
			{
				filename = SIGen.MakeSelfPicturePathHr( "RuinInserter-Corpse" , "遗迹爪子-残骸" ) ,
				priority = "extra-high" ,
				width = 134 ,
				height = 94 ,
				frame_count = 1 ,
				line_length = 1 ,
				variation_count = 1 ,
				direction_count = 1 ,
				scale = 0.5 ,
				shift = SIUtils.by_pixel( 3.5 , -2 ) ,
				axially_symmetrical = false
			}
		}
	} )
}
.New( SICommon.Types.Entities.Inserter , "RuinInserter" , "遗迹爪子" )
.AutoIcon()
.SetSize( 1 , 1 )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceableEnemy , SICommon.Flags.Entity.NotOnMap } ,
	minable =
	{
		mining_time = 6000.0 ,
		results = {}
	} ,
	max_health = 270 ,
	corpse = SIConstants_RuinSystem.raw.Entities.RuinInserter_Corpse ,
	dying_explosion = "inserter-explosion" ,
	map_color = { r = 1.0 , g = 1.0 , b = 1.0 } ,
	friendly_map_color = { r = 0.4 , g = 0.4 , b = 1.0 } ,
	enemy_map_color = { r = 1.0 , g = 0.4 , b = 0.4 } ,
	is_military_target = false ,
	allow_run_time_change_of_is_military_target = true ,
	alert_when_damaged = true ,
	create_ghost_on_death = false ,
	hide_resistances = false ,
	resistances =
	{
		SITools.Resistance( "fire" , 0 , 25 )
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
			filename = SIGen.MakeSelfPicturePath( "RuinInserter-Platform" , "遗迹爪子-底座" ) ,
			priority = "extra-high" ,
			width = 46 ,
			height = 46 ,
			scale = 1.0 ,
			shift = { 0.09375 , 0 } ,
			hr_version =
			{
				filename = SIGen.MakeSelfPicturePathHr( "RuinInserter-Platform" , "遗迹爪子-底座" ) ,
				priority = "extra-high" ,
				width = 105 ,
				height = 79 ,
				scale = 0.5 ,
				shift = SIUtils.by_pixel( 1.5 , 6.5 )
			}
		}
	} ,
	hand_base_picture =
	{
		filename = SIGen.MakeSelfPicturePath( "RuinInserter-Base" , "遗迹爪子-基础" ) ,
		priority = "extra-high" ,
		width = 8 ,
		height = 33 ,
		scale = 1.0 ,
		hr_version =
		{
			filename = SIGen.MakeSelfPicturePathHr( "RuinInserter-Base" , "遗迹爪子-基础" ) ,
			priority = "extra-high" ,
			width = 32 ,
			height = 136 ,
			scale = 0.25
		}
	} ,
	hand_base_shadow =
	{
		filename = SIGen.MakeSelfPicturePath( "RuinInserter-Base-Shadow" , "遗迹爪子-基础-影子" ) ,
		priority = "extra-high" ,
		width = 8 ,
		height = 33 ,
		scale = 1.0 ,
		hr_version =
		{
			filename = SIGen.MakeSelfPicturePathHr( "RuinInserter-Base-Shadow" , "遗迹爪子-基础-影子" ) ,
			priority = "extra-high" ,
			width = 32 ,
			height = 132 ,
			scale = 0.25
		}
	} ,
	hand_open_picture =
	{
		filename = SIGen.MakeSelfPicturePath( "RuinInserter-Open" , "遗迹爪子-打开" ) ,
		priority = "extra-high" ,
		width = 18 ,
		height = 41 ,
		scale = 1.0 ,
		hr_version =
		{
			filename = SIGen.MakeSelfPicturePathHr( "RuinInserter-Open" , "遗迹爪子-打开" ) ,
			priority = "extra-high" ,
			width = 72 ,
			height = 164 ,
			scale = 0.25
		}
	} ,
	hand_open_shadow =
	{
		filename = SIGen.MakeSelfPicturePath( "RuinInserter-Open-Shadow" , "遗迹爪子-打开-影子" ) ,
		priority = "extra-high" ,
		width = 18 ,
		height = 41 ,
		scale = 1.0 ,
		hr_version =
		{
			filename = SIGen.MakeSelfPicturePathHr( "RuinInserter-Open-Shadow" , "遗迹爪子-打开-影子" ) ,
			priority = "extra-high" ,
			width = 72 ,
			height = 164 ,
			scale = 0.25
		}
	} ,
	hand_closed_picture =
	{
		filename = SIGen.MakeSelfPicturePath( "RuinInserter-Close" , "遗迹爪子-关闭" ) ,
		priority = "extra-high" ,
		width = 18 ,
		height = 41 ,
		scale = 1.0 ,
		hr_version =
		{
			filename = SIGen.MakeSelfPicturePathHr( "RuinInserter-Close" , "遗迹爪子-关闭" ) ,
			priority = "extra-high" ,
			width = 72 ,
			height = 164 ,
			scale = 0.25
		}
	} ,
	hand_closed_shadow =
	{
		filename = SIGen.MakeSelfPicturePath( "RuinInserter-Close-Shadow" , "遗迹爪子-关闭-影子" ) ,
		priority = "extra-high" ,
		width = 18 ,
		height = 41 ,
		scale = 1.0 ,
		hr_version =
		{
			filename = SIGen.MakeSelfPicturePathHr( "RuinInserter-Close-Shadow" , "遗迹爪子-关闭-影子" ) ,
			priority = "extra-high" ,
			width = 72 ,
			height = 164 ,
			scale = 0.25
		}
	} ,
	mined_sound =
	{
		SISound.Core( "deconstruct-small" , 1 )
	} ,
	vehicle_impact_sound =
	{
		SISound.Base( "car-wood-impact" , 0.5 ) ,
		SISound.Base( "car-wood-impact-02" , 0.5 ) ,
		SISound.Base( "car-wood-impact-03" , 0.5 ) ,
		SISound.Base( "car-wood-impact-04" , 0.5 ) ,
		SISound.Base( "car-wood-impact-05" , 0.5 )
	} ,
	repair_sound =
	{
		SISound.Core( "manual-repair-advanced-1" , 0.5 ) ,
		SISound.Core( "manual-repair-advanced-2" , 0.5 )
	} ,
	open_sound =
	{
		SISound.Base( "wooden-chest-open" , 0.5 )
	} ,
	close_sound =
	{
		SISound.Base( "wooden-chest-close" , 0.5 )
	} ,
	working_sound =
	{
		sound =
		{
			SISound.Base( "inserter-basic-1" , 0.5 ) ,
			SISound.Base( "inserter-basic-2" , 0.5 ) ,
			SISound.Base( "inserter-basic-3" , 0.5 ) ,
			SISound.Base( "inserter-basic-4" , 0.5 ) ,
			SISound.Base( "inserter-basic-5" , 0.5 )
		} ,
		match_progress_to_activity = true ,
		audible_distance_modifier = 0.3
	}
}

-- ======================================================================
-- 遗迹地板
-- ======================================================================
local DefaultTransitionGroupID = 0
local WaterTransitionGroupID = 1
local OutOfMapTransitionGroupID = 2

-- ======================================================================<br>
---@param pictureID string
---@param pictureName string
---@param srcX integer
---@param srcY integer
---@param count integer
---@param lineLength integer
---@param isTall boolean|nil
---@return table
local function MakeTileTransitionPicture( pictureID , pictureName , srcX , srcY , count , lineLength , isTall )
	return
	{
		picture = SIGen.MakeSelfPicturePath( pictureID , pictureName ) ,
		count = count ,
		line_length = lineLength ,
		x = srcX ,
		y = srcY ,
		tall = isTall ,
		scale = 1.0 ,
		hr_version =
		{
			picture = SIGen.MakeSelfPicturePathHr( pictureID , pictureName ) ,
			count = count ,
			line_length = lineLength ,
			x = srcX * 2 ,
			y = ( srcY or 0 ) * 2 ,
			tall = isTall ,
			scale = 0.5
		}
	}
end

-- ======================================================================<br>
---@param options table
---@return table
local function MakeTileTransition( options )
	local data = options.base or {}
	data.to_tiles = options.toTiles
	data.transition_group = options.group1
	data.transition_group1 = options.group2 and options.group1 or nil
	data.transition_group2 = options.group2
	local defaultCount = options.count or 16
	for sizeCode , pictureData in pairs
	{
		innerCorner = { Code = "inner_corner" , Y = 0    } ,
		outerCorner = { Code = "outer_corner" , Y = 288  } ,
		side        = { Code = "side"         , Y = 576  } ,
		uTransition = { Code = "u_transition" , Y = 864  } ,
		oTransition = { Code = "o_transition" , Y = 1152 }
	} do
		local pictureCode = pictureData.Code
		local pictureY = pictureData.Y
		local count = options[sizeCode .. "_Count"] or defaultCount
		if count > 0 then
			local lineLength = options[sizeCode .. "_LineLength"] or count
			local isTall = true
			if options[sizeCode .. "_Tall"] == false then
				isTall = false
			end
			data[pictureCode] = MakeTileTransitionPicture( options.pictureID , options.pictureName , 0 , pictureY , count , lineLength , isTall )
			data[pictureCode .. "_mask"] = MakeTileTransitionPicture( options.pictureID , options.pictureName , 1088 , pictureY , count , lineLength , nil )
			if options.background then
				data[pictureCode .. "_background"] = MakeTileTransitionPicture( options.pictureID , options.pictureName , 544 , pictureY , count , lineLength , isTall )
			end
			if options.effectMap then
				local effectDefaultCount = options.effectMap.count or 16
				local effectCount = options.effectMap[sizeCode .. "_Count"] or effectDefaultCount
				if effectCount > 0 then
					local effectLineLength = options.effectMap[sizeCode .. "_LineLength"] or effectCount
					local effectIsTall = true
					if options.effectMap[sizeCode .. "_Tall"] == false then
						effectIsTall = false
					end
					data[pictureCode .. "_effect_map"] = MakeTileTransitionPicture( options.effectMap.fileID , options.effectMap.fileName , 0 , pictureY , effectCount , effectLineLength , effectIsTall )
				end
			end
		end
	end
	return data
end

SIGen
.New( SICommon.Types.Tile , "RuinFloor" , "遗迹地板" )
.AutoIcon()
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
				picture = SIGen.MakeSelfPicturePath( "RuinFloor-Shape" , "遗迹地板-形状" ) ,
				count = 1 ,
				size = 1 ,
				scale = 1.0
			} ,
			{
				picture = SIGen.MakeSelfPicturePath( "RuinFloor-Shape" , "遗迹地板-形状" ) ,
				count = 1 ,
				size = 2 ,
				probability = 0.39 ,
				scale = 1.0
			} ,
			{
				picture = SIGen.MakeSelfPicturePath( "RuinFloor-Shape" , "遗迹地板-形状" ) ,
				count = 1 ,
				size = 4 ,
				probability = 1 ,
				scale = 1.0
			}
		} ,
		inner_corner =
		{
			picture = SIGen.MakeSelfPicturePath( "RuinFloor-InnerCorner" , "遗迹地板-内角" ) ,
			count = 16 ,
			scale = 1.0 ,
			hr_version =
			{
				picture = SIGen.MakeSelfPicturePathHr( "RuinFloor-InnerCorner" , "遗迹地板-内角" ) ,
				count = 16 ,
				scale = 0.5
			}
		} ,
		inner_corner_mask =
		{
			picture = SIGen.MakeSelfPicturePath( "RuinFloor-InnerCorner-Cover" , "遗迹地板-内角-遮盖" ) ,
			count = 16 ,
			scale = 1.0 ,
			hr_version =
			{
				picture = SIGen.MakeSelfPicturePathHr( "RuinFloor-InnerCorner-Cover" , "遗迹地板-内角-遮盖" ) ,
				count = 16 ,
				scale = 0.5
			}
		} ,
		outer_corner =
		{
			picture = SIGen.MakeSelfPicturePath( "RuinFloor-OuterCorner" , "遗迹地板-外角" ) ,
			count = 8 ,
			scale = 1.0 ,
			hr_version =
			{
				picture = SIGen.MakeSelfPicturePathHr( "RuinFloor-OuterCorner" , "遗迹地板-外角" ) ,
				count = 8 ,
				scale = 0.5
			}
		} ,
		outer_corner_mask =
		{
			picture = SIGen.MakeSelfPicturePath( "RuinFloor-OuterCorner-Cover" , "遗迹地板-外角-遮盖" ) ,
			count = 8 ,
			scale = 1.0 ,
			hr_version =
			{
				picture = SIGen.MakeSelfPicturePathHr( "RuinFloor-OuterCorner-Cover" , "遗迹地板-外角-遮盖" ) ,
				count = 8 ,
				scale = 0.5
			}
		} ,
		side =
		{
			picture = SIGen.MakeSelfPicturePath( "RuinFloor-Side" , "遗迹地板-侧边" ) ,
			count = 16 ,
			scale = 1.0 ,
			hr_version =
			{
				picture = SIGen.MakeSelfPicturePathHr( "RuinFloor-Side" , "遗迹地板-侧边" ) ,
				count = 16 ,
				scale = 0.5
			}
		} ,
		side_mask =
		{
			picture = SIGen.MakeSelfPicturePath( "RuinFloor-Side-Cover" , "遗迹地板-侧边-遮盖" ) ,
			count = 16 ,
			scale = 1.0 ,
			hr_version =
			{
				picture = SIGen.MakeSelfPicturePathHr( "RuinFloor-Side-Cover" , "遗迹地板-侧边-遮盖" ) ,
				count = 16 ,
				scale = 0.5
			}
		} ,
		u_transition =
		{
			picture = SIGen.MakeSelfPicturePath( "RuinFloor-UTransition" , "遗迹地板-凹形" ) ,
			count = 8 ,
			scale = 1.0 ,
			hr_version =
			{
				picture = SIGen.MakeSelfPicturePathHr( "RuinFloor-UTransition" , "遗迹地板-凹形" ) ,
				count = 8 ,
				scale = 0.5
			}
		} ,
		u_transition_mask =
		{
			picture = SIGen.MakeSelfPicturePath( "RuinFloor-UTransition-Cover" , "遗迹地板-凹形-遮盖" ) ,
			count = 8 ,
			scale = 1.0 ,
			hr_version =
			{
				picture = SIGen.MakeSelfPicturePathHr( "RuinFloor-UTransition-Cover" , "遗迹地板-凹形-遮盖" ) ,
				count = 8 ,
				scale = 0.5
			}
		} ,
		o_transition =
		{
			picture = SIGen.MakeSelfPicturePath( "RuinFloor-OTransition" , "遗迹地板-圆形" ) ,
			count = 4 ,
			scale = 1.0 ,
			hr_version =
			{
				picture = SIGen.MakeSelfPicturePathHr( "RuinFloor-OTransition" , "遗迹地板-圆形" ) ,
				count = 4 ,
				scale = 0.5
			}
		} ,
		o_transition_mask =
		{
			picture = SIGen.MakeSelfPicturePath( "RuinFloor-OTransition-Cover" , "遗迹地板-圆形-遮盖" ) ,
			count = 4 ,
			scale = 1.0 ,
			hr_version =
			{
				picture = SIGen.MakeSelfPicturePathHr( "RuinFloor-OTransition-Cover" , "遗迹地板-圆形-遮盖" ) ,
				count = 4 ,
				scale = 0.5
			}
		} ,
		material_background =
		{
			picture = SIGen.MakeSelfPicturePath( "RuinFloor-Background" , "遗迹地板" ) ,
			count = 8 ,
			scale = 1.0 ,
			hr_version =
			{
				picture = SIGen.MakeSelfPicturePathHr( "RuinFloor-Background" , "遗迹地板" ) ,
				count = 8 ,
				scale = 0.5
			}
		}
	} ,
	transitions =
	{
		---@diagnostic disable-next-line: newfield-call
		MakeTileTransition
		{
			pictureID = "RuinFloor-Normal-Transition" ,
			pictureName = "遗迹地板-普通-过渡" ,
			effectMap =
			{
				fileID = "RuinFloor-Water-Stone-Cover" ,
				fileName = "遗迹地板-水面-岩石-遮盖" ,
				count = 1 ,
				oTransition_Tall = false
			} ,
			toTiles = water_tile_type_names ,
			group1 = WaterTransitionGroupID ,
			group2 = nil ,
			innerCorner_Count = 8 ,
			outerCorner_Count = 8 ,
			side_Count = 8 ,
			uTransition_Count = 4 ,
			oTransition_Count = 4 ,
			oTransition_Tall = false ,
			background = false
		} ,
		---@diagnostic disable-next-line: newfield-call
		MakeTileTransition
		{
			pictureID = "RuinFloor-Outside-Transition" ,
			pictureName = "遗迹地板-地图外-过渡" ,
			toTiles = { "out-of-map" } ,
			group1 = OutOfMapTransitionGroupID ,
			group2 = nil ,
			innerCorner_Count = 4 ,
			outerCorner_Count = 4 ,
			side_Count = 8 ,
			uTransition_Count = 1 ,
			oTransition_Count = 1 ,
			oTransition_Tall = false ,
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
		---@diagnostic disable-next-line: newfield-call
		MakeTileTransition
		{
			pictureID = "RuinFloor-Transition-Transition" ,
			pictureName = "遗迹地板-过渡-过渡" ,
			effectMap =
			{
				fileID = "RuinFloor-Water-Stone-Land-Cover" ,
				fileName = "遗迹地板-水面-岩石-陆地-遮盖" ,
				count = 3 ,
				uTransition_Count = 1 ,
				oTransition_Count = 0
			} ,
			toTiles = nil ,
			group1 = DefaultTransitionGroupID ,
			group2 = WaterTransitionGroupID ,
			innerCorner_Count = 3 ,
			innerCorner_Tall = true ,
			outerCorner_Count = 3 ,
			side_Count = 3 ,
			uTransition_Count = 1 ,
			oTransition_Count = 0 ,
			background = false
		} ,
		---@diagnostic disable-next-line: newfield-call
		MakeTileTransition
		{
			pictureID = "RuinFloor-Outside-Transition2" ,
			pictureName = "遗迹地板-地图外-过渡2" ,
			to_tiles = nil ,
			group1 = DefaultTransitionGroupID ,
			group2 = OutOfMapTransitionGroupID ,
			innerCorner_Count = 3 ,
			innerCorner_Tall = true ,
			outerCorner_Count = 3 ,
			side_Count = 3 ,
			uTransition_Count = 1 ,
			oTransition_Count = 0 ,
			background = true ,
			base =
			{
				background_layer_offset = 1 ,
				background_layer_group = "zero" ,
				offset_background_layer_by_tile_layer = true
			}
		} ,
		---@diagnostic disable-next-line: newfield-call
		MakeTileTransition
		{
			pictureID = "RuinFloor-OutsideLandbase-Transition2" ,
			pictureName = "遗迹地板-地图外岸边-过渡" ,
			effectMap =
			{
				fileID = "RuinFloor-Water-Stone-Outside-Cover" ,
				fileName = "遗迹地板-水面-岩石-地图外-遮盖" ,
				count = 3 ,
				uTransition_Count = 0 ,
				oTransition_Count = 0
			} ,
			toTiles = nil ,
			group1 = WaterTransitionGroupID ,
			group2 = OutOfMapTransitionGroupID ,
			innerCorner_Count = 3 ,
			outerCorner_Count = 3 ,
			side_Count = 3 ,
			uTransition_Count = 1 ,
			oTransition_Count = 0 ,
			oTransition_Tall = false ,
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
		SISound.Base( "deconstruct-bricks" , 0.8 )
	} ,
	build_sound =
	{
		small =
		{
			SISound.Core( "build-concrete-small" , 0.4 ) ,
			SISound.Core( "build-concrete-small-1" , 0.4 ) ,
			SISound.Core( "build-concrete-small-2" , 0.4 ) ,
			SISound.Core( "build-concrete-small-3" , 0.4 ) ,
			SISound.Core( "build-concrete-small-4" , 0.4 ) ,
			SISound.Core( "build-concrete-small-5" , 0.4 )
		} ,
		medium =
		{
			SISound.Core( "build-concrete-medium" , 0.4 ) ,
			SISound.Core( "build-concrete-medium-1" , 0.4 ) ,
			SISound.Core( "build-concrete-medium-2" , 0.4 ) ,
			SISound.Core( "build-concrete-medium-3" , 0.4 ) ,
			SISound.Core( "build-concrete-medium-4" , 0.4 ) ,
			SISound.Core( "build-concrete-medium-5" , 0.4 )
		} ,
		large =
		{
			SISound.Core( "build-concrete-large" , 0.4 ) ,
			SISound.Core( "build-concrete-large-1" , 0.4 ) ,
			SISound.Core( "build-concrete-large-2" , 0.4 ) ,
			SISound.Core( "build-concrete-large-3" , 0.4 ) ,
			SISound.Core( "build-concrete-large-4" , 0.4 ) ,
			SISound.Core( "build-concrete-large-5" , 0.4 )
		}
	} ,
	walking_sound =
	{
		SISound.Base( "walking/refined-concrete-01" , 0.5 ) ,
		SISound.Base( "walking/refined-concrete-02" , 0.5 ) ,
		SISound.Base( "walking/refined-concrete-03" , 0.5 ) ,
		SISound.Base( "walking/refined-concrete-04" , 0.5 ) ,
		SISound.Base( "walking/refined-concrete-05" , 0.5 ) ,
		SISound.Base( "walking/refined-concrete-06" , 0.5 ) ,
		SISound.Base( "walking/refined-concrete-07" , 0.5 ) ,
		SISound.Base( "walking/refined-concrete-08" , 0.5 ) ,
		SISound.Base( "walking/refined-concrete-09" , 0.5 ) ,
		SISound.Base( "walking/refined-concrete-10" , 0.5 ) ,
		SISound.Base( "walking/refined-concrete-11" , 0.5 )
	}
}
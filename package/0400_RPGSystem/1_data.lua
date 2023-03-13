-- ------------------------------------------------------------------------------------------------
-- -------- 创建经验物品 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen
.SetGroup( SIConstants_RPGSystem.raw.Groups.Hidden.EXP )
for prefixID , prefixAlias in pairs
{
	Attack = "-战斗" ,
	Adventure = "-探索" ,
	Craft = "-生存"
} do
	for suffixID , suffixAlias in pairs
	{
		_1 = "-1" ,
		_100 = "-100" ,
		_1W = "-1W" ,
		_100W = "-100W" ,
		_1E = "-1E" ,
		_100E = "-100E" ,
		_1WE = "-1WE" ,
	} do
		SIGen
		.New( SICommon.Types.Items.Capsule , "EXP_" .. prefixID .. suffixID , "经验" .. prefixAlias .. suffixAlias ,
		{
			flags = { SICommon.Flags.Item.Hidden } ,
			stack_size = 100 ,
			capsule_action =
			{
				type = "use-on-self" ,
				uses_stack = true ,
				attack_parameters =
				{
					type = "projectile" ,
					cooldown = 4 ,
					range = 0 ,
					activation_type = "consume" ,
					ammo_category = "capsule" ,
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
										type = "instant" ,
										target_effects =
										{
											{
												type = "script" ,
												effect_id = SIConstants_RPGSystem.ExpTrigger[prefixID .. suffixID]
											} ,
											{
												type = "play-sound" ,
												sound = SITools.SoundList_Base( "eat" , 4 , 0.6 )
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
end

-- ------------------------------------------------------------------------------------------------
-- -------- 创建经验箱子 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen
.New( SICommon.Types.Entities.Corpse , "EXPChestRemnants" , "经验箱子-残骸" )
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
		filename = SIGen.MakeSelfPicturePath( "经验箱子-残骸" ) ,
		priority = "extra-high" ,
		width = 64 ,
		height = 40 ,
		frame_count = 1 ,
		line_length = 1 ,
		variation_count = 1 ,
		direction_count = 1 ,
		shift = SIUtils.by_pixel( 12 , 0 )
	}
}
.AutoIcon()
.SetSizeScale( 1 , 1 , 0 )
.New( SICommon.Types.Entities.Container , "EXPChest" , "经验箱子" )
.Append
{
	flags = { SICommon.Flags.Entity.PlaceableEnemy , SICommon.Flags.Entity.NotOnMap } ,
	minable =
	{
		mining_time = 6000.0 ,
		results = {}
	} ,
	max_health = 32 ,
	corpse = SIConstants_RPGSystem.raw.Entities.EXPChestRemnants ,
	dying_explosion = "iron-chest-explosion" ,
	map_color = { r = 1.0 , g = 1.0 , b = 1.0 } ,
	friendly_map_color = { r = 0.4 , g = 0.4 , b = 1.0 } ,
	enemy_map_color = { r = 1.0 , g = 0.4 , b = 0.4 } ,
	alert_when_damaged = false ,
	create_ghost_on_death = false ,
	hide_resistances = false ,
	resistances =
	{
		{
			type = "physical" ,
			percent = 45
		} ,
		{
			type = "impact" ,
			percent = 45
		} ,
		{
			type = "fire" ,
			percent = 45
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
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Container , "经验箱子" ) ,
				priority = "extra-high" ,
				width = 34 ,
				height = 38 ,
				shift = SIUtils.by_pixel( 0 , -0.5 )
			} ,
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Entities.Container , "经验箱子-影子" ) ,
				priority = "extra-high" ,
				width = 56 ,
				height = 26 ,
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
			filename = "__base__/sound/metallic-chest-open.ogg" ,
			volume = 0.5
		}
	} ,
	close_sound =
	{
		{
			filename = "__base__/sound/metallic-chest-close.ogg" ,
			volume = 0.5
		}
	}
}
.AutoIcon()
.SetSize( 1 , 1 )

-- ------------------------------------------------------------------------------------------------
-- -------- 创建图标物品 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen
.SetGroup( SIConstants_Core.raw.Groups.Hidden.Icon )
.AutoIconItem
{
	IconRPG = "图标RPG" ,
	IconRPGYellow = "图标RPG-黄" ,
	IconAddRed = "图标添加-红" ,
	IconAddGreen = "图标添加-绿" ,
	IconAddCyan = "图标添加-青"
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 创建控件 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen
-- ----------------------------------------
-- 玩家属性控件样式
-- ----------------------------------------
.AddStyle( "PlayerStatus_Frame" , "玩家属性-窗口" ,
{
	type = "frame_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Frame ,
	-- 体积
	minimal_width = 100 ,
	minimal_height = 100 ,
	maximal_height = 740
} )
.AddStyle( "PlayerStatus_LevelList" , "玩家属性-等级列表" ,
{
	type = "table_style" ,
	parent = SIConstants_Core.raw.Styles.Common_List ,
	-- 体积
	minimal_width = 0 ,
	minimal_height = 0 ,
	-- 元素间距
	horizontal_spacing = 15
} )
.AddStyle( "PlayerStatus_LevelTitle" , "玩家属性-等级标题" ,
{
	type = "label_style" ,
	-- 体积
	width = 120 ,
	-- 对齐
	horizontal_align = "center" ,
	-- 富文本
	single_line = true
} )
.AddStyle( "PlayerStatus_LevelLabel" , "玩家属性-等级标签" ,
{
	type = "label_style" ,
	-- 体积
	minimal_width = 40 ,
	-- 对齐
	horizontal_align = "center" ,
	-- 富文本
	single_line = true
} )
.AddStyle( "PlayerStatus_ProgressRed" , "玩家属性-进度条-红" ,
{
	type = "progressbar_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Progress ,
	-- 体积
	width = 360 ,
	height = 24 ,
	bar_width = 22 ,
	-- 图形
	color = { r = 1 , g = 0.4 , b = 0.4 , a = 1 }
} )
.AddStyle( "PlayerStatus_ProgressGreen" , "玩家属性-进度条-绿" ,
{
	type = "progressbar_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Progress ,
	-- 体积
	width = 360 ,
	height = 24 ,
	bar_width = 22 ,
	-- 图形
	color = { r = 0.4 , g = 1 , b = 0.4 , a = 1 }
} )
.AddStyle( "PlayerStatus_ProgressCyan" , "玩家属性-进度条-青" ,
{
	type = "progressbar_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Progress ,
	-- 体积
	width = 360 ,
	height = 24 ,
	bar_width = 22 ,
	-- 图形
	color = { r = 0.4 , g = 1 , b = 1 , a = 1 }
} )
.AddStyle( "PlayerStatus_PointLabel" , "玩家属性-点数标签" ,
{
	type = "label_style" ,
	-- 体积
	minimal_width = 40 ,
	-- 对齐
	horizontal_align = "left" ,
	-- 富文本
	single_line = true
} )
.AddStyle( "PlayerStatus_Flow" , "玩家属性-布局" ,
{
	type = "horizontal_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowTop ,
	-- 元素间距
	horizontal_spacing = 15
} )
.AddStyle( "PlayerStatus_BarList" , "玩家属性-条列表" ,
{
	type = "table_style" ,
	parent = SIConstants_Core.raw.Styles.Common_List ,
	-- 体积
	minimal_width = 0 ,
	minimal_height = 0 ,
	-- 元素间距
	horizontal_spacing = 6
} )
.AddStyle( "PlayerStatus_ValueList" , "玩家属性-数值列表" ,
{
	type = "table_style" ,
	parent = SIConstants_Core.raw.Styles.Common_List ,
	-- 体积
	minimal_width = 0 ,
	minimal_height = 0 ,
	-- 元素间距
	horizontal_spacing = 6
} )
.AddStyle( "PlayerStatus_ListValue" , "玩家属性-列表标签数值" ,
{
	type = "label_style" ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 80 ,
	height = 20 ,
	-- 对齐
	horizontal_align = "center" ,
	vertical_align = "center" ,
	-- 富文本
	single_line = true
} )
.AddStyle( "PlayerStatus_ListValueFlow" , "玩家属性-列表布局数值" ,
{
	type = "horizontal_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowCenterH ,
	-- 元素间距
	horizontal_spacing = 0
} )
.AddStyle( "PlayerStatus_ListValueLeft" , "玩家属性-列表标签数值左" ,
{
	type = "label_style" ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 70 ,
	height = 20 ,
	-- 对齐
	horizontal_align = "right" ,
	vertical_align = "center" ,
	-- 富文本
	single_line = true
} )
.AddStyle( "PlayerStatus_ListValueCenter" , "玩家属性-列表标签数值中" ,
{
	type = "label_style" ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 10 ,
	height = 20 ,
	-- 对齐
	horizontal_align = "center" ,
	vertical_align = "center" ,
	-- 富文本
	single_line = true
} )
.AddStyle( "PlayerStatus_ListValueRight" , "玩家属性-列表标签数值右" ,
{
	type = "label_style" ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 60 ,
	height = 20 ,
	-- 对齐
	horizontal_align = "left" ,
	vertical_align = "center" ,
	-- 富文本
	single_line = true
} )
.AddStyle( "PlayerStatus_ProgressHealth" , "玩家属性-进度条-健康值" ,
{
	type = "progressbar_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Progress ,
	-- 体积
	width = 220 ,
	height = 20 ,
	bar_width = 18 ,
	-- 图形
	color = { r = 0.93 , g = 0.4 , b = 0.25 , a = 1 }
} )
.AddStyle( "PlayerStatus_ProgressStrength" , "玩家属性-进度条-体力值" ,
{
	type = "progressbar_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Progress ,
	-- 体积
	width = 220 ,
	height = 20 ,
	bar_width = 18 ,
	-- 图形
	color = { r = 0.16 , g = 0.87 , b = 0.79 , a = 1 }
} )
.AddStyle( "PlayerStatus_ProgressMana" , "玩家属性-进度条-魔法值" ,
{
	type = "progressbar_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Progress ,
	-- 体积
	width = 220 ,
	height = 20 ,
	bar_width = 18 ,
	-- 图形
	color = { r = 0.3 , g = 0.59 , b = 0.91 , a = 1 }
} )
.AddStyle( "PlayerStatus_ProgressEnergy" , "玩家属性-进度条-能量值" ,
{
	type = "progressbar_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Progress ,
	-- 体积
	width = 220 ,
	height = 20 ,
	bar_width = 18 ,
	-- 图形
	color = { r = 0.7 , g = 0.91 , b = 0.3 , a = 1 }
} )
.AddStyle( "PlayerStatus_ProgressThought" , "玩家属性-进度条-精神值" ,
{
	type = "progressbar_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Progress ,
	-- 体积
	width = 220 ,
	height = 20 ,
	bar_width = 18 ,
	-- 图形
	color = { r = 0.73 , g = 0.42 , b = 0.87 , a = 1 }
} )
.AddStyle( "PlayerStatus_ProgressSoul" , "玩家属性-进度条-灵魂值" ,
{
	type = "progressbar_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Progress ,
	-- 体积
	width = 220 ,
	height = 20 ,
	bar_width = 18 ,
	-- 图形
	color = { r = 0.78 , g = 0.65 , b = 0.18 , a = 1 }
} )
.AddStyle( "PlayerStatus_List" , "玩家属性-列表" ,
{
	type = "table_style" ,
	parent = SIConstants_Core.raw.Styles.Common_List ,
	-- 体积
	minimal_width = 0 ,
	minimal_height = 0 ,
	-- 元素间距
	horizontal_spacing = 6
} )
.AddStyle( "PlayerStatus_ListLabelTitleShort" , "玩家属性-列表标签标题-短" ,
{
	type = "label_style" ,
	-- 体积
	width = 50 ,
	height = 24 ,
	-- 对齐
	horizontal_align = "center" ,
	vertical_align = "center" ,
	-- 富文本
	single_line = true
} )
.AddStyle( "PlayerStatus_ListLabelTitleLong" , "玩家属性-列表标签标题-长" ,
{
	type = "label_style" ,
	-- 体积
	width = 110 ,
	height = 24 ,
	-- 对齐
	horizontal_align = "center" ,
	vertical_align = "center" ,
	-- 富文本
	single_line = true
} )
.AddStyle( "PlayerStatus_ListLabelLevel" , "玩家属性-列表标签等级" ,
{
	type = "label_style" ,
	-- 体积
	width = 95 ,
	height = 24 ,
	-- 对齐
	horizontal_align = "center" ,
	vertical_align = "center" ,
	-- 富文本
	single_line = true
} )
.AddStyle( "PlayerStatus_ListLabelEffect" , "玩家属性-列表标签效果" ,
{
	type = "label_style" ,
	-- 体积
	width = 145 ,
	height = 24 ,
	-- 对齐
	horizontal_align = "center" ,
	vertical_align = "center" ,
	-- 富文本
	single_line = true
} )
.AddStyle( "PlayerStatus_AddingButton" , "玩家属性-添加属性按钮" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonTitle ,
	-- 偏移
	top_padding = 1 ,
	right_padding = 1 ,
	bottom_padding = 1 ,
	left_padding = 1 ,
	-- 体积
	width = 24 ,
	height = 24
} )
.AddStyle( "PlayerStatus_ListFlow" , "玩家属性-列表布局" ,
{
	type = "horizontal_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowCenterH ,
	-- 元素间距
	horizontal_spacing = 1
} )
.AddStyle( "PlayerStatus_Slider" , "玩家属性-滑块" ,
{
	type = "slider_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Slider ,
	-- 体积
	width = 120 ,
	height = 12 ,
	-- 滑块按钮
	button =
	{
		type = "button_style" ,
		parent = SIConstants_Core.raw.Styles.Common_SliderButton ,
		-- 显示
		tooltip = "SIRPGSystem.玩家属性-窗口-适用等级-提示" -- 神 TM 需要在原型里设置 , 在 control 里设置就无效
	}
} )
.AddStyle( "PlayerStatus_Number" , "玩家属性-数字框" ,
{
	type = "textbox_style" ,
	-- 体积
	width = 60 ,
	height = 24
} )
-- ----------------------------------------
-- 玩家属性迷你控件样式
-- ----------------------------------------
.AddStyle( "PlayerStatusMini_Frame" , "玩家属性迷你-窗口" ,
{
	type = "frame_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Frame ,
	-- 体积
	minimal_width = 100 ,
	minimal_height = 20 ,
	maximal_height = 700
} )
.AddStyle( "PlayerStatusMini_Flow" , "玩家属性迷你-布局" ,
{
	type = "horizontal_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowTop ,
	-- 元素间距
	horizontal_spacing = 8
} )
.AddStyle( "PlayerStatusMini_LevelList" , "玩家属性迷你-等级列表" ,
{
	type = "table_style" ,
	parent = SIConstants_Core.raw.Styles.Common_List ,
	-- 体积
	minimal_width = 0 ,
	minimal_height = 0 ,
	-- 元素间距
	horizontal_spacing = 8
} )
.AddStyle( "PlayerStatusMini_LevelLabel" , "玩家属性迷你-等级标签" ,
{
	type = "label_style" ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 69 ,
	height = 14 ,
	-- 对齐
	horizontal_align = "center" ,
	vertical_align = "center" ,
	-- 字体
	font = SIConstants_Core.raw.Fonts.CommonSmall ,
	-- 富文本
	single_line = true
} )
.AddStyle( "PlayerStatusMini_ProgressRed" , "玩家属性迷你-进度条-红" ,
{
	type = "progressbar_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Progress ,
	-- 体积
	width = 100 ,
	height = 14 ,
	bar_width = 12 ,
	-- 图形
	color = { r = 1 , g = 0.4 , b = 0.4 , a = 1 }
} )
.AddStyle( "PlayerStatusMini_ProgressGreen" , "玩家属性迷你-进度条-绿" ,
{
	type = "progressbar_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Progress ,
	-- 体积
	width = 100 ,
	height = 14 ,
	bar_width = 12 ,
	-- 图形
	color = { r = 0.4 , g = 1 , b = 0.4 , a = 1 }
} )
.AddStyle( "PlayerStatusMini_ProgressCyan" , "玩家属性迷你-进度条-青" ,
{
	type = "progressbar_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Progress ,
	-- 体积
	width = 100 ,
	height = 14 ,
	bar_width = 12 ,
	-- 图形
	color = { r = 0.4 , g = 1 , b = 1 , a = 1 }
} )
.AddStyle( "PlayerStatusMini_ButtonFlow" , "玩家属性迷你-按钮布局" ,
{
	type = "vertical_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowLeft ,
	-- 元素间距
	vertical_spacing = 8
} )
.AddStyle( "PlayerStatusMini_ButtonList" , "玩家属性迷你-按钮列表" ,
{
	type = "table_style" ,
	parent = SIConstants_Core.raw.Styles.Common_List ,
	-- 体积
	minimal_width = 0 ,
	minimal_height = 0 ,
	-- 元素间距
	cell_spacing = 0 ,
	horizontal_spacing = 0 ,
	vertical_spacing = 0
} )
.AddStyle( "PlayerStatusMini_AddingButton" , "玩家属性迷你-添加按钮" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonTitle ,
	-- 偏移
	top_padding = 1 ,
	right_padding = 1 ,
	bottom_padding = 1 ,
	left_padding = 1 ,
	-- 体积
	width = 22 ,
	height = 22
} )
-- ----------------------------------------
-- 玩家信息控件样式
-- ----------------------------------------
.AddStyle( "PlayerInfo_Frame" , "玩家信息-窗口" ,
{
	type = "frame_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Frame ,
	-- 体积
	minimal_width = 100 ,
	minimal_height = 20 ,
	maximal_height = 700
} )
.AddStyle( "PlayerInfo_Flow" , "玩家信息-布局" ,
{
	type = "horizontal_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowTop ,
	-- 元素间距
	horizontal_spacing = 6
} )
.AddStyle( "PlayerInfo_ValueList" , "玩家信息-数值列表" ,
{
	type = "table_style" ,
	parent = SIConstants_Core.raw.Styles.Common_List ,
	-- 体积
	minimal_width = 0 ,
	minimal_height = 0 ,
	-- 元素间距
	horizontal_spacing = 8
} )
.AddStyle( "PlayerInfo_ListValueFlow" , "玩家信息-列表布局数值" ,
{
	type = "horizontal_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowCenterH ,
	-- 元素间距
	horizontal_spacing = 0
} )
.AddStyle( "PlayerInfo_ListValueLeft" , "玩家信息-列表标签数值左" ,
{
	type = "label_style" ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 58 ,
	height = 14 ,
	-- 对齐
	horizontal_align = "right" ,
	vertical_align = "center" ,
	-- 字体
	font = SIConstants_Core.raw.Fonts.CommonSmall ,
	-- 富文本
	single_line = true
} )
.AddStyle( "PlayerInfo_ListValueCenter" , "玩家信息-列表标签数值中" ,
{
	type = "label_style" ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 8 ,
	height = 14 ,
	-- 对齐
	horizontal_align = "center" ,
	vertical_align = "center" ,
	-- 字体
	font = SIConstants_Core.raw.Fonts.CommonSmall ,
	-- 富文本
	single_line = true
} )
.AddStyle( "PlayerInfo_ListValueRight" , "玩家信息-列表标签数值右" ,
{
	type = "label_style" ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 50 ,
	height = 14 ,
	-- 对齐
	horizontal_align = "left" ,
	vertical_align = "center" ,
	-- 字体
	font = SIConstants_Core.raw.Fonts.CommonSmall ,
	-- 富文本
	single_line = true
} )
.AddStyle( "PlayerInfo_ProgressHealth" , "玩家信息-进度条-健康值" ,
{
	type = "progressbar_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Progress ,
	-- 体积
	width = 100 ,
	height = 14 ,
	bar_width = 12 ,
	-- 图形
	color = { r = 0.93 , g = 0.4 , b = 0.25 , a = 1 }
} )
.AddStyle( "PlayerInfo_ProgressStrength" , "玩家信息-进度条-体力值" ,
{
	type = "progressbar_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Progress ,
	-- 体积
	width = 100 ,
	height = 14 ,
	bar_width = 12 ,
	-- 图形
	color = { r = 0.16 , g = 0.87 , b = 0.79 , a = 1 }
} )
.AddStyle( "PlayerInfo_ProgressMana" , "玩家信息-进度条-魔法值" ,
{
	type = "progressbar_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Progress ,
	-- 体积
	width = 100 ,
	height = 14 ,
	bar_width = 12 ,
	-- 图形
	color = { r = 0.3 , g = 0.59 , b = 0.91 , a = 1 }
} )
.AddStyle( "PlayerInfo_ProgressEnergy" , "玩家信息-进度条-能量值" ,
{
	type = "progressbar_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Progress ,
	-- 体积
	width = 100 ,
	height = 14 ,
	bar_width = 12 ,
	-- 图形
	color = { r = 0.7 , g = 0.91 , b = 0.3 , a = 1 }
} )
.AddStyle( "PlayerInfo_ProgressThought" , "玩家信息-进度条-精神值" ,
{
	type = "progressbar_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Progress ,
	-- 体积
	width = 100 ,
	height = 14 ,
	bar_width = 12 ,
	-- 图形
	color = { r = 0.73 , g = 0.42 , b = 0.87 , a = 1 }
} )
.AddStyle( "PlayerInfo_ProgressSoul" , "玩家信息-进度条-灵魂值" ,
{
	type = "progressbar_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Progress ,
	-- 体积
	width = 100 ,
	height = 14 ,
	bar_width = 12 ,
	-- 图形
	color = { r = 0.78 , g = 0.65 , b = 0.18 , a = 1 }
} )
.AddStyle( "PlayerInfo_ButtonFlow" , "玩家信息-按钮布局" ,
{
	type = "vertical_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowLeft ,
	-- 元素间距
	vertical_spacing = 8
} )
.AddStyle( "PlayerInfo_ButtonList" , "玩家信息-按钮列表" ,
{
	type = "table_style" ,
	parent = SIConstants_Core.raw.Styles.Common_List ,
	-- 体积
	minimal_width = 0 ,
	minimal_height = 0 ,
	-- 元素间距
	cell_spacing = 0 ,
	horizontal_spacing = 0 ,
	vertical_spacing = 0
} )
.AddStyle( "PlayerInfo_AddingButton" , "玩家信息-添加按钮" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonTitle ,
	-- 偏移
	top_padding = 1 ,
	right_padding = 1 ,
	bottom_padding = 1 ,
	left_padding = 1 ,
	-- 体积
	width = 22 ,
	height = 22
} )
-- ----------------------------------------
-- 玩家技能控件样式
-- ----------------------------------------
.AddStyle( "PlayerSkill_Frame" , "玩家技能-窗口" ,
{
	type = "frame_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Frame ,
	-- 体积
	minimal_width = 100 ,
	minimal_height = 20 ,
	maximal_height = 700
} )
.AddStyle( "PlayerSkill_PointList" , "玩家技能-点数列表" ,
{
	type = "table_style" ,
	parent = SIConstants_Core.raw.Styles.Common_List ,
	-- 体积
	minimal_width = 0 ,
	minimal_height = 0 ,
	-- 元素间距
	horizontal_spacing = 8
} )
.AddStyle( "PlayerSkill_PointLabel" , "玩家技能-点数标签" ,
{
	type = "label_style" ,
	-- 体积
	minimal_width = 40 ,
	height = 20 ,
	-- 对齐
	horizontal_align = "left" ,
	vertical_align = "center" ,
	-- 富文本
	single_line = true
} )
.AddStyle( "PlayerSkill_SkillList" , "玩家技能-技能列表" ,
{
	type = "table_style" ,
	-- 体积
	width = 860 ,
	minimal_height = 564 ,
	-- 元素间距
	cell_spacing = 2 ,
	horizontal_spacing = 6 ,
	vertical_spacing = 1 ,
	-- 图形
	horizontal_line_color = { r = 0 , g = 0 , b = 0 , a = 1 } ,
	vertical_line_color = { r = 0 , g = 0 , b = 0 , a = 1 }
} )
.AddStyle( "PlayerSkill_ListFlowH" , "玩家技能-列表布局横" ,
{
	type = "horizontal_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowCenterH ,
	-- 元素间距
	horizontal_spacing = 0
} )
.AddStyle( "PlayerSkill_ListFlowV" , "玩家技能-列表布局竖" ,
{
	type = "vertical_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowCenterV ,
	-- 偏移
	top_padding = 6 ,
	right_padding = 5 ,
	bottom_padding = 6 ,
	left_padding = 5 ,
	-- 元素间距
	vertical_spacing = 0
} )
.AddStyle( "PlayerSkill_ListFlowPoint" , "玩家技能-列表布局点数" ,
{
	type = "horizontal_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowCenterH ,
	-- 体积
	height = 30 ,
	-- 元素间距
	horizontal_spacing = 6
} )
.AddStyle( "PlayerSkill_ListFlowSlider" , "玩家技能-列表布局滑块" ,
{
	type = "horizontal_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowCenterH ,
	-- 体积
	height = 30 ,
	-- 元素间距
	horizontal_spacing = 1
} )
.AddStyle( "PlayerSkill_SkillItemButtonBlue" , "玩家技能-技能物品按钮蓝" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonBlue ,
	-- 偏移
	top_padding = 1 ,
	right_padding = 1 ,
	bottom_padding = 1 ,
	left_padding = 1 ,
	-- 体积
	width = 24 ,
	height = 24
} )
.AddStyle( "PlayerSkill_SkillItemButtonPurple" , "玩家技能-技能物品按钮紫" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonPurple ,
	-- 偏移
	top_padding = 1 ,
	right_padding = 1 ,
	bottom_padding = 1 ,
	left_padding = 1 ,
	-- 体积
	width = 24 ,
	height = 24
} )
.AddStyle( "PlayerSkill_SkillItemButtonOrange" , "玩家技能-技能物品按钮橙" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonOrange ,
	-- 偏移
	top_padding = 1 ,
	right_padding = 1 ,
	bottom_padding = 1 ,
	left_padding = 1 ,
	-- 体积
	width = 24 ,
	height = 24
} )
.AddStyle( "PlayerSkill_ListTitle" , "玩家技能-列表标题" ,
{
	type = "label_style" ,
	-- 体积
	width = 226 ,
	height = 24 ,
	-- 对齐
	horizontal_align = "center" ,
	vertical_align = "center" ,
	-- 富文本
	single_line = true
} )
.AddStyle( "PlayerSkill_ListDesc" , "玩家技能-列表说明" ,
{
	type = "label_style" ,
	-- 偏移
	top_padding = 1 ,
	right_padding = 1 ,
	bottom_padding = 1 ,
	left_padding = 1 ,
	-- 体积
	width = 250 ,
	height = 66 ,
	-- 对齐
	horizontal_align = "left" ,
	vertical_align = "top" ,
	-- 字体
	font = SIConstants_Core.raw.Fonts.CommonSmall ,
	-- 富文本
	single_line = false
} )
.AddStyle( "PlayerSkill_ListPart" , "玩家技能-列表部分" ,
{
	type = "label_style" ,
	-- 偏移
	top_padding = 1 ,
	right_padding = 1 ,
	bottom_padding = 1 ,
	left_padding = 1 ,
	-- 体积
	width = 140 ,
	height = 30 ,
	-- 对齐
	horizontal_align = "center" ,
	vertical_align = "center" ,
	-- 字体
	font = SIConstants_Core.raw.Fonts.CommonSmall ,
	-- 富文本
	single_line = true
} )
.AddStyle( "PlayerSkill_ListLevel" , "玩家技能-列表等级" ,
{
	type = "label_style" ,
	-- 体积
	width = 80 ,
	height = 30 ,
	-- 对齐
	horizontal_align = "center" ,
	vertical_align = "center" ,
	-- 富文本
	single_line = true
} )
.AddStyle( "PlayerSkill_ListValue" , "玩家技能-列表数值" ,
{
	type = "label_style" ,
	-- 体积
	width = 140 ,
	height = 30 ,
	-- 对齐
	horizontal_align = "center" ,
	vertical_align = "center" ,
	-- 富文本
	single_line = true
} )
.AddStyle( "PlayerSkill_AddingButton" , "玩家技能-添加属性按钮" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonTitle ,
	-- 偏移
	top_padding = 1 ,
	right_padding = 1 ,
	bottom_padding = 1 ,
	left_padding = 1 ,
	-- 体积
	width = 24 ,
	height = 24
} )
.AddStyle( "PlayerSkill_Slider" , "玩家技能-滑块" ,
{
	type = "slider_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Slider ,
	-- 体积
	width = 120 ,
	height = 12 ,
	-- 滑块按钮
	button =
	{
		type = "button_style" ,
		parent = SIConstants_Core.raw.Styles.Common_SliderButton ,
		-- 显示
		tooltip = "SIRPGSystem.玩家技能-窗口-适用等级-提示" -- 神 TM 需要在原型里设置 , 在 control 里设置就无效
	}
} )
.AddStyle( "PlayerSkill_Number" , "玩家技能-数字框" ,
{
	type = "textbox_style" ,
	-- 体积
	width = 60 ,
	height = 24
} )
-- ----------------------------------------
-- 玩家技能迷你控件样式
-- ----------------------------------------
.AddStyle( "PlayerSkillMini_Frame" , "玩家技能迷你-窗口" ,
{
	type = "frame_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Frame ,
	-- 体积
	minimal_width = 100 ,
	minimal_height = 20 ,
	maximal_height = 700
} )
.AddStyle( "PlayerSkillMini_Flow" , "玩家技能迷你-布局" ,
{
	type = "horizontal_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowTop ,
	-- 元素间距
	horizontal_spacing = 6
} )
.AddStyle( "PlayerSkillMini_List" , "玩家技能迷你-列表" ,
{
	type = "table_style" ,
	-- 体积
	minimal_width = 96 ,
	minimal_height = 48 ,
	-- 元素间距
	cell_spacing = 0 ,
	horizontal_spacing = 0 ,
	vertical_spacing = 0
} )
.AddStyle( "PlayerSkillMini_SkillButton" , "玩家技能迷你-技能按钮" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonPurple ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 24 ,
	height = 24
} )
.AddStyle( "PlayerSkillMini_ButtonFlow" , "玩家技能迷你-按钮布局" ,
{
	type = "vertical_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowLeft ,
	-- 元素间距
	vertical_spacing = 8
} )
.AddStyle( "PlayerSkillMini_ButtonList" , "玩家技能迷你-按钮列表" ,
{
	type = "table_style" ,
	parent = SIConstants_Core.raw.Styles.Common_List ,
	-- 体积
	minimal_width = 0 ,
	minimal_height = 0 ,
	-- 元素间距
	cell_spacing = 0 ,
	horizontal_spacing = 0 ,
	vertical_spacing = 0
} )
.AddStyle( "PlayerSkillMini_AddingButton" , "玩家技能迷你-添加按钮" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonTitle ,
	-- 偏移
	top_padding = 1 ,
	right_padding = 1 ,
	bottom_padding = 1 ,
	left_padding = 1 ,
	-- 体积
	width = 22 ,
	height = 22
} )
-- ----------------------------------------
-- 玩家设置控件样式
-- ----------------------------------------
.AddStyle( "PlayerSetting_Frame" , "玩家设置-窗口" ,
{
	type = "frame_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Frame ,
	-- 体积
	minimal_width = 100 ,
	minimal_height = 100 ,
	maximal_height = 700
} )
.AddStyle( "PlayerSetting_LabelTop" , "玩家设置-标签顶部" ,
{
	type = "label_style" ,
	-- 体积
	minimal_width = 300 ,
	-- 对齐
	horizontal_align = "left" ,
	-- 富文本
	single_line = false
} )
.AddStyle( "PlayerSetting_ListTitleFlow" , "玩家设置-列表标题布局" ,
{
	type = "horizontal_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowCenterH ,
	-- 体积
	width = 170
} )
.AddStyle( "PlayerSetting_ListLabel" , "玩家设置-列表标签" ,
{
	type = "label_style" ,
	-- 对齐
	horizontal_align = "left"
} )
.AddStyle( "PlayerSetting_ListCheck" , "玩家设置-列表复选" ,
{
	type = "checkbox_style" ,
	parent = SIConstants_Core.raw.Styles.Common_CheckBox ,
	-- 体积
	width = 200
} )
.AddStyle( "PlayerSetting_ListItemFlow" , "玩家设置-列表元素布局" ,
{
	type = "horizontal_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowCenterH ,
	-- 体积
	width = 200 ,
	-- 元素间距
	horizontal_spacing = 1
} )
.AddStyle( "PlayerSetting_ListPlace" , "玩家设置-列表占位" ,
{
	type = "label_style" ,
	-- 体积
	width = 120 ,
	-- 对齐
	horizontal_align = "left"
} )
.AddStyle( "PlayerSetting_Slider" , "玩家设置-滑块" ,
{
	type = "slider_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Slider ,
	-- 体积
	width = 139 ,
	height = 12 ,
	-- 滑块按钮
	button =
	{
		type = "button_style" ,
		parent = SIConstants_Core.raw.Styles.Common_SliderButton ,
		-- 显示
		tooltip = "SIRPGSystem.玩家设置-窗口-设置-玩家技能迷你每行显示的技能数量-提示" -- 神 TM 需要在原型里设置 , 在 control 里设置就无效
	}
} )
.AddStyle( "PlayerSetting_Number" , "玩家设置-数字框" ,
{
	type = "textbox_style" ,
	-- 体积
	width = 60
} )
.AddStyle( "PlayerSetting_DropDown" , "玩家设置-下拉列表" ,
{
	type = "dropdown_style" ,
	parent = SIConstants_Core.raw.Styles.Common_DropDown ,
	-- 体积
	width = 200 ,
	height = 28
} )
-- ----------------------------------------
-- 技能面板洞察控件样式
-- ----------------------------------------
.AddStyle( "SkillUI_OverView_Frame" , "技能面板-洞察-窗口" ,
{
	type = "frame_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Frame ,
	-- 体积
	minimal_width = 100 ,
	minimal_height = 100 ,
	maximal_height = 700
} )
.AddStyle( "SkillUI_OverView_LabelTitle" , "技能面板-洞察-标签标题" ,
{
	type = "label_style" ,
	-- 体积
	width = 400 ,
	-- 对齐
	horizontal_align = "left" ,
	vertical_align = "center" ,
	-- 富文本
	single_line = true
} )
.AddStyle( "SkillUI_OverView_LabelPoint" , "技能面板-洞察-标签坐标" ,
{
	type = "label_style" ,
	-- 体积
	width = 450 ,
	height = 30 ,
	-- 对齐
	horizontal_align = "left" ,
	vertical_align = "center" ,
	-- 富文本
	single_line = true
} )
.AddStyle( "SkillUI_OverView_PointList" , "技能面板-洞察-坐标列表" ,
{
	type = "table_style" ,
	-- 体积
	width = 450 ,
	minimal_height = 400 ,
	-- 元素间距
	cell_spacing = 2 ,
	horizontal_spacing = 6 ,
	vertical_spacing = 1
} )
.AddStyle( "SkillUI_OverView_Map_Camera" , "技能面板-洞察-地图-相机" ,
{
	type = "camera_style" ,
	-- 体积
	width = 320 ,
	height = 320
} )
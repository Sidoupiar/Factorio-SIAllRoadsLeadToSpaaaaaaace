-- ------------------------------------------------------------------------------------------------
-- ------- 创建窗口快捷键 -------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen
.New( SICommon.Types.Input , "OreMapFrame" , "黄图窗口" , { key_sequence = "SHIFT + O" } )
.New( SICommon.Types.Input , "RequestMapFrame" , "紫图窗口" , { key_sequence = "SHIFT + P" } )

-- ------------------------------------------------------------------------------------------------
-- -------- 创建图标物品 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen
.SetGroup( SIConstants_Core.raw.Groups.Hidden.Icon )
.AutoIconItem
{
	IconEmpty = "图标空的" ,
	IconFind = "图标查询" ,
	IconEdit = "图标修改" ,
	IconSave = "图标保存" ,
	IconSetting = "图标设置" ,
	IconToolbar = "图标工具" ,
	IconNote = "图标便签" ,
	IconMessage = "图标消息" ,
	IconFindYellow = "图标查询-黄" ,
	IconEditYellow = "图标修改-黄" ,
	IconSaveYellow = "图标保存-黄" ,
	IconSettingYellow = "图标设置-黄" ,
	IconToolbarYellow = "图标工具-黄" ,
	IconNoteYellow = "图标便签-黄" ,
	IconMessageYellow = "图标消息-黄" ,
	IconSettingWhite = "图标设置-白" ,
	IconNext1 = "图标前进1" ,
	IconNext2 = "图标前进2" ,
	IconBack1 = "图标后退1" ,
	IconBack2 = "图标后退2" ,
	IconToUp = "图标向上" ,
	IconToRight = "图标向右" ,
	IconToDown = "图标向下" ,
	IconToLeft = "图标向左" ,
	IconToCenter = "图标向中" ,
	IconOnTop = "图标最顶部" ,
	IconOnRight = "图标最右侧" ,
	IconOnBottom = "图标最底部" ,
	IconOnLeft = "图标最左侧" ,
	IconArrow = "图标箭头" ,
	IconStar = "图标星星" ,
	IconDoc = "图标文档" ,
	IconTip = "图标提示" ,
	IconMini = "图标小窗口" ,
	IconLock = "图标锁定" ,
	IconUnlock = "图标解锁" ,
	IconClose = "图标关闭" ,
	IconAdd = "图标添加" ,
	-- 纯色图标
	IconColorSky = "图标纯色天色" ,
	IconColorCopper = "图标纯色铜色" ,
	IconColorGrass = "图标纯色草色" ,
	IconColorDream = "图标纯色梦色" ,
	IconColorSliver = "图标纯色银色" ,
	IconColorMeat = "图标纯色肉色"
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 创建控件 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen
-- 字体
.AddFont( "Common" , "通用字体" , 14 )
.AddFont( "CommonSmall" , "通用字体小" , 12 )
.AddFont( "CommonMini" , "通用字体微" , 10 )
.AddFont( "CommonTitle" , "通用标题字体" , 18 , nil , nil , "default-bold" )
.AddFont( "CommonDropDown" , "通用下拉列表字体" , 14 , nil , nil , "default-semibold" )
.AddFont( "Mainbar" , "主面板" , 10 )
.AddFont( "MainbarButton" , "主面板按钮" , 10 )
.AddFont( "MainbarNote" , "主面板便签" , 10 )
-- ----------------------------------------
-- 通用控件样式
-- ----------------------------------------
.AddStyle( "Common_FrameTitleLabel" , "通用-窗口标题标签" ,
{
	type = "label_style" ,
	-- 偏移
	top_padding = -3 ,
	bottom_padding = 3 ,
	-- 体积
	height = 24 ,
	-- 字体
	font = SIConstants_Core.raw.Fonts.CommonTitle ,
	font_color = SICommon.Colors.FontColor.Title ,
	disabled_font_color = SICommon.Colors.FontColor.Disable_Default ,
	-- 富文本
	rich_text_setting = "enabled" ,
	single_line = true ,
	rich_text_highlight_error_color = SICommon.Colors.FontColor.RED ,
	rich_text_highlight_warning_color = SICommon.Colors.FontColor.YELLOW ,
	rich_text_highlight_ok_color = SICommon.Colors.FontColor.GREEN
} )
.AddStyle( "Common_Frame" , "通用-窗口" ,
{
	type = "frame_style" ,
	-- 偏移
	top_padding = 4 ,
	right_padding = 8 ,
	bottom_padding = 8 ,
	left_padding = 8 ,
	-- 图形
	graphical_set =
	{
		base =
		{
			position = { 0 , 0 } ,
			corner_size = 8
		} ,
		shadow = SIStyle.Dirt.Shadow
	} ,
	-- 水平和垂直滚动条
	horizontal_flow_style =
	{
		-- 内容位于 Gui.Direction.Horizontal
		type = "horizontal_flow_style"
	} ,
	vertical_flow_style =
	{
		-- 内容位于 Gui.Direction.Vertical
		type = "vertical_flow_style"
	} ,
	-- 标题
	drag_by_title = true ,
	title_style =
	{
		type = "label_style" ,
		parent = SIConstants_Core.raw.Styles.Common_FrameTitleLabel
	} ,
	-- 边框
	use_header_filler = true ,
	border = {} ,
	-- 布局
	header_flow_style =
	{
		type = "horizontal_flow_style" ,
		horizontally_stretchable = "on" ,
		bottom_padding = 4 ,
		horizontal_spacing = 8 ,
		ignored_by_search = true
	} ,
	-- 填充
	header_filler_style =
	{
		type = "empty_widget_style" ,
		parent = "draggable_space_header" ,
		horizontally_stretchable = "on" ,
		vertically_stretchable = "on" ,
		height = 24
	} ,
} )
.AddStyle( "Common_DraggableSpace" , "通用-可拖动区域" ,
{
	type = "empty_widget_style" ,
	-- 偏移
	left_margin = 8 ,
	right_margin = 8 ,
	-- 体积
	minimal_width = 40 ,
	height = 24 ,
	horizontally_stretchable = "on" ,
	-- 图形
	graphical_set =
	{
		base =
		{
			top =
			{
				position = { 192 , 8 } ,
				size = { 8 , 7 }
			} ,
			center =
			{
				position = { 200 , 8 } ,
				size = { 8 , 8 }
			} ,
			bottom =
			{
				position = { 208 , 8 } ,
				size = { 8 , 8 }
			} ,
			top_tiling = true ,
			center_tiling_horizontal = true ,
			bottom_tiling = true
		} ,
		shadow = SIStyle.Dirt.Filler
	}
} )
.AddStyle( "Common_FlowTop" , "通用-布局上" ,
{
	type = "horizontal_flow_style" ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	minimal_width = 0 ,
	-- 元素间距
	horizontal_spacing = 2 ,
	-- 对齐
	vertical_align = "top"
} )
.AddStyle( "Common_FlowBottom" , "通用-布局下" ,
{
	type = "horizontal_flow_style" ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	minimal_width = 0 ,
	-- 元素间距
	horizontal_spacing = 2 ,
	-- 对齐
	vertical_align = "bottom"
} )
.AddStyle( "Common_FlowLeft" , "通用-布局左" ,
{
	type = "vertical_flow_style" ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	minimal_width = 0 ,
	-- 元素间距
	vertical_spacing = 2 ,
	-- 对齐
	horizontal_align = "left"
} )
.AddStyle( "Common_FlowRight" , "通用-布局右" ,
{
	type = "vertical_flow_style" ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	minimal_width = 0 ,
	-- 元素间距
	vertical_spacing = 2 ,
	-- 对齐
	horizontal_align = "right"
} )
.AddStyle( "Common_FlowCenterH" , "通用-布局中竖" ,
{
	type = "horizontal_flow_style" ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	minimal_width = 0 ,
	-- 元素间距
	horizontal_spacing = 2 ,
	-- 对齐
	vertical_align = "center"
} )
.AddStyle( "Common_FlowCenterV" , "通用-布局中横" ,
{
	type = "vertical_flow_style" ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	minimal_width = 0 ,
	-- 元素间距
	vertical_spacing = 2 ,
	-- 对齐
	horizontal_align = "center"
} )
.AddStyle( "Common_TitleFlow" , "通用-标题布局" ,
{
	type = "horizontal_flow_style" ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 4 ,
	bottom_padding = 0 ,
	left_padding = 4 ,
	-- 体积
	minimal_width = 0 ,
	-- 元素间距
	horizontal_spacing = 1 ,
	-- 对齐
	vertical_align = "top"
} )
.AddStyle( "Common_ScrollPane" , "通用-滚动区域" ,
{
	type = "scroll_pane_style" ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	extra_padding_when_activated = 4 ,
	-- 中央区域
	vertical_flow_style =
	{
		type = "vertical_flow_style"
	} ,
	-- 滚动条
	vertically_squashable = "on" ,
	horizontally_squashable = "on" ,
	horizontal_scrollbar_style =
	{
		type = "horizontal_scrollbar_style"
	} ,
	vertical_scrollbar_style =
	{
		type = "vertical_scrollbar_style"
	} ,
	-- 图形
	graphical_set =
	{
		base =
		{
			position = { 17 , 0 } ,
			corner_size = 8 ,
			draw_type = "outer"
		} ,
		shadow = SIStyle.DirtInner.Shadow
	}
} )
.AddStyle( "Common_List" , "通用-列表" ,
{
	type = "table_style" ,
	-- 体积
	minimal_width = 300 ,
	minimal_height = 300 ,
	-- 元素间距
	cell_spacing = 2 ,
	horizontal_spacing = 1 ,
	vertical_spacing = 1
} )
.AddStyle( "Common_SliderButton" , "通用-滑块按钮" ,
{
	type = "button_style" ,
	-- 偏移
	padding = 0 ,
	-- 体积
	width = 20 ,
	height = 12 ,
	-- 图形
	default_graphical_set =
	{
		base =
		{
			position = { 64 , 48 } ,
			size = { 40 , 24 }
		} ,
		shadow = SIStyle.Dirt.Shadow
	} ,
	hovered_graphical_set =
	{
		base =
		{
			position = { 144 , 48 } ,
			size = { 40 , 24 }
		} ,
		glow = SIStyle.Dirt.Glow
	} ,
	clicked_graphical_set =
	{
		base =
		{
			position = { 184 , 48 } ,
			size = { 40 , 24 }
		} ,
		shadow = SIStyle.Dirt.Shadow
	} ,
	disabled_graphical_set =
	{
		base =
		{
			position = { 104 , 48 } ,
			size = { 40 , 24 }
		} ,
		shadow = SIStyle.Dirt.Shadow
	} ,
	left_click_sound =
	{
		{
			filename = "__core__/sound/gui-slider.ogg" ,
			volume = 1
		}
	}
} )
.AddStyle( "Common_Slider" , "通用-滑块" ,
{
	type = "slider_style" ,
	-- 体积
	width = 150 ,
	height = 12 ,
	-- 图形
	full_bar =
	{
		base =
		{
			position = { 73 , 72 } ,
			corner_size = 8
		} ,
		shadow = SIStyle.Dirt.Default
	} ,
	full_bar_disabled =
	{
		base =
		{
			position = { 90 , 72 } ,
			corner_size = 8
		} ,
		shadow = SIStyle.Dirt.Default
	} ,
	empty_bar =
	{
		base =
		{
			left =
			{
				position = { 56 , 72 } ,
				size = { 8 , 8 }
			} ,
			right =
			{
				position = { 65 , 72 } ,
				size = { 8 , 8 }
			} ,
			center =
			{
				position = { 64 , 72 } ,
				size = { 1 , 8 }
			}
		} ,
		shadow = SIStyle.Dirt.Default
	} ,
	empty_bar_disabled =
	{
		base =
		{
			left =
			{
				position = { 56 , 80 } ,
				size = { 8 , 8 }
			} ,
			right =
			{
				position = { 65 , 80 } ,
				size = { 8 , 8 }
			} ,
			center =
			{
				position = { 65 , 80 } ,
				size = { 1 , 8 }
			}
		} ,
        shadow = SIStyle.Dirt.Default
	} ,
	-- 绘制标尺
	draw_notches = false ,
	notch =
	{
		base =
		{
			position = { 138 , 200 } ,
			size = { 4 , 16 }
		} ,
		shadow =
		{
			position = { 146 , 192 } ,
			size = { 20 , 32 } ,
			draw_type = "outer" ,
			tint = SIStyle.DirtColor.Default ,
			top_outer_border_shift = -4 ,
			bottom_outer_border_shift = 4 ,
			left_outer_border_shift = -4 ,
			right_outer_border_shift = 4
		}
	} ,
	-- 滑块按钮
	button =
	{
		type = "button_style" ,
		parent = SIConstants_Core.raw.Styles.Common_SliderButton
	}
} )
.AddStyle( "Common_Progress" , "通用-进度条" ,
{
	type = "progressbar_style",
	-- 体积
	minimal_width = 100 ,
	bar_width = 7 ,
	-- 图形
	color = { r = 1 , g = 1 , b = 0.4 , a = 1 } ,
	other_colors = {} ,
	bar_background =
	{
		base =
		{
			position = { 296 , 48 } ,
			corner_size = 8
		} ,
		shadow = SIStyle.Dirt.Default
	} ,
	bar =
	{
		position = { 313 , 48 } ,
		corner_size = 8
	} ,
	-- 字体
	font = SIConstants_Core.raw.Fonts.Common ,
	font_color = SICommon.Colors.FontColor.BLACK ,
	side_text_padding = 8 ,
	embed_text_in_bar = false
} )
.AddStyle( "Common_ButtonGray" , "通用-按钮灰" , SIStyle.ColorButton( 0 , SIStyle.Dirt.Gray ) )
.AddStyle( "Common_ButtonGreen" , "通用-按钮绿" , SIStyle.ColorButton( 68 , SIStyle.Dirt.Green ) )
.AddStyle( "Common_ButtonRed" , "通用-按钮红" , SIStyle.ColorButton( 136 , SIStyle.Dirt.Red ) )
.AddStyle( "Common_ButtonBlue" , "通用-按钮蓝" , SIStyle.ColorButton( 700 , SIStyle.Dirt.Blue ) )
.AddStyle( "Common_ButtonPurple" , "通用-按钮紫" , SIStyle.ColorButton( 768 , SIStyle.Dirt.Purple ) )
.AddStyle( "Common_ButtonOrange" , "通用-按钮橙" , SIStyle.ColorButton( 836 , SIStyle.Dirt.Orange ) )
.AddStyle( "Common_ButtonYellow" , "通用-按钮黄" , SIStyle.ColorButton( 904 , SIStyle.Dirt.Yellow ) )
.AddStyle( "Common_ButtonTitle" , "通用-按钮标题" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonGray ,
	-- 偏移
	top_padding = 2 ,
	right_padding = 2 ,
	bottom_padding = 2 ,
	left_padding = 2 ,
	-- 体积
	width = 24 ,
	height = 24 ,
	-- 图形
	default_graphical_set =
	{
		base =
		{
			position = { 0 , 0 } ,
			corner_size = 8
		} ,
		shadow =
		{
			position = { 440 , 24 } ,
			corner_size = 8 ,
			draw_type = "outer"
		}
	} ,
	hovered_graphical_set =
	{
		base =
		{
			position = { 34 , 17 } ,
			corner_size = 8
		} ,
		shadow =
		{
			position = { 440 , 24 } ,
			corner_size = 8 ,
			draw_type = "outer"
		} ,
		glow = SIStyle.Dirt.Glow
	} ,
	clicked_graphical_set =
	{
		base =
		{
			position = { 51 , 17 } ,
			corner_size = 8
		} ,
		shadow =
		{
			position = { 440 , 24 } ,
			corner_size = 8 ,
			draw_type = "outer"
		}
	} ,
	disabled_graphical_set =
	{
		base =
		{
			position = { 17 , 17 } ,
			corner_size = 8
		} ,
		shadow =
		{
			position = { 440 , 24 } ,
			corner_size = 8 ,
			draw_type = "outer"
		}
	} ,
	selected_graphical_set =
	{
		base =
		{
			position = { 369 , 17 } ,
			corner_size = 8
		} ,
		shadow =
		{
			position = { 440 , 24 } ,
			corner_size = 8 ,
			draw_type = "outer"
		}
	} ,
	selected_hovered_graphical_set =
	{
		base =
		{
			position = { 352 , 17 } ,
			corner_size = 8
		} ,
		shadow =
		{
			position = { 440 , 24 } ,
			corner_size = 8 ,
			draw_type = "outer"
		}
	} ,
	-- 声音
	left_click_sound =
	{
		{
			filename = "__core__/sound/gui-tool-button.ogg" ,
			volume = 1
		}
	}
} )
.AddStyle( "Common_Radio" , "通用-单选" ,
{
	type = "radiobutton_style" ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 字体
	text_padding = 8 ,
	font = SIConstants_Core.raw.Fonts.Common ,
	font_color = SICommon.Colors.FontColor.Default ,
	disabled_font_color = SICommon.Colors.FontColor.Disable_Default ,
	-- 声音
	left_click_sound =
	{
		{
			filename = "__core__/sound/gui-radio-button.ogg" ,
			volume = 1
		}
	}
} )
.AppendStyleData( SIStyle.RadioGraphics( 0 , 160 ) )
.AddStyle( "Common_RadioGreen" , "通用-单选绿" ,
{
	type = "radiobutton_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Radio
} )
.AppendStyleData( SIStyle.RadioGraphics( 700 , 34 ) )
.AddStyle( "Common_RadioRed" , "通用-单选红" ,
{
	type = "radiobutton_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Radio
} )
.AppendStyleData( SIStyle.RadioGraphics( 820 , 34 ) )
.AddStyle( "Common_RadioBlue" , "通用-单选蓝" ,
{
	type = "radiobutton_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Radio
} )
.AppendStyleData( SIStyle.RadioGraphics( 940 , 34 ) )
.AddStyle( "Common_CheckBox" , "通用-复选" ,
{
	type = "checkbox_style" ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 对齐
	vertical_align = "center" ,
	-- 字体
	text_padding = 8 ,
	font = SIConstants_Core.raw.Fonts.Common ,
	font_color = SICommon.Colors.FontColor.Default ,
	disabled_font_color = SICommon.Colors.FontColor.Disable_Default ,
	-- 图形
	checkmark =
	{
		position = { 112 , 132 } ,
		size = { 28 , 28 }
	} ,
	disabled_checkmark =
	{
		position = { 456 , 188 } ,
		size = { 28 , 28 }
	} ,
	intermediate_mark =
	{
		position = { 456 , 160 } ,
		size = { 28 , 28 }
	} ,
	-- 声音
	left_click_sound =
	{
		{
			filename = "__core__/sound/gui-checkbox-click.ogg" ,
			volume = 1
		}
	}
} )
.AppendStyleData( SIStyle.CheckBoxGraphics( 0 , 132 ) )
.AddStyle( "Common_CheckBoxGreen" , "通用-复选绿" ,
{
	type = "checkbox_style" ,
	parent = SIConstants_Core.raw.Styles.Common_CheckBox
} )
.AppendStyleData( SIStyle.RadioGraphics( 700 , 34 ) )
.AddStyle( "Common_CheckBoxRed" , "通用-复选红" ,
{
	type = "checkbox_style" ,
	parent = SIConstants_Core.raw.Styles.Common_CheckBox
} )
.AppendStyleData( SIStyle.RadioGraphics( 812 , 34 ) )
.AddStyle( "Common_CheckBoxBlue" , "通用-复选蓝" ,
{
	type = "checkbox_style" ,
	parent = SIConstants_Core.raw.Styles.Common_CheckBox
} )
.AppendStyleData( SIStyle.RadioGraphics( 924 , 34 ) )
.AddStyle( "Common_DropDown" , "通用-下拉列表" ,
{
	type = "dropdown_style" ,
	-- 偏移
	top_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 8 ,
	right_padding = 4 ,
	-- 体积
	width = 100 ,
	height = 28 ,
	-- 元素间距
	selector_and_title_spacing = 8 ,
	-- 按钮
	button_style =
	{
		type = "button_style" ,
		parent = SIConstants_Core.raw.Styles.Common_ButtonGray ,
		-- 偏移
		padding = 0 ,
		-- 对齐
		horizontal_align = "left" ,
		-- 字体
		font = SIConstants_Core.raw.Fonts.CommonDropDown
	} ,
	-- 图标
	icon =
	{
		filename = "__core__/graphics/icons/mip/dropdown.png" ,
		priority = "extra-high-no-scale" ,
		flags = { "gui-icon" } ,
		size = 32 ,
		scale = 0.5 ,
		mipmap_count = 2
	} ,
	-- 列表
	list_box_style =
	{
		type = "list_box_style" ,
		-- 体积
		maximal_height = 400 ,
		-- 下拉列表滚动区域
		scroll_pane_style =
		{
			type = "scroll_pane_style" ,
			-- 偏移
			padding = 0 ,
			extra_padding_when_activated = 0 ,
			-- 图形
			graphical_set =
			{
				shadow = SIStyle.Dirt.Shadow
			}
		}
	} ,
	-- 声音
	opened_sound =
	{
		{
			filename = "__core__/sound/gui-dropdown-open.ogg" ,
			volume = 1
		}
	}
} )
-- ----------------------------------------
-- 主面板控件样式
-- ----------------------------------------
.AddStyle( "Mainbar_Frame" , "主面板-窗口" ,
{
	type = "frame_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Frame ,
	-- 偏移
	top_padding = 5 ,
	right_padding = 5 ,
	bottom_padding = 5 ,
	left_padding = 5 ,
	-- 体积
	minimal_width = 50 ,
	minimal_height = 50 ,
	-- 元素间距
	cell_spacing = 0 ,
	horizontal_spacing = 0 ,
	vertical_spacing = 0 ,
	-- 图形
	graphical_set =
	{
		base =
		{
			position = { 162 , 932 } ,
			corner_size = 8
		}
	}
} )
.AddStyle( "Mainbar_ButtonBig" , "主面板-按钮大" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonGray ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 56 ,
	height = 56
} )
.AddStyle( "Mainbar_ButtonSmall" , "主面板-按钮小" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonGray ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 27 ,
	height = 27
} )
.AddStyle( "Mainbar_LabelFlow" , "主面板-标签布局" ,
{
	type = "vertical_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowLeft ,
	-- 元素间距
	vertical_spacing = 0
} )
.AddStyle( "Mainbar_LabelText" , "主面板-标签文本" ,
{
	type = "label_style" ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	minimal_width = 100 ,
	maximal_width = 400 ,
	height = 15 ,
	-- 对齐
	horizontal_align = "left" ,
	vertical_align = "center" ,
	-- 字体
	font = SIConstants_Core.raw.Fonts.Mainbar ,
	-- 富文本
	single_line = true
} )
.AddStyle( "Mainbar_ToolbarOpen" , "主面板-工具栏-打开" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonGray ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 56 ,
	height = 56
} )
.AddStyle( "Mainbar_ToolbarClose" , "主面板-工具栏-关闭" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonRed ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 56 ,
	height = 56
} )
.AddStyle( "Mainbar_ToolbarCommonFlow" , "主面板-工具栏-常用布局" ,
{
	type = "horizontal_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowTop ,
	-- 体积
	width = 27 ,
	height = 27 ,
	-- 元素间距
	horizontal_spacing = 0
} )
.AddStyle( "Mainbar_ToolbarCommonButton" , "主面板-工具栏-常用按钮" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonGray ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 27 ,
	height = 27
} )
.AddStyle( "Mainbar_ToolbarScroll" , "主面板-工具栏滚动区域" ,
{
	type = "scroll_pane_style" ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	extra_padding_when_activated = 4 ,
	-- 中央区域
	vertical_flow_style =
	{
		type = "vertical_flow_style"
	} ,
	-- 滚动条
	vertically_squashable = "on" ,
	horizontally_squashable = "on" ,
	horizontal_scrollbar_style =
	{
		type = "horizontal_scrollbar_style"
	} ,
	vertical_scrollbar_style =
	{
		type = "vertical_scrollbar_style"
	}
} )
.AddStyle( "Mainbar_ToolbarList" , "主面板-工具栏列表" ,
{
	type = "table_style" ,
	-- 元素间距
	cell_spacing = 3 ,
	vertical_spacing = 3 ,
	horizontal_spacing = 3
} )
.AddStyle( "Mainbar_ToolbarButton" , "主面板-工具栏按钮" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonGray ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 30 ,
	height = 30
} )
.AddStyle( "Mainbar_Button_GameSpeed" , "主面板-按钮-游戏速度" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonGray ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 100 ,
	height = 24 ,
	-- 字体
	font = SIConstants_Core.raw.Fonts.MainbarButton
} )
.AddStyle( "Mainbar_Button_GameSpeedSmall" , "主面板-按钮-游戏速度小" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonGray ,
	-- 偏移
	top_padding = 1 ,
	right_padding = 1 ,
	bottom_padding = 1 ,
	left_padding = 1 ,
	-- 体积
	width = 24 ,
	height = 24
} )
.AddStyle( "Mainbar_Button_Time" , "主面板-游戏时间-显示" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonBlue ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 170 ,
	height = 24 ,
	-- 字体
	font = SIConstants_Core.raw.Fonts.Mainbar
} )
.AddStyle( "Mainbar_Button_TimeSwitch" , "主面板-游戏时间-显示切换" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonGreen ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 24 ,
	height = 24
} )
-- ----------------------------------------
-- 主面板设置管理控件样式
-- ----------------------------------------
.AddStyle( "Mainbar_Setting_Frame" , "主面板设置管理-窗口" ,
{
	type = "frame_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Frame ,
	-- 体积
	minimal_width = 100 ,
	minimal_height = 100 ,
	maximal_height = 700
} )
.AddStyle( "Mainbar_Setting_LabelTop" , "主面板设置管理-标签顶部" ,
{
	type = "label_style" ,
	-- 体积
	minimal_width = 300 ,
	-- 对齐
	horizontal_align = "left" ,
	-- 富文本
	single_line = false
} )
.AddStyle( "Mainbar_Setting_ListTitleFlow" , "主面板设置管理-列表标题布局" ,
{
	type = "horizontal_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowCenterH ,
	-- 体积
	width = 170
} )
.AddStyle( "Mainbar_Setting_ListLabel" , "主面板设置管理-列表标签" ,
{
	type = "label_style" ,
	-- 对齐
	horizontal_align = "left"
} )
.AddStyle( "Mainbar_Setting_ListCheck" , "主面板设置管理-列表复选" ,
{
	type = "checkbox_style" ,
	parent = SIConstants_Core.raw.Styles.Common_CheckBox ,
	-- 体积
	width = 200
} )
.AddStyle( "Mainbar_Setting_ListItemFlow" , "主面板设置管理-列表元素布局" ,
{
	type = "horizontal_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowCenterH ,
	-- 体积
	width = 200 ,
	-- 元素间距
	horizontal_spacing = 1
} )
.AddStyle( "Mainbar_Setting_ListPlace" , "主面板设置管理-列表占位" ,
{
	type = "label_style" ,
	-- 体积
	width = 120 ,
	-- 对齐
	horizontal_align = "left"
} )
.AddStyle( "Mainbar_Setting_Slider" , "主面板设置管理-滑块" ,
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
		tooltip = "SICore.主面板设置管理-窗口-设置-工具栏按钮每行数量-提示" -- 神 TM 需要在原型里设置 , 在 control 里设置就无效
	}
} )
.AddStyle( "Mainbar_Setting_Number" , "主面板设置管理-数字框" ,
{
	type = "textbox_style" ,
	-- 体积
	width = 60
} )
.AddStyle( "Mainbar_Setting_DropDown" , "主面板设置管理-下拉列表" ,
{
	type = "dropdown_style" ,
	parent = SIConstants_Core.raw.Styles.Common_DropDown ,
	-- 体积
	width = 200 ,
	height = 28
} )
-- ----------------------------------------
-- 主面板便签管理控件样式
-- ----------------------------------------
.AddStyle( "Mainbar_Note_Frame" , "主面板便签管理-窗口" ,
{
	type = "frame_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Frame ,
	-- 体积
	minimal_width = 100 ,
	minimal_height = 100 ,
	maximal_height = 700
} )
.AddStyle( "Mainbar_Note_LabelTop" , "主面板便签管理-标签顶部" ,
{
	type = "label_style" ,
	-- 体积
	minimal_width = 300 ,
	-- 对齐
	horizontal_align = "left" ,
	-- 富文本
	single_line = false
} )
.AddStyle( "Mainbar_Note_RightFlow" , "主面板便签管理-右侧布局" ,
{
	type = "vertical_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowLeft ,
	-- 偏移
	left_padding = 15
} )
.AddStyle( "Mainbar_Note_ListNoteNormal" , "主面板便签管理-列表便签按钮-普通" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonGray ,
	-- 偏移
	top_padding = 5 ,
	right_padding = 10 ,
	bottom_padding = 5 ,
	left_padding = 10 ,
	-- 体积
	width = 460 ,
	height = 60
} )
.AddStyle( "Mainbar_Note_ListNoteKey" , "主面板便签管理-列表便签按钮-重点" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonOrange ,
	-- 偏移
	top_padding = 5 ,
	right_padding = 10 ,
	bottom_padding = 5 ,
	left_padding = 10 ,
	-- 体积
	width = 460 ,
	height = 60
} )
.AddStyle( "Mainbar_Note_ListNoteNone" , "主面板便签管理-列表便签按钮-暂无" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonBlue ,
	-- 偏移
	top_padding = 5 ,
	right_padding = 10 ,
	bottom_padding = 5 ,
	left_padding = 10 ,
	-- 体积
	width = 460 ,
	height = 60
} )
.AddStyle( "Mainbar_Note_ListNoteDelete" , "主面板便签管理-列表便签按钮-删除" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonRed ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 60 ,
	height = 60
} )
.AddStyle( "Mainbar_Note_ListFlow" , "主面板便签管理-列表便签布局" ,
{
	type = "vertical_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowLeft ,
	-- 体积
	width = 440 ,
	height = 50
} )
.AddStyle( "Mainbar_Note_ListTitle" , "主面板便签管理-列表便签标题" ,
{
	type = "label_style" ,
	-- 体积
	width = 440 ,
	height = 25 ,
	-- 对齐
	horizontal_align = "left" ,
	vertical_align = "center" ,
	-- 富文本
	single_line = true
} )
.AddStyle( "Mainbar_Note_ListContent" , "主面板便签管理-列表便签内容" ,
{
	type = "label_style" ,
	-- 体积
	width = 440 ,
	height = 15 ,
	-- 对齐
	horizontal_align = "left" ,
	vertical_align = "center" ,
	-- 字体
	font = SIConstants_Core.raw.Fonts.MainbarNote ,
	-- 富文本
	single_line = true
} )
.AddStyle( "Mainbar_Note_EditFlow" , "主面板便签管理-编辑便签布局" ,
{
	type = "horizontal_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowCenterH ,
	-- 体积
	width = 110 ,
} )
.AddStyle( "Mainbar_Note_EditLabel" , "主面板便签管理-编辑便签标签" ,
{
	type = "label_style" ,
	-- 体积
	maximal_width = 95 ,
	-- 对齐
	horizontal_align = "left"
} )
.AddStyle( "Mainbar_Note_EditTitle" , "主面板便签管理-编辑便签标题" ,
{
	type = "textbox_style" ,
	-- 体积
	width = 200
} )
.AddStyle( "Mainbar_Note_EditContent" , "主面板便签管理-编辑便签内容" ,
{
	type = "textbox_style" ,
	-- 体积
	width = 200 ,
	height = 110
} )
.AddStyle( "Mainbar_Note_EditOrder" , "主面板便签管理-编辑便签排序" ,
{
	type = "textbox_style" ,
	-- 体积
	width = 200
} )
.AddStyle( "Mainbar_Note_EditCheck" , "主面板便签管理-编辑便签复选" ,
{
	type = "checkbox_style" ,
	parent = SIConstants_Core.raw.Styles.Common_CheckBox ,
	-- 体积
	minimal_width = 28 ,
	height = 28
} )
-- ----------------------------------------
-- 主面板消息管理控件样式
-- ----------------------------------------
.AddStyle( "Mainbar_Message_Frame" , "主面板消息管理-窗口" ,
{
	type = "frame_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Frame ,
	-- 体积
	minimal_width = 100 ,
	minimal_height = 100 ,
	maximal_height = 700
} )
.AddStyle( "Mainbar_Message_LabelTop" , "主面板消息管理-标签顶部" ,
{
	type = "label_style" ,
	-- 体积
	minimal_width = 300 ,
	-- 对齐
	horizontal_align = "left" ,
	-- 富文本
	single_line = false
} )
.AddStyle( "Mainbar_Message_ListMessageNormal" , "主面板消息管理-列表消息按钮-普通" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonGray ,
	-- 偏移
	top_padding = 5 ,
	right_padding = 10 ,
	bottom_padding = 5 ,
	left_padding = 10 ,
	-- 体积
	width = 520 ,
	minimal_height = 50 ,
	maximal_height = 500 ,
	natural_height = 105
} )
.AddStyle( "Mainbar_Message_ListMessageBack" , "主面板消息管理-列表消息按钮-反馈" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonGreen ,
	-- 偏移
	top_padding = 5 ,
	right_padding = 10 ,
	bottom_padding = 5 ,
	left_padding = 10 ,
	-- 体积
	width = 520 ,
	minimal_height = 50 ,
	maximal_height = 500 ,
	natural_height = 105
} )
.AddStyle( "Mainbar_Message_ListMessageTip" , "主面板消息管理-列表消息按钮-提示" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonBlue ,
	-- 偏移
	top_padding = 5 ,
	right_padding = 10 ,
	bottom_padding = 5 ,
	left_padding = 10 ,
	-- 体积
	width = 520 ,
	minimal_height = 50 ,
	maximal_height = 500 ,
	natural_height = 105
} )
.AddStyle( "Mainbar_Message_ListMessageWarn" , "主面板消息管理-列表消息按钮-警告" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonOrange ,
	-- 偏移
	top_padding = 5 ,
	right_padding = 10 ,
	bottom_padding = 5 ,
	left_padding = 10 ,
	-- 体积
	width = 520 ,
	minimal_height = 50 ,
	maximal_height = 500 ,
	natural_height = 105
} )
.AddStyle( "Mainbar_Message_ListMessageError" , "主面板消息管理-列表消息按钮-异常" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonRed ,
	-- 偏移
	top_padding = 5 ,
	right_padding = 10 ,
	bottom_padding = 5 ,
	left_padding = 10 ,
	-- 体积
	width = 520 ,
	minimal_height = 50 ,
	maximal_height = 500 ,
	natural_height = 105
} )
.AddStyle( "Mainbar_Message_ListMessageSpecial" , "主面板消息管理-列表消息按钮-特殊" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonPurple ,
	-- 偏移
	top_padding = 5 ,
	right_padding = 10 ,
	bottom_padding = 5 ,
	left_padding = 10 ,
	-- 体积
	width = 520 ,
	minimal_height = 50 ,
	maximal_height = 500 ,
	natural_height = 105
} )
.AddStyle( "Mainbar_Message_ListFlow" , "主面板消息管理-列表消息布局" ,
{
	type = "vertical_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowLeft ,
	-- 体积
	width = 500 ,
	minimal_height = 40 ,
	maximal_height = 490 ,
	natural_height = 40
} )
.AddStyle( "Mainbar_Message_ListTitle" , "主面板消息管理-列表消息标题" ,
{
	type = "label_style" ,
	-- 体积
	width = 500 ,
	height = 25 ,
	-- 对齐
	horizontal_align = "left" ,
	vertical_align = "center" ,
	-- 富文本
	single_line = true
} )
.AddStyle( "Mainbar_Message_ListContent" , "主面板消息管理-列表消息内容" ,
{
	type = "label_style" ,
	-- 体积
	width = 500 ,
	minimal_height = 15 ,
	maximal_height = 465 ,
	natural_height = 15 ,
	-- 对齐
	horizontal_align = "left" ,
	vertical_align = "top" ,
	-- 富文本
	single_line = false
} )
-- ----------------------------------------
-- 权限管理控件样式
-- ----------------------------------------
.AddStyle( "Permission_Frame" , "权限管理-窗口" ,
{
	type = "frame_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Frame ,
	-- 体积
	minimal_width = 100 ,
	minimal_height = 100 ,
	maximal_height = 730
} )
.AddStyle( "Permission_TabPane" , "权限管理-分页面板" ,
{
	type = "tabbed_pane_style" ,
	-- 偏移
	padding = 0 ,
	-- 体积
	minimal_width = 200 ,
	minimal_height = 250 ,
	-- 元素间距
	vertical_spacing = 0 ,
	-- 标签头部
	tab_content_frame =
	{
		type = "frame_style" ,
		-- 偏移
		top_padding = 8 ,
		right_padding = 4 ,
		bottom_padding = 4 ,
		left_padding = 4 ,
		-- 图形
		graphical_set =
		{
			base =
			{
				-- 选项卡面板是一种嵌入式面板 , 因此下方接触面的阴影不应该绘制
				top =
				{
					position = { 76 , 0 } ,
					size = { 1 , 8 }
				} ,
				bottom =
				{
					position = { 76 , 9 } ,
					size = { 1 , 8 }
				} ,
				center =
				{
					position = { 76 , 8 } ,
					size = { 1 , 1 }
				}
			} ,
			shadow = SIStyle.DirtTop.Shadow
		}
	} ,
	-- 标签本体
	tab_container =
	{
		type = "horizontal_flow_style" ,
		-- 偏移
		right_padding = 12 ,
		left_padding = 12 ,
		-- 元素间距
		horizontal_spacing = 0
	}
} )
.AddStyle( "Permission_Flow" , "权限管理-布局" ,
{
	type = "vertical_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowRight ,
	-- 体积
	width = 670
} )
.AddStyle( "Permission_LabelTop" , "权限管理-标签顶部" ,
{
	type = "label_style" ,
	-- 体积
	minimal_width = 300 ,
	-- 对齐
	horizontal_align = "left"
} )
.AddStyle( "Permission_ItemIconGreen" , "权限管理-物品图标绿" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonGreen ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 24 ,
	height = 24
} )
.AddStyle( "Permission_ItemIconRed" , "权限管理-物品图标红" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonRed ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 24 ,
	height = 24
} )
.AddStyle( "Permission_ItemIconBlue" , "权限管理-物品图标蓝" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonBlue ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 24 ,
	height = 24
} )
.AddStyle( "Permission_ItemIconOrange" , "权限管理-物品图标橙" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonOrange ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 24 ,
	height = 24
} )
.AddStyle( "Permission_Look_ListTitle" , "权限管理-查看-列表标题" ,
{
	type = "label_style" ,
	-- 体积
	width = 209 ,
	-- 对齐
	horizontal_align = "center"
} )
.AddStyle( "Permission_Look_ListTitleLong" , "权限管理-查看-列表标题长" ,
{
	type = "label_style" ,
	-- 体积
	width = 432 ,
	-- 对齐
	horizontal_align = "center"
} )
.AddStyle( "Permission_Look_List" , "权限管理-查看-列表" ,
{
	type = "table_style" ,
	parent = SIConstants_Core.raw.Styles.Common_List ,
	-- 体积
	minimal_height = 400
} )
.AddStyle( "Permission_Look_ListLabel" , "权限管理-查看-列表标签" ,
{
	type = "label_style" ,
	-- 体积
	width = 209 ,
	-- 对齐
	horizontal_align = "center"
} )
.AddStyle( "Permission_Look_ListFlow" , "权限管理-查看-列表布局" ,
{
	type = "vertical_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowLeft ,
	-- 体积
	width = 432 ,
	-- 元素间距
	vertical_spacing = 0
} )
.AddStyle( "Permission_Look_ListFlowH" , "权限管理-查看-列表布局横" ,
{
	type = "horizontal_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowCenterH ,
	-- 体积
	width = 432 ,
	-- 元素间距
	horizontal_spacing = 0
} )
.AddStyle( "Permission_Look_ListItem" , "权限管理-查看-列表项目" ,
{
	type = "label_style" ,
	-- 体积
	width = 96 ,
	-- 对齐
	horizontal_align = "center" ,
	vertical_align = "center"
} )
.AddStyle( "Permission_Look_ListItemLong" , "权限管理-查看-列表项目长" ,
{
	type = "label_style" ,
	-- 体积
	width = 150 ,
	-- 对齐
	horizontal_align = "center" ,
	vertical_align = "center"
} )
.AddStyle( "Permission_Look_ListSub" , "权限管理-查看-列表内部" ,
{
	type = "table_style" ,
	-- 体积
	width = 336 ,
	-- 元素间距
	cell_spacing = 0 ,
	horizontal_spacing = 0 ,
	vertical_spacing = 0
} )
.AddStyle( "Permission_Global_ListTitleHead" , "权限管理-全局-列表标题头部" ,
{
	type = "label_style" ,
	-- 体积
	width = 186 ,
	-- 对齐
	horizontal_align = "center"
} )
.AddStyle( "Permission_Global_ListTitleShort" , "权限管理-全局-列表标题短" ,
{
	type = "label_style" ,
	-- 体积
	width = 45 ,
	-- 对齐
	horizontal_align = "center"
} )
.AddStyle( "Permission_Global_ListTitleLong" , "权限管理-全局-列表标题长" ,
{
	type = "label_style" ,
	-- 体积
	width = 135 ,
	-- 对齐
	horizontal_align = "center"
} )
.AddStyle( "Permission_Global_List" , "权限管理-全局-列表" ,
{
	type = "table_style" ,
	parent = SIConstants_Core.raw.Styles.Common_List ,
	-- 体积
	minimal_height = 314
} )
.AddStyle( "Permission_Global_ListLabelHead" , "权限管理-全局-列表标签头部" ,
{
	type = "label_style" ,
	-- 体积
	width = 186 ,
	-- 对齐
	horizontal_align = "center"
} )
.AddStyle( "Permission_Global_ListLabel" , "权限管理-全局-列表标签" ,
{
	type = "label_style" ,
	-- 体积
	width = 135 ,
	-- 对齐
	horizontal_align = "center"
} )
.AddStyle( "Permission_Global_ListRadioFlow" , "权限管理-全局-列表单选布局" ,
{
	type = "vertical_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowCenterV ,
	-- 体积
	width = 45
} )
.AddStyle( "Permission_Global_ListText" , "权限管理-全局-列表文本条" ,
{
	type = "textbox_style" ,
	-- 体积
	width = 135
} )
.AddStyle( "Permission_Global_ListCheck" , "权限管理-全局-列表复选"  ,
{
	type = "checkbox_style" ,
	parent = SIConstants_Core.raw.Styles.Common_CheckBox ,
	-- 体积
	width = 30 ,
	height = 28
} )
.AddStyle( "Permission_Global_ItemTitle" , "权限管理-全局-物品标题" ,
{
	type = "label_style" ,
	-- 体积
	width = 328 ,
	-- 对齐
	horizontal_align = "center"
} )
.AddStyle( "Permission_Global_ItemListFind" , "权限管理-全局-物品列表查询" ,
{
	type = "scroll_pane_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ScrollPane ,
	-- 体积
	width = 164 ,
	height = 170
} )
.AddStyle( "Permission_Global_ItemListNow" , "权限管理-全局-物品列表现有" ,
{
	type = "scroll_pane_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ScrollPane ,
	-- 体积
	width = 164 ,
	height = 200
} )
.AddStyle( "Permission_Global_ListSmall" , "权限管理-全局-列表小" ,
{
	type = "table_style" ,
	parent = SIConstants_Core.raw.Styles.Common_List ,
	-- 体积
	minimal_height = 50
} )
.AddStyle( "Permission_Global_ItemFindFlow" , "权限管理-全局-物品查询布局" ,
{
	type = "horizontal_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowCenterH ,
	-- 体积
	width = 164
} )
.AddStyle( "Permission_Global_ItemFind" , "权限管理-全局-物品查询" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonGray ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 28 ,
	height = 28
} )
.AddStyle( "Permission_Global_ItemFindText" , "权限管理-全局-物品查询文本条" ,
{
	type = "textbox_style" ,
	-- 体积
	width = 134
} )
.AddStyle( "Permission_Player_ListTitlePlayer" , "权限管理-玩家-列表标题玩家" ,
{
	type = "label_style" ,
	-- 体积
	width = 190 ,
	-- 对齐
	horizontal_align = "center"
} )
.AddStyle( "Permission_Player_ListTitlePermission" , "权限管理-玩家-列表标题权限" ,
{
	type = "label_style" ,
	-- 体积
	width = 262 ,
	-- 对齐
	horizontal_align = "center"
} )
.AddStyle( "Permission_Player_ListTitleShort" , "权限管理-玩家-列表标题短" ,
{
	type = "label_style" ,
	-- 体积
	width = 55 ,
	-- 对齐
	horizontal_align = "center"
} )
.AddStyle( "Permission_Player_ListPlayer" , "权限管理-玩家-列表玩家" ,
{
	type = "table_style" ,
	parent = SIConstants_Core.raw.Styles.Common_List ,
	-- 体积
	width = 190 ,
	minimal_height = 298
} )
.AddStyle( "Permission_Player_ListPermission" , "权限管理-玩家-列表权限" ,
{
	type = "table_style" ,
	parent = SIConstants_Core.raw.Styles.Common_List ,
	-- 体积
	width = 430 ,
	minimal_height = 298
} )
.AddStyle( "Permission_Player_ListItemPlayer" , "权限管理-玩家-列表按钮玩家" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonGray ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 190 ,
	height = 24
} )
.AddStyle( "Permission_Player_ListLabelPermission" , "权限管理-玩家-列表标签权限" ,
{
	type = "label_style" ,
	-- 体积
	width = 262 ,
	-- 对齐
	horizontal_align = "center"
} )
.AddStyle( "Permission_Player_ListFlow" , "权限管理-玩家-列表标签布局" ,
{
	type = "vertical_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowCenterV ,
	-- 体积
	width = 55
} )
.AddStyle( "Permission_Player_ItemTitle" , "权限管理-玩家-物品标题" ,
{
	type = "label_style" ,
	-- 体积
	width = 328 ,
	-- 对齐
	horizontal_align = "center"
} )
.AddStyle( "Permission_Player_ItemListFind" , "权限管理-玩家-物品列表查询" ,
{
	type = "scroll_pane_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ScrollPane ,
	-- 体积
	width = 164 ,
	height = 170
} )
.AddStyle( "Permission_Player_ItemListNow" , "权限管理-玩家-物品列表现有" ,
{
	type = "scroll_pane_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ScrollPane ,
	-- 体积
	width = 164 ,
	height = 200
} )
.AddStyle( "Permission_Player_ListSmall" , "权限管理-玩家-列表小" ,
{
	type = "table_style" ,
	parent = SIConstants_Core.raw.Styles.Common_List ,
	-- 体积
	minimal_height = 50
} )
.AddStyle( "Permission_Player_ItemFindFlow" , "权限管理-玩家-物品查询布局" ,
{
	type = "horizontal_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowCenterH ,
	-- 体积
	width = 164
} )
.AddStyle( "Permission_Player_ItemFind" , "权限管理-玩家-物品查询" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonGray ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 28 ,
	height = 28
} )
.AddStyle( "Permission_Player_ItemFindText" , "权限管理-玩家-物品查询文本条" ,
{
	type = "textbox_style" ,
	-- 体积
	width = 134
} )
.AddStyle( "Permission_Check_ListTitlePermission" , "权限管理-查询-列表标题权限" ,
{
	type = "label_style" ,
	-- 体积
	width = 262 ,
	-- 对齐
	horizontal_align = "center"
} )
.AddStyle( "Permission_Check_ListTitlePlayer" , "权限管理-查询-列表标题玩家" ,
{
	type = "label_style" ,
	-- 体积
	width = 190 ,
	-- 对齐
	horizontal_align = "center"
} )
.AddStyle( "Permission_Check_ListTitleShort" , "权限管理-查询-列表标题短" ,
{
	type = "label_style" ,
	-- 体积
	width = 55 ,
	-- 对齐
	horizontal_align = "center"
} )
.AddStyle( "Permission_Check_ListPermission" , "权限管理-查询-列表权限" ,
{
	type = "table_style" ,
	parent = SIConstants_Core.raw.Styles.Common_List ,
	-- 体积
	width = 262 ,
	minimal_height = 522
} )
.AddStyle( "Permission_Check_ListPlayer" , "权限管理-查询-列表玩家" ,
{
	type = "table_style" ,
	parent = SIConstants_Core.raw.Styles.Common_List ,
	-- 体积
	width = 358 ,
	minimal_height = 522
} )
.AddStyle( "Permission_Check_ListItemPermission" , "权限管理-查询-列表按钮权限" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonGray ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 262 ,
	height = 24
} )
.AddStyle( "Permission_Check_ListLabelPlayer" , "权限管理-查询-列表标签玩家" ,
{
	type = "label_style" ,
	-- 体积
	width = 190 ,
	-- 对齐
	horizontal_align = "center"
} )
.AddStyle( "Permission_Check_ListFlow" , "权限管理-查询-列表标签布局" ,
{
	type = "vertical_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowCenterV ,
	-- 体积
	width = 55
} )
-- ----------------------------------------
-- 信息查询控件样式
-- ----------------------------------------
.AddStyle( "Finder_Frame" , "信息查询-窗口" ,
{
	type = "frame_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Frame ,
	-- 体积
	minimal_width = 100 ,
	minimal_height = 100 ,
	maximal_height = 700
} )
.AddStyle( "Finder_DropDown" , "信息查询-下拉列表" ,
{
	type = "dropdown_style" ,
	parent = SIConstants_Core.raw.Styles.Common_DropDown ,
	-- 体积
	width = 200 ,
	height = 28
} )
.AddStyle( "Finder_Flow" , "信息查询-布局" ,
{
	type = "horizontal_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowCenterH ,
	-- 元素间距
	horizontal_spacing = 10
} )
.AddStyle( "Finder_Chooser" , "信息查询-选择" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonGray ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 30 ,
	height = 30
} )
.AddStyle( "Finder_Label" , "信息查询-选择标签" ,
{
	type = "label_style" ,
	-- 体积
	width = 250 ,
	-- 对齐
	horizontal_align = "left" ,
	-- 富文本
	single_line = true
} )
.AddStyle( "Finder_ListLabel" , "信息查询-列表标签" ,
{
	type = "label_style" ,
	-- 体积
	width = 300 ,
	height = 35 ,
	-- 对齐
	horizontal_align = "left" ,
	vertical_align = "center" ,
	-- 富文本
	single_line = true
} )
-- ----------------------------------------
-- 黄图控件样式
-- ----------------------------------------
.AddStyle( "OreMap_Frame" , "黄图-窗口" ,
{
	type = "frame_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Frame ,
	-- 体积
	minimal_width = 100 ,
	minimal_height = 100 ,
	maximal_height = 700
} )
.AddStyle( "OreMap_LabelTop" , "黄图-标签顶部" ,
{
	type = "label_style" ,
	-- 体积
	width = 456 ,
	-- 对齐
	horizontal_align = "left" ,
	-- 富文本
	single_line = false
} )
.AddStyle( "OreMap_Check" , "黄图-复选" ,
{
	type = "checkbox_style" ,
	parent = SIConstants_Core.raw.Styles.Common_CheckBox ,
	-- 体积
	minimal_width = 50 ,
	height = 28
} )
.AddStyle( "OreMap_FlowShort" , "黄图-布局短" ,
{
	type = "horizontal_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowCenterH ,
	-- 体积
	width = 100
} )
.AddStyle( "OreMap_LabelShort" , "黄图-标签短" ,
{
	type = "label_style" ,
	-- 对齐
	horizontal_align = "right"
} )
.AddStyle( "OreMap_Number" , "黄图-数字框" ,
{
	type = "textbox_style" ,
	-- 体积
	width = 150
} )
.AddStyle( "OreMap_ButtonGreen" , "黄图-绿色按钮" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonGreen ,
	-- 体积
	width = 125 ,
	height = 28
} )
.AddStyle( "OreMap_ListTitleIcon" , "黄图-列表标题图标" ,
{
	type = "label_style" ,
	-- 体积
	width = 30 ,
	-- 对齐
	horizontal_align = "center"
} )
.AddStyle( "OreMap_ListTitleLong" , "黄图-列表标题长" ,
{
	type = "label_style" ,
	-- 体积
	width = 202 ,
	-- 对齐
	horizontal_align = "center"
} )
.AddStyle( "OreMap_ListIcon" , "黄图-列表图标" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonGray ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 30 ,
	height = 30
} )
.AddStyle( "OreMap_ListLabelLong" , "黄图-列表标签长" ,
{
	type = "label_style" ,
	-- 体积
	width = 202 ,
	-- 对齐
	horizontal_align = "center"
} )
.AddStyle( "OreMap_LabelBottom" , "黄图-标签底部" ,
{
	type = "label_style" ,
	-- 体积
	width = 420 ,
	-- 对齐
	horizontal_align = "left" ,
	-- 富文本
	single_line = false
} )
-- ----------------------------------------
-- 紫图控件样式
-- ----------------------------------------
.AddStyle( "RequestMap_Frame" , "紫图-窗口" ,
{
	type = "frame_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Frame ,
	-- 体积
	minimal_width = 100 ,
	height = 700
} )
.AddStyle( "RequestMap_TabPane" , "紫图-分页面板" ,
{
	type = "tabbed_pane_style" ,
	-- 偏移
	padding = 0 ,
	-- 体积
	minimal_width = 200 ,
	minimal_height = 250 ,
	-- 元素间距
	vertical_spacing = 0 ,
	-- 标签头部
	tab_content_frame =
	{
		type = "frame_style" ,
		-- 偏移
		top_padding = 8 ,
		right_padding = 4 ,
		bottom_padding = 4 ,
		left_padding = 4 ,
		-- 图形
		graphical_set =
		{
			base =
			{
				-- 选项卡面板是一种嵌入式面板 , 因此下方接触面的阴影不应该绘制
				top =
				{
					position = { 76 , 0 } ,
					size = { 1 , 8 }
				} ,
				bottom =
				{
					position = { 76 , 9 } ,
					size = { 1 , 8 }
				} ,
				center =
				{
					position = { 76 , 8 } ,
					size = { 1 , 1 }
				}
			} ,
			shadow = SIStyle.DirtTop.Shadow
		}
	} ,
	-- 标签本体
	tab_container =
	{
		type = "horizontal_flow_style" ,
		-- 偏移
		right_padding = 12 ,
		left_padding = 12 ,
		-- 元素间距
		horizontal_spacing = 0
	}
} )
.AddStyle( "RequestMap_Label" , "紫图-标签" ,
{
	type = "label_style" ,
	-- 偏移
	left_padding = 12 ,
	-- 体积
	width = 120 ,
	-- 对齐
	horizontal_align = "left"
} )
.AddStyle( "RequestMap_Text" , "紫图-文本条" ,
{
	type = "textbox_style" ,
	-- 体积
	width = 250
} )
.AddStyle( "RequestMap_EmptyFlow" , "紫图-空布局" ,
{
	type = "vertical_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowLeft ,
	-- 体积
	width = 300
} )
.AddStyle( "RequestMap_DropDown" , "紫图-下拉列表" ,
{
	type = "dropdown_style" ,
	parent = SIConstants_Core.raw.Styles.Common_DropDown ,
	-- 体积
	width = 250 ,
	height = 28
} )
.AddStyle( "RequestMap_ListButtonFlow" , "紫图-列表定位按钮布局" ,
{
	type = "horizontal_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowCenterH ,
	-- 偏移
	top_padding = 2 ,
	bottom_padding = 4
} )
.AddStyle( "RequestMap_ListButton" , "紫图-列表定位按钮" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonTitle ,
	-- 偏移
	top_padding = -2 ,
	right_padding = -2 ,
	bottom_padding = -2 ,
	left_padding = -2 ,
	-- 体积
	width = 16 ,
	height = 16
} )
.AddStyle( "RequestMap_ListCheck" , "紫图-列表复选" ,
{
	type = "checkbox_style" ,
	parent = SIConstants_Core.raw.Styles.Common_CheckBox ,
	-- 体积
	width = 758 ,
} )
.AddStyle( "RequestMap_ListFlow" , "紫图-列表布局" ,
{
	type = "vertical_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowLeft ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 30 ,
	-- 体积
	minimal_width = 758
} )
.AddStyle( "RequestMap_SubList" , "紫图-子列表" ,
{
	type = "table_style" ,
	parent = SIConstants_Core.raw.Styles.Common_List ,
	-- 体积
	minimal_width = 10 ,
	minimal_height = 10 ,
	-- 元素间距
	horizontal_spacing = 10 ,
	vertical_spacing = 5
} )
.AddStyle( "RequestMap_SelectList" , "紫图-选择列表" ,
{
	type = "table_style" ,
	parent = SIConstants_Core.raw.Styles.Common_List ,
	-- 体积
	minimal_width = 10 ,
	minimal_height = 10 ,
	-- 元素间距
	cell_spacing = 0 ,
	horizontal_spacing = 2 ,
	vertical_spacing = 2
} )
.AddStyle( "RequestMap_Chooser" , "紫图-选择" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonTitle ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 32 ,
	height = 32
} )
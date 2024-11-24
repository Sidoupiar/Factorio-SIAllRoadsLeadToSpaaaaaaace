-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 创建特殊工具 ====================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIGen
.SetGroup( SIConstants_Core.raw.Groups.Hidden.SpecialTool )

-- ======================================================================
-- 粉图
-- ======================================================================
.New( SICommon.Types.Items.SelectionTool , "DeleteMap" , "粉图" ,
{
	flags = { SICommon.Flags.Item.NotStackable , SICommon.Flags.Item.HideFromBonusGUI , SICommon.Flags.Item.HideFromFuelTooltip } ,
	stack_size = 1 ,
	default_request_amount = 1 ,
	show_in_library = false ,
	skip_fog_of_war = true ,
	always_include_tiles = false ,
	mouse_cursor = "selection-tool-cursor" ,
	select =
	{
		border_color = { r = 0.90 , g = 0.06 , b = 0.53 } ,
		count_button_color = { r = 0.90 , g = 0.06 , b = 0.53 } ,
		chart_color = { r = 0.90 , g = 0.06 , b = 0.53 } ,
		cursor_box_type = "copy" ,
		mode = { "any-entity" }
	} ,
	reverse_select =
	{
		border_color = { r = 0.90 , g = 0.06 , b = 0.53 } ,
		count_button_color = { r = 0.90 , g = 0.06 , b = 0.53 } ,
		chart_color = { r = 0.90 , g = 0.06 , b = 0.53 } ,
		cursor_box_type = "copy" ,
		mode = { "any-entity" }
	} ,
	alt_select =
	{
		border_color = { r = 0.55 , g = 0.27 , b = 0.41 } ,
		count_button_color = { r = 0.55 , g = 0.27 , b = 0.41 } ,
		chart_color = { r = 0.55 , g = 0.27 , b = 0.41 } ,
		cursor_box_type = "copy" ,
		mode = { "any-tile" }
	} ,
	alt_reverse_select =
	{
		border_color = { r = 0.55 , g = 0.27 , b = 0.41 } ,
		count_button_color = { r = 0.55 , g = 0.27 , b = 0.41 } ,
		chart_color = { r = 0.55 , g = 0.27 , b = 0.41 } ,
		cursor_box_type = "copy" ,
		mode = { "any-tile" }
	} ,
--	super_forced_select =
--	{
--		border_color = { r = 0.55 , g = 0.27 , b = 0.41 } ,
--		count_button_color = { r = 0.55 , g = 0.27 , b = 0.41 } ,
--		chart_color = { r = 0.55 , g = 0.27 , b = 0.41 } ,
--		cursor_box_type = "copy" ,
--		mode = { "any-tile" }
--	} ,
	fuel_category = SIConstants_Core.raw.Categories.Fuel.Special ,
	fuel_value = "120J" ,
	fuel_acceleration_multiplier = 1.1 ,
	fuel_top_speed_multiplier = 1.1 ,
	fuel_emissions_multiplier = 452 ,
	fuel_glow_color = { r = 0.90 , g = 0.06 , b = 0.53 }
} )
.Append
{
	burnt_result = SIConstants_ToolMap.raw.Items.DeleteMap ,
	place_result = nil ,
	placed_as_equipment_result = nil ,
	rocket_launch_products =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_ToolMap.raw.Items.DeleteMap ,
			amount = 2 ,
			catalyst_amount = 2
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_ToolMap.raw.Items.DeleteMap ,
			probability = 0.2 ,
			amount_min = 0 ,
			amount_max = 20 ,
			catalyst_amount = 20
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_ToolMap.raw.Items.DeleteMap ,
			probability = 0.06 ,
			amount_min = 0 ,
			amount_max = 200 ,
			catalyst_amount = 200
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_ToolMap.raw.Items.DeleteMap ,
			probability = 0.02 ,
			amount_min = 0 ,
			amount_max = 2000 ,
			catalyst_amount = 2000
		}
	}
}
.AutoIcon()
.SetItemIconSI()
.New( SICommon.Types.Equipments.Battery , "DeleteMap" , "粉图" ,
{
	hidden = true ,
	take_result = SIConstants_ToolMap.raw.Items.DeleteMap ,
	categories =
	{
		SIConstants_Core.raw.Categories.Equipment.Special
	} ,
	background_color = SICommon.Colors.Equipment.Default ,
	background_border_color = SICommon.Colors.Equipment.Border ,
	grabbed_background_color = SICommon.Colors.Equipment.DefaultHover ,
	shape =
	{
		type = SICommon.Flags.EquipmentShapeType.Full ,
		width = 2 ,
		height = 2
	} ,
	energy_source =
	{
		type = SICommon.Flags.EnergySourceType.Electric ,
		emissions_per_minute = { pollution = 0.0 } ,
		render_no_power_icon = false ,
		render_no_network_icon = false ,
		usage_priority = SICommon.Flags.ElectricUsagePriority.Tertiary ,
		buffer_capacity = "0J" ,
		input_flow_limit = "0W" ,
		output_flow_limit = "0W" ,
		drain = "0J"
	} ,
	sprite =
	{
		filename = SIGen.MakePicturePath( SICommon.Types.Items.SelectionTool , "DeleteMap" .. SICommon.CodeNameSuffix.ICON , "粉图" .. SICommon.ShowNameSuffix.ICON ) ,
		priority = "medium" ,
		width = 64 ,
		height = 64 ,
		scale = 1.0
	}
} )
.MakeIcon( SICommon.Types.Items.SelectionTool , "DeleteMap" , "粉图" , 64 , 4 )
.ReferenceEquipmentResult( SICommon.Types.Items.SelectionTool , SIConstants_ToolMap.raw.Items.DeleteMap )

-- ======================================================================
-- 黄图
-- ======================================================================
.New( SICommon.Types.Items.SelectionTool , "OreMap" , "黄图" ,
{
	flags = { SICommon.Flags.Item.NotStackable , SICommon.Flags.Item.HideFromBonusGUI , SICommon.Flags.Item.HideFromFuelTooltip } ,
	stack_size = 1 ,
	default_request_amount = 1 ,
	show_in_library = false ,
	skip_fog_of_war = true ,
	always_include_tiles = false ,
	mouse_cursor = "selection-tool-cursor" ,
	select =
	{
		border_color = { r = 0.70 , g = 0.57 , b = 0.00 } ,
		count_button_color = { r = 0.70 , g = 0.57 , b = 0.00 } ,
		chart_color = { r = 0.70 , g = 0.57 , b = 0.00 } ,
		cursor_box_type = "copy" ,
		mode = { "any-entity" }
	} ,
	alt_select =
	{
		border_color = { r = 1.00 , g = 0.82 , b = 0.00 } ,
		count_button_color = { r = 1.00 , g = 0.82 , b = 0.00 } ,
		chart_color = { r = 1.00 , g = 0.82 , b = 0.00 } ,
		cursor_box_type = "copy" ,
		mode = { "any-tile" }
	} ,
--	reverse_select =
--	{
--		border_color = { r = 0.55 , g = 0.27 , b = 0.41 } ,
--		count_button_color = { r = 0.55 , g = 0.27 , b = 0.41 } ,
--		chart_color = { r = 0.55 , g = 0.27 , b = 0.41 } ,
--		cursor_box_type = "copy" ,
--		mode = { "any-tile" }
--	} ,
--	alt_reverse_select =
--	{
--		border_color = { r = 0.55 , g = 0.27 , b = 0.41 } ,
--		count_button_color = { r = 0.55 , g = 0.27 , b = 0.41 } ,
--		chart_color = { r = 0.55 , g = 0.27 , b = 0.41 } ,
--		cursor_box_type = "copy" ,
--		mode = { "any-tile" }
--	} ,
--	super_forced_select =
--	{
--		border_color = { r = 0.55 , g = 0.27 , b = 0.41 } ,
--		count_button_color = { r = 0.55 , g = 0.27 , b = 0.41 } ,
--		chart_color = { r = 0.55 , g = 0.27 , b = 0.41 } ,
--		cursor_box_type = "copy" ,
--		mode = { "any-tile" }
--	} ,
	fuel_category = SIConstants_Core.raw.Categories.Fuel.Special ,
	fuel_value = "120J" ,
	fuel_acceleration_multiplier = 1.1 ,
	fuel_top_speed_multiplier = 1.1 ,
	fuel_emissions_multiplier = 452 ,
	fuel_glow_color = { r = 0.70 , g = 0.57 , b = 0.00 }
} )
.Append
{
	burnt_result = SIConstants_ToolMap.raw.Items.OreMap ,
	place_result = nil ,
	placed_as_equipment_result = nil ,
	rocket_launch_products =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_ToolMap.raw.Items.OreMap ,
			amount = 2 ,
			catalyst_amount = 2
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_ToolMap.raw.Items.OreMap ,
			probability = 0.2 ,
			amount_min = 0 ,
			amount_max = 20 ,
			catalyst_amount = 20
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_ToolMap.raw.Items.OreMap ,
			probability = 0.06 ,
			amount_min = 0 ,
			amount_max = 200 ,
			catalyst_amount = 200
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_ToolMap.raw.Items.OreMap ,
			probability = 0.02 ,
			amount_min = 0 ,
			amount_max = 2000 ,
			catalyst_amount = 2000
		}
	}
}
.AutoIcon()
.SetItemIconSI()
.New( SICommon.Types.Equipments.Battery , "OreMap" , "黄图" ,
{
	hidden = true ,
	take_result = SIConstants_ToolMap.raw.Items.OreMap ,
	categories =
	{
		SIConstants_Core.raw.Categories.Equipment.Special
	} ,
	background_color = SICommon.Colors.Equipment.Default ,
	background_border_color = SICommon.Colors.Equipment.Border ,
	grabbed_background_color = SICommon.Colors.Equipment.DefaultHover ,
	shape =
	{
		type = SICommon.Flags.EquipmentShapeType.Full ,
		width = 2 ,
		height = 2
	} ,
	energy_source =
	{
		type = SICommon.Flags.EnergySourceType.Electric ,
		emissions_per_minute = { pollution = 0.0 } ,
		render_no_power_icon = false ,
		render_no_network_icon = false ,
		usage_priority = SICommon.Flags.ElectricUsagePriority.Tertiary ,
		buffer_capacity = "0J" ,
		input_flow_limit = "0W" ,
		output_flow_limit = "0W" ,
		drain = "0J"
	} ,
	sprite =
	{
		filename = SIGen.MakePicturePath( SICommon.Types.Items.SelectionTool , "OreMap" .. SICommon.CodeNameSuffix.ICON , "黄图" .. SICommon.ShowNameSuffix.ICON ) ,
		priority = "medium" ,
		width = 64 ,
		height = 64 ,
		scale = 1.0
	}
} )
.MakeIcon( SICommon.Types.Items.SelectionTool , "OreMap" , "黄图" , 64 , 4 )
.ReferenceEquipmentResult( SICommon.Types.Items.SelectionTool , SIConstants_ToolMap.raw.Items.OreMap )

-- ======================================================================
-- 紫图
-- ======================================================================
.New( SICommon.Types.Items.SelectionTool , "RequestMap" , "紫图" ,
{
	flags = { SICommon.Flags.Item.NotStackable , SICommon.Flags.Item.HideFromBonusGUI , SICommon.Flags.Item.HideFromFuelTooltip } ,
	stack_size = 1 ,
	default_request_amount = 1 ,
	show_in_library = false ,
	skip_fog_of_war = true ,
	always_include_tiles = false ,
	mouse_cursor = "selection-tool-cursor" ,
	select =
	{
		border_color = { r = 0.84 , g = 0.06 , b = 0.92 } ,
		count_button_color = { r = 0.84 , g = 0.06 , b = 0.92 } ,
		chart_color = { r = 0.84 , g = 0.06 , b = 0.92 } ,
		cursor_box_type = "copy" ,
		mode = { "any-entity" , "same-force" }
	} ,
	reverse_select =
	{
		border_color = { r = 0.51 , g = 0.03 , b = 0.55 } ,
		count_button_color = { r = 0.51 , g = 0.03 , b = 0.55 } ,
		chart_color = { r = 0.51 , g = 0.03 , b = 0.55 } ,
		cursor_box_type = "copy" ,
		mode = { "any-entity" , "same-force" }
	} ,
	alt_select =
	{
		border_color = { r = 0.84 , g = 0.06 , b = 0.92 } ,
		count_button_color = { r = 0.84 , g = 0.06 , b = 0.92 } ,
		chart_color = { r = 0.84 , g = 0.06 , b = 0.92 } ,
		cursor_box_type = "copy" ,
		mode = { "any-entity" , "same-force" }
	} ,
	alt_reverse_select =
	{
		border_color = { r = 0.51 , g = 0.03 , b = 0.55 } ,
		count_button_color = { r = 0.51 , g = 0.03 , b = 0.55 } ,
		chart_color = { r = 0.51 , g = 0.03 , b = 0.55 } ,
		cursor_box_type = "copy" ,
		mode = { "any-entity" , "same-force" }
	} ,
--	super_forced_select =
--	{
--		border_color = { r = 0.55 , g = 0.27 , b = 0.41 } ,
--		count_button_color = { r = 0.55 , g = 0.27 , b = 0.41 } ,
--		chart_color = { r = 0.55 , g = 0.27 , b = 0.41 } ,
--		cursor_box_type = "copy" ,
--		mode = { "any-tile" }
--	} ,
	fuel_category = SIConstants_Core.raw.Categories.Fuel.Special ,
	fuel_value = "120J" ,
	fuel_acceleration_multiplier = 1.1 ,
	fuel_top_speed_multiplier = 1.1 ,
	fuel_emissions_multiplier = 452 ,
	fuel_glow_color = { r = 0.70 , g = 0.57 , b = 0.00 }
} )
.Append
{
	burnt_result = SIConstants_ToolMap.raw.Items.RequestMap ,
	place_result = nil ,
	placed_as_equipment_result = nil ,
	rocket_launch_products =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_ToolMap.raw.Items.RequestMap ,
			amount = 2 ,
			catalyst_amount = 2
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_ToolMap.raw.Items.RequestMap ,
			probability = 0.2 ,
			amount_min = 0 ,
			amount_max = 20 ,
			catalyst_amount = 20
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_ToolMap.raw.Items.RequestMap ,
			probability = 0.06 ,
			amount_min = 0 ,
			amount_max = 200 ,
			catalyst_amount = 200
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_ToolMap.raw.Items.RequestMap ,
			probability = 0.02 ,
			amount_min = 0 ,
			amount_max = 2000 ,
			catalyst_amount = 2000
		}
	}
}
.AutoIcon()
.SetItemIconSI()
.New( SICommon.Types.Equipments.Battery , "RequestMap" , "紫图" ,
{
	hidden = true ,
	take_result = SIConstants_ToolMap.raw.Items.RequestMap ,
	categories =
	{
		SIConstants_Core.raw.Categories.Equipment.Special
	} ,
	background_color = SICommon.Colors.Equipment.Default ,
	background_border_color = SICommon.Colors.Equipment.Border ,
	grabbed_background_color = SICommon.Colors.Equipment.DefaultHover ,
	shape =
	{
		type = SICommon.Flags.EquipmentShapeType.Full ,
		width = 2 ,
		height = 2
	} ,
	energy_source =
	{
		type = SICommon.Flags.EnergySourceType.Electric ,
		emissions_per_minute = { pollution = 0.0 } ,
		render_no_power_icon = false ,
		render_no_network_icon = false ,
		usage_priority = SICommon.Flags.ElectricUsagePriority.Tertiary ,
		buffer_capacity = "0J" ,
		input_flow_limit = "0W" ,
		output_flow_limit = "0W" ,
		drain = "0J"
	} ,
	sprite =
	{
		filename = SIGen.MakePicturePath( SICommon.Types.Items.SelectionTool , "RequestMap" .. SICommon.CodeNameSuffix.ICON , "紫图" .. SICommon.ShowNameSuffix.ICON ) ,
		priority = "medium" ,
		width = 64 ,
		height = 64 ,
		scale = 1.0
	}
} )
.MakeIcon( SICommon.Types.Items.SelectionTool , "RequestMap" , "紫图" , 64 , 4 )
.ReferenceEquipmentResult( SICommon.Types.Items.SelectionTool , SIConstants_ToolMap.raw.Items.RequestMap )

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 创建窗口快捷键 ==================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIGen
.New( SICommon.Types.Input , "OreMapFrame" , "黄图窗口" , { key_sequence = "SHIFT + O" } )
.New( SICommon.Types.Input , "RequestMapFrame" , "紫图窗口" , { key_sequence = "SHIFT + P" } )

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 创建控件 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIGen

-- ======================================================================
-- 黄图控件样式
-- ======================================================================
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

-- ======================================================================
-- 紫图控件样式
-- ======================================================================
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
		type = "table_style" ,
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
.AddStyle( "RequestMap_BlankFlow" , "紫图-空白区" ,
{
	type = "vertical_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowLeft ,
	-- 体积
	minimal_height = 200
} )
.AddStyle( "RequestMap_ListCheck" , "紫图-列表复选" ,
{
	type = "checkbox_style" ,
	parent = SIConstants_Core.raw.Styles.Common_CheckBox ,
	-- 体积
	width = 758 ,
} )
.AddStyle( "RequestMap_ListPanelFlow" , "紫图-列表面板布局" ,
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
.AddStyle( "RequestMap_ListChooser" , "紫图-列表选择" ,
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
.AddStyle( "RequestMap_ListFlow" , "紫图-列表布局" ,
{
	type = "horizontal_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowCenterH ,
	-- 元素间距
	horizontal_spacing = 6
} )
.AddStyle( "RequestMap_ListLabel" , "紫图-列表标签" ,
{
	type = "label_style" ,
	-- 体积
	minimal_width = 10 ,
	-- 对齐
	horizontal_align = "left"
} )
.AddStyle( "RequestMap_ListText" , "紫图-列表文本条" ,
{
	type = "textbox_style" ,
	-- 体积
	width = 120
} )
.AddStyle( "RequestMap_ListDropDown" , "紫图-列表下拉列表" ,
{
	type = "dropdown_style" ,
	parent = SIConstants_Core.raw.Styles.Common_DropDown ,
	-- 体积
	width = 120 ,
	height = 28
} )
.AddStyle( "RequestMap_ListEmptyFlow" , "紫图-列表占位布局" ,
{
	type = "horizontal_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowCenterH ,
	-- 体积
	minimal_width = 10
} )
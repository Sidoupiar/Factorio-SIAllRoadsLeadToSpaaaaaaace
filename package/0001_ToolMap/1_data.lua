-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 创建特殊工具 ====================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIGen
.SetGroup( SIConstants_Core.raw.Groups.Hidden.SpecialTool )
-- 粉图
.New( SICommon.Types.Items.SelectionTool , "DeleteMap" , "粉图" ,
{
	flags = { SICommon.Flags.Item.NotStackable , SICommon.Flags.Item.HideFromFuelTooltip } ,
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
	alt_select =
	{
		border_color = { r = 0.90 , g = 0.06 , b = 0.53 } ,
		count_button_color = { r = 0.90 , g = 0.06 , b = 0.53 } ,
		chart_color = { r = 0.90 , g = 0.06 , b = 0.53 } ,
		cursor_box_type = "copy" ,
		mode = { "any-entity" }
	} ,
	reverse_select =
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
	fuel_category = SIConstants_ToolMap.raw.Categories.Fuel.Special ,
	fuel_value = "120J" ,
	fuel_acceleration_multiplier = 1.1 ,
	fuel_top_speed_multiplier = 1.1 ,
	fuel_emissions_multiplier = 452 ,
	fuel_glow_color = { r = 0.90 , g = 0.06 , b = 0.53 } ,
	burnt_result = SIConstants_ToolMap.raw.Items.SuperCandy ,
	place_result = nil ,
	placed_as_equipment_result = nil ,
	rocket_launch_products =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_ToolMap.raw.Items.SuperCandy ,
			amount = 2 ,
			catalyst_amount = 2
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_ToolMap.raw.Items.SuperCandy ,
			probability = 0.2 ,
			amount_min = 0 ,
			amount_max = 20 ,
			catalyst_amount = 20
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_ToolMap.raw.Items.SuperCandy ,
			probability = 0.06 ,
			amount_min = 0 ,
			amount_max = 200 ,
			catalyst_amount = 200
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_ToolMap.raw.Items.SuperCandy ,
			probability = 0.02 ,
			amount_min = 0 ,
			amount_max = 2000 ,
			catalyst_amount = 2000
		}
	}
} )
.AutoIcon()
.SetItemIconSI()
.New( SICommon.Types.Equipments.Battery , "DeleteMap" , "粉图" ,
{
	take_result = SIConstants_ToolMap.raw.Items.DeleteMap ,
	categories =
	{
		SIConstants_ToolMap.raw.Categories.Equipment.Special
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
		filename = SIGen.MakePicturePath( SICommon.Types.Items.SelectionTool , "粉图" .. SICommon.ShowNameSuffix.ICON ) ,
		priority = "medium" ,
		width = 64 ,
		height = 64 ,
		scale = 1.0
	}
} )
.MakeIcon( SICommon.Types.Items.SelectionTool , "粉图" , 64 , 4 )
.ReferenceEquipmentResult( SICommon.Types.Items.SelectionTool , SIConstants_ToolMap.raw.Items.DeleteMap )
-- 黄图
.New( SICommon.Types.Items.SelectionTool , "OreMap" , "黄图" ,
{
	flags = { SICommon.Flags.Item.NotStackable , SICommon.Flags.Item.HideFromFuelTooltip } ,
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
	fuel_category = SIConstants_ToolMap.raw.Categories.Fuel.Special ,
	fuel_value = "120J" ,
	fuel_acceleration_multiplier = 1.1 ,
	fuel_top_speed_multiplier = 1.1 ,
	fuel_emissions_multiplier = 452 ,
	fuel_glow_color = { r = 0.70 , g = 0.57 , b = 0.00 } ,
	burnt_result = SIConstants_ToolMap.raw.Items.SuperCandy ,
	place_result = nil ,
	placed_as_equipment_result = nil ,
	rocket_launch_products =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_ToolMap.raw.Items.SuperCandy ,
			amount = 2 ,
			catalyst_amount = 2
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_ToolMap.raw.Items.SuperCandy ,
			probability = 0.2 ,
			amount_min = 0 ,
			amount_max = 20 ,
			catalyst_amount = 20
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_ToolMap.raw.Items.SuperCandy ,
			probability = 0.06 ,
			amount_min = 0 ,
			amount_max = 200 ,
			catalyst_amount = 200
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_ToolMap.raw.Items.SuperCandy ,
			probability = 0.02 ,
			amount_min = 0 ,
			amount_max = 2000 ,
			catalyst_amount = 2000
		}
	}
} )
.AutoIcon()
.SetItemIconSI()
.New( SICommon.Types.Equipments.Battery , "OreMap" , "黄图" ,
{
	take_result = SIConstants_ToolMap.raw.Items.OreMap ,
	categories =
	{
		SIConstants_ToolMap.raw.Categories.Equipment.Special
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
		filename = SIGen.MakePicturePath( SICommon.Types.Items.SelectionTool , "黄图" .. SICommon.ShowNameSuffix.ICON ) ,
		priority = "medium" ,
		width = 64 ,
		height = 64 ,
		scale = 1.0
	}
} )
.MakeIcon( SICommon.Types.Items.SelectionTool , "黄图" , 64 , 4 )
.ReferenceEquipmentResult( SICommon.Types.Items.SelectionTool , SIConstants_ToolMap.raw.Items.OreMap )
-- 紫图
.New( SICommon.Types.Items.SelectionTool , "RequestMap" , "紫图" ,
{
	flags = { SICommon.Flags.Item.NotStackable , SICommon.Flags.Item.HideFromFuelTooltip } ,
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
	alt_select =
	{
		border_color = { r = 0.51 , g = 0.03 , b = 0.55 } ,
		count_button_color = { r = 0.51 , g = 0.03 , b = 0.55 } ,
		chart_color = { r = 0.51 , g = 0.03 , b = 0.55 } ,
		cursor_box_type = "copy" ,
		mode = { "any-entity" , "same-force" }
	} ,
	reverse_select =
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
	fuel_category = SIConstants_ToolMap.raw.Categories.Fuel.Special ,
	fuel_value = "120J" ,
	fuel_acceleration_multiplier = 1.1 ,
	fuel_top_speed_multiplier = 1.1 ,
	fuel_emissions_multiplier = 452 ,
	fuel_glow_color = { r = 0.70 , g = 0.57 , b = 0.00 } ,
	burnt_result = SIConstants_ToolMap.raw.Items.SuperCandy ,
	place_result = nil ,
	placed_as_equipment_result = nil ,
	rocket_launch_products =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_ToolMap.raw.Items.SuperCandy ,
			amount = 2 ,
			catalyst_amount = 2
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_ToolMap.raw.Items.SuperCandy ,
			probability = 0.2 ,
			amount_min = 0 ,
			amount_max = 20 ,
			catalyst_amount = 20
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_ToolMap.raw.Items.SuperCandy ,
			probability = 0.06 ,
			amount_min = 0 ,
			amount_max = 200 ,
			catalyst_amount = 200
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_ToolMap.raw.Items.SuperCandy ,
			probability = 0.02 ,
			amount_min = 0 ,
			amount_max = 2000 ,
			catalyst_amount = 2000
		}
	}
} )
.AutoIcon()
.SetItemIconSI()
.New( SICommon.Types.Equipments.Battery , "RequestMap" , "紫图" ,
{
	take_result = SIConstants_ToolMap.raw.Items.RequestMap ,
	categories =
	{
		SIConstants_ToolMap.raw.Categories.Equipment.Special
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
		filename = SIGen.MakePicturePath( SICommon.Types.Items.SelectionTool , "紫图" .. SICommon.ShowNameSuffix.ICON ) ,
		priority = "medium" ,
		width = 64 ,
		height = 64 ,
		scale = 1.0
	}
} )
.MakeIcon( SICommon.Types.Items.SelectionTool , "紫图" , 64 , 4 )
.ReferenceEquipmentResult( SICommon.Types.Items.SelectionTool , SIConstants_ToolMap.raw.Items.RequestMap )

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 创建窗口快捷键 ==================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIGen
.New( SICommon.Types.Input , "OreMapFrame" , "黄图窗口" , { key_sequence = "SHIFT + O" } )
.New( SICommon.Types.Input , "RequestMapFrame" , "紫图窗口" , { key_sequence = "SHIFT + P" } )
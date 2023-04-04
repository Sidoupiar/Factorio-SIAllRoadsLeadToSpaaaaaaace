-- ------------------------------------------------------------------------------------------------
-- -------- 创建特殊实体 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen
.SetGroup( SIConstants_Core.raw.Groups.Hidden.Debug )
.New( SICommon.Types.Entities.FlyingText , "FlyingText" , "飞行文字" ,
{
	flags = { SICommon.Flags.Entity.NotOnMap , SICommon.Flags.Entity.PlaceableOffGrid } ,
	speed = 0.03 ,
	time_to_live = 170 ,
	text_alignment = "center"
} )

-- ------------------------------------------------------------------------------------------------
-- -------- 创建特殊工具 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen
.SetGroup( SIConstants_Core.raw.Groups.Hidden.Tool )
-- 粉图
.New( SICommon.Types.Items.SelectionTool , "DeleteMap" , "粉图" ,
{
	flags = { SICommon.Flags.Item.NotStackable , SICommon.Flags.Item.Hidden } ,
	stack_size = 1 ,
	default_request_amount = 1 ,
	show_in_library = false ,
	selection_color = { r = 0.90 , g = 0.06 , b = 0.53 } ,
	selection_mode = { "any-entity" } ,
	selection_cursor_box_type = "copy" ,
	alt_selection_color = { r = 0.55 , g = 0.27 , b = 0.41 } ,
	alt_selection_mode = { "any-tile" } ,
	alt_selection_cursor_box_type = "copy" ,
	fuel_category = SIConstants_Core.raw.Categories.Fuel.Special ,
	fuel_value = "12KJ" ,
	fuel_acceleration_multiplier = 1.1 ,
	fuel_top_speed_multiplier = 1.1 ,
	fuel_emissions_multiplier = 452 ,
	fuel_glow_color = { r = 0.90 , g = 0.06 , b = 0.53 } ,
	burnt_result = SIConstants_Core.raw.Items.Candy ,
	place_result = nil ,
	placed_as_equipment_result = nil ,
	rocket_launch_products =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			amount = 2 ,
			catalyst_amount = 2
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.2 ,
			amount_min = 0 ,
			amount_max = 20 ,
			catalyst_amount = 20
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.06 ,
			amount_min = 0 ,
			amount_max = 200 ,
			catalyst_amount = 200
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.02 ,
			amount_min = 0 ,
			amount_max = 2000 ,
			catalyst_amount = 2000
		}
	}
} )
.AutoIcon()
.New( SICommon.Types.Equipments.Battery , "DeleteMap" , "粉图" ,
{
	take_result = SIConstants_Core.raw.Items.DeleteMap ,
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
		emissions_per_minute = 0 ,
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
.ReferenceEquipmentResult( SICommon.Types.Items.SelectionTool , SIConstants_Core.raw.Items.DeleteMap )
-- 黄图
.New( SICommon.Types.Items.SelectionTool , "OreMap" , "黄图" ,
{
	flags = { SICommon.Flags.Item.NotStackable , SICommon.Flags.Item.Hidden } ,
	stack_size = 1 ,
	default_request_amount = 1 ,
	show_in_library = false ,
	selection_color = { r = 0.70 , g = 0.57 , b = 0.00 } ,
	selection_mode = { "any-entity" } ,
	selection_cursor_box_type = "copy" ,
	alt_selection_color = { r = 1.00 , g = 0.82 , b = 0.00 } ,
	alt_selection_mode = { "any-tile" } ,
	alt_selection_cursor_box_type = "copy" ,
	fuel_category = SIConstants_Core.raw.Categories.Fuel.Special ,
	fuel_value = "12KJ" ,
	fuel_acceleration_multiplier = 1.1 ,
	fuel_top_speed_multiplier = 1.1 ,
	fuel_emissions_multiplier = 452 ,
	fuel_glow_color = { r = 0.70 , g = 0.57 , b = 0.00 } ,
	burnt_result = SIConstants_Core.raw.Items.Candy ,
	place_result = nil ,
	placed_as_equipment_result = nil ,
	rocket_launch_products =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			amount = 2 ,
			catalyst_amount = 2
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.2 ,
			amount_min = 0 ,
			amount_max = 20 ,
			catalyst_amount = 20
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.06 ,
			amount_min = 0 ,
			amount_max = 200 ,
			catalyst_amount = 200
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.02 ,
			amount_min = 0 ,
			amount_max = 2000 ,
			catalyst_amount = 2000
		}
	}
} )
.AutoIcon()
.New( SICommon.Types.Equipments.Battery , "OreMap" , "黄图" ,
{
	take_result = SIConstants_Core.raw.Items.OreMap ,
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
		emissions_per_minute = 0 ,
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
.ReferenceEquipmentResult( SICommon.Types.Items.SelectionTool , SIConstants_Core.raw.Items.OreMap )
-- 紫图
.New( SICommon.Types.Items.SelectionTool , "RequestMap" , "紫图" ,
{
	flags = { SICommon.Flags.Item.NotStackable , SICommon.Flags.Item.Hidden } ,
	stack_size = 1 ,
	default_request_amount = 1 ,
	show_in_library = false ,
	selection_color = { r = 0.84 , g = 0.06 , b = 0.92 } ,
	selection_mode = { "any-entity" , "same-force" } ,
	selection_cursor_box_type = "copy" ,
	alt_selection_color = { r = 0.51 , g = 0.03 , b = 0.55 } ,
	alt_selection_mode = { "any-entity" , "same-force" } ,
	alt_selection_cursor_box_type = "copy" ,
	fuel_category = SIConstants_Core.raw.Categories.Fuel.Special ,
	fuel_value = "12KJ" ,
	fuel_acceleration_multiplier = 1.1 ,
	fuel_top_speed_multiplier = 1.1 ,
	fuel_emissions_multiplier = 452 ,
	fuel_glow_color = { r = 0.70 , g = 0.57 , b = 0.00 } ,
	burnt_result = SIConstants_Core.raw.Items.Candy ,
	place_result = nil ,
	placed_as_equipment_result = nil ,
	rocket_launch_products =
	{
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			amount = 2 ,
			catalyst_amount = 2
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.2 ,
			amount_min = 0 ,
			amount_max = 20 ,
			catalyst_amount = 20
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.06 ,
			amount_min = 0 ,
			amount_max = 200 ,
			catalyst_amount = 200
		} ,
		{
			type = SICommon.Types.Items.Item ,
			name = SIConstants_Core.raw.Items.Candy ,
			probability = 0.02 ,
			amount_min = 0 ,
			amount_max = 2000 ,
			catalyst_amount = 2000
		}
	}
} )
.AutoIcon()
.New( SICommon.Types.Equipments.Battery , "RequestMap" , "紫图" ,
{
	take_result = SIConstants_Core.raw.Items.RequestMap ,
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
		emissions_per_minute = 0 ,
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
.ReferenceEquipmentResult( SICommon.Types.Items.SelectionTool , SIConstants_Core.raw.Items.RequestMap )
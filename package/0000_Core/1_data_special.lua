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
	show_in_library = false ,
	selection_color = { 0.90 , 0.06 , 0.53 } ,
	selection_mode = { "any-entity" } ,
	selection_cursor_box_type = "copy" ,
	alt_selection_color = { 0.55 , 0.27 , 0.41 } ,
	alt_selection_mode = { "any-tile" } ,
	alt_selection_cursor_box_type = "copy" ,
	fuel_category = "chemical" ,
	fuel_value = "12KJ" ,
	fuel_acceleration_multiplier = 1.1 ,
	fuel_top_speed_multiplier = 1.1 ,
	fuel_emissions_multiplier = 452 ,
	fuel_glow_color = { 0.90 , 0.06 , 0.53 } ,
	burnt_result = "explosives" ,
	placed_as_equipment_result = nil ,
	rocket_launch_products =
	{
		{
			name = "cluster-grenade" ,
			amount_min = 0 ,
			amount_max = 48 ,
			catalyst_amount = 48
		} ,
		{
			name = "destroyer-capsule" ,
			amount_min = 0 ,
			amount_max = 48 ,
			catalyst_amount = 48
		} ,
		{
			name = "defender-capsule" ,
			amount_min = 0 ,
			amount_max = 48 ,
			catalyst_amount = 48
		} ,
		{
			name = "poison-capsule" ,
			amount_min = 0 ,
			amount_max = 48 ,
			catalyst_amount = 48
		} ,
		{
			name = "slowdown-capsule" ,
			amount_min = 0 ,
			amount_max = 48 ,
			catalyst_amount = 48
		}
	}
} )
.AutoIcon()
.New( SICommon.Types.Equipments.Battery , "DeleteMap" , "粉图" ,
{
	take_result = SIConstants_Core.raw.Items.DeleteMap ,
	categories =
	{
		"armor"
	} ,
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
	show_in_library = false ,
	selection_color = { 0.70 , 0.57 , 0.00 } ,
	selection_mode = { "any-entity" } ,
	selection_cursor_box_type = "copy" ,
	alt_selection_color = { 1.00 , 0.82 , 0.00 } ,
	alt_selection_mode = { "any-tile" } ,
	alt_selection_cursor_box_type = "copy" ,
	fuel_category = "chemical" ,
	fuel_value = "12KJ" ,
	fuel_acceleration_multiplier = 1.1 ,
	fuel_top_speed_multiplier = 1.1 ,
	fuel_emissions_multiplier = 452 ,
	fuel_glow_color = { 0.70 , 0.57 , 0.00 } ,
	burnt_result = "stone-brick" ,
	placed_as_equipment_result = nil ,
	rocket_launch_products =
	{
		{
			name = "iron-ore" ,
			probability = 0.5 ,
			amount_min = 0 ,
			amount_max = 500 ,
			catalyst_amount = 500
		} ,
		{
			name = "copper-ore" ,
			probability = 0.5 ,
			amount_min = 0 ,
			amount_max = 500 ,
			catalyst_amount = 500
		} ,
		{
			name = "uranium-ore" ,
			probability = 0.5 ,
			amount_min = 0 ,
			amount_max = 500 ,
			catalyst_amount = 500
		} ,
		{
			name = "stone" ,
			probability = 0.5 ,
			amount_min = 0 ,
			amount_max = 500 ,
			catalyst_amount = 500
		} ,
		{
			name = "coal" ,
			probability = 0.5 ,
			amount_min = 0 ,
			amount_max = 500 ,
			catalyst_amount = 500
		}
	}
} )
.AutoIcon()
.New( SICommon.Types.Equipments.Battery , "OreMap" , "黄图" ,
{
	take_result = SIConstants_Core.raw.Items.OreMap ,
	categories =
	{
		"armor"
	} ,
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
	show_in_library = false ,
	selection_color = { 0.84 , 0.06 , 0.92 } ,
	selection_mode = { "any-entity" , "same-force" } ,
	selection_cursor_box_type = "copy" ,
	alt_selection_color = { 0.51 , 0.03 , 0.55 } ,
	alt_selection_mode = { "any-entity" , "same-force" } ,
	alt_selection_cursor_box_type = "copy" ,
	fuel_category = "chemical" ,
	fuel_value = "12KJ" ,
	fuel_acceleration_multiplier = 1.1 ,
	fuel_top_speed_multiplier = 1.1 ,
	fuel_emissions_multiplier = 452 ,
	fuel_glow_color = { 0.70 , 0.57 , 0.00 } ,
	burnt_result = "copper-cable" ,
	placed_as_equipment_result = nil ,
	rocket_launch_products =
	{
		{
			name = "burner-inserter" ,
			probability = 0.35 ,
			amount_min = 0 ,
			amount_max = 35 ,
			catalyst_amount = 35
		} ,
		{
			name = "inserter" ,
			probability = 0.35 ,
			amount_min = 0 ,
			amount_max = 35 ,
			catalyst_amount = 35
		} ,
		{
			name = "fast-inserter" ,
			probability = 0.35 ,
			amount_min = 0 ,
			amount_max = 35 ,
			catalyst_amount = 35
		} ,
		{
			name = "filter-inserter" ,
			probability = 0.35 ,
			amount_min = 0 ,
			amount_max = 35 ,
			catalyst_amount = 35
		} ,
		{
			name = "long-handed-inserter" ,
			probability = 0.35 ,
			amount_min = 0 ,
			amount_max = 35 ,
			catalyst_amount = 35
		}
	}
} )
.AutoIcon()
.New( SICommon.Types.Equipments.Battery , "RequestMap" , "紫图" ,
{
	take_result = SIConstants_Core.raw.Items.RequestMap ,
	categories =
	{
		"armor"
	} ,
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
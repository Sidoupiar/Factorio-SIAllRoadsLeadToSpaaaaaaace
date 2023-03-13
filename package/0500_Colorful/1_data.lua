-- ------------------------------------------------------------------------------------------------
-- ---------- 多彩母版 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen
.SetGroup( SIConstants_Colorful.raw.Groups.Colorful.Pixel )
.New( SICommon.Types.Items.Item , "Pixel" , "像素块母板" ,
{
	stack_size = 1000 ,
	place_result = nil
} )
.AutoIcon()
for r = 0 , SIConstants_Colorful.ColorMax , SIConstants_Colorful.ColorStep do
	for g = 0 , SIConstants_Colorful.ColorMax , SIConstants_Colorful.ColorStep do
		for b = 0 , SIConstants_Colorful.ColorMax , SIConstants_Colorful.ColorStep do
			local tint = SICommon.Colors.MakeColor256( r , g , b )
			local colorText = tostring( tint.r ) .. "," .. tostring( tint.g ) .. "," .. tostring( tint.b )
			local colorTextHex = SICommon.Colors.MakeHex256( r , g , b )
			SIGen.New( SICommon.Types.Entities.SimpleOwner , "Pixel_" .. r .. "_" .. g .. "_" .. b , "像素块-" .. r .. "-" .. g .. "-" .. b )
			.Append
			{
				localised_name = SIGen.MakeSelfLocalisedName( "像素块" , colorTextHex ) ,
				localised_description = SIGen.MakeSelfLocalisedDescription( "像素块" , colorText , colorTextHex ) ,
				icons =
				{
					{
						icon = SIGen.MakeSelfPicturePath( "像素块-图标" ) ,
						icon_size = 64 ,
						icon_mipmaps = 4 ,
						tint = tint
					}
				} ,
				icon_size = 64 ,
				icon_mipmaps = 4 ,
				flags = { SICommon.Flags.Entity.PlaceablePlayer , SICommon.Flags.Entity.PlayerCreation , SICommon.Flags.Entity.HideAltInfo } ,
				minable =
				{
					mining_time = 0.05 ,
					results =
					{
						{
							type = SICommon.Types.Items.item ,
							name = SIConstants_Colorful.raw.Items.Pixel ,
							amount = 1
						}
					}
				} ,
				placeable_by =
				{
					item = SIConstants_Colorful.raw.Items.Pixel ,
					count = 1
				} ,
				max_health = 10 ,
				corpse = "small-remnants" ,
				dying_explosion = "wall-explosion" ,
				map_color = tint ,
				friendly_map_color = tint ,
				enemy_map_color = tint ,
				alert_when_damaged = false ,
				hide_resistances = true ,
				return_ingredients_on_change = false ,
				render_layer = SICommon.Flags.RenderLayer.FloorMechanics ,
				pictures =
				{
					{
						layers =
						{
							{
								filename = SIGen.MakeSelfPicturePath( "像素块" ) ,
								priority = "very-low" ,
								width = 32 ,
								height = 32 ,
								scale = 1.0 ,
								tint = tint
							}
						}
					}
				} ,
				mined_sound =
				{
					{
						filename = "__core__/sound/deconstruct-bricks.ogg" ,
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
			}
			.SetSizeScale( 1 , 1 , 0.04 )
		end
	end
end
SIGen.Find( SICommon.Types.Items.Item , SIConstants_Colorful.raw.Items.Pixel , function( prototypeName , prototypeData )
	prototypeData.place_result = SIConstants_Colorful.raw.Entities.Pixel_256_256_256
end )

-- ------------------------------------------------------------------------------------------------
-- --------- 多彩调色盘 ---------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen
.SetGroup( SIConstants_Colorful.raw.Groups.Colorful.Tool )
-- 粉图
.New( SICommon.Types.Items.SelectionTool , "ColorPanel" , "多彩调色盘" ,
{
	flags = { SICommon.Flags.Item.NotStackable } ,
	stack_size = 1 ,
	show_in_library = false ,
	selection_color = { 0 , 0 , 0 } ,
	selection_mode = { "any-entity" } ,
	selection_cursor_box_type = "copy" ,
	alt_selection_color = { 1 , 1 , 1 } ,
	alt_selection_mode = { "any-entity" } ,
	alt_selection_cursor_box_type = "copy"
} )
.AutoIcon()

-- ------------------------------------------------------------------------------------------------
-- ---------- 创建控件 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen
-- ----------------------------------------
-- 多彩调色盘拾色器控件样式
-- ----------------------------------------
.AddStyle( "ColorPanel_Frame" , "多彩调色盘拾色器-窗口" ,
{
	type = "frame_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Frame ,
	-- 体积
	minimal_width = 100 ,
	minimal_height = 100 ,
	maximal_height = 700
} )
.AddStyle( "ColorPanel_LabelTop" , "多彩调色盘拾色器-标签顶部" ,
{
	type = "label_style" ,
	-- 体积
	width = 400 ,
	-- 对齐
	horizontal_align = "left"
} )
.AddStyle( "ColorPanel_List" , "多彩调色盘拾色器-列表" ,
{
	type = "table_style" ,
	-- 元素间距
	cell_spacing = 0 ,
	horizontal_spacing = 0 ,
	vertical_spacing = 0
} )
.AddStyle( "ColorPanel_Pixel" , "多彩调色盘拾色器-色块" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonGray ,
	-- 偏移
	top_padding = -4 ,
	right_padding = -4 ,
	bottom_padding = -4 ,
	left_padding = -4 ,
	-- 体积
	width = 15 ,
	height = 15
} )
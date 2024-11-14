-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 多彩母版 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIGen
.SetGroup( SIConstants_Colorful.raw.Groups.Colorful.Pixel )
-- 像素块母板
.New( SICommon.Types.Items.Item , "Pixel" , "像素块母板" ,
{
	stack_size = 1000 ,
	default_request_amount = 1000 ,
	place_result = nil
} )
.AutoIcon()
-- 各种像素块
for r = 0 , SIConstants_Colorful.ColorMax , SIConstants_Colorful.ColorStep do
	for g = 0 , SIConstants_Colorful.ColorMax , SIConstants_Colorful.ColorStep do
		for b = 0 , SIConstants_Colorful.ColorMax , SIConstants_Colorful.ColorStep do
			local tint = SITools.MakeColor256( r , g , b )
			local colorText = tostring( tint.r ) .. "," .. tostring( tint.g ) .. "," .. tostring( tint.b )
			local colorTextHex = SITools.MakeHex256( r , g , b )
			SIGen
			.New( SICommon.Types.Entities.SimpleOwner , "Pixel_" .. r .. "_" .. g .. "_" .. b , "像素块-" .. r .. "-" .. g .. "-" .. b )
			.SetSizeScale( 1 , 1 , 0.04 )
			.Append
			{
				localised_name = SIGen.MakeSelfLocalisedName( "像素块" , colorTextHex ) ,
				localised_description = SIGen.MakeSelfLocalisedDescription( "像素块" , colorText , colorTextHex ) ,
				icons =
				{
					{
						icon = SIGen.MakeSelfPicturePath( "Pixel-icon" , "像素块-图标" ) ,
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
							type = SICommon.Types.Items.Item ,
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
				is_military_target = true ,
				allow_run_time_change_of_is_military_target = true ,
				alert_when_damaged = true ,
				create_ghost_on_death = true ,
				hide_resistances = true ,
				resistances = nil ,
				render_layer = SICommon.Flags.RenderLayer.FloorMechanics ,
				pictures =
				{
					{
						layers =
						{
							{
								filename = SIGen.MakeSelfPicturePath( "Pixel" , "像素块" ) ,
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
			}
		end
	end
end
SIGen.Find( SICommon.Types.Items.Item , SIConstants_Colorful.raw.Items.Pixel , function( prototypeName , prototypeData )
	prototypeData.place_result = SIConstants_Colorful.raw.Entities.Pixel_256_256_256
end )

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 多彩调色盘 ======================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIGen
.SetGroup( SIConstants_Colorful.raw.Groups.Colorful.Tool )
-- 多彩调色盘
.New( SICommon.Types.Items.SelectionTool , "ColorPanel" , "多彩调色盘" ,
{
	flags = { SICommon.Flags.Item.NotStackable } ,
	stack_size = 1 ,
	default_request_amount = 1 ,
	show_in_library = false ,
	selection_color = { r = 0.00 , g = 0.00 , b = 0.00 } ,
	selection_mode = { "any-entity" , "same-force" } ,
	selection_cursor_box_type = "copy" ,
	reverse_selection_color = { r = 1.00 , g = 0.00 , b = 0.00 } ,
	reverse_selection_mode = { "any-entity" , "same-force" } ,
	reverse_selection_cursor_box_type = "copy" ,
	alt_selection_color = { r = 1.00 , g = 1.00 , b = 1.00 } ,
	alt_selection_mode = { "any-entity" , "same-force" } ,
	alt_selection_cursor_box_type = "copy" ,
	alt_reverse_selection_color = { r = 1.00 , g = 0.00 , b = 0.00 } ,
	alt_reverse_selection_mode = { "any-entity" , "same-force" } ,
	alt_reverse_selection_cursor_box_type = "copy"
} )
.AutoIcon()
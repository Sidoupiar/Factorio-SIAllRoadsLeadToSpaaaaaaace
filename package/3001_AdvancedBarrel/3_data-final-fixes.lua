-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 装桶 ============================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

local BarrelItemIDPrefix_1 = "Barrel_1_"
local BarrelFullIDPrefix_1 = "BarrelFull_1_"
local BarrelEmptyIDPrefix_1 = "BarrelEmpty_1_"
local BarrelFullAssembledIDPrefix_1 = "BarrelFullAssembled_1_"
local BarrelEmptyAssembledIDPrefix_1 = "BarrelEmptyAssembled_1_"
local BarrelItemAliasPrefix_1 = "桶装-1-"
local BarrelFullAliasPrefix_1 = "灌装-1-"
local BarrelEmptyAliasPrefix_1 = "倾倒-1-"
local BarrelFullAssembledAliasPrefix_1 = "灌装组装-1-"
local BarrelEmptyAssembledAliasPrefix_1 = "倾倒组装-1-"
local BarrelItemLocalisedPrefix_1 = "桶装-1"
local BarrelFullLocalisedPrefix_1 = "灌装-1"
local BarrelEmptyLocalisedPrefix_1 = "倾倒-1"

local BarrelItemIDPrefix_2 = "Barrel_2_"
local BarrelFullIDPrefix_2 = "BarrelFull_2_"
local BarrelEmptyIDPrefix_2 = "BarrelEmpty_2_"
local BarrelFullAssembledIDPrefix_2 = "BarrelFullAssembled_2_"
local BarrelEmptyAssembledIDPrefix_2 = "BarrelEmptyAssembled_2_"
local BarrelItemAliasPrefix_2 = "桶装-2-"
local BarrelFullAliasPrefix_2 = "灌装-2-"
local BarrelEmptyAliasPrefix_2 = "倾倒-2-"
local BarrelFullAssembledAliasPrefix_2 = "灌装组装-2-"
local BarrelEmptyAssembledAliasPrefix_2 = "倾倒组装-2-"
local BarrelItemLocalisedPrefix_2 = "桶装-2"
local BarrelFullLocalisedPrefix_2 = "灌装-2"
local BarrelEmptyLocalisedPrefix_2 = "倾倒-2"

local BarrelItemIDPrefix_3 = "Barrel_3_"
local BarrelFullIDPrefix_3 = "BarrelFull_3_"
local BarrelEmptyIDPrefix_3 = "BarrelEmpty_3_"
local BarrelEmptyAssembledIDPrefix_3 = "BarrelEmptyAssembled_3_"
local BarrelItemAliasPrefix_3 = "桶装-3-"
local BarrelFullAliasPrefix_3 = "灌装-3-"
local BarrelEmptyAliasPrefix_3 = "倾倒-3-"
local BarrelEmptyAssembledAliasPrefix_3 = "倾倒组装-3-"
local BarrelItemLocalisedPrefix_3 = "桶装-3"
local BarrelFullLocalisedPrefix_3 = "灌装-3"
local BarrelEmptyLocalisedPrefix_3 = "倾倒-3"

local BarrelFullIconFluidShift = { -8 , -8 }
local BarrelEmptyIconFluidShift = { 8 , 8 }
local BarrelEntityShift = SIUtils.by_pixel( 0 , -8.5 )
local Barrel_1_EntityShadowShift = SIUtils.by_pixel( 16.5 , 0 )
local Barrel_2_EntityShadowShift_1 = SIUtils.by_pixel( 8 , 0 )
local Barrel_2_EntityShadowShift_2 = SIUtils.by_pixel( 4 , 0 )
local Barrel_2_EntityShadowShift_3 = SIUtils.by_pixel( 4 , 0 )
local Barrel_2_EntityShadowShift_4 = SIUtils.by_pixel( 1.5 , 0 )

local ignoreAutoBarrel = SIConfigs.SIAdvancedBarrel.IgnoreAutoBarrel ~= nil and SISettings.Startup.SIAdvancedBarrel.IgnoreAutoBarrel() or false
local barrelSize = SIConfigs.SIAdvancedBarrel.BarrelSize ~= nil and SISettings.Startup.SIAdvancedBarrel.BarrelSize() or 100
local barrelStackSize = SIConfigs.SIAdvancedBarrel.BarrelStackSize ~= nil and SISettings.SIAdvancedBarrel.BarrelStackSize() or 10

-- 流体装桶
SIGen
.SetGroup( SIConstants_AdvancedBarrel.raw.Groups.Expand.MakeBarrel )
.ForEach( SICommon.Types.Fluid , function( fluidPrototypeName , fluidPrototypeData )
	if SIConfigs.SIAdvancedBarrel.BarrelBlackList[fluidPrototypeName] then
		return
	end
	if fluidPrototypeData and not fluidPrototypeData.hidden and ( ignoreAutoBarrel or fluidPrototypeData.auto_barrel ~= false ) then
		local fluidIcons = nil
		if fluidPrototypeData.icons then
			fluidIcons = fluidPrototypeData.icons
			local size = fluidPrototypeData.icon_size
			local mipmaps = fluidPrototypeData.icon_mipmaps
			for index , icon in pairs( fluidIcons ) do
				if not icon.icon_size then
					icon.icon_size = size
				end
				if not icon.icon_mipmaps then
					icon.icon_mipmaps = mipmaps
				end
			end
		elseif fluidPrototypeData.icon then
			fluidIcons =
			{
				{
					icon = fluidPrototypeData.icon ,
					icon_size = fluidPrototypeData.icon_size ,
					icon_mipmaps = fluidPrototypeData.icon_mipmaps
				}
			}
		end
		local fluidColor = fluidPrototypeData.base_color
		if fluidColor and fluidIcons then
			local fluidName = fluidPrototypeName
			local fluidID = fluidName:gsub( "_" , "-" )
			local localName = fluidPrototypeData.localised_name or { "fluid-name." .. fluidName }
			local localDescription = fluidPrototypeData.localised_description or { "fluid-description." .. fluidName }
			SIGen
			-- ======================================================================
			-- 灌装科技 1
			-- ======================================================================
			.New( SICommon.Types.Items.Item , BarrelItemIDPrefix_1 .. fluidID , BarrelItemAliasPrefix_1 .. fluidName )
			.Append
			{
				localised_name = SIGen.MakeSelfLocalisedName( BarrelItemLocalisedPrefix_1 , localName ) ,
				localised_description = SIGen.MakeSelfLocalisedDescription( BarrelItemLocalisedPrefix_1 , localDescription ) ,
				icons =
				{
					{
						icon = SIGen.MakeSelfPicturePath( "木桶-身体" .. SICommon.ShowNameSuffix.ICON ) ,
						icon_size = 64 ,
						icon_mipmaps = 4
					} ,
					{
						icon = SIGen.MakeSelfPicturePath( "木桶-顶部" .. SICommon.ShowNameSuffix.ICON ) ,
						icon_size = 64 ,
						icon_mipmaps = 4 ,
						tint = fluidColor
					}
				} ,
				icon_size = 64 ,
				icon_mipmaps = 4 ,
				stack_size = barrelStackSize ,
				default_request_amount = barrelStackSize ,
				place_result = nil
			}
			.New( SICommon.Types.Recipe , BarrelFullIDPrefix_1 .. fluidID , BarrelFullAliasPrefix_1 .. fluidID )
			.ReferenceUnlockRecipe( SIConstants_AdvancedBarrel.raw.Technologies.Barrel_1 )
			.Append
			{
				localised_name = SIGen.MakeSelfLocalisedName( BarrelFullLocalisedPrefix_1 , localName ) ,
				localised_description = SIGen.MakeSelfLocalisedDescription( BarrelFullLocalisedPrefix_1 ) ,
				icons =
				{
					{
						icon = SIGen.MakeSelfPicturePath( "木桶-身体" .. SICommon.ShowNameSuffix.ICON ) ,
						icon_size = 64 ,
						icon_mipmaps = 4
					} ,
					{
						icon = SIGen.MakeSelfPicturePath( "木桶-顶部" .. SICommon.ShowNameSuffix.ICON ) ,
						icon_size = 64 ,
						icon_mipmaps = 4 ,
						tint = fluidColor
					}
				} ,
				icon_size = 64 ,
				icon_mipmaps = 4 ,
				category = SIConstants_AdvancedBarrel.raw.Categories.Recipe.MakeBarrel ,
				crafting_machine_tint =
				{
					primary = fluidColor ,
					secondary = fluidColor ,
					tertiary = fluidColor ,
					quaternary = fluidColor
				} ,
				enabled = false ,
				hidden = false ,
				hide_from_stats = false ,
				hide_from_player_crafting = true ,
				energy_required = 0.2 ,
				ingredients =
				{
					{
						type = SICommon.Types.Items.Item ,
						name = SIConstants_AdvancedBarrel.raw.Items.WoodenBarrel ,
						amount = 1
					} ,
					{
						type = SICommon.Types.Fluid ,
						name = fluidName ,
						amount = barrelSize
					}
				} ,
				results =
				{
					{
						type = SICommon.Types.Items.Item ,
						name = SIConstants_AdvancedBarrel.raw.Items[BarrelItemIDPrefix_1 .. fluidID] ,
						amount = 1 ,
						catalyst_amount = 1
					}
				} ,
				main_product = SIConstants_AdvancedBarrel.raw.Items[BarrelItemIDPrefix_1 .. fluidID] ,
				emissions_multiplier = 0.1 ,
				requester_paste_multiplier = 10 ,
				overload_multiplier = 5 ,
				allow_inserter_overload = true ,
				allow_decomposition = true ,
				allow_intermediates = true ,
				allow_as_intermediate = true ,
				always_show_products = true ,
				always_show_made_in = true ,
				show_amount_in_title = false ,
				unlock_results = true
			}
			.AddFunction( function( prototypeName , prototypeData )
				for index , icon in pairs( fluidIcons ) do
					local iconData = SIUtils.table.deepcopy( icon )
					iconData.scale = 12 / iconData.icon_size
					iconData.shift = BarrelFullIconFluidShift
					table.insert( prototypeData.icons , iconData )
				end
			end )
			.New( SICommon.Types.Recipe , BarrelEmptyIDPrefix_1 .. fluidID , BarrelEmptyAliasPrefix_1 .. fluidID )
			.ReferenceUnlockRecipe( SIConstants_AdvancedBarrel.raw.Technologies.Barrel_1 )
			.Append
			{
				localised_name = SIGen.MakeSelfLocalisedName( BarrelEmptyLocalisedPrefix_1 , localName ) ,
				localised_description = SIGen.MakeSelfLocalisedDescription( BarrelEmptyLocalisedPrefix_1 ) ,
				icons =
				{
					{
						icon = SIGen.MakeSelfPicturePath( "木桶-身体" .. SICommon.ShowNameSuffix.ICON ) ,
						icon_size = 64 ,
						icon_mipmaps = 4
					} ,
					{
						icon = SIGen.MakeSelfPicturePath( "木桶-顶部" .. SICommon.ShowNameSuffix.ICON ) ,
						icon_size = 64 ,
						icon_mipmaps = 4 ,
						tint = fluidColor
					}
				} ,
				icon_size = 64 ,
				icon_mipmaps = 4 ,
				category = SIConstants_AdvancedBarrel.raw.Categories.Recipe.DropBarrel ,
				crafting_machine_tint =
				{
					primary = fluidColor ,
					secondary = fluidColor ,
					tertiary = fluidColor ,
					quaternary = fluidColor
				} ,
				enabled = false ,
				hidden = false ,
				hide_from_stats = false ,
				hide_from_player_crafting = true ,
				energy_required = 0.2 ,
				ingredients =
				{
					{
						type = SICommon.Types.Items.Item ,
						name = SIConstants_AdvancedBarrel.raw.Items[BarrelItemIDPrefix_1 .. fluidID] ,
						amount = 1
					}
				} ,
				results =
				{
					{
						type = SICommon.Types.Items.Item ,
						name = SIConstants_AdvancedBarrel.raw.Items.WoodenBarrel ,
						amount = 1 ,
						catalyst_amount = 1
					} ,
					{
						type = SICommon.Types.Fluid ,
						name = fluidName ,
						amount = barrelSize ,
						catalyst_amount = barrelSize
					}
				} ,
				main_product = fluidName ,
				emissions_multiplier = 0.1 ,
				requester_paste_multiplier = 10 ,
				overload_multiplier = 5 ,
				allow_inserter_overload = true ,
				allow_decomposition = true ,
				allow_intermediates = true ,
				allow_as_intermediate = true ,
				always_show_products = true ,
				always_show_made_in = true ,
				show_amount_in_title = false ,
				unlock_results = true
			}
			.AddFunction( function( prototypeName , prototypeData )
				for index , icon in pairs( fluidIcons ) do
					local iconData = SIUtils.table.deepcopy( icon )
					iconData.scale = 12 / iconData.icon_size
					iconData.shift = BarrelEmptyIconFluidShift
					table.insert( prototypeData.icons , iconData )
				end
			end )
			.New( SICommon.Types.Recipe , BarrelFullAssembledIDPrefix_1 .. fluidID , BarrelFullAssembledAliasPrefix_1 .. fluidID )
			.ReferenceUnlockRecipe( SIConstants_AdvancedBarrel.raw.Technologies.Barrel_1 )
			.Append
			{
				localised_name = SIGen.MakeSelfLocalisedName( BarrelFullLocalisedPrefix_1 , localName ) ,
				localised_description = SIGen.MakeSelfLocalisedDescription( BarrelFullLocalisedPrefix_1 ) ,
				icons =
				{
					{
						icon = SIGen.MakeSelfPicturePath( "木桶-身体" .. SICommon.ShowNameSuffix.ICON ) ,
						icon_size = 64 ,
						icon_mipmaps = 4
					} ,
					{
						icon = SIGen.MakeSelfPicturePath( "木桶-顶部" .. SICommon.ShowNameSuffix.ICON ) ,
						icon_size = 64 ,
						icon_mipmaps = 4 ,
						tint = fluidColor
					}
				} ,
				icon_size = 64 ,
				icon_mipmaps = 4 ,
				category = "crafting-with-fluid" ,
				crafting_machine_tint =
				{
					primary = fluidColor ,
					secondary = fluidColor ,
					tertiary = fluidColor ,
					quaternary = fluidColor
				} ,
				enabled = false ,
				hidden = false ,
				hide_from_stats = false ,
				hide_from_player_crafting = true ,
				energy_required = 1.0 ,
				ingredients =
				{
					{
						type = SICommon.Types.Items.Item ,
						name = SIConstants_AdvancedBarrel.raw.Items.WoodenBarrel ,
						amount = 1
					} ,
					{
						type = SICommon.Types.Fluid ,
						name = fluidName ,
						amount = barrelSize
					}
				} ,
				results =
				{
					{
						type = SICommon.Types.Items.Item ,
						name = SIConstants_AdvancedBarrel.raw.Items[BarrelItemIDPrefix_1 .. fluidID] ,
						amount = 1 ,
						catalyst_amount = 1
					}
				} ,
				main_product = SIConstants_AdvancedBarrel.raw.Items[BarrelItemIDPrefix_1 .. fluidID] ,
				emissions_multiplier = 0.1 ,
				requester_paste_multiplier = 10 ,
				overload_multiplier = 5 ,
				allow_inserter_overload = true ,
				allow_decomposition = true ,
				allow_intermediates = true ,
				allow_as_intermediate = true ,
				always_show_products = true ,
				always_show_made_in = true ,
				show_amount_in_title = false ,
				unlock_results = true
			}
			.AddFunction( function( prototypeName , prototypeData )
				for index , icon in pairs( fluidIcons ) do
					local iconData = SIUtils.table.deepcopy( icon )
					iconData.scale = 12 / iconData.icon_size
					iconData.shift = BarrelFullIconFluidShift
					table.insert( prototypeData.icons , iconData )
				end
			end )
			.New( SICommon.Types.Recipe , BarrelEmptyAssembledIDPrefix_1 .. fluidID , BarrelEmptyAssembledAliasPrefix_1 .. fluidID )
			.ReferenceUnlockRecipe( SIConstants_AdvancedBarrel.raw.Technologies.Barrel_1 )
			.Append
			{
				localised_name = SIGen.MakeSelfLocalisedName( BarrelEmptyLocalisedPrefix_1 , localName ) ,
				localised_description = SIGen.MakeSelfLocalisedDescription( BarrelEmptyLocalisedPrefix_1 ) ,
				icons =
				{
					{
						icon = SIGen.MakeSelfPicturePath( "木桶-身体" .. SICommon.ShowNameSuffix.ICON ) ,
						icon_size = 64 ,
						icon_mipmaps = 4
					} ,
					{
						icon = SIGen.MakeSelfPicturePath( "木桶-顶部" .. SICommon.ShowNameSuffix.ICON ) ,
						icon_size = 64 ,
						icon_mipmaps = 4 ,
						tint = fluidColor
					}
				} ,
				icon_size = 64 ,
				icon_mipmaps = 4 ,
				category = "crafting-with-fluid" ,
				crafting_machine_tint =
				{
					primary = fluidColor ,
					secondary = fluidColor ,
					tertiary = fluidColor ,
					quaternary = fluidColor
				} ,
				enabled = false ,
				hidden = false ,
				hide_from_stats = false ,
				hide_from_player_crafting = true ,
				energy_required = 1.0 ,
				ingredients =
				{
					{
						type = SICommon.Types.Items.Item ,
						name = SIConstants_AdvancedBarrel.raw.Items[BarrelItemIDPrefix_1 .. fluidID] ,
						amount = 1
					}
				} ,
				results =
				{
					{
						type = SICommon.Types.Items.Item ,
						name = SIConstants_AdvancedBarrel.raw.Items.WoodenBarrel ,
						amount = 1 ,
						catalyst_amount = 1
					} ,
					{
						type = SICommon.Types.Fluid ,
						name = fluidName ,
						amount = barrelSize ,
						catalyst_amount = barrelSize
					}
				} ,
				main_product = fluidName ,
				emissions_multiplier = 0.1 ,
				requester_paste_multiplier = 10 ,
				overload_multiplier = 5 ,
				allow_inserter_overload = true ,
				allow_decomposition = true ,
				allow_intermediates = true ,
				allow_as_intermediate = true ,
				always_show_products = true ,
				always_show_made_in = true ,
				show_amount_in_title = false ,
				unlock_results = true
			}
			.AddFunction( function( prototypeName , prototypeData )
				for index , icon in pairs( fluidIcons ) do
					local iconData = SIUtils.table.deepcopy( icon )
					iconData.scale = 12 / iconData.icon_size
					iconData.shift = BarrelEmptyIconFluidShift
					table.insert( prototypeData.icons , iconData )
				end
			end )
			.New( SICommon.Types.Entities.SimpleOwner , BarrelItemIDPrefix_1 .. fluidID , BarrelItemAliasPrefix_1 .. fluidName )
			.SetSize( 1 , 1 )
			.ReferencePlaceResult( SICommon.Types.Items.Item , SIConstants_AdvancedBarrel.raw.Items[BarrelItemIDPrefix_1 .. fluidID] )
			.Append
			{
				localised_name = SIGen.MakeSelfLocalisedName( BarrelItemLocalisedPrefix_1 , localName ) ,
				localised_description = SIGen.MakeSelfLocalisedDescription( BarrelItemLocalisedPrefix_1 , localDescription ) ,
				icons =
				{
					{
						icon = SIGen.MakeSelfPicturePath( "木桶-身体" .. SICommon.ShowNameSuffix.ICON ) ,
						icon_size = 64 ,
						icon_mipmaps = 4
					} ,
					{
						icon = SIGen.MakeSelfPicturePath( "木桶-顶部" .. SICommon.ShowNameSuffix.ICON ) ,
						icon_size = 64 ,
						icon_mipmaps = 4 ,
						tint = fluidColor
					}
				} ,
				icon_size = 64 ,
				icon_mipmaps = 4 ,
				flags = { SICommon.Flags.Entity.PlaceablePlayer , SICommon.Flags.Entity.PlayerCreation , SICommon.Flags.Entity.HideAltInfo } ,
				minable =
				{
					mining_time = 0.3 ,
					results =
					{
						{
							type = SICommon.Types.Items.Item ,
							name = SIConstants_AdvancedBarrel.raw.Items[BarrelItemIDPrefix_1 .. fluidID] ,
							amount = 1
						}
					}
				} ,
				max_health = 35 ,
				corpse = "small-remnants" ,
				dying_explosion = nil ,
				map_color = fluidColor ,
				friendly_map_color = fluidColor ,
				enemy_map_color = fluidColor ,
				is_military_target = false ,
				allow_run_time_change_of_is_military_target = true ,
				alert_when_damaged = true ,
				create_ghost_on_death = true ,
				hide_resistances = true ,
				resistances = nil ,
				render_layer = SICommon.Flags.RenderLayer.Object ,
				alert_icon_shift = { 0 , 0 } ,
				pictures = SIGraphics.MakeHrVersionData
				{
					{
						layers =
						{
							{
								filename = SIGen.MakeSelfPicturePath( "木桶-身体" ) ,
								priority = "extra-high" ,
								width = 32 ,
								height = 47 ,
								scale = 1.0 ,
								shift = BarrelEntityShift ,
							} ,
							{
								filename = SIGen.MakeSelfPicturePath( "木桶-顶部" ) ,
								priority = "extra-high" ,
								width = 32 ,
								height = 47 ,
								scale = 1.0 ,
								shift = BarrelEntityShift ,
								tint = fluidColor
							} ,
							{
								filename = SIGen.MakeSelfPicturePath( "木桶-影子" ) ,
								priority = "extra-high" ,
								width = 65 ,
								height = 32 ,
								scale = 1.0 ,
								shift = Barrel_1_EntityShadowShift ,
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
			-- ======================================================================
			-- 灌装科技 2
			-- ======================================================================
			.New( SICommon.Types.Items.Item , BarrelItemIDPrefix_2 .. fluidID , BarrelItemAliasPrefix_2 .. fluidName )
			.Append
			{
				localised_name = SIGen.MakeSelfLocalisedName( BarrelItemLocalisedPrefix_2 , localName ) ,
				localised_description = SIGen.MakeSelfLocalisedDescription( BarrelItemLocalisedPrefix_2 , localDescription ) ,
				icons =
				{
					{
						icon = SIGen.MakeSelfPicturePath( "塑料胶囊-身体" .. SICommon.ShowNameSuffix.ICON ) ,
						icon_size = 64 ,
						icon_mipmaps = 4
					} ,
					{
						icon = SIGen.MakeSelfPicturePath( "塑料胶囊-顶部" .. SICommon.ShowNameSuffix.ICON ) ,
						icon_size = 64 ,
						icon_mipmaps = 4 ,
						tint = fluidColor
					}
				} ,
				icon_size = 64 ,
				icon_mipmaps = 4 ,
				stack_size = barrelStackSize ,
				default_request_amount = barrelStackSize ,
				place_result = nil
			}
			.New( SICommon.Types.Recipe , BarrelFullIDPrefix_2 .. fluidID , BarrelFullAliasPrefix_2 .. fluidID )
			.ReferenceUnlockRecipe( SIConstants_AdvancedBarrel.raw.Technologies.Barrel_2 )
			.Append
			{
				localised_name = SIGen.MakeSelfLocalisedName( BarrelFullLocalisedPrefix_2 , localName ) ,
				localised_description = SIGen.MakeSelfLocalisedDescription( BarrelFullLocalisedPrefix_2 ) ,
				icons =
				{
					{
						icon = SIGen.MakeSelfPicturePath( "塑料胶囊-身体" .. SICommon.ShowNameSuffix.ICON ) ,
						icon_size = 64 ,
						icon_mipmaps = 4
					} ,
					{
						icon = SIGen.MakeSelfPicturePath( "塑料胶囊-顶部" .. SICommon.ShowNameSuffix.ICON ) ,
						icon_size = 64 ,
						icon_mipmaps = 4 ,
						tint = fluidColor
					}
				} ,
				icon_size = 64 ,
				icon_mipmaps = 4 ,
				category = SIConstants_AdvancedBarrel.raw.Categories.Recipe.MakeBarrel ,
				crafting_machine_tint =
				{
					primary = fluidColor ,
					secondary = fluidColor ,
					tertiary = fluidColor ,
					quaternary = fluidColor
				} ,
				enabled = false ,
				hidden = false ,
				hide_from_stats = false ,
				hide_from_player_crafting = true ,
				energy_required = 0.2 ,
				ingredients =
				{
					{
						type = SICommon.Types.Items.Item ,
						name = SIConstants_AdvancedBarrel.raw.Items.PlasticCapable ,
						amount = 1
					} ,
					{
						type = SICommon.Types.Fluid ,
						name = fluidName ,
						amount = barrelSize
					}
				} ,
				results =
				{
					{
						type = SICommon.Types.Items.Item ,
						name = SIConstants_AdvancedBarrel.raw.Items[BarrelItemIDPrefix_2 .. fluidID] ,
						amount = 1 ,
						catalyst_amount = 1
					}
				} ,
				main_product = SIConstants_AdvancedBarrel.raw.Items[BarrelItemIDPrefix_2 .. fluidID] ,
				emissions_multiplier = 0.1 ,
				requester_paste_multiplier = 10 ,
				overload_multiplier = 5 ,
				allow_inserter_overload = true ,
				allow_decomposition = true ,
				allow_intermediates = true ,
				allow_as_intermediate = true ,
				always_show_products = true ,
				always_show_made_in = true ,
				show_amount_in_title = false ,
				unlock_results = true
			}
			.AddFunction( function( prototypeName , prototypeData )
				for index , icon in pairs( fluidIcons ) do
					local iconData = SIUtils.table.deepcopy( icon )
					iconData.scale = 12 / iconData.icon_size
					iconData.shift = BarrelFullIconFluidShift
					table.insert( prototypeData.icons , iconData )
				end
			end )
			.New( SICommon.Types.Recipe , BarrelEmptyIDPrefix_2 .. fluidID , BarrelEmptyAliasPrefix_2 .. fluidID )
			.ReferenceUnlockRecipe( SIConstants_AdvancedBarrel.raw.Technologies.Barrel_2 )
			.Append
			{
				localised_name = SIGen.MakeSelfLocalisedName( BarrelEmptyLocalisedPrefix_2 , localName ) ,
				localised_description = SIGen.MakeSelfLocalisedDescription( BarrelEmptyLocalisedPrefix_2 ) ,
				icons =
				{
					{
						icon = SIGen.MakeSelfPicturePath( "塑料胶囊-身体" .. SICommon.ShowNameSuffix.ICON ) ,
						icon_size = 64 ,
						icon_mipmaps = 4
					} ,
					{
						icon = SIGen.MakeSelfPicturePath( "塑料胶囊-顶部" .. SICommon.ShowNameSuffix.ICON ) ,
						icon_size = 64 ,
						icon_mipmaps = 4 ,
						tint = fluidColor
					}
				} ,
				icon_size = 64 ,
				icon_mipmaps = 4 ,
				category = SIConstants_AdvancedBarrel.raw.Categories.Recipe.DropBarrel ,
				crafting_machine_tint =
				{
					primary = fluidColor ,
					secondary = fluidColor ,
					tertiary = fluidColor ,
					quaternary = fluidColor
				} ,
				enabled = false ,
				hidden = false ,
				hide_from_stats = false ,
				hide_from_player_crafting = true ,
				energy_required = 0.2 ,
				ingredients =
				{
					{
						type = SICommon.Types.Items.Item ,
						name = SIConstants_AdvancedBarrel.raw.Items[BarrelItemIDPrefix_2 .. fluidID] ,
						amount = 1
					}
				} ,
				results =
				{
					{
						type = SICommon.Types.Fluid ,
						name = fluidName ,
						amount = barrelSize ,
						catalyst_amount = barrelSize
					}
				} ,
				main_product = fluidName ,
				emissions_multiplier = 0.1 ,
				requester_paste_multiplier = 10 ,
				overload_multiplier = 5 ,
				allow_inserter_overload = true ,
				allow_decomposition = true ,
				allow_intermediates = true ,
				allow_as_intermediate = true ,
				always_show_products = true ,
				always_show_made_in = true ,
				show_amount_in_title = false ,
				unlock_results = true
			}
			.AddFunction( function( prototypeName , prototypeData )
				for index , icon in pairs( fluidIcons ) do
					local iconData = SIUtils.table.deepcopy( icon )
					iconData.scale = 12 / iconData.icon_size
					iconData.shift = BarrelEmptyIconFluidShift
					table.insert( prototypeData.icons , iconData )
				end
			end )
			.New( SICommon.Types.Recipe , BarrelFullAssembledIDPrefix_2 .. fluidID , BarrelFullAssembledAliasPrefix_2 .. fluidID )
			.ReferenceUnlockRecipe( SIConstants_AdvancedBarrel.raw.Technologies.Barrel_2 )
			.Append
			{
				localised_name = SIGen.MakeSelfLocalisedName( BarrelFullLocalisedPrefix_2 , localName ) ,
				localised_description = SIGen.MakeSelfLocalisedDescription( BarrelFullLocalisedPrefix_2 ) ,
				icons =
				{
					{
						icon = SIGen.MakeSelfPicturePath( "塑料胶囊-身体" .. SICommon.ShowNameSuffix.ICON ) ,
						icon_size = 64 ,
						icon_mipmaps = 4
					} ,
					{
						icon = SIGen.MakeSelfPicturePath( "塑料胶囊-顶部" .. SICommon.ShowNameSuffix.ICON ) ,
						icon_size = 64 ,
						icon_mipmaps = 4 ,
						tint = fluidColor
					}
				} ,
				icon_size = 64 ,
				icon_mipmaps = 4 ,
				category = "crafting-with-fluid" ,
				crafting_machine_tint =
				{
					primary = fluidColor ,
					secondary = fluidColor ,
					tertiary = fluidColor ,
					quaternary = fluidColor
				} ,
				enabled = false ,
				hidden = false ,
				hide_from_stats = false ,
				hide_from_player_crafting = true ,
				energy_required = 1.0 ,
				ingredients =
				{
					{
						type = SICommon.Types.Items.Item ,
						name = SIConstants_AdvancedBarrel.raw.Items.PlasticCapable ,
						amount = 1
					} ,
					{
						type = SICommon.Types.Fluid ,
						name = fluidName ,
						amount = barrelSize
					}
				} ,
				results =
				{
					{
						type = SICommon.Types.Items.Item ,
						name = SIConstants_AdvancedBarrel.raw.Items[BarrelItemIDPrefix_2 .. fluidID] ,
						amount = 1 ,
						catalyst_amount = 1
					}
				} ,
				main_product = SIConstants_AdvancedBarrel.raw.Items[BarrelItemIDPrefix_2 .. fluidID] ,
				emissions_multiplier = 0.1 ,
				requester_paste_multiplier = 10 ,
				overload_multiplier = 5 ,
				allow_inserter_overload = true ,
				allow_decomposition = true ,
				allow_intermediates = true ,
				allow_as_intermediate = true ,
				always_show_products = true ,
				always_show_made_in = true ,
				show_amount_in_title = false ,
				unlock_results = true
			}
			.AddFunction( function( prototypeName , prototypeData )
				for index , icon in pairs( fluidIcons ) do
					local iconData = SIUtils.table.deepcopy( icon )
					iconData.scale = 12 / iconData.icon_size
					iconData.shift = BarrelFullIconFluidShift
					table.insert( prototypeData.icons , iconData )
				end
			end )
			.New( SICommon.Types.Recipe , BarrelEmptyAssembledIDPrefix_2 .. fluidID , BarrelEmptyAssembledAliasPrefix_2 .. fluidID )
			.ReferenceUnlockRecipe( SIConstants_AdvancedBarrel.raw.Technologies.Barrel_2 )
			.Append
			{
				localised_name = SIGen.MakeSelfLocalisedName( BarrelEmptyLocalisedPrefix_2 , localName ) ,
				localised_description = SIGen.MakeSelfLocalisedDescription( BarrelEmptyLocalisedPrefix_2 ) ,
				icons =
				{
					{
						icon = SIGen.MakeSelfPicturePath( "塑料胶囊-身体" .. SICommon.ShowNameSuffix.ICON ) ,
						icon_size = 64 ,
						icon_mipmaps = 4
					} ,
					{
						icon = SIGen.MakeSelfPicturePath( "塑料胶囊-顶部" .. SICommon.ShowNameSuffix.ICON ) ,
						icon_size = 64 ,
						icon_mipmaps = 4 ,
						tint = fluidColor
					}
				} ,
				icon_size = 64 ,
				icon_mipmaps = 4 ,
				category = "crafting-with-fluid" ,
				crafting_machine_tint =
				{
					primary = fluidColor ,
					secondary = fluidColor ,
					tertiary = fluidColor ,
					quaternary = fluidColor
				} ,
				enabled = false ,
				hidden = false ,
				hide_from_stats = false ,
				hide_from_player_crafting = true ,
				energy_required = 1.0 ,
				ingredients =
				{
					{
						type = SICommon.Types.Items.Item ,
						name = SIConstants_AdvancedBarrel.raw.Items[BarrelItemIDPrefix_2 .. fluidID] ,
						amount = 1
					}
				} ,
				results =
				{
					{
						type = SICommon.Types.Fluid ,
						name = fluidName ,
						amount = barrelSize ,
						catalyst_amount = barrelSize
					}
				} ,
				main_product = fluidName ,
				emissions_multiplier = 0.1 ,
				requester_paste_multiplier = 10 ,
				overload_multiplier = 5 ,
				allow_inserter_overload = true ,
				allow_decomposition = true ,
				allow_intermediates = true ,
				allow_as_intermediate = true ,
				always_show_products = true ,
				always_show_made_in = true ,
				show_amount_in_title = false ,
				unlock_results = true
			}
			.AddFunction( function( prototypeName , prototypeData )
				for index , icon in pairs( fluidIcons ) do
					local iconData = SIUtils.table.deepcopy( icon )
					iconData.scale = 12 / iconData.icon_size
					iconData.shift = BarrelEmptyIconFluidShift
					table.insert( prototypeData.icons , iconData )
				end
			end )
			.New( SICommon.Types.Entities.SimpleOwner , BarrelItemIDPrefix_2 .. fluidID , BarrelItemAliasPrefix_2 .. fluidName )
			.SetSizeSize( 1 , 1 , 0.5 )
			.ReferencePlaceResult( SICommon.Types.Items.Item , SIConstants_AdvancedBarrel.raw.Items[BarrelItemIDPrefix_2 .. fluidID] )
			.Append
			{
				localised_name = SIGen.MakeSelfLocalisedName( BarrelItemLocalisedPrefix_2 , localName ) ,
				localised_description = SIGen.MakeSelfLocalisedDescription( BarrelItemLocalisedPrefix_2 , localDescription ) ,
				icons =
				{
					{
						icon = SIGen.MakeSelfPicturePath( "塑料胶囊-身体" .. SICommon.ShowNameSuffix.ICON ) ,
						icon_size = 64 ,
						icon_mipmaps = 4
					} ,
					{
						icon = SIGen.MakeSelfPicturePath( "塑料胶囊-顶部" .. SICommon.ShowNameSuffix.ICON ) ,
						icon_size = 64 ,
						icon_mipmaps = 4 ,
						tint = fluidColor
					}
				} ,
				icon_size = 64 ,
				icon_mipmaps = 4 ,
				flags = { SICommon.Flags.Entity.PlaceablePlayer , SICommon.Flags.Entity.PlayerCreation , SICommon.Flags.Entity.HideAltInfo } ,
				minable =
				{
					mining_time = 0.3 ,
					results =
					{
						{
							type = SICommon.Types.Items.Item ,
							name = SIConstants_AdvancedBarrel.raw.Items[BarrelItemIDPrefix_2 .. fluidID] ,
							amount = 1
						}
					}
				} ,
				max_health = 35 ,
				corpse = "small-remnants" ,
				dying_explosion = nil ,
				map_color = fluidColor ,
				friendly_map_color = fluidColor ,
				enemy_map_color = fluidColor ,
				is_military_target = false ,
				allow_run_time_change_of_is_military_target = true ,
				alert_when_damaged = true ,
				create_ghost_on_death = true ,
				hide_resistances = true ,
				resistances = nil ,
				render_layer = SICommon.Flags.RenderLayer.Object ,
				alert_icon_shift = { 0 , 0 } ,
				pictures = SIGraphics.MakeHrVersionData
				{
					{
						layers =
						{
							{
								filename = SIGen.MakeSelfPicturePath( "塑料胶囊-身体-1" ) ,
								priority = "extra-high" ,
								width = 32 ,
								height = 32 ,
								scale = 1.0
							} ,
							{
								filename = SIGen.MakeSelfPicturePath( "塑料胶囊-顶部-1" ) ,
								priority = "extra-high" ,
								width = 32 ,
								height = 32 ,
								scale = 1.0 ,
								tint = fluidColor
							} ,
							{
								filename = SIGen.MakeSelfPicturePath( "塑料胶囊-影子-1" ) ,
								priority = "extra-high" ,
								width = 48 ,
								height = 32 ,
								scale = 1.0 ,
								shift = Barrel_2_EntityShadowShift_1 ,
								draw_as_shadow = true
							}
						}
					} ,
					{
						layers =
						{
							{
								filename = SIGen.MakeSelfPicturePath( "塑料胶囊-身体-2" ) ,
								priority = "extra-high" ,
								width = 32 ,
								height = 32 ,
								scale = 1.0
							} ,
							{
								filename = SIGen.MakeSelfPicturePath( "塑料胶囊-顶部-2" ) ,
								priority = "extra-high" ,
								width = 32 ,
								height = 32 ,
								scale = 1.0 ,
								tint = fluidColor
							} ,
							{
								filename = SIGen.MakeSelfPicturePath( "塑料胶囊-影子-2" ) ,
								priority = "extra-high" ,
								width = 40 ,
								height = 32 ,
								scale = 1.0 ,
								shift = Barrel_2_EntityShadowShift_2 ,
								draw_as_shadow = true
							}
						}
					} ,
					{
						layers =
						{
							{
								filename = SIGen.MakeSelfPicturePath( "塑料胶囊-身体-3" ) ,
								priority = "extra-high" ,
								width = 32 ,
								height = 32 ,
								scale = 1.0
							} ,
							{
								filename = SIGen.MakeSelfPicturePath( "塑料胶囊-顶部-3" ) ,
								priority = "extra-high" ,
								width = 32 ,
								height = 32 ,
								scale = 1.0 ,
								tint = fluidColor
							} ,
							{
								filename = SIGen.MakeSelfPicturePath( "塑料胶囊-影子-3" ) ,
								priority = "extra-high" ,
								width = 40 ,
								height = 32 ,
								scale = 1.0 ,
								shift = Barrel_2_EntityShadowShift_3 ,
								draw_as_shadow = true
							}
						}
					} ,
					{
						layers =
						{
							{
								filename = SIGen.MakeSelfPicturePath( "塑料胶囊-身体-4" ) ,
								priority = "extra-high" ,
								width = 32 ,
								height = 32 ,
								scale = 1.0
							} ,
							{
								filename = SIGen.MakeSelfPicturePath( "塑料胶囊-顶部-4" ) ,
								priority = "extra-high" ,
								width = 32 ,
								height = 32 ,
								scale = 1.0 ,
								tint = fluidColor
							} ,
							{
								filename = SIGen.MakeSelfPicturePath( "塑料胶囊-影子-4" ) ,
								priority = "extra-high" ,
								width = 35 ,
								height = 32 ,
								scale = 1.0 ,
								shift = Barrel_2_EntityShadowShift_4 ,
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
			-- ======================================================================
			-- 灌装科技 3
			-- ======================================================================
			.New( SICommon.Types.Items.Item , BarrelItemIDPrefix_3 .. fluidID , BarrelItemAliasPrefix_3 .. fluidName )
			.Append
			{
				localised_name = SIGen.MakeSelfLocalisedName( BarrelItemLocalisedPrefix_3 , localName ) ,
				localised_description = SIGen.MakeSelfLocalisedDescription( BarrelItemLocalisedPrefix_3 , localDescription ) ,
				icons =
				{
					{
						icon = SIGen.MakeSelfPicturePath( "固化液体" .. SICommon.ShowNameSuffix.ICON ) ,
						icon_size = 64 ,
						icon_mipmaps = 4 ,
						tint = fluidColor
					}
				} ,
				icon_size = 64 ,
				icon_mipmaps = 4 ,
				stack_size = barrelStackSize ,
				default_request_amount = barrelStackSize ,
				place_result = nil
			}
			.AddFunction( function( prototypeName , prototypeData )
				for index , icon in pairs( fluidIcons ) do
					local iconData = SIUtils.table.deepcopy( icon )
					iconData.scale = 12 / iconData.icon_size
					table.insert( prototypeData.icons , iconData )
				end
			end )
			.New( SICommon.Types.Recipe , BarrelFullIDPrefix_3 .. fluidID , BarrelFullAliasPrefix_3 .. fluidID )
			.ReferenceUnlockRecipe( SIConstants_AdvancedBarrel.raw.Technologies.Barrel_3 )
			.Append
			{
				localised_name = SIGen.MakeSelfLocalisedName( BarrelFullLocalisedPrefix_3 , localName ) ,
				localised_description = SIGen.MakeSelfLocalisedDescription( BarrelFullLocalisedPrefix_3 ) ,
				icons =
				{
					{
						icon = SIGen.MakeSelfPicturePath( "固化液体" .. SICommon.ShowNameSuffix.ICON ) ,
						icon_size = 64 ,
						icon_mipmaps = 4 ,
						tint = fluidColor
					}
				} ,
				icon_size = 64 ,
				icon_mipmaps = 4 ,
				category = SIConstants_AdvancedBarrel.raw.Categories.Recipe.MakeBarrel ,
				crafting_machine_tint =
				{
					primary = fluidColor ,
					secondary = fluidColor ,
					tertiary = fluidColor ,
					quaternary = fluidColor
				} ,
				enabled = false ,
				hidden = false ,
				hide_from_stats = false ,
				hide_from_player_crafting = true ,
				energy_required = 0.2 ,
				ingredients =
				{
					{
						type = SICommon.Types.Fluid ,
						name = fluidName ,
						amount = barrelSize
					}
				} ,
				results =
				{
					{
						type = SICommon.Types.Items.Item ,
						name = SIConstants_AdvancedBarrel.raw.Items[BarrelItemIDPrefix_3 .. fluidID] ,
						amount = 1 ,
						catalyst_amount = 1
					}
				} ,
				main_product = SIConstants_AdvancedBarrel.raw.Items[BarrelItemIDPrefix_3 .. fluidID] ,
				emissions_multiplier = 0.1 ,
				requester_paste_multiplier = 10 ,
				overload_multiplier = 5 ,
				allow_inserter_overload = true ,
				allow_decomposition = true ,
				allow_intermediates = true ,
				allow_as_intermediate = true ,
				always_show_products = true ,
				always_show_made_in = true ,
				show_amount_in_title = false ,
				unlock_results = true
			}
			.AddFunction( function( prototypeName , prototypeData )
				for index , icon in pairs( fluidIcons ) do
					local iconData = SIUtils.table.deepcopy( icon )
					iconData.scale = 12 / iconData.icon_size
					iconData.shift = BarrelFullIconFluidShift
					table.insert( prototypeData.icons , iconData )
				end
			end )
			.New( SICommon.Types.Recipe , BarrelEmptyIDPrefix_3 .. fluidID , BarrelEmptyAliasPrefix_3 .. fluidID )
			.ReferenceUnlockRecipe( SIConstants_AdvancedBarrel.raw.Technologies.Barrel_3 )
			.Append
			{
				localised_name = SIGen.MakeSelfLocalisedName( BarrelEmptyLocalisedPrefix_3 , localName ) ,
				localised_description = SIGen.MakeSelfLocalisedDescription( BarrelEmptyLocalisedPrefix_3 ) ,
				icons =
				{
					{
						icon = SIGen.MakeSelfPicturePath( "固化液体" .. SICommon.ShowNameSuffix.ICON ) ,
						icon_size = 64 ,
						icon_mipmaps = 4 ,
						tint = fluidColor
					}
				} ,
				icon_size = 64 ,
				icon_mipmaps = 4 ,
				category = SIConstants_AdvancedBarrel.raw.Categories.Recipe.DropBarrel ,
				crafting_machine_tint =
				{
					primary = fluidColor ,
					secondary = fluidColor ,
					tertiary = fluidColor ,
					quaternary = fluidColor
				} ,
				enabled = false ,
				hidden = false ,
				hide_from_stats = false ,
				hide_from_player_crafting = true ,
				energy_required = 0.2 ,
				ingredients =
				{
					{
						type = SICommon.Types.Items.Item ,
						name = SIConstants_AdvancedBarrel.raw.Items[BarrelItemIDPrefix_3 .. fluidID] ,
						amount = 1
					}
				} ,
				results =
				{
					{
						type = SICommon.Types.Fluid ,
						name = fluidName ,
						amount = barrelSize ,
						catalyst_amount = barrelSize
					}
				} ,
				main_product = fluidName ,
				emissions_multiplier = 0.1 ,
				requester_paste_multiplier = 10 ,
				overload_multiplier = 5 ,
				allow_inserter_overload = true ,
				allow_decomposition = true ,
				allow_intermediates = true ,
				allow_as_intermediate = true ,
				always_show_products = true ,
				always_show_made_in = true ,
				show_amount_in_title = false ,
				unlock_results = true
			}
			.AddFunction( function( prototypeName , prototypeData )
				for index , icon in pairs( fluidIcons ) do
					local iconData = SIUtils.table.deepcopy( icon )
					iconData.scale = 12 / iconData.icon_size
					iconData.shift = BarrelEmptyIconFluidShift
					table.insert( prototypeData.icons , iconData )
				end
			end )
			.New( SICommon.Types.Recipe , BarrelEmptyAssembledIDPrefix_3 .. fluidID , BarrelEmptyAssembledAliasPrefix_3 .. fluidID )
			.ReferenceUnlockRecipe( SIConstants_AdvancedBarrel.raw.Technologies.Barrel_3 )
			.Append
			{
				localised_name = SIGen.MakeSelfLocalisedName( BarrelEmptyLocalisedPrefix_3 , localName ) ,
				localised_description = SIGen.MakeSelfLocalisedDescription( BarrelEmptyLocalisedPrefix_3 ) ,
				icons =
				{
					{
						icon = SIGen.MakeSelfPicturePath( "固化液体" .. SICommon.ShowNameSuffix.ICON ) ,
						icon_size = 64 ,
						icon_mipmaps = 4 ,
						tint = fluidColor
					}
				} ,
				icon_size = 64 ,
				icon_mipmaps = 4 ,
				category = "crafting-with-fluid" ,
				crafting_machine_tint =
				{
					primary = fluidColor ,
					secondary = fluidColor ,
					tertiary = fluidColor ,
					quaternary = fluidColor
				} ,
				enabled = false ,
				hidden = false ,
				hide_from_stats = false ,
				hide_from_player_crafting = true ,
				energy_required = 1.0 ,
				ingredients =
				{
					{
						type = SICommon.Types.Items.Item ,
						name = SIConstants_AdvancedBarrel.raw.Items[BarrelItemIDPrefix_3 .. fluidID] ,
						amount = 1
					}
				} ,
				results =
				{
					{
						type = SICommon.Types.Fluid ,
						name = fluidName ,
						amount = barrelSize ,
						catalyst_amount = barrelSize
					}
				} ,
				main_product = fluidName ,
				emissions_multiplier = 0.1 ,
				requester_paste_multiplier = 10 ,
				overload_multiplier = 5 ,
				allow_inserter_overload = true ,
				allow_decomposition = true ,
				allow_intermediates = true ,
				allow_as_intermediate = true ,
				always_show_products = true ,
				always_show_made_in = true ,
				show_amount_in_title = false ,
				unlock_results = true
			}
			.AddFunction( function( prototypeName , prototypeData )
				for index , icon in pairs( fluidIcons ) do
					local iconData = SIUtils.table.deepcopy( icon )
					iconData.scale = 12 / iconData.icon_size
					iconData.shift = BarrelEmptyIconFluidShift
					table.insert( prototypeData.icons , iconData )
				end
			end )
		end
	end
end )
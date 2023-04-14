-- ------------------------------------------------------------------------------------------------
-- ------------ 泥土 ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local dirtList =
{
	DirtSoft   = "棉流土" ,
	DirtHigh   = "高山土" ,
	DirtWind   = "浊风土" ,
	DirtWest   = "西锥土" ,
	DirtFlat   = "平结土" ,
	DirtShadow = "影寂土"
}

SIGen.SetGroup( SIConstants_Resource.raw.Groups.Resource.Dirt )
for dirtID , dirtAlias in pairs( dirtList ) do
	SIGen
	.New( SICommon.Types.Items.Module , dirtID , dirtAlias ,
	{
		stack_size = 10000 ,
		default_request_amount = 100 ,
		place_result = nil ,
		tier = 1 ,
		effect =
		{
			speed = { bonus = -1 } ,
			productivity = { bonus = -1 } ,
			consumption = { bonus = 3.75 } ,
			pollution = { bonus = 0.75 }
		} ,
		beacon_tint =
		{
			primary = { r = 0.12 , g = 0.12 , b = 0.12 , a = 1.00 } ,
			secondary = { r = 0.12 , g = 0.12 , b = 0.12 , a = 1.00 }
		} ,
		art_style = "vanilla" ,
		requires_beacon_alt_mode = false
	} )
	.AutoIcon()
end

for dirtID , dirtAlias in pairs( dirtList ) do
	local iconSettings = SICommon.Numbers.IconSettings[SICommon.Types.Recipe] or SICommon.Numbers.IconSettings.Default
	local baseResult =
	{
		ID = dirtID ,
		Alias = dirtAlias ,
		Icons =
		{
			{
				icon = SIGen.MakePicturePath( SICommon.Types.Items.Item , dirtAlias .. SICommon.ShowNameSuffix.ICON ) ,
				icon_size = iconSettings.size ,
				icon_mipmaps = iconSettings.mipmaps
			}
		} ,
		Results =
		{
			{
				type = SICommon.Types.Items.Item ,
				name = SIConstants_Resource.raw.Items[dirtID] ,
				amount = 1 ,
				catalyst_amount = 1
			} ,
			{
				type = SICommon.Types.Items.Item ,
				name = SIConstants_Resource.raw.Items[dirtID] ,
				probability = 0.4 ,
				amount_min = 0 ,
				amount_max = 15 ,
				catalyst_amount = 15
			}
		}
	}
	local innerBaseResult = SIUtils.table.deepcopy( baseResult )
	table.insert( innerBaseResult.Results ,
	{
		type = SICommon.Types.Items.Item ,
		name = SIConstants_Resource.raw.Items[dirtID] ,
		probability = 0.1 ,
		amount_min = 0 ,
		amount_max = 40 ,
		catalyst_amount = 40
	} )
	local resultList = { innerBaseResult }
	for subDirtID , subDirtAlias in pairs( dirtList ) do
		if subDirtID ~= dirtID then
			for size = 1 , 2 , 1 do
				local result = SIUtils.table.deepcopy( baseResult )
				result.ID = result.ID .. "_" .. subDirtID .. "_" .. size
				result.Alias = result.Alias .. "-" .. subDirtAlias .. "-" .. size
				table.insert( result.Icons ,
				{
					icon = SIGen.MakePicturePath( SICommon.Types.Items.Item , subDirtAlias .. SICommon.ShowNameSuffix.ICON ) ,
					icon_size = iconSettings.size ,
					icon_mipmaps = iconSettings.mipmaps ,
					scale = 12 / iconSettings.size ,
					shift = { 8 , 8 }
				} )
				table.insert( result.Results ,
				{
					type = SICommon.Types.Items.Item ,
					name = SIConstants_Resource.raw.Items[subDirtID] ,
					probability = 0.2 * size ,
					amount_min = 0 ,
					amount_max = 6 ,
					catalyst_amount = 6
				} )
				table.insert( result.Results ,
				{
					type = SICommon.Types.Items.Item ,
					name = SIConstants_Resource.raw.Items[subDirtID] ,
					probability = 0.0005 * size ,
					amount_min = 0 ,
					amount_max = 400 ,
					catalyst_amount = 400
				} )
			end
		end
	end
	for index , result in pairs( resultList ) do
		SIGen
		.New( SICommon.Types.Recipe , result.ID , result.Alias )
		.Append
		{
			icons = result.Icons ,
			icon_size = iconSettings.size ,
			icon_mipmaps = iconSettings.mipmaps ,
			localised_name = SIGen.MakeSelfLocalisedName( result.Alias ) ,
			localised_description = SIGen.MakeSelfLocalisedDescription( result.Alias ) ,
			category = SIConstants_Resource.raw.Categories.Recipe.Dirt ,
			crafting_machine_tint =
			{
				primary = { r = 0.12 , g = 0.12 , b = 0.12 } ,
				secondary = { r = 0.12 , g = 0.12 , b = 0.12 } ,
				tertiary = { r = 0.12 , g = 0.12 , b = 0.12 } ,
				quaternary = { r = 0.12 , g = 0.12 , b = 0.12 }
			} ,
			enabled = true ,
			hidden = false ,
			hide_from_stats = false ,
			hide_from_player_crafting = true ,
			energy_required = 1.0 ,
			ingredients = {} ,
			results = result.Results ,
			main_product = SIConstants_Resource.raw.Items[dirtID] ,
			emissions_multiplier = 2.6 ,
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
	end
end
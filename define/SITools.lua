SITools =
{
	Hex16 = { "0" , "1" , "2" , "3" , "4" , "5" , "6" , "7" , "8" , "9" , "A" , "B" , "C" , "D" , "E" , "F" } ,

	CopyData = function( curData , customData , needOverwrite )
		if not curData then
			curData = {}
		end
		if not customData or SITools.IsNotTable( customData ) then
			return curData
		end
		for key , value in pairs( customData ) do
			if curData[key] then
				if needOverwrite then
					curData[key] = value
				end
			else curData[key] = value end
		end
		return curData
	end ,

	NumberLength = function( number )
		number = math.abs( number )
		local length = 0
		while number > 0 do
			length = length + 1
			number = math.floor( number/10 )
		end
		return length
	end ,
	NumberToString = function( number , length )
		local str = "" .. number
		while str:len() < length do
			str = "0" .. str
		end
		return str
	end ,
	Round = function( number , min , max )
		return math.max( math.min( number , max ) , min )
	end ,
	AsNumber = function( number , min , max )
		local cur = tonumber( number ) or 0
		return math.max( math.min( cur , max ) , min )
	end ,
	AsNumberInt = function( number , min , max )
		local cur = tonumber( number ) or 0
		return math.floor( math.max( math.min( cur , max ) , min ) )
	end ,
	NumberTo16 = function( number , length )
		local out = ""
		while number > 0 do
			local size = math.fmod( number , 16 ) + 1
			out = SITools.Hex16[size] .. out
			number = math.floor( number / 16 )
		end
		while out:len() < length do
			out = "0" .. out
		end
		return out
	end ,
	FormatNumber2 = function( number )
		return ( "%.2f" ):format( number )
	end ,
	FormatNumber4 = function( number )
		return ( "%.4f" ):format( number )
	end ,

	IsTable = function( data )
		return type( data ) == "table"
	end ,
	IsNotTable = function( data )
		return type( data ) ~= "table"
	end ,
	IsString = function( data )
		return type( data ) == "string"
	end ,
	IsNotString = function( data )
		return type( data ) ~= "string"
	end ,
	IsNumber = function( data )
		return type( data ) == "number"
	end ,
	IsNotNumber = function( data )
		return type( data ) ~= "number"
	end ,
	IsFunction = function( data )
		return type( data ) == "function"
	end ,
	IsNotFunction = function( data )
		return type( data ) ~= "function"
	end ,

	Icon = function( iconPath , tint , scale , shift , mipmaps , size )
		local icon = {}
		if iconPath then
			if not iconPath:EndsWith( ".png" ) then
				iconPath = iconPath .. ".png"
			end
			icon.icon = iconPath
		end
		if tint then
			icon.tint = tint
		end
		if scale then
			icon.scale = scale
		end
		if shift then
			icon.shift = shift
		end
		if mipmaps then
			icon.icon_mipmaps = mipmaps
		end
		if size then
			icon.icon_size = size
		end
		return icon
	end ,

	Attack_EffectDamage = function( damageType , amount )
		return
		{
			type = "damage" ,
			damage = { type = damageType , amount = amount }
		}
	end ,
	Resistance = function( damageType , decrease , percent )
		return
		{
			type = damageType ,
			decrease = decrease or 0 ,
			percent = percent or 0
		}
	end ,

	BoundBox = function( width , height )
		height = height or width
		local halfWidth = width / 2.0
		local halfHeight = height / 2.0
		return { { -halfWidth , -halfHeight } , { halfWidth , halfHeight } }
	end ,
	BoundBox_Collision = function( width , height )
		width = width * 0.95
		height = height and height * 0.95 or width
		local halfWidth = width / 2.0
		local halfHeight = height / 2.0
		return { { -halfWidth , -halfHeight } , { halfWidth , halfHeight } }
	end ,

	IngredientItem = function( name , amount )
		return
		{
			type = SICommon.Types.Item.Item ,
			name = name ,
			amount = math.max( amount or 1 , 1 )
		}
	end ,
	IngredientFluid = function( name , amount , minTemperature , maxTemperature )
		return
		{
			type = SICommon.Types.Fluid ,
			name = name ,
			amount = math.max( amount or 1 , 1 ) ,
			minimum_temperature = minTemperature ,
			maximum_temperature = maxTemperature
		}
	end ,
	ProductItem = function( name , amountOrProbability , minAmount , maxAmount , catalystAmount )
		local product = { type = SICommon.Types.Item.Item , name = name , show_details_in_recipe_tooltip = true }
		if minAmount then
			product.probability = amountOrProbability
			if maxAmount then
				product.amount_min = math.max( minAmount , 1 )
				product.amount_max = math.max( maxAmount , product.amount_min )
			else
				product.amount = math.max( minAmount , 1 )
			end
		else
			product.amount = math.max( amountOrProbability or 1 , 1 )
		end
		product.catalyst_amount = math.max( catalystAmount or product.amount or product.amount_max or 0 , 0 )
		return product
	end ,
	ProductItemHide = function( name , amountOrProbability , minAmount , maxAmount , catalystAmount )
		local product = SITools.ProductItem( name , amountOrProbability , minAmount , maxAmount , catalystAmount )
		product.show_details_in_recipe_tooltip = false
		return product
	end ,
	ProductFluid = function( name , amountOrProbability , minAmount , maxAmount , temperature , catalystAmount )
		local product = { type = SICommon.Types.Fluid , name = name , show_details_in_recipe_tooltip = true }
		if minAmount then
			product.probability = amountOrProbability
			if maxAmount then
				product.amount_min = math.max( minAmount , 1 )
				product.amount_max = math.max( maxAmount , product.amount_min )
			else
				product.amount = math.max( minAmount , 1 )
			end
		else
			product.amount = math.max( amountOrProbability or 1 , 1 )
		end
		product.temperature = temperature or 15
		product.catalyst_amount = math.max( catalystAmount or product.amount or product.amount_max or 0 , 0 )
		return product
	end ,
	ProductFluidHide = function( name , amountOrProbability , minAmount , maxAmount , temperature , catalystAmount )
		local product = SITools.ProductFluid( name , amountOrProbability , minAmount , maxAmount , temperature , catalystAmount )
		product.show_details_in_recipe_tooltip = false
		return product
	end ,
	Loot = function( name , probability , minCount , maxCount )
		local loot = { item = name , probability = probability , count_min = math.max( minCount or 1 , 1 ) }
		loot.count_max = math.max( maxCount or loot.count_min , loot.count_min )
		return loot
	end ,

	Sound = function( file , volume , minSpeed , maxSpeed )
		local sound = { filename = file , volume = volume or 1 }
		if minSpeed then
			sound.min_speed = minSpeed
		end
		if maxSpeed then
			sound.max_speed = maxSpeed
		end
		return sound
	end ,
	Sounds = function( fileOrList , volume , minSpeed , maxSpeed )
		if SITools.IsTable( fileOrList ) then
			local sounds = {}
			for i , v in pairs( fileOrList ) do
				table.insert( sounds , SITools.Sound( v , volume , minSpeed , maxSpeed ) )
			end
			return sounds
		else
			return { SITools.Sound( fileOrList , volume , minSpeed , maxSpeed ) }
		end
	end ,
	SoundList_Base = function( soundName , count , volume , startIndex )
		volume = volume or 1
		startIndex = startIndex or 1
		local length = count + startIndex - 1
		local countLength = SITools.NumberLength( length )
		local soundList = {}
		for i = startIndex , length , 1 do
			table.insert( soundList , SITools.Sound( "__base__/sound/"..soundName.."-"..SITools.NumberToString( i , countLength )..".ogg" , volume ) )
		end
		return soundList
	end
}
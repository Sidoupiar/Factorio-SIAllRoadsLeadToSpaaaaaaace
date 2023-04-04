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

	Resistance = function( damageType , decrease , percent )
		return
		{
			type = damageType ,
			decrease = decrease or 0 ,
			percent = percent or 0
		}
	end
}
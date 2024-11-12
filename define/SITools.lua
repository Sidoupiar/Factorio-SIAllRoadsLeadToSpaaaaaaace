---@class SITools
SITools =
{
	Hex16 = { "0" , "1" , "2" , "3" , "4" , "5" , "6" , "7" , "8" , "9" , "A" , "B" , "C" , "D" , "E" , "F" } ,

	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 表操作 ==========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================<br>
	---@param curData table
	---@param customData table
	---@param needOverwrite boolean
	---@return table -- 自身
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

	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 数值操作 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================<br>
	---@param number number
	---@return integer
	NumberLength = function( number )
		number = math.abs( number )
		local length = 0
		while number > 0 do
			length = length + 1
			number = math.floor( number/10 )
		end
		return length
	end ,

	-- ======================================================================<br>
	---@param number number
	---@param length integer
	---@return string
	NumberToString = function( number , length )
		local str = "" .. number
		while str:len() < length do
			str = "0" .. str
		end
		return str
	end ,

	-- ======================================================================<br>
	---@param number number
	---@param min number
	---@param max number
	---@return number
	Round = function( number , min , max )
		return math.max( math.min( number , max ) , min )
	end ,

	-- ======================================================================<br>
	---@param number any
	---@param min number
	---@param max number
	---@return number
	AsNumber = function( number , min , max )
		local cur = tonumber( number ) or 0
		return math.max( math.min( cur , max ) , min )
	end ,

	-- ======================================================================<br>
	---@param number any
	---@param min number
	---@return number
	AsNumber_Min = function( number , min )
		local cur = tonumber( number ) or 0
		return math.max( cur , min )
	end ,

	-- ======================================================================<br>
	---@param number any
	---@param min number
	---@param max number
	---@return integer
	AsNumberInt = function( number , min , max )
		local cur = tonumber( number ) or 0
		return math.floor( math.max( math.min( cur , max ) , min ) )
	end ,

	-- ======================================================================<br>
	---@param number any
	---@param min number
	---@return integer
	AsNumberInt_Min = function( number , min )
		local cur = tonumber( number ) or 0
		return math.floor( math.max( cur , min ) )
	end ,

	-- ======================================================================<br>
	---@param number integer
	---@param length integer
	---@return string
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

	-- ======================================================================<br>
	---@param number number
	---@return string
	FormatNumber2 = function( number )
		return ( "%.2f" ):format( number )
	end ,

	-- ======================================================================<br>
	---@param number number
	---@return string
	FormatNumber4 = function( number )
		return ( "%.4f" ):format( number )
	end ,

	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 类型判断 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================<br>
	---@param data any
	---@return boolean
	IsTable = function( data )
		return type( data ) == "table"
	end ,

	-- ======================================================================<br>
	---@param data any
	---@return boolean
	IsNotTable = function( data )
		return type( data ) ~= "table"
	end ,

	-- ======================================================================<br>
	---@param data any
	---@return boolean
	IsString = function( data )
		return type( data ) == "string"
	end ,

	-- ======================================================================<br>
	---@param data any
	---@return boolean
	IsNotString = function( data )
		return type( data ) ~= "string"
	end ,

	-- ======================================================================<br>
	---@param data any
	---@return boolean
	IsNumber = function( data )
		return type( data ) == "number"
	end ,

	-- ======================================================================<br>
	---@param data any
	---@return boolean
	IsNotNumber = function( data )
		return type( data ) ~= "number"
	end ,

	-- ======================================================================<br>
	---@param data any
	---@return boolean
	IsFunction = function( data )
		return type( data ) == "function"
	end ,

	-- ======================================================================<br>
	---@param data any
	---@return boolean
	IsNotFunction = function( data )
		return type( data ) ~= "function"
	end ,

	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 颜色操作 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================<br>
	---@param red integer|nil
	---@param green integer|nil
	---@param blue integer|nil
	---@param alpha integer|nil
	---@return table -- 颜色数据
	MakeColor = function( red , green , blue , alpha )
		return
		{
			r = red or 0.0 ,
			g = green or 0.0 ,
			b = blue or 0.0 ,
			a = alpha or 1.0
		}
	end ,

	-- ======================================================================<br>
	---@param red integer|nil
	---@param green integer|nil
	---@param blue integer|nil
	---@param alpha integer|nil
	---@return table -- 颜色数据
	MakeColor256 = function( red , green , blue , alpha )
		return
		{
			r = red and math.max( math.min( red , 255 ) , 0 ) / 255.0 or 0.0 ,
			g = green and math.max( math.min( green , 255 ) , 0 ) / 255.0 or 0.0 ,
			b = blue and math.max( math.min( blue , 255 ) , 0 ) / 255.0 or 0.0 ,
			a = alpha and math.max( math.min( alpha , 255 ) , 0 ) / 255.0 or 1.0 ,
		}
	end ,

	-- ======================================================================<br>
	---@param red integer|nil
	---@param green integer|nil
	---@param blue integer|nil
	---@param alpha integer|nil
	---@return string
	MakeHex256 = function( red , green , blue , alpha )
		local redString = red and SITools.NumberTo16( math.max( math.min( red , 255 ) , 0 ) , 2 ) or "00"
		local greenString = green and SITools.NumberTo16( math.max( math.min( green , 255 ) , 0 ) , 2 ) or "00"
		local blueString = blue and SITools.NumberTo16( math.max( math.min( blue , 255 ) , 0 ) , 2 ) or "00"
		local alphaString = alpha and SITools.NumberTo16( math.max( math.min( alpha , 255 ) , 0 ) , 2 ) or ""
		return alphaString .. redString .. greenString .. blueString
	end ,

	-- ======================================================================<br>
	---@param color table
	---@param dark number
	---@return table
	TransColor_Dark = function( color , dark )
		local red = math.max( math.min( color.r or color[1] or 0 , 255 ) , 0 )
		local green = math.max( math.min( color.g or color[2] or 0 , 255 ) , 0 )
		local blue = math.max( math.min( color.b or color[3] or 0 , 255 ) , 0 )
		local alpha = math.max( math.min( color.a or color[4] or 1 , 255 ) , 0 )
		if red > 1 then
			red = red / 255.0
		end
		if green > 1 then
			green = green / 255.0
		end
		if blue > 1 then
			blue = blue / 255.0
		end
		if alpha > 1 then
			alpha = alpha / 255.0
		end
		return
		{
			r = red + ( 1.0 - dark ) ,
			g = green + ( 1.0 - dark ) ,
			b = blue + ( 1.0 - dark ) ,
			a = alpha
		}
	end ,

	-- ======================================================================<br>
	---@param color table
	---@param light number
	---@return table
	TransColor_Light = function( color , light )
		local red = math.max( math.min( color.r or color[1] or 0 , 255 ) , 0 )
		local green = math.max( math.min( color.g or color[2] or 0 , 255 ) , 0 )
		local blue = math.max( math.min( color.b or color[3] or 0 , 255 ) , 0 )
		local alpha = math.max( math.min( color.a or color[4] or 1 , 255 ) , 0 )
		if red > 1 then
			red = red / 255.0
		end
		if green > 1 then
			green = green / 255.0
		end
		if blue > 1 then
			blue = blue / 255.0
		end
		if alpha > 1 then
			alpha = alpha / 255.0
		end
		return
		{
			r = red + ( 1.0 - red ) * light ,
			g = green + ( 1.0 - green ) * light ,
			b = blue + ( 1.0 - blue ) * light ,
			a = alpha
		}
	end ,

	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 图标操作 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================<br>
	---@param iconPath string
	---@param tint table
	---@param scale number
	---@param shift table
	---@param mipmaps integer
	---@param size integer
	---@return table -- 图标数据
	Icon = function( iconPath , tint , scale , shift , mipmaps , size )
		local icon = {}
		if iconPath then
			---@diagnostic disable-next-line: param-type-mismatch
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

	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 抗性操作 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================<br>
	---@param damageType string
	---@param decrease number
	---@param percent number
	---@return table -- 抗性数据
	Resistance = function( damageType , decrease , percent )
		return
		{
			type = damageType ,
			decrease = decrease or 0 ,
			percent = percent or 0
		}
	end ,

	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 能量操作 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================<br>
	---@param energy string
	---@param addition number
	---@return string
	Energy_Add = function( energy , addition )
		---@diagnostic disable-next-line: param-type-mismatch
		local value , class = energy:GetEnergyClass()
		return tostring( value + addition ) .. class
	end ,

	-- ======================================================================<br>
	---@param energy string
	---@param multiplier number
	---@return string
	Energy_Mult = function( energy , multiplier )
		---@diagnostic disable-next-line: param-type-mismatch
		local value , class = energy:GetEnergyClass()
		return tostring( value * multiplier ) .. class
	end
}
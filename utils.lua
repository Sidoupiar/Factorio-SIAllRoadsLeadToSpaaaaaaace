---@diagnostic disable: param-type-mismatch
-- ------------------------------------------------------------------------------------------------
-- ---------- 定义数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local CoreName = "SIAllRoadsLeadToSpaaaaaaace"
local CorePath = "__" .. CoreName .. "__"
local ClassList = {}
if defines and defines.events then
	SIEvents = {}
	for k , v in pairs( defines.events ) do
		SIEvents[k] = v
	end
end
function GetCorePath()
	return CorePath
end
function SIOrderPrefix()
	return "zSIOrderT"
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 添加引用 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIUtils = require( "__core__/lualib/util" )
require( CorePath .. "/define/SITools" )
require( CorePath .. "/define/SICommon" )
require( CorePath .. "/define/SIModData" )

SIUtils.CollisionMask = require( "__core__/lualib/collision-mask-util" )
SIUtils.Noise = require( "__core__/lualib/noise" )
SIUtils.NoiseMath = require( "__core__/lualib/noise/expression-to-ascii-math" )
SIUtils.Settings =
{
	ShowPatreon = function()
		return settings and settings.startup and settings.startup["SIUtils-ShowPatreon"].value or true
	end ,
	Debug = function()
		return settings and settings.startup and settings.startup["SIUtils-Debug"].value or false
	end ,
	ShowError = function()
		return settings and settings.startup and settings.startup["SIUtils-ShowError"].value or false
	end ,
	CodeError = function()
		return settings and settings.startup and settings.startup["SIUtils-CodeError"].value or true
	end
}
function SIUtils.PrintLocalised( localisedString )
	localised_print( localisedString )
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 定义函数 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIDate =
{
	TicksPerDay = 25000 ,
	TicksPerHalfDay = 12500 ,
	TicksPerDayReal = 5184000 ,
	TicksPerHalfDayReal = 2592000 ,
	-- ----------------------------------------
	-- 计算游戏时间<br>
	-- 按照游戏时间也是 1 天 24 小时计算<br>
	-- ----------------------------------------
	-- tick = 当前游戏时刻 , game.tick<br>
	-- ----------------------------------------
	-- 返回值 1 = 天数<br>
	-- 返回值 2 = 小时<br>
	-- 返回值 3 = 分钟<br>
	-- ----------------------------------------
	FormatDateByTick = function( tick )
		local d , t = math.modf( tick / SIDate.TicksPerDay + 0.5 )
		local h , m = math.modf( t * 24 )
		return ( "%u" ):format( d + 1 ) , ( "%02u" ):format( h ) , ( "%02u" ):format( math.floor( m * 60 ) )
	end ,
	-- ----------------------------------------
	-- 计算游戏时间<br>
	-- 按照游戏时间也是 1 天 24 小时计算<br>
	-- ----------------------------------------
	-- tick        = 当前游戏时刻 , game.tick<br>
	-- ticksPerDay = 当前世界的一天时间长度<br>
	-- ----------------------------------------
	-- 返回值 1 = 天数<br>
	-- 返回值 2 = 小时<br>
	-- 返回值 3 = 分钟<br>
	-- ----------------------------------------
	FormatDateByTickPerDay = function( tick , ticksPerDay )
		local d , t = math.modf( tick / ticksPerDay + 0.5 )
		local h , m = math.modf( t * 24 )
		return ( "%u" ):format( d + 1 ) , ( "%02u" ):format( h ) , ( "%02u" ):format( math.floor( m * 60 ) )
	end ,
	-- ----------------------------------------
	-- 计算游戏时间<br>
	-- 按照现实的时间计算 , 也就是 60 tick = 1 秒<br>
	-- ----------------------------------------
	-- tick = 当前游戏时刻 , game.tick<br>
	-- ----------------------------------------
	-- 返回值 1 = 天数<br>
	-- 返回值 2 = 小时<br>
	-- 返回值 3 = 分钟<br>
	-- 返回值 4 = 秒数<br>
	-- ----------------------------------------
	FormatDateByTickReal = function( tick )
		local d , t = math.modf( tick / SIDate.TicksPerDayReal )
		local h , o = math.modf( t * 24 )
		local m , s = math.modf( o * 60 )
		return ( "%u" ):format( d ) , ( "%02u" ):format( h ) , ( "%02u" ):format( m ) , ( "%02u" ):format( math.floor( s * 60 ) )
	end
}
SIMath =
{
	Range = function( num , min , max )
		return math.max( math.min( num , max ) , min )
	end ,
	Cnum = function( num , min , max )
		return SIMath.Range( math.floor( num ) , min , max )
	end
}
SITable =
{
	Size = function( data )
		return table_size( data )
	end ,
	-- ----------------------------------------
	-- 数组型的表使用 , 移除第一个匹配的值那一项<br>
	-- 非数组型的表使用 SITable.RemoveItem 函数<br>
	-- ----------------------------------------
	-- data  = 数组<br>
	-- value = 值<br>
	-- ----------------------------------------
	Remove = function( data , value )
		local pos = nil
		for i , v in pairs( data ) do
			if v == value then
				pos = i
				break
			end
		end
		if pos then
			table.remove( data , pos )
		end
	end ,
	-- ----------------------------------------
	-- 非数组型的表使用 , 移除第一个匹配的值那一项<br>
	-- 数组型的表使用 SITable.Remove 函数<br>
	-- ----------------------------------------
	-- data  = 表<br>
	-- value = 值<br>
	-- ----------------------------------------
	RemoveItem = function( data , value )
		for k , v in pairs( data ) do
			if v == value then
				data[k] = nil
			end
		end
	end ,
	HasKey = function( data , key )
		for k , v in pairs( data ) do
			if k == key then
				return true
			end
		end
		return false
	end ,
	Has = function( data , value )
		for k , v in pairs( data ) do
			if v == value then
				return true
			end
		end
		return false
	end ,
	Find = function( data , value )
		for k , v in pairs( data ) do
			if v == value then
				return k
			end
		end
		return nil
	end ,
	GetWithID = function( data , id )
		for key , value in pairs( data ) do
			if SITools.IsTable( value ) and value.ID == id then
				return value , key
			end
		end
		return nil , 0
	end ,
	GetWithName = function( data , name )
		for key , value in pairs( data ) do
			if SITools.IsTable( value ) and value.Name == name then
				return value , key
			end
		end
		return nil , 0
	end ,
	ShallowCopy = function( data )
		local newData = {}
		for k , v in pairs( data ) do
			newData[k] = v
		end
		return newData
	end ,
	TableToString = function( data , level )
		if SITools.IsNotTable( data ) then
			E( "数据处理 : 数据类型错误 , 无法对非 table 类型的数据进行转换" )
		end
		level = level or 1
		local levelBaseSpace = ""
		local levelValueSpace = "    "
		for i = 1 , level-1 , 1 do
			levelBaseSpace = levelBaseSpace .. "    "
			levelValueSpace = levelValueSpace .. "    "
		end
		local currentSize = 1
		local totalSize = SITable.Size( data )
		local lastIndex = 1
		local output = "\n" .. levelBaseSpace .. "{"
		for key , value in pairs( data ) do
			local outputKey = ""
			if SITools.IsString( key ) then
				outputKey = "\n" .. levelValueSpace .. key .. " ="
			elseif key == lastIndex then
				lastIndex = lastIndex + 1
			else
				outputKey = "\n" .. levelValueSpace .. tostring( key ) .. " ="
			end
			if outputKey == "" then
				if SITools.IsTable( value ) then
					output = output .. SITable.TableToString( value , level+1 )
				elseif SITools.IsString( value ) then
					output = output .. "\n" .. levelValueSpace .. "\"" .. value .. "\""
				else
					output = output .. "\n" .. levelValueSpace .. tostring( value )
				end
			else
				if SITools.IsTable( value ) then
					output = output .. outputKey .. SITable.TableToString( value , level+1 )
				elseif SITools.IsString( value ) then
					output = output .. outputKey .. " \"" .. value .. "\""
				else
					output = output .. outputKey .. " " .. tostring( value )
				end
			end
			if currentSize < totalSize then
				output = output .. " ,"
			end
			currentSize = currentSize + 1
		end
		return output .. "\n" .. levelBaseSpace .. "}"
	end ,
	StartsWithList = function( stringList , source )
		for index , string in pairs( stringList ) do
			if string:StartsWith( string , source ) then
				return true
			end
		end
		return false
	end ,
	EndsWithList = function( stringList , source )
		for index , string in pairs( stringList ) do
			if string:EndsWith( string , source ) then
				return true
			end
		end
		return false
	end
}

function string:Split( separator )
	if not separator or separator:len() < 1 then
		return { self }
	end
	local pos = 0
	local list = {}
	for st , sp in function() return self:find( separator , pos , true ) end do
		table.insert( list , self:sub( pos , st - 1 ) )
		pos = sp + 1
	end
	table.insert( list , self:sub( pos ) )
	return list
end

function string:Concat( list , separator )
	local str = self and self .. separator or ""
	local index = 1
	for i , v in pairs( list ) do
		if index > 1 then
			str = str .. separator
		end
		str = str .. v
		index = index + 1
	end
	return str
end

function string:UpperCaseFirst()
	return self:sub( 1 , 1 ):upper() .. self:sub( 1 - self:len() )
end

function string:StartsWith( str )
	return self:sub( 1 , str:len() ) == str
end

function string:EndsWith( str )
	return self:sub( -str:len() ) == str
end

function string:FindLast( str )
	if not str or str:len() < 1 then
		return nil
	end
	local length = str:len()
	for index = self:len() - length , 1 , -1 do
		local startPos , endPos = self:find( str , index , length )
		if startPos then
			return startPos , endPos
		end
	end
	return nil
end

function string:RemoveLastAndAfter( str )
	local startPos = self:FindLast( str )
	return startPos and self:sub( 1 , startPos ) or self
end

function string:ToABlist()
	if self and self ~= "" then
		local list = self:Split( ";" )
		if #list > 0 then
			local item
			local items = {}
			for i , v in pairs( list ) do
				if v and v ~= "" then
					item = v:Split( "," )
					if item[1] ~= "" and item[2] ~= "" and tonumber( item[2] ) then
						item[2] = math.ceil( item[2] )
						items[item[1]] = item[2] < 1 and 1 or item[2]
					end
				end
			end
			return items
		else
			return {}
		end
	else
		return {}
	end
end

function string:Spos( pos )
	self = self or ""
	return self .. pos.x .. "," .. pos.y
end

function string:Level()
	return tonumber( self:sub( -1 ) )
end

function string:LastLevel()
	return self:sub( 1 , -2 ) .. ( self:Level() - 1 )
end

function string:NextLevel()
	return self:sub( 1 , -2 ) .. ( self:Level() + 1 )
end

function string:GetEnergyClass()
	local class = ""
	local value = tostring( self )
	local pos , _ = value:find( "[a-zA-Z]" )
	if pos then
		class = value:sub( pos )
		value = value:sub( 1 , pos - 1 )
	end
	return tonumber( value ) , class
end

function string:ToFunctionName()
	local functionName = ""
	for index , str in pairs( self:Split( "-" ) ) do
		functionName = functionName .. str:UpperCaseFirst()
	end
	return functionName
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 报错信息 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local SIMmess = error

function error( message )
	if SIUtils.Settings.ShowError() then
		SIMmess( message )
		return
	end
	log( "[获取错误] : " .. CoreName .. "_Code: " .. message )
end

function E( message )
	local output = ""
	for i = 5 , 2 , -1 do
		local S = debug.getinfo( i , "S" )
		local l = debug.getinfo( i , "l" )
		local n = debug.getinfo( i , "n" )
		if S and S.source then
			output = output .. S.source:sub( 2 , -1 )
		else
			output = output .. "[unknown]"
		end
		if l and l.currentline then
			output = output .. ":" .. l.currentline
		else
			output = output .. ":-1"
		end
		if n and n.name then
			output = output .. ":" .. n.name .. "()"
		else
			output = output .. ":[filecode]"
		end
		output = output .. " ::\n"
	end
	if SIUtils.Settings.CodeError() then
		SIMmess( "\n_____ ::\n" .. output .. message )
		return
	end
	log( "[获取错误] :\n_____ ::\n" .. output .. message )
end

function CodeE( Structure , message )
	E( Structure.Name .. " [ " .. Structure.ID .. " ] : " .. message )
	return Structure
end

function UseE( Structure , message )
	E( "模块使用 [ " .. Structure.ID .. " ] : " .. message )
	return Structure
end

function TableE( tableData , tableName )
	if tableName and tableName ~= "" then
		E( "当前表 [" .. tostring( tableName ) .. "] 的数据 :" .. SITable.TableToString( tableData ) )
	else
		E( "当前表的数据 :" .. SITable.TableToString( tableData ) )
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 输出信息 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIPrint =
{
	Log = function( message )
		log( CoreName .. " : " .. ( message or "nil" ) )
	end ,
	Debug = function( message )
		if SIUtils.Settings.Debug() then
			log( CoreName .. " : " .. ( message or "nil" ) )
			if game then
				game.print( { "SICommon.debug" , message } , SICommon.Colors.Print.BLUE )
			end
		end
	end ,
	Print = function( message )
		if SIInit.State == SIInit.StateCodeDefine.Control and game then
			game.print( { "SICommon.message" , message } , SICommon.Colors.Print.GREEN )
		end
		SIPrint.Log( message )
	end ,
	Message = function( playerOrIndex , customMessage )
		if not customMessage or customMessage == "" then
			return
		end
		if SIInit.State == SIInit.StateCodeDefine.Control then
			if not playerOrIndex then
				playerOrIndex = game
			elseif SITools.IsNumber( playerOrIndex ) or not playerOrIndex.is_player then
				playerOrIndex = game.get_player( playerOrIndex )
			end
			playerOrIndex.print( { "SICommon.message" , customMessage } , SICommon.Colors.Print.GREEN )
		else
			SIPrint.Log( customMessage )
		end
	end ,
	Tip = function( playerOrIndex , customMessage )
		if not customMessage or customMessage == "" then
			return
		end
		if SIInit.State == SIInit.StateCodeDefine.Control then
			if not playerOrIndex then
				playerOrIndex = game
			elseif SITools.IsNumber( playerOrIndex ) or not playerOrIndex.is_player then
				playerOrIndex = game.get_player( playerOrIndex )
			end
			playerOrIndex.print( { "SICommon.tip" , customMessage } , SICommon.Colors.Print.BLUE )
		else
			SIPrint.Log( customMessage )
		end
	end ,
	Warning = function( playerOrIndex , customMessage )
		if not customMessage or customMessage == "" then
			return
		end
		if SIInit.State == SIInit.StateCodeDefine.Control then
			if not playerOrIndex then
				playerOrIndex = game
			elseif SITools.IsNumber( playerOrIndex ) or not playerOrIndex.is_player then
				playerOrIndex = game.get_player( playerOrIndex )
			end
			playerOrIndex.print( { "SICommon.warning" , customMessage } , SICommon.Colors.Print.ORANGE )
		else
			SIPrint.Log( customMessage )
		end
	end ,
	Alert = function( playerOrIndex , customMessage )
		if not customMessage or customMessage == "" then
			return
		end
		if SIInit.State == SIInit.StateCodeDefine.Control then
			if not playerOrIndex then
				playerOrIndex = game
			elseif SITools.IsNumber( playerOrIndex ) or not playerOrIndex.is_player then
				playerOrIndex = game.get_player( playerOrIndex )
			end
			playerOrIndex.print( { "SICommon.alert" , customMessage } , SICommon.Colors.Print.RED )
		else
			SIPrint.Log( customMessage )
		end
	end ,
	ToShow = function( value )
		local show = tostring( value )
		if show == nil or show == "" then
			return { "SICommon.Show-EmptyValue" }
		elseif show == "true" then
			return { "SICommon.Show-TrueValue" }
		elseif show == "false" then
			return { "SICommon.Show-FalseValue" }
		end
		return show
	end ,
	Error      = E ,
	ErrorCode  = CodeE ,
	ErrorUse   = UseE ,
	ErrorTable = TableE
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 引用函数 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local SINeedListData = {}

function SINeed( name , notself )
	local source = debug.getinfo( 2 , "S" ).source
	if notself then
		for i = 3 , 10 , 1 do
			local info = debug.getinfo( i , "S" )
			if info then
				source = info.source
				if not source:find( CorePath ) then
					break
				end
			else
				source = debug.getinfo( i - 1 , "S" ).source
				break
			end
		end
	end
	local isBase = name:find( "__" )
	source = isBase and source:sub( source:find( "__" , 3 ) + 3 , -1 ) or source:sub( 2 , -1 )
	local path = SINeedListData[source]
	if not path then
		path = isBase and "" or source:match( "^.*/" ) or ""
		SINeedListData[source] = path
	end
	return require( path .. name )
end

function SINeedList( basePath , ... )
	local results = {}
	for i , path in pairs{ ... } do
		if path then
			results[path] = SINeed( basePath .. "/" .. path , true )
		end
	end
	return results
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- API 的使用常见和原始 MOD 中一致
SIAPI = {}
SIConfigs = {}
SISettings =
{
	Startup = {} ,
	Runtime = {} ,
	PerUser = {} ,
	RuntimeChange = {} ,
	PerUserChange = {}
}
SIInit =
{
	ID = "SIInit" ,
	Name = "初始化" ,
	StateCodeDefine =
	{
		Data                = 1 ,
		DataUpdates         = 2 ,
		DataFinalFixes      = 3 ,
		Control             = 4 ,
		Settings            = 5 ,
		SettingsUpdates     = 6 ,
		SettingsFinalFixes  = 7 ,
		-- 特殊状态
		SettingsInstrument  = 101 ,
		DataInstrument      = 102 ,
		DataFinalInstrument = 103 ,
		ControlInstrument   = 104 ,
	} ,
	State = nil ,
	OrderCode = 1000 ,
	OrderStep = 1000 ,
	ConstantsDataOrderCode = 1000 ,
	ConstantsDataOrderStep = 1 ,
	ConstantsDataList = {} ,
	ModName = CoreName ,
	ModPath = CorePath ,
	CurrentConstantsData = {}
}

-- ----------------------------------------
-- 设置当前的载入阶段<br>
-- 除了 control 阶段外 , 请勿在外部调用此函数<br>
-- ----------------------------------------
-- StateCode = 载入阶段值 , 可用值请见 SIInit.StateCodeDefine 表<br>
-- ----------------------------------------
function SIInit.AutoLoadState( StateCode )
	if not SITable.Has( SIInit.StateCodeDefine , StateCode ) then
		return CodeE( SIInit , "不存在的阶段 , StateCode=" .. StateCode )
	end
	SIInit.State = StateCode
	if StateCode == SIInit.StateCodeDefine.Data then
		for index , name in pairs( ClassList ) do
			SINeed( CorePath .. "/define/class/" .. name )
		end
		SINeed( CorePath .. "/define/data/SIGen" , true )
		SINeed( CorePath .. "/define/data/SIGraphics" , true )
		SINeed( CorePath .. "/define/data/SISound" , true )
		SINeed( CorePath .. "/define/data/SIStyle" , true )
		--SINeed( CorePath .. "/define/data/SIAutoPlace" , true )
		if not circuit_connector_definitions then
			require( "circuit-connector-sprites" )
		end
	elseif StateCode == SIInit.StateCodeDefine.Control then
		for index , name in pairs( ClassList ) do
			SINeed( CorePath .. "/define/class/" .. name )
		end
		SINeed( CorePath .. "/define/runtime/SIInterface" , true )
		SINeed( CorePath .. "/define/runtime/SIEventBus" , true )
		SINeed( CorePath .. "/define/runtime/SIGlobal" , true )
		SINeed( CorePath .. "/define/runtime/SIConfigManager" , true )
		SINeed( CorePath .. "/define/runtime/SIElements" , true )
		SINeed( CorePath .. "/define/runtime/SIFunctions" , true )
		SIEventBus.InitSelf()
	end
	return SIInit
end

-- ----------------------------------------
-- 初始化 ConstantsData 数据包<br>
-- 除了自动创建一些 ConstantsData 属性和自动创建一些 ConstantsData 定义的数据外<br>
-- 还负责读取 ConstantsData.FileList 中定义的文件列表<br>
-- 以及给 ConstantsData 创建一个全局变量<br>
-- 更多信息请见 data.lua 中的相关注释<br>
-- ----------------------------------------
-- ModName = 调用此函数的 MOD 的名称 , 要使用代码名称而不是显示名称<br>
-- CustomPackageConfig = 功能包的配置信息数组 , 如果值为 nil , 则会尝试加载 MOD 文件夹下的 PackageConfig.lua 文件 , 文件不存在则会报错<br>
-- ConstantsDataPrefix = ConstantsData 在代码的各种位置中进行注册时使用的名称前缀 , 防止重名 , 不影响注册的原型数据<br>
-- ShowNamePrefix      = ConstantsData 在代码的各种位置中进行显示时使用的名称前缀 , 防止重名 , 影响注册的原型数据和本地化字符串 , 生成原型数据名称时此前缀也会被包含进去<br>
-- ----------------------------------------
function SIInit.AutoLoad( ModName , CustomPackageConfig , ConstantsDataPrefix , ShowNamePrefix )
	if not ModName then
		ModName = CoreName
		SIInit.ModName = CoreName
		SIInit.ModPath = CorePath
	else
		SIInit.ModName = ModName
		SIInit.ModPath = "__" .. ModName .. "__"
	end
	CustomPackageConfig = CustomPackageConfig or SINeed( SIInit.ModPath .. "/PackageConfig" , true )
	ConstantsDataPrefix = ConstantsDataPrefix or "SIConstants_"
	ShowNamePrefix = ShowNamePrefix or "SI"
	if SIInit.State == SIInit.StateCodeDefine.Settings or SIInit.State == SIInit.StateCodeDefine.Data or SIInit.State == SIInit.StateCodeDefine.Control then
		for packageIndex , packageConfig in pairs( CustomPackageConfig ) do
			local packageName = packageConfig.PackageName
			if packageConfig.Requires then
				for requireIndex , requirePackageName in pairs( packageConfig.Requires ) do
					if not SIInit.ConstantsDataList[ModName .. "_" .. requirePackageName] then
						return CodeE( SIInit , "模块缺少强制依赖 , Package=\"" .. packageName .. "\" , Require=\"" .. requirePackageName .. "\"" )
					end
				end
			end
			local packagePath = SIInit.ModPath .. "/package/" .. packageName .. "/"
			local constantsData = SINeed( packagePath .. "0_ConstantsData" , true )
			if constantsData and constantsData.ID then
				SIInit.ConstantsDataList[ModName .. "_" .. packageName] = constantsData
				SIInit.OrderCode = SIInit.OrderCode + SIInit.OrderStep
				SIInit.ConstantsDataOrderCode = SIInit.ConstantsDataOrderCode + SIInit.ConstantsDataOrderStep
				-- 补全属性
				if not constantsData.Name then
					constantsData.Name = constantsData.ID
				end
				if constantsData.UseClassPrefix == nil then
					constantsData.UseClassPrefix = true
				end
				if constantsData.UseShowPrefix == nil then
					constantsData.UseShowPrefix = true
				end
				if constantsData.Order == nil then
					constantsData.Order = tostring( SIInit.ConstantsDataOrderCode )
				end
				if not constantsData.Autoload then
					constantsData.Autoload = {}
				end
				if constantsData.Autoload.Enable == nil then
					constantsData.Autoload.Enable = true
				end
				local className = ( constantsData.UseClassPrefix and ConstantsDataPrefix or "" ) .. constantsData.ID:gsub( "-" , "_" )
				if _G[className] then
					return CodeE( SIInit , "已存在的 ConstantsData.ClassName , ClassName=" .. className )
				end
				_G[className] = constantsData
				constantsData.API =
				{
					ID = constantsData.ID ,
					PackageName = packageName ,
					ClassName = className
				}
				constantsData.OrderOffset = {}
				-- 添加基础数据
				constantsData.ClassName = className
				constantsData.CodeName = ( constantsData.UseShowPrefix and ShowNamePrefix or "" ) .. constantsData.ID:gsub( "_" , "-" )
				constantsData.ShowName = ( constantsData.UseShowPrefix and ShowNamePrefix or "" ) .. constantsData.Name:gsub( "_" , "-" )
				constantsData.ShowNamePrefix = constantsData.ShowName .. "-"
				constantsData.OrderPrefix = SIOrderPrefix() .. "[" .. constantsData.Order .. constantsData.CodeName .. "]-"
				constantsData.OrderCode = SIInit.OrderCode
				constantsData.LocalisedName = { "ConstantsDataName." .. constantsData.CodeName }
				constantsData.LocalisedDescription = { "ConstantsDataDescription." .. constantsData.CodeName }
				constantsData.GetNextOrderCode = function()
					local orderCode = constantsData.OrderCode + 1
					while constantsData.OrderOffset[orderCode] do
						orderCode = orderCode + 1
					end
					constantsData.OrderCode = orderCode
					return constantsData.OrderCode
				end
				constantsData.GetOrderString = function()
					local orderCode = constantsData.OrderCode + 1
					while constantsData.OrderOffset[orderCode] do
						orderCode = orderCode + 1
					end
					constantsData.OrderCode = orderCode
					return constantsData.OrderPrefix .. constantsData.OrderCode .. "-"
				end
				constantsData.GetOrderStringWithOffset = function( OrderOffset )
					constantsData.OrderCode = constantsData.OrderCode + 1
					local orderCode = constantsData.OrderCode + OrderOffset
					constantsData.OrderOffset[orderCode] = constantsData.OrderCode
					return constantsData.OrderPrefix .. orderCode .. "-"
				end
				if SIAPI[constantsData.CodeName] then
					return CodeE( SIInit , "已存在的 ConstantsData.CodeName , CodeName=" .. constantsData.CodeName )
				end
				SIAPI[constantsData.CodeName] = constantsData.API
				constantsData.API.CodeName = constantsData.CodeName
				constantsData.API.OrderPrefix = constantsData.OrderPrefix
				constantsData.API.GetNextOrderCode = constantsData.GetNextOrderCode
				constantsData.API.GetOrderString = constantsData.GetOrderString
				constantsData.API.GetOrderStringWithOffset = constantsData.GetOrderStringWithOffset
				-- 加载开始前回调
				if constantsData.BeforeLoad then
					constantsData.BeforeLoad( constantsData )
				end
				-- 按阶段生成属性
				if SIInit.State == SIInit.StateCodeDefine.Settings then
					-- 自动创建设置
					if constantsData.Autoload.Enable and constantsData.Autoload.Settings then
						local settings = {}
						for settingID , settingValues in pairs( constantsData.Autoload.Settings ) do
							local realName = constantsData.ShowNamePrefix .. settingID:gsub( "_" , "-" )
							local settingType = settingValues[1]
							local settingItem =
							{
								type = settingType .. "-setting" ,
								setting_type = settingValues[2] ,
								name = realName ,
								default_value = settingValues[3] ,
								order = constantsData.GetOrderString() ,
								hidden = false
							}
							if settingType == SICommon.SettingTypes.BOOL then
								settingItem.localised_name = settingValues[4] or { "SISettingName."..realName }
								settingItem.localised_description = settingValues[5] or { "SICommon.SettingsDescription" , constantsData.LocalisedName , { "SISettingDescription."..realName } , SIPrint.ToShow( settingValues[3] ) }
								settingItem.forced_value = false
							elseif settingType == SICommon.SettingTypes.INT or settingType == SICommon.SettingTypes.DOUBLE then
								settingItem.minimum_value = settingValues[4]
								settingItem.maximum_value = settingValues[5]
								settingItem.allowed_values = settingValues[6]
								settingItem.localised_name = settingValues[7] or { "SISettingName."..realName }
								settingItem.localised_description = settingValues[8] or { "SICommon.SettingsDescription" , constantsData.LocalisedName , { "SISettingDescription."..realName } , SIPrint.ToShow( settingValues[3] ) }
							elseif settingType == SICommon.SettingTypes.STRING then
								settingItem.allow_blank = settingValues[4] or false
								settingItem.allowed_values = settingValues[5]
								settingItem.localised_name = settingValues[6] or { "SISettingName."..realName }
								settingItem.localised_description = settingValues[7] or { "SICommon.SettingsDescription" , constantsData.LocalisedName , { "SISettingDescription."..realName } , SIPrint.ToShow( settingValues[3] ) }
								settingItem.auto_trim = true
							end
							table.insert( settings , settingItem )
						end
						if #settings > 0 then
							data:extend( settings )
						end
						constantsData.Autoload = nil
					end
				else
					-- 补充属性
					constantsData.raw = {}
					-- 计算资源文件路径
					if constantsData.Path then
						if constantsData.Path.Resource then
							constantsData.PicturePath = constantsData.Path.Resource:gsub( "\\." , "/" ) .. "/"
							constantsData.SoundPath = constantsData.PicturePath
						else
							if constantsData.Path.Picture then
								constantsData.PicturePath = constantsData.Path.Picture:gsub( "\\." , "/" ) .. "/"
							else
								constantsData.PicturePath = SIInit.ModPath .. "/package/" .. packageName .. "/graphic/"
							end
							if constantsData.Path.Sound then
								constantsData.SoundPath = constantsData.Path.Sound:gsub( "\\." , "/" ) .. "/"
							else
								constantsData.SoundPath = SIInit.ModPath .. "/package/" .. packageName .. "/sound/"
							end
						end
						constantsData.Path = nil
					else
						constantsData.PicturePath = SIInit.ModPath .. "/package/" .. packageName .. "/graphic/"
						constantsData.PoundPath = SIInit.ModPath .. "/package/" .. packageName .. "/sound/"
					end
					-- 创建设置引用 , 注册分组 , 伤害类型和其他类型
					local autoload = constantsData.Autoload
					if autoload.Enable then
						if autoload.Settings then
							constantsData.raw.Settings = {}
							local startupList = {}
							local runtimeList = {}
							local perUserList = {}
							local runtimeChangeList = {}
							local perUserChangeList = {}
							for settingID , settingValues in pairs( autoload.Settings ) do
								local realName = constantsData.ShowNamePrefix .. settingID:gsub( "_" , "-" )
								constantsData.raw.Settings[settingID] = realName
								if settingValues[2] == SICommon.SettingAffectTypes.StartUp then
									startupList[settingID] = function()
										return settings.startup[realName].value
									end
								elseif settingValues[2] == SICommon.SettingAffectTypes.Runtime then
									runtimeList[settingID] = function()
										return settings.global[realName].value
									end
									runtimeChangeList[settingID] = function( value )
										settings.global[realName] = { value = value }
									end
								elseif settingValues[2] == SICommon.SettingAffectTypes.PerUser then
									perUserList[settingID] = function( playerOrIndex )
										return settings.get_player_settings( playerOrIndex )[realName].value
									end
									perUserChangeList[settingID] = function( playerOrIndex , value )
										settings.get_player_settings( playerOrIndex )[realName] = { value = value }
									end
								end
							end
							SISettings.Startup[constantsData.CodeName] = startupList
							SISettings.Runtime[constantsData.CodeName] = runtimeList
							SISettings.PerUser[constantsData.CodeName] = perUserList
							SISettings.RuntimeChange[constantsData.CodeName] = runtimeChangeList
							SISettings.PerUserChange[constantsData.CodeName] = perUserChangeList
						end
						if SIInit.State == SIInit.StateCodeDefine.Data then
							local prototypes = {}
							if autoload.Groups then
								constantsData.raw.Groups = {}
								for groupID , groupData in pairs( autoload.Groups ) do
									local groupShowName = SICommon.ShowNamePrefix[SICommon.Types.Group] .. ( groupData and groupData.Name or groupID ):gsub( "_" , "-" )
									local groupRealName = constantsData.ShowNamePrefix .. groupShowName
									if not groupData.Order then
										groupData.Order = constantsData.Order
									end
									if autoload.Enable then
										local groupOrderString = "zSIOrder[" .. groupData.Order .. constantsData.CodeName .. "]-" .. constantsData.GetNextOrderCode() .. "-"
										local group =
										{
											type = SICommon.Types.Group ,
											name = groupRealName ,
											localised_name = { constantsData.CodeName .. "Name." .. groupShowName } ,
											localised_description = { constantsData.CodeName .. "Description." .. groupShowName } ,
											icon = constantsData.PicturePath .. groupShowName .. SICommon.ShowNameSuffix.ICON .. ".png" ,
											icon_size = 64 ,
											icon_mipmaps = 0 ,
											order = groupOrderString ,
											order_in_recipe = groupOrderString
										}
										table.insert( prototypes , group )
									end
									constantsData.raw.Groups[groupID] = {}
									if groupData.Subgroups then
										local subOrder = groupData.SubOrder or "0"
										for subgroupID , subgroupUseName in pairs( groupData.Subgroups ) do
											local subgroupShowName = groupShowName .. "-" .. ( subgroupUseName or subgroupID ):gsub( "_" , "-" )
											local subgroupRealName = constantsData.ShowNamePrefix .. subgroupShowName
											if autoload.Enable then
												local subgroup =
												{
													type = SICommon.Types.Subgroup ,
													name = subgroupRealName ,
													localised_name = { constantsData.CodeName .. "Name." .. subgroupShowName } ,
													localised_description = { constantsData.CodeName .. "Description." .. subgroupShowName } ,
													group = groupRealName ,
													order = "zSIOrder[" .. groupData.Order .. constantsData.CodeName .. "]-[" .. subOrder .. "]-" .. constantsData.GetNextOrderCode() .. "-"
												}
												table.insert( prototypes , subgroup )
											end
											constantsData.raw.Groups[groupID][subgroupID] = subgroupRealName
										end
									end
									groupData.Subgroups = nil
									groupData.ShowName = groupShowName
									groupData.RealName = groupRealName
								end
								constantsData.API.Groups = SIUtils.table.deepcopy( autoload.Groups )
							end
							if autoload.GroupsAppend then
								if not constantsData.raw.Groups then
									constantsData.raw.Groups = {}
								end
								for groupID , groupData in pairs( autoload.GroupsAppend ) do
									local ConstantsDataCodeName = groupData.ConstantsDataCodeName
									if not ConstantsDataCodeName then
										return CodeE( SIInit , "自动创建子分组并添加至指定分组时 , 分组数据的 ConstantsDataCodeName 属性不能为空 , ConstantsData=" .. constantsData.ShowName .. " , GroupID=" .. groupID )
									end
									if not groupData.Subgroups then
										return CodeE( SIInit , "自动创建子分组并添加至指定分组时 , 分组数据的 Subgroups 属性不能为空" )
									end
									local APIData = SIAPI[ConstantsDataCodeName]
									if not APIData then
										return CodeE( SIInit , "自动创建子分组并添加至指定分组时 , 分组数据的 ConstantsDataCodeName 必须指向已经加载完成或正在加载的 ConstantsData , ConstantsData=" .. constantsData.ShowName .. " , GroupID=" .. groupID )
									end
									if not APIData.Groups or not APIData.Groups[groupID] then
										return CodeE( SIInit , "自动创建子分组并添加至指定分组时 , 分组数据的 ConstantsDataCodeName 指向的 ConstantsData 中必须包含指定分组 , ConstantsData=" .. constantsData.ShowName .. " , GroupID=" .. groupID )
									end
									if not constantsData.raw.Groups[groupID] then
										constantsData.raw.Groups[groupID] = {}
									end
									local aimGroupData = APIData.Groups[groupID]
									local subOrder = groupData.SubOrder or "0"
									for subgroupID , subgroupUseName in pairs( groupData.Subgroups ) do
										local subgroupShowName = aimGroupData.ShowName .. "-" .. ( subgroupUseName or subgroupID ):gsub( "_" , "-" )
										local subgroupRealName = constantsData.ShowNamePrefix .. subgroupShowName
										if autoload.Enable then
											local subgroup =
											{
												type = SICommon.Types.Subgroup ,
												name = subgroupRealName ,
												localised_name = { constantsData.CodeName .. "Name." .. subgroupShowName } ,
												localised_description = { constantsData.CodeName .. "Description." .. subgroupShowName } ,
												group = aimGroupData.RealName ,
												order = "zSIOrder[" .. aimGroupData.Order .. ConstantsDataCodeName .. "]-[" .. subOrder .. "]-" .. APIData.GetNextOrderCode() .. "-"
											}
											table.insert( prototypes , subgroup )
										end
										constantsData.raw.Groups[groupID][subgroupID] = subgroupRealName
									end
								end
							end
							if autoload.DamageTypes then
								constantsData.raw.DamageTypes = {}
								constantsData.raw.DamageTypeValues = {}
								for damageTypeID , resistanceValue in pairs( autoload.DamageTypes ) do
									local showName = SICommon.ShowNamePrefix[SICommon.Types.DamageType] .. ( resistanceValue and resistanceValue.Name or damageTypeID ):gsub( "_" , "-" )
									local realName = constantsData.ShowNamePrefix .. showName
									if autoload.Enable then
										local damageType =
										{
											type = SICommon.Types.DamageType ,
											name = realName ,
											localised_name = { constantsData.CodeName .. "Name." .. showName } ,
											localised_description = { constantsData.CodeName .. "Description." .. showName } ,
											order = constantsData.GetOrderString() ,
											hidden = false
										}
										table.insert( prototypes , damageType )
									end
									constantsData.raw.DamageTypes[damageTypeID] = realName
									if resistanceValue and ( resistanceValue.Decrease or resistanceValue.Percent ) then
										constantsData.raw.DamageTypeValues[damageTypeID] = SITools.Resistance( realName , resistanceValue.Decrease , resistanceValue.Percent )
									else
										constantsData.raw.DamageTypeValues[damageTypeID] = nil
									end
								end
							end
							if autoload.Categories then
								constantsData.raw.Categories = {}
								for categoryCode , categroyList in pairs( autoload.Categories ) do
									local typeCode = SICommon.Types.Categories[categoryCode]
									constantsData.raw.Categories[categoryCode] = {}
									for categoryID , categoryUseName in pairs( categroyList ) do
										local showName = SICommon.ShowNamePrefix[typeCode] .. ( categoryUseName or categoryID ):gsub( "_" , "-" )
										local realName = constantsData.ShowNamePrefix .. showName
										if autoload.Enable then
											local category =
											{
												type = typeCode ,
												name = realName ,
												localised_name = { constantsData.CodeName .. "Name." .. showName } ,
												localised_description = { constantsData.CodeName .. "Description." .. showName } ,
												order = constantsData.GetOrderString()
											}
											table.insert( prototypes , category )
										end
										constantsData.raw.Categories[categoryCode][categoryID] = realName
									end
								end
							end
							if SIGen then
								SIGen.Extend( prototypes )
							end
						end
						constantsData.Autoload = nil
					end
				end
				-- 注册功能包配置
				SIConfigs[constantsData.CodeName] = packageConfig.Configs or {}
				-- 加载完毕后回调
				if constantsData.AfterLoad then
					constantsData.AfterLoad( constantsData )
				end
			end
		end
		for packageIndex , packageConfig in pairs( CustomPackageConfig ) do
			local packageName = packageConfig.PackageName
			local constantsData = SIInit.ConstantsDataList[ModName .. "_" .. packageName]
			if constantsData and constantsData.FileList then
				local currentFileList = constantsData.FileList[SIInit.State]
				if currentFileList then
					local packagePath = SIInit.ModPath .. "/package/" .. packageName .. "/"
					SIInit.CurrentConstantsData = constantsData
					for index, fileName in pairs( currentFileList ) do
						SINeed( packagePath .. fileName , true )
					end
					if SIGen then
						SIGen.Fresh()
					end
				end
			end
		end
	else
		for ModPackageName , constantsData in pairs( SIInit.ConstantsDataList ) do
			if constantsData and constantsData.FileList then
				local currentFileList = constantsData.FileList[SIInit.State]
				if currentFileList then
					local packagePath = SIInit.ModPath .. "/package/" .. constantsData.API.PackageName .. "/"
					SIInit.CurrentConstantsData = constantsData
					for index, fileName in pairs( constantsData.FileList[SIInit.State] ) do
						SINeed( packagePath .. fileName , true )
					end
					if SIGen then
						SIGen.Fresh()
					end
				end
			end
		end
		local SIGenFinish = function()
			SIGen.Finish()
			for ModPackageName , constantsData in pairs( SIInit.ConstantsDataList ) do
				if constantsData and constantsData.raw and constantsData.raw.DamageTypeValues then
					for damageTypeName , resistanceValue in pairs( constantsData.raw.DamageTypeValues ) do
						if resistanceValue then
							for typeCode , typeName in pairs( SICommon.Types.HealthEntities ) do
								local entityList = data.raw[typeName]
								if entityList then
									for entityName , entity in pairs( entityList ) do
										if not entity.resistances then
											entity.resistances = {}
										end
										local addFlag = true
										for index , resistance in pairs( entity.resistances ) do
											if resistance.type == damageTypeName then
												addFlag = false
												break
											end
										end
										if addFlag then
											table.insert( entity.resistances , resistanceValue )
										end
									end
								end
							end
						end
					end
				end
			end
		end
		if SIInstrumentMode then
			if SIInit.State == SIInit.StateCodeDefine.DataFinalInstrument then
				SIGenFinish()
			end
		else
			if SIInit.State == SIInit.StateCodeDefine.DataFinalFixes then
				SIGenFinish()
			end
		end
	end
	return SIInit
end
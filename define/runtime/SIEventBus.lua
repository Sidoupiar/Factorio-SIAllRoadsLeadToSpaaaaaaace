-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 使用说明 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================
-- [事件总线]
-- 这是一个本地化的模块 , 每个 contrl 层都需要单独引入
-- ======================================================================
-- [作用]
-- 作用就是它可以给一个事件注册多个函数 , 自动分配
-- 各个函数的用处请见对应函数的注释
-- ======================================================================

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 基础数据 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIEventBus =
{
	ID = "SIEventBus" ,
	Code = "SIEventBus" ,
	Show = "事件总线" ,
	Order = 1 ,
	InitFunctions = 
	{
		Functions = {}
	} ,
	LoadFunctions =
	{
		Functions = {}
	} ,
	ConfigurationChangeFunctions =
	{
		NotAdd = true ,
		Functions = {}
	} ,
	WaitFunctions =
	{
		Functions = {}
	}  ,
	NthFunctions = {} ,
	EventList = {} ,
	-- 一些事件标识
	IsOnCode = true ,
	IsOnInit = false ,
	IsOnLoad = false ,
	-- 全局持久化数据
	Settings =
	{
		Name = "SIEventBus" ,
		Default =
		{
			WaitListeners = {} ,
			AsyncList = {}
		}
	}
}
-- EventList 内的元素结构
-- eventId =
-- {
--   IsSet = bool ,
--   Functions = { { id = idString , func = function } }
-- }

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 事件操作 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================
-- 把函数注册进 script.on_init<br>
-- 可以注册多个函数<br>
-- ======================================================================
-- func          = 函数 , 不能为空<br>
-- id            = 函数的 id , 默认是一个递增的数字<br>
-- ======================================================================
function SIEventBus.Init( func , id )
	if not func then
		return CodeE( SIEventBus , "不能添加空的初始化函数" )
	end
	if not id then
		id = SIEventBus.Order
		SIEventBus.Order = SIEventBus.Order + 1
	end
	table.insert( SIEventBus.InitFunctions.Functions , { id = id , func = func } )
	return SIEventBus
end

-- ======================================================================
-- 把函数注册进 script.on_load<br>
-- 可以注册多个函数<br>
-- ======================================================================
-- func          = 函数 , 不能为空<br>
-- id            = 函数的 id , 默认是一个递增的数字<br>
-- ======================================================================
function SIEventBus.Load( func , id )
	if not func then
		return CodeE( SIEventBus , "不能添加空的载入存档函数" )
	end
	if not id then
		id = SIEventBus.Order
		SIEventBus.Order = SIEventBus.Order + 1
	end
	table.insert( SIEventBus.LoadFunctions.Functions , { id = id , func = func } )
	return SIEventBus
end

-- ======================================================================
-- 把函数注册进 script.on_configuration_changed<br>
-- 可以注册多个函数<br>
-- ======================================================================
-- func          = 函数 , 不能为空<br>
-- id            = 函数的 id , 默认是一个递增的数字<br>
-- ======================================================================
function SIEventBus.ConfigurationChange( func , id )
	if not func then
		return CodeE( SIEventBus , "不能添加空的初始化函数" )
	end
	if not id then
		id = SIEventBus.Order
		SIEventBus.Order = SIEventBus.Order + 1
	end
	table.insert( SIEventBus.ConfigurationChangeFunctions.Functions , { id = id , func = func } )
	if SIEventBus.ConfigurationChangeFunctions.NotAdd then
		SIEventBus.ConfigurationChangeFunctions.NotAdd = false
		script.on_configuration_changed( function( configurationChangedData )
			for index , funcData in pairs( SIEventBus.ConfigurationChangeFunctions.Functions ) do
				funcData.func( configurationChangedData , funcData.id )
			end
		end )
	end
	return SIEventBus
end

-- ======================================================================
-- 把函数注册为当玩家加入游戏时执行的函数<br>
-- 可以注册多个函数<br>
-- 每个函数每个玩家执行一次<br>
-- 需要启用 SIGlobal 模块之后 , 这个函数才会有效<br>
-- ======================================================================
-- func          = 函数 , 不能为空<br>
-- id            = 函数的 id , 默认是一个递增的数字<br>
-- ======================================================================
function SIEventBus.Wait( func , id )
	if not func then
		return CodeE( SIEventBus , "不能添加空的缓执行函数" )
	end
	if not id then
		id = SIEventBus.Order
		SIEventBus.Order = SIEventBus.Order + 1
	end
	table.insert( SIEventBus.WaitFunctions.Functions , { id = id , func = func } )
	return SIEventBus
end

-- ======================================================================
-- 把函数注册进 script.on_nth_tick<br>
-- 每个间隔都可以注册多个函数<br>
-- ======================================================================
-- count         = 执行间隔 , 不能为空<br>
-- func          = 函数 , 不能为空<br>
-- id            = 函数的 id , 默认是一个递增的数字<br>
-- ======================================================================
function SIEventBus.AddNth( count , func , id )
	if not func then
		return CodeE( SIEventBus , "不能添加空的事件函数" )
	end
	if not id then
		id = SIEventBus.Order
		SIEventBus.Order = SIEventBus.Order + 1
	end
	local data = SIEventBus.NthFunctions[count]
	if not data then
		data = {}
		data.IsSet = false
		data.Functions = {}
		SIEventBus.NthFunctions[count] = data
	end
	if data.IsSet then table.insert( data.Functions , { id = id , func = func } )
	else
		data.IsSet = true
		table.insert( data.Functions , { id = id , func = func } )
		script.on_nth_tick( count , function( event )
			for index , funcData in pairs( SIEventBus.NthFunctions[event.nth_tick].Functions ) do
				funcData.func( event , funcData.id )
			end
		end )
	end
	return SIEventBus
end

-- ======================================================================
-- 函数注册进 script.on_nth_tick 后通过 id 替换函数<br>
-- ======================================================================
-- count         = 执行间隔 , 不能为空<br>
-- func          = 函数 , 不能为空<br>
-- id            = 函数的 id , 不能为空<br>
-- ======================================================================
function SIEventBus.SetNth( count , func , id )
	if not func then
		return CodeE( SIEventBus , "不能设置空的事件函数" )
	end
	if not id then
		return CodeE( SIEventBus , "设置事件函数时必须使用明确的 id" )
	end
	local data = SIEventBus.NthFunctions[count]
	if not data then
		return CodeE( SIEventBus , "当前 count 指定的事件列表没有记录数据" )
	end
	local oldIndex
	for index , funcData in pairs( data.Functions ) do
		if funcData.id == id then
			oldIndex = index
			break
		end
	end
	if not oldIndex then
		return CodeE( SIEventBus , "设置事件函数时必须使用列表中存在的 id" )
	end
	data.Functions[oldIndex] = { id = id , func = func }
	return SIEventBus
end

-- ======================================================================
-- 通过 id 移除注册进 script.on_nth_tick 的函数<br>
-- ======================================================================
-- count         = 执行间隔 , 不能为空<br>
-- id            = 函数的 id , 不能为空<br>
-- ======================================================================
function SIEventBus.RemoveNth( count , id )
	if not id then
		return CodeE( SIEventBus , "移除事件函数时必须使用明确的 id" )
	end
	local data = SIEventBus.NthFunctions[count]
	if not data then
		return CodeE( SIEventBus , "当前 count 指定的事件列表没有记录数据" )
	end
	local oldIndex
	for index , funcData in pairs( data.Functions ) do
		if funcData.id == id then
			oldIndex = index
			break
		end
	end
	if not oldIndex then
		return CodeE( SIEventBus , "设置事件函数时必须使用列表中存在的 id" )
	end
	if SITable.Size( data.Functions ) > 1 then
		local functions = {}
		for index , funcData in pairs( data.Functions ) do
			if oldIndex ~= index then
				table.insert( functions , funcData )
			end
		end
		data.Functions = functions
	else
		SIEventBus.ClearNth( count )
	end
	return SIEventBus
end

-- ======================================================================
-- 移除注册进 script.on_nth_tick 的函数<br>
-- ======================================================================
-- count         = 执行间隔 , 不能为空<br>
-- ======================================================================
function SIEventBus.ClearNth( count )
	local data = SIEventBus.NthFunctions[count]
	if data then
		SIEventBus.NthFunctions[count] = nil
	end
	script.on_nth_tick( count )
	return SIEventBus
end

-- ======================================================================
-- 把函数注册进 script.on_event<br>
-- 可以注册多个函数<br>
-- ======================================================================
-- eventId       = defines.events 中枚举的事件 id 或自定义的事件 id , 不能为空<br>
-- func          = 函数 , 不能为空<br>
-- id            = 函数的 id , 默认是一个递增的数字<br>
-- ======================================================================
function SIEventBus.Add( eventId , func , id )
	if not func then
		return CodeE( SIEventBus , "不能添加空的事件函数" )
	end
	if not id then
		id = SIEventBus.Order
		SIEventBus.Order = SIEventBus.Order + 1
	end
	local baseFunc = script.get_event_handler( eventId )
	if baseFunc then
		local data = SIEventBus.EventList[eventId]
		if data.IsSet then
			table.insert( data.Functions , { id = id , func = func } )
		else
			data.IsSet = true
			table.insert( data.Functions , { id = id , func = func } )
			script.on_event( eventId , function( event )
				for index , funcData in pairs( SIEventBus.EventList[event.name].Functions ) do
					funcData.func( event , funcData.id )
				end
			end )
		end
	else
		local data = SIEventBus.EventList[eventId]
		if not data then
			data = {}
			SIEventBus.EventList[eventId] = data
		end
		data.IsSet = false
		data.Functions = { { id = id , func = func } }
		script.on_event( eventId , func )
	end
	return SIEventBus
end

-- ======================================================================
-- 函数注册进 script.on_event 后通过 id 替换函数<br>
-- 可以注册多个函数<br>
-- ======================================================================
-- eventId       = defines.events 中枚举的事件 id 或自定义的事件 id , 不能为空<br>
-- func          = 函数 , 不能为空<br>
-- id            = 函数的 id , 不能为空<br>
-- ======================================================================
function SIEventBus.Set( eventId , func , id )
	if not func then
		return CodeE( SIEventBus , "不能设置空的事件函数" )
	end
	if not id then
		return CodeE( SIEventBus , "设置事件函数时必须使用明确的 id" )
	end
	local data = SIEventBus.EventList[eventId]
	if not data then
		return CodeE( SIEventBus , "当前 eventId 指定的事件列表没有记录数据" )
	end
	local oldIndex
	for index , funcData in pairs( data.Functions ) do
		if funcData.id == id then
			oldIndex = index
			break
		end
	end
	if not oldIndex then
		return CodeE( SIEventBus , "设置事件函数时必须使用列表中存在的 id" )
	end
	if data.IsSet then
		data.Functions[oldIndex] = { id = id , func = func }
	else
		data.Functions = { { id = id , func = func } }
		script.on_event( eventId , func )
	end
	return SIEventBus
end

-- ======================================================================
-- 通过 id 移除注册进 script.on_event 的函数<br>
-- ======================================================================
-- eventId       = defines.events 中枚举的事件 id 或自定义的事件 id , 不能为空<br>
-- id            = 函数的 id , 不能为空<br>
-- ======================================================================
function SIEventBus.Remove( eventId , id )
	if not id then
		return CodeE( SIEventBus , "移除事件函数时必须使用明确的 id" )
	end
	local data = SIEventBus.EventList[eventId]
	if not data then
		return CodeE( SIEventBus , "当前 eventId 指定的事件列表没有记录数据" )
	end
	local oldIndex
	for index , funcData in pairs( data.Functions ) do
		if funcData.id == id then
			oldIndex = index
			break
		end
	end
	if not oldIndex then
		return CodeE( SIEventBus , "设置事件函数时必须使用列表中存在的 id" )
	end
	if data.IsSet then
		local functions = {}
		for index , funcData in pairs( data.Functions ) do
			if oldIndex ~= index then
				table.insert( functions , funcData )
			end
		end
		data.Functions = functions
		if #functions < 2 then
			data.IsSet = false
			local funcData = functions[1]
			if funcData then
				script.on_event( eventId , funcData.func )
			end
		end
	else
		SIEventBus.Clear( eventId )
	end
	return SIEventBus
end

-- ======================================================================
-- 移除注册进 script.on_event 的函数<br>
-- ======================================================================
-- eventId       = defines.events 中枚举的事件 id 或自定义的事件 id , 不能为空<br>
-- ======================================================================
function SIEventBus.Clear( eventId )
	local data = SIEventBus.EventList[eventId]
	if data then
		SIEventBus.EventList[eventId] = nil
	end
	script.on_event( eventId )
	return SIEventBus
end

-- ======================================================================
-- 添加伪异步执行数据包<br>
-- 它会在指定的时间被执行<br>
-- 需要启用 SIGlobal 模块之后才能使用这个函数<br>
-- ======================================================================
-- asyncDataList = 需要伪异步执行的数据包列表<br>
-- ======================================================================
-- asyncDataList 是一个表 , 由键值对组成<br>
-- 键是多少游戏刻后要执行这个数据包 , 以当前游戏刻为准<br>
-- 值是一个表 , 结构如下 :<br>
-- data     = 执行函数时使用的自定义数据包 , 可以为 nil<br>
-- funcName = 要执行的函数名称 , 指向一个全局函数 , 调用时会传递两个参数 , 参数 1 = 当前的游戏刻 , 参数 2 = 执行函数时使用的自定义数据包 , 即上面的数据包<br>
-- ======================================================================
function SIEventBus.AddAsyncData( asyncDataList )
	if SIEventBus.IsOnCode or SIEventBus.IsOnLoad then
		return CodeE( SIEventBus , "不可以在初始化阶段和 on_load 阶段添加伪异步执行数据包" )
	end
	if not SIGlobal then
		return UseE( SIEventBus , "必须启用 SIGlobal 之后才能使用 SIEventBus.AddAsyncData 函数" )
	end
	local settings = SIGlobal.GetGlobalSettings( SIEventBus.Settings.Name )
	local tick = game.tick
	for nextTick , funcData in pairs( asyncDataList ) do
		local realTick = tick + nextTick
		local asyncDataList = settings.AsyncList[realTick]
		if not asyncDataList then
			asyncDataList = {}
			settings.AsyncList[realTick] = asyncDataList
		end
		table.insert( asyncDataList , funcData )
	end
	return SIEventBus
end

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 事件注册 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================
-- 用于执行在 SIEventBus.Init 函数中注册的函数 , 以及更新 SIEventBus 的事件标识<br>
-- ======================================================================
script.on_init( function()
	SIEventBus.IsOnCode = false
	SIEventBus.IsOnInit = true
	for index , funcData in pairs( SIEventBus.InitFunctions.Functions ) do
		funcData.func( funcData.id )
	end
	SIEventBus.IsOnInit = false
end )

-- ======================================================================
-- 用于执行在 SIEventBus.Load 函数中注册的函数 , 以及更新 SIEventBus 的事件标识<br>
-- ======================================================================
script.on_load( function()
	SIEventBus.IsOnCode = false
	SIEventBus.IsOnLoad = true
	for index , funcData in pairs( SIEventBus.LoadFunctions.Functions ) do
		funcData.func( funcData.id )
	end
	SIEventBus.IsOnLoad = false
end )

-- ======================================================================
-- 新玩家首次进入游戏时对这个玩家执行一次<br>
-- 注册函数后才会判断是否执行过<br>
-- ======================================================================
SIEventBus.Add( SIEvents.on_player_joined_game , function( event )
	if not SIGlobal then
		return
	end
	local playerIndex = event.player_index
	for index , funcData in pairs( SIEventBus.WaitFunctions.Functions ) do
		local settings = SIGlobal.GetGlobalSettings( SIEventBus.Settings.Name )
		local listeners = settings.WaitListeners[funcData.id]
		if not listeners then
			listeners = {}
			settings.WaitListeners[funcData.id] = listeners
		end
		if not SITable.Has( listeners , playerIndex ) then
			table.insert( listeners , playerIndex )
			funcData.func( event , funcData.id )
		end
	end
end )

-- ======================================================================
-- 指定伪异步操作数据包<br>
-- ======================================================================
SIEventBus.Add( SIEvents.on_tick , function( event )
	if not SIGlobal then
		return
	end
	local tick = event.tick
	local settings = SIGlobal.GetGlobalSettings( SIEventBus.Settings.Name )
	local asyncDataList = settings.AsyncList[tick]
	if asyncDataList then
		for index , funcData in pairs( asyncDataList ) do
			_G[funcData.funcName]( tick , funcData.data )
		end
		settings.AsyncList[tick] = nil
	end
end )

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 内部函数 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================
-- 框架内部函数 , 请勿在外部调用<br>
-- 注册一些需要持久化保存的数据<br>
-- ======================================================================
function SIEventBus.InitSelf()
	if not SIGlobal then
		UseE( SIEventBus , "需要使用 SIGlobal 来读取和保存持久化数据" )
	end
	SIGlobal.CreateSettings( SIEventBus.Settings )
	return SIEventBus
end
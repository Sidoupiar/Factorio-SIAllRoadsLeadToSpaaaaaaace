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
-- eventID =
-- {
--   NotAdd = boolean ,
--   Functions = { { id = idString , func = function } }
-- }

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 事件操作 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================<br>
-- 把事件函数注册进 script.on_init<br>
-- 可以注册多个事件函数<br>
-- ======================================================================<br>
---@param func function -- 事件函数 , 不能为空
---@param id integer|string|nil -- 事件函数的 id , 默认是一个递增的数字
---@return table -- 自身
function SIEventBus.Init( func , id )
	if not func then
		return CodeE( SIEventBus , "不能添加空的初始化事件函数" )
	end
	if not id then
		id = SIEventBus.Order
		SIEventBus.Order = SIEventBus.Order + 1
	end
	table.insert( SIEventBus.InitFunctions.Functions , { id = id , func = func } )
	return SIEventBus
end

-- ======================================================================<br>
-- 把事件函数注册进 script.on_load<br>
-- 可以注册多个事件函数<br>
-- ======================================================================<br>
---@param func function -- 事件函数 , 不能为空
---@param id integer|string|nil -- 事件函数的 id , 默认是一个递增的数字
---@return table -- 自身
function SIEventBus.Load( func , id )
	if not func then
		return CodeE( SIEventBus , "不能添加空的载入存档事件函数" )
	end
	if not id then
		id = SIEventBus.Order
		SIEventBus.Order = SIEventBus.Order + 1
	end
	table.insert( SIEventBus.LoadFunctions.Functions , { id = id , func = func } )
	return SIEventBus
end

-- ======================================================================<br>
-- 把事件函数注册进 script.on_configuration_changed<br>
-- 可以注册多个事件函数<br>
-- ======================================================================<br>
---@param func function -- 事件函数 , 不能为空
---@param id integer|string|nil -- 事件函数的 id , 默认是一个递增的数字
---@return table -- 自身
function SIEventBus.ConfigurationChange( func , id )
	if not func then
		return CodeE( SIEventBus , "不能添加空的初始化事件函数" )
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

-- ======================================================================<br>
-- 把事件函数注册为当玩家加入游戏时执行的事件函数<br>
-- 可以注册多个事件函数<br>
-- 每个事件函数每个玩家执行一次<br>
-- 需要启用 SIGlobal 模块之后 , 这个事件函数才会被调用<br>
-- ======================================================================<br>
---@param func function -- 事件函数 , 不能为空
---@param id integer|string|nil -- 事件函数的 id , 默认是一个递增的数字
---@return table -- 自身
function SIEventBus.Wait( func , id )
	return CodeE( SIEventBus , "暂时不给用" )
-- 	if not func then
-- 		return CodeE( SIEventBus , "不能添加空的缓执行事件函数" )
-- 	end
-- 	if not id then
-- 		id = SIEventBus.Order
-- 		SIEventBus.Order = SIEventBus.Order + 1
-- 	end
-- 	table.insert( SIEventBus.WaitFunctions.Functions , { id = id , func = func } )
-- 	return SIEventBus
end

-- ======================================================================<br>
-- 把事件函数注册进 script.on_nth_tick<br>
-- 每个间隔都可以注册多个事件函数<br>
-- ======================================================================<br>
---@param count integer -- 执行间隔 , 不能为空
---@param func function -- 事件函数 , 不能为空
---@param id integer|string|nil -- 事件函数的 id , 默认是一个递增的数字
---@return table -- 自身
function SIEventBus.AddNth( count , func , id )
	if not func then
		return CodeE( SIEventBus , "不能添加空的事件函数" )
	end
	if not id then
		id = SIEventBus.Order
		SIEventBus.Order = SIEventBus.Order + 1
	end
	local data = SIEventBus.NthFunctions[count]
	if data then
		for index , funcData in pairs( data.Functions ) do
			if funcData.id == id then
				return CodeE( SIEventBus , "不能重复添加具有相同 id 的事件函数" )
			end
		end
		table.insert( data.Functions , { id = id , func = func } )
		return SIEventBus
	else
		SIEventBus.NthFunctions[count] =
		{
			NotAdd = false ,
			Functions = { { id = id , func = func } }
		}
		script.on_nth_tick( count , SIEventBus.Inner_NTHFunction )
		return SIEventBus
	end
end

-- ======================================================================<br>
-- 把事件函数注册进 script.on_nth_tick 后通过 id 替换事件函数<br>
-- ======================================================================<br>
---@param count integer -- 执行间隔 , 不能为空
---@param func function -- 事件函数 , 不能为空
---@param id integer|string|nil -- 事件函数的 id , 不能为空
---@return table -- 自身
function SIEventBus.SetNth( count , func , id )
	if not func then
		return CodeE( SIEventBus , "不能设置空的事件函数" )
	end
	if not id then
		return CodeE( SIEventBus , "设置事件函数时必须使用明确的 id" )
	end
	local data = SIEventBus.NthFunctions[count]
	if not data then
		return CodeE( SIEventBus , "当前 count 指定的事件列表没有记录的事件函数数据" )
	end
	for index , funcData in pairs( data.Functions ) do
		if funcData.id == id then
			data.Functions[index] = { id = id , func = func }
			return SIEventBus
		end
	end
	return CodeE( SIEventBus , "设置事件函数时必须使用列表中存在的 id" )
end

-- ======================================================================<br>
-- 把事件函数注册进 script.on_nth_tick<br>
-- 每个间隔都可以注册多个事件函数<br>
-- 如果 id 已经存在 , 则替换事件函数<br>
-- ======================================================================<br>
---@param count integer -- 执行间隔 , 不能为空
---@param func function -- 事件函数 , 不能为空
---@param id integer|string -- 事件函数的 id , 不能为空
---@return table -- 自身
function SIEventBus.AddOrSetNth( count , func , id )
	if not func then
		return CodeE( SIEventBus , "不能设置空的事件函数" )
	end
	if not id then
		return CodeE( SIEventBus , "设置事件函数时必须使用明确的 id" )
	end
	local data = SIEventBus.NthFunctions[count]
	if data then
		for index , funcData in pairs( data.Functions ) do
			if funcData.id == id then
				data.Functions[index] = { id = id , func = func }
				return SIEventBus
			end
		end
		table.insert( data.Functions , { id = id , func = func } )
		return SIEventBus
	else
		SIEventBus.NthFunctions[count] =
		{
			NotAdd = false ,
			Functions = { { id = id , func = func } }
		}
		script.on_nth_tick( count , SIEventBus.Inner_NTHFunction )
		return SIEventBus
	end
end

-- ======================================================================<br>
-- 通过 id 移除注册进 script.on_nth_tick 的事件函数<br>
-- ======================================================================<br>
---@param count integer -- 执行间隔 , 不能为空
---@param id integer|string -- 事件函数的 id , 不能为空
---@return table -- 自身
function SIEventBus.RemoveNth( count , id )
	if not id then
		return CodeE( SIEventBus , "移除事件函数时必须使用明确的 id" )
	end
	local data = SIEventBus.NthFunctions[count]
	if not data then
		return CodeE( SIEventBus , "当前 count 指定的事件列表没有记录的事件函数数据" )
	end
	for index , funcData in pairs( data.Functions ) do
		if funcData.id == id then
			if #data.Functions > 1 then
				table.remove( data.Functions , index )
			else
				SIEventBus.ClearNth( count )
			end
			return SIEventBus
		end
	end
	return CodeE( SIEventBus , "设置事件函数时必须使用列表中存在的 id" )
end

-- ======================================================================<br>
-- 移除注册进 script.on_nth_tick 的事件函数<br>
-- ======================================================================<br>
---@param count integer -- 执行间隔 , 不能为空
---@return table -- 自身
function SIEventBus.ClearNth( count )
	if SIEventBus.NthFunctions[count] then
		SIEventBus.NthFunctions[count] = nil
	end
	script.on_nth_tick( count , nil )
	return SIEventBus
end

-- ======================================================================<br>
-- 把事件函数注册进 script.on_event<br>
-- 可以注册多个事件函数<br>
-- ======================================================================<br>
---@param eventID string -- defines.events 中枚举的事件 id 或自定义的事件 id , 不能为空
---@param func function -- 事件函数 , 不能为空
---@param id integer|string|nil -- 事件函数的 id , 默认是一个递增的数字
---@return table -- 自身
function SIEventBus.Add( eventID , func , id )
	if not func then
		return CodeE( SIEventBus , "不能添加空的事件函数" )
	end
	if not id then
		id = SIEventBus.Order
		SIEventBus.Order = SIEventBus.Order + 1
	end
	local data = SIEventBus.EventList[eventID]
	if script.get_event_handler( eventID ) then
		for index , funcData in pairs( data.Functions ) do
			if funcData.id == id then
				return CodeE( SIEventBus , "不能重复添加具有相同 id 的事件函数" )
			end
		end
		table.insert( data.Functions , { id = id , func = func } )
		if data.NotAdd then
			data.NotAdd = false
			script.on_event( eventID , SIEventBus.Inner_EventFunction )
		end
		return SIEventBus
	else
		if data then
			data.NotAdd = true
			data.Functions = { { id = id , func = func } }
		else
			SIEventBus.EventList[eventID] =
			{
				NotAdd = true ,
				Functions = { { id = id , func = func } }
			}
		end
		script.on_event( eventID , func )
		return SIEventBus
	end
end

-- ======================================================================<br>
-- 把事件函数注册进 script.on_event 后通过 id 替换事件函数<br>
-- 可以注册多个事件函数<br>
-- ======================================================================<br>
---@param eventID string -- defines.events 中枚举的事件 id 或自定义的事件 id , 不能为空
---@param func function -- 事件函数 , 不能为空
---@param id integer|string -- 事件函数的 id , 不能为空
---@return table -- 自身
function SIEventBus.Set( eventID , func , id )
	if not func then
		return CodeE( SIEventBus , "不能设置空的事件函数" )
	end
	if not id then
		return CodeE( SIEventBus , "设置事件函数时必须使用明确的 id" )
	end
	local data = SIEventBus.EventList[eventID]
	if not data then
		return CodeE( SIEventBus , "当前 eventID 指定的事件列表没有记录的事件函数数据" )
	end
	for index , funcData in pairs( data.Functions ) do
		if funcData.id == id then
			if data.NotAdd then
				data.Functions = { { id = id , func = func } }
				script.on_event( eventID , func )
			else
				data.Functions[index] = { id = id , func = func }
			end
			return SIEventBus
		end
	end
	return CodeE( SIEventBus , "设置事件函数时必须使用列表中存在的 id" )
end

-- ======================================================================<br>
-- 通过 id 移除注册进 script.on_event 的事件函数<br>
-- ======================================================================<br>
---@param eventID string -- defines.events 中枚举的事件 id 或自定义的事件 id , 不能为空
---@param id integer|string -- 事件函数的 id , 不能为空
---@return table -- 自身
function SIEventBus.Remove( eventID , id )
	if not id then
		return CodeE( SIEventBus , "移除事件函数时必须使用明确的 id" )
	end
	local data = SIEventBus.EventList[eventID]
	if not data then
		return CodeE( SIEventBus , "当前 eventID 指定的事件列表没有记录的事件函数数据" )
	end
	for index , funcData in pairs( data.Functions ) do
		if funcData.id == id then
			if data.NotAdd then
				SIEventBus.Clear( eventID )
			else
				table.remove( data.Functions , index )
				if #data.Functions < 2 then
					data.NotAdd = true
					local singleFuncData = data.Functions[1]
					if singleFuncData then
						script.on_event( eventID , singleFuncData.func )
					end
				end
			end
			return SIEventBus
		end
	end
	return CodeE( SIEventBus , "设置事件函数时必须使用列表中存在的 id" )
end

-- ======================================================================<br>
-- 移除注册进 script.on_event 的事件函数<br>
-- ======================================================================<br>
---@param eventID string -- defines.events 中枚举的事件 id 或自定义的事件 id , 不能为空
---@return table -- 自身
function SIEventBus.Clear( eventID )
	if SIEventBus.EventList[eventID] then
		SIEventBus.EventList[eventID] = nil
	end
	script.on_event( eventID , nil )
	return SIEventBus
end

-- ======================================================================<br>
-- 添加伪异步执行数据包<br>
-- 它会在指定的时间被执行<br>
-- 需要启用 SIGlobal 模块之后才能使用这个函数<br>
-- ======================================================================<br>
-- asyncDataList 是一个表 , 由键值对组成<br>
-- 键是多少游戏刻后要执行这个数据包 , 以当前游戏刻为准<br>
-- 值是一个表 , 结构如下 :<br>
-- data     = 执行函数时使用的自定义数据包 , 可以为 nil<br>
-- funcName = 要执行的函数名称 , 指向一个全局函数 , 调用时会传递两个参数 , 参数 1 = 当前的游戏刻 , 参数 2 = 执行函数时使用的自定义数据包 , 即上面的数据包<br>
-- ======================================================================<br> 
---@param asyncDataList table -- 需要伪异步执行的数据包列表
---@return table -- 自身
function SIEventBus.AddAsyncData( asyncDataList )
	return CodeE( SIEventBus , "暂时不给用" )
-- 	if SIEventBus.IsOnCode or SIEventBus.IsOnLoad then
-- 		return CodeE( SIEventBus , "不可以在初始化阶段和 on_load 阶段添加伪异步执行数据包" )
-- 	end
-- 	if not SIGlobal then
-- 		return UseE( SIEventBus , "必须启用 SIGlobal 之后才能使用 SIEventBus.AddAsyncData 函数" )
-- 	end
-- 	local settings = SIGlobal.GetGlobalSettings( SIEventBus.Settings.Name )
-- 	local tick = game.tick
-- 	for nextTick , funcData in pairs( asyncDataList ) do
-- 		local realTick = tick + nextTick
-- 		local settingAsyncDataList = settings.AsyncList[realTick]
-- 		if not settingAsyncDataList then
-- 			settingAsyncDataList = {}
-- 			settings.AsyncList[realTick] = settingAsyncDataList
-- 		end
-- 		table.insert( settingAsyncDataList , funcData )
-- 	end
-- 	return SIEventBus
end

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 事件注册 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================<br>
-- 用于执行在 SIEventBus.Init 函数中注册的事件函数 , 以及更新 SIEventBus 的事件标识<br>
-- ======================================================================<br>
script.on_init( function()
	SIEventBus.IsOnCode = false
	SIEventBus.IsOnInit = true
	for index , funcData in pairs( SIEventBus.InitFunctions.Functions ) do
		funcData.func( funcData.id )
	end
	SIEventBus.IsOnInit = false
end )

-- ======================================================================<br>
-- 用于执行在 SIEventBus.Load 函数中注册的事件函数 , 以及更新 SIEventBus 的事件标识<br>
-- ======================================================================<br>
script.on_load( function()
	SIEventBus.IsOnCode = false
	SIEventBus.IsOnLoad = true
	for index , funcData in pairs( SIEventBus.LoadFunctions.Functions ) do
		funcData.func( funcData.id )
	end
	SIEventBus.IsOnLoad = false
end )

-- -- ======================================================================<br>
-- -- 新玩家首次进入游戏时对这个玩家执行一次<br>
-- -- 注册函数后才会判断是否执行过<br>
-- -- ======================================================================<br>
-- SIEventBus.Add( SIEvents.on_player_joined_game , function( event )
-- 	if not SIGlobal then
-- 		return
-- 	end
-- 	local playerIndex = event.player_index
-- 	for index , funcData in pairs( SIEventBus.WaitFunctions.Functions ) do
-- 		local settings = SIGlobal.GetGlobalSettings( SIEventBus.Settings.Name )
-- 		local listeners = settings.WaitListeners[funcData.id]
-- 		if not listeners then
-- 			listeners = {}
-- 			settings.WaitListeners[funcData.id] = listeners
-- 		end
-- 		if not SITable.Has( listeners , playerIndex ) then
-- 			table.insert( listeners , playerIndex )
-- 			funcData.func( event , funcData.id )
-- 		end
-- 	end
-- end )
-- 
-- -- ======================================================================<br>
-- -- 指定伪异步操作数据包<br>
-- -- ======================================================================<br>
-- SIEventBus.Add( SIEvents.on_tick , function( event )
-- 	if not SIGlobal then
-- 		return
-- 	end
-- 	local tick = event.tick
-- 	local settings = SIGlobal.GetGlobalSettings( SIEventBus.Settings.Name )
-- 	local asyncDataList = settings.AsyncList[tick]
-- 	if asyncDataList then
-- 		for index , funcData in pairs( asyncDataList ) do
-- 			_G[funcData.funcName]( tick , funcData.data )
-- 		end
-- 		settings.AsyncList[tick] = nil
-- 	end
-- end )

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 内部函数 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================<br>
-- 框架内部函数 , 请勿在外部调用<br>
-- 注册一些需要持久化保存的数据<br>
-- ======================================================================<br>
---@return table -- 自身
function SIEventBus.InitSelf()
	if not SIGlobal then
		UseE( SIEventBus , "需要使用 SIGlobal 来读取和保存持久化数据" )
	end
	SIGlobal.CreateSettings( SIEventBus.Settings )
	return SIEventBus
end

-- ======================================================================<br>
-- 框架内部函数 , 请勿在外部调用<br>
-- 用于实现 nth 功能的事件函数<br>
-- ======================================================================<br>
---@param event table -- 事件参数
function SIEventBus.Inner_NTHFunction( event )
	for index , funcData in pairs( SIEventBus.NthFunctions[event.nth_tick].Functions ) do
		funcData.func( event , funcData.id )
	end
end

-- ======================================================================<br>
-- 框架内部函数 , 请勿在外部调用<br>
-- 用于实现事件功能的事件函数<br>
-- ======================================================================<br>
---@param event table -- 事件参数
function SIEventBus.Inner_EventFunction( event )
	for index , funcData in pairs( SIEventBus.EventList[event.name].Functions ) do
		funcData.func( event , funcData.id )
	end
end
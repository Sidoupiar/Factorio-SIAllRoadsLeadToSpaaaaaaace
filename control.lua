if not SIInstrumentMode then
	require( "utils" )
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 特殊结构 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 这是一个特殊结构<br>
-- 用于像 data 阶段的 SIGen 一样自动计算物品的 [ name ] 属性的值<br>
-- nameList 的格式 :<br>
-- {<br>
--     [SICommon.Types.类型1] =<br>
--     {<br>
--         原型数据ID1 = "原型数据别名1" ,<br>
--         原型数据ID2 = "原型数据别名2" ,<br>
--         ...<br>
--     } ,<br>
--     [SICommon.Types.类型2] =<br>
--     {<br>
--         原型数据ID1 = "原型数据别名1" ,<br>
--         原型数据ID2 = "原型数据别名2" ,<br>
--         ...<br>
--     } ,<br>
--     ...<br>
-- }<br>
-- 因为有些时候 , 一个功能包下的新增原型数据还是挺多的 , 而且大部分在 control 阶段都用不到 , 所以才把 [ name ] 属性的值的计算独立了出来<br>
-- 在这个函数中 , 默认使用 SIInit.CurrentConstantsData , 不建议在同一个功能包内多次使用 SIControl.Init 函数并混用多个 ConstantsData<br>
-- 如果原型数据没有别名 , 则都写成原型数据的 ID 即可<br>
-- ----------------------------------------
SIControl =
{
	Init = function( nameList )
		if SIInit.CurrentConstantsData then
			if not SIInit.CurrentConstantsData.raw then
				SIInit.CurrentConstantsData.raw = {}
			end
			for typeCode , prototypeNameList in pairs( nameList ) do
				if typeCode == "Styles" then
					local list = SIInit.CurrentConstantsData.raw.Styles
					if not list then
						list = {}
						SIInit.CurrentConstantsData.raw.Styles = list
					end
					if prototypeNameList then
						for styleID , styleName in pairs( prototypeNameList ) do
							list[styleID] = SIInit.CurrentConstantsData.ShowNamePrefix .. styleName:gsub( "_" , "-" )
						end
					end
				else
					local rawCode = SICommon.Types.Raw[typeCode]
					local list = SIInit.CurrentConstantsData.raw[rawCode]
					if not list then
						list = {}
						SIInit.CurrentConstantsData.raw[rawCode] = list
					end
					if prototypeNameList then
						for prototypeID , prototypeName in pairs( prototypeNameList ) do
							list[prototypeID] = SIInit.CurrentConstantsData.ShowNamePrefix .. SICommon.ShowNamePrefix[typeCode] .. prototypeName:gsub( "_" , "-" )
						end
					end
				end
			end
		end
	end
}

-- ------------------------------------------------------------------------------------------------
-- ----------- 初始化 -----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIInit
.AutoLoadState( SIInit.StateCodeDefine.Control )
.AutoLoad()
-- 如果你想在附属 MOD 中使用这个框架 , 则仅需在 settings.lua , data.lua , control.lua 中使用 SIInit.AutoLoad 函数即可 ( 不要在其他文件中使用 )
-- 具体请见 data.lua 中的注释
--
-- 另外由于不同的 MOD 之间 control 阶段都是独立的 , 因此 SIInit.AutoLoad 函数上面的代码需要照抄一份才能正常使用



-- ------------------------------------------------------------------------------------------------
-- ---------- 赞助信息 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

if SIUtils.Settings.ShowPatreon() then
	SIEventBus.Add( SIEvents.on_player_joined_game , function( event )
		game.get_player( event.player_index ).print{ "SIUtils.赞助信息" , "https://afdian.net/@Sidoupiar" } -- 爱发电页面
	end )
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 火星功能 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

NotClickList =
{
	{ "SIUtils.点了也没用1" } ,
	{ "SIUtils.点了也没用2" } ,
	{ "SIUtils.点了也没用3" } ,
	{ "SIUtils.点了也没用4" }
}
NotClickListSize = #NotClickList

function NotClick( playerIndex )
	local index = math.floor( math.random() * NotClickListSize ) + 1
	if index > 0 and index <= NotClickListSize then
		local player = game.get_player( playerIndex )
		if player and player.valid then
			player.print( NotClickList[index] , SICommon.Colors.PrintColor.ORANGE )
		end
	end
end
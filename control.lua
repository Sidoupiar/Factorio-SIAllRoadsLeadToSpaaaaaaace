if not SIInstrumentMode then
	require( "utils" )
end

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 特殊结构 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================<br>
-- 这是一个特殊结构<br>
-- 用于像 data 阶段的 SIGen 一样自动计算物品的 [ name ] 属性的值<br>
-- nameList 的格式 :<br>
-- {<br>
--     [SICommon.Types.类型1] =<br>
--     {<br>
--         原型数据ID1 = "原型数据Show1" ,<br>
--         原型数据ID2 = "原型数据Show2" ,<br>
--         ...<br>
--     } ,<br>
--     [SICommon.Types.类型2] =<br>
--     {<br>
--         原型数据ID1 = "原型数据Show1" ,<br>
--         原型数据ID2 = "原型数据Show2" ,<br>
--         ...<br>
--     } ,<br>
--     ...<br>
--     Styles =<br>
--     {<br>
--         GUI元素ID1 = "GUI元素Show1" ,<br>
--         GUI元素ID2 = "GUI元素Show2" ,<br>
--     }<br>
-- }<br>
-- 因为有些时候 , 一个功能模块下的新增原型数据还是挺多的 , 而且大部分在 control 阶段都用不到 , 所以才把 [ name ] 属性的值的计算独立了出来<br>
-- 在这个函数中 , 默认使用 SIInit.CurrentConstantsData , 不建议在同一个功能模块内多次使用 SIControl.Init 函数并混用多个 ConstantsData<br>
-- 如果原型数据没有别名 , 则都写成原型数据的 ID 即可<br>
-- ======================================================================<br>
---@class SIControl : SIBaseClass
SIControl =
{
	ID = "SIControl" ,
	Code = "SIControl" ,
	Show = "运行时" ,
	-- ======================================================================<br>
	-- 初始化基础数据<br>
	-- 创建的结构和 data 模块一致 , 都是 [ConstantsData].raw.[rawCode].[prototypeID]<br>
	-- ======================================================================<br>
	---@param nameList table
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
							list[prototypeID] = SIInit.CurrentConstantsData.CodeNamePrefix .. SICommon.CodeNamePrefix[typeCode] .. prototypeID:gsub( "_" , "-" )
						end
					end
				end
			end
		end
	end ,
	-- ======================================================================<br>
	-- 检测科技状态 , 如果科技状态不符合给定的要求 , 则立刻解锁科技<br>
	-- 单项版本<br>
	-- ======================================================================<br>
	-- technologyData 的格式 :<br>
	-- {<br>
	--     Name = "科技ID" , -- 科技的 name 值<br>
	--     NeedEnabled = true/false , -- 是否要求这个科技是可研究的状态<br>
	--     ResearchUnitCount = 1 , -- 需求的瓶子数量最大值<br>
	--     ResearchUnitEnergy = 1 , -- 每组瓶子研究的时间最大值<br>
	--     ResearchUnitIngredients = -- 瓶子种类限制 , 字典<br>
	--     {<br>
	--         瓶子ID1 = 数量限制1 ,<br>
	--         瓶子ID2 = 数量限制2 ,<br>
	--         ...<br>
	--     } ,<br>
	--     Prerequisites = -- 前置科技限制 , 这个科技只能有这些前置科技 , 数组<br>
	--     {<br>
	--         前置科技ID1 ,<br>
	--         前置科技ID2 ,<br>
	--         ...<br>
	--     }<br>
	-- }<br>
	-- ======================================================================<br>
	---@param force table
	---@param technologyData table
	ForceUnlockTechnology = function( force , technologyData )
		if not technologyData then
			return
		end
		local technology = force.technologies[technologyData.Name]
		if not technology or technology.researched then
			return
		end
		local technologyPrototype = technology.prototype
		if not technologyPrototype then
			return
		end
		if not technology.enabled and technologyData.NeedEnabled then
			technology.enabled = true
		end
		if technologyPrototype.research_unit_count > technologyData.ResearchUnitCount then
			technology.researched = true
			return
		end
		if technologyPrototype.research_unit_energy > technologyData.ResearchUnitEnergy then
			technology.researched = true
			return
		end
		if technologyPrototype.research_unit_ingredients and technologyData.ResearchUnitIngredients then
			for index , ingredientData in pairs( technologyPrototype.research_unit_ingredients ) do
				local unitAmount = technologyData.ResearchUnitIngredients[ingredientData.name]
				if not unitAmount or ingredientData.amount > unitAmount then
					technology.researched = true
					return
				end
			end
		end
		if technologyPrototype.prerequisites and technologyData.Prerequisites then
			for prerequisiteTechnologyName , prerequisiteTechnologyPrototype in pairs( technologyPrototype.prerequisites ) do
				if not SITable.Has( technologyData.Prerequisites , prerequisiteTechnologyName ) then
					technology.researched = true
					return
				end
			end
		end
	end ,
	-- ======================================================================<br>
	-- 检测科技状态 , 如果科技状态不符合给定的要求 , 则立刻解锁科技<br>
	-- 列表版本<br>
	-- ======================================================================<br>
	-- technologyList 的格式 :<br>
	-- {<br>
	--     technologyData1 ,<br>
	--     technologyData2 ,<br>
	--     ...<br>
	-- }<br>
	-- technologyData 的格式见上方 SIControl.ForceUnlockTechnology 函数的注释<br>
	-- ======================================================================<br>
	---@param force table
	---@param technologyList table
	ForceUnlockTechnologyList = function( force , technologyList )
		if not technologyList then
			return
		end
		for index , technologyData in pairs( technologyList ) do
			SIControl.ForceUnlockTechnology( force , technologyData )
		end
	end
}

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 初始化 ==========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIInit
.AutoLoadState( SIInit.StateCodeDefine.Control )
.AutoLoad()



-- 如果你想在附属 MOD 中使用这个框架 , 则仅需在 settings.lua , data.lua , control.lua 中使用 SIInit.AutoLoad 函数即可 ( 不要在其他文件中使用 )
-- 使用方法可以参考我做的其他附属 MOD
-- 具体请见 data.lua 中的注释
--
-- 另外由于不同的 MOD 之间 control 阶段都是独立的 , 因此 SIInit.AutoLoad 函数上面的代码需要照抄一份才能正常使用

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 提示信息 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIEventBus
.Add( SIEvents.on_player_joined_game , function( event , functionID )
	local playerIndex = event.player_index
	SIInit.ShowUnloadedPackageList( playerIndex )
end )

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 赞助信息 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

--if SIUtils.Settings.ShowPatreon() then
--	SIEventBus.Add( SIEvents.on_player_joined_game , function( event )
--		game.get_player( event.player_index ).print{ "SIUtils.赞助信息" , "https://afdian.net/@Sidoupiar" } -- 爱发电页面
--	end )
--end

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 火星功能 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SINotClickListSize = 8

-- ======================================================================<br>
---@param playerIndex integer
function NotClick( playerIndex )
	local index = math.floor( math.random() * SINotClickListSize ) + 1
	if index > 0 and index <= SINotClickListSize then
		local player = game.get_player( playerIndex )
		if player and player.valid then
			player.print( { "SIUtils.点了也没用" .. index } , SICommon.Colors.Print.ORANGE )
		end
	else
		local player = game.get_player( playerIndex )
		if player and player.valid then
			player.print( { "SIUtils.点了也没用1" } , SICommon.Colors.Print.ORANGE )
		end
	end
end
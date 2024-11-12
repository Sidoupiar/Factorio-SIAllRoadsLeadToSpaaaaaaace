---@class SIFinder : SIBaseClass
SIFinder =
{
	ID = "Finder" ,
	Code = "Finder" ,
	Show = "信息查询" ,
	InterfaceID = "SICore-Finder" ,
	Names =
	{
		Prefix = "SI核心-信息查询-" ,
		Frame = "SI核心-信息查询-窗口" ,
		Selector = "SI核心-信息查询-类型" ,
		Close = "SI核心-信息查询-关闭" ,
		ChooserPrefix = "SI核心-信息查询-选择-"
	} ,
	Settings =
	{
		Name = "Finder" ,
		Default =
		{
			frame = nil ,
			frameLocation = nil ,
			selector = nil ,
			chooser = nil ,
			chooserList = nil ,
			chooserLabel = nil ,
			listInput = nil ,
			listOutput = nil ,
			listTool = nil ,
			selectedIndex = nil
		}
	} ,
	DropDownTypes =
	{
		Item = 1 ,
		Fluid = 2 ,
		Entity = 3 ,
		Recipe = 4 ,
		Tile = 5 ,
		Equipment = 6
	} ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 窗口函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	OpenFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIFinder.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			SIFinder.CloseFrame( playerIndex )
		else
			local player = game.get_player( playerIndex )
			-- 获取拖动的物品
			local itemName = nil
			local itemStack = player.cursor_stack
			if itemStack and itemStack.valid_for_read then
				itemName = itemStack.prototype.name
			end
			-- 显示窗口
			local frame = SIElements.CreateFrame( player , settings ,
			{
				Name         = SIFinder.Names.Frame ,
				Close        = SIFinder.Names.Close ,
				Style        = SIConstants_Core.raw.Styles.Finder_Frame ,
				Title        = { "SICore.信息查询-窗口-标题" } ,
				TitleTooltip = { "SICore.信息查询-窗口-标题-提示" } ,
				UseTooltip   = { "SICore.信息查询-窗口-使用-提示" } ,
				CloseTooltip = { "SICore.信息查询-窗口-关闭-提示" }
			} )
			-- 第 1 层
			local selectedIndex = settings.selectedIndex
			if not selectedIndex or not SIFinder.ElementTypes[selectedIndex] or itemName then
				selectedIndex = SIFinder.DropDownTypes.Item
				settings.selectedIndex = selectedIndex
			end
			local flow1 = frame.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			-- 第 1.1 层
			settings.selector = flow1.add
			{
				type = "drop-down" ,
				name = SIFinder.Names.Selector ,
				caption = { "SICore.信息查询-窗口-选择查询类型" } ,
				tooltip = { "SICore.信息查询-窗口-选择查询类型-提示" } ,
				items = SIFinder.DropDownLocals ,
				selected_index = selectedIndex ,
				style = SIConstants_Core.raw.Styles.Finder_DropDown
			}
			-- 第 1.2 层
			local flow12 = flow1.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Finder_Flow }
			settings.chooserList = {}
			for dropDownType , index in pairs( SIFinder.DropDownTypes ) do
				local currentChooser = flow12.add{ type = "choose-elem-button" , name = SIFinder.Names.ChooserPrefix .. index , tooltip = { "SICore.信息查询-窗口-选择项目-提示" } , elem_type = SIFinder.ElementTypes[index] , style = SIConstants_Core.raw.Styles.Finder_Chooser }
				table.insert( settings.chooserList , currentChooser )
				if index == selectedIndex then
					settings.chooser = currentChooser
					currentChooser.visible = true
					if itemName then
						currentChooser.elem_value = itemName
					end
				else
					currentChooser.visible = false
				end
			end
			settings.chooserLabel = flow12.add{ type = "label" , caption = { "SICore.信息查询-窗口-选择项目-标签" , { "SICore.信息查询-窗口-选择项目-标签-无" } } , tooltip = { "SICore.信息查询-窗口-选择项目-左-提示" } , style = SIConstants_Core.raw.Styles.Finder_Label }
			-- 分隔
			frame.add{ type = "line" , direction = "horizontal" }
			-- 第 2 层
			local flow2 = frame.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
			-- 第 2.1 层
			local flow21 = flow2.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			flow21.add{ type = "label" , caption = { "SICore.信息查询-窗口-输入列表" } , style = SIConstants_Core.raw.Styles.Finder_Label }
			settings.listInput = flow21
			.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Common_ScrollPane }
			.add{ type = "table" , column_count = 1 , style = SIConstants_Core.raw.Styles.Common_List }
			-- 第 2.2 层
			local flow22 = flow2.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			flow22.add{ type = "label" , caption = { "SICore.信息查询-窗口-输出列表" } , style = SIConstants_Core.raw.Styles.Finder_Label }
			settings.listOutput = flow22
			.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Common_ScrollPane }
			.add{ type = "table" , column_count = 1 , style = SIConstants_Core.raw.Styles.Common_List }
			-- 第 2.3 层
			local flow23 = flow2.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			flow23.add{ type = "label" , caption = { "SICore.信息查询-窗口-工具列表" } , style = SIConstants_Core.raw.Styles.Finder_Label }
			settings.listTool = flow23
			.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Common_ScrollPane }
			.add{ type = "table" , column_count = 1 , style = SIConstants_Core.raw.Styles.Common_List }
			-- 根据设置更新控件
			SIFinder.FreshList( settings , itemName )
		end
	end ,
	CloseFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIFinder.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			settings.frame.destroy()
			settings.frame = nil
			settings.selector = nil
			settings.chooser = nil
			settings.chooserList = nil
			settings.chooserLabel = nil
			settings.listInput = nil
			settings.listOutput = nil
			settings.listTool = nil
		end
	end ,
	MoveFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIFinder.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			SIElements.SaveFrameLocation( settings )
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 控件函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	FreshList = function( settings , thingName )
		local selectedIndex = settings.selectedIndex
		local listInput = {}
		local listOutput = {}
		local listTool = {}
		if selectedIndex == SIFinder.DropDownTypes.Item then
			local itemName = thingName
			local item = itemName and prototypes.item[itemName] or nil
			settings.chooserLabel.caption = { "SICore.信息查询-窗口-选择项目-标签" , item and item.localised_name or { "SICore.信息查询-窗口-选择项目-标签-无" } }
			if itemName then
				-- 输入列表
				listInput.recipe = prototypes.get_recipe_filtered{ { filter = "has-ingredient-item" , elem_filters = { { filter = "name" , name = itemName } } } }
				-- 输出列表
				listOutput.recipe = prototypes.get_recipe_filtered{ { filter = "has-product-item" , elem_filters = { { filter = "name" , name = itemName } } } }
				-- 工具列表
			end
		elseif selectedIndex == SIFinder.DropDownTypes.Fluid then
			local fluidName = thingName
			local fluid = fluidName and prototypes.fluid[fluidName] or nil
			settings.chooserLabel.caption = { "SICore.信息查询-窗口-选择项目-标签" , fluid and fluid.localised_name or { "SICore.信息查询-窗口-选择项目-标签-无" } }
			if fluidName then
				-- 输入列表
				listInput.recipe = prototypes.get_recipe_filtered{ { filter = "has-ingredient-fluid" , elem_filters = { { filter = "name" , name = fluidName } } } }
				-- 输出列表
				listOutput.recipe = prototypes.get_recipe_filtered{ { filter = "has-product-fluid" , elem_filters = { { filter = "name" , name = fluidName } } } }
				-- 工具列表
			end
		elseif selectedIndex == SIFinder.DropDownTypes.Entity then
			local entityName = thingName
			local entity = entityName and prototypes.entity[entityName] or nil
			settings.chooserLabel.caption = { "SICore.信息查询-窗口-选择项目-标签" , entity and entity.localised_name or { "SICore.信息查询-窗口-选择项目-标签-无" } }
			-- 输入列表
			-- 输出列表
			-- 工具列表
		elseif selectedIndex == SIFinder.DropDownTypes.Recipe then
			local recipeName = thingName
			local recipe = recipeName and prototypes.recipe[recipeName] or nil
			settings.chooserLabel.caption = { "SICore.信息查询-窗口-选择项目-标签" , recipe and recipe.localised_name or { "SICore.信息查询-窗口-选择项目-标签-无" } }
			-- 输入列表
			-- 输出列表
			-- 工具列表
		elseif selectedIndex == SIFinder.DropDownTypes.Tile then
			local tileName = thingName
			local tile = tileName and prototypes.tile[tileName] or nil
			settings.chooserLabel.caption = { "SICore.信息查询-窗口-选择项目-标签" , tile and tile.localised_name or { "SICore.信息查询-窗口-选择项目-标签-无" } }
			-- 输入列表
			-- 输出列表
			-- 工具列表
		elseif selectedIndex == SIFinder.DropDownTypes.Equipment then
			local equipmentName = thingName
			local equipment = equipmentName and prototypes.equipment[equipmentName] or nil
			settings.chooserLabel.caption = { "SICore.信息查询-窗口-选择项目-标签" , equipment and equipment.localised_name or { "SICore.信息查询-窗口-选择项目-标签-无" } }
			-- 输入列表
			-- 输出列表
			-- 工具列表
		else
			settings.chooserLabel.caption = { "SICore.信息查询-窗口-选择项目-标签" , { "SICore.信息查询-窗口-选择项目-标签-无" } }
		end
		-- 更新输入列表
		settings.listInput.clear()
		if listInput.recipe and #listInput.recipe > 0 then
			for name , recipe in pairs( listInput.recipe ) do
				settings.listInput.add{ type = "label" , caption = SIFinder.MakeRecipeString( recipe ) , style = SIConstants_Core.raw.Styles.Finder_ListLabel }
			end
		else
			settings.listInput.add{ type = "label" , caption = { "SICore.信息查询-窗口-查询结果-无" } , style = SIConstants_Core.raw.Styles.Finder_ListLabel }
		end
		-- 更新输出列表
		settings.listOutput.clear()
		if listOutput.recipe and #listOutput.recipe > 0 then
			for name , recipe in pairs( listOutput.recipe ) do
				settings.listOutput.add{ type = "label" , caption = SIFinder.MakeRecipeString( recipe ) , style = SIConstants_Core.raw.Styles.Finder_ListLabel }
			end
		else
			settings.listOutput.add{ type = "label" , caption = { "SICore.信息查询-窗口-查询结果-无" } , style = SIConstants_Core.raw.Styles.Finder_ListLabel }
		end
		-- 更新工具列表
		settings.listTool.clear()
		if listTool.recipe and #listTool.recipe > 0 then
			for name , recipe in pairs( listTool.recipe ) do
				settings.listTool.add{ type = "label" , caption = SIFinder.MakeRecipeString( recipe ) , style = SIConstants_Core.raw.Styles.Finder_ListLabel }
			end
		else
			settings.listTool.add{ type = "label" , caption = { "SICore.信息查询-窗口-查询结果-无" } , style = SIConstants_Core.raw.Styles.Finder_ListLabel }
		end
	end ,
	-- ======================================================================<br>
	-- 这是一个内部函数 , 请勿外部调用<br>
	-- ======================================================================<br>
	MakeRecipeString = function( recipe )
		local input = ""
		local countInput = #recipe.ingredients
		for index , ingredient in pairs( recipe.ingredients ) do
			input = input .. "[" .. ingredient.type .. "=" .. ingredient.name .. "]" .. "×" .. ingredient.amount
			if index < countInput then
				input = input .. " + "
			end
		end
		if input:len() < 1 then
			input = "[item=" .. SIConstants_Core.raw.Items.IconEmpty .. "]"
		end
		local output = ""
		local countOutput = #recipe.products
		for index , product in pairs( recipe.products ) do
			output = output .. ( product.probability < 1 and "(" .. ( product.probability * 100 ) .. "%)" or "" ) .. "[" .. product.type .. "=" .. product.name .. "]" .. "×" .. ( product.amount and product.amount or product.amount_min .. "~" .. product.amount_max )
			if index < countOutput then
				output = output .. " + "
			end
		end
		return { "SICore.信息查询-窗口-查询结果" , input , output }
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 功能函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 事件函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	SelectElementType = function( playerIndex , selectedIndex )
		local settings = SIGlobal.GetPlayerSettings( SIFinder.Settings.Name , playerIndex )
		settings.selectedIndex = selectedIndex
		for index , currentChooser in pairs( settings.chooserList ) do
			if index == selectedIndex then
				currentChooser.visible = true
				settings.chooser = currentChooser
			else
				currentChooser.visible = false
			end
		end
		settings.chooser.elem_value = nil
		SIFinder.FreshList( settings )
	end ,
	FreshFrame = function( playerIndex , thingName )
		local settings = SIGlobal.GetPlayerSettings( SIFinder.Settings.Name , playerIndex )
		settings.chooser.elem_value = thingName
		SIFinder.FreshList( settings , thingName )
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 接口函数 - 窗口 =================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================<br>
	-- 打开指定玩家的信息查询窗口<br>
	-- ======================================================================<br>
	---@param playerIndex integer -- 玩家索引
	OpenFrameByPlayerIndex = function( playerIndex )
		SIFinder.OpenFrame( playerIndex )
	end ,

	-- ======================================================================<br>
	-- 关闭指定玩家的信息查询窗口<br>
	-- ======================================================================<br>
	---@param playerIndex integer -- 玩家索引
	CloseFrameByPlayerIndex = function( playerIndex )
		SIFinder.CloseFrame( playerIndex )
	end ,

	-- ======================================================================<br>
	-- 打开所有玩家的信息查询窗口<br>
	-- ======================================================================<br>
	OpenFrames = function()
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIFinder.Settings.Name ) ) do
			SIFinder.OpenFrame( playerIndex )
		end
	end ,

	-- ======================================================================<br>
	-- 关闭所有玩家的信息查询窗口<br>
	-- ======================================================================<br>
	CloseFrames = function()
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIFinder.Settings.Name ) ) do
			SIFinder.CloseFrame( playerIndex )
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 接口函数 - 信息查询 =============================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================<br>
	-- 打开窗口并查询给定的项目<br>
	-- ======================================================================<br>
	---@param playerIndex integer -- 玩家索引
	---@param type integer -- 查询的类型 , 是一个数字 , 可用值请见 SIFinder.DropDownTypes 的定义 , 无效值会被重新定义为 SIFinder.DropDownTypes.Item 的值
	---@param thingName string -- 查询的项目名称
	Find = function( playerIndex , type , thingName )
		local settings = SIGlobal.GetPlayerSettings( SIFinder.Settings.Name , playerIndex )
		if not settings.frame or not settings.frame.valid then
			SIFinder.OpenFrame( playerIndex )
		end
		local selectedIndex = SITable.Has( SIFinder.DropDownTypes , type ) and type or SIFinder.DropDownTypes.Item
		settings.selectedIndex = selectedIndex
		for index , currentChooser in pairs( settings.chooserList ) do
			if index == selectedIndex then
				currentChooser.visible = true
				settings.chooser = currentChooser
			else
				currentChooser.visible = false
			end
		end
		settings.chooser.elem_value = thingName
		SIFinder.FreshList( settings )
	end
}

SIFinder.DropDownLocals =
{
	[SIFinder.DropDownTypes.Item] = { "SICore.信息查询-窗口-查询物品" } ,
	[SIFinder.DropDownTypes.Fluid] = { "SICore.信息查询-窗口-查询流体" } ,
	[SIFinder.DropDownTypes.Entity] = { "SICore.信息查询-窗口-查询实体" } ,
	[SIFinder.DropDownTypes.Recipe] = { "SICore.信息查询-窗口-查询配方" } ,
	[SIFinder.DropDownTypes.Tile] = { "SICore.信息查询-窗口-查询地板" } ,
	[SIFinder.DropDownTypes.Equipment] = { "SICore.信息查询-窗口-查询模块" }
}
SIFinder.ElementTypes =
{
	[SIFinder.DropDownTypes.Item] = "item" ,
	[SIFinder.DropDownTypes.Fluid] = "fluid" ,
	[SIFinder.DropDownTypes.Entity] = "entity" ,
	[SIFinder.DropDownTypes.Recipe] = "recipe" ,
	[SIFinder.DropDownTypes.Tile] = "tile" ,
	[SIFinder.DropDownTypes.Equipment] = "equipment"
}

SIFinder.Names.ChooserPosition = #SIFinder.Names.ChooserPrefix + 1

SIFinder.Toolbar =
{
	ID = "SI核心-信息查询" ,
	Name = "信息查询" ,
	IconItemName = SIConstants_Core.raw.Items.IconFind ,
	LocalizedName = { "SICore.信息查询-工具栏-按钮" } ,
	LocalizedDescription = { "SICore.信息查询-工具栏-提示" } ,
	ActionRemoteInterfaceID = SIFinder.InterfaceID ,
	ActionRemoteFunctionName = "OpenFrameByPlayerIndex" ,
	Permission = nil ,
	Order = "SICore-Finder"
}
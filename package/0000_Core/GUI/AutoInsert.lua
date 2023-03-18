SIAutoInsert =
{
	ID = "AutoInsert" ,
	Name = "自动填充" ,
	InterfaceID = "SICore-AutoInsert" ,
	Names =
	{
		Prefix = "SI核心-自动填充-" ,
		Frame = "SI核心-自动填充-窗口" ,
		Close = "SI核心-自动填充-关闭" ,
		Add = "SI核心-自动填充-添加" ,
		Delete = "SI核心-自动填充-删除" ,
		TabPane = "SI核心-自动填充-分页面板" ,
		TabSettingsName = "SI核心-自动填充-设置名称" ,
		DefaultIndex = "SI核心-自动填充-默认选择" ,
		ListButtonPrefix = "SI核心-自动填充-列表定位按钮-" ,
		EnablePrefix = "SI核心-自动填充-启用功能-" ,
		InsertFuel_Entity_Prefix = "SI核心-自动填充-插入燃料-实体-" ,
		InsertFuel_Item_Prefix = "SI核心-自动填充-插入燃料-物品-" ,
		InsertFuel_Count_Prefix = "SI核心-自动填充-插入燃料-数量-" ,
		InsertAmmo_Entity_Prefix = "SI核心-自动填充-插入弹药-实体-" ,
		InsertAmmo_Item_Prefix = "SI核心-自动填充-插入弹药-物品-" ,
		InsertAmmo_Count_Prefix = "SI核心-自动填充-插入弹药-数量-"
	} ,
	Settings =
	{
		Name = "AutoInsert" ,
		Default =
		{
			frame = nil ,
			frameLocation = nil ,
			tabPane = nil ,
			TabList = {} ,
			PageList = {} ,
			ListButtons = {} ,
			Elements =
			{
				-- {
				-- 	-- 插入燃料
				-- 	InsertFuel_Enable = nil ,
				-- 	InsertFuel_Flow = nil ,
				-- 	InsertFuel_List = nil ,
				--	-- 插入弹药
				-- 	InsertAmmo_Enable = nil ,
				-- 	InsertAmmo_Flow = nil ,
				-- 	InsertAmmo_List = nil
				-- }
			} ,
			entities = nil ,
			tabSettingsIndex = 1 ,
			defaultIndex = 0 ,
			TabSettingsList = {}
		}
	} ,
	TabSettingsMaxCount = 8 ,
	DefaultTabSettings =
	{
		Name = nil ,
		-- 插入燃料
		InsertFuel =
		{
			Enable = false ,
			List = {} -- 键为选择的设备实体 , 值为物品名称列表 , 列表每一项都是一个配置 , 决定数量和插入方式
		} ,
		-- 插入弹药
		InsertAmmo =
		{
			Enable = false ,
			List = {} -- 键为选择的设备实体 , 值为物品名称列表 , 列表每一项都是一个配置 , 决定数量和插入方式
		}
	} ,
	ListButtonIcon =
	{
		InsertFuel   = SIConstants_Core.raw.Items.IconColorMeat ,
		InsertAmmo   = SIConstants_Core.raw.Items.IconColorRose
	} ,
	DefaultIndexText =
	{
		[1] = { "SICore.自动填充-窗口-选择-空" } ,
		[2] = { "SICore.自动填充-窗口-选择-默认" }
	} ,
	InsertFuel_Entity_Filters =
	{
		{
			filter = "type" ,
			type =
			{
				SICommon.Types.Entities.Machine ,
				SICommon.Types.Entities.Furnace ,
				SICommon.Types.Entities.Lab ,
				SICommon.Types.Entities.Mining ,
				SICommon.Types.Entities.Beacon ,
				SICommon.Types.Entities.Inserter ,
				SICommon.Types.Entities.Boiler ,
				SICommon.Types.Entities.BurnerGenerator ,
				SICommon.Types.Entities.Reactor ,
				SICommon.Types.Entities.Car ,
				SICommon.Types.Entities.SpiderVehicle ,
				SICommon.Types.Entities.WagonLocomotive
			} ,
			mode = SICommon.Flags.Condition.OR
		} ,
		{
			filter = "hidden" ,
			mode = SICommon.Flags.Condition.AND ,
			invert = true
		} ,
		{
			filter = "name" ,
			name = SIConstants_Core.raw.Entities.IconEmpty ,
			mode = SICommon.Flags.Condition.OR
		}
	} ,
	InsertFuel_Item_Filters = {} , -- 暂时不需要设置筛选器
	InsertAmmo_Entity_Filters =
	{
		{
			filter = "type" ,
			type =
			{
				SICommon.Types.Entities.TurretAmmo ,
				SICommon.Types.Entities.TurretArtillery ,
				SICommon.Types.Entities.Car ,
				SICommon.Types.Entities.SpiderVehicle ,
				SICommon.Types.Entities.WagonArtillery
			} ,
			mode = SICommon.Flags.Condition.OR
		} ,
		{
			filter = "hidden" ,
			mode = SICommon.Flags.Condition.AND ,
			invert = true
		} ,
		{
			filter = "name" ,
			name = SIConstants_Core.raw.Entities.IconEmpty ,
			mode = SICommon.Flags.Condition.OR
		}
	} ,
	InsertAmmo_Item_Filters =
	{
		{
			filter = "type" ,
			type = SICommon.Types.Items.Ammo ,
			mode = SICommon.Flags.Condition.OR
		}
	} ,
	InsertAmmo_ItemNamed_Filters = {} , -- 暂时不需要设置筛选器
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 窗口函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	OpenFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIAutoInsert.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			SIAutoInsert.CloseFrame( playerIndex )
		else
			local player = game.get_player( playerIndex )
			-- 显示窗口
			local frame = SIElements.CreateFrame( player , settings ,
			{
				Name         = SIAutoInsert.Names.Frame ,
				Close        = SIAutoInsert.Names.Close ,
				Style        = SIConstants_Core.raw.Styles.AutoInsert_Frame ,
				Title        = { "SICore.自动填充-窗口-标题" } ,
				TitleTooltip = { "SICore.自动填充-窗口-标题-提示" } ,
				UseTooltip   = { "SICore.自动填充-窗口-使用-提示" } ,
				CloseTooltip = { "SICore.自动填充-窗口-关闭-提示" } ,
				OtherButtons =
				{
					{
						Name = SIAutoInsert.Names.Add ,
						Item = SIConstants_Core.raw.Items.IconAdd ,
						Tooltip = { "SICore.自动填充-窗口-新增-提示" , SIAutoInsert.TabSettingsMaxCount }
					}
				}
			} )
			-- 整理数据
			local tabSettingsCount = #settings.TabSettingsList
			if tabSettingsCount < 1 then
				SIAutoInsert.CreateTabSettings( settings )
				tabSettingsCount = #settings.TabSettingsList
			end
			settings.tabSettingsIndex = SITools.AsNumberInt( settings.tabSettingsIndex , 1 , tabSettingsCount )
			-- 第 1 层
			settings.tabPane = frame.add{ type = "tabbed-pane" , name = SIAutoInsert.Names.TabPane , style = SIConstants_Core.raw.Styles.AutoInsert_TabPane }
			-- 根据设置更新控件
			SIAutoInsert.CreateTab( settings )
		end
	end ,
	CloseFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIAutoInsert.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			settings.entities = nil
			settings.frame.destroy()
			settings.frame = nil
			settings.tabPane = nil
			settings.TabList = {}
			settings.PageList = {}
			settings.ListButtons = {}
			settings.Elements = {}
		end
	end ,
	MoveFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIAutoInsert.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			SIElements.SaveFrameLocation( settings )
		end
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 控件函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	CreateTab = function( settings )
		local tabPane = settings.tabPane
		-- 清除已有分页
		for index , tab in pairs( settings.TabList ) do
			tabPane.remove_tab( tab )
			tab.destroy()
		end
		for index , page in pairs( settings.PageList ) do
			page.destroy()
		end
		settings.TabList = {}
		-- 增加新的分页
		for index , tabSettings in pairs( settings.TabSettingsList ) do
			-- 添加控件集合
			table.insert( settings.Elements , {} )
			-- 创建分页
			local tab = tabPane.add{ type = "tab" , caption = { "SICore.自动填充-窗口-分页标题" , tabSettings.Name } , tooltip = { "SICore.自动填充-窗口-分页标题-提示" , SIAutoInsert.TabSettingsMaxCount } }
			local page = SIAutoInsert.CreatePage( settings , index )
			tabPane.add_tab( tab , page )
			-- 保存信息
			table.insert( settings.TabList , tab )
			table.insert( settings.PageList , page )
		end
		settings.tabSettingsIndex = 1 -- 不知道为什么设置当前标签页就不好使 , 为了避免 bug 就先强制第 1 页了
		settings.tabPane.selected_tab_index = settings.tabSettingsIndex
		SIAutoInsert.FreshPage( settings )
	end ,
	-- ----------------------------------------
	-- 这是一个内部函数 , 请勿外部调用<br>
	-- ----------------------------------------
	CreatePage = function( settings , tabSettingsIndex )
		local page = settings.tabPane.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
		local elements = settings.Elements[tabSettingsIndex]
		-- ----------------------------------------
		-- 设置名称
		-- ----------------------------------------
		local nameFlow = page.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowCenterH }
		nameFlow.add{ type = "label" , caption = { "SICore.自动填充-窗口-名称" } , tooltip = { "SICore.自动填充-窗口-名称-提示" } , style = SIConstants_Core.raw.Styles.AutoInsert_Label }
		elements.TabSettingsName = nameFlow.add{ type = "textfield" , name = SIAutoInsert.Names.TabSettingsName , text = nil , tooltip = { "SICore.自动填充-窗口-名称-提示" } , style = SIConstants_Core.raw.Styles.AutoInsert_Text }
		nameFlow.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.AutoInsert_EmptyFlow }
		nameFlow.add{ type = "button" , name = SIAutoInsert.Names.Delete , caption = { "SICore.自动填充-窗口-删除" } , tooltip = { "SICore.自动填充-窗口-删除-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonRed }
		-- ----------------------------------------
		-- 默认选择
		-- ----------------------------------------
		local defaultIndexFlow = page.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowCenterH }
		defaultIndexFlow.add{ type = "label" , caption = { "SICore.自动填充-窗口-默认选择" } , tooltip = { "SICore.自动填充-窗口-默认选择-提示" } , style = SIConstants_Core.raw.Styles.AutoInsert_Label }
		elements.DefaultIndex = defaultIndexFlow.add
		{
			type = "drop-down" ,
			name = SIAutoInsert.Names.DefaultIndex ,
			caption = { "SICore.自动填充-窗口-默认选择" } ,
			tooltip = { "SICore.自动填充-窗口-默认选择-提示" } ,
			items = SIAutoInsert.DefaultIndexText ,
			selected_index = 1 ,
			style = SIConstants_Core.raw.Styles.AutoInsert_DropDown
		}
		-- ----------------------------------------
		-- 设置列表按钮
		-- ----------------------------------------
		local listButtonFlow = page.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.AutoInsert_ListButtonFlow }
		-- ----------------------------------------
		-- 设置列表
		-- ----------------------------------------
		local scroll = page.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Common_ScrollPane }
		local list = scroll.add{ type = "table" , column_count = 1 , style = SIConstants_Core.raw.Styles.Common_List }
		elements.Scroll = scroll
		-- ----------------------------------------
		-- 插入燃料
		-- ----------------------------------------
		elements.InsertFuel_Enable = list.add{ type = "checkbox" , name = SIAutoInsert.Names.EnablePrefix .. "InsertFuel_Flow" , state = false , caption = { "SICore.自动填充-窗口-插入燃料-启用" , { "SICore.自动填充-窗口-启用-未设置" } } , tooltip = { "SICore.自动填充-窗口-插入燃料-启用-提示" } , style = SIConstants_Core.raw.Styles.AutoInsert_ListCheck }
		local InsertFuel_Flow = list.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.AutoInsert_ListPanelFlow }
		elements.InsertFuel_Flow = InsertFuel_Flow
		elements.InsertFuel_List = InsertFuel_Flow.add{ type = "table" , column_count = 2 , style = SIConstants_Core.raw.Styles.AutoInsert_SubList }
		-- ----------------------------------------
		-- 插入弹药
		-- ----------------------------------------
		elements.InsertAmmo_Enable = list.add{ type = "checkbox" , name = SIAutoInsert.Names.EnablePrefix .. "InsertAmmo_Flow" , state = false , caption = { "SICore.自动填充-窗口-插入弹药-启用" , { "SICore.自动填充-窗口-启用-未设置" } } , tooltip = { "SICore.自动填充-窗口-插入弹药-启用-提示" } , style = SIConstants_Core.raw.Styles.AutoInsert_ListCheck }
		local InsertAmmo_Flow = list.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.AutoInsert_ListPanelFlow }
		elements.InsertAmmo_Flow = InsertAmmo_Flow
		elements.InsertAmmo_List = InsertAmmo_Flow.add{ type = "table" , column_count = 2 , style = SIConstants_Core.raw.Styles.AutoInsert_SubList }
		-- ----------------------------------------
		-- 插入空白区
		-- ----------------------------------------
		list.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.AutoInsert_BlankFlow }
		-- ----------------------------------------
		-- 创建滚动定位按钮
		-- ----------------------------------------
		for key , value in pairs( SIAutoInsert.DefaultTabSettings ) do
			if key ~= "Name" then
				local button = listButtonFlow.add{ type = "sprite-button" , name = SIAutoInsert.Names.ListButtonPrefix .. key .. "_Enable" , sprite = "item/" .. SIAutoInsert.ListButtonIcon[key] , tooltip = { "SICore.自动填充-窗口-列表定位按钮-提示" , { elements[key .. "_Enable"].caption[1] , "" } } , style = SIConstants_Core.raw.Styles.AutoInsert_ListButton }
				settings.ListButtons[key] = button
			end
		end
		-- 返回分页
		return page
	end ,
	FreshPage = function( settings )
		local tabSettingsIndex = settings.tabSettingsIndex
		local tabSettings = settings.TabSettingsList[tabSettingsIndex]
		local elements = settings.Elements[tabSettingsIndex]
		-- ----------------------------------------
		-- 设置名称
		-- ----------------------------------------
		elements.TabSettingsName.text = tabSettings.Name
		-- ----------------------------------------
		-- 默认选择
		-- ----------------------------------------
		elements.DefaultIndex.selected_index = settings.defaultIndex == tabSettingsIndex and 2 or 1
		-- ----------------------------------------
		-- 插入燃料
		-- ----------------------------------------
		elements.InsertFuel_Enable.state = tabSettings.InsertFuel.Enable
		elements.InsertFuel_Flow.visible = tabSettings.InsertFuel.Enable
		SIAutoInsert.FreshPage_InsertFuel( settings , tabSettings , elements )
		-- ----------------------------------------
		-- 插入弹药
		-- ----------------------------------------
		elements.InsertAmmo_Enable.state = tabSettings.InsertAmmo.Enable
		elements.InsertAmmo_Flow.visible = tabSettings.InsertAmmo.Enable
		SIAutoInsert.FreshPage_InsertAmmo( settings , tabSettings , elements )
	end ,
	FreshPage_InsertFuel = function( settings , tabSettings , elements )
		-- 更新说明
		elements.InsertFuel_Enable.caption = { "SICore.自动填充-窗口-插入燃料-启用" , { SITable.Size( tabSettings.InsertFuel.List ) > 0 and "SICore.自动填充-窗口-启用-已设置" or "SICore.自动填充-窗口-启用-未设置" } }
		-- 清空列表
		local list = elements.InsertFuel_List
		list.clear()
		-- 重建列表
		for entityName , itemDataList in pairs( tabSettings.InsertFuel.List ) do
			local entityPrototype = game.entity_prototypes[entityName]
			if entityPrototype then
				list.add
				{
					type = "choose-elem-button" ,
					name = SIAutoInsert.Names.InsertFuel_Entity_Prefix .. entityName ,
					tooltip = { "SICore.自动填充-窗口-插入燃料-实体-提示" , entityPrototype.localised_name } ,
					elem_type = "entity" ,
					entity = entityName ,
					elem_filters = SIAutoInsert.InsertFuel_Entity_Filters ,
					style = SIConstants_Core.raw.Styles.AutoInsert_ListChooser
				}
				local subList = list.add{ type = "table" , column_count = 5 , style = SIConstants_Core.raw.Styles.AutoInsert_SelectList }
				if entityPrototype.burner_prototype then
					local fuelFilter = SIUtils.table.deepcopy( SIAutoInsert.InsertFuel_Item_Filters )
					for categoryName , value in pairs( entityPrototype.burner_prototype.fuel_categories ) do
						table.insert( fuelFilter ,
						{
							filter = "fuel-category" ,
							["fuel-category"] = categoryName ,
							mode = SICommon.Flags.Condition.OR
						} )
					end
					for itemDataIndex = 1 , entityPrototype.burner_prototype.fuel_inventory_size , 1 do
						local itemData = itemDataList[itemDataIndex]
						if not itemData then
							itemData = {}
							itemDataList[itemDataIndex] = itemData
						end
						local itemTooltip = nil
						local itemName = itemData.ItemName
						if itemName then
							local itemPrototype = game.item_prototypes[itemName]
							if itemPrototype then
								itemTooltip = { "SICore.自动填充-窗口-插入燃料-物品-提示" , itemPrototype.localised_name }
							else
								itemTooltip = { "SICore.自动填充-窗口-插入燃料-物品-空-提示" , itemName }
								itemName = SIConstants_Core.raw.Items.IconEmpty
							end
						else
							itemTooltip = { "SICore.自动填充-窗口-插入燃料-物品-选择-提示" }
						end
						subList.add
						{
							type = "choose-elem-button" ,
							name = SIAutoInsert.Names.InsertFuel_Item_Prefix .. itemDataIndex .. "_" .. entityName ,
							tooltip = itemTooltip ,
							elem_type = "item" ,
							item = itemName ,
							elem_filters = fuelFilter ,
							style = SIConstants_Core.raw.Styles.AutoInsert_ListChooser
						}
						subList.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.AutoInsert_ListEmptyFlow }
						subList.add{ type = "label" , caption = { "SICore.自动填充-窗口-插入燃料-数量" } , tooltip = { "SICore.自动填充-窗口-插入燃料-数量-提示" } , style = SIConstants_Core.raw.Styles.AutoInsert_ListLabel }
						subList.add{ type = "textfield" , name = SIAutoInsert.Names.InsertFuel_Count_Prefix .. itemDataIndex .. "_" .. entityName , text = tostring( itemData.Count or 1 ) , numeric = true , tooltip = { "SICore.自动填充-窗口-插入燃料-数量-提示" } , style = SIConstants_Core.raw.Styles.AutoInsert_ListText }
						subList.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.AutoInsert_ListEmptyFlow }
					end
				end
			else
				list.add
				{
					type = "choose-elem-button" ,
					name = SIAutoInsert.Names.InsertFuel_Entity_Prefix .. entityName ,
					tooltip = { "SICore.自动填充-窗口-插入燃料-实体-空-提示" , entityName } ,
					elem_type = "entity" ,
					entity = SIConstants_Core.raw.Entities.IconEmpty ,
					elem_filters = SIAutoInsert.InsertFuel_Entity_Filters ,
					style = SIConstants_Core.raw.Styles.AutoInsert_ListChooser
				}
				local subList = list.add{ type = "table" , column_count = 5 , style = SIConstants_Core.raw.Styles.AutoInsert_SelectList }
				local fuelFilter = SIUtils.table.deepcopy( SIAutoInsert.InsertFuel_Item_Filters )
				table.insert( fuelFilter ,
				{
					filter = "fuel-category" ,
					["fuel-category"] = "chemical" ,
					mode = SICommon.Flags.Condition.OR
				} )
				for itemDataIndex , itemData in pairs( itemDataList ) do
					local itemTooltip = nil
					local itemName = itemData.ItemName
					if itemName then
						local itemPrototype = game.item_prototypes[itemName]
						if itemPrototype then
							itemTooltip = { "SICore.自动填充-窗口-插入燃料-物品-提示" , itemPrototype.localised_name }
						else
							itemTooltip = { "SICore.自动填充-窗口-插入燃料-物品-空-提示" , itemName }
							itemName = SIConstants_Core.raw.Items.IconEmpty
						end
					else
						itemTooltip = { "SICore.自动填充-窗口-插入燃料-物品-选择-提示" }
					end
					subList.add
					{
						type = "choose-elem-button" ,
						name = SIAutoInsert.Names.InsertFuel_Item_Prefix .. itemDataIndex .. "_" .. entityName ,
						tooltip = itemTooltip ,
						elem_type = "item" ,
						item = itemName ,
						elem_filters = fuelFilter ,
						style = SIConstants_Core.raw.Styles.AutoInsert_ListChooser
					}
					subList.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.AutoInsert_ListEmptyFlow }
					subList.add{ type = "label" , caption = { "SICore.自动填充-窗口-插入燃料-数量" } , tooltip = { "SICore.自动填充-窗口-插入燃料-数量-提示" } , style = SIConstants_Core.raw.Styles.AutoInsert_ListLabel }
					subList.add{ type = "textfield" , name = SIAutoInsert.Names.InsertFuel_Count_Prefix .. itemDataIndex .. "_" .. entityName , text = tostring( itemData.Count or 1 ) , numeric = true , tooltip = { "SICore.自动填充-窗口-插入燃料-数量-提示" } , style = SIConstants_Core.raw.Styles.AutoInsert_ListText }
					subList.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.AutoInsert_ListEmptyFlow }
				end
			end
		end
		list.add
		{
			type = "choose-elem-button" ,
			name = SIAutoInsert.Names.InsertFuel_Entity_Prefix ,
			tooltip = { "SICore.自动填充-窗口-插入燃料-实体-选择-提示" } ,
			elem_type = "entity" ,
			entity = nil ,
			elem_filters = SIAutoInsert.InsertFuel_Entity_Filters ,
			style = SIConstants_Core.raw.Styles.AutoInsert_ListChooser
		}
	end ,
	FreshPage_InsertAmmo = function( settings , tabSettings , elements )
		-- 更新说明
		elements.InsertAmmo_Enable.caption = { "SICore.自动填充-窗口-插入弹药-启用" , { SITable.Size( tabSettings.InsertAmmo.List ) > 0 and "SICore.自动填充-窗口-启用-已设置" or "SICore.自动填充-窗口-启用-未设置" } }
		-- 清空列表
		local list = elements.InsertAmmo_List
		list.clear()
		-- 重建列表
		for entityName , itemDataList in pairs( tabSettings.InsertAmmo.List ) do
			local entityPrototype = game.entity_prototypes[entityName]
			if entityPrototype then
				list.add
				{
					type = "choose-elem-button" ,
					name = SIAutoInsert.Names.InsertAmmo_Entity_Prefix .. entityName ,
					tooltip = { "SICore.自动填充-窗口-插入弹药-实体-提示" , entityPrototype.localised_name } ,
					elem_type = "entity" ,
					entity = entityName ,
					elem_filters = SIAutoInsert.InsertAmmo_Entity_Filters ,
					style = SIConstants_Core.raw.Styles.AutoInsert_ListChooser
				}
				local type = entityPrototype.type
				local maxAmmoSize = 0
				if type == SICommon.Types.Entities.TurretAmmo then
					maxAmmoSize = entityPrototype.get_inventory_size( defines.inventory.turret_ammo )
				elseif type == SICommon.Types.Entities.TurretArtillery then
					maxAmmoSize = entityPrototype.get_inventory_size( defines.inventory.artillery_turret_ammo )
				elseif type == SICommon.Types.Entities.Car then
					maxAmmoSize = entityPrototype.get_inventory_size( defines.inventory.car_ammo )
				elseif type == SICommon.Types.Entities.SpiderVehicle then
					maxAmmoSize = entityPrototype.get_inventory_size( defines.inventory.spider_ammo )
				elseif type == SICommon.Types.Entities.WagonArtillery then
					maxAmmoSize = entityPrototype.get_inventory_size( defines.inventory.artillery_wagon_ammo )
				end
				local subList = list.add{ type = "table" , column_count = 6 , style = SIConstants_Core.raw.Styles.AutoInsert_SelectList }
				for itemDataIndex = 1 , maxAmmoSize , 1 do
					local itemData = itemDataList[itemDataIndex]
					if not itemData then
						itemData = {}
						itemDataList[itemDataIndex] = itemData
					end
					local ammoCategories = nil
					local weaponTooltip = nil
					local weapon = nil
					if type == SICommon.Types.Entities.TurretAmmo then
						ammoCategories = entityPrototype.attack_parameters.ammo_categories or {}
						if entityPrototype.attack_parameters.ammo_type and entityPrototype.attack_parameters.ammo_type.category then
							table.insert( ammoCategories , entityPrototype.attack_parameters.ammo_type.category )
						end
						weaponTooltip = { "SICore.自动填充-窗口-插入弹药-武器-提示" , entityPrototype.localised_name }
						weapon = game.item_prototypes[entityName] and entityName or SIConstants_Core.raw.Items.IconEmpty
					else
						local weaponPrototype = entityPrototype.indexed_guns[itemDataIndex]
						ammoCategories = weaponPrototype.attack_parameters.ammo_categories or {}
						if weaponPrototype.attack_parameters.ammo_type and weaponPrototype.attack_parameters.ammo_type.category then
							table.insert( ammoCategories , weaponPrototype.attack_parameters.ammo_type.category )
						end
						if not weaponPrototype.name then
							weaponTooltip = { "SICore.自动填充-窗口-插入弹药-武器-提示" , entityPrototype.localised_name }
							weapon = SIConstants_Core.raw.Items.IconEmpty
						else
							weaponTooltip = { "SICore.自动填充-窗口-插入弹药-武器-提示" , weaponPrototype.localised_name }
							weapon = weaponPrototype.name
						end
					end
					local weaponChooser = subList.add
					{
						type = "choose-elem-button" ,
						tooltip = weaponTooltip ,
						elem_type = "item" ,
						item = weapon ,
						style = SIConstants_Core.raw.Styles.AutoInsert_ListChooser
					}
					weaponChooser.enabled = false
					local itemTooltip = nil
					local itemName = itemData.ItemName
					if itemName then
						local itemPrototype = game.item_prototypes[itemName]
						if itemPrototype then
							itemTooltip = { "SICore.自动填充-窗口-插入弹药-物品-提示" , itemPrototype.localised_name }
						else
							itemTooltip = { "SICore.自动填充-窗口-插入弹药-物品-空-提示" , itemName }
							itemName = SIConstants_Core.raw.Items.IconEmpty
						end
					else
						itemTooltip = { "SICore.自动填充-窗口-插入弹药-物品-选择-提示" }
					end
					local filter = SIUtils.table.deepcopy( SIAutoInsert.InsertAmmo_ItemNamed_Filters )
					for ammoName , ammoPrototype in pairs( game.get_filtered_item_prototypes( SIAutoInsert.InsertAmmo_Item_Filters ) ) do
						if SITable.Has( ammoCategories , ammoPrototype.get_ammo_type( "default" ).category ) then
							table.insert( filter ,
							{
								filter = "name" ,
								name = ammoName ,
								mode = SICommon.Flags.Condition.OR
							} )
						end
					end
					subList.add
					{
						type = "choose-elem-button" ,
						name = SIAutoInsert.Names.InsertAmmo_Item_Prefix .. itemDataIndex .. "_" .. entityName ,
						tooltip = itemTooltip ,
						elem_type = "item" ,
						item = itemName ,
						elem_filters = filter ,
						style = SIConstants_Core.raw.Styles.AutoInsert_ListChooser
					}
					subList.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.AutoInsert_ListEmptyFlow }
					subList.add{ type = "label" , caption = { "SICore.自动填充-窗口-插入弹药-数量" } , tooltip = { "SICore.自动填充-窗口-插入弹药-数量-提示" } , style = SIConstants_Core.raw.Styles.AutoInsert_ListLabel }
					subList.add{ type = "textfield" , name = SIAutoInsert.Names.InsertAmmo_Count_Prefix .. itemDataIndex .. "_" .. entityName , text = tostring( itemData.Count or 1 ) , numeric = true , tooltip = { "SICore.自动填充-窗口-插入弹药-数量-提示" } , style = SIConstants_Core.raw.Styles.AutoInsert_ListText }
					subList.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.AutoInsert_ListEmptyFlow }
				end
			else
				list.add
				{
					type = "choose-elem-button" ,
					name = SIAutoInsert.Names.InsertAmmo_Entity_Prefix .. entityName ,
					tooltip = { "SICore.自动填充-窗口-插入弹药-实体-空-提示" , entityName } ,
					elem_type = "entity" ,
					entity = SIConstants_Core.raw.Entities.IconEmpty ,
					elem_filters = SIAutoInsert.InsertAmmo_Entity_Filters ,
					style = SIConstants_Core.raw.Styles.AutoInsert_ListChooser
				}
				local subList = list.add{ type = "table" , column_count = 6 , style = SIConstants_Core.raw.Styles.AutoInsert_SelectList }
				for itemDataIndex , itemData in pairs( itemDataList ) do
					local weaponChooser = subList.add
					{
						type = "choose-elem-button" ,
						tooltip = { "SICore.自动填充-窗口-插入弹药-武器-空-提示" , entityName } ,
						elem_type = "item" ,
						item = SIConstants_Core.raw.Items.IconEmpty ,
						style = SIConstants_Core.raw.Styles.AutoInsert_ListChooser
					}
					weaponChooser.enabled = false
					local itemTooltip = nil
					local itemName = itemData.ItemName
					if itemName then
						local itemPrototype = game.item_prototypes[itemName]
						if itemPrototype then
							itemTooltip = { "SICore.自动填充-窗口-插入弹药-物品-提示" , itemPrototype.localised_name }
						else
							itemTooltip = { "SICore.自动填充-窗口-插入弹药-物品-空-提示" , itemName }
							itemName = SIConstants_Core.raw.Items.IconEmpty
						end
					else
						itemTooltip = { "SICore.自动填充-窗口-插入弹药-物品-选择-提示" }
					end
					subList.add
					{
						type = "choose-elem-button" ,
						name = SIAutoInsert.Names.InsertAmmo_Item_Prefix .. itemDataIndex .. "_" .. entityName ,
						tooltip = itemTooltip ,
						elem_type = "item" ,
						item = itemName ,
						elem_filters = SIAutoInsert.InsertAmmo_Item_Filters ,
						style = SIConstants_Core.raw.Styles.AutoInsert_ListChooser
					}
					subList.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.AutoInsert_ListEmptyFlow }
					subList.add{ type = "label" , caption = { "SICore.自动填充-窗口-插入弹药-数量" } , tooltip = { "SICore.自动填充-窗口-插入弹药-数量-提示" } , style = SIConstants_Core.raw.Styles.AutoInsert_ListLabel }
					subList.add{ type = "textfield" , name = SIAutoInsert.Names.InsertAmmo_Count_Prefix .. itemDataIndex .. "_" .. entityName , text = tostring( itemData.Count or 1 ) , numeric = true , tooltip = { "SICore.自动填充-窗口-插入弹药-数量-提示" } , style = SIConstants_Core.raw.Styles.AutoInsert_ListText }
					subList.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.AutoInsert_ListEmptyFlow }
				end
			end
		end
		list.add
		{
			type = "choose-elem-button" ,
			name = SIAutoInsert.Names.InsertAmmo_Entity_Prefix ,
			tooltip = { "SICore.自动填充-窗口-插入弹药-实体-选择-提示" } ,
			elem_type = "entity" ,
			entity = nil ,
			elem_filters = SIAutoInsert.InsertAmmo_Entity_Filters ,
			style = SIConstants_Core.raw.Styles.AutoInsert_ListChooser
		}
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 功能函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	CreateTabSettings = function( settings )
		local tabSettingsCount = #settings.TabSettingsList
		if tabSettingsCount < SIAutoInsert.TabSettingsMaxCount then
			local tabSettings = SIUtils.table.deepcopy( SIAutoInsert.DefaultTabSettings )
			tabSettings.Name = tostring( tabSettingsCount + 1 )
			table.insert( settings.TabSettingsList , tabSettings )
		end
	end ,
	DeleteTabSettings = function( settings )
		local tabSettingsCount = #settings.TabSettingsList
		if tabSettingsCount > 0 then
			local tabSettingsIndex = SITools.AsNumberInt( settings.tabSettingsIndex , 1 , SIAutoInsert.TabSettingsMaxCount )
			table.remove( settings.TabSettingsList , tabSettingsIndex )
			tabSettingsCount = #settings.TabSettingsList
			if tabSettingsCount < 1 then
				SIAutoInsert.CreateTabSettings( settings )
				tabSettingsCount = #settings.TabSettingsList
			end
			settings.tabSettingsIndex = SITools.AsNumberInt( tabSettingsIndex , 1 , tabSettingsCount )
			settings.defaultIndex1 = tabSettingsIndex == settings.defaultIndex1 and 0 or tabSettingsIndex < settings.defaultIndex1 and SITools.AsNumberInt( settings.defaultIndex1 - 1 , 1 , tabSettingsCount ) or settings.defaultIndex1
			settings.defaultIndex2 = tabSettingsIndex == settings.defaultIndex2 and 0 or tabSettingsIndex < settings.defaultIndex2 and SITools.AsNumberInt( settings.defaultIndex2 - 1 , 1 , tabSettingsCount ) or settings.defaultIndex2
			settings.defaultIndex3 = tabSettingsIndex == settings.defaultIndex3 and 0 or tabSettingsIndex < settings.defaultIndex3 and SITools.AsNumberInt( settings.defaultIndex3 - 1 , 1 , tabSettingsCount ) or settings.defaultIndex3
			settings.defaultIndex4 = tabSettingsIndex == settings.defaultIndex4 and 0 or tabSettingsIndex < settings.defaultIndex4 and SITools.AsNumberInt( settings.defaultIndex4 - 1 , 1 , tabSettingsCount ) or settings.defaultIndex4
		else
			SIAutoInsert.CreateTabSettings( settings )
			settings.tabSettingsIndex = 1
			settings.defaultIndex1 = 0
			settings.defaultIndex2 = 0
			settings.defaultIndex3 = 0
			settings.defaultIndex4 = 0
		end
	end ,
	EffectTabSettings = function( settings , tabSettingsIndex )
		local player = game.get_player( settings.playerIndex )
		local playerInventory = player.get_main_inventory()
		local tabSettings = settings.TabSettingsList[tabSettingsIndex]
		for index , entity in pairs( settings.entities ) do
			local force = entity.force
			local surface = entity.surface
			local entityName = entity.name
			local entityPrototype = entity.prototype
			local type = entityPrototype.type
			-- ----------------------------------------
			-- 插入燃料
			-- ----------------------------------------
			if tabSettings.InsertFuel.Enable then
				local insertFuelList = tabSettings.InsertFuel.List[entityName]
				if insertFuelList then
					local inventory = entity.get_fuel_inventory()
					-- 判断存储空间
					if inventory then
						for slotIndex , itemData in pairs( insertFuelList ) do
							local itemName = itemData.ItemName
							local itemPrototype = game.item_prototypes[itemName]
							-- 判断燃料物品是否存在
							if itemName and itemPrototype then
								local hasCount = playerInventory.get_item_count( itemName )
								-- 判断玩家背包内的燃料物品数量
								if hasCount > 0 then
									local currentItemStack = inventory[slotIndex]
									-- 判断指定空间内是否可以填充指定种类的燃料物品
									if not currentItemStack.valid_for_read or currentItemStack.name == itemName then
										local currentCount = currentItemStack.valid_for_read and currentItemStack.count or 0
										-- 计算可以填充的数量
										local count = math.min( math.max( ( itemData.Count or 1 ) - currentCount , 0 ) , itemPrototype.stack_size )
										count = math.min( count , hasCount )
										if count > 0 then
											-- 填充燃料物品
											if currentItemStack.valid_for_read then
												currentItemStack.count = currentItemStack.count + count
											else
												currentItemStack.set_stack{ name = itemName , count = count }
											end
											playerInventory.remove{ name = itemName , count = count }
										end
									end
								end
							end
						end
					end
				end
			end
			-- ----------------------------------------
			-- 插入弹药
			-- ----------------------------------------
			if tabSettings.InsertAmmo.Enable then
				local insertAmmoList = tabSettings.InsertAmmo.List[entityName]
				if insertAmmoList then
					local inventory = nil
					if type == SICommon.Types.Entities.TurretAmmo then
						inventory = entity.get_inventory( defines.inventory.turret_ammo )
					elseif type == SICommon.Types.Entities.TurretArtillery then
						inventory = entity.get_inventory( defines.inventory.artillery_turret_ammo )
					elseif type == SICommon.Types.Entities.Car then
						inventory = entity.get_inventory( defines.inventory.car_ammo )
					elseif type == SICommon.Types.Entities.SpiderVehicle then
						inventory = entity.get_inventory( defines.inventory.spider_ammo )
					elseif type == SICommon.Types.Entities.WagonArtillery then
						inventory = entity.get_inventory( defines.inventory.artillery_wagon_ammo )
					end
					if inventory then
						for slotIndex , itemData in pairs( insertAmmoList ) do
							local itemName = itemData.ItemName
							local itemPrototype = game.item_prototypes[itemName]
							-- 判断弹药物品是否存在
							if itemName and itemPrototype then
								local hasCount = playerInventory.get_item_count( itemName )
								-- 判断玩家背包内的弹药物品数量
								if hasCount > 0 then
									local currentItemStack = inventory[slotIndex]
									-- 判断指定空间内是否可以填充指定种类的弹药物品
									if not currentItemStack.valid_for_read or currentItemStack.valid_for_read and currentItemStack.name == itemName then
										local currentCount = currentItemStack.valid_for_read and currentItemStack.count or 0
										-- 计算可以填充的数量
										local count = math.min( math.max( ( itemData.Count or 1 ) - currentCount , 0 ) , itemPrototype.stack_size )
										count = math.min( count , hasCount )
										if count > 0 then
											-- 填充燃料物品
											if currentItemStack.valid_for_read then
												currentItemStack.count = currentItemStack.count + count
											else
												currentItemStack.set_stack{ name = itemName , count = count }
											end
											playerInventory.remove{ name = itemName , count = count }
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 事件函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	Out_AddTabSettings = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIAutoInsert.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			SIAutoInsert.CreateTabSettings( settings )
			SIAutoInsert.CreateTab( settings )
		end
	end ,
	Out_DeleteTabSettings = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIAutoInsert.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			SIAutoInsert.DeleteTabSettings( settings )
			SIAutoInsert.CreateTab( settings )
		end
	end ,
	SwitchTab = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIAutoInsert.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			local tabSettingsIndex = settings.tabPane.selected_tab_index or 1
			settings.tabSettingsIndex = SITools.AsNumber( tabSettingsIndex , 1 , #settings.TabList )
			SIAutoInsert.FreshPage( settings )
		end
	end ,
	ListScroll = function( playerIndex , name )
		local settings = SIGlobal.GetPlayerSettings( SIAutoInsert.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			local tabSettingsIndex = settings.tabSettingsIndex
			local key = name:sub( SIAutoInsert.Names.ListButtonPosition )
			settings.Elements[tabSettingsIndex].Scroll.scroll_to_element( settings.Elements[tabSettingsIndex][key] , "top-third" )
		end
	end ,
	EnableFunction = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIAutoInsert.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			local tabSettingsIndex = settings.tabSettingsIndex
			local key = name:sub( SIAutoInsert.Names.EnablePosition )
			local flow = settings.Elements[tabSettingsIndex][key]
			if flow then
				flow.visible = element.state
			end
			-- 保存功能的启用状态
			key = key:sub( 1 , key:find( "_" ) - 1 )
			local tabSettings = settings.TabSettingsList[tabSettingsIndex]
			tabSettings[key].Enable = element.state
		end
	end ,
	Set_TabSettingsName = function( playerIndex , element )
		local settings = SIGlobal.GetPlayerSettings( SIAutoInsert.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			local tabSettingsIndex = settings.tabSettingsIndex
			settings.TabList[tabSettingsIndex].caption = { "SICore.自动填充-窗口-分页标题" , element.text }
			-- 保存 [设置名称] 复选框的值
			local tabSettings = settings.TabSettingsList[tabSettingsIndex]
			tabSettings.Name = element.text
		end
	end ,
	Set_DefaultIndex = function( playerIndex , element )
		local settings = SIGlobal.GetPlayerSettings( SIAutoInsert.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			local selectedIndex = element.selected_index
			if not selectedIndex then
				element.selected_index = 1
				selectedIndex = 1
			end
			local tabSettingsIndex = settings.tabSettingsIndex
			-- 清除原有默认选择值
			if settings.defaultIndex == tabSettingsIndex then
				settings.defaultIndex = 0
			end
			-- 设置新的默认选择值
			if selectedIndex == 2 then
				settings.defaultIndex = tabSettingsIndex
			end
		end
	end ,
	Set_InsertFuel_Entity = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIAutoInsert.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [插入燃料-实体] 选择的实体
			local selectEntityName = element.elem_value
			local tabSettingsIndex = settings.tabSettingsIndex
			local tabSettings = settings.TabSettingsList[tabSettingsIndex]
			local itemDataList = tabSettings.InsertFuel.List
			local entityName = name:sub( SIAutoInsert.Names.InsertFuel_Entity_Position )
			if itemDataList[entityName] then
				if entityName == selectEntityName then
					return
				else
					if selectEntityName == nil then
						itemDataList[entityName] = nil
					else
						local newItemDataList = {}
						for innerEntityName , itemData in pairs( itemDataList ) do
							if entityName == innerEntityName then
								newItemDataList[selectEntityName] = {}
							else
								newItemDataList[innerEntityName] = itemData
							end
						end
						tabSettings.InsertFuel.List = newItemDataList
					end
				end
			else
				if selectEntityName == nil then
					return
				end
				if itemDataList[selectEntityName] then
					SIPrint.Warning( playerIndex , { "SICore.自动填充-提示-插入燃料-已存在" , selectEntityName , game.entity_prototypes[selectEntityName].localised_name } )
					element.elem_value = nil
					return
				end
				itemDataList[selectEntityName] = {}
			end
			SIAutoInsert.FreshPage_InsertFuel( settings , tabSettings , settings.Elements[tabSettingsIndex] )
		end
	end ,
	Set_InsertFuel_Item = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIAutoInsert.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			local selectItemName = element.elem_value
			element.tooltip = selectItemName and { "SICore.自动填充-窗口-插入燃料-物品-提示" , game.item_prototypes[selectItemName].localised_name } or { "SICore.自动填充-窗口-插入燃料-物品-选择-提示" }
			-- 保存 [插入燃料-物品] 选择的物品
			local key = name:sub( SIAutoInsert.Names.InsertFuel_Item_Position )
			local location = key:find( "_" )
			local itemDataIndex = tonumber( key:sub( 1 , location - 1 ) )
			if itemDataIndex and itemDataIndex > 0 then
				local entityName = key:sub( location + 1 )
				local tabSettingsIndex = settings.tabSettingsIndex
				local tabSettings = settings.TabSettingsList[tabSettingsIndex]
				local itemDataList = tabSettings.InsertFuel.List
				itemDataList[entityName][itemDataIndex].ItemName = selectItemName
			end
		end
	end ,
	Set_InsertFuel_Count = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIAutoInsert.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			local count = math.floor( tonumber( element.text ) or 0 )
			element.text = tostring( count )
			-- 保存 [插入燃料-数量] 填写的数量
			local key = name:sub( SIAutoInsert.Names.InsertFuel_Count_Position )
			local location = key:find( "_" )
			local itemDataIndex = tonumber( key:sub( 1 , location - 1 ) )
			if itemDataIndex and itemDataIndex > 0 then
				local entityName = key:sub( location + 1 )
				local tabSettingsIndex = settings.tabSettingsIndex
				local tabSettings = settings.TabSettingsList[tabSettingsIndex]
				local itemDataList = tabSettings.InsertFuel.List
				itemDataList[entityName][itemDataIndex].Count = count
			end
		end
	end ,
	Set_InsertAmmo_Entity = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIAutoInsert.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [插入弹药-实体] 选择的实体
			local selectEntityName = element.elem_value
			local tabSettingsIndex = settings.tabSettingsIndex
			local tabSettings = settings.TabSettingsList[tabSettingsIndex]
			local itemDataList = tabSettings.InsertAmmo.List
			local entityName = name:sub( SIAutoInsert.Names.InsertAmmo_Entity_Position )
			if itemDataList[entityName] then
				if entityName == selectEntityName then
					return
				else
					if selectEntityName == nil then
						itemDataList[entityName] = nil
					else
						local newItemDataList = {}
						for innerEntityName , itemData in pairs( itemDataList ) do
							if entityName == innerEntityName then
								newItemDataList[selectEntityName] = {}
							else
								newItemDataList[innerEntityName] = itemData
							end
						end
						tabSettings.InsertAmmo.List = newItemDataList
					end
				end
			else
				if selectEntityName == nil then
					return
				end
				if itemDataList[selectEntityName] then
					SIPrint.Warning( playerIndex , { "SICore.自动填充-提示-插入弹药-已存在" , selectEntityName , game.entity_prototypes[selectEntityName].localised_name } )
					element.elem_value = nil
					return
				end
				itemDataList[selectEntityName] = {}
			end
			SIAutoInsert.FreshPage_InsertAmmo( settings , tabSettings , settings.Elements[tabSettingsIndex] )
		end
	end ,
	Set_InsertAmmo_Item = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIAutoInsert.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			local selectItemName = element.elem_value
			element.tooltip = selectItemName and { "SICore.自动填充-窗口-插入弹药-物品-提示" , game.item_prototypes[selectItemName].localised_name } or { "SICore.自动填充-窗口-插入弹药-物品-选择-提示" }
			-- 保存 [插入弹药-物品] 选择的物品
			local key = name:sub( SIAutoInsert.Names.InsertAmmo_Item_Position )
			local location = key:find( "_" )
			local itemDataIndex = tonumber( key:sub( 1 , location - 1 ) )
			if itemDataIndex and itemDataIndex > 0 then
				local entityName = key:sub( location + 1 )
				local tabSettingsIndex = settings.tabSettingsIndex
				local tabSettings = settings.TabSettingsList[tabSettingsIndex]
				local itemDataList = tabSettings.InsertAmmo.List
				itemDataList[entityName][itemDataIndex].ItemName = selectItemName
			end
		end
	end ,
	Set_InsertAmmo_Count = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIAutoInsert.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			local count = math.floor( tonumber( element.text ) or 0 )
			element.text = tostring( count )
			-- 保存 [插入弹药-数量] 填写的数量
			local key = name:sub( SIAutoInsert.Names.InsertAmmo_Count_Position )
			local location = key:find( "_" )
			local itemDataIndex = tonumber( key:sub( 1 , location - 1 ) )
			if itemDataIndex and itemDataIndex > 0 then
				local entityName = key:sub( location + 1 )
				local tabSettingsIndex = settings.tabSettingsIndex
				local tabSettings = settings.TabSettingsList[tabSettingsIndex]
				local itemDataList = tabSettings.InsertAmmo.List
				itemDataList[entityName][itemDataIndex].Count = count
			end
		end
	end ,
	EffectSelect = function( playerIndex , entity )
		local settings = SIGlobal.GetPlayerSettings( SIAutoInsert.Settings.Name , playerIndex )
		settings.entities = { entity }
		if settings.frame and settings.frame.valid then
			SIAutoInsert.EffectTabSettings( settings , settings.tabSettingsIndex )
		else
			local defaultIndex = settings.defaultIndex
			if defaultIndex < 1 or defaultIndex > #settings.TabSettingsList then
				SIAutoInsert.OpenFrame( playerIndex )
			else
				SIAutoInsert.EffectTabSettings( settings , defaultIndex )
			end
		end
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ------ 接口函数 -- 窗口 ------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------

	-- ----------------------------------------
	-- 打开指定玩家的自动填充的管理窗口<br>
	-- ----------------------------------------
	-- playerIndex = 玩家索引<br>
	-- ----------------------------------------
	OpenFrameByPlayerIndex = function( playerIndex )
		SIAutoInsert.OpenFrame( playerIndex )
	end ,

	-- ----------------------------------------
	-- 关闭指定玩家的自动填充的管理窗口<br>
	-- ----------------------------------------
	-- playerIndex = 玩家索引<br>
	-- ----------------------------------------
	CloseFrameByPlayerIndex = function( playerIndex )
		SIAutoInsert.CloseFrame( playerIndex )
	end ,

	-- ----------------------------------------
	-- 打开所有玩家的自动填充的管理窗口<br>
	-- ----------------------------------------
	-- 无参数<br>
	-- ----------------------------------------
	OpenFrames = function()
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIAutoInsert.Settings.Name ) ) do
			SIAutoInsert.OpenFrame( playerIndex )
		end
	end ,

	-- ----------------------------------------
	-- 关闭所有玩家的自动填充的管理窗口<br>
	-- ----------------------------------------
	-- 无参数<br>
	-- ----------------------------------------
	CloseFrames = function()
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIAutoInsert.Settings.Name ) ) do
			SIAutoInsert.CloseFrame( playerIndex )
		end
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ---- 接口函数 -- 导入导出 ----------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------

	-- ----------------------------------------
	-- 导入数据<br>
	-- ----------------------------------------
	-- playerIndex    = 点击按钮的玩家索引<br>
	-- data           = 导出时保存的数据 , 根据导出时导出接口函数返回的数据 , 此参数可能为 nil<br>
	-- settingsDataID = 导入导出设置数据包的 ID<br>
	-- gameTick       = 导出数据时的游戏时间 , tick<br>
	-- ----------------------------------------
	ImpoerSettingsData = function( playerIndex , data , settingsDataID , gameTick )
		if not data then
			return
		end
		local settings = SIGlobal.GetPlayerSettings( SIAutoInsert.Settings.Name , playerIndex )
		settings.defaultIndex = data.defaultIndex or 0
		settings.TabSettingsList = data.TabSettingsList or {}
		-- 整理数据
		local tabSettingsCount = #settings.TabSettingsList
		if tabSettingsCount < 1 then
			SIAutoInsert.CreateTabSettings( settings )
			tabSettingsCount = #settings.TabSettingsList
		end
		settings.tabSettingsIndex = SITools.AsNumberInt( settings.tabSettingsIndex , 1 , tabSettingsCount )
		-- 更新控件
		if settings.frame and settings.frame.valid then
			SIAutoInsert.CreateTab( settings )
		end
	end ,

	-- ----------------------------------------
	-- 导出数据<br>
	-- ----------------------------------------
	-- playerIndex    = 点击按钮的玩家索引<br>
	-- settingsDataID = 导入导出设置数据包的 ID<br>
	-- gameTick       = 当前的游戏时间 , tick<br>
	-- ----------------------------------------
	-- 返回值 = 导出的数据<br>
	-- ----------------------------------------
	ExportSettingsData = function( playerIndex , settingsDataID , gameTick )
		local settings = SIGlobal.GetPlayerSettings( SIAutoInsert.Settings.Name , playerIndex )
		return
		{
			defaultIndex = settings.defaultIndex ,
			TabSettingsList = settings.TabSettingsList
		}
	end
}

SIAutoInsert.Names.ListButtonPosition = #SIAutoInsert.Names.ListButtonPrefix + 1
SIAutoInsert.Names.EnablePosition = #SIAutoInsert.Names.EnablePrefix + 1
SIAutoInsert.Names.InsertFuel_Entity_Position = #SIAutoInsert.Names.InsertFuel_Entity_Prefix + 1
SIAutoInsert.Names.InsertFuel_Item_Position = #SIAutoInsert.Names.InsertFuel_Item_Prefix + 1
SIAutoInsert.Names.InsertFuel_Count_Position = #SIAutoInsert.Names.InsertFuel_Count_Prefix + 1
SIAutoInsert.Names.InsertAmmo_Entity_Position = #SIAutoInsert.Names.InsertAmmo_Entity_Prefix + 1
SIAutoInsert.Names.InsertAmmo_Item_Position = #SIAutoInsert.Names.InsertAmmo_Item_Prefix + 1
SIAutoInsert.Names.InsertAmmo_Count_Position = #SIAutoInsert.Names.InsertAmmo_Count_Prefix + 1

SIAutoInsert.Toolbar =
{
	ID = "SI核心-自动填充" ,
	Name = "自动填充" ,
	IconItemName = SIConstants_Core.raw.Items.IconAuto ,
	LocalizedName = { "SICore.自动填充-工具栏-按钮" } ,
	LocalizedDescription = { "SICore.自动填充-工具栏-提示" } ,
	ActionRemoteInterfaceID = SIAutoInsert.InterfaceID ,
	ActionRemoteFunctionName = "OpenFrameByPlayerIndex" ,
	Permission = SIPermission.PermissionIDs.AutoInsert ,
	Order = "SICore-AutoInsert"
}
SIAutoInsert.SettingsData =
{
	ID = "SI核心-自动填充" ,
	ImportRemoteInterfaceID = SIAutoInsert.InterfaceID ,
	ImportRemoteFunctionName = "ImpoerSettingsData" ,
	ExportRemoteInterfaceID = SIAutoInsert.InterfaceID ,
	ExportRemoteFunctionName = "ExportSettingsData"
}
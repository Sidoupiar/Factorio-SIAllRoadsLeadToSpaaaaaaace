SIRequestMap =
{
	ID = "RequestMap" ,
	Name = "紫图" ,
	InterfaceID = "SICore-RequestMap" ,
	Names =
	{
		Prefix = "SI核心-紫图-" ,
		Frame = "SI核心-紫图-窗口" ,
		Close = "SI核心-紫图-关闭" ,
		Add = "SI核心-紫图-添加" ,
		Delete = "SI核心-紫图-删除" ,
		TabPane = "SI核心-紫图-分页面板" ,
		TabSettingsName = "SI核心-紫图-设置名称" ,
		DefaultIndex = "SI核心-紫图-默认选择" ,
		GreenToBlue_Check = "SI核心-紫图-绿箱向蓝箱供货-勾选" ,
		SetModule_FromInventory = "SI核心-紫图-设置插件-从背包填充" ,
		RemoveModule_ToInventory = "SI核心-紫图-移除插件-进入背包" ,
		RemoveModule_Invert = "SI核心-紫图-移除插件-条件反转" ,
		ListButtonPrefix = "SI核心-紫图-列表定位按钮-" ,
		EnablePrefix = "SI核心-紫图-启用功能-" ,
		RequestSlot_Entity_Prefix = "SI核心-紫图-请求格子-实体-" ,
		RequestSlot_Item_Prefix = "SI核心-紫图-请求格子-物品-" ,
		MaxSlot_Entity_Prefix = "SI核心-紫图-最大格子-实体-" ,
		MaxSlot_Count_Prefix = "SI核心-紫图-最大格子-数量-" ,
		SetModule_Entity_Prefix = "SI核心-紫图-设置插件-实体-" ,
		SetModule_Item_Prefix = "SI核心-紫图-设置插件-物品-" ,
		RemoveModule_Entity_Prefix = "SI核心-紫图-移除插件-实体-" ,
		RemoveModule_Item_Prefix = "SI核心-紫图-移除插件-物品-" ,
		InsertFuel_Entity_Prefix = "SI核心-紫图-插入燃料-实体-" ,
		InsertFuel_Item_Prefix = "SI核心-紫图-插入燃料-物品-" ,
		InsertFuel_Count_Prefix = "SI核心-紫图-插入燃料-数量-" ,
		InsertFuel_Mode_Prefix = "SI核心-紫图-插入燃料-模式-" ,
		InsertAmmo_Entity_Prefix = "SI核心-紫图-插入弹药-实体-" ,
		InsertAmmo_Item_Prefix = "SI核心-紫图-插入弹药-物品-" ,
		InsertAmmo_Count_Prefix = "SI核心-紫图-插入弹药-数量-" ,
		InsertAmmo_Mode_Prefix = "SI核心-紫图-插入弹药-模式-"
	} ,
	Settings =
	{
		Name = "RequestMap" ,
		Default =
		{
			frame = nil ,
			frameLocation = nil ,
			tabPane = nil ,
			scroll = nil ,
			TabList = {} ,
			PageList = {} ,
			ListButtons = {} ,
			Elements =
			{
				-- {
				-- 	TabSettingsName = nil ,
				-- 	DefaultIndex = nil ,
				-- 	-- 请求格子
				-- 	RequestSlot_Enable = nil ,
				-- 	RequestSlot_Flow = nil ,
				-- 	RequestSlot_List = nil ,
				-- 	-- 最大格子
				-- 	MaxSlot_Enable = nil ,
				-- 	MaxSlot_Flow = nil ,
				-- 	MaxSlot_List = nil ,
				-- 	-- 绿箱向蓝箱供货
				-- 	GreenToBlue_Enable = nil ,
				-- 	GreenToBlue_Flow = nil ,
				-- 	GreenToBlue_Check = nil ,
				-- 	-- 设置插件
				-- 	SetModule_Enable = nil ,
				-- 	SetModule_Flow = nil ,
				-- 	SetModule_FromInventory = nil ,
				-- 	SetModule_List = nil ,
				-- 	-- 移除插件
				-- 	RemoveModule_Enable = nil ,
				-- 	RemoveModule_Flow = nil ,
				-- 	RemoveModule_ToInventory = nil ,
				--	RemoveModule_Invert = nil ,
				-- 	RemoveModule_List = nil ,
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
			defaultIndex1 = 0 ,
			defaultIndex2 = 0 ,
			defaultIndex3 = 0 ,
			defaultIndex4 = 0 ,
			TabSettingsList = {}
		}
	} ,
	TabSettingsMaxCount = 8 ,
	DefaultTabSettings =
	{
		Name = nil ,
		-- 请求格子
		RequestSlot =
		{
			Enable = false ,
			List = {} -- 键为选择的容器实体 , 值为请求物品名称列表
		} ,
		-- 最大格子
		MaxSlot =
		{
			Enable = false ,
			List = {} -- 键为选择的容器实体 , 值为限制的数量
		} ,
		-- 绿箱向蓝箱供货
		GreenToBlue =
		{
			Enable = false ,
			Check = true
		} ,
		-- 设置插件
		SetModule =
		{
			Enable = false ,
			FromInventory = false ,
			List = {} -- 键为选择的设备实体 , 值为插件物品名称列表
		} ,
		-- 移除插件
		RemoveModule =
		{
			Enable = false ,
			ToInventory = false ,
			Invert = false ,
			List = {} -- 键为选择的设备实体 , 值为插件物品名称列表
		} ,
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
		RequestSlot  = SIConstants_Core.raw.Items.IconColorSky ,
		MaxSlot      = SIConstants_Core.raw.Items.IconColorCopper ,
		GreenToBlue  = SIConstants_Core.raw.Items.IconColorGrass ,
		SetModule    = SIConstants_Core.raw.Items.IconColorDream ,
		RemoveModule = SIConstants_Core.raw.Items.IconColorSliver ,
		InsertFuel   = SIConstants_Core.raw.Items.IconColorMeat ,
		InsertAmmo   = SIConstants_Core.raw.Items.IconColorRose
	} ,
	DefaultIndexText =
	{
		[1] = { "SICore.紫图-窗口-选择-空" } ,
		[2] = { "SICore.紫图-窗口-选择-1" } ,
		[3] = { "SICore.紫图-窗口-选择-2" } ,
		[4] = { "SICore.紫图-窗口-选择-3" } ,
		[5] = { "SICore.紫图-窗口-选择-4" }
	} ,
	CountModeText =
	{
		[1] = { "SICore.紫图-窗口-计数-整体计数" } ,
		[2] = { "SICore.紫图-窗口-计数-独立计数" }
	} ,
	RequestSlot_ItemSlotMax = 200 ,
	RequestSlot_Entity_Filters =
	{
		{
			filter = "type" ,
			type =
			{
				SICommon.Types.Entities.ContainerLogic ,
				SICommon.Types.Entities.Inserter ,
				SICommon.Types.Entities.BeltLoader ,
				SICommon.Types.Entities.BeltLoaderSmall ,
				SICommon.Types.Entities.Car ,
				SICommon.Types.Entities.SpiderVehicle ,
				SICommon.Types.Entities.WagonCargo
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
	RequestSlot_Item_Filters =
	{
		{
			filter = "flag" ,
			flag = SICommon.Flags.Item.Hidden ,
			mode = SICommon.Flags.Condition.OR ,
			invert = true
		} ,
		{
			filter = "name" ,
			name = SIConstants_Core.raw.Items.IconEmpty ,
			mode = SICommon.Flags.Condition.OR
		}
	} ,
	MaxSlot_Entity_Filters =
	{
		{
			filter = "type" ,
			type =
			{
				SICommon.Types.Entities.Container ,
				SICommon.Types.Entities.ContainerLogic ,
				SICommon.Types.Entities.Car ,
				SICommon.Types.Entities.SpiderVehicle ,
				SICommon.Types.Entities.WagonCargo
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
	SetModule_Entity_Filters =
	{
		{
			filter = "type" ,
			type =
			{
				SICommon.Types.Entities.Machine ,
				SICommon.Types.Entities.Furnace ,
				SICommon.Types.Entities.Lab ,
				SICommon.Types.Entities.Mining ,
				SICommon.Types.Entities.RocketSilo ,
				SICommon.Types.Entities.Beacon
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
	SetModule_Item_Filters =
	{
		{
			filter = "type" ,
			type = SICommon.Types.Items.Module ,
			mode = SICommon.Flags.Condition.OR
		} ,
		{
			filter = "flag" ,
			flag = SICommon.Flags.Item.Hidden ,
			mode = SICommon.Flags.Condition.AND ,
			invert = true
		} ,
		{
			filter = "name" ,
			name = SIConstants_Core.raw.Items.IconEmpty ,
			mode = SICommon.Flags.Condition.OR
		}
	} ,
	RemoveModule_Entity_Filters =
	{
		{
			filter = "type" ,
			type =
			{
				SICommon.Types.Entities.Machine ,
				SICommon.Types.Entities.Furnace ,
				SICommon.Types.Entities.Lab ,
				SICommon.Types.Entities.Mining ,
				SICommon.Types.Entities.RocketSilo ,
				SICommon.Types.Entities.Beacon
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
	RemoveModule_Item_Filters =
	{
		{
			filter = "type" ,
			type = SICommon.Types.Items.Module ,
			mode = SICommon.Flags.Condition.OR
		} ,
		{
			filter = "flag" ,
			flag = SICommon.Flags.Item.Hidden ,
			mode = SICommon.Flags.Condition.AND ,
			invert = true
		} ,
		{
			filter = "name" ,
			name = SIConstants_Core.raw.Items.IconEmpty ,
			mode = SICommon.Flags.Condition.OR
		}
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
	InsertFuel_Item_Filters =
	{
		{
			filter = "fuel" ,
			["fuel-category"] = nil ,
			mode = SICommon.Flags.Condition.OR
		} ,
		{
			filter = "flag" ,
			flag = SICommon.Flags.Item.Hidden ,
			mode = SICommon.Flags.Condition.AND ,
			invert = true
		} ,
		{
			filter = "name" ,
			name = SIConstants_Core.raw.Items.IconEmpty ,
			mode = SICommon.Flags.Condition.OR
		}
	} ,
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
		} ,
		{
			filter = "flag" ,
			flag = SICommon.Flags.Item.Hidden ,
			mode = SICommon.Flags.Condition.AND ,
			invert = true
		} ,
		{
			filter = "name" ,
			name = SIConstants_Core.raw.Items.IconEmpty ,
			mode = SICommon.Flags.Condition.OR
		}
	} ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 窗口函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	OpenFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )




		local newTabSettingsList = {}
		for index , tabSettings in pairs( settings.TabSettingsList ) do
			local newTabSettings = SIUtils.table.deepcopy( SIRequestMap.DefaultTabSettings )
			for key , value in pairs( newTabSettings ) do
				if tabSettings[key] then
					newTabSettings[key] = tabSettings[key]
				end
			end
		end
		settings.TabSettingsList = newTabSettingsList





		if settings.frame and settings.frame.valid then
			SIRequestMap.CloseFrame( playerIndex )
		else
			local player = game.get_player( playerIndex )
			-- 显示窗口
			local frame = SIElements.CreateFrame( player , settings ,
			{
				Name         = SIRequestMap.Names.Frame ,
				Close        = SIRequestMap.Names.Close ,
				Style        = SIConstants_Core.raw.Styles.RequestMap_Frame ,
				Title        = { "SICore.紫图-窗口-标题" } ,
				TitleTooltip = { "SICore.紫图-窗口-标题-提示" , { "item-name.infinity-chest" } , { "SICoreName.物品-紫图" } } ,
				UseTooltip   = { "SICore.紫图-窗口-使用-提示" , { "item-name.infinity-chest" } , { "SICoreName.物品-紫图" } } ,
				CloseTooltip = { "SICore.紫图-窗口-关闭-提示" } ,
				OtherButtons =
				{
					{
						Name = SIRequestMap.Names.Add ,
						Item = SIConstants_Core.raw.Items.IconAdd ,
						Tooltip = { "SICore.紫图-窗口-新增-提示" , SIRequestMap.TabSettingsMaxCount }
					}
				}
			} )
			-- 整理数据
			local tabSettingsCount = #settings.TabSettingsList
			if tabSettingsCount < 1 then
				SIRequestMap.CreateTabSettings( settings )
				tabSettingsCount = #settings.TabSettingsList
			end
			settings.tabSettingsIndex = SITools.AsNumberInt( settings.tabSettingsIndex , 1 , tabSettingsCount )
			-- 第 1 层
			settings.tabPane = frame.add{ type = "tabbed-pane" , name = SIRequestMap.Names.TabPane , style = SIConstants_Core.raw.Styles.RequestMap_TabPane }
			-- 根据设置更新控件
			SIRequestMap.CreateTab( settings )
		end
	end ,
	CloseFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			settings.entities = nil
			settings.frame.destroy()
			settings.frame = nil
			settings.tabPane = nil
			settings.scroll = nil
			settings.TabList = {}
			settings.PageList = {}
			settings.ListButtons = {}
			settings.Elements = {}
		end
	end ,
	MoveFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			SIElements.SaveFrameLocation( settings )
		end
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 功能函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	CreateTabSettings = function( settings )
		local tabSettingsCount = #settings.TabSettingsList
		if tabSettingsCount < SIRequestMap.TabSettingsMaxCount then
			local tabSettings = SIUtils.table.deepcopy( SIRequestMap.DefaultTabSettings )
			tabSettings.Name = tostring( tabSettingsCount + 1 )
			table.insert( settings.TabSettingsList , tabSettings )
		end
	end ,
	DeleteTabSettings = function( settings )
		local tabSettingsCount = #settings.TabSettingsList
		if tabSettingsCount > 0 then
			local tabSettingsIndex = SITools.AsNumberInt( settings.tabSettingsIndex , 1 , SIRequestMap.TabSettingsMaxCount )
			table.remove( settings.TabSettingsList , tabSettingsIndex )
			tabSettingsCount = #settings.TabSettingsList
			if tabSettingsCount < 1 then
				SIRequestMap.CreateTabSettings( settings )
				tabSettingsCount = #settings.TabSettingsList
			end
			settings.tabSettingsIndex = SITools.AsNumberInt( tabSettingsIndex , 1 , tabSettingsCount )
			settings.defaultIndex1 = tabSettingsIndex == settings.defaultIndex1 and 0 or tabSettingsIndex < settings.defaultIndex1 and SITools.AsNumberInt( settings.defaultIndex1 - 1 , 1 , tabSettingsCount ) or settings.defaultIndex1
			settings.defaultIndex2 = tabSettingsIndex == settings.defaultIndex2 and 0 or tabSettingsIndex < settings.defaultIndex2 and SITools.AsNumberInt( settings.defaultIndex2 - 1 , 1 , tabSettingsCount ) or settings.defaultIndex2
			settings.defaultIndex3 = tabSettingsIndex == settings.defaultIndex3 and 0 or tabSettingsIndex < settings.defaultIndex3 and SITools.AsNumberInt( settings.defaultIndex3 - 1 , 1 , tabSettingsCount ) or settings.defaultIndex3
			settings.defaultIndex4 = tabSettingsIndex == settings.defaultIndex4 and 0 or tabSettingsIndex < settings.defaultIndex4 and SITools.AsNumberInt( settings.defaultIndex4 - 1 , 1 , tabSettingsCount ) or settings.defaultIndex4
		else
			SIRequestMap.CreateTabSettings( settings )
			settings.tabSettingsIndex = 1
			settings.defaultIndex1 = 0
			settings.defaultIndex2 = 0
			settings.defaultIndex3 = 0
			settings.defaultIndex4 = 0
		end
	end ,
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
			local tab = tabPane.add{ type = "tab" , caption = { "SICore.紫图-窗口-分页标题" , tabSettings.Name } , tooltip = { "SICore.紫图-窗口-分页标题-提示" , SIRequestMap.TabSettingsMaxCount } }
			local page = SIRequestMap.CreatePage( settings , index )
			tabPane.add_tab( tab , page )
			-- 保存信息
			table.insert( settings.TabList , tab )
			table.insert( settings.PageList , page )
		end
		settings.tabSettingsIndex = 1 -- 不知道为什么设置当前标签页就不好使 , 为了避免 bug 就先强制第 1 页了
		settings.tabPane.selected_tab_index = settings.tabSettingsIndex
		SIRequestMap.FreshPage( settings )
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
		nameFlow.add{ type = "label" , caption = { "SICore.紫图-窗口-名称" } , tooltip = { "SICore.紫图-窗口-名称-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_Label }
		elements.TabSettingsName = nameFlow.add{ type = "textfield" , name = SIRequestMap.Names.TabSettingsName , text = nil , tooltip = { "SICore.紫图-窗口-名称-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_Text }
		nameFlow.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.RequestMap_EmptyFlow }
		nameFlow.add{ type = "button" , name = SIRequestMap.Names.Delete , caption = { "SICore.紫图-窗口-删除" } , tooltip = { "SICore.紫图-窗口-删除-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonRed }
		-- ----------------------------------------
		-- 默认选择
		-- ----------------------------------------
		local defaultIndexFlow = page.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowCenterH }
		defaultIndexFlow.add{ type = "label" , caption = { "SICore.紫图-窗口-默认选择" } , tooltip = { "SICore.紫图-窗口-默认选择-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_Label }
		elements.DefaultIndex = defaultIndexFlow.add
		{
			type = "drop-down" ,
			name = SIRequestMap.Names.DefaultIndex ,
			caption = { "SICore.紫图-窗口-默认选择" } ,
			tooltip = { "SICore.紫图-窗口-默认选择-提示" } ,
			items = SIRequestMap.DefaultIndexText ,
			selected_index = 1 ,
			style = SIConstants_Core.raw.Styles.RequestMap_DropDown
		}
		-- ----------------------------------------
		-- 设置列表按钮
		-- ----------------------------------------
		local listButtonFlow = page.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.RequestMap_ListButtonFlow }
		-- ----------------------------------------
		-- 设置列表
		-- ----------------------------------------
		local scroll = page.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Common_ScrollPane }
		local list = scroll.add{ type = "table" , column_count = 1 , style = SIConstants_Core.raw.Styles.Common_List }
		settings.scroll = scroll
		-- ----------------------------------------
		-- 请求格子
		-- ----------------------------------------
		elements.RequestSlot_Enable = list.add{ type = "checkbox" , name = SIRequestMap.Names.EnablePrefix .. "RequestSlot_Flow" , state = false , caption = { "SICore.紫图-窗口-请求格子-启用" , { "SICore.紫图-窗口-启用-未设置" } } , tooltip = { "SICore.紫图-窗口-请求格子-启用-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_ListCheck }
		local RequestSlot_Flow = list.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.RequestMap_ListPanelFlow }
		elements.RequestSlot_Flow = RequestSlot_Flow
		elements.RequestSlot_List = RequestSlot_Flow.add{ type = "table" , column_count = 3 , style = SIConstants_Core.raw.Styles.RequestMap_SubList }
		-- ----------------------------------------
		-- 最大格子
		-- ----------------------------------------
		elements.MaxSlot_Enable = list.add{ type = "checkbox" , name = SIRequestMap.Names.EnablePrefix .. "MaxSlot_Flow" , state = false , caption = { "SICore.紫图-窗口-最大格子-启用" , { "SICore.紫图-窗口-启用-未设置" } } , tooltip = { "SICore.紫图-窗口-最大格子-启用-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_ListCheck }
		local MaxSlot_Flow = list.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.RequestMap_ListPanelFlow }
		elements.MaxSlot_Flow = MaxSlot_Flow
		elements.MaxSlot_List = MaxSlot_Flow.add{ type = "table" , column_count = 2 , style = SIConstants_Core.raw.Styles.RequestMap_SubList }
		-- ----------------------------------------
		-- 绿箱向蓝箱供货
		-- ----------------------------------------
		elements.GreenToBlue_Enable = list.add{ type = "checkbox" , name = SIRequestMap.Names.EnablePrefix .. "GreenToBlue_Flow" , state = false , caption = { "SICore.紫图-窗口-绿箱向蓝箱供货-启用" , { "SICore.紫图-窗口-启用-未设置" } } , tooltip = { "SICore.紫图-窗口-绿箱向蓝箱供货-启用-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_ListCheck }
		local GreenToBlue_Flow = list.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.RequestMap_ListPanelFlow }
		elements.GreenToBlue_Flow = GreenToBlue_Flow
		elements.GreenToBlue_Check = GreenToBlue_Flow.add{ type = "checkbox" , name = SIRequestMap.Names.GreenToBlue_Check , state = false , caption = { "SICore.紫图-窗口-绿箱向蓝箱供货-勾选" } , tooltip = { "SICore.紫图-窗口-绿箱向蓝箱供货-勾选-提示" } , style = SIConstants_Core.raw.Styles.Common_CheckBox }
		-- ----------------------------------------
		-- 设置插件
		-- ----------------------------------------
		elements.SetModule_Enable = list.add{ type = "checkbox" , name = SIRequestMap.Names.EnablePrefix .. "SetModule_Flow" , state = false , caption = { "SICore.紫图-窗口-设置插件-启用" , { "SICore.紫图-窗口-启用-未设置" } } , tooltip = { "SICore.紫图-窗口-设置插件-启用-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_ListCheck }
		local SetModule_Flow = list.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.RequestMap_ListPanelFlow }
		elements.SetModule_Flow = SetModule_Flow
		elements.SetModule_FromInventory = SetModule_Flow.add{ type = "checkbox" , name = SIRequestMap.Names.SetModule_FromInventory , state = false , caption = { "SICore.紫图-窗口-设置插件-从背包填充" } , tooltip = { "SICore.紫图-窗口-设置插件-从背包填充-提示" } , style = SIConstants_Core.raw.Styles.Common_CheckBox }
		elements.SetModule_List = SetModule_Flow.add{ type = "table" , column_count = 2 , style = SIConstants_Core.raw.Styles.RequestMap_SubList }
		-- ----------------------------------------
		-- 移除插件
		-- ----------------------------------------
		elements.RemoveModule_Enable = list.add{ type = "checkbox" , name = SIRequestMap.Names.EnablePrefix .. "RemoveModule_Flow" , state = false , caption = { "SICore.紫图-窗口-移除插件-启用" , { "SICore.紫图-窗口-启用-未设置" } } , tooltip = { "SICore.紫图-窗口-移除插件-启用-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_ListCheck }
		local RemoveModule_Flow = list.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.RequestMap_ListPanelFlow }
		elements.RemoveModule_Flow = RemoveModule_Flow
		elements.RemoveModule_ToInventory = RemoveModule_Flow.add{ type = "checkbox" , name = SIRequestMap.Names.RemoveModule_ToInventory , state = false , caption = { "SICore.紫图-窗口-移除插件-进入背包" } , tooltip = { "SICore.紫图-窗口-移除插件-进入背包-提示" } , style = SIConstants_Core.raw.Styles.Common_CheckBox }
		elements.RemoveModule_Invert = RemoveModule_Flow.add{ type = "checkbox" , name = SIRequestMap.Names.RemoveModule_Invert , state = false , caption = { "SICore.紫图-窗口-移除插件-条件反转" } , tooltip = { "SICore.紫图-窗口-移除插件-条件反转-提示" } , style = SIConstants_Core.raw.Styles.Common_CheckBox }
		elements.RemoveModule_List = RemoveModule_Flow.add{ type = "table" , column_count = 2 , style = SIConstants_Core.raw.Styles.RequestMap_SubList }
		-- ----------------------------------------
		-- 插入燃料
		-- ----------------------------------------
		elements.InsertFuel_Enable = list.add{ type = "checkbox" , name = SIRequestMap.Names.EnablePrefix .. "InsertFuel_Flow" , state = false , caption = { "SICore.紫图-窗口-插入燃料-启用" , { "SICore.紫图-窗口-启用-未设置" } } , tooltip = { "SICore.紫图-窗口-插入燃料-启用-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_ListCheck }
		local InsertFuel_Flow = list.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.RequestMap_ListPanelFlow }
		elements.InsertFuel_Flow = InsertFuel_Flow
		elements.InsertFuel_List = InsertFuel_Flow.add{ type = "table" , column_count = 6 , style = SIConstants_Core.raw.Styles.RequestMap_SubList }
		-- ----------------------------------------
		-- 插入弹药
		-- ----------------------------------------
		elements.InsertAmmo_Enable = list.add{ type = "checkbox" , name = SIRequestMap.Names.EnablePrefix .. "InsertAmmo_Flow" , state = false , caption = { "SICore.紫图-窗口-插入弹药-启用" , { "SICore.紫图-窗口-启用-未设置" } } , tooltip = { "SICore.紫图-窗口-插入弹药-启用-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_ListCheck }
		local InsertAmmo_Flow = list.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.RequestMap_ListPanelFlow }
		elements.InsertAmmo_Flow = InsertAmmo_Flow
		elements.InsertAmmo_List = InsertAmmo_Flow.add{ type = "table" , column_count = 7 , style = SIConstants_Core.raw.Styles.RequestMap_SubList }
		-- ----------------------------------------
		-- 创建滚动定位按钮
		-- ----------------------------------------
		for key , value in pairs( SIRequestMap.DefaultTabSettings ) do
			if key ~= "Name" then
				local button = listButtonFlow.add{ type = "sprite-button" , name = SIRequestMap.Names.ListButtonPrefix .. key .. "_Enable" , sprite = "item/" .. SIRequestMap.ListButtonIcon[key] , tooltip = { "SICore.紫图-窗口-列表定位按钮-提示" , elements[key .. "_Enable"].caption } , style = SIConstants_Core.raw.Styles.RequestMap_ListButton }
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
		if settings.defaultIndex1 == tabSettingsIndex then
			elements.DefaultIndex.selected_index = 2
		elseif settings.defaultIndex2 == tabSettingsIndex then
			elements.DefaultIndex.selected_index = 3
		elseif settings.defaultIndex3 == tabSettingsIndex then
			elements.DefaultIndex.selected_index = 4
		elseif settings.defaultIndex4 == tabSettingsIndex then
			elements.DefaultIndex.selected_index = 5
		else
			elements.DefaultIndex.selected_index = 1
		end
		-- ----------------------------------------
		-- 请求格子
		-- ----------------------------------------
		elements.RequestSlot_Enable.state = tabSettings.RequestSlot.Enable
		elements.RequestSlot_Flow.visible = tabSettings.RequestSlot.Enable
		SIRequestMap.FreshPage_RequestSlot( settings , tabSettings , elements )
		-- ----------------------------------------
		-- 最大格子
		-- ----------------------------------------
		elements.MaxSlot_Enable.state = tabSettings.MaxSlot.Enable
		elements.MaxSlot_Flow.visible = tabSettings.MaxSlot.Enable
		SIRequestMap.FreshPage_MaxSlot( settings , tabSettings , elements )
		-- ----------------------------------------
		-- 绿箱向蓝箱供货
		-- ----------------------------------------
		elements.GreenToBlue_Enable.state = tabSettings.GreenToBlue.Enable
		elements.GreenToBlue_Flow.visible = tabSettings.GreenToBlue.Enable
		elements.GreenToBlue_Check.state = tabSettings.GreenToBlue.Check
		SIRequestMap.FreshPage_GreenToBlue( settings , tabSettings , elements )
		-- ----------------------------------------
		-- 设置插件
		-- ----------------------------------------
		elements.SetModule_Enable.state = tabSettings.SetModule.Enable
		elements.SetModule_Flow.visible = tabSettings.SetModule.Enable
		elements.SetModule_FromInventory.state = tabSettings.SetModule.FromInventory
		SIRequestMap.FreshPage_SetModule( settings , tabSettings , elements )
		-- ----------------------------------------
		-- 移除插件
		-- ----------------------------------------
		elements.RemoveModule_Enable.state = tabSettings.RemoveModule.Enable
		elements.RemoveModule_Flow.visible = tabSettings.RemoveModule.Enable
		elements.RemoveModule_ToInventory.state = tabSettings.RemoveModule.ToInventory
		elements.RemoveModule_Invert.state = tabSettings.RemoveModule.Invert
		SIRequestMap.FreshPage_RemoveModule( settings , tabSettings , elements )
		-- ----------------------------------------
		-- 插入燃料
		-- ----------------------------------------
		elements.InsertFuel_Enable.state = tabSettings.InsertFuel.Enable
		elements.InsertFuel_Flow.visible = tabSettings.InsertFuel.Enable
		SIRequestMap.FreshPage_InsertFuel( settings , tabSettings , elements )
		-- ----------------------------------------
		-- 插入弹药
		-- ----------------------------------------
		elements.InsertAmmo_Enable.state = tabSettings.InsertAmmo.Enable
		elements.InsertAmmo_Flow.visible = tabSettings.InsertAmmo.Enable
		SIRequestMap.FreshPage_InsertAmmo( settings , tabSettings , elements )
	end ,
	FreshPage_RequestSlot = function( settings , tabSettings , elements )
		-- 更新说明
		elements.RequestSlot_Enable.caption = { "SICore.紫图-窗口-请求格子-启用" , { SITable.Size( tabSettings.RequestSlot.List ) > 0 and "SICore.紫图-窗口-启用-已设置" or "SICore.紫图-窗口-启用-未设置" } }
		-- 清空列表
		local list = elements.RequestSlot_List
		list.clear()
		-- 重建列表
		for entityName , requestItemList in pairs( tabSettings.RequestSlot.List ) do
			local entityPrototype = game.entity_prototypes[entityName]
			local entityTooltip = nil
			local entity = entityName
			local maxSlot = 0
			if entityPrototype then
				entityTooltip = { "SICore.紫图-窗口-请求格子-实体-提示" , entityPrototype.localised_name }
				local type = entityPrototype.type
				if type == SICommon.Types.Entities.ContainerLogic then
					local logisticMode = entityPrototype.logistic_mode
					if logisticMode == SICommon.Flags.LogisticMode.Requester or logisticMode == SICommon.Flags.LogisticMode.Buffer then
						maxSlot = entityPrototype.filter_count or SITable.Size( requestItemList ) + 1
					elseif logisticMode == SICommon.Flags.LogisticMode.Storage then
						maxSlot = 1
					else
						maxSlot = 0
					end
				elseif type == SICommon.Types.Entities.Inserter or type == SICommon.Types.Entities.BeltLoader or type == SICommon.Types.Entities.BeltLoaderSmall then
					maxSlot = entityPrototype.filter_count or SITable.Size( requestItemList ) + 1
				elseif type == SICommon.Types.Entities.Car then
					maxSlot = entityPrototype.get_inventory_size( defines.inventory.car_trunk ) or 0
				elseif type == SICommon.Types.Entities.SpiderVehicle then
					maxSlot = entityPrototype.get_inventory_size( defines.inventory.spider_trunk ) or 0
				elseif type == SICommon.Types.Entities.WagonCargo then
					maxSlot = entityPrototype.get_inventory_size( defines.inventory.cargo_wagon ) or 0
				else
					maxSlot = 0
				end
				if maxSlot > SIRequestMap.RequestSlot_ItemSlotMax then
					SIPrint.Warning( settings.playerIndex , { "SICore.紫图-提示-请求格子-格子太多" , entity , entityPrototype.localised_name , SIRequestMap.RequestSlot_ItemSlotMax } )
					maxSlot = SIRequestMap.RequestSlot_ItemSlotMax
				end
			else
				entityTooltip = { "SICore.紫图-窗口-请求格子-实体-空-提示" , entity }
				entity = SIConstants_Core.raw.Entities.IconEmpty
				for key , value in pairs( requestItemList ) do
					maxSlot = math.max( maxSlot , key )
				end
			end
			list.add
			{
				type = "choose-elem-button" ,
				name = SIRequestMap.Names.RequestSlot_Entity_Prefix .. entityName ,
				tooltip = entityTooltip ,
				elem_type = "entity" ,
				entity = entity ,
				elem_filters = SIRequestMap.RequestSlot_Entity_Filters ,
				style = SIConstants_Core.raw.Styles.RequestMap_ListChooser
			}
			local selectList1 = list.add{ type = "table" , column_count = 10 , style = SIConstants_Core.raw.Styles.RequestMap_SelectList }
			local selectList2 = list.add{ type = "table" , column_count = 10 , style = SIConstants_Core.raw.Styles.RequestMap_SelectList }
			for slotIndex = 1 , maxSlot , 1 do
				local selectList = math.fmod( math.floor( slotIndex / 10 ) , 2 ) == 0 and selectList1 or selectList2
				local itemTooltip = nil
				local item = requestItemList[slotIndex]
				if item then
					local itemPrototype = game.item_prototypes[item]
					if itemPrototype then
						itemTooltip = { "SICore.紫图-窗口-请求格子-物品-提示" , itemPrototype.localised_name }
					else
						itemTooltip = { "SICore.紫图-窗口-请求格子-物品-空-提示" , item }
						item = SIConstants_Core.raw.Items.IconEmpty
					end
				else
					itemTooltip = { "SICore.紫图-窗口-请求格子-物品-选择-提示" }
				end
				selectList.add
				{
					type = "choose-elem-button" ,
					name = SIRequestMap.Names.RequestSlot_Item_Prefix .. slotIndex .. "_" .. entityName ,
					tooltip = itemTooltip ,
					elem_type = "item" ,
					item = item ,
					elem_filters = SIRequestMap.RequestSlot_Item_Filters ,
					style = SIConstants_Core.raw.Styles.RequestMap_ListChooser
				}
			end
		end
		list.add
		{
			type = "choose-elem-button" ,
			name = SIRequestMap.Names.RequestSlot_Entity_Prefix ,
			tooltip = { "SICore.紫图-窗口-请求格子-实体-选择-提示" } ,
			elem_type = "entity" ,
			entity = nil ,
			elem_filters = SIRequestMap.RequestSlot_Entity_Filters ,
			style = SIConstants_Core.raw.Styles.RequestMap_ListChooser
		}
	end ,
	FreshPage_MaxSlot = function( settings , tabSettings , elements )
		-- 更新说明
		elements.MaxSlot_Enable.caption = { "SICore.紫图-窗口-最大格子-启用" , { SITable.Size( tabSettings.MaxSlot.List ) > 0 and "SICore.紫图-窗口-启用-已设置" or "SICore.紫图-窗口-启用-未设置" } }
		-- 清空列表
		local list = elements.MaxSlot_List
		list.clear()
		-- 重建列表
		for entityName , count in pairs( tabSettings.MaxSlot.List ) do
			local entityPrototype = game.entity_prototypes[entityName]
			local entityTooltip = nil
			local entity = entityName
			local maxCount = 0
			if entityPrototype then
				entityTooltip = { "SICore.紫图-窗口-最大格子-实体-提示" , entityPrototype.localised_name }
				local type = entityPrototype.type
				if type == SICommon.Types.Entities.Container or type == SICommon.Types.Entities.ContainerLogic then
					maxCount = entityPrototype.get_inventory_size( defines.inventory.chest ) or 0
				elseif type == SICommon.Types.Entities.Car then
					maxCount = entityPrototype.get_inventory_size( defines.inventory.car_trunk ) or 0
				elseif type == SICommon.Types.Entities.SpiderVehicle then
					maxCount = entityPrototype.get_inventory_size( defines.inventory.spider_trunk ) or 0
				elseif type == SICommon.Types.Entities.WagonCargo then
					maxCount = entityPrototype.get_inventory_size( defines.inventory.cargo_wagon ) or 0
				else
					maxCount = 0
				end
			else
				entityTooltip = { "SICore.紫图-窗口-最大格子-实体-空-提示" , entity }
				entity = SIConstants_Core.raw.Entities.IconEmpty
				maxCount = 0
			end
			list.add
			{
				type = "choose-elem-button" ,
				name = SIRequestMap.Names.MaxSlot_Entity_Prefix .. entityName ,
				tooltip = entityTooltip ,
				elem_type = "entity" ,
				entity = entity ,
				elem_filters = SIRequestMap.MaxSlot_Entity_Filters ,
				style = SIConstants_Core.raw.Styles.RequestMap_ListChooser
			}
			local flow = list.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.RequestMap_ListFlow }
			flow.add{ type = "label" , caption = { "SICore.紫图-窗口-最大格子-数量前缀" , maxCount } , tooltip = { "SICore.紫图-窗口-最大格子-数量-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_ListLabel }
			flow.add{ type = "textfield" , name = SIRequestMap.Names.MaxSlot_Count_Prefix .. entityName , text = tostring( count ) , numeric = true , tooltip = { "SICore.紫图-窗口-最大格子-数量-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_ListText }
			flow.add{ type = "label" , caption = { "SICore.紫图-窗口-最大格子-数量后缀" } , tooltip = { "SICore.紫图-窗口-最大格子-数量-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_ListLabel }
		end
		list.add
		{
			type = "choose-elem-button" ,
			name = SIRequestMap.Names.MaxSlot_Entity_Prefix ,
			tooltip = { "SICore.紫图-窗口-最大格子-实体-选择" } ,
			elem_type = "entity" ,
			entity = nil ,
			elem_filters = SIRequestMap.MaxSlot_Entity_Filters ,
			style = SIConstants_Core.raw.Styles.RequestMap_ListChooser
		}
	end ,
	FreshPage_GreenToBlue = function( settings , tabSettings , elements )
		-- 更新说明
		elements.GreenToBlue_Enable.caption = { "SICore.紫图-窗口-绿箱向蓝箱供货-启用" , { tabSettings.GreenToBlue.Check and "SICore.紫图-窗口-启用-未设置" or "SICore.紫图-窗口-启用-已设置" } }
	end ,
	FreshPage_SetModule = function( settings , tabSettings , elements )
		-- 更新说明
		SIRequestMap.FreshPage_SetModule_Enable( settings , tabSettings , elements )
		-- 清空列表
		local list = elements.SetModule_List
		list.clear()
		-- 重建列表
		for entityName , moduleList in pairs( tabSettings.SetModule.List ) do
			local entityPrototype = game.entity_prototypes[entityName]
			local entityTooltip = nil
			local entity = entityName
			local maxSlot = 0
			if entityPrototype then
				entityTooltip = { "SICore.紫图-窗口-设置插件-实体-提示" , entityPrototype.localised_name }
				local type = entityPrototype.type
				if type == SICommon.Types.Entities.Machine then
					maxSlot = entityPrototype.get_inventory_size( defines.inventory.assembling_machine_modules ) or 0
				elseif type == SICommon.Types.Entities.Furnace then
					maxSlot = entityPrototype.get_inventory_size( defines.inventory.furnace_modules ) or 0
				elseif type == SICommon.Types.Entities.Lab then
					maxSlot = entityPrototype.get_inventory_size( defines.inventory.lab_modules ) or 0
				elseif type == SICommon.Types.Entities.Mining then
					maxSlot = entityPrototype.get_inventory_size( defines.inventory.mining_drill_modules ) or 0
				elseif type == SICommon.Types.Entities.RocketSilo then
					maxSlot = entityPrototype.get_inventory_size( defines.inventory.rocket_silo_modules ) or 0
				elseif type == SICommon.Types.Entities.Beacon then
					maxSlot = entityPrototype.get_inventory_size( defines.inventory.beacon_modules ) or 0
				else
					maxSlot = 0
				end
			else
				entityTooltip = { "SICore.紫图-窗口-设置插件-实体-空-提示" , entity }
				entity = SIConstants_Core.raw.Entities.IconEmpty
				for key , value in pairs( moduleList ) do
					maxSlot = math.max( maxSlot , key )
				end
			end
			list.add
			{
				type = "choose-elem-button" ,
				name = SIRequestMap.Names.SetModule_Entity_Prefix .. entityName ,
				tooltip = entityTooltip ,
				elem_type = "entity" ,
				entity = entity ,
				elem_filters = SIRequestMap.SetModule_Entity_Filters ,
				style = SIConstants_Core.raw.Styles.RequestMap_ListChooser
			}
			local selectList1 = list.add{ type = "table" , column_count = 10 , style = SIConstants_Core.raw.Styles.RequestMap_SelectList }
			local selectList2 = list.add{ type = "table" , column_count = 10 , style = SIConstants_Core.raw.Styles.RequestMap_SelectList }
			for slotIndex = 1 , maxSlot , 1 do
				local selectList = math.fmod( math.floor( slotIndex / 10 ) , 2 ) == 0 and selectList1 or selectList2
				local itemTooltip = nil
				local item = moduleList[slotIndex]
				if item then
					local itemPrototype = game.item_prototypes[item]
					if itemPrototype then
						itemTooltip = { "SICore.紫图-窗口-设置插件-物品-提示" , itemPrototype.localised_name }
					else
						itemTooltip = { "SICore.紫图-窗口-设置插件-物品-空-提示" , item }
						item = SIConstants_Core.raw.Items.IconEmpty
					end
				else
					itemTooltip = { "SICore.紫图-窗口-设置插件-物品-选择-提示" }
				end
				selectList.add
				{
					type = "choose-elem-button" ,
					name = SIRequestMap.Names.SetModule_Item_Prefix .. slotIndex .. "_" .. entityName ,
					tooltip = itemTooltip ,
					elem_type = "item" ,
					item = item ,
					elem_filters = SIRequestMap.SetModule_Item_Filters ,
					style = SIConstants_Core.raw.Styles.RequestMap_ListChooser
				}
			end
		end
		list.add
		{
			type = "choose-elem-button" ,
			name = SIRequestMap.Names.SetModule_Entity_Prefix ,
			tooltip = { "SICore.紫图-窗口-设置插件-实体-选择-提示" } ,
			elem_type = "entity" ,
			entity = nil ,
			elem_filters = SIRequestMap.SetModule_Entity_Filters ,
			style = SIConstants_Core.raw.Styles.RequestMap_ListChooser
		}
	end ,
	FreshPage_SetModule_Enable = function( settings , tabSettings , elements )
		-- 更新说明
		elements.SetModule_Enable.caption = { "SICore.紫图-窗口-设置插件-启用" , { ( tabSettings.SetModule.FromInventory or SITable.Size( tabSettings.SetModule.List ) > 0 ) and "SICore.紫图-窗口-启用-已设置" or "SICore.紫图-窗口-启用-未设置" } }
	end ,
	FreshPage_RemoveModule = function( settings , tabSettings , elements )
		-- 更新说明
		SIRequestMap.FreshPage_RemoveModule_Enable( settings , tabSettings , elements )
		-- 清空列表
		local list = elements.RemoveModule_List
		list.clear()
		-- 重建列表
		for entityName , moduleList in pairs( tabSettings.RemoveModule.List ) do
			local entityPrototype = game.entity_prototypes[entityName]
			local entityTooltip = nil
			local entity = entityName
			local maxSlot = 0
			if entityPrototype then
				entityTooltip = { "SICore.紫图-窗口-移除插件-实体-提示" , entityPrototype.localised_name }
				local type = entityPrototype.type
				if type == SICommon.Types.Entities.Machine then
					maxSlot = entityPrototype.get_inventory_size( defines.inventory.assembling_machine_modules ) or 0
				elseif type == SICommon.Types.Entities.Furnace then
					maxSlot = entityPrototype.get_inventory_size( defines.inventory.furnace_modules ) or 0
				elseif type == SICommon.Types.Entities.Lab then
					maxSlot = entityPrototype.get_inventory_size( defines.inventory.lab_modules ) or 0
				elseif type == SICommon.Types.Entities.Mining then
					maxSlot = entityPrototype.get_inventory_size( defines.inventory.mining_drill_modules ) or 0
				elseif type == SICommon.Types.Entities.RocketSilo then
					maxSlot = entityPrototype.get_inventory_size( defines.inventory.rocket_silo_modules ) or 0
				elseif type == SICommon.Types.Entities.Beacon then
					maxSlot = entityPrototype.get_inventory_size( defines.inventory.beacon_modules ) or 0
				else
					maxSlot = 0
				end
			else
				entityTooltip = { "SICore.紫图-窗口-移除插件-实体-空-提示" , entity }
				entity = SIConstants_Core.raw.Entities.IconEmpty
				for key , value in pairs( moduleList ) do
					maxSlot = math.max( maxSlot , key )
				end
			end
			list.add
			{
				type = "choose-elem-button" ,
				name = SIRequestMap.Names.RemoveModule_Entity_Prefix .. entityName ,
				tooltip = entityTooltip ,
				elem_type = "entity" ,
				entity = entity ,
				elem_filters = SIRequestMap.RemoveModule_Entity_Filters ,
				style = SIConstants_Core.raw.Styles.RequestMap_ListChooser
			}
			local selectList1 = list.add{ type = "table" , column_count = 10 , style = SIConstants_Core.raw.Styles.RequestMap_SelectList }
			local selectList2 = list.add{ type = "table" , column_count = 10 , style = SIConstants_Core.raw.Styles.RequestMap_SelectList }
			for slotIndex = 1 , maxSlot , 1 do
				local selectList = math.fmod( math.floor( slotIndex / 10 ) , 2 ) == 0 and selectList1 or selectList2
				local itemTooltip = nil
				local item = moduleList[slotIndex]
				if item then
					local itemPrototype = game.item_prototypes[item]
					if itemPrototype then
						itemTooltip = { "SICore.紫图-窗口-移除插件-物品-提示" , itemPrototype.localised_name }
					else
						itemTooltip = { "SICore.紫图-窗口-移除插件-物品-空-提示" , item }
						item = SIConstants_Core.raw.Items.IconEmpty
					end
				else
					itemTooltip = { "SICore.紫图-窗口-移除插件-物品-选择-提示" }
				end
				selectList.add
				{
					type = "choose-elem-button" ,
					name = SIRequestMap.Names.RemoveModule_Item_Prefix .. slotIndex .. "_" .. entityName ,
					tooltip = itemTooltip ,
					elem_type = "item" ,
					item = item ,
					elem_filters = SIRequestMap.RemoveModule_Item_Filters ,
					style = SIConstants_Core.raw.Styles.RequestMap_ListChooser
				}
			end
		end
		list.add
		{
			type = "choose-elem-button" ,
			name = SIRequestMap.Names.RemoveModule_Entity_Prefix ,
			tooltip = { "SICore.紫图-窗口-移除插件-实体-选择-提示" } ,
			elem_type = "entity" ,
			entity = nil ,
			elem_filters = SIRequestMap.RemoveModule_Entity_Filters ,
			style = SIConstants_Core.raw.Styles.RequestMap_ListChooser
		}
	end ,
	FreshPage_RemoveModule_Enable = function( settings , tabSettings , elements )
		-- 更新说明
		elements.RemoveModule_Enable.caption = { "SICore.紫图-窗口-移除插件-启用" , { ( tabSettings.RemoveModule.ToInventory or tabSettings.RemoveModule.Invert or SITable.Size( tabSettings.RemoveModule.List ) > 0 ) and "SICore.紫图-窗口-启用-已设置" or "SICore.紫图-窗口-启用-未设置" } }
	end ,
	FreshPage_InsertFuel = function( settings , tabSettings , elements )
		-- 更新说明
		elements.InsertFuel_Enable.caption = { "SICore.紫图-窗口-插入燃料-启用" , { SITable.Size( tabSettings.InsertFuel.List ) > 0 and "SICore.紫图-窗口-启用-已设置" or "SICore.紫图-窗口-启用-未设置" } }
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
					name = SIRequestMap.Names.InsertFuel_Entity_Prefix .. entityName ,
					tooltip = { "SICore.紫图-窗口-插入燃料-实体-提示" , entityPrototype.localised_name } ,
					elem_type = "entity" ,
					entity = entityName ,
					elem_filters = SIRequestMap.InsertFuel_Entity_Filters ,
					style = SIConstants_Core.raw.Styles.RequestMap_ListChooser
				}
				if entityPrototype.burner_prototype then
					local fuelFilter = SIUtils.table.deepcopy( SIRequestMap.InsertFuel_Item_Filters )
					fuelFilter[1]["fuel-category"] = entityPrototype.burner_prototype.fuel_categories
					for itemDataIndex = 1 , entityPrototype.burner_prototype.fuel_inventory_size , 1 do
						local itemData = itemDataList[itemDataIndex]
						if not itemData then
							itemData = {}
							itemDataList[itemDataIndex] = itemData
						end
						local itemTooltip = nil
						local item = itemData.Item
						if item then
							local itemPrototype = game.item_prototypes[item]
							if itemPrototype then
								itemTooltip = { "SICore.紫图-窗口-插入燃料-物品-提示" , itemPrototype.localised_name }
							else
								itemTooltip = { "SICore.紫图-窗口-插入燃料-物品-空-提示" , item }
								item = SIConstants_Core.raw.Items.IconEmpty
							end
						else
							itemTooltip = { "SICore.紫图-窗口-插入燃料-物品-选择-提示" }
						end
						list.add
						{
							type = "choose-elem-button" ,
							name = SIRequestMap.Names.InsertFuel_Item_Prefix .. itemDataIndex .. "_" .. entityName ,
							tooltip = itemTooltip ,
							elem_type = "item" ,
							item = item ,
							elem_filters = fuelFilter ,
							style = SIConstants_Core.raw.Styles.RequestMap_ListChooser
						}
						list.add{ type = "label" , caption = { "SICore.紫图-窗口-插入燃料-数量" } , tooltip = { "SICore.紫图-窗口-插入燃料-数量-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_ListLabel }
						list.add{ type = "textfield" , name = SIRequestMap.Names.InsertFuel_Count_Prefix .. itemDataIndex .. "_" .. entityName , text = tostring( itemData.Count or 1 ) , numeric = true , tooltip = { "SICore.紫图-窗口-插入燃料-数量-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_ListText }
						list.add{ type = "label" , caption = { "SICore.紫图-窗口-插入燃料-模式" } , tooltip = { "SICore.紫图-窗口-插入燃料-模式-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_ListLabel }
						list.add
						{
							type = "drop-down" ,
							name = SIRequestMap.Names.InsertFuel_Mode_Prefix .. itemDataIndex .. "_" .. entityName ,
							caption = { "SICore.紫图-窗口-插入燃料-模式" } ,
							tooltip = { "SICore.紫图-窗口-插入燃料-模式-提示" } ,
							items = SIRequestMap.CountModeText ,
							selected_index = itemData.Mode or 1 ,
							style = SIConstants_Core.raw.Styles.RequestMap_ListDropDown
						}
					end
				end
			else
				list.add
				{
					type = "choose-elem-button" ,
					name = SIRequestMap.Names.InsertFuel_Entity_Prefix .. entityName ,
					tooltip = { "SICore.紫图-窗口-插入燃料-实体-空-提示" , entityName } ,
					elem_type = "entity" ,
					entity = SIConstants_Core.raw.Entities.IconEmpty ,
					elem_filters = SIRequestMap.InsertFuel_Entity_Filters ,
					style = SIConstants_Core.raw.Styles.RequestMap_ListChooser
				}
				local fuelFilter = SIUtils.table.deepcopy( SIRequestMap.InsertFuel_Item_Filters )
				fuelFilter[1]["fuel-category"] = "chemical"
				for itemDataIndex , itemData in pairs( itemDataList ) do
					local itemTooltip = nil
					local item = itemData.Item
					if item then
						local itemPrototype = game.item_prototypes[item]
						if itemPrototype then
							itemTooltip = { "SICore.紫图-窗口-插入燃料-物品-提示" , itemPrototype.localised_name }
						else
							itemTooltip = { "SICore.紫图-窗口-插入燃料-物品-空-提示" , item }
							item = SIConstants_Core.raw.Items.IconEmpty
						end
					else
						itemTooltip = { "SICore.紫图-窗口-插入燃料-物品-选择-提示" }
					end
					list.add
					{
						type = "choose-elem-button" ,
						name = SIRequestMap.Names.InsertFuel_Item_Prefix .. itemDataIndex .. "_" .. entityName ,
						tooltip = itemTooltip ,
						elem_type = "item" ,
						item = item ,
						elem_filters = fuelFilter ,
						style = SIConstants_Core.raw.Styles.RequestMap_ListChooser
					}
					list.add{ type = "label" , caption = { "SICore.紫图-窗口-插入燃料-数量" } , tooltip = { "SICore.紫图-窗口-插入燃料-数量-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_ListLabel }
					list.add{ type = "textfield" , name = SIRequestMap.Names.InsertFuel_Count_Prefix .. itemDataIndex .. "_" .. entityName , text = tostring( itemData.Count or 1 ) , numeric = true , tooltip = { "SICore.紫图-窗口-插入燃料-数量-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_ListText }
					list.add{ type = "label" , caption = { "SICore.紫图-窗口-插入燃料-模式" } , tooltip = { "SICore.紫图-窗口-插入燃料-模式-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_ListLabel }
					list.add
					{
						type = "drop-down" ,
						name = SIRequestMap.Names.InsertFuel_Mode_Prefix .. itemDataIndex .. "_" .. entityName ,
						caption = { "SICore.紫图-窗口-插入燃料-模式" } ,
						tooltip = { "SICore.紫图-窗口-插入燃料-模式-提示" } ,
						items = SIRequestMap.CountModeText ,
						selected_index = itemData.Mode or 1 ,
						style = SIConstants_Core.raw.Styles.RequestMap_ListDropDown
					}
				end
			end
		end
		list.add
		{
			type = "choose-elem-button" ,
			name = SIRequestMap.Names.InsertFuel_Entity_Prefix ,
			tooltip = { "SICore.紫图-窗口-插入燃料-实体-选择-提示" } ,
			elem_type = "entity" ,
			entity = nil ,
			elem_filters = SIRequestMap.InsertFuel_Entity_Filters ,
			style = SIConstants_Core.raw.Styles.RequestMap_ListChooser
		}
	end ,
	FreshPage_InsertAmmo = function( settings , tabSettings , elements )
		-- 更新说明
		elements.InsertAmmo_Enable.caption = { "SICore.紫图-窗口-插入弹药-启用" , { SITable.Size( tabSettings.InsertAmmo.List ) > 0 and "SICore.紫图-窗口-启用-已设置" or "SICore.紫图-窗口-启用-未设置" } }
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
					name = SIRequestMap.Names.InsertAmmo_Entity_Prefix .. entityName ,
					tooltip = { "SICore.紫图-窗口-插入弹药-实体-提示" , entityPrototype.localised_name } ,
					elem_type = "entity" ,
					entity = entityName ,
					elem_filters = SIRequestMap.InsertAmmo_Entity_Filters ,
					style = SIConstants_Core.raw.Styles.RequestMap_ListChooser
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
				for itemDataIndex = 1 , maxAmmoSize , 1 do
					local itemData = itemDataList[itemDataIndex]
					if not itemData then
						itemData = {}
						itemDataList[itemDataIndex] = itemData
					end
					local weapon = entityPrototype.indexed_guns[itemDataIndex]
					local weaponChooser = list.add
					{
						type = "choose-elem-button" ,
						tooltip = { "SICore.紫图-窗口-插入弹药-武器-提示" , weapon.localised_name } ,
						elem_type = "item" ,
						item = weapon ,
						style = SIConstants_Core.raw.Styles.RequestMap_ListChooser
					}
					weaponChooser.enabled = false
					local itemTooltip = nil
					local item = itemData.Item
					if item then
						local itemPrototype = game.item_prototypes[item]
						if itemPrototype then
							itemTooltip = { "SICore.紫图-窗口-插入弹药-物品-提示" , itemPrototype.localised_name }
						else
							itemTooltip = { "SICore.紫图-窗口-插入弹药-物品-空-提示" , item }
							item = SIConstants_Core.raw.Items.IconEmpty
						end
					else
						itemTooltip = { "SICore.紫图-窗口-插入弹药-物品-选择-提示" }
					end
					list.add
					{
						type = "choose-elem-button" ,
						name = SIRequestMap.Names.InsertAmmo_Item_Prefix .. itemDataIndex .. "_" .. entityName ,
						tooltip = itemTooltip ,
						elem_type = "item" ,
						item = item ,
						elem_filters = SIRequestMap.InsertAmmo_Item_Filters ,
						style = SIConstants_Core.raw.Styles.RequestMap_ListChooser
					}
					list.add{ type = "label" , caption = { "SICore.紫图-窗口-插入弹药-数量" } , tooltip = { "SICore.紫图-窗口-插入弹药-数量-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_ListLabel }
					list.add{ type = "textfield" , name = SIRequestMap.Names.InsertAmmo_Count_Prefix .. itemDataIndex .. "_" .. entityName , text = tostring( itemData.Count or 1 ) , numeric = true , tooltip = { "SICore.紫图-窗口-插入弹药-数量-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_ListText }
					list.add{ type = "label" , caption = { "SICore.紫图-窗口-插入弹药-模式" } , tooltip = { "SICore.紫图-窗口-插入弹药-模式-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_ListLabel }
					list.add
					{
						type = "drop-down" ,
						name = SIRequestMap.Names.InsertAmmo_Mode_Prefix .. itemDataIndex .. "_" .. entityName ,
						caption = { "SICore.紫图-窗口-插入弹药-模式" } ,
						tooltip = { "SICore.紫图-窗口-插入弹药-模式-提示" } ,
						items = SIRequestMap.CountModeText ,
						selected_index = itemData.Mode or 1 ,
						style = SIConstants_Core.raw.Styles.RequestMap_ListDropDown
					}
				end
			else
				list.add
				{
					type = "choose-elem-button" ,
					name = SIRequestMap.Names.InsertAmmo_Entity_Prefix .. entityName ,
					tooltip = { "SICore.紫图-窗口-插入弹药-实体-空-提示" , entityName } ,
					elem_type = "entity" ,
					entity = SIConstants_Core.raw.Entities.IconEmpty ,
					elem_filters = SIRequestMap.InsertAmmo_Entity_Filters ,
					style = SIConstants_Core.raw.Styles.RequestMap_ListChooser
				}
				for itemDataIndex , itemData in pairs( itemDataList ) do
					local weaponChooser = list.add
					{
						type = "choose-elem-button" ,
						tooltip = { "SICore.紫图-窗口-插入弹药-武器-空-提示" , entityName } ,
						elem_type = "item" ,
						item = SIConstants_Core.raw.Items.IconEmpty ,
						style = SIConstants_Core.raw.Styles.RequestMap_ListChooser
					}
					weaponChooser.enabled = false
					local itemTooltip = nil
					local item = itemData.Item
					if item then
						local itemPrototype = game.item_prototypes[item]
						if itemPrototype then
							itemTooltip = { "SICore.紫图-窗口-插入弹药-物品-提示" , itemPrototype.localised_name }
						else
							itemTooltip = { "SICore.紫图-窗口-插入弹药-物品-空-提示" , item }
							item = SIConstants_Core.raw.Items.IconEmpty
						end
					else
						itemTooltip = { "SICore.紫图-窗口-插入弹药-物品-选择-提示" }
					end
					list.add
					{
						type = "choose-elem-button" ,
						name = SIRequestMap.Names.InsertAmmo_Item_Prefix .. itemDataIndex .. "_" .. entityName ,
						tooltip = itemTooltip ,
						elem_type = "item" ,
						item = item ,
						elem_filters = SIRequestMap.InsertAmmo_Item_Filters ,
						style = SIConstants_Core.raw.Styles.RequestMap_ListChooser
					}
					list.add{ type = "label" , caption = { "SICore.紫图-窗口-插入弹药-数量" } , tooltip = { "SICore.紫图-窗口-插入弹药-数量-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_ListLabel }
					list.add{ type = "textfield" , name = SIRequestMap.Names.InsertAmmo_Count_Prefix .. itemDataIndex .. "_" .. entityName , text = tostring( itemData.Count or 1 ) , numeric = true , tooltip = { "SICore.紫图-窗口-插入弹药-数量-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_ListText }
					list.add{ type = "label" , caption = { "SICore.紫图-窗口-插入弹药-模式" } , tooltip = { "SICore.紫图-窗口-插入弹药-模式-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_ListLabel }
					list.add
					{
						type = "drop-down" ,
						name = SIRequestMap.Names.InsertAmmo_Mode_Prefix .. itemDataIndex .. "_" .. entityName ,
						caption = { "SICore.紫图-窗口-插入弹药-模式" } ,
						tooltip = { "SICore.紫图-窗口-插入弹药-模式-提示" } ,
						items = SIRequestMap.CountModeText ,
						selected_index = itemData.Mode or 1 ,
						style = SIConstants_Core.raw.Styles.RequestMap_ListDropDown
					}
				end
			end
		end
		list.add
		{
			type = "choose-elem-button" ,
			name = SIRequestMap.Names.InsertAmmo_Entity_Prefix ,
			tooltip = { "SICore.紫图-窗口-插入弹药-实体-选择-提示" } ,
			elem_type = "entity" ,
			entity = nil ,
			elem_filters = SIRequestMap.InsertAmmo_Entity_Filters ,
			style = SIConstants_Core.raw.Styles.RequestMap_ListChooser
		}
	end ,
	Out_AddTabSettings = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			SIRequestMap.CreateTabSettings( settings )
			SIRequestMap.CreateTab( settings )
		end
	end ,
	Out_DeleteTabSettings = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			SIRequestMap.DeleteTabSettings( settings )
			SIRequestMap.CreateTab( settings )
		end
	end ,
	SwitchTab = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			local tabSettingsIndex = settings.tabPane.selected_tab_index or 1
			settings.tabSettingsIndex = SITools.AsNumber( tabSettingsIndex , 1 , #settings.TabList )
			SIRequestMap.FreshPage( settings )
		end
	end ,
	ListScroll = function( playerIndex , name )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			local tabSettingsIndex = settings.tabSettingsIndex
			local key = name:sub( SIRequestMap.Names.ListButtonPosition )
			settings.scroll.scroll_to_element( settings.Elements[tabSettingsIndex][key] , "top-third" )
		end
	end ,
	EnableFunction = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			local tabSettingsIndex = settings.tabSettingsIndex
			local key = name:sub( SIRequestMap.Names.EnablePosition )
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
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			local tabSettingsIndex = settings.tabSettingsIndex
			settings.TabList[tabSettingsIndex].caption = { "SICore.紫图-窗口-分页标题" , element.text }
			-- 保存 [设置名称] 复选框的值
			local tabSettings = settings.TabSettingsList[tabSettingsIndex]
			tabSettings.Name = element.text
		end
	end ,
	Set_DefaultIndex = function( playerIndex , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			local selectedIndex = element.selected_index
			if not selectedIndex then
				element.selected_index = 1
				selectedIndex = 1
			end
			local tabSettingsIndex = settings.tabSettingsIndex
			-- 清除原有默认选择值
			if settings.defaultIndex1 == tabSettingsIndex then
				settings.defaultIndex1 = 0
			end
			if settings.defaultIndex2 == tabSettingsIndex then
				settings.defaultIndex2 = 0
			end
			if settings.defaultIndex3 == tabSettingsIndex then
				settings.defaultIndex3 = 0
			end
			if settings.defaultIndex4 == tabSettingsIndex then
				settings.defaultIndex4 = 0
			end
			-- 设置新的默认选择值
			if selectedIndex == 2 then
				settings.defaultIndex1 = tabSettingsIndex
			elseif selectedIndex == 3 then
				settings.defaultIndex2 = tabSettingsIndex
			elseif selectedIndex == 4 then
				settings.defaultIndex3 = tabSettingsIndex
			elseif selectedIndex == 5 then
				settings.defaultIndex4 = tabSettingsIndex
			end
		end
	end ,
	Set_RequestSlot_Entity = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [请求格子-实体] 选择的实体
			local selectEntityName = element.elem_value
			local tabSettingsIndex = settings.tabSettingsIndex
			local tabSettings = settings.TabSettingsList[tabSettingsIndex]
			local requestList = tabSettings.RequestSlot.List
			local entityName = name:sub( SIRequestMap.Names.RequestSlot_Entity_Position )
			if requestList[entityName] then
				if entityName == selectEntityName then
					return
				else
					if selectEntityName == nil then
						requestList[entityName] = nil
					else
						local newRequestList = {}
						for innerEntityName , requestItemList in pairs( requestList ) do
							if entityName == innerEntityName then
								newRequestList[selectEntityName] = {}
							else
								newRequestList[innerEntityName] = requestItemList
							end
						end
						tabSettings.RequestSlot.List = newRequestList
					end
				end
			else
				if selectEntityName == nil then
					return
				end
				if requestList[selectEntityName] then
					SIPrint.Warning( playerIndex , { "SICore.紫图-提示-请求格子-已存在" , selectEntityName , game.entity_prototypes[selectEntityName].localised_name } )
					element.elem_value = nil
					return
				end
				requestList[selectEntityName] = {}
			end
			SIRequestMap.FreshPage_RequestSlot( settings , tabSettings , settings.Elements[tabSettingsIndex] )
		end
	end ,
	Set_RequestSlot_Item = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [请求格子-物品] 选择的物品
			local selectItemName = element.elem_value
			local key = name:sub( SIRequestMap.Names.RequestSlot_Item_Position )
			local location = key:find( "_" )
			local slotIndex = tonumber( key:sub( 1 , location - 1 ) )
			if slotIndex and slotIndex > 0 and slotIndex < SIRequestMap.RequestSlot_ItemSlotMax then
				local entityName = key:sub( location + 1 )
				local tabSettingsIndex = settings.tabSettingsIndex
				local tabSettings = settings.TabSettingsList[tabSettingsIndex]
				local requestList = tabSettings.RequestSlot.List
				requestList[entityName][slotIndex] = selectItemName
				-- 如果是无限格子的 物流箱子 / 爪子 / 装卸机 等实体 , 则追加更新 UI , 因为要考虑是否新增一个选择物品的格子
				local entityPrototype = game.entity_prototypes[entityName]
				if entityPrototype then
					local type = entityPrototype.type
					if type == SICommon.Types.Entities.ContainerLogic or type == SICommon.Types.Entities.Inserter or type == SICommon.Types.Entities.BeltLoader or type == SICommon.Types.Entities.BeltLoaderSmall then
						if not entityPrototype.filter_count then
							SIRequestMap.FreshPage_RequestSlot( settings , tabSettings , settings.Elements[tabSettingsIndex] )
						end
					end
				end
			end
		end
	end ,
	Set_MaxSlot_Entity = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [最大格子-实体] 选择的实体
			local selectEntityName = element.elem_value
			local tabSettingsIndex = settings.tabSettingsIndex
			local tabSettings = settings.TabSettingsList[tabSettingsIndex]
			local countList = tabSettings.MaxSlot.List
			local entityName = name:sub( SIRequestMap.Names.MaxSlot_Entity_Position )
			if countList[entityName] then
				if entityName == selectEntityName then
					return
				else
					if selectEntityName == nil then
						countList[entityName] = nil
					else
						local newCountList = {}
						for innerEntityName , requestItemList in pairs( countList ) do
							if entityName == innerEntityName then
								newCountList[selectEntityName] = {}
							else
								newCountList[innerEntityName] = requestItemList
							end
						end
						tabSettings.MaxSlot.List = newCountList
					end
				end
			else
				if selectEntityName == nil then
					return
				end
				if countList[selectEntityName] then
					SIPrint.Warning( playerIndex , { "SICore.紫图-提示-最大格子-已存在" , selectEntityName , game.entity_prototypes[selectEntityName].localised_name } )
					element.elem_value = nil
					return
				end
				countList[selectEntityName] = {}
			end
			SIRequestMap.FreshPage_MaxSlot( settings , tabSettings , settings.Elements[tabSettingsIndex] )
		end
	end ,
	Set_MaxSlot_Count = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [最大格子-数量] 填写的数量
			local count = math.floor( tonumber( element.text ) or 0 )
			element.text = tostring( count )
			local tabSettingsIndex = settings.tabSettingsIndex
			local tabSettings = settings.TabSettingsList[tabSettingsIndex]
			local countList = tabSettings.MaxSlot.List
			local entityName = name:sub( SIRequestMap.Names.MaxSlot_Count_Position )
			countList[entityName] = count
		end
	end ,
	Set_GreenToBlue_Check = function( playerIndex , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [绿箱向蓝箱供货-勾选] 复选框的值
			local tabSettingsIndex = settings.tabSettingsIndex
			local tabSettings = settings.TabSettingsList[tabSettingsIndex]
			tabSettings.GreenToBlue.Check = element.state
			SIRequestMap.FreshPage_GreenToBlue( settings , tabSettings , settings.Elements[tabSettingsIndex] )
		end
	end ,
	Set_SetModule_FromInventory = function( playerIndex , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [设置插件-从背包填充] 复选框的值
			local tabSettingsIndex = settings.tabSettingsIndex
			local tabSettings = settings.TabSettingsList[tabSettingsIndex]
			tabSettings.SetModule.FromInventory = element.state
			SIRequestMap.FreshPage_SetModule_Enable( settings , tabSettings , settings.Elements[tabSettingsIndex] )
		end
	end ,
	Set_SetModule_Entity = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [设置插件-实体] 选择的实体
			local selectEntityName = element.elem_value
			local tabSettingsIndex = settings.tabSettingsIndex
			local tabSettings = settings.TabSettingsList[tabSettingsIndex]
			local moduleList = tabSettings.SetModule.List
			local entityName = name:sub( SIRequestMap.Names.SetModule_Entity_Position )
			if moduleList[entityName] then
				if entityName == selectEntityName then
					return
				else
					if selectEntityName == nil then
						moduleList[entityName] = nil
					else
						local newModuleList = {}
						for innerEntityName , requestItemList in pairs( moduleList ) do
							if entityName == innerEntityName then
								newModuleList[selectEntityName] = {}
							else
								newModuleList[innerEntityName] = requestItemList
							end
						end
						tabSettings.SetModule.List = newModuleList
					end
				end
			else
				if selectEntityName == nil then
					return
				end
				if moduleList[selectEntityName] then
					SIPrint.Warning( playerIndex , { "SICore.紫图-提示-设置插件-已存在" , selectEntityName , game.entity_prototypes[selectEntityName].localised_name } )
					element.elem_value = nil
					return
				end
				moduleList[selectEntityName] = {}
			end
			SIRequestMap.FreshPage_SetModule( settings , tabSettings , settings.Elements[tabSettingsIndex] )
		end
	end ,
	Set_SetModule_Item = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [设置插件-物品] 选择的物品
			local selectItemName = element.elem_value
			local key = name:sub( SIRequestMap.Names.SetModule_Item_Position )
			local location = key:find( "_" )
			local slotIndex = tonumber( key:sub( 1 , location - 1 ) )
			if slotIndex and slotIndex > 0 then
				local entityName = key:sub( location + 1 )
				local tabSettingsIndex = settings.tabSettingsIndex
				local tabSettings = settings.TabSettingsList[tabSettingsIndex]
				local moduleList = tabSettings.SetModule.List
				moduleList[entityName][slotIndex] = selectItemName
			end
		end
	end ,
	Set_RemoveModule_ToInventory = function( playerIndex , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [移除插件-进入背包] 复选框的值
			local tabSettingsIndex = settings.tabSettingsIndex
			local tabSettings = settings.TabSettingsList[tabSettingsIndex]
			tabSettings.RemoveModule.ToInventory = element.state
			SIRequestMap.FreshPage_RemoveModule_Enable( settings , tabSettings , settings.Elements[tabSettingsIndex] )
		end
	end ,
	Set_RemoveModule_Invert = function( playerIndex , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [移除插件-条件反转] 复选框的值
			local tabSettingsIndex = settings.tabSettingsIndex
			local tabSettings = settings.TabSettingsList[tabSettingsIndex]
			tabSettings.RemoveModule.Invert = element.state
			SIRequestMap.FreshPage_RemoveModule_Enable( settings , tabSettings , settings.Elements[tabSettingsIndex] )
		end
	end ,
	Set_RemoveModule_Entity = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [移除插件-实体] 选择的实体
			local selectEntityName = element.elem_value
			local tabSettingsIndex = settings.tabSettingsIndex
			local tabSettings = settings.TabSettingsList[tabSettingsIndex]
			local moduleList = tabSettings.RemoveModule.List
			local entityName = name:sub( SIRequestMap.Names.RemoveModule_Entity_Position )
			if moduleList[entityName] then
				if entityName == selectEntityName then
					return
				else
					if selectEntityName == nil then
						moduleList[entityName] = nil
					else
						local newModuleList = {}
						for innerEntityName , requestItemList in pairs( moduleList ) do
							if entityName == innerEntityName then
								newModuleList[selectEntityName] = {}
							else
								newModuleList[innerEntityName] = requestItemList
							end
						end
						tabSettings.RemoveModule.List = newModuleList
					end
				end
			else
				if selectEntityName == nil then
					return
				end
				if moduleList[selectEntityName] then
					SIPrint.Warning( playerIndex , { "SICore.紫图-提示-移除插件-已存在" , selectEntityName , game.entity_prototypes[selectEntityName].localised_name } )
					element.elem_value = nil
					return
				end
				moduleList[selectEntityName] = {}
			end
			SIRequestMap.FreshPage_RemoveModule( settings , tabSettings , settings.Elements[tabSettingsIndex] )
		end
	end ,
	Set_RemoveModule_Item = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [移除插件-物品] 选择的物品
			local selectItemName = element.elem_value
			local key = name:sub( SIRequestMap.Names.RemoveModule_Item_Position )
			local location = key:find( "_" )
			local slotIndex = tonumber( key:sub( 1 , location - 1 ) )
			if slotIndex and slotIndex > 0 then
				local entityName = key:sub( location + 1 )
				local tabSettingsIndex = settings.tabSettingsIndex
				local tabSettings = settings.TabSettingsList[tabSettingsIndex]
				local moduleList = tabSettings.RemoveModule.List
				moduleList[entityName][slotIndex] = selectItemName
			end
		end
	end ,
	Set_InsertFuel_Entity = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [插入燃料-实体] 选择的实体
			local selectEntityName = element.elem_value
			local tabSettingsIndex = settings.tabSettingsIndex
			local tabSettings = settings.TabSettingsList[tabSettingsIndex]
			local itemDataList = tabSettings.InsertFuel.List
			local entityName = name:sub( SIRequestMap.Names.InsertFuel_Entity_Position )
			if itemDataList[entityName] then
				if entityName == selectEntityName then
					return
				else
					if selectEntityName == nil then
						itemDataList[entityName] = nil
					else
						local newItemDataList = {}
						for innerEntityName , requestItemList in pairs( itemDataList ) do
							if entityName == innerEntityName then
								newItemDataList[selectEntityName] = {}
							else
								newItemDataList[innerEntityName] = requestItemList
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
					SIPrint.Warning( playerIndex , { "SICore.紫图-提示-插入燃料-已存在" , selectEntityName , game.entity_prototypes[selectEntityName].localised_name } )
					element.elem_value = nil
					return
				end
				itemDataList[selectEntityName] = {}
			end
			SIRequestMap.FreshPage_InsertFuel( settings , tabSettings , settings.Elements[tabSettingsIndex] )
		end
	end ,
	Set_InsertFuel_Item = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [插入燃料-物品] 选择的物品
			local selectItemName = element.elem_value
			local key = name:sub( SIRequestMap.Names.InsertFuel_Item_Position )
			local location = key:find( "_" )
			local itemDataIndex = tonumber( key:sub( 1 , location - 1 ) )
			if itemDataIndex and itemDataIndex > 0 then
				local entityName = key:sub( location + 1 )
				local tabSettingsIndex = settings.tabSettingsIndex
				local tabSettings = settings.TabSettingsList[tabSettingsIndex]
				local itemDataList = tabSettings.InsertFuel.List
				itemDataList[entityName][itemDataIndex].Item = selectItemName
			end
		end
	end ,
	Set_InsertFuel_Count = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [插入燃料-数量] 填写的数量
			local count = math.floor( tonumber( element.text ) or 0 )
			element.text = tostring( count )
			local key = name:sub( SIRequestMap.Names.InsertFuel_Count_Position )
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
	Set_InsertFuel_Mode = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [插入燃料-模式] 选择的模式
			local selectedIndex = element.selected_index or 1
			element.selected_index = selectedIndex
			local key = name:sub( SIRequestMap.Names.InsertFuel_Mode_Position )
			local location = key:find( "_" )
			local itemDataIndex = tonumber( key:sub( 1 , location - 1 ) )
			if itemDataIndex and itemDataIndex > 0 then
				local entityName = key:sub( location + 1 )
				local tabSettingsIndex = settings.tabSettingsIndex
				local tabSettings = settings.TabSettingsList[tabSettingsIndex]
				local itemDataList = tabSettings.InsertFuel.List
				itemDataList[entityName][itemDataIndex].Mode = selectedIndex
			end
		end
	end ,
	Set_InsertAmmo_Entity = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [插入弹药-实体] 选择的实体
			local selectEntityName = element.elem_value
			local tabSettingsIndex = settings.tabSettingsIndex
			local tabSettings = settings.TabSettingsList[tabSettingsIndex]
			local itemDataList = tabSettings.InsertAmmo.List
			local entityName = name:sub( SIRequestMap.Names.InsertAmmo_Entity_Position )
			if itemDataList[entityName] then
				if entityName == selectEntityName then
					return
				else
					if selectEntityName == nil then
						itemDataList[entityName] = nil
					else
						local newItemDataList = {}
						for innerEntityName , requestItemList in pairs( itemDataList ) do
							if entityName == innerEntityName then
								newItemDataList[selectEntityName] = {}
							else
								newItemDataList[innerEntityName] = requestItemList
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
					SIPrint.Warning( playerIndex , { "SICore.紫图-提示-插入弹药-已存在" , selectEntityName , game.entity_prototypes[selectEntityName].localised_name } )
					element.elem_value = nil
					return
				end
				itemDataList[selectEntityName] = {}
			end
			SIRequestMap.FreshPage_InsertAmmo( settings , tabSettings , settings.Elements[tabSettingsIndex] )
		end
	end ,
	Set_InsertAmmo_Item = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [插入弹药-物品] 选择的物品
			local selectItemName = element.elem_value
			local key = name:sub( SIRequestMap.Names.InsertAmmo_Item_Position )
			local location = key:find( "_" )
			local itemDataIndex = tonumber( key:sub( 1 , location - 1 ) )
			if itemDataIndex and itemDataIndex > 0 then
				local entityName = key:sub( location + 1 )
				local tabSettingsIndex = settings.tabSettingsIndex
				local tabSettings = settings.TabSettingsList[tabSettingsIndex]
				local itemDataList = tabSettings.InsertAmmo.List
				itemDataList[entityName][itemDataIndex].Item = selectItemName
			end
		end
	end ,
	Set_InsertAmmo_Count = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [插入弹药-数量] 填写的数量
			local count = math.floor( tonumber( element.text ) or 0 )
			element.text = tostring( count )
			local key = name:sub( SIRequestMap.Names.InsertAmmo_Count_Position )
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
	Set_InsertAmmo_Mode = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [插入弹药-模式] 选择的模式
			local selectedIndex = element.selected_index or 1
			element.selected_index = selectedIndex
			local key = name:sub( SIRequestMap.Names.InsertAmmo_Mode_Position )
			local location = key:find( "_" )
			local itemDataIndex = tonumber( key:sub( 1 , location - 1 ) )
			if itemDataIndex and itemDataIndex > 0 then
				local entityName = key:sub( location + 1 )
				local tabSettingsIndex = settings.tabSettingsIndex
				local tabSettings = settings.TabSettingsList[tabSettingsIndex]
				local itemDataList = tabSettings.InsertAmmo.List
				itemDataList[entityName][itemDataIndex].Mode = selectedIndex
			end
		end
	end ,
	EffectTabSettings = function( settings , tabSettingsIndex )
		local tabSettings = settings.TabSettingsList[tabSettingsIndex]
		local entities = settings.entities
		-- ----------------------------------------
		-- 请求格子
		-- ----------------------------------------
		-- ----------------------------------------
		-- 最大格子
		-- ----------------------------------------
		-- ----------------------------------------
		-- 绿箱向蓝箱供货
		-- ----------------------------------------
		-- ----------------------------------------
		-- 设置插件
		-- ----------------------------------------
		-- ----------------------------------------
		-- 移除插件
		-- ----------------------------------------
		-- ----------------------------------------
		-- 插入燃料
		-- ----------------------------------------
	end ,
	EffectSelect1 = function( playerIndex , entities )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		settings.entities = entities
		local defaultIndex = settings.defaultIndex1
		if defaultIndex < 1 or defaultIndex > #settings.TabSettingsList then
			if not settings.frame or not settings.frame.valid then
				SIRequestMap.OpenFrame( playerIndex )
			end
		else
			SIRequestMap.EffectTabSettings( settings , defaultIndex )
		end
	end ,
	EffectSelect2 = function( playerIndex , entities )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		settings.entities = entities
		local defaultIndex = settings.defaultIndex2
		if defaultIndex < 1 or defaultIndex > #settings.TabSettingsList then
			if not settings.frame or not settings.frame.valid then
				SIRequestMap.OpenFrame( playerIndex )
			end
		else
			SIRequestMap.EffectTabSettings( settings , defaultIndex )
		end
	end ,
	EffectSelect3 = function( playerIndex , entities )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		settings.entities = entities
		local defaultIndex = settings.defaultIndex3
		if defaultIndex < 1 or defaultIndex > #settings.TabSettingsList then
			if not settings.frame or not settings.frame.valid then
				SIRequestMap.OpenFrame( playerIndex )
			end
		else
			SIRequestMap.EffectTabSettings( settings , defaultIndex )
		end
	end ,
	EffectSelect4 = function( playerIndex , entities )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		settings.entities = entities
		local defaultIndex = settings.defaultIndex4
		if defaultIndex < 1 or defaultIndex > #settings.TabSettingsList then
			if not settings.frame or not settings.frame.valid then
				SIRequestMap.OpenFrame( playerIndex )
			end
		else
			SIRequestMap.EffectTabSettings( settings , defaultIndex )
		end
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ------ 接口函数 -- 窗口 ------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------

	-- ----------------------------------------
	-- 打开指定玩家的紫图的管理窗口<br>
	-- ----------------------------------------
	-- playerIndex = 玩家索引<br>
	-- ----------------------------------------
	OpenFrameByPlayerIndex = function( playerIndex )
		SIRequestMap.OpenFrame( playerIndex )
	end ,

	-- ----------------------------------------
	-- 关闭指定玩家的紫图的管理窗口<br>
	-- ----------------------------------------
	-- playerIndex = 玩家索引<br>
	-- ----------------------------------------
	CloseFrameByPlayerIndex = function( playerIndex )
		SIRequestMap.CloseFrame( playerIndex )
	end ,

	-- ----------------------------------------
	-- 打开所有玩家的紫图的管理窗口<br>
	-- ----------------------------------------
	-- 无参数<br>
	-- ----------------------------------------
	OpenFrames = function()
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIRequestMap.Settings.Name ) ) do
			SIRequestMap.OpenFrame( playerIndex )
		end
	end ,

	-- ----------------------------------------
	-- 关闭所有玩家的紫图的管理窗口<br>
	-- ----------------------------------------
	-- 无参数<br>
	-- ----------------------------------------
	CloseFrames = function()
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIRequestMap.Settings.Name ) ) do
			SIRequestMap.CloseFrame( playerIndex )
		end
	end
}

SIRequestMap.Names.ListButtonPosition = #SIRequestMap.Names.ListButtonPrefix + 1
SIRequestMap.Names.EnablePosition = #SIRequestMap.Names.EnablePrefix + 1
SIRequestMap.Names.RequestSlot_Entity_Position = #SIRequestMap.Names.RequestSlot_Entity_Prefix + 1
SIRequestMap.Names.RequestSlot_Item_Position = #SIRequestMap.Names.RequestSlot_Item_Prefix + 1
SIRequestMap.Names.MaxSlot_Entity_Position = #SIRequestMap.Names.MaxSlot_Entity_Prefix + 1
SIRequestMap.Names.MaxSlot_Count_Position = #SIRequestMap.Names.MaxSlot_Count_Prefix + 1
SIRequestMap.Names.SetModule_Entity_Position = #SIRequestMap.Names.SetModule_Entity_Prefix + 1
SIRequestMap.Names.SetModule_Item_Position = #SIRequestMap.Names.SetModule_Item_Prefix + 1
SIRequestMap.Names.RemoveModule_Entity_Position = #SIRequestMap.Names.RemoveModule_Entity_Prefix + 1
SIRequestMap.Names.RemoveModule_Item_Position = #SIRequestMap.Names.RemoveModule_Item_Prefix + 1
SIRequestMap.Names.InsertFuel_Entity_Position = #SIRequestMap.Names.InsertFuel_Entity_Prefix + 1
SIRequestMap.Names.InsertFuel_Item_Position = #SIRequestMap.Names.InsertFuel_Item_Prefix + 1
SIRequestMap.Names.InsertFuel_Count_Position = #SIRequestMap.Names.InsertFuel_Count_Prefix + 1
SIRequestMap.Names.InsertFuel_Mode_Position = #SIRequestMap.Names.InsertFuel_Mode_Prefix + 1
SIRequestMap.Names.InsertAmmo_Entity_Position = #SIRequestMap.Names.InsertAmmo_Entity_Prefix + 1
SIRequestMap.Names.InsertAmmo_Item_Position = #SIRequestMap.Names.InsertAmmo_Item_Prefix + 1
SIRequestMap.Names.InsertAmmo_Count_Position = #SIRequestMap.Names.InsertAmmo_Count_Prefix + 1
SIRequestMap.Names.InsertAmmo_Mode_Position = #SIRequestMap.Names.InsertAmmo_Mode_Prefix + 1

SIRequestMap.Toolbar =
{
	ID = "SI核心-紫图" ,
	Name = "紫图" ,
	IconItemName = SIConstants_Core.raw.Items.RequestMap ,
	LocalizedName = { "SICore.紫图-工具栏-按钮" } ,
	LocalizedDescription = { "SICore.紫图-工具栏-提示" , { "item-name.infinity-chest" } , { "SICoreName.物品-紫图" } } ,
	ActionRemoteInterfaceID = SIRequestMap.InterfaceID ,
	ActionRemoteFunctionName = "OpenFrameByPlayerIndex" ,
	Permission = SIPermission.PermissionIDs.RequestMap ,
	Order = "SICore-MapRequest"
}
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
		GreenToBlue_Check = "SI核心-自动填充-绿箱向蓝箱供货-勾选" ,
		ListButtonPrefix = "SI核心-自动填充-列表定位按钮-" ,
		EnablePrefix = "SI核心-自动填充-启用功能-" ,
		MaxSlot_Entity_Prefix = "SI核心-自动填充-最大格子-实体-" ,
		MaxSlot_Count_Prefix = "SI核心-自动填充-最大格子-数量-" ,
		SetModule_Entity_Prefix = "SI核心-自动填充-设置插件-实体-" ,
		SetModule_Item_Prefix = "SI核心-自动填充-设置插件-物品-" ,
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
	ModuleEventID = script.generate_event_name() ,
	TabSettingsMaxCount = 8 ,
	DefaultTabSettings =
	{
		Name = nil ,
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
		InsertFuel   = SIConstants_Core.raw.Items.IconColorMeat ,
		InsertAmmo   = SIConstants_Core.raw.Items.IconColorRose
	} ,
	DefaultIndexText =
	{
		[1] = { "SICore.自动填充-窗口-选择-空" } ,
		[2] = { "SICore.自动填充-窗口-选择-默认" }
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
			filter = "flag" ,
			flag = SICommon.Flags.Entity.PlayerCreation ,
			mode = SICommon.Flags.Condition.AND ,
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
	MaxSlot_Entity_Filters_ShowHidden =
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
			filter = "flag" ,
			flag = SICommon.Flags.Entity.PlayerCreation ,
			mode = SICommon.Flags.Condition.AND ,
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
			filter = "flag" ,
			flag = SICommon.Flags.Entity.PlayerCreation ,
			mode = SICommon.Flags.Condition.AND ,
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
	SetModule_Entity_Filters_ShowHidden =
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
			filter = "flag" ,
			flag = SICommon.Flags.Entity.PlayerCreation ,
			mode = SICommon.Flags.Condition.AND ,
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
			filter = "flag" ,
			flag = SICommon.Flags.Entity.PlayerCreation ,
			mode = SICommon.Flags.Condition.AND ,
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
	InsertFuel_Entity_Filters_ShowHidden =
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
			filter = "flag" ,
			flag = SICommon.Flags.Entity.PlayerCreation ,
			mode = SICommon.Flags.Condition.AND ,
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
			filter = "flag" ,
			flag = SICommon.Flags.Entity.PlayerCreation ,
			mode = SICommon.Flags.Condition.AND ,
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
	InsertAmmo_Entity_Filters_ShowHidden =
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
			filter = "flag" ,
			flag = SICommon.Flags.Entity.PlayerCreation ,
			mode = SICommon.Flags.Condition.AND ,
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
		-- 最大格子
		-- ----------------------------------------
		elements.MaxSlot_Enable = list.add{ type = "checkbox" , name = SIAutoInsert.Names.EnablePrefix .. "MaxSlot_Flow" , state = false , caption = { "SICore.自动填充-窗口-最大格子-启用" , { "SICore.自动填充-窗口-启用-未设置" } } , tooltip = { "SICore.自动填充-窗口-最大格子-启用-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_ListCheck }
		local MaxSlot_Flow = list.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.RequestMap_ListPanelFlow }
		elements.MaxSlot_Flow = MaxSlot_Flow
		elements.MaxSlot_List = MaxSlot_Flow.add{ type = "table" , column_count = 2 , style = SIConstants_Core.raw.Styles.RequestMap_SubList }
		-- ----------------------------------------
		-- 绿箱向蓝箱供货
		-- ----------------------------------------
		elements.GreenToBlue_Enable = list.add{ type = "checkbox" , name = SIAutoInsert.Names.EnablePrefix .. "GreenToBlue_Flow" , state = false , caption = { "SICore.自动填充-窗口-绿箱向蓝箱供货-启用" , { "SICore.自动填充-窗口-启用-未设置" } } , tooltip = { "SICore.自动填充-窗口-绿箱向蓝箱供货-启用-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_ListCheck }
		local GreenToBlue_Flow = list.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.RequestMap_ListPanelFlow }
		elements.GreenToBlue_Flow = GreenToBlue_Flow
		elements.GreenToBlue_Check = GreenToBlue_Flow.add{ type = "checkbox" , name = SIAutoInsert.Names.GreenToBlue_Check , state = false , caption = { "SICore.自动填充-窗口-绿箱向蓝箱供货-勾选" } , tooltip = { "SICore.自动填充-窗口-绿箱向蓝箱供货-勾选-提示" } , style = SIConstants_Core.raw.Styles.Common_CheckBox }
		-- ----------------------------------------
		-- 设置插件
		-- ----------------------------------------
		elements.SetModule_Enable = list.add{ type = "checkbox" , name = SIAutoInsert.Names.EnablePrefix .. "SetModule_Flow" , state = false , caption = { "SICore.自动填充-窗口-设置插件-启用" , { "SICore.自动填充-窗口-启用-未设置" } } , tooltip = { "SICore.自动填充-窗口-设置插件-启用-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_ListCheck }
		local SetModule_Flow = list.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.RequestMap_ListPanelFlow }
		elements.SetModule_Flow = SetModule_Flow
		elements.SetModule_List = SetModule_Flow.add{ type = "table" , column_count = 3 , style = SIConstants_Core.raw.Styles.RequestMap_SubList }
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
		-- 最大格子
		-- ----------------------------------------
		elements.MaxSlot_Enable.state = tabSettings.MaxSlot.Enable
		elements.MaxSlot_Flow.visible = tabSettings.MaxSlot.Enable
		SIAutoInsert.FreshPage_MaxSlot( settings , tabSettings , elements )
		-- ----------------------------------------
		-- 绿箱向蓝箱供货
		-- ----------------------------------------
		elements.GreenToBlue_Enable.state = tabSettings.GreenToBlue.Enable
		elements.GreenToBlue_Flow.visible = tabSettings.GreenToBlue.Enable
		elements.GreenToBlue_Check.state = tabSettings.GreenToBlue.Check
		SIAutoInsert.FreshPage_GreenToBlue( settings , tabSettings , elements )
		-- ----------------------------------------
		-- 设置插件
		-- ----------------------------------------
		elements.SetModule_Enable.state = tabSettings.SetModule.Enable
		elements.SetModule_Flow.visible = tabSettings.SetModule.Enable
		SIAutoInsert.FreshPage_SetModule( settings , tabSettings , elements )
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
	FreshPage_MaxSlot = function( settings , tabSettings , elements )
		-- 更新说明
		elements.MaxSlot_Enable.caption = { "SICore.自动填充-窗口-最大格子-启用" , { SITable.Size( tabSettings.MaxSlot.List ) > 0 and "SICore.自动填充-窗口-启用-已设置" or "SICore.自动填充-窗口-启用-未设置" } }
		-- 清空列表
		local list = elements.MaxSlot_List
		list.clear()
		-- 选择筛选器
		local entityFilter = SISettings.PerUser.SICore.ShowHiddenEntity( settings.playerIndex ) and SIAutoInsert.MaxSlot_Entity_Filters_ShowHidden or SIAutoInsert.MaxSlot_Entity_Filters
		-- 重建列表
		for entityName , count in pairs( tabSettings.MaxSlot.List ) do
			local entityPrototype = game.entity_prototypes[entityName]
			local entityTooltip = nil
			local entityNameSelected = entityName
			local maxCount = 0
			if entityPrototype then
				entityTooltip = { "SICore.自动填充-窗口-最大格子-实体-提示" , entityPrototype.localised_name }
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
				entityTooltip = { "SICore.自动填充-窗口-最大格子-实体-空-提示" , entityName }
				entityNameSelected = SIConstants_Core.raw.Entities.IconEmpty
				maxCount = 0
			end
			list.add
			{
				type = "choose-elem-button" ,
				name = SIAutoInsert.Names.MaxSlot_Entity_Prefix .. entityName ,
				tooltip = entityTooltip ,
				elem_type = "entity" ,
				entity = entityNameSelected ,
				elem_filters = entityFilter ,
				style = SIConstants_Core.raw.Styles.RequestMap_ListChooser
			}
			local flow = list.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.RequestMap_ListFlow }
			flow.add{ type = "label" , caption = { "SICore.自动填充-窗口-最大格子-数量前缀" , maxCount } , tooltip = { "SICore.自动填充-窗口-最大格子-数量-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_ListLabel }
			flow.add{ type = "textfield" , name = SIAutoInsert.Names.MaxSlot_Count_Prefix .. entityName , text = tostring( count ) , numeric = true , tooltip = { "SICore.自动填充-窗口-最大格子-数量-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_ListText }
			flow.add{ type = "label" , caption = { "SICore.自动填充-窗口-最大格子-数量后缀" } , tooltip = { "SICore.自动填充-窗口-最大格子-数量-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_ListLabel }
		end
		list.add
		{
			type = "choose-elem-button" ,
			name = SIAutoInsert.Names.MaxSlot_Entity_Prefix ,
			tooltip = { "SICore.自动填充-窗口-最大格子-实体-选择-提示" } ,
			elem_type = "entity" ,
			entity = nil ,
			elem_filters = entityFilter ,
			style = SIConstants_Core.raw.Styles.RequestMap_ListChooser
		}
	end ,
	FreshPage_GreenToBlue = function( settings , tabSettings , elements )
		-- 更新说明
		elements.GreenToBlue_Enable.caption = { "SICore.自动填充-窗口-绿箱向蓝箱供货-启用" , { tabSettings.GreenToBlue.Check and "SICore.自动填充-窗口-启用-未设置" or "SICore.自动填充-窗口-启用-已设置" } }
	end ,
	FreshPage_SetModule = function( settings , tabSettings , elements )
		-- 更新说明
		SIAutoInsert.FreshPage_SetModule_Enable( settings , tabSettings , elements )
		-- 清空列表
		local list = elements.SetModule_List
		list.clear()
		-- 选择筛选器
		local entityFilter = SISettings.PerUser.SICore.ShowHiddenEntity( settings.playerIndex ) and SIAutoInsert.SetModule_Entity_Filters_ShowHidden or SIAutoInsert.SetModule_Entity_Filters
		-- 重建列表
		for entityName , moduleList in pairs( tabSettings.SetModule.List ) do
			local entityPrototype = game.entity_prototypes[entityName]
			local entityTooltip = nil
			local entityNameSelected = entityName
			local maxSlot = 0
			if entityPrototype then
				entityTooltip = { "SICore.自动填充-窗口-设置插件-实体-提示" , entityPrototype.localised_name }
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
				entityTooltip = { "SICore.自动填充-窗口-设置插件-实体-空-提示" , entityName }
				entityNameSelected = SIConstants_Core.raw.Entities.IconEmpty
				for key , value in pairs( moduleList ) do
					maxSlot = math.max( maxSlot , key )
				end
			end
			list.add
			{
				type = "choose-elem-button" ,
				name = SIAutoInsert.Names.SetModule_Entity_Prefix .. entityName ,
				tooltip = entityTooltip ,
				elem_type = "entity" ,
				entity = entityNameSelected ,
				elem_filters = entityFilter ,
				style = SIConstants_Core.raw.Styles.RequestMap_ListChooser
			}
			local selectList1 = list.add{ type = "table" , column_count = 10 , style = SIConstants_Core.raw.Styles.RequestMap_SelectList }
			local selectList2 = list.add{ type = "table" , column_count = 10 , style = SIConstants_Core.raw.Styles.RequestMap_SelectList }
			for slotIndex = 1 , maxSlot , 1 do
				local selectList = math.fmod( math.floor( ( slotIndex - 1 ) / 10 ) , 2 ) == 0 and selectList1 or selectList2
				local itemTooltip = nil
				local itemName = moduleList[slotIndex]
				if itemName then
					local itemPrototype = game.item_prototypes[itemName]
					if itemPrototype then
						itemTooltip = { "SICore.自动填充-窗口-设置插件-物品-提示" , itemPrototype.localised_name }
					else
						itemTooltip = { "SICore.自动填充-窗口-设置插件-物品-空-提示" , itemName }
						itemName = SIConstants_Core.raw.Items.IconEmpty
					end
				else
					itemTooltip = { "SICore.自动填充-窗口-设置插件-物品-选择-提示" }
				end
				selectList.add
				{
					type = "choose-elem-button" ,
					name = SIAutoInsert.Names.SetModule_Item_Prefix .. slotIndex .. "_" .. entityName ,
					tooltip = itemTooltip ,
					elem_type = "item" ,
					item = itemName ,
					elem_filters = SIAutoInsert.SetModule_Item_Filters ,
					style = SIConstants_Core.raw.Styles.RequestMap_ListChooser
				}
			end
		end
		list.add
		{
			type = "choose-elem-button" ,
			name = SIAutoInsert.Names.SetModule_Entity_Prefix ,
			tooltip = { "SICore.自动填充-窗口-设置插件-实体-选择-提示" } ,
			elem_type = "entity" ,
			entity = nil ,
			elem_filters = entityFilter ,
			style = SIConstants_Core.raw.Styles.RequestMap_ListChooser
		}
	end ,
	FreshPage_SetModule_Enable = function( settings , tabSettings , elements )
		-- 更新说明
		elements.SetModule_Enable.caption = { "SICore.自动填充-窗口-设置插件-启用" , { SITable.Size( tabSettings.SetModule.List ) > 0 and "SICore.自动填充-窗口-启用-已设置" or "SICore.自动填充-窗口-启用-未设置" } }
	end ,
	FreshPage_InsertFuel = function( settings , tabSettings , elements )
		-- 更新说明
		elements.InsertFuel_Enable.caption = { "SICore.自动填充-窗口-插入燃料-启用" , { SITable.Size( tabSettings.InsertFuel.List ) > 0 and "SICore.自动填充-窗口-启用-已设置" or "SICore.自动填充-窗口-启用-未设置" } }
		-- 清空列表
		local list = elements.InsertFuel_List
		list.clear()
		-- 选择筛选器
		local entityFilter = SISettings.PerUser.SICore.ShowHiddenEntity( settings.playerIndex ) and SIAutoInsert.InsertFuel_Entity_Filters_ShowHidden or SIAutoInsert.InsertFuel_Entity_Filters
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
					elem_filters = entityFilter ,
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
					elem_filters = entityFilter ,
					style = SIConstants_Core.raw.Styles.AutoInsert_ListChooser
				}
				local subList = list.add{ type = "table" , column_count = 5 , style = SIConstants_Core.raw.Styles.AutoInsert_SelectList }
				local fuelFilter = SIUtils.table.deepcopy( SIAutoInsert.InsertFuel_Item_Filters )
				table.insert( fuelFilter ,
				{
					filter = "fuel-category" ,
					["fuel-category"] = SIConstants_Core.raw.Categories.Fuel.Special ,
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
			elem_filters = entityFilter ,
			style = SIConstants_Core.raw.Styles.AutoInsert_ListChooser
		}
	end ,
	FreshPage_InsertAmmo = function( settings , tabSettings , elements )
		-- 更新说明
		elements.InsertAmmo_Enable.caption = { "SICore.自动填充-窗口-插入弹药-启用" , { SITable.Size( tabSettings.InsertAmmo.List ) > 0 and "SICore.自动填充-窗口-启用-已设置" or "SICore.自动填充-窗口-启用-未设置" } }
		-- 清空列表
		local list = elements.InsertAmmo_List
		list.clear()
		-- 选择筛选器
		local entityFilter = SISettings.PerUser.SICore.ShowHiddenEntity( settings.playerIndex ) and SIAutoInsert.InsertAmmo_Entity_Filters_ShowHidden or SIAutoInsert.InsertAmmo_Entity_Filters
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
					elem_filters = entityFilter ,
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
					elem_filters = entityFilter ,
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
			elem_filters = entityFilter ,
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
	-- ----------------------------------------
	-- 这是一个内部函数 , 请勿外部调用<br>
	-- ----------------------------------------
	FireModuleEvent = function( playerIndex , entity )
		local data =
		{
			name = SIAutoInsert.ModuleEventID ,
			tick = game.tick ,
			player_index = playerIndex ,
			entity = entity
		}
		script.raise_event( SIAutoInsert.ModuleEventID , data )
	end ,
	EffectTabSettings = function( settings , tabSettingsIndex )
		local playerIndex = settings.playerIndex
		local player = game.get_player( playerIndex )
		local playerInventory = player.get_main_inventory()
		local tabSettings = settings.TabSettingsList[tabSettingsIndex]
		local greenToBlue = tabSettings.GreenToBlue.Check
		for index , entity in pairs( settings.entities ) do
			local force = entity.force
			local surface = entity.surface
			local entityName = entity.name
			local entityPrototype = entity.prototype
			local type = entityPrototype.type
			local moduleFlag = false
			-- ----------------------------------------
			-- 最大格子
			-- ----------------------------------------
			if tabSettings.MaxSlot.Enable then
				local maxSlotCount = tabSettings.MaxSlot.List[entityName]
				if maxSlotCount then
					maxSlotCount = maxSlotCount + 1 -- 因为实际是设置到此格子 , 而保存的值是空余这么多格子 , 所以此处的值要 + 1
					if type == SICommon.Types.Entities.Container or type == SICommon.Types.Entities.ContainerLogic then
						local inventory = entity.get_inventory( defines.inventory.chest )
						if inventory and inventory.supports_bar() then
							local inventorySize = #inventory
							if maxSlotCount < inventorySize then
								inventory.set_bar( maxSlotCount < 1 and nil or maxSlotCount )
							end
						end
					elseif type == SICommon.Types.Entities.Car then
						local inventory = entity.get_inventory( defines.inventory.car_trunk )
						if inventory and inventory.supports_bar() then
							local inventorySize = #inventory
							if maxSlotCount < inventorySize then
								inventory.set_bar( maxSlotCount < 1 and nil or maxSlotCount )
							end
						end
					elseif type == SICommon.Types.Entities.SpiderVehicle then
						local inventory = entity.get_inventory( defines.inventory.spider_trunk )
						if inventory and inventory.supports_bar() then
							local inventorySize = #inventory
							if maxSlotCount < inventorySize then
								inventory.set_bar( maxSlotCount < 1 and nil or maxSlotCount )
							end
						end
					elseif type == SICommon.Types.Entities.WagonCargo then
						local inventory = entity.get_inventory( defines.inventory.cargo_wagon )
						if inventory and inventory.supports_bar() then
							local inventorySize = #inventory
							if maxSlotCount < inventorySize then
								inventory.set_bar( maxSlotCount < 1 and nil or maxSlotCount )
							end
						end
					end
				end
			end
			-- ----------------------------------------
			-- 绿箱向蓝箱供货
			-- ----------------------------------------
			if tabSettings.GreenToBlue.Enable then
				if type == SICommon.Types.Entities.ContainerLogic then
					local logisticMode = entityPrototype.logistic_mode
					if logisticMode == SICommon.Flags.LogisticMode.Requester then
						entity.request_from_buffers = greenToBlue
					end
				end
			end
			-- ----------------------------------------
			-- 设置插件
			-- ----------------------------------------
			if tabSettings.SetModule.Enable then
				local setModuleList = tabSettings.SetModule.List[entityName]
				if setModuleList then
					local inventory = entity.get_module_inventory()
					if inventory then
						for slotIndex = 1 , #inventory , 1 do
							local itemName = setModuleList[slotIndex]
							if itemName and game.item_prototypes[itemName] then
								local currentItemStack = inventory[slotIndex]
								if not currentItemStack.valid_for_read or currentItemStack.name ~= itemName then
									if currentItemStack.valid_for_read and currentItemStack.name ~= itemName then
										local dropItemFlag = true
										local itemStack = { name = currentItemStack.name , count = 1 }
										if playerInventory.can_insert( itemStack ) then
											playerInventory.insert( itemStack )
											dropItemFlag = false
										end
										if dropItemFlag then
											surface.spill_item_stack( entity.position , { name = currentItemStack.name , count = 1 } , true , force , false )
										end
										currentItemStack.clear()
										moduleFlag = true
									end
									local itemStack = { name = itemName , count = 1 }
									if inventory.can_insert( itemStack ) then
										local hasCount = playerInventory.get_item_count( itemName )
										if hasCount > 0 then
											currentItemStack.set_stack( itemStack )
											playerInventory.remove{ name = itemName , count = 1 }
											moduleFlag = true
										end
									end
								end
							else
								local currentItemStack = inventory[slotIndex]
								if currentItemStack.valid_for_read then
									local dropItemFlag = true
									local itemStack = { name = currentItemStack.name , count = 1 }
									if playerInventory.can_insert( itemStack ) then
										playerInventory.insert( itemStack )
										dropItemFlag = false
									end
									if dropItemFlag then
										surface.spill_item_stack( entity.position , { name = currentItemStack.name , count = 1 } , true , force , false )
									end
									currentItemStack.clear()
									moduleFlag = true
								end
							end
						end
					end
				end
			end
			-- 触发插件事件
			if moduleFlag then
				SIAutoInsert.FireModuleEvent( playerIndex , entity )
			end
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
	Set_MaxSlot_Entity = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIAutoInsert.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [最大格子-实体] 选择的实体
			local selectEntityName = element.elem_value
			local tabSettingsIndex = settings.tabSettingsIndex
			local tabSettings = settings.TabSettingsList[tabSettingsIndex]
			local countList = tabSettings.MaxSlot.List
			local entityName = name:sub( SIAutoInsert.Names.MaxSlot_Entity_Position )
			if countList[entityName] then
				if entityName == selectEntityName then
					return
				else
					if selectEntityName == nil then
						countList[entityName] = nil
					else
						local newCountList = {}
						for innerEntityName , count in pairs( countList ) do
							if entityName == innerEntityName then
								newCountList[selectEntityName] = 0
							else
								newCountList[innerEntityName] = count
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
					SIPrint.Warning( playerIndex , { "SICore.自动填充-提示-最大格子-已存在" , selectEntityName , game.entity_prototypes[selectEntityName].localised_name } )
					element.elem_value = nil
					return
				end
				countList[selectEntityName] = 0
			end
			SIAutoInsert.FreshPage_MaxSlot( settings , tabSettings , settings.Elements[tabSettingsIndex] )
		end
	end ,
	Set_MaxSlot_Count = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIAutoInsert.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			local count = math.floor( tonumber( element.text ) or 0 )
			element.text = tostring( count )
			-- 保存 [最大格子-数量] 填写的数量
			local tabSettingsIndex = settings.tabSettingsIndex
			local tabSettings = settings.TabSettingsList[tabSettingsIndex]
			local countList = tabSettings.MaxSlot.List
			local entityName = name:sub( SIAutoInsert.Names.MaxSlot_Count_Position )
			countList[entityName] = count
		end
	end ,
	Set_GreenToBlue_Check = function( playerIndex , element )
		local settings = SIGlobal.GetPlayerSettings( SIAutoInsert.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [绿箱向蓝箱供货-勾选] 复选框的值
			local tabSettingsIndex = settings.tabSettingsIndex
			local tabSettings = settings.TabSettingsList[tabSettingsIndex]
			tabSettings.GreenToBlue.Check = element.state
			SIAutoInsert.FreshPage_GreenToBlue( settings , tabSettings , settings.Elements[tabSettingsIndex] )
		end
	end ,
	Set_SetModule_FromInventory = function( playerIndex , element )
		local settings = SIGlobal.GetPlayerSettings( SIAutoInsert.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [设置插件-从背包填充] 复选框的值
			local tabSettingsIndex = settings.tabSettingsIndex
			local tabSettings = settings.TabSettingsList[tabSettingsIndex]
			tabSettings.SetModule.FromInventory = element.state
			SIAutoInsert.FreshPage_SetModule_Enable( settings , tabSettings , settings.Elements[tabSettingsIndex] )
		end
	end ,
	Set_SetModule_Entity = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIAutoInsert.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [设置插件-实体] 选择的实体
			local selectEntityName = element.elem_value
			local tabSettingsIndex = settings.tabSettingsIndex
			local tabSettings = settings.TabSettingsList[tabSettingsIndex]
			local moduleList = tabSettings.SetModule.List
			local entityName = name:sub( SIAutoInsert.Names.SetModule_Entity_Position )
			if moduleList[entityName] then
				if entityName == selectEntityName then
					return
				else
					if selectEntityName == nil then
						moduleList[entityName] = nil
					else
						local newModuleList = {}
						for innerEntityName , moduleData in pairs( moduleList ) do
							if entityName == innerEntityName then
								newModuleList[selectEntityName] = {}
							else
								newModuleList[innerEntityName] = moduleData
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
					SIPrint.Warning( playerIndex , { "SICore.自动填充-提示-设置插件-已存在" , selectEntityName , game.entity_prototypes[selectEntityName].localised_name } )
					element.elem_value = nil
					return
				end
				moduleList[selectEntityName] = {}
			end
			SIAutoInsert.FreshPage_SetModule( settings , tabSettings , settings.Elements[tabSettingsIndex] )
		end
	end ,
	Set_SetModule_Item = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIAutoInsert.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			local selectItemName = element.elem_value
			element.tooltip = selectItemName and { "SICore.自动填充-窗口-设置插件-物品-提示" , game.item_prototypes[selectItemName].localised_name } or { "SICore.自动填充-窗口-设置插件-物品-选择-提示" }
			-- 保存 [设置插件-物品] 选择的物品
			local key = name:sub( SIAutoInsert.Names.SetModule_Item_Position )
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
			if defaultIndex > 0 and defaultIndex <= #settings.TabSettingsList then
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
	end ,

	-- ------------------------------------------------------------------------------------------------
	-- ------ 接口函数 -- 事件 ------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------

	-- ----------------------------------------
	-- 当一个玩家通过自动填充修改了实体的插件时 , 会触发此事件<br>
	-- 事件会包含 4 个参数 :<br>
	-- name          = 事件的 ID 值<br>
	-- tick          = 当前游戏刻<br>
	-- player_index  = 操作玩家的索引<br>
	-- entity        = 被修改了插件的实体<br>
	-- ----------------------------------------
	-- 返回值 = 事件的 ID 值<br>
	-- ----------------------------------------
	GetModuleEventID = function()
		return SIAutoInsert.ModuleEventID
	end
}

SIAutoInsert.Names.ListButtonPosition = #SIAutoInsert.Names.ListButtonPrefix + 1
SIAutoInsert.Names.EnablePosition = #SIAutoInsert.Names.EnablePrefix + 1
SIAutoInsert.Names.MaxSlot_Entity_Position = #SIAutoInsert.Names.MaxSlot_Entity_Prefix + 1
SIAutoInsert.Names.MaxSlot_Count_Position = #SIAutoInsert.Names.MaxSlot_Count_Prefix + 1
SIAutoInsert.Names.SetModule_Entity_Position = #SIAutoInsert.Names.SetModule_Entity_Prefix + 1
SIAutoInsert.Names.SetModule_Item_Position = #SIAutoInsert.Names.SetModule_Item_Prefix + 1
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
	Tooltip = { "SICore.自动填充-导出设置-提示" } ,
	ImportRemoteInterfaceID = SIAutoInsert.InterfaceID ,
	ImportRemoteFunctionName = "ImpoerSettingsData" ,
	ExportRemoteInterfaceID = SIAutoInsert.InterfaceID ,
	ExportRemoteFunctionName = "ExportSettingsData"
}
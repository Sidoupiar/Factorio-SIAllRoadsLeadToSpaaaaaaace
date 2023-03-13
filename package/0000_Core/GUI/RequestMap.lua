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
		GreenToBlue_Check = "SI核心-紫图-绿箱向蓝箱供货-勾选" ,
		SetModule_FromInventory = "SI核心-紫图-设置插件-从背包填充" ,
		RemoveModule_ToInventory = "SI核心-紫图-移除插件-进入背包" ,
		ListButtonPrefix = "SI核心-紫图-列表定位按钮-" ,
		EnablePrefix = "SI核心-紫图-启用功能-"
	} ,
	Settings =
	{
		Name = "RequestMap" ,
		Default =
		{
			frame = nil ,
			frameLocation = nil ,
			tabPane = nil ,
			page = nil ,
			scroll = nil ,
			TabList = {} ,
			ListButtons = {} ,
			Elements =
			{
				TabSettingsName = nil ,
				-- 请求格子
				RequestSlot_Enable = nil ,
				RequestSlot_Flow = nil ,
				RequestSlot_List = nil ,
				-- 最大格子
				MaxSlot_Enable = nil ,
				MaxSlot_Flow = nil ,
				MaxSlot_List = nil ,
				-- 绿箱向蓝箱供货
				GreenToBlue_Enable = nil ,
				GreenToBlue_Flow = nil ,
				GreenToBlue_Check = nil ,
				-- 设置插件
				SetModule_Enable = nil ,
				SetModule_Flow = nil ,
				SetModule_FromInventory = nil ,
				SetModule_List = nil ,
				-- 移除插件
				RemoveModule_Enable = nil ,
				RemoveModule_Flow = nil ,
				RemoveModule_ToInventory = nil ,
				RemoveModule_List = nil ,
				-- 插入物品
				InsertItem_Enable = nil ,
				InsertItem_Flow = nil ,
				InsertItem_List = nil
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
			FromInventory = true ,
			List = {} -- 键为选择的设备实体 , 值为插件物品名称列表
		} ,
		-- 移除插件
		RemoveModule =
		{
			Enable = false ,
			ToInventory = true ,
			List = {} -- 键为选择的设备实体 , 值为插件物品名称列表
		} ,
		-- 插入物品
		InsertItem =
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
		InsertItem   = SIConstants_Core.raw.Items.IconColorMeat
	} ,
	DefaultIndexText =
	{
		[1] = { "SICore.紫图-窗口-选择-空" } ,
		[2] = { "SICore.紫图-窗口-选择-1" } ,
		[3] = { "SICore.紫图-窗口-选择-2" } ,
		[4] = { "SICore.紫图-窗口-选择-3" } ,
		[5] = { "SICore.紫图-窗口-选择-4" }
	} ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 窗口函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	OpenFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )




		settings.label = nil
		settings.tabList = nil
		settings.TabList = {}
		settings.ListButtons = {}
		settings.Elements = {}
		settings.tabIndex = nil
		settings.tabSettingsIndex = 1
		settings.settingList = nil
		if not settings.TabSettingsList then
			settings.TabSettingsList = {}
		end
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
			local tabPane = frame.add{ type = "tabbed-pane" , name = SIRequestMap.Names.TabPane , style = SIConstants_Core.raw.Styles.RequestMap_TabPane }
			settings.tabPane = tabPane
			settings.page = tabPane.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			-- 根据设置更新控件
			SIRequestMap.CreateTab( settings )
			SIRequestMap.CreatePage( settings )
			SIRequestMap.FreshPage( settings )
		end
	end ,
	CloseFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			settings.entities = nil
			settings.frame.destroy()
			settings.frame = nil
			settings.tabPane = nil
			settings.page = nil
			settings.scroll = nil
			settings.TabList = {}
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
			settings.defaultIndex1 = tabSettingsIndex == settings.defaultIndex1 and 0 or tabSettingsIndex < settings.defaultIndex1 and SITools.AsNumberInt( tabSettingsIndex - 1 , 1 , tabSettingsCount )
			settings.defaultIndex2 = tabSettingsIndex == settings.defaultIndex2 and 0 or tabSettingsIndex < settings.defaultIndex2 and SITools.AsNumberInt( tabSettingsIndex - 1 , 1 , tabSettingsCount )
			settings.defaultIndex3 = tabSettingsIndex == settings.defaultIndex3 and 0 or tabSettingsIndex < settings.defaultIndex3 and SITools.AsNumberInt( tabSettingsIndex - 1 , 1 , tabSettingsCount )
			settings.defaultIndex4 = tabSettingsIndex == settings.defaultIndex4 and 0 or tabSettingsIndex < settings.defaultIndex4 and SITools.AsNumberInt( tabSettingsIndex - 1 , 1 , tabSettingsCount )
		end
	end ,
	CreateTab = function( settings )
		local tabPane = settings.tabPane
		local page = settings.page
		-- 清除已有分页
		for index , tab in pairs( settings.TabList ) do
			tabPane.remove_tab( tab )
			tab.destroy()
		end
		settings.TabList = {}
		-- 增加新的分页
		for index , tabSettings in pairs( settings.TabSettingsList ) do
			local tab = tabPane.add{ type = "tab" , caption = { "SICore.紫图-窗口-分页标题" , tabSettings.Name } , tooltip = { "SICore.紫图-窗口-分页标题-提示" , SIRequestMap.TabSettingsMaxCount } }
			tabPane.add_tab( tab , page )
			table.insert( settings.TabList , tab )
		end
		settings.tabPane.selected_tab_index = settings.tabSettingsIndex
	end ,
	CreatePage = function( settings )
		local page = settings.page
		local elements = settings.Elements
		-- ----------------------------------------
		-- 设置名称
		-- ----------------------------------------
		local nameFlow = page.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowCenterH }
		nameFlow.add{ type = "label" , caption = { "SICore.紫图-窗口-名称" } , tooltip = { "SICore.紫图-窗口-名称-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_Label }
		elements.TabSettingsName = nameFlow.add{ type = "textfield" , name = SIRequestMap.Names.TabSettingsName , text = nil , tooltip = { "SICore.紫图-窗口-名称-提示" } , style = SIConstants_Core.raw.Styles.RequestMap_Text }
		nameFlow.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.RequestMap_EmptyFlow }
		nameFlow.add{ type = "button" , name = SIRequestMap.Names.Delete , caption = { "SICore.紫图-窗口-删除" } , tooltip = { "SICore.紫图-窗口-删除-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonRed }
		-- ----------------------------------------
		-- 设置列表按钮
		-- ----------------------------------------
		local listButtonFlow = page.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowCenterH }
		-- ----------------------------------------
		-- 设置列表
		-- ----------------------------------------
		local scroll = page.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Common_ScrollPane }
		local list = scroll.add{ type = "table" , column_count = 1 , style = SIConstants_Core.raw.Styles.Common_List }
		settings.scroll = scroll
		-- ----------------------------------------
		-- 请求格子
		-- ----------------------------------------
		elements.RequestSlot_Enable = list.add{ type = "checkbox" , name = SIRequestMap.Names.EnablePrefix .. "RequestSlot_Flow" , state = false , caption = { "SICore.紫图-窗口-请求格子-启用" } , tooltip = { "SICore.紫图-窗口-请求格子-启用-提示" } , style = SIConstants_Core.raw.Styles.Common_CheckBox }
		local RequestSlot_Flow = list.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.RequestMap_ListFlow }
		elements.RequestSlot_Flow = RequestSlot_Flow
		elements.RequestSlot_List = RequestSlot_Flow
		.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Common_ScrollPane }
		.add{ type = "table" , column_count = 2 , style = SIConstants_Core.raw.Styles.RequestMap_SubList }
		-- ----------------------------------------
		-- 最大格子
		-- ----------------------------------------
		elements.MaxSlot_Enable = list.add{ type = "checkbox" , name = SIRequestMap.Names.EnablePrefix .. "MaxSlot_Flow" , state = false , caption = { "SICore.紫图-窗口-最大格子-启用" } , tooltip = { "SICore.紫图-窗口-最大格子-启用-提示" } , style = SIConstants_Core.raw.Styles.Common_CheckBox }
		local MaxSlot_Flow = list.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.RequestMap_ListFlow }
		elements.MaxSlot_Flow = MaxSlot_Flow
		elements.MaxSlot_List = MaxSlot_Flow
		.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Common_ScrollPane }
		.add{ type = "table" , column_count = 2 , style = SIConstants_Core.raw.Styles.RequestMap_SubList }
		-- ----------------------------------------
		-- 绿箱向蓝箱供货
		-- ----------------------------------------
		elements.GreenToBlue_Enable = list.add{ type = "checkbox" , name = SIRequestMap.Names.EnablePrefix .. "GreenToBlue_Flow" , state = false , caption = { "SICore.紫图-窗口-绿箱向蓝箱供货-启用" } , tooltip = { "SICore.紫图-窗口-绿箱向蓝箱供货-启用-提示" } , style = SIConstants_Core.raw.Styles.Common_CheckBox }
		local GreenToBlue_Flow = list.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.RequestMap_ListFlow }
		elements.GreenToBlue_Flow = GreenToBlue_Flow
		elements.GreenToBlue_Check = GreenToBlue_Flow.add{ type = "checkbox" , name = SIRequestMap.Names.GreenToBlue_Check , state = false , caption = { "SICore.紫图-窗口-绿箱向蓝箱供货-勾选" } , tooltip = { "SICore.紫图-窗口-绿箱向蓝箱供货-勾选-提示" } , style = SIConstants_Core.raw.Styles.Common_CheckBox }
		-- ----------------------------------------
		-- 设置插件
		-- ----------------------------------------
		elements.SetModule_Enable = list.add{ type = "checkbox" , name = SIRequestMap.Names.EnablePrefix .. "SetModule_Flow" , state = false , caption = { "SICore.紫图-窗口-设置插件-启用" } , tooltip = { "SICore.紫图-窗口-设置插件-启用-提示" } , style = SIConstants_Core.raw.Styles.Common_CheckBox }
		local SetModule_Flow = list.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.RequestMap_ListFlow }
		elements.SetModule_Flow = SetModule_Flow
		elements.SetModule_FromInventory = SetModule_Flow.add{ type = "checkbox" , name = SIRequestMap.Names.SetModule_FromInventory , state = false , caption = { "SICore.紫图-窗口-设置插件-从背包填充" } , tooltip = { "SICore.紫图-窗口-设置插件-从背包填充-提示" } , style = SIConstants_Core.raw.Styles.Common_CheckBox }
		elements.SetModule_List = SetModule_Flow
		.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Common_ScrollPane }
		.add{ type = "table" , column_count = 2 , style = SIConstants_Core.raw.Styles.RequestMap_SubList }
		-- ----------------------------------------
		-- 移除插件
		-- ----------------------------------------
		elements.RemoveModule_Enable = list.add{ type = "checkbox" , name = SIRequestMap.Names.EnablePrefix .. "RemoveModule_Flow" , state = false , caption = { "SICore.紫图-窗口-移除插件-启用" } , tooltip = { "SICore.紫图-窗口-移除插件-启用-提示" } , style = SIConstants_Core.raw.Styles.Common_CheckBox }
		local RemoveModule_Flow = list.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.RequestMap_ListFlow }
		elements.RemoveModule_Flow = RemoveModule_Flow
		elements.RemoveModule_ToInventory = RemoveModule_Flow.add{ type = "checkbox" , name = SIRequestMap.Names.RemoveModule_ToInventory , state = false , caption = { "SICore.紫图-窗口-移除插件-进入背包" } , tooltip = { "SICore.紫图-窗口-移除插件-进入背包-提示" } , style = SIConstants_Core.raw.Styles.Common_CheckBox }
		elements.RemoveModule_List = RemoveModule_Flow
		.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Common_ScrollPane }
		.add{ type = "table" , column_count = 2 , style = SIConstants_Core.raw.Styles.RequestMap_SubList }
		-- ----------------------------------------
		-- 插入物品
		-- ----------------------------------------
		elements.InsertItem_Enable = list.add{ type = "checkbox" , name = SIRequestMap.Names.EnablePrefix .. "InsertItem_Flow" , state = false , caption = { "SICore.紫图-窗口-插入物品-启用" } , tooltip = { "SICore.紫图-窗口-插入物品-启用-提示" } , style = SIConstants_Core.raw.Styles.Common_CheckBox }
		local InsertItem_Flow = list.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.RequestMap_ListFlow }
		elements.InsertItem_Flow = InsertItem_Flow
		elements.InsertItem_List = InsertItem_Flow
		.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Common_ScrollPane }
		.add{ type = "table" , column_count = 2 , style = SIConstants_Core.raw.Styles.RequestMap_SubList }
		-- ----------------------------------------
		-- 创建滚动定位按钮
		-- ----------------------------------------
		for key , value in pairs( SIRequestMap.DefaultTabSettings ) do
			if key ~= "Name" then
				local button = listButtonFlow.add{ type = "sprite-button" , name = SIRequestMap.Names.ListButtonPrefix .. key .. "_Enable" , sprite = "item/" .. SIRequestMap.ListButtonIcon[key] , tooltip = { "SICore.紫图-窗口-列表定位按钮-提示" , elements[key .. "_Enable"].caption } , style = SIConstants_Core.raw.Styles.RequestMap_ListButton }
				settings.ListButtons[key] = button
			end
		end
	end ,
	FreshPage = function( settings )
		local tabSettingsIndex = settings.tabSettingsIndex
		local tabSettings = settings.TabSettingsList[tabSettingsIndex]
		local elements = settings.Elements
		-- ----------------------------------------
		-- 设置名称
		-- ----------------------------------------
		elements.TabSettingsName.text = tabSettings.Name
		-- ----------------------------------------
		-- 请求格子
		-- ----------------------------------------
		elements.RequestSlot_Enable.state = tabSettings.RequestSlot.Enable
		elements.RequestSlot_Flow.visible = tabSettings.RequestSlot.Enable
		-- ----------------------------------------
		-- 最大格子
		-- ----------------------------------------
		elements.MaxSlot_Enable.state = tabSettings.MaxSlot.Enable
		elements.MaxSlot_Flow.visible = tabSettings.MaxSlot.Enable
		-- ----------------------------------------
		-- 绿箱向蓝箱供货
		-- ----------------------------------------
		elements.GreenToBlue_Enable.state = tabSettings.GreenToBlue.Enable
		elements.GreenToBlue_Flow.visible = tabSettings.GreenToBlue.Enable
		elements.GreenToBlue_Check.state = tabSettings.GreenToBlue.Check
		-- ----------------------------------------
		-- 设置插件
		-- ----------------------------------------
		elements.SetModule_Enable.state = tabSettings.SetModule.Enable
		elements.SetModule_Flow.visible = tabSettings.SetModule.Enable
		elements.SetModule_FromInventory.state = tabSettings.SetModule.FromInventory
		-- ----------------------------------------
		-- 移除插件
		-- ----------------------------------------
		elements.RemoveModule_Enable.state = tabSettings.RemoveModule.Enable
		elements.RemoveModule_Flow.visible = tabSettings.RemoveModule.Enable
		elements.RemoveModule_ToInventory.state = tabSettings.RemoveModule.ToInventory
		-- ----------------------------------------
		-- 插入物品
		-- ----------------------------------------
		elements.InsertItem_Enable.state = tabSettings.InsertItem.Enable
		elements.InsertItem_Flow.visible = tabSettings.InsertItem.Enable
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
		-- 插入物品
		-- ----------------------------------------
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
			local tabSettingsIndex = settings.tabPane.selected_tab_index
			settings.tabSettingsIndex = tabSettingsIndex
			SIRequestMap.FreshPage( settings )
		end
	end ,
	ListScroll = function( playerIndex , name )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			local key = name:sub( SIRequestMap.Names.ListButtonPosition )
			settings.scroll.scroll_to_element( settings.Elements[key] , "top-third" )
		end
	end ,
	EnableFunction = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			local key = name:sub( SIRequestMap.Names.EnablePosition )
			local flow = settings.Elements[key]
			if flow then
				flow.visible = element.state
			end
			-- 保存功能的启用状态
			key = key:sub( 1 , key:find( "_" ) )
			local tabSettingsIndex = settings.tabSettingsIndex
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
	Set_GreenToBlue_Check = function( playerIndex , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [绿箱向蓝箱供货-勾选] 复选框的值
			local tabSettingsIndex = settings.tabSettingsIndex
			local tabSettings = settings.TabSettingsList[tabSettingsIndex]
			tabSettings.GreenToBlue.Check = element.state
		end
	end ,
	Set_SetModule_FromInventory = function( playerIndex , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [设置插件-从背包填充] 复选框的值
			local tabSettingsIndex = settings.tabSettingsIndex
			local tabSettings = settings.TabSettingsList[tabSettingsIndex]
			tabSettings.SetModule.FromInventory = element.state
		end
	end ,
	Set_RemoveModule_ToInventory = function( playerIndex , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [移除插件-进入背包] 复选框的值
			local tabSettingsIndex = settings.tabSettingsIndex
			local tabSettings = settings.TabSettingsList[tabSettingsIndex]
			tabSettings.RemoveModule.ToInventory = element.state
		end
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
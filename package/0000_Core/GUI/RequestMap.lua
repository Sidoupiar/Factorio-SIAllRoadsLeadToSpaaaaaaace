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
		TabPane = "SI核心-紫图-分页面板"
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
			TabList = {} ,
			Elements = {} ,
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
		EnableRequestSlot = false ,
		EnableMaxSlot = false ,
		EnableGreenToBlue = false ,
		EnableSetModule = false ,
		EnableRemoveModule = false ,
		EnableInsertItem = false
	} ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 窗口函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	OpenFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )




		settings.label = nil
		settings.tabList = nil
		settings.TabList = {}
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
				CloseTooltip = { "SICore.紫图-窗口-关闭-提示" }
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
			local page = tabPane.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			settings.tabPane = tabPane
			settings.page = page
			for index , tabSettings in pairs( settings.TabSettingsList ) do
				local tab = tabPane.add{ type = "tab" , caption = { "SICore.紫图-窗口-分页标题" , tabSettings.Name } , tooltip = { "SICore.紫图-窗口-分页标题-提示" , SIRequestMap.TabSettingsMaxCount } }
				tabPane.add_tab( tab , page )
				table.insert( settings.TabList , tab )
			end
			-- 根据设置更新控件
			settings.tabPane.selected_tab_index = settings.tabSettingsIndex
			SIRequestMap.CreatePage( settings )
			SIRequestMap.FreshPage( settings )
		end
	end ,
	CloseFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			SIRequestMap.Save( settings )
			-- 清除临时数据
			settings.entities = nil
			settings.frame.destroy()
			settings.frame = nil
			settings.tabPane = nil
			settings.page = nil
			settings.TabList = {}
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
	Save = function( settings )
		local elements = settings.Elements
	end ,
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
	CreatePage = function( settings )
		local page = settings.page
		local list = page
		.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Common_ScrollPane }
		.add{ type = "table" , column_count = 1 , style = SIConstants_Core.raw.Styles.Common_List }
		-- 第 1 层
	end ,
	FreshPage = function( settings )
		local tabSettingsIndex = settings.tabSettingsIndex
		local tabSettings = settings.TabSettingsList[tabSettingsIndex]
		local elements = settings.Elements
	end ,
	EffectTabSettings = function( settings , tabSettingsIndex )
		local tabSettings = settings.TabSettingsList[tabSettingsIndex]
		local entities = settings.entities
	end ,
	SwitchTab = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			local tabSettingsIndex = settings.tabPane.selected_tab_index
			SIRequestMap.Save( settings )
			settings.tabSettingsIndex = tabSettingsIndex
			SIRequestMap.FreshPage( settings )
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
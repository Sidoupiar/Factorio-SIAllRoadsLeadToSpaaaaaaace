---@class SIRequestMap : SIBaseClass
SIRequestMap =
{
	ID = "RequestMap" ,
	Code = "RequestMap" ,
	Show = "紫图" ,
	InterfaceID = "SICore-RequestMap" ,
	Names =
	{
		Prefix = "SI工具图-紫图-" ,
		Frame = "SI工具图-紫图-窗口" ,
		Close = "SI工具图-紫图-关闭" ,
		Add = "SI工具图-紫图-添加" ,
		Delete = "SI工具图-紫图-删除" ,
		TabPane = "SI工具图-紫图-分页面板" ,
		TabSettingsName = "SI工具图-紫图-设置名称" ,
		DefaultIndex = "SI工具图-紫图-默认选择" ,
		GreenToBlue_Check = "SI工具图-紫图-绿箱向蓝箱供货-勾选" ,
		SetModule_FromInventory = "SI工具图-紫图-设置插件-从背包填充" ,
		RemoveModule_ToInventory = "SI工具图-紫图-移除插件-进入背包" ,
		RemoveModule_Invert = "SI工具图-紫图-移除插件-条件反转" ,
		ListButtonPrefix = "SI工具图-紫图-列表定位按钮-" ,
		EnablePrefix = "SI工具图-紫图-启用功能-" ,
		RequestSlot_Entity_Prefix = "SI工具图-紫图-请求格子-实体-" ,
		RequestSlot_Item_Prefix = "SI工具图-紫图-请求格子-物品-" ,
		MaxSlot_Entity_Prefix = "SI工具图-紫图-最大格子-实体-" ,
		MaxSlot_Count_Prefix = "SI工具图-紫图-最大格子-数量-" ,
		SetModule_Entity_Prefix = "SI工具图-紫图-设置插件-实体-" ,
		SetModule_Item_Prefix = "SI工具图-紫图-设置插件-物品-" ,
		RemoveModule_Entity_Prefix = "SI工具图-紫图-移除插件-实体-" ,
		RemoveModule_Item_Prefix = "SI工具图-紫图-移除插件-物品-" ,
		InsertFuel_Entity_Prefix = "SI工具图-紫图-插入燃料-实体-" ,
		InsertFuel_Item_Prefix = "SI工具图-紫图-插入燃料-物品-" ,
		InsertFuel_Count_Prefix = "SI工具图-紫图-插入燃料-数量-" ,
		InsertFuel_Mode_Prefix = "SI工具图-紫图-插入燃料-模式-" ,
		InsertAmmo_Entity_Prefix = "SI工具图-紫图-插入弹药-实体-" ,
		InsertAmmo_Item_Prefix = "SI工具图-紫图-插入弹药-物品-" ,
		InsertAmmo_Count_Prefix = "SI工具图-紫图-插入弹药-数量-" ,
		InsertAmmo_Mode_Prefix = "SI工具图-紫图-插入弹药-模式-"
	} ,
	Settings =
	{
		Name = "RequestMap" ,
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
				-- 	TabSettingsName = nil ,
				-- 	DefaultIndex = nil ,
				--	Scroll = nil ,
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
	ModuleEventID = script.generate_event_name() ,
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
		[1] = { "SIToolMap.紫图-窗口-选择-空" } ,
		[2] = { "SIToolMap.紫图-窗口-选择-1" } ,
		[3] = { "SIToolMap.紫图-窗口-选择-2" } ,
		[4] = { "SIToolMap.紫图-窗口-选择-3" } ,
		[5] = { "SIToolMap.紫图-窗口-选择-4" }
	} ,
	CountMode =
	{
		Total = 1 ,
		Single = 2
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
	RequestSlot_Entity_Filters_ShowHidden =
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
	RequestSlot_Item_Filters = {} , -- 暂时不需要设置筛选器
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
	RemoveModule_Entity_Filters_ShowHidden =
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
	RemoveModule_Item_Filters =
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
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 窗口函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	OpenFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )


		-- local newTabSettingsList = {}
		-- for index , tabSettings in pairs( settings.TabSettingsList ) do
		-- 	local newTabSettings = SIUtils.table.deepcopy( SIRequestMap.DefaultTabSettings )
		-- 	for key , value in pairs( newTabSettings ) do
		-- 		if tabSettings[key] then
		-- 			newTabSettings[key] = tabSettings[key]
		-- 		end
		-- 	end
		--	table.insert( newTabSettingsList , newTabSettings )
		-- end
		-- settings.TabSettingsList = newTabSettingsList


		if settings.frame and settings.frame.valid then
			SIRequestMap.CloseFrame( playerIndex )
		else
			local player = game.get_player( playerIndex )
			-- 显示窗口
			local frame = SIElements.CreateFrame( player , settings ,
			{
				Name         = SIRequestMap.Names.Frame ,
				Close        = SIRequestMap.Names.Close ,
				Style        = SIConstants_ToolMap.raw.Styles.RequestMap_Frame ,
				Title        = { "SIToolMap.紫图-窗口-标题" } ,
				TitleTooltip = { "SIToolMap.紫图-窗口-标题-提示" , { "item-name.infinity-chest" } , { "SIToolMapName.物品-紫图" } } ,
				UseTooltip   = { "SIToolMap.紫图-窗口-使用-提示" , { "item-name.infinity-chest" } , { "SIToolMapName.物品-紫图" } } ,
				CloseTooltip = { "SIToolMap.紫图-窗口-关闭-提示" } ,
				OtherButtons =
				{
					{
						Name = SIRequestMap.Names.Add ,
						Item = SIConstants_Core.raw.Items.IconAdd ,
						Tooltip = { "SIToolMap.紫图-窗口-新增-提示" , SIRequestMap.TabSettingsMaxCount }
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
			settings.tabPane = frame.add{ type = "tabbed-pane" , name = SIRequestMap.Names.TabPane , style = SIConstants_ToolMap.raw.Styles.RequestMap_TabPane }
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
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 控件函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
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
			local tab = tabPane.add{ type = "tab" , caption = { "SIToolMap.紫图-窗口-分页标题" , tabSettings.Name } , tooltip = { "SIToolMap.紫图-窗口-分页标题-提示" , SIRequestMap.TabSettingsMaxCount } }
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
	-- ======================================================================<br>
	-- 这是一个内部函数 , 请勿外部调用<br>
	-- ======================================================================<br>
	CreatePage = function( settings , tabSettingsIndex )
		local page = settings.tabPane.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
		local elements = settings.Elements[tabSettingsIndex]
		-- ======================================================================
		-- 设置名称
		-- ======================================================================
		local nameFlow = page.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowCenterH }
		nameFlow.add{ type = "label" , caption = { "SIToolMap.紫图-窗口-名称" } , tooltip = { "SIToolMap.紫图-窗口-名称-提示" } , style = SIConstants_ToolMap.raw.Styles.RequestMap_Label }
		elements.TabSettingsName = nameFlow.add{ type = "textfield" , name = SIRequestMap.Names.TabSettingsName , text = nil , tooltip = { "SIToolMap.紫图-窗口-名称-提示" } , style = SIConstants_ToolMap.raw.Styles.RequestMap_Text }
		nameFlow.add{ type = "flow" , direction = "vertical" , style = SIConstants_ToolMap.raw.Styles.RequestMap_EmptyFlow }
		nameFlow.add{ type = "button" , name = SIRequestMap.Names.Delete , caption = { "SIToolMap.紫图-窗口-删除" } , tooltip = { "SIToolMap.紫图-窗口-删除-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonRed }
		-- ======================================================================
		-- 默认选择
		-- ======================================================================
		local defaultIndexFlow = page.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowCenterH }
		defaultIndexFlow.add{ type = "label" , caption = { "SIToolMap.紫图-窗口-默认选择" } , tooltip = { "SIToolMap.紫图-窗口-默认选择-提示" } , style = SIConstants_ToolMap.raw.Styles.RequestMap_Label }
		elements.DefaultIndex = defaultIndexFlow.add
		{
			type = "drop-down" ,
			name = SIRequestMap.Names.DefaultIndex ,
			caption = { "SIToolMap.紫图-窗口-默认选择" } ,
			tooltip = { "SIToolMap.紫图-窗口-默认选择-提示" } ,
			items = SIRequestMap.DefaultIndexText ,
			selected_index = 1 ,
			style = SIConstants_ToolMap.raw.Styles.RequestMap_DropDown
		}
		-- ======================================================================
		-- 设置列表按钮
		-- ======================================================================
		local listButtonFlow = page.add{ type = "flow" , direction = "horizontal" , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListButtonFlow }
		-- ======================================================================
		-- 设置列表
		-- ======================================================================
		local scroll = page.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Common_ScrollPane }
		local list = scroll.add{ type = "table" , column_count = 1 , style = SIConstants_Core.raw.Styles.Common_List }
		elements.Scroll = scroll
		-- ======================================================================
		-- 请求格子
		-- ======================================================================
		elements.RequestSlot_Enable = list.add{ type = "checkbox" , name = SIRequestMap.Names.EnablePrefix .. "RequestSlot_Flow" , state = false , caption = { "SIToolMap.紫图-窗口-请求格子-启用" , { "SIToolMap.紫图-窗口-启用-未设置" } } , tooltip = { "SIToolMap.紫图-窗口-请求格子-启用-提示" } , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListCheck }
		local RequestSlot_Flow = list.add{ type = "flow" , direction = "vertical" , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListPanelFlow }
		elements.RequestSlot_Flow = RequestSlot_Flow
		elements.RequestSlot_List = RequestSlot_Flow.add{ type = "table" , column_count = 3 , style = SIConstants_ToolMap.raw.Styles.RequestMap_SubList }
		-- ======================================================================
		-- 最大格子
		-- ======================================================================
		elements.MaxSlot_Enable = list.add{ type = "checkbox" , name = SIRequestMap.Names.EnablePrefix .. "MaxSlot_Flow" , state = false , caption = { "SIToolMap.紫图-窗口-最大格子-启用" , { "SIToolMap.紫图-窗口-启用-未设置" } } , tooltip = { "SIToolMap.紫图-窗口-最大格子-启用-提示" } , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListCheck }
		local MaxSlot_Flow = list.add{ type = "flow" , direction = "vertical" , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListPanelFlow }
		elements.MaxSlot_Flow = MaxSlot_Flow
		elements.MaxSlot_List = MaxSlot_Flow.add{ type = "table" , column_count = 2 , style = SIConstants_ToolMap.raw.Styles.RequestMap_SubList }
		-- ======================================================================
		-- 绿箱向蓝箱供货
		-- ======================================================================
		elements.GreenToBlue_Enable = list.add{ type = "checkbox" , name = SIRequestMap.Names.EnablePrefix .. "GreenToBlue_Flow" , state = false , caption = { "SIToolMap.紫图-窗口-绿箱向蓝箱供货-启用" , { "SIToolMap.紫图-窗口-启用-未设置" } } , tooltip = { "SIToolMap.紫图-窗口-绿箱向蓝箱供货-启用-提示" } , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListCheck }
		local GreenToBlue_Flow = list.add{ type = "flow" , direction = "vertical" , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListPanelFlow }
		elements.GreenToBlue_Flow = GreenToBlue_Flow
		elements.GreenToBlue_Check = GreenToBlue_Flow.add{ type = "checkbox" , name = SIRequestMap.Names.GreenToBlue_Check , state = false , caption = { "SIToolMap.紫图-窗口-绿箱向蓝箱供货-勾选" } , tooltip = { "SIToolMap.紫图-窗口-绿箱向蓝箱供货-勾选-提示" } , style = SIConstants_Core.raw.Styles.Common_CheckBox }
		-- ======================================================================
		-- 设置插件
		-- ======================================================================
		elements.SetModule_Enable = list.add{ type = "checkbox" , name = SIRequestMap.Names.EnablePrefix .. "SetModule_Flow" , state = false , caption = { "SIToolMap.紫图-窗口-设置插件-启用" , { "SIToolMap.紫图-窗口-启用-未设置" } } , tooltip = { "SIToolMap.紫图-窗口-设置插件-启用-提示" } , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListCheck }
		local SetModule_Flow = list.add{ type = "flow" , direction = "vertical" , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListPanelFlow }
		elements.SetModule_Flow = SetModule_Flow
		elements.SetModule_FromInventory = SetModule_Flow.add{ type = "checkbox" , name = SIRequestMap.Names.SetModule_FromInventory , state = false , caption = { "SIToolMap.紫图-窗口-设置插件-从背包填充" } , tooltip = { "SIToolMap.紫图-窗口-设置插件-从背包填充-提示" } , style = SIConstants_Core.raw.Styles.Common_CheckBox }
		elements.SetModule_List = SetModule_Flow.add{ type = "table" , column_count = 3 , style = SIConstants_ToolMap.raw.Styles.RequestMap_SubList }
		-- ======================================================================
		-- 移除插件
		-- ======================================================================
		elements.RemoveModule_Enable = list.add{ type = "checkbox" , name = SIRequestMap.Names.EnablePrefix .. "RemoveModule_Flow" , state = false , caption = { "SIToolMap.紫图-窗口-移除插件-启用" , { "SIToolMap.紫图-窗口-启用-未设置" } } , tooltip = { "SIToolMap.紫图-窗口-移除插件-启用-提示" } , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListCheck }
		local RemoveModule_Flow = list.add{ type = "flow" , direction = "vertical" , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListPanelFlow }
		elements.RemoveModule_Flow = RemoveModule_Flow
		elements.RemoveModule_ToInventory = RemoveModule_Flow.add{ type = "checkbox" , name = SIRequestMap.Names.RemoveModule_ToInventory , state = false , caption = { "SIToolMap.紫图-窗口-移除插件-进入背包" } , tooltip = { "SIToolMap.紫图-窗口-移除插件-进入背包-提示" } , style = SIConstants_Core.raw.Styles.Common_CheckBox }
		elements.RemoveModule_Invert = RemoveModule_Flow.add{ type = "checkbox" , name = SIRequestMap.Names.RemoveModule_Invert , state = false , caption = { "SIToolMap.紫图-窗口-移除插件-条件反转" } , tooltip = { "SIToolMap.紫图-窗口-移除插件-条件反转-提示" } , style = SIConstants_Core.raw.Styles.Common_CheckBox }
		elements.RemoveModule_List = RemoveModule_Flow.add{ type = "table" , column_count = 3 , style = SIConstants_ToolMap.raw.Styles.RequestMap_SubList }
		-- ======================================================================
		-- 插入燃料
		-- ======================================================================
		elements.InsertFuel_Enable = list.add{ type = "checkbox" , name = SIRequestMap.Names.EnablePrefix .. "InsertFuel_Flow" , state = false , caption = { "SIToolMap.紫图-窗口-插入燃料-启用" , { "SIToolMap.紫图-窗口-启用-未设置" } } , tooltip = { "SIToolMap.紫图-窗口-插入燃料-启用-提示" } , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListCheck }
		local InsertFuel_Flow = list.add{ type = "flow" , direction = "vertical" , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListPanelFlow }
		elements.InsertFuel_Flow = InsertFuel_Flow
		elements.InsertFuel_List = InsertFuel_Flow.add{ type = "table" , column_count = 2 , style = SIConstants_ToolMap.raw.Styles.RequestMap_SubList }
		-- ======================================================================
		-- 插入弹药
		-- ======================================================================
		elements.InsertAmmo_Enable = list.add{ type = "checkbox" , name = SIRequestMap.Names.EnablePrefix .. "InsertAmmo_Flow" , state = false , caption = { "SIToolMap.紫图-窗口-插入弹药-启用" , { "SIToolMap.紫图-窗口-启用-未设置" } } , tooltip = { "SIToolMap.紫图-窗口-插入弹药-启用-提示" } , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListCheck }
		local InsertAmmo_Flow = list.add{ type = "flow" , direction = "vertical" , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListPanelFlow }
		elements.InsertAmmo_Flow = InsertAmmo_Flow
		elements.InsertAmmo_List = InsertAmmo_Flow.add{ type = "table" , column_count = 2 , style = SIConstants_ToolMap.raw.Styles.RequestMap_SubList }
		-- ======================================================================
		-- 插入空白区
		-- ======================================================================
		list.add{ type = "flow" , direction = "vertical" , style = SIConstants_ToolMap.raw.Styles.RequestMap_BlankFlow }
		-- ======================================================================
		-- 创建滚动定位按钮
		-- ======================================================================
		for key , value in pairs( SIRequestMap.DefaultTabSettings ) do
			if key ~= "Name" then
				local button = listButtonFlow.add{ type = "sprite-button" , name = SIRequestMap.Names.ListButtonPrefix .. key .. "_Enable" , sprite = "item/" .. SIRequestMap.ListButtonIcon[key] , tooltip = { "SIToolMap.紫图-窗口-列表定位按钮-提示" , { elements[key .. "_Enable"].caption[1] , "" } } , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListButton }
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
		-- ======================================================================
		-- 设置名称
		-- ======================================================================
		elements.TabSettingsName.text = tabSettings.Name
		-- ======================================================================
		-- 默认选择
		-- ======================================================================
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
		-- ======================================================================
		-- 请求格子
		-- ======================================================================
		elements.RequestSlot_Enable.state = tabSettings.RequestSlot.Enable
		elements.RequestSlot_Flow.visible = tabSettings.RequestSlot.Enable
		SIRequestMap.FreshPage_RequestSlot( settings , tabSettings , elements )
		-- ======================================================================
		-- 最大格子
		-- ======================================================================
		elements.MaxSlot_Enable.state = tabSettings.MaxSlot.Enable
		elements.MaxSlot_Flow.visible = tabSettings.MaxSlot.Enable
		SIRequestMap.FreshPage_MaxSlot( settings , tabSettings , elements )
		-- ======================================================================
		-- 绿箱向蓝箱供货
		-- ======================================================================
		elements.GreenToBlue_Enable.state = tabSettings.GreenToBlue.Enable
		elements.GreenToBlue_Flow.visible = tabSettings.GreenToBlue.Enable
		elements.GreenToBlue_Check.state = tabSettings.GreenToBlue.Check
		SIRequestMap.FreshPage_GreenToBlue( settings , tabSettings , elements )
		-- ======================================================================
		-- 设置插件
		-- ======================================================================
		elements.SetModule_Enable.state = tabSettings.SetModule.Enable
		elements.SetModule_Flow.visible = tabSettings.SetModule.Enable
		elements.SetModule_FromInventory.state = tabSettings.SetModule.FromInventory
		SIRequestMap.FreshPage_SetModule( settings , tabSettings , elements )
		-- ======================================================================
		-- 移除插件
		-- ======================================================================
		elements.RemoveModule_Enable.state = tabSettings.RemoveModule.Enable
		elements.RemoveModule_Flow.visible = tabSettings.RemoveModule.Enable
		elements.RemoveModule_ToInventory.state = tabSettings.RemoveModule.ToInventory
		elements.RemoveModule_Invert.state = tabSettings.RemoveModule.Invert
		SIRequestMap.FreshPage_RemoveModule( settings , tabSettings , elements )
		-- ======================================================================
		-- 插入燃料
		-- ======================================================================
		elements.InsertFuel_Enable.state = tabSettings.InsertFuel.Enable
		elements.InsertFuel_Flow.visible = tabSettings.InsertFuel.Enable
		SIRequestMap.FreshPage_InsertFuel( settings , tabSettings , elements )
		-- ======================================================================
		-- 插入弹药
		-- ======================================================================
		elements.InsertAmmo_Enable.state = tabSettings.InsertAmmo.Enable
		elements.InsertAmmo_Flow.visible = tabSettings.InsertAmmo.Enable
		SIRequestMap.FreshPage_InsertAmmo( settings , tabSettings , elements )
	end ,
	FreshPage_RequestSlot = function( settings , tabSettings , elements )
		-- 更新说明
		elements.RequestSlot_Enable.caption = { "SIToolMap.紫图-窗口-请求格子-启用" , { SITable.Size( tabSettings.RequestSlot.List ) > 0 and "SIToolMap.紫图-窗口-启用-已设置" or "SIToolMap.紫图-窗口-启用-未设置" } }
		-- 清空列表
		local list = elements.RequestSlot_List
		list.clear()
		-- 选择筛选器
		local entityFilter = SISettings.PerUser.SICore.ShowHiddenEntity( settings.playerIndex ) and SIRequestMap.RequestSlot_Entity_Filters_ShowHidden or SIRequestMap.RequestSlot_Entity_Filters
		-- 重建列表
		for entityName , requestItemList in pairs( tabSettings.RequestSlot.List ) do
			local entityPrototype = prototypes.entity[entityName]
			local entityTooltip = nil
			local entityNameSelected = entityName
			local maxSlot = 0
			if entityPrototype then
				entityTooltip = { "SIToolMap.紫图-窗口-请求格子-实体-提示" , entityPrototype.localised_name }
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
					SIPrint.Warning( settings.playerIndex , { "SIToolMap.紫图-提示-请求格子-格子太多" , entityName , entityPrototype.localised_name , SIRequestMap.RequestSlot_ItemSlotMax } )
					maxSlot = SIRequestMap.RequestSlot_ItemSlotMax
				end
			else
				entityTooltip = { "SIToolMap.紫图-窗口-请求格子-实体-空-提示" , entityName }
				entityNameSelected = SIConstants_Core.raw.Entities.IconEmpty
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
				entity = entityNameSelected ,
				elem_filters = entityFilter ,
				style = SIConstants_ToolMap.raw.Styles.RequestMap_ListChooser
			}
			local selectList1 = list.add{ type = "table" , column_count = 10 , style = SIConstants_ToolMap.raw.Styles.RequestMap_SelectList }
			local selectList2 = list.add{ type = "table" , column_count = 10 , style = SIConstants_ToolMap.raw.Styles.RequestMap_SelectList }
			for slotIndex = 1 , maxSlot , 1 do
				local selectList = math.fmod( math.floor( ( slotIndex - 1 ) / 10 ) , 2 ) == 0 and selectList1 or selectList2
				local itemTooltip = nil
				local itemName = requestItemList[slotIndex]
				if itemName then
					local itemPrototype = prototypes.item[itemName]
					if itemPrototype then
						itemTooltip = { "SIToolMap.紫图-窗口-请求格子-物品-提示" , itemPrototype.localised_name }
					else
						itemTooltip = { "SIToolMap.紫图-窗口-请求格子-物品-空-提示" , itemName }
						itemName = SIConstants_Core.raw.Items.IconEmpty
					end
				else
					itemTooltip = { "SIToolMap.紫图-窗口-请求格子-物品-选择-提示" }
				end
				selectList.add
				{
					type = "choose-elem-button" ,
					name = SIRequestMap.Names.RequestSlot_Item_Prefix .. slotIndex .. "_" .. entityName ,
					tooltip = itemTooltip ,
					elem_type = "item" ,
					item = itemName ,
					elem_filters = SIRequestMap.RequestSlot_Item_Filters ,
					style = SIConstants_ToolMap.raw.Styles.RequestMap_ListChooser
				}
			end
		end
		list.add
		{
			type = "choose-elem-button" ,
			name = SIRequestMap.Names.RequestSlot_Entity_Prefix ,
			tooltip = { "SIToolMap.紫图-窗口-请求格子-实体-选择-提示" } ,
			elem_type = "entity" ,
			entity = nil ,
			elem_filters = entityFilter ,
			style = SIConstants_ToolMap.raw.Styles.RequestMap_ListChooser
		}
	end ,
	FreshPage_MaxSlot = function( settings , tabSettings , elements )
		-- 更新说明
		elements.MaxSlot_Enable.caption = { "SIToolMap.紫图-窗口-最大格子-启用" , { SITable.Size( tabSettings.MaxSlot.List ) > 0 and "SIToolMap.紫图-窗口-启用-已设置" or "SIToolMap.紫图-窗口-启用-未设置" } }
		-- 清空列表
		local list = elements.MaxSlot_List
		list.clear()
		-- 选择筛选器
		local entityFilter = SISettings.PerUser.SICore.ShowHiddenEntity( settings.playerIndex ) and SIRequestMap.MaxSlot_Entity_Filters_ShowHidden or SIRequestMap.MaxSlot_Entity_Filters
		-- 重建列表
		for entityName , count in pairs( tabSettings.MaxSlot.List ) do
			local entityPrototype = prototypes.entity[entityName]
			local entityTooltip = nil
			local entityNameSelected = entityName
			local maxCount = 0
			if entityPrototype then
				entityTooltip = { "SIToolMap.紫图-窗口-最大格子-实体-提示" , entityPrototype.localised_name }
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
				entityTooltip = { "SIToolMap.紫图-窗口-最大格子-实体-空-提示" , entityName }
				entityNameSelected = SIConstants_Core.raw.Entities.IconEmpty
				maxCount = 0
			end
			list.add
			{
				type = "choose-elem-button" ,
				name = SIRequestMap.Names.MaxSlot_Entity_Prefix .. entityName ,
				tooltip = entityTooltip ,
				elem_type = "entity" ,
				entity = entityNameSelected ,
				elem_filters = entityFilter ,
				style = SIConstants_ToolMap.raw.Styles.RequestMap_ListChooser
			}
			local flow = list.add{ type = "flow" , direction = "horizontal" , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListFlow }
			flow.add{ type = "label" , caption = { "SIToolMap.紫图-窗口-最大格子-数量前缀" , maxCount } , tooltip = { "SIToolMap.紫图-窗口-最大格子-数量-提示" } , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListLabel }
			flow.add{ type = "textfield" , name = SIRequestMap.Names.MaxSlot_Count_Prefix .. entityName , text = tostring( count ) , numeric = true , tooltip = { "SIToolMap.紫图-窗口-最大格子-数量-提示" } , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListText }
			flow.add{ type = "label" , caption = { "SIToolMap.紫图-窗口-最大格子-数量后缀" } , tooltip = { "SIToolMap.紫图-窗口-最大格子-数量-提示" } , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListLabel }
		end
		list.add
		{
			type = "choose-elem-button" ,
			name = SIRequestMap.Names.MaxSlot_Entity_Prefix ,
			tooltip = { "SIToolMap.紫图-窗口-最大格子-实体-选择-提示" } ,
			elem_type = "entity" ,
			entity = nil ,
			elem_filters = entityFilter ,
			style = SIConstants_ToolMap.raw.Styles.RequestMap_ListChooser
		}
	end ,
	FreshPage_GreenToBlue = function( settings , tabSettings , elements )
		-- 更新说明
		elements.GreenToBlue_Enable.caption = { "SIToolMap.紫图-窗口-绿箱向蓝箱供货-启用" , { tabSettings.GreenToBlue.Check and "SIToolMap.紫图-窗口-启用-未设置" or "SIToolMap.紫图-窗口-启用-已设置" } }
	end ,
	FreshPage_SetModule = function( settings , tabSettings , elements )
		-- 更新说明
		SIRequestMap.FreshPage_SetModule_Enable( settings , tabSettings , elements )
		-- 清空列表
		local list = elements.SetModule_List
		list.clear()
		-- 选择筛选器
		local entityFilter = SISettings.PerUser.SICore.ShowHiddenEntity( settings.playerIndex ) and SIRequestMap.SetModule_Entity_Filters_ShowHidden or SIRequestMap.SetModule_Entity_Filters
		-- 重建列表
		for entityName , moduleList in pairs( tabSettings.SetModule.List ) do
			local entityPrototype = prototypes.entity[entityName]
			local entityTooltip = nil
			local entityNameSelected = entityName
			local maxSlot = 0
			if entityPrototype then
				entityTooltip = { "SIToolMap.紫图-窗口-设置插件-实体-提示" , entityPrototype.localised_name }
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
				entityTooltip = { "SIToolMap.紫图-窗口-设置插件-实体-空-提示" , entityName }
				entityNameSelected = SIConstants_Core.raw.Entities.IconEmpty
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
				entity = entityNameSelected ,
				elem_filters = entityFilter ,
				style = SIConstants_ToolMap.raw.Styles.RequestMap_ListChooser
			}
			local selectList1 = list.add{ type = "table" , column_count = 10 , style = SIConstants_ToolMap.raw.Styles.RequestMap_SelectList }
			local selectList2 = list.add{ type = "table" , column_count = 10 , style = SIConstants_ToolMap.raw.Styles.RequestMap_SelectList }
			for slotIndex = 1 , maxSlot , 1 do
				local selectList = math.fmod( math.floor( ( slotIndex - 1 ) / 10 ) , 2 ) == 0 and selectList1 or selectList2
				local itemTooltip = nil
				local itemName = moduleList[slotIndex]
				if itemName then
					local itemPrototype = prototypes.item[itemName]
					if itemPrototype then
						itemTooltip = { "SIToolMap.紫图-窗口-设置插件-物品-提示" , itemPrototype.localised_name }
					else
						itemTooltip = { "SIToolMap.紫图-窗口-设置插件-物品-空-提示" , itemName }
						itemName = SIConstants_Core.raw.Items.IconEmpty
					end
				else
					itemTooltip = { "SIToolMap.紫图-窗口-设置插件-物品-选择-提示" }
				end
				selectList.add
				{
					type = "choose-elem-button" ,
					name = SIRequestMap.Names.SetModule_Item_Prefix .. slotIndex .. "_" .. entityName ,
					tooltip = itemTooltip ,
					elem_type = "item" ,
					item = itemName ,
					elem_filters = SIRequestMap.SetModule_Item_Filters ,
					style = SIConstants_ToolMap.raw.Styles.RequestMap_ListChooser
				}
			end
		end
		list.add
		{
			type = "choose-elem-button" ,
			name = SIRequestMap.Names.SetModule_Entity_Prefix ,
			tooltip = { "SIToolMap.紫图-窗口-设置插件-实体-选择-提示" } ,
			elem_type = "entity" ,
			entity = nil ,
			elem_filters = entityFilter ,
			style = SIConstants_ToolMap.raw.Styles.RequestMap_ListChooser
		}
	end ,
	FreshPage_SetModule_Enable = function( settings , tabSettings , elements )
		-- 更新说明
		elements.SetModule_Enable.caption = { "SIToolMap.紫图-窗口-设置插件-启用" , { ( tabSettings.SetModule.FromInventory or SITable.Size( tabSettings.SetModule.List ) > 0 ) and "SIToolMap.紫图-窗口-启用-已设置" or "SIToolMap.紫图-窗口-启用-未设置" } }
	end ,
	FreshPage_RemoveModule = function( settings , tabSettings , elements )
		-- 更新说明
		SIRequestMap.FreshPage_RemoveModule_Enable( settings , tabSettings , elements )
		-- 清空列表
		local list = elements.RemoveModule_List
		list.clear()
		-- 选择筛选器
		local entityFilter = SISettings.PerUser.SICore.ShowHiddenEntity( settings.playerIndex ) and SIRequestMap.RemoveModule_Entity_Filters_ShowHidden or SIRequestMap.RemoveModule_Entity_Filters
		-- 重建列表
		for entityName , moduleList in pairs( tabSettings.RemoveModule.List ) do
			local entityPrototype = prototypes.entity[entityName]
			local entityTooltip = nil
			local entityNameSelected = entityName
			local maxSlot = 0
			if entityPrototype then
				entityTooltip = { "SIToolMap.紫图-窗口-移除插件-实体-提示" , entityPrototype.localised_name }
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
				entityTooltip = { "SIToolMap.紫图-窗口-移除插件-实体-空-提示" , entityName }
				entityNameSelected = SIConstants_Core.raw.Entities.IconEmpty
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
				entity = entityNameSelected ,
				elem_filters = entityFilter ,
				style = SIConstants_ToolMap.raw.Styles.RequestMap_ListChooser
			}
			local selectList1 = list.add{ type = "table" , column_count = 10 , style = SIConstants_ToolMap.raw.Styles.RequestMap_SelectList }
			local selectList2 = list.add{ type = "table" , column_count = 10 , style = SIConstants_ToolMap.raw.Styles.RequestMap_SelectList }
			for slotIndex = 1 , maxSlot , 1 do
				local selectList = math.fmod( math.floor( ( slotIndex - 1 ) / 10 ) , 2 ) == 0 and selectList1 or selectList2
				local itemTooltip = nil
				local itemName = moduleList[slotIndex]
				if itemName then
					local itemPrototype = prototypes.item[itemName]
					if itemPrototype then
						itemTooltip = { "SIToolMap.紫图-窗口-移除插件-物品-提示" , itemPrototype.localised_name }
					else
						itemTooltip = { "SIToolMap.紫图-窗口-移除插件-物品-空-提示" , itemName }
						itemName = SIConstants_Core.raw.Items.IconEmpty
					end
				else
					itemTooltip = { "SIToolMap.紫图-窗口-移除插件-物品-选择-提示" }
				end
				selectList.add
				{
					type = "choose-elem-button" ,
					name = SIRequestMap.Names.RemoveModule_Item_Prefix .. slotIndex .. "_" .. entityName ,
					tooltip = itemTooltip ,
					elem_type = "item" ,
					item = itemName ,
					elem_filters = SIRequestMap.RemoveModule_Item_Filters ,
					style = SIConstants_ToolMap.raw.Styles.RequestMap_ListChooser
				}
			end
		end
		list.add
		{
			type = "choose-elem-button" ,
			name = SIRequestMap.Names.RemoveModule_Entity_Prefix ,
			tooltip = { "SIToolMap.紫图-窗口-移除插件-实体-选择-提示" } ,
			elem_type = "entity" ,
			entity = nil ,
			elem_filters = entityFilter ,
			style = SIConstants_ToolMap.raw.Styles.RequestMap_ListChooser
		}
	end ,
	FreshPage_RemoveModule_Enable = function( settings , tabSettings , elements )
		-- 更新说明
		elements.RemoveModule_Enable.caption = { "SIToolMap.紫图-窗口-移除插件-启用" , { ( tabSettings.RemoveModule.ToInventory or tabSettings.RemoveModule.Invert or SITable.Size( tabSettings.RemoveModule.List ) > 0 ) and "SIToolMap.紫图-窗口-启用-已设置" or "SIToolMap.紫图-窗口-启用-未设置" } }
	end ,
	FreshPage_InsertFuel = function( settings , tabSettings , elements )
		-- 更新说明
		elements.InsertFuel_Enable.caption = { "SIToolMap.紫图-窗口-插入燃料-启用" , { SITable.Size( tabSettings.InsertFuel.List ) > 0 and "SIToolMap.紫图-窗口-启用-已设置" or "SIToolMap.紫图-窗口-启用-未设置" } }
		-- 清空列表
		local list = elements.InsertFuel_List
		list.clear()
		-- 选择筛选器
		local entityFilter = SISettings.PerUser.SICore.ShowHiddenEntity( settings.playerIndex ) and SIRequestMap.InsertFuel_Entity_Filters_ShowHidden or SIRequestMap.InsertFuel_Entity_Filters
		-- 重建列表
		for entityName , itemDataList in pairs( tabSettings.InsertFuel.List ) do
			local entityPrototype = prototypes.entity[entityName]
			if entityPrototype then
				list.add
				{
					type = "choose-elem-button" ,
					name = SIRequestMap.Names.InsertFuel_Entity_Prefix .. entityName ,
					tooltip = { "SIToolMap.紫图-窗口-插入燃料-实体-提示" , entityPrototype.localised_name } ,
					elem_type = "entity" ,
					entity = entityName ,
					elem_filters = entityFilter ,
					style = SIConstants_ToolMap.raw.Styles.RequestMap_ListChooser
				}
				local subList = list.add{ type = "table" , column_count = 7 , style = SIConstants_ToolMap.raw.Styles.RequestMap_SelectList }
				if entityPrototype.burner_prototype then
					local fuelFilter = SIUtils.table.deepcopy( SIRequestMap.InsertFuel_Item_Filters )
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
							local itemPrototype = prototypes.item[itemName]
							if itemPrototype then
								itemTooltip = { "SIToolMap.紫图-窗口-插入燃料-物品-提示" , itemPrototype.localised_name }
							else
								itemTooltip = { "SIToolMap.紫图-窗口-插入燃料-物品-空-提示" , itemName }
								itemName = SIConstants_Core.raw.Items.IconEmpty
							end
						else
							itemTooltip = { "SIToolMap.紫图-窗口-插入燃料-物品-选择-提示" }
						end
						subList.add
						{
							type = "choose-elem-button" ,
							name = SIRequestMap.Names.InsertFuel_Item_Prefix .. itemDataIndex .. "_" .. entityName ,
							tooltip = itemTooltip ,
							elem_type = "item" ,
							item = itemName ,
							elem_filters = fuelFilter ,
							style = SIConstants_ToolMap.raw.Styles.RequestMap_ListChooser
						}
						subList.add{ type = "flow" , direction = "horizontal" , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListEmptyFlow }
						subList.add{ type = "label" , caption = { "SIToolMap.紫图-窗口-插入燃料-数量" } , tooltip = { "SIToolMap.紫图-窗口-插入燃料-数量-提示" } , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListLabel }
						subList.add{ type = "textfield" , name = SIRequestMap.Names.InsertFuel_Count_Prefix .. itemDataIndex .. "_" .. entityName , text = tostring( itemData.Count or 1 ) , numeric = true , tooltip = { "SIToolMap.紫图-窗口-插入燃料-数量-提示" } , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListText }
						subList.add{ type = "flow" , direction = "horizontal" , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListEmptyFlow }
						subList.add{ type = "label" , caption = { "SIToolMap.紫图-窗口-插入燃料-模式" } , tooltip = { "SIToolMap.紫图-窗口-插入燃料-模式-提示" } , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListLabel }
						subList.add
						{
							type = "drop-down" ,
							name = SIRequestMap.Names.InsertFuel_Mode_Prefix .. itemDataIndex .. "_" .. entityName ,
							caption = { "SIToolMap.紫图-窗口-插入燃料-模式" } ,
							tooltip = { "SIToolMap.紫图-窗口-插入燃料-模式-提示" } ,
							items = SIRequestMap.CountModeText ,
							selected_index = itemData.Mode or SIRequestMap.CountMode.Total ,
							style = SIConstants_ToolMap.raw.Styles.RequestMap_ListDropDown
						}
					end
				end
			else
				list.add
				{
					type = "choose-elem-button" ,
					name = SIRequestMap.Names.InsertFuel_Entity_Prefix .. entityName ,
					tooltip = { "SIToolMap.紫图-窗口-插入燃料-实体-空-提示" , entityName } ,
					elem_type = "entity" ,
					entity = SIConstants_Core.raw.Entities.IconEmpty ,
					elem_filters = entityFilter ,
					style = SIConstants_ToolMap.raw.Styles.RequestMap_ListChooser
				}
				local subList = list.add{ type = "table" , column_count = 7 , style = SIConstants_ToolMap.raw.Styles.RequestMap_SelectList }
				local fuelFilter = SIUtils.table.deepcopy( SIRequestMap.InsertFuel_Item_Filters )
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
						local itemPrototype = prototypes.item[itemName]
						if itemPrototype then
							itemTooltip = { "SIToolMap.紫图-窗口-插入燃料-物品-提示" , itemPrototype.localised_name }
						else
							itemTooltip = { "SIToolMap.紫图-窗口-插入燃料-物品-空-提示" , itemName }
							itemName = SIConstants_Core.raw.Items.IconEmpty
						end
					else
						itemTooltip = { "SIToolMap.紫图-窗口-插入燃料-物品-选择-提示" }
					end
					subList.add
					{
						type = "choose-elem-button" ,
						name = SIRequestMap.Names.InsertFuel_Item_Prefix .. itemDataIndex .. "_" .. entityName ,
						tooltip = itemTooltip ,
						elem_type = "item" ,
						item = itemName ,
						elem_filters = fuelFilter ,
						style = SIConstants_ToolMap.raw.Styles.RequestMap_ListChooser
					}
					subList.add{ type = "flow" , direction = "horizontal" , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListEmptyFlow }
					subList.add{ type = "label" , caption = { "SIToolMap.紫图-窗口-插入燃料-数量" } , tooltip = { "SIToolMap.紫图-窗口-插入燃料-数量-提示" } , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListLabel }
					subList.add{ type = "textfield" , name = SIRequestMap.Names.InsertFuel_Count_Prefix .. itemDataIndex .. "_" .. entityName , text = tostring( itemData.Count or 1 ) , numeric = true , tooltip = { "SIToolMap.紫图-窗口-插入燃料-数量-提示" } , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListText }
					subList.add{ type = "flow" , direction = "horizontal" , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListEmptyFlow }
					subList.add{ type = "label" , caption = { "SIToolMap.紫图-窗口-插入燃料-模式" } , tooltip = { "SIToolMap.紫图-窗口-插入燃料-模式-提示" } , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListLabel }
					subList.add
					{
						type = "drop-down" ,
						name = SIRequestMap.Names.InsertFuel_Mode_Prefix .. itemDataIndex .. "_" .. entityName ,
						caption = { "SIToolMap.紫图-窗口-插入燃料-模式" } ,
						tooltip = { "SIToolMap.紫图-窗口-插入燃料-模式-提示" } ,
						items = SIRequestMap.CountModeText ,
						selected_index = itemData.Mode or SIRequestMap.CountMode.Total ,
						style = SIConstants_ToolMap.raw.Styles.RequestMap_ListDropDown
					}
				end
			end
		end
		list.add
		{
			type = "choose-elem-button" ,
			name = SIRequestMap.Names.InsertFuel_Entity_Prefix ,
			tooltip = { "SIToolMap.紫图-窗口-插入燃料-实体-选择-提示" } ,
			elem_type = "entity" ,
			entity = nil ,
			elem_filters = entityFilter ,
			style = SIConstants_ToolMap.raw.Styles.RequestMap_ListChooser
		}
	end ,
	FreshPage_InsertAmmo = function( settings , tabSettings , elements )
		-- 更新说明
		elements.InsertAmmo_Enable.caption = { "SIToolMap.紫图-窗口-插入弹药-启用" , { SITable.Size( tabSettings.InsertAmmo.List ) > 0 and "SIToolMap.紫图-窗口-启用-已设置" or "SIToolMap.紫图-窗口-启用-未设置" } }
		-- 清空列表
		local list = elements.InsertAmmo_List
		list.clear()
		-- 选择筛选器
		local entityFilter = SISettings.PerUser.SICore.ShowHiddenEntity( settings.playerIndex ) and SIRequestMap.InsertAmmo_Entity_Filters_ShowHidden or SIRequestMap.InsertAmmo_Entity_Filters
		-- 重建列表
		for entityName , itemDataList in pairs( tabSettings.InsertAmmo.List ) do
			local entityPrototype = prototypes.entity[entityName]
			if entityPrototype then
				list.add
				{
					type = "choose-elem-button" ,
					name = SIRequestMap.Names.InsertAmmo_Entity_Prefix .. entityName ,
					tooltip = { "SIToolMap.紫图-窗口-插入弹药-实体-提示" , entityPrototype.localised_name } ,
					elem_type = "entity" ,
					entity = entityName ,
					elem_filters = entityFilter ,
					style = SIConstants_ToolMap.raw.Styles.RequestMap_ListChooser
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
				local subList = list.add{ type = "table" , column_count = 8 , style = SIConstants_ToolMap.raw.Styles.RequestMap_SelectList }
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
						weaponTooltip = { "SIToolMap.紫图-窗口-插入弹药-武器-提示" , entityPrototype.localised_name }
						weapon = prototypes.item[entityName] and entityName or SIConstants_Core.raw.Items.IconEmpty
					else
						local weaponPrototype = entityPrototype.indexed_guns[itemDataIndex]
						ammoCategories = weaponPrototype.attack_parameters.ammo_categories or {}
						if weaponPrototype.attack_parameters.ammo_type and weaponPrototype.attack_parameters.ammo_type.category then
							table.insert( ammoCategories , weaponPrototype.attack_parameters.ammo_type.category )
						end
						if not weaponPrototype.name then
							weaponTooltip = { "SIToolMap.紫图-窗口-插入弹药-武器-提示" , entityPrototype.localised_name }
							weapon = SIConstants_Core.raw.Items.IconEmpty
						else
							weaponTooltip = { "SIToolMap.紫图-窗口-插入弹药-武器-提示" , weaponPrototype.localised_name }
							weapon = weaponPrototype.name
						end
					end
					local weaponChooser = subList.add
					{
						type = "choose-elem-button" ,
						tooltip = weaponTooltip ,
						elem_type = "item" ,
						item = weapon ,
						style = SIConstants_ToolMap.raw.Styles.RequestMap_ListChooser
					}
					weaponChooser.enabled = false
					local itemTooltip = nil
					local itemName = itemData.ItemName
					if itemName then
						local itemPrototype = prototypes.item[itemName]
						if itemPrototype then
							itemTooltip = { "SIToolMap.紫图-窗口-插入弹药-物品-提示" , itemPrototype.localised_name }
						else
							itemTooltip = { "SIToolMap.紫图-窗口-插入弹药-物品-空-提示" , itemName }
							itemName = SIConstants_Core.raw.Items.IconEmpty
						end
					else
						itemTooltip = { "SIToolMap.紫图-窗口-插入弹药-物品-选择-提示" }
					end
					local filter = SIUtils.table.deepcopy( SIRequestMap.InsertAmmo_ItemNamed_Filters )
					for ammoName , ammoPrototype in pairs( prototypes.get_item_filtered( SIRequestMap.InsertAmmo_Item_Filters ) ) do
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
						name = SIRequestMap.Names.InsertAmmo_Item_Prefix .. itemDataIndex .. "_" .. entityName ,
						tooltip = itemTooltip ,
						elem_type = "item" ,
						item = itemName ,
						elem_filters = filter ,
						style = SIConstants_ToolMap.raw.Styles.RequestMap_ListChooser
					}
					subList.add{ type = "flow" , direction = "horizontal" , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListEmptyFlow }
					subList.add{ type = "label" , caption = { "SIToolMap.紫图-窗口-插入弹药-数量" } , tooltip = { "SIToolMap.紫图-窗口-插入弹药-数量-提示" } , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListLabel }
					subList.add{ type = "textfield" , name = SIRequestMap.Names.InsertAmmo_Count_Prefix .. itemDataIndex .. "_" .. entityName , text = tostring( itemData.Count or 1 ) , numeric = true , tooltip = { "SIToolMap.紫图-窗口-插入弹药-数量-提示" } , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListText }
					subList.add{ type = "flow" , direction = "horizontal" , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListEmptyFlow }
					subList.add{ type = "label" , caption = { "SIToolMap.紫图-窗口-插入弹药-模式" } , tooltip = { "SIToolMap.紫图-窗口-插入弹药-模式-提示" } , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListLabel }
					subList.add
					{
						type = "drop-down" ,
						name = SIRequestMap.Names.InsertAmmo_Mode_Prefix .. itemDataIndex .. "_" .. entityName ,
						caption = { "SIToolMap.紫图-窗口-插入弹药-模式" } ,
						tooltip = { "SIToolMap.紫图-窗口-插入弹药-模式-提示" } ,
						items = SIRequestMap.CountModeText ,
						selected_index = itemData.Mode or SIRequestMap.CountMode.Total ,
						style = SIConstants_ToolMap.raw.Styles.RequestMap_ListDropDown
					}
				end
			else
				list.add
				{
					type = "choose-elem-button" ,
					name = SIRequestMap.Names.InsertAmmo_Entity_Prefix .. entityName ,
					tooltip = { "SIToolMap.紫图-窗口-插入弹药-实体-空-提示" , entityName } ,
					elem_type = "entity" ,
					entity = SIConstants_Core.raw.Entities.IconEmpty ,
					elem_filters = entityFilter ,
					style = SIConstants_ToolMap.raw.Styles.RequestMap_ListChooser
				}
				local subList = list.add{ type = "table" , column_count = 8 , style = SIConstants_ToolMap.raw.Styles.RequestMap_SelectList }
				for itemDataIndex , itemData in pairs( itemDataList ) do
					local weaponChooser = subList.add
					{
						type = "choose-elem-button" ,
						tooltip = { "SIToolMap.紫图-窗口-插入弹药-武器-空-提示" , entityName } ,
						elem_type = "item" ,
						item = SIConstants_Core.raw.Items.IconEmpty ,
						style = SIConstants_ToolMap.raw.Styles.RequestMap_ListChooser
					}
					weaponChooser.enabled = false
					local itemTooltip = nil
					local itemName = itemData.ItemName
					if itemName then
						local itemPrototype = prototypes.item[itemName]
						if itemPrototype then
							itemTooltip = { "SIToolMap.紫图-窗口-插入弹药-物品-提示" , itemPrototype.localised_name }
						else
							itemTooltip = { "SIToolMap.紫图-窗口-插入弹药-物品-空-提示" , itemName }
							itemName = SIConstants_Core.raw.Items.IconEmpty
						end
					else
						itemTooltip = { "SIToolMap.紫图-窗口-插入弹药-物品-选择-提示" }
					end
					subList.add
					{
						type = "choose-elem-button" ,
						name = SIRequestMap.Names.InsertAmmo_Item_Prefix .. itemDataIndex .. "_" .. entityName ,
						tooltip = itemTooltip ,
						elem_type = "item" ,
						item = itemName ,
						elem_filters = SIRequestMap.InsertAmmo_Item_Filters ,
						style = SIConstants_ToolMap.raw.Styles.RequestMap_ListChooser
					}
					subList.add{ type = "flow" , direction = "horizontal" , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListEmptyFlow }
					subList.add{ type = "label" , caption = { "SIToolMap.紫图-窗口-插入弹药-数量" } , tooltip = { "SIToolMap.紫图-窗口-插入弹药-数量-提示" } , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListLabel }
					subList.add{ type = "textfield" , name = SIRequestMap.Names.InsertAmmo_Count_Prefix .. itemDataIndex .. "_" .. entityName , text = tostring( itemData.Count or 1 ) , numeric = true , tooltip = { "SIToolMap.紫图-窗口-插入弹药-数量-提示" } , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListText }
					subList.add{ type = "flow" , direction = "horizontal" , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListEmptyFlow }
					subList.add{ type = "label" , caption = { "SIToolMap.紫图-窗口-插入弹药-模式" } , tooltip = { "SIToolMap.紫图-窗口-插入弹药-模式-提示" } , style = SIConstants_ToolMap.raw.Styles.RequestMap_ListLabel }
					subList.add
					{
						type = "drop-down" ,
						name = SIRequestMap.Names.InsertAmmo_Mode_Prefix .. itemDataIndex .. "_" .. entityName ,
						caption = { "SIToolMap.紫图-窗口-插入弹药-模式" } ,
						tooltip = { "SIToolMap.紫图-窗口-插入弹药-模式-提示" } ,
						items = SIRequestMap.CountModeText ,
						selected_index = itemData.Mode or SIRequestMap.CountMode.Total ,
						style = SIConstants_ToolMap.raw.Styles.RequestMap_ListDropDown
					}
				end
			end
		end
		list.add
		{
			type = "choose-elem-button" ,
			name = SIRequestMap.Names.InsertAmmo_Entity_Prefix ,
			tooltip = { "SIToolMap.紫图-窗口-插入弹药-实体-选择-提示" } ,
			elem_type = "entity" ,
			entity = nil ,
			elem_filters = entityFilter ,
			style = SIConstants_ToolMap.raw.Styles.RequestMap_ListChooser
		}
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 功能函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
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
	-- ======================================================================<br>
	-- 这是一个内部函数 , 请勿外部调用<br>
	-- ======================================================================<br>
	FireModuleEvent = function( playerIndex , entity )
		local data =
		{
			name = SIRequestMap.ModuleEventID ,
			tick = game.tick ,
			player_index = playerIndex ,
			entity = entity
		}
		script.raise_event( SIRequestMap.ModuleEventID , data )
	end ,
	EffectTabSettings = function( settings , tabSettingsIndex )
		local playerIndex = settings.playerIndex
		local player = game.get_player( playerIndex )
		local playerForce = player.force
		local playerInventory = player.get_main_inventory()
		local tabSettings = settings.TabSettingsList[tabSettingsIndex]
		local greenToBlue = tabSettings.GreenToBlue.Check
		local fromInventory = tabSettings.SetModule.FromInventory
		local toInventory = tabSettings.RemoveModule.ToInventory
		local invert = tabSettings.RemoveModule.Invert
		local proxyList = {}
		local fuelTotalList = {}
		local ammoTotalList = {}
		for index , entity in pairs( settings.entities ) do
			local force = entity.force
			if force.index == playerForce.index then
				local surface = entity.surface
				local entityName = entity.name
				local entityPrototype = entity.prototype
				local type = entityPrototype.type
				local moduleFlag = false
				-- ======================================================================
				-- 请求格子
				-- ======================================================================
				if tabSettings.RequestSlot.Enable then
					local requestItemList = tabSettings.RequestSlot.List[entityName]
					if requestItemList then
						if type == SICommon.Types.Entities.ContainerLogic then
							local logisticMode = entityPrototype.logistic_mode
							if logisticMode == SICommon.Flags.LogisticMode.Requester or logisticMode == SICommon.Flags.LogisticMode.Buffer then
								for slotIndex = 1 , entity.request_slot_count , 1 do
									entity.clear_request_slot( slotIndex )
								end
								for slotIndex , itemName in pairs( requestItemList ) do
									local itemPrototype = prototypes.item[itemName]
									if not itemName or itemPrototype then
										entity.set_request_slot( { name = itemName , count = itemPrototype.stack_size } , slotIndex )
									end
								end
							elseif logisticMode == SICommon.Flags.LogisticMode.Storage then
								local itemName = requestItemList[1]
								if not itemName or prototypes.item[itemName] then
									entity.set_filter( 1 , itemName )
								end
							end
						elseif type == SICommon.Types.Entities.Inserter or type == SICommon.Types.Entities.BeltLoader or type == SICommon.Types.Entities.BeltLoaderSmall then
							for slotIndex = 1 , entity.filter_slot_count , 1 do
								entity.set_filter( slotIndex , nil )
							end
							for slotIndex , itemName in pairs( requestItemList ) do
								if not itemName or prototypes.item[itemName] then
									entity.set_filter( slotIndex , itemName )
								end
							end
						elseif type == SICommon.Types.Entities.Car then
							local inventory = entity.get_inventory( defines.inventory.car_trunk )
							if inventory and inventory.supports_filters() then
								for slotIndex = 1 , #inventory , 1 do
									local itemName = requestItemList[slotIndex]
									if itemName and prototypes.item[itemName] then
										if inventory.can_set_filter( slotIndex , itemName ) then
											inventory.set_filter( slotIndex , itemName )
										end
									else
										inventory.set_filter( slotIndex , nil )
									end
								end
							end
						elseif type == SICommon.Types.Entities.SpiderVehicle then
							local inventory = entity.get_inventory( defines.inventory.spider_trunk )
							if inventory and inventory.supports_filters() then
								for slotIndex = 1 , #inventory , 1 do
									local itemName = requestItemList[slotIndex]
									if itemName and prototypes.item[itemName] then
										if inventory.can_set_filter( slotIndex , itemName ) then
											inventory.set_filter( slotIndex , itemName )
										end
									else
										inventory.set_filter( slotIndex , nil )
									end
								end
							end
						elseif type == SICommon.Types.Entities.WagonCargo then
							local inventory = entity.get_inventory( defines.inventory.cargo_wagon )
							if inventory and inventory.supports_filters() then
								for slotIndex = 1 , #inventory , 1 do
									local itemName = requestItemList[slotIndex]
									if itemName and prototypes.item[itemName] then
										if inventory.can_set_filter( slotIndex , itemName ) then
											inventory.set_filter( slotIndex , itemName )
										end
									else
										inventory.set_filter( slotIndex , nil )
									end
								end
							end
						end
					end
				end
				-- ======================================================================
				-- 最大格子
				-- ======================================================================
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
				-- ======================================================================
				-- 绿箱向蓝箱供货
				-- ======================================================================
				if tabSettings.GreenToBlue.Enable then
					if type == SICommon.Types.Entities.ContainerLogic then
						local logisticMode = entityPrototype.logistic_mode
						if logisticMode == SICommon.Flags.LogisticMode.Requester then
							entity.request_from_buffers = greenToBlue
						end
					end
				end
				-- ======================================================================
				-- 设置插件
				-- ======================================================================
				if tabSettings.SetModule.Enable then
					local setModuleList = tabSettings.SetModule.List[entityName]
					if setModuleList then
						local inventory = entity.get_module_inventory()
						if inventory then
							for slotIndex = 1 , #inventory , 1 do
								local itemName = setModuleList[slotIndex]
								if itemName and prototypes.item[itemName] then
									local currentItemStack = inventory[slotIndex]
									if not currentItemStack.valid_for_read or currentItemStack.name ~= itemName then
										if currentItemStack.valid_for_read and currentItemStack.name ~= itemName then
											local dropItemFlag = true
											if fromInventory then
												local itemStack = { name = currentItemStack.name , count = 1 }
												if playerInventory.can_insert( itemStack ) then
													playerInventory.insert( itemStack )
													dropItemFlag = false
												end
											end
											if dropItemFlag then
												surface.spill_item_stack( entity.position , { name = currentItemStack.name , count = 1 } , true , force , false )
											end
											currentItemStack.clear()
											moduleFlag = true
										end
										local itemStack = { name = itemName , count = 1 }
										if inventory.can_insert( itemStack ) then
											local needProxyFlag = true
											if fromInventory then
												local hasCount = playerInventory.get_item_count( itemName )
												if hasCount > 0 then
													currentItemStack.set_stack( itemStack )
													playerInventory.remove{ name = itemName , count = 1 }
													needProxyFlag = false
												end
											end
											if needProxyFlag then
												local proxy = proxyList[entity.unit_number]
												if proxy then
													local requestList = proxy.item_requests
													if requestList[itemName] then
														requestList[itemName] = requestList[itemName] + 1
													else
														requestList[itemName] = 1
													end
													proxy.item_requests = requestList
												else
													proxy = surface.create_entity
													{
														name = "item-request-proxy" ,
														position = entity.position ,
														direction = defines.direction.north ,
														force = force ,
														fast_replace = false ,
														player = player ,
														raise_built = false ,
														create_build_effect_smoke = false ,
														spawn_decorations = false ,
														move_stuck_players = true ,
														target = entity ,
														modules = { [itemName] = 1 }
													}
													proxyList[entity.unit_number] = proxy
												end
											end
											moduleFlag = true
										end
									end
								else
									local currentItemStack = inventory[slotIndex]
									if currentItemStack.valid_for_read then
										local dropItemFlag = true
										if fromInventory then
											local itemStack = { name = currentItemStack.name , count = 1 }
											if playerInventory.can_insert( itemStack ) then
												playerInventory.insert( itemStack )
												dropItemFlag = false
											end
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
				-- ======================================================================
				-- 移除插件
				-- ======================================================================
				if tabSettings.RemoveModule.Enable then
					local removeModuleList = tabSettings.RemoveModule.List[entityName]
					if removeModuleList then
						local inventory = entity.get_module_inventory()
						if inventory then
							for slotIndex = 1 , #inventory , 1 do
								local itemName = removeModuleList[slotIndex]
								if itemName and prototypes.item[itemName] then
									local currentItemStack = inventory[slotIndex]
									if invert then
										if currentItemStack.valid_for_read and currentItemStack.name ~= itemName then
											local dropItemFlag = true
											if toInventory then
												local itemStack = { name = currentItemStack.name , count = 1 }
												if playerInventory.can_insert( itemStack ) then
													playerInventory.insert( itemStack )
													dropItemFlag = false
												end
											end
											if dropItemFlag then
												surface.spill_item_stack( entity.position , { name = currentItemStack.name , count = 1 } , true , force , false )
											end
											currentItemStack.clear()
											moduleFlag = true
										end
									else
										if currentItemStack.valid_for_read and currentItemStack.name == itemName then
											local dropItemFlag = true
											if toInventory then
												local itemStack = { name = currentItemStack.name , count = 1 }
												if playerInventory.can_insert( itemStack ) then
													playerInventory.insert( itemStack )
													dropItemFlag = true
												end
											end
											if dropItemFlag then
												surface.spill_item_stack( entity.position , { name = currentItemStack.name , count = 1 } , true , force , false )
											end
											currentItemStack.clear()
											moduleFlag = true
										end
									end
								else
									local currentItemStack = inventory[slotIndex]
									if invert then
										if currentItemStack.valid_for_read then
											local dropItemFlag = true
											if toInventory then
												local itemStack = { name = currentItemStack.name , count = 1 }
												if playerInventory.can_insert( itemStack ) then
													playerInventory.insert( itemStack )
													dropItemFlag = false
												end
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
				end
				-- 触发插件事件
				if moduleFlag then
					SIRequestMap.FireModuleEvent( playerIndex , entity )
				end
				-- ======================================================================
				-- 插入燃料
				-- ======================================================================
				if tabSettings.InsertFuel.Enable then
					local insertFuelList = tabSettings.InsertFuel.List[entityName]
					if insertFuelList then
						local inventory = entity.get_fuel_inventory()
						-- 判断存储空间
						if inventory then
							for slotIndex , itemData in pairs( insertFuelList ) do
								local itemName = itemData.ItemName
								local itemPrototype = prototypes.item[itemName]
								-- 判断燃料物品是否存在
								if itemName and itemPrototype then
									local hasCount = playerInventory.get_item_count( itemName )
									-- 判断玩家背包内的燃料物品数量
									if hasCount > 0 then
										local currentItemStack = inventory[slotIndex]
										-- 判断指定空间内是否可以填充指定种类的燃料物品
										if not currentItemStack.valid_for_read or currentItemStack.name == itemName then
											local currentCount = currentItemStack.valid_for_read and currentItemStack.count or 0
											local mode = itemData.Mode or SIRequestMap.CountMode.Total
											-- 根据模式决定操作方式
											if mode == SIRequestMap.CountMode.Total then
												local fuelEntityList = fuelTotalList[entityName]
												if not fuelEntityList then
													fuelEntityList = {}
													fuelTotalList[entityName] = fuelEntityList
												end
												local fuelList = fuelEntityList[slotIndex]
												if not fuelList then
													fuelList =
													{
														ItemData = itemData ,
														List = {}
													}
													fuelEntityList[slotIndex] = fuelList
												end
												table.insert( fuelList.List ,
												{
													ItemStack = currentItemStack ,
													CurretnCount = currentCount ,
													Max = itemPrototype.stack_size }
												)
											elseif mode == SIRequestMap.CountMode.Single then
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
				-- ======================================================================
				-- 插入弹药
				-- ======================================================================
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
								local itemPrototype = prototypes.item[itemName]
								-- 判断弹药物品是否存在
								if itemName and itemPrototype then
									local hasCount = playerInventory.get_item_count( itemName )
									-- 判断玩家背包内的弹药物品数量
									if hasCount > 0 then
										local currentItemStack = inventory[slotIndex]
										-- 判断指定空间内是否可以填充指定种类的弹药物品
										if not currentItemStack.valid_for_read or currentItemStack.valid_for_read and currentItemStack.name == itemName then
											local currentCount = currentItemStack.valid_for_read and currentItemStack.count or 0
											local mode = itemData.Mode or SIRequestMap.CountMode.Total
											-- 根据模式决定操作方式
											if mode == SIRequestMap.CountMode.Total then
												local ammoEntityList = ammoTotalList[entityName]
												if not ammoEntityList then
													ammoEntityList = {}
													ammoTotalList[entityName] = ammoEntityList
												end
												local ammoList = ammoEntityList[slotIndex]
												if not ammoList then
													ammoList =
													{
														ItemData = itemData ,
														List = {}
													}
													ammoEntityList[slotIndex] = ammoList
												end
												table.insert( ammoList.List ,
												{
													ItemStack = currentItemStack ,
													CurretnCount = currentCount ,
													Max = itemPrototype.stack_size }
												)
											elseif mode == SIRequestMap.CountMode.Single then
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
			end
		end
		-- ======================================================================
		-- 插入燃料 , 整体计数
		-- ======================================================================
		if tabSettings.InsertFuel.Enable then
			for entityName , fuelEntityList in pairs( fuelTotalList ) do
				for slotIndex , fuelList in pairs( fuelEntityList ) do
					local itemData = fuelList.ItemData
					local itemName = itemData.ItemName
					local hasCount = playerInventory.get_item_count( itemName )
					if hasCount > 0 then
						local singleCount = math.max( math.floor( math.min( itemData.Count or 1 , hasCount ) / #fuelList.List ) , 1 )
						for index , fuelData in pairs( fuelList.List ) do
							local count = math.min( math.max( singleCount - fuelData.CurretnCount , 0 ) , fuelData.Max )
							count = math.min( count , playerInventory.get_item_count( itemName ) )
							if count > 0 then
								-- 填充燃料物品
								local currentItemStack = fuelData.ItemStack
								if currentItemStack.valid_for_read then
									currentItemStack.count = currentItemStack.count + count
								else
									currentItemStack.set_stack{ name = itemName , count = count }
								end
								playerInventory.remove{ name = itemName , count = count }
							else
								break
							end
						end
					end
				end
			end
		end
		-- ======================================================================
		-- 插入弹药 , 整体计数
		-- ======================================================================
		if tabSettings.InsertAmmo.Enable then
			for entityName , ammoEntityList in pairs( ammoTotalList ) do
				for slotIndex , ammoList in pairs( ammoEntityList ) do
					local itemData = ammoList.ItemData
					local itemName = itemData.ItemName
					local hasCount = playerInventory.get_item_count( itemName )
					if hasCount > 0 then
						local singleCount = math.max( math.floor( math.min( itemData.Count or 1 , hasCount ) / #ammoList.List ) , 1 )
						for index , ammoData in pairs( ammoList.List ) do
							local count = math.min( math.max( singleCount - ammoData.CurretnCount , 0 ) , ammoData.Max )
							count = math.min( count , playerInventory.get_item_count( itemName ) )
							if count > 0 then
								-- 填充弹药物品
								local currentItemStack = ammoData.ItemStack
								if currentItemStack.valid_for_read then
									currentItemStack.count = currentItemStack.count + count
								else
									currentItemStack.set_stack{ name = itemName , count = count }
								end
								playerInventory.remove{ name = itemName , count = count }
							else
								break
							end
						end
					end
				end
			end
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 事件函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
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
			settings.Elements[tabSettingsIndex].Scroll.scroll_to_element( settings.Elements[tabSettingsIndex][key] , "top-third" )
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
			settings.TabList[tabSettingsIndex].caption = { "SIToolMap.紫图-窗口-分页标题" , element.text }
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
					SIPrint.Warning( playerIndex , { "SIToolMap.紫图-提示-请求格子-已存在" , selectEntityName , prototypes.entity[selectEntityName].localised_name } )
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
			local selectItemName = element.elem_value
			element.tooltip = selectItemName and { "SIToolMap.紫图-窗口-请求格子-物品-提示" , prototypes.item[selectItemName].localised_name } or { "SIToolMap.紫图-窗口-请求格子-物品-选择-提示" }
			-- 保存 [请求格子-物品] 选择的物品
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
				local entityPrototype = prototypes.entity[entityName]
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
					SIPrint.Warning( playerIndex , { "SIToolMap.紫图-提示-最大格子-已存在" , selectEntityName , prototypes.entity[selectEntityName].localised_name } )
					element.elem_value = nil
					return
				end
				countList[selectEntityName] = 0
			end
			SIRequestMap.FreshPage_MaxSlot( settings , tabSettings , settings.Elements[tabSettingsIndex] )
		end
	end ,
	Set_MaxSlot_Count = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [最大格子-数量] 填写的数量
			local tabSettingsIndex = settings.tabSettingsIndex
			local tabSettings = settings.TabSettingsList[tabSettingsIndex]
			local countList = tabSettings.MaxSlot.List
			local entityName = name:sub( SIRequestMap.Names.MaxSlot_Count_Position )
			countList[entityName] = SIElements.GetInputNumber( element )
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
					SIPrint.Warning( playerIndex , { "SIToolMap.紫图-提示-设置插件-已存在" , selectEntityName , prototypes.entity[selectEntityName].localised_name } )
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
			local selectItemName = element.elem_value
			element.tooltip = selectItemName and { "SIToolMap.紫图-窗口-设置插件-物品-提示" , prototypes.item[selectItemName].localised_name } or { "SIToolMap.紫图-窗口-设置插件-物品-选择-提示" }
			-- 保存 [设置插件-物品] 选择的物品
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
						for innerEntityName , moduleData in pairs( moduleList ) do
							if entityName == innerEntityName then
								newModuleList[selectEntityName] = {}
							else
								newModuleList[innerEntityName] = moduleData
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
					SIPrint.Warning( playerIndex , { "SIToolMap.紫图-提示-移除插件-已存在" , selectEntityName , prototypes.entity[selectEntityName].localised_name } )
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
			local selectItemName = element.elem_value
			element.tooltip = selectItemName and { "SIToolMap.紫图-窗口-移除插件-物品-提示" , prototypes.item[selectItemName].localised_name } or { "SIToolMap.紫图-窗口-移除插件-物品-选择-提示" }
			-- 保存 [移除插件-物品] 选择的物品
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
					SIPrint.Warning( playerIndex , { "SIToolMap.紫图-提示-插入燃料-已存在" , selectEntityName , prototypes.entity[selectEntityName].localised_name } )
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
			local selectItemName = element.elem_value
			element.tooltip = selectItemName and { "SIToolMap.紫图-窗口-插入燃料-物品-提示" , prototypes.item[selectItemName].localised_name } or { "SIToolMap.紫图-窗口-插入燃料-物品-选择-提示" }
			-- 保存 [插入燃料-物品] 选择的物品
			local key = name:sub( SIRequestMap.Names.InsertFuel_Item_Position )
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
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [插入燃料-数量] 填写的数量
			local key = name:sub( SIRequestMap.Names.InsertFuel_Count_Position )
			local location = key:find( "_" )
			local itemDataIndex = tonumber( key:sub( 1 , location - 1 ) )
			if itemDataIndex and itemDataIndex > 0 then
				local entityName = key:sub( location + 1 )
				local tabSettingsIndex = settings.tabSettingsIndex
				local tabSettings = settings.TabSettingsList[tabSettingsIndex]
				local itemDataList = tabSettings.InsertFuel.List
				itemDataList[entityName][itemDataIndex].Count = SIElements.GetInputNumber( element )
			end
		end
	end ,
	Set_InsertFuel_Mode = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			local selectedIndex = element.selected_index or 1
			element.selected_index = selectedIndex
			-- 保存 [插入燃料-模式] 选择的模式
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
					SIPrint.Warning( playerIndex , { "SIToolMap.紫图-提示-插入弹药-已存在" , selectEntityName , prototypes.entity[selectEntityName].localised_name } )
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
			local selectItemName = element.elem_value
			element.tooltip = selectItemName and { "SIToolMap.紫图-窗口-插入弹药-物品-提示" , prototypes.item[selectItemName].localised_name } or { "SIToolMap.紫图-窗口-插入弹药-物品-选择-提示" }
			-- 保存 [插入弹药-物品] 选择的物品
			local key = name:sub( SIRequestMap.Names.InsertAmmo_Item_Position )
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
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [插入弹药-数量] 填写的数量
			local key = name:sub( SIRequestMap.Names.InsertAmmo_Count_Position )
			local location = key:find( "_" )
			local itemDataIndex = tonumber( key:sub( 1 , location - 1 ) )
			if itemDataIndex and itemDataIndex > 0 then
				local entityName = key:sub( location + 1 )
				local tabSettingsIndex = settings.tabSettingsIndex
				local tabSettings = settings.TabSettingsList[tabSettingsIndex]
				local itemDataList = tabSettings.InsertAmmo.List
				itemDataList[entityName][itemDataIndex].Count = SIElements.GetInputNumber( element )
			end
		end
	end ,
	Set_InsertAmmo_Mode = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			local selectedIndex = element.selected_index or 1
			element.selected_index = selectedIndex
			-- 保存 [插入弹药-模式] 选择的模式
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
	EffectSelect1 = function( playerIndex , entities )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		settings.entities = entities
		if settings.frame and settings.frame.valid then
			SIRequestMap.EffectTabSettings( settings , settings.tabSettingsIndex )
		else
			local defaultIndex = settings.defaultIndex1
			if defaultIndex < 1 or defaultIndex > #settings.TabSettingsList then
				SIRequestMap.OpenFrame( playerIndex )
			else
				SIRequestMap.EffectTabSettings( settings , defaultIndex )
			end
		end
	end ,
	EffectSelect2 = function( playerIndex , entities )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		settings.entities = entities
		if settings.frame and settings.frame.valid then
			SIRequestMap.EffectTabSettings( settings , settings.tabSettingsIndex )
		else
			local defaultIndex = settings.defaultIndex2
			if defaultIndex < 1 or defaultIndex > #settings.TabSettingsList then
				SIRequestMap.OpenFrame( playerIndex )
			else
				SIRequestMap.EffectTabSettings( settings , defaultIndex )
			end
		end
	end ,
	EffectSelect3 = function( playerIndex , entities )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		settings.entities = entities
		if settings.frame and settings.frame.valid then
			SIRequestMap.EffectTabSettings( settings , settings.tabSettingsIndex )
		else
			local defaultIndex = settings.defaultIndex3
			if defaultIndex < 1 or defaultIndex > #settings.TabSettingsList then
				SIRequestMap.OpenFrame( playerIndex )
			else
				SIRequestMap.EffectTabSettings( settings , defaultIndex )
			end
		end
	end ,
	EffectSelect4 = function( playerIndex , entities )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		settings.entities = entities
		if settings.frame and settings.frame.valid then
			SIRequestMap.EffectTabSettings( settings , settings.tabSettingsIndex )
		else
			local defaultIndex = settings.defaultIndex4
			if defaultIndex < 1 or defaultIndex > #settings.TabSettingsList then
				SIRequestMap.OpenFrame( playerIndex )
			else
				SIRequestMap.EffectTabSettings( settings , defaultIndex )
			end
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 接口函数 - 窗口 =================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================<br>
	-- 打开指定玩家的紫图的管理窗口<br>
	-- ======================================================================<br>
	---@param playerIndex integer -- 玩家索引
	OpenFrameByPlayerIndex = function( playerIndex )
		SIRequestMap.OpenFrame( playerIndex )
	end ,

	-- ======================================================================<br>
	-- 关闭指定玩家的紫图的管理窗口<br>
	-- ======================================================================<br>
	---@param playerIndex integer -- 玩家索引
	CloseFrameByPlayerIndex = function( playerIndex )
		SIRequestMap.CloseFrame( playerIndex )
	end ,

	-- ======================================================================<br>
	-- 打开所有玩家的紫图的管理窗口<br>
	-- ======================================================================<br>
	OpenFrames = function()
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIRequestMap.Settings.Name ) ) do
			SIRequestMap.OpenFrame( playerIndex )
		end
	end ,

	-- ======================================================================<br>
	-- 关闭所有玩家的紫图的管理窗口<br>
	-- ======================================================================<br>
	CloseFrames = function()
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIRequestMap.Settings.Name ) ) do
			SIRequestMap.CloseFrame( playerIndex )
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 接口函数 - 导入导出 =============================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================<br>
	-- 导入数据<br>
	-- ======================================================================<br>
	---@param playerIndex integer -- 点击按钮的玩家索引
	---@param data table -- 导出时保存的数据 , 根据导出时导出接口函数返回的数据 , 此参数可能为 nil
	---@param settingsDataID string -- 导入导出设置数据包的 ID
	---@param gameTick integer -- 导出数据时的游戏时间 , tick
	ImpoerSettingsData = function( playerIndex , data , settingsDataID , gameTick )
		if not data then
			return
		end
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		settings.defaultIndex1 = data.defaultIndex1 or 0
		settings.defaultIndex2 = data.defaultIndex2 or 0
		settings.defaultIndex3 = data.defaultIndex3 or 0
		settings.defaultIndex4 = data.defaultIndex4 or 0
		settings.TabSettingsList = data.TabSettingsList or {}
		-- 整理数据
		local tabSettingsCount = #settings.TabSettingsList
		if tabSettingsCount < 1 then
			SIRequestMap.CreateTabSettings( settings )
			tabSettingsCount = #settings.TabSettingsList
		end
		settings.tabSettingsIndex = SITools.AsNumberInt( settings.tabSettingsIndex , 1 , tabSettingsCount )
		-- 更新控件
		if settings.frame and settings.frame.valid then
			SIRequestMap.CreateTab( settings )
		end
	end ,

	-- ======================================================================<br>
	-- 导出数据<br>
	-- ======================================================================<br>
	---@param playerIndex integer -- 点击按钮的玩家索引
	---@param settingsDataID string -- 导入导出设置数据包的 ID
	---@param gameTick integer -- 当前的游戏时间 , tick
	---@return table -- 导出的数据
	ExportSettingsData = function( playerIndex , settingsDataID , gameTick )
		local settings = SIGlobal.GetPlayerSettings( SIRequestMap.Settings.Name , playerIndex )
		return
		{
			defaultIndex1 = settings.defaultIndex1 ,
			defaultIndex2 = settings.defaultIndex2 ,
			defaultIndex3 = settings.defaultIndex3 ,
			defaultIndex4 = settings.defaultIndex4 ,
			TabSettingsList = settings.TabSettingsList
		}
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 接口函数 - 事件 =================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================<br>
	-- 当一个玩家通过紫图修改了实体的插件时 , 会触发此事件<br>
	-- 事件会包含 4 个参数 :<br>
	-- name          = 事件的 ID 值<br>
	-- tick          = 当前游戏刻<br>
	-- player_index  = 操作玩家的索引<br>
	-- entity        = 被修改了插件的实体<br>
	-- ======================================================================<br>
	---@return string -- 事件的 ID 值
	GetModuleEventID = function()
		return SIRequestMap.ModuleEventID
	end
}

SIRequestMap.CountModeText =
{
	[SIRequestMap.CountMode.Total] = { "SIToolMap.紫图-窗口-计数-整体计数" } ,
	[SIRequestMap.CountMode.Single] = { "SIToolMap.紫图-窗口-计数-独立计数" }
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
	ID = "SI工具图-紫图" ,
	Name = "紫图" ,
	IconItemName = SIConstants_ToolMap.raw.Items.RequestMap ,
	LocalizedName = { "SIToolMap.紫图-工具栏-按钮" } ,
	LocalizedDescription = { "SIToolMap.紫图-工具栏-提示" , { "item-name.infinity-chest" } , { "SIToolMapName.物品-紫图" } } ,
	ActionRemoteInterfaceID = SIRequestMap.InterfaceID ,
	ActionRemoteFunctionName = "OpenFrameByPlayerIndex" ,
	Permission = SIPermission.PermissionIDs.RequestMap ,
	Order = "SICore-MapRequest"
}

SIRequestMap.SettingsData =
{
	ID = "SI工具图-紫图" ,
	Tooltip = { "SIToolMap.紫图-导出设置-提示" } ,
	ImportRemoteInterfaceID = SIRequestMap.InterfaceID ,
	ImportRemoteFunctionName = "ImpoerSettingsData" ,
	ExportRemoteInterfaceID = SIRequestMap.InterfaceID ,
	ExportRemoteFunctionName = "ExportSettingsData"
}
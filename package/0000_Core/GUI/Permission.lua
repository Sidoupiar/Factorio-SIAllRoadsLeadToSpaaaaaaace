---@class SIPermission : SIBaseClass
SIPermission =
{
	ID = "Permission" ,
	Code = "Permission" ,
	Show = "权限管理" ,
	InterfaceID = "SICore-Permission" ,
	Names =
	{
		Prefix = "SI核心-权限管理-" ,
		Frame = "SI核心-权限管理-窗口" ,
		Close = "SI核心-权限管理-关闭" ,
		GlobalItemFindWhite = "SI核心-权限管理-全局-物品查询白" ,
		GlobalItemFindTextWhite = "SI核心-权限管理-全局-物品查询文本条白" ,
		GlobalItemFindBlack = "SI核心-权限管理-全局-物品查询黑" ,
		GlobalItemFindTextBlack = "SI核心-权限管理-全局-物品查询文本条黑" ,
		GlobalSave = "SI核心-权限管理-全局-保存" ,
		GlobalBack = "SI核心-权限管理-全局-撤销" ,
		GlobalReset = "SI核心-权限管理-全局-默认" ,
		PlayerItemFindWhite = "SI核心-权限管理-玩家-物品查询白" ,
		PlayerItemFindTextWhite = "SI核心-权限管理-玩家-物品查询文本条白" ,
		PlayerItemFindBlack = "SI核心-权限管理-玩家-物品查询黑" ,
		PlayerItemFindTextBlack = "SI核心-权限管理-玩家-物品查询文本条黑" ,
		PlayerSave = "SI核心-权限管理-玩家-保存" ,
		PlayerBack = "SI核心-权限管理-玩家-撤销" ,
		PlayerClear = "SI核心-权限管理-玩家-清空" ,
		CheckSave = "SI核心-权限管理-查询-保存" ,
		CheckBack = "SI核心-权限管理-查询-撤销" ,
		CheckClear = "SI核心-权限管理-查询-清空" ,
		GlobalRadioPrefix = "SI核心-权限管理-全局单选" ,
		GlobalItemWhitePrefix = "SI核心-权限管理-全局物品白" ,
		GlobalItemBlackPrefix = "SI核心-权限管理-全局物品黑" ,
		GlobalItemBluePrefix = "SI核心-权限管理-全局物品蓝" ,
		GlobalItemOrangePrefix = "SI核心-权限管理-全局物品橙" ,
		PlayerItemPrefix = "SI核心-权限管理-玩家编号" ,
		PlayerRadioPrefix = "SI核心-权限管理-玩家单选" ,
		PlayerItemWhitePrefix = "SI核心-权限管理-玩家物品白" ,
		PlayerItemBlackPrefix = "SI核心-权限管理-玩家物品黑" ,
		PlayerItemBluePrefix = "SI核心-权限管理-玩家物品蓝" ,
		PlayerItemOrangePrefix = "SI核心-权限管理-玩家物品橙" ,
		CheckItemPrefix = "SI核心-权限管理-查询权限" ,
		CheckRadioPrefix = "SI核心-权限管理-查询单选"
	} ,
	PermissionIDs =
	{
		-- 管理员
		Master           = "Master" ,
		Operator         = "Operator" ,
		-- 以下仅对此 MOD 添加的功能生效
		GameSpeed        = "GameSpeed" ,
		DeleteMap        = "DeleteMap" ,
		OreMap           = "OreMap" ,
		RequestMap       = "RequestMap" ,
		AutoInsert       = "AutoInsert" ,
		OutWhite         = "OutWhite" ,
		OutBlack         = "OutBlack" ,
		RPGGlobalSetting = "RPGGlobalSetting" ,
		RPGPlayerStatus  = "RPGPlayerStatus" ,
		RPGPlayerSkill   = "RPGPlayerSkill" ,
		RPGExp           = "RPGExp" ,
		RPGSystem        = "RPGSystem"
	} ,
	BasePermissionIDs = {} ,
	PermissionCode =
	{
		TRUE = 1 , -- 持有权限
		FALSE = 2 -- 不持有权限
	} ,
	-- 此项只能一个字符
	PermissionElementCode =
	{
		TRUE = "1" , -- 持有权限
		FALSE = "2" , -- 不持有权限
		DEFAULT = "0" -- 默认 , 使用全局设置 , 全局默认设置不使用此项
	} ,
	-- 事件<br>
	EventID = script.generate_event_name() ,
	BasePermissionGroupName = "SI核心-基础权限组" ,
	PlayerPermissionGroupPrefix = "SI核心-玩家权限组-" ,
	ChangingPermissionGroup = false ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 窗口函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	OpenFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			SIPermission.CloseFrame( playerIndex )
		else
			local player = game.get_player( playerIndex )
			-- 显示窗口
			local frame = SIElements.CreateFrame( player , settings ,
			{
				Name         = SIPermission.Names.Frame ,
				Close        = SIPermission.Names.Close ,
				Style        = SIConstants_Core.raw.Styles.Permission_Frame ,
				Title        = { "SICore.权限管理-窗口-标题" } ,
				TitleTooltip = { "SICore.权限管理-窗口-标题-提示" } ,
				UseTooltip   = { "SICore.权限管理-窗口-使用-提示" } ,
				CloseTooltip = { "SICore.权限管理-窗口-关闭-提示" }
			} )
			-- 第 1 层
			local tabPane = frame.add{ type = "tabbed-pane" , style = SIConstants_Core.raw.Styles.Permission_TabPane }
			settings.tabPane = tabPane
			settings.data.look.tab = tabPane.add{ type = "tab" , caption = { "SICore.权限管理-窗口-查看自己权限" } }
			settings.data.global.tab = tabPane.add{ type = "tab" , caption = { "SICore.权限管理-窗口-修改默认权限" } }
			settings.data.player.tab = tabPane.add{ type = "tab" , caption = { "SICore.权限管理-窗口-修改玩家权限" } }
			settings.data.check.tab = tabPane.add{ type = "tab" , caption = { "SICore.权限管理-窗口-权限查询" } }
			settings.data.look.flow = tabPane.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			settings.data.global.flow = tabPane.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			settings.data.player.flow = tabPane.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			settings.data.check.flow = tabPane.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			tabPane.add_tab( settings.data.look.tab , settings.data.look.flow )
			-- 根据设置更新控件
			settings.data.global.back = SIUtils.table.deepcopy( SIGlobal.GetGlobalSettings( SIPermission.Settings.Name ) )
			settings.data.global.back.PermissionTooltips = nil
			settings.data.global.current = SIUtils.table.deepcopy( settings.data.global.back )
			settings.data.global.current.AddingLists =
			{
				ItemWhiteList = {} , -- 物品白名单 , 临时列表 , 关闭窗口时消失
				ItemBlackList = {}   -- 物品黑名单 , 临时列表 , 关闭窗口时消失
			}
			SIPermission.FreshList( settings )
		end
	end ,
	CloseFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			settings.frame.destroy()
			settings.frame = nil
			settings.tabPane = nil
			settings.lastAdmin = nil
			for key , data in pairs( settings.data ) do
				for type , value in pairs( data ) do
					data[type] = nil
				end
			end
		end
	end ,
	MoveFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			SIElements.SaveFrameLocation( settings )
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 控件函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	FreshList = function( settings )
		local globalSettings = SIGlobal.GetGlobalSettings( SIPermission.Settings.Name )
		local isAdmin = SIPermission.IsAdmin( settings.playerIndex )
		local isMaster = SIPermission.HasPermission( SIPermission.PermissionIDs.Master , settings.playerIndex )
		if settings.lastAdmin ~= isAdmin then
			settings.lastAdmin = isAdmin
			if isAdmin then
				settings.tabPane.add_tab( settings.data.global.tab , settings.data.global.flow )
				settings.tabPane.add_tab( settings.data.player.tab , settings.data.player.flow )
				settings.tabPane.add_tab( settings.data.check.tab , settings.data.check.flow )
			else
				settings.tabPane.remove_tab( settings.data.global.tab )
				settings.tabPane.remove_tab( settings.data.player.tab )
				settings.tabPane.remove_tab( settings.data.check.tab )
			end
		end
		for key , data in pairs( settings.data ) do
			data.flow.clear()
		end
		-- ======================================================================
		-- 查看自己权限
		-- ======================================================================
		local lookView = settings.data.look.flow
		-- 第 1 层 , 说明
		lookView.add{ type = "label" , caption = { isAdmin and "SICore.权限管理-窗口-查看-说明-有权限" or "SICore.权限管理-窗口-查看-说明-无权限" } , style = SIConstants_Core.raw.Styles.Permission_LabelTop }
		-- 第 2 层 , 列表标题
		local lookFlow2 = lookView.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
		lookFlow2.add{ type = "line" , direction = "horizontal" }
		-- 第 2.1 层
		local lookFlow21 = lookFlow2.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_TitleFlow }
		lookFlow21.add{ type = "label" , caption = { "SICore.权限管理-窗口-查看-列表-权限名称" } , style = SIConstants_Core.raw.Styles.Permission_Look_ListTitle }
		lookFlow21.add{ type = "label" , caption = { "SICore.权限管理-窗口-查看-列表-权限属性" } , style = SIConstants_Core.raw.Styles.Permission_Look_ListTitleLong }
		-- 第 3 层 , 列表
		-- 普通权限列表
		local lookList = lookView
		.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Common_ScrollPane }
		.add{ type = "table" , column_count = 2 , style = SIConstants_Core.raw.Styles.Permission_Look_List }
		for permissionID , permissionEnabled in pairs( globalSettings.EnabledPermissions ) do
			if permissionEnabled == SIPermission.PermissionCode.TRUE then
				if isMaster or permissionID ~= SIPermission.PermissionIDs.Master then
					local permissionCode = globalSettings.DefaultPermissions[permissionID]
					lookList.add{ type = "label" , caption = globalSettings.DefaultNames[permissionID] , style = SIConstants_Core.raw.Styles.Permission_Look_ListLabel }
					local playerPermissionCode = settings.Permissions[permissionID]
					local code = playerPermissionCode or permissionCode
					local caption = code == SIPermission.PermissionCode.TRUE and { "SICore.权限管理-权限-有权限" } or { "SICore.权限管理-权限-无权限" }
					local flow = lookList
					.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Permission_Look_ListFlow }
					.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Permission_Look_ListFlowH }
					flow.add{ type = "label" , caption = caption , style = SIConstants_Core.raw.Styles.Permission_Look_ListItem }
					-- 绘制 物品白名单 和 物品黑名单
					if permissionID == SIPermission.PermissionIDs.OutWhite then
						local whiteList = settings.Lists.ItemWhiteList or globalSettings.DefaultLists.ItemWhiteList
						if #whiteList < 1 then
							flow.add{ type = "label" , caption = { "SICore.权限管理-权限-物品-无" } , style = SIConstants_Core.raw.Styles.Permission_Look_ListItemLong }
						else
							local subList = flow.add{ type = "table" , column_count = 14 , style = SIConstants_Core.raw.Styles.Permission_Look_ListSub }
							for index , itemName in pairs( whiteList ) do
								local item = prototypes.item[itemName]
								subList.add{ type = "sprite-button" , sprite = "item/" .. itemName , tooltip = item.localised_name , style = SIConstants_Core.raw.Styles.Permission_ItemIconGreen }
							end
						end
					elseif permissionID == SIPermission.PermissionIDs.OutBlack then
						local blackList = settings.Lists.ItemBlackList or globalSettings.DefaultLists.ItemBlackList
						if #blackList < 1 then
							flow.add{ type = "label" , caption = { "SICore.权限管理-权限-物品-无" } , style = SIConstants_Core.raw.Styles.Permission_Look_ListItemLong }
						else
							local subList = flow.add{ type = "table" , column_count = 14 , style = SIConstants_Core.raw.Styles.Permission_Look_ListSub }
							for index , itemName in pairs( blackList ) do
								local item = prototypes.item[itemName]
								subList.add{ type = "sprite-button" , sprite = "item/" .. itemName , tooltip = item.localised_name , style = SIConstants_Core.raw.Styles.Permission_ItemIconRed }
							end
						end
					elseif isAdmin then
						flow.add{ type = "label" , caption = { playerPermissionCode and "SICore.权限管理-权限-使用设定值" or "SICore.权限管理-权限-使用默认值" } , style = SIConstants_Core.raw.Styles.Permission_Look_ListItemLong }
					end
				end
			end
		end
		-- 当为管理员时额外创建的控件
		if isAdmin then
			-- ======================================================================
			-- 修改默认权限
			-- ======================================================================
			local playerGlobalSettings = settings.data.global.current
			settings.data.global.radios = {}
			settings.data.global.texts = {}
			settings.data.global.items = {}
			local globalFlow = settings.data.global.flow
			-- 第 1 层 , 说明
			local globalFlow1 = globalFlow.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
			globalFlow1.add{ type = "label" , caption = { "SICore.权限管理-窗口-全局-说明" } , style = SIConstants_Core.raw.Styles.Permission_LabelTop }
			-- 第 2 层 , 列表标题
			local globalFlow2 = globalFlow.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			globalFlow2.add{ type = "line" , direction = "horizontal" }
			-- 第 2.1 层
			local globalFlow21 = globalFlow2.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_TitleFlow }
			globalFlow21.add{ type = "label" , caption = { "SICore.权限管理-窗口-全局-列表-权限名称" } , style = SIConstants_Core.raw.Styles.Permission_Global_ListTitleHead }
			globalFlow21.add{ type = "label" , caption = { "SICore.权限管理-窗口-全局-列表-权限启用" } , style = SIConstants_Core.raw.Styles.Permission_Global_ListTitleShort }
			globalFlow21.add{ type = "label" , caption = { "SICore.权限管理-窗口-全局-列表-权限禁用" } , style = SIConstants_Core.raw.Styles.Permission_Global_ListTitleShort }
			globalFlow21.add{ type = "label" , caption = { "SICore.权限管理-窗口-全局-列表-显示名称" } , style = SIConstants_Core.raw.Styles.Permission_Global_ListTitleLong }
			globalFlow21.add{ type = "label" , caption = { "SICore.权限管理-窗口-全局-列表-本地化字符串" } , style = SIConstants_Core.raw.Styles.Permission_Global_ListTitleShort }
			globalFlow21.add{ type = "label" , caption = { "SICore.权限管理-窗口-全局-列表-提示信息" } , style = SIConstants_Core.raw.Styles.Permission_Global_ListTitleLong }
			globalFlow21.add{ type = "label" , caption = { "SICore.权限管理-窗口-全局-列表-本地化字符串" } , style = SIConstants_Core.raw.Styles.Permission_Global_ListTitleShort }
			-- 第 3 层 , 普通权限列表
			local globalList = globalFlow
			.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Common_ScrollPane }
			.add{ type = "table" , column_count = 7 , style = SIConstants_Core.raw.Styles.Permission_Global_List }
			for permissionID , permissionEnabled in pairs( globalSettings.EnabledPermissions ) do
				if permissionEnabled == SIPermission.PermissionCode.TRUE then
					if isMaster or permissionID ~= SIPermission.PermissionIDs.Master then
						local permissionCode = globalSettings.DefaultPermissions[permissionID]
						local isBasePermissionID = SIPermission.BasePermissionIDs[permissionID]
						globalList.add
						{
							type = "label" ,
							caption = { isBasePermissionID and "SICore.权限管理-窗口-全局-列表-原始编码-原始" or globalSettings.ExpandPermissions[permissionID] and "SICore.权限管理-窗口-全局-列表-原始编码-扩展" or "SICore.权限管理-窗口-全局-列表-原始编码-基础" , globalSettings.DefaultNames[permissionID] } ,
							tooltip = { "SICore.权限管理-窗口-全局-列表-原始编码-提示" , permissionID , globalSettings.PermissionTooltips[permissionID] } ,
							style = SIConstants_Core.raw.Styles.Permission_Global_ListLabelHead
						}
						-- 单选
						settings.data.global.radios[permissionID] =
						{
							[SIPermission.PermissionElementCode.TRUE] = globalList
							.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Permission_Global_ListRadioFlow }
							.add{ type = "radiobutton" , name = SIPermission.Names.GlobalRadioPrefix .. SIPermission.PermissionElementCode.TRUE .. permissionID , state = permissionCode == SIPermission.PermissionCode.TRUE , tooltip = { "SICore.权限管理-窗口-全局-列表-权限启用-提示" } , style = SIConstants_Core.raw.Styles.Common_RadioGreen } ,
							[SIPermission.PermissionElementCode.FALSE] = globalList
							.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Permission_Global_ListRadioFlow }
							.add{ type = "radiobutton" , name = SIPermission.Names.GlobalRadioPrefix .. SIPermission.PermissionElementCode.FALSE .. permissionID , state = permissionCode == SIPermission.PermissionCode.FALSE , tooltip = { "SICore.权限管理-窗口-全局-列表-权限禁用-提示" } , style = SIConstants_Core.raw.Styles.Common_RadioRed }
						}
						settings.data.global.texts[permissionID] = {}
						local textList = settings.data.global.texts[permissionID]
						-- 名称
						local name = playerGlobalSettings.DefaultNames[permissionID]
						local isNameLocal = SITools.IsTable( name )
						textList.name = globalList.add{ type = "textfield" , text = isNameLocal and name[1] or name , tooltip = { "SICore.权限管理-窗口-全局-列表-显示名称-提示" } , style = SIConstants_Core.raw.Styles.Permission_Global_ListText }
						textList.nameLocal = globalList
						.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Permission_Global_ListRadioFlow }
						.add{ type = "checkbox" , state = isNameLocal , tooltip = { "SICore.权限管理-窗口-全局-列表-名称本地化字符串-提示" } , style = SIConstants_Core.raw.Styles.Permission_Global_ListCheck }
						-- 信息
						if isBasePermissionID then
							globalList.add{ type = "label" , caption = { "SICore.权限管理-原版权限" } , style = SIConstants_Core.raw.Styles.Permission_Global_ListLabel }
							globalList.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Permission_Global_ListRadioFlow }
						else
							local message = playerGlobalSettings.DefaultMessages[permissionID]
							local isMessageLocal = SITools.IsTable( message )
							textList.message = globalList.add{ type = "textfield" , text = isMessageLocal and message[1] or message , tooltip = { "SICore.权限管理-窗口-全局-列表-提示信息-提示" } , style = SIConstants_Core.raw.Styles.Permission_Global_ListText }
							textList.messageLocal = globalList
							.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Permission_Global_ListRadioFlow }
							.add{ type = "checkbox" , state = isMessageLocal , tooltip = { "SICore.权限管理-窗口-全局-列表-信息本地化字符串-提示" } , style = SIConstants_Core.raw.Styles.Permission_Global_ListCheck }
						end
					end
				end
			end
			-- 第 4 层 , 物品列表
			local globalFlow4 = globalFlow.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
			-- 第 4.1 层
			local globalFlow41 = globalFlow4.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			globalFlow41.add{ type = "label" , caption = { "SICore.权限管理-窗口-全局-白名单" } , style = SIConstants_Core.raw.Styles.Permission_Global_ItemTitle }
			-- 第 4.1.1 层
			local globalFlow411 = globalFlow41.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
			-- 第 4.1.1.1 层
			local globalFlow4111 = globalFlow411.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			-- 第 4.1.1.1.1 层
			local globalFlow41111 = globalFlow4111.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Permission_Global_ItemFindFlow }
			globalFlow41111.add{ type = "choose-elem-button" , name = SIPermission.Names.GlobalItemFindWhite , tooltip = { "SICore.权限管理-窗口-全局-物品查询" } , elem_type = "item" , item = SIConstants_Core.raw.Items.IconFind , style = SIConstants_Core.raw.Styles.Permission_Global_ItemFind }
			settings.data.global.items.textWhite = globalFlow41111.add{ type = "textfield" , name = SIPermission.Names.GlobalItemFindTextWhite , tooltip = { "SICore.权限管理-窗口-全局-物品查询文本" } , style = SIConstants_Core.raw.Styles.Permission_Global_ItemFindText }
			-- 第 4.1.1.1.2 层
			settings.data.global.items.findWhite = globalFlow4111
			.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Permission_Global_ItemListFind }
			.add{ type = "table" , column_count = 6 , style = SIConstants_Core.raw.Styles.Permission_Global_ListSmall }
			-- 第 4.1.1.2 层
			settings.data.global.items.listWhite = globalFlow411
			.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Permission_Global_ItemListNow }
			.add{ type = "table" , column_count = 6 , style = SIConstants_Core.raw.Styles.Permission_Global_ListSmall }
			for index , itemName in pairs( playerGlobalSettings.DefaultLists.ItemWhiteList ) do
				local item = prototypes.item[itemName]
				settings.data.global.items.listWhite.add{ type = "sprite-button" , name = SIPermission.Names.GlobalItemWhitePrefix .. itemName , sprite = "item/" .. itemName , tooltip = { "SICore.权限管理-窗口-全局-物品-移除" , item.localised_name } , style = SIConstants_Core.raw.Styles.Permission_ItemIconGreen }
			end
			for index , itemName in pairs( playerGlobalSettings.AddingLists.ItemWhiteList ) do
				local item = prototypes.item[itemName]
				settings.data.global.items.listWhite.add{ type = "sprite-button" , name = SIPermission.Names.GlobalItemWhitePrefix .. itemName , sprite = "item/" .. itemName , tooltip = { "SICore.权限管理-窗口-全局-物品-移除" , item.localised_name } , style = SIConstants_Core.raw.Styles.Permission_ItemIconBlue }
			end
			-- 第 4.2 层
			local globalFlow42 = globalFlow4.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			globalFlow42.add{ type = "label" , caption = { "SICore.权限管理-窗口-全局-黑名单" } , style = SIConstants_Core.raw.Styles.Permission_Global_ItemTitle }
			-- 第 4.2.1 层
			local globalFlow421 = globalFlow42.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
			-- 第 4.2.1.1 层
			local globalFlow4211 = globalFlow421.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			-- 第 4.2.1.1.1 层
			local globalFlow42111 = globalFlow4211.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Permission_Global_ItemFindFlow }
			globalFlow42111.add{ type = "choose-elem-button" , name = SIPermission.Names.GlobalItemFindBlack , tooltip = { "SICore.权限管理-窗口-全局-物品查询" } , elem_type = "item" , item = SIConstants_Core.raw.Items.IconFind , style = SIConstants_Core.raw.Styles.Permission_Global_ItemFind }
			settings.data.global.items.textBlack = globalFlow42111.add{ type = "textfield" , name = SIPermission.Names.GlobalItemFindTextBlack , tooltip = { "SICore.权限管理-窗口-全局-物品查询文本" } , style = SIConstants_Core.raw.Styles.Permission_Global_ItemFindText }
			-- 第 4.2.1.1.2 层
			settings.data.global.items.findBlack = globalFlow4211
			.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Permission_Global_ItemListFind }
			.add{ type = "table" , column_count = 6 , style = SIConstants_Core.raw.Styles.Permission_Global_ListSmall }
			-- 第 4.2.1.2 层
			settings.data.global.items.listBlack = globalFlow421
			.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Permission_Global_ItemListNow }
			.add{ type = "table" , column_count = 6 , style = SIConstants_Core.raw.Styles.Permission_Global_ListSmall }
			for index , itemName in pairs( playerGlobalSettings.DefaultLists.ItemBlackList ) do
				local item = prototypes.item[itemName]
				settings.data.global.items.listBlack.add{ type = "sprite-button" , name = SIPermission.Names.GlobalItemBlackPrefix .. itemName , sprite = "item/" .. itemName , tooltip = { "SICore.权限管理-窗口-全局-物品-移除" , item.localised_name } , style = SIConstants_Core.raw.Styles.Permission_ItemIconRed }
			end
			for index , itemName in pairs( playerGlobalSettings.AddingLists.ItemBlackList ) do
				local item = prototypes.item[itemName]
				settings.data.global.items.listBlack.add{ type = "sprite-button" , name = SIPermission.Names.GlobalItemBlackPrefix .. itemName , sprite = "item/" .. itemName , tooltip = { "SICore.权限管理-窗口-全局-物品-移除" , item.localised_name } , style = SIConstants_Core.raw.Styles.Permission_ItemIconOrange }
			end
			-- 第 5 层 , 操作按钮
			local globalFlow5 = globalFlow.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
			globalFlow5.add{ type = "button" , name = SIPermission.Names.GlobalReset , caption = { "SICore.权限管理-窗口-全局-默认" } , tooltip = { "SICore.权限管理-窗口-全局-默认-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonGray }
			globalFlow5.add{ type = "button" , name = SIPermission.Names.GlobalBack , caption = { "SICore.权限管理-窗口-全局-撤销" } , tooltip = { "SICore.权限管理-窗口-全局-撤销-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonBlue }
			globalFlow5.add{ type = "button" , name = SIPermission.Names.GlobalSave , caption = { "SICore.权限管理-窗口-全局-保存" } , tooltip = { "SICore.权限管理-窗口-全局-保存-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonGreen }
			-- ======================================================================
			-- 修改玩家权限
			-- ======================================================================
			settings.data.player.radios = {}
			settings.data.player.items = {}
			local playerFlow = settings.data.player.flow
			-- 第 1 层 , 说明
			local playerFlow1 = playerFlow.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			playerFlow1.add{ type = "label" , caption = { "SICore.权限管理-窗口-玩家-说明1" } , style = SIConstants_Core.raw.Styles.Permission_LabelTop }
			playerFlow1.add{ type = "label" , caption = { "SICore.权限管理-窗口-玩家-说明2" } , style = SIConstants_Core.raw.Styles.Permission_LabelTop }
			-- 第 2 层
			local playerFlow2 = playerFlow.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
			-- 第 2.1 层
			local playerFlow21 = playerFlow2.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			-- 第 2.1.1 层
			local playerFlow211 = playerFlow21.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_TitleFlow }
			playerFlow211.add{ type = "label" , caption = { "SICore.权限管理-窗口-玩家-列表-所有玩家" } , style = SIConstants_Core.raw.Styles.Permission_Player_ListTitlePlayer }
			-- 第 2.1.2 层
			local listPlayerScroll = playerFlow21.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Common_ScrollPane }
			local listPlayer = listPlayerScroll.add{ type = "table" , column_count = 1 , style = SIConstants_Core.raw.Styles.Permission_Player_ListPlayer }
			local currentPlayerButton = nil
			for listPlayerIndex , playerSettings in pairs( SIGlobal.GetAllPlayerSettings( SIPermission.Settings.Name ) ) do
				local player = game.get_player( listPlayerIndex )
				local button = listPlayer.add{ type = "button" , name = SIPermission.Names.PlayerItemPrefix .. listPlayerIndex , caption = { "SICore.权限管理-窗口-玩家-列表-玩家名称" , player.name } , tooltip = { "SICore.权限管理-窗口-玩家-列表-所有玩家-提示" } , style = SIConstants_Core.raw.Styles.Permission_Player_ListItemPlayer }
				if listPlayerIndex == settings.data.player.playerIndex then
					button.enabled = false
					currentPlayerButton = button
				end
			end
			settings.data.player.items.listPlayer = listPlayer
			if currentPlayerButton then
				listPlayerScroll.scroll_to_element( currentPlayerButton , "top-third" )
			end
			-- 第 2.2 层
			local playerFlow22 = playerFlow2.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			-- 第 2.2.1 层
			local playerFlow221 = playerFlow22.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_TitleFlow }
			playerFlow221.add{ type = "label" , caption = { "SICore.权限管理-窗口-玩家-列表-权限名称" } , style = SIConstants_Core.raw.Styles.Permission_Player_ListTitlePermission }
			playerFlow221.add{ type = "label" , caption = { "SICore.权限管理-窗口-玩家-列表-权限默认" } , style = SIConstants_Core.raw.Styles.Permission_Player_ListTitleShort }
			playerFlow221.add{ type = "label" , caption = { "SICore.权限管理-窗口-玩家-列表-权限启用" } , style = SIConstants_Core.raw.Styles.Permission_Player_ListTitleShort }
			playerFlow221.add{ type = "label" , caption = { "SICore.权限管理-窗口-玩家-列表-权限禁用" } , style = SIConstants_Core.raw.Styles.Permission_Player_ListTitleShort }
			-- 第 2.2.2 层
			settings.data.player.items.listPermission = playerFlow22
			.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Common_ScrollPane }
			.add{ type = "table" , column_count = 4 , style = SIConstants_Core.raw.Styles.Permission_Player_ListPermission }
			-- 第 3 层 , 物品列表
			local playerFlow3 = playerFlow.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
			-- 第 3.1 层
			local playerFlow31 = playerFlow3.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			playerFlow31.add{ type = "label" , caption = { "SICore.权限管理-窗口-玩家-白名单" } , style = SIConstants_Core.raw.Styles.Permission_Player_ItemTitle }
			-- 第 3.1.1 层
			local playerFlow311 = playerFlow31.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
			-- 第 3.1.1.1 层
			local playerFlow3111 = playerFlow311.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			-- 第 3.1.1.1.1 层
			local playerFlow31111 = playerFlow3111.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Permission_Player_ItemFindFlow }
			playerFlow31111.add{ type = "choose-elem-button" , name = SIPermission.Names.PlayerItemFindWhite , tooltip = { "SICore.权限管理-窗口-玩家-物品查询" } , elem_type = "item" , item = SIConstants_Core.raw.Items.IconFind , style = SIConstants_Core.raw.Styles.Permission_Player_ItemFind }
			settings.data.player.items.textWhite = playerFlow31111.add{ type = "textfield" , name = SIPermission.Names.PlayerItemFindTextWhite , tooltip = { "SICore.权限管理-窗口-玩家-物品查询文本" } , style = SIConstants_Core.raw.Styles.Permission_Player_ItemFindText }
			-- 第 3.1.1.1.2 层
			settings.data.player.items.findWhite = playerFlow3111
			.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Permission_Player_ItemListFind }
			.add{ type = "table" , column_count = 6 , style = SIConstants_Core.raw.Styles.Permission_Player_ListSmall }
			-- 第 3.1.1.2 层
			settings.data.player.items.listWhite = playerFlow311
			.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Permission_Player_ItemListNow }
			.add{ type = "table" , column_count = 6 , style = SIConstants_Core.raw.Styles.Permission_Player_ListSmall }
			-- 第 3.2 层
			local playerFlow32 = playerFlow3.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			playerFlow32.add{ type = "label" , caption = { "SICore.权限管理-窗口-玩家-黑名单" } , style = SIConstants_Core.raw.Styles.Permission_Player_ItemTitle }
			-- 第 3.2.1 层
			local playerFlow321 = playerFlow32.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
			-- 第 3.2.1.1 层
			local playerFlow3211 = playerFlow321.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			-- 第 3.2.1.1.1 层
			local playerFlow32111 = playerFlow3211.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Permission_Player_ItemFindFlow }
			playerFlow32111.add{ type = "choose-elem-button" , name = SIPermission.Names.PlayerItemFindBlack , tooltip = { "SICore.权限管理-窗口-玩家-物品查询" } , elem_type = "item" , item = SIConstants_Core.raw.Items.IconFind , style = SIConstants_Core.raw.Styles.Permission_Player_ItemFind }
			settings.data.player.items.textBlack = playerFlow32111.add{ type = "textfield" , name = SIPermission.Names.PlayerItemFindTextBlack , tooltip = { "SICore.权限管理-窗口-玩家-物品查询文本" } , style = SIConstants_Core.raw.Styles.Permission_Player_ItemFindText }
			-- 第 3.2.1.1.2 层
			settings.data.player.items.findBlack = playerFlow3211
			.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Permission_Player_ItemListFind }
			.add{ type = "table" , column_count = 6 , style = SIConstants_Core.raw.Styles.Permission_Player_ListSmall }
			-- 第 3.2.1.2 层
			settings.data.player.items.listBlack = playerFlow321
			.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Permission_Player_ItemListNow }
			.add{ type = "table" , column_count = 6 , style = SIConstants_Core.raw.Styles.Permission_Player_ListSmall }
			-- 第 4 层 , 操作按钮
			local playerFlow4 = playerFlow.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
			playerFlow4.add{ type = "button" , name = SIPermission.Names.PlayerClear , caption = { "SICore.权限管理-窗口-玩家-清空" } , tooltip = { "SICore.权限管理-窗口-玩家-清空-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonGray }
			playerFlow4.add{ type = "button" , name = SIPermission.Names.PlayerBack , caption = { "SICore.权限管理-窗口-玩家-撤销" } , tooltip = { "SICore.权限管理-窗口-玩家-撤销-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonBlue }
			playerFlow4.add{ type = "button" , name = SIPermission.Names.PlayerSave , caption = { "SICore.权限管理-窗口-玩家-保存" } , tooltip = { "SICore.权限管理-窗口-玩家-保存-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonGreen }
			if settings.data.player.current then
				SIPermission.FreshListPlayer( settings , globalSettings , isMaster )
			end
			-- ======================================================================
			-- 权限查询
			-- ======================================================================
			settings.data.check.radios = {}
			settings.data.check.items = {}
			local checkFlow = settings.data.check.flow
			-- 第 1 层 , 说明
			local checkFlow1 = checkFlow.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			checkFlow1.add{ type = "label" , caption = { "SICore.权限管理-窗口-查询-说明1" } , style = SIConstants_Core.raw.Styles.Permission_LabelTop }
			checkFlow1.add{ type = "label" , caption = { "SICore.权限管理-窗口-查询-说明2" } , style = SIConstants_Core.raw.Styles.Permission_LabelTop }
			-- 第 2 层
			local checkFlow2 = checkFlow.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
			-- 第 2.1 层
			local checkFlow21 = checkFlow2.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			-- 第 2.1.1 层
			local checkFlow211 = checkFlow21.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_TitleFlow }
			checkFlow211.add{ type = "label" , caption = { "SICore.权限管理-窗口-查询-列表-权限列表" } , style = SIConstants_Core.raw.Styles.Permission_Check_ListTitlePermission }
			-- 第 2.1.2 层
			local listPermissionScroll = checkFlow21.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Common_ScrollPane }
			local listPermission = listPermissionScroll.add{ type = "table" , column_count = 1 , style = SIConstants_Core.raw.Styles.Permission_Check_ListPermission }
			local currentPermissionButton = nil
			for permissionID , permissionEnabled in pairs( globalSettings.EnabledPermissions ) do
				if permissionEnabled == SIPermission.PermissionCode.TRUE then
					if isMaster or permissionID ~= SIPermission.PermissionIDs.Master then
						local permissionCode = globalSettings.DefaultPermissions[permissionID]
						local button = listPermission.add
						{
							type = "button" ,
							name = SIPermission.Names.CheckItemPrefix .. permissionID ,
							caption = { SIPermission.BasePermissionIDs[permissionID] and "SICore.权限管理-窗口-查询-列表-原始编码-原始" or globalSettings.ExpandPermissions[permissionID] and "SICore.权限管理-窗口-查询-列表-原始编码-扩展" or "SICore.权限管理-窗口-查询-列表-原始编码-基础" , globalSettings.DefaultNames[permissionID] , { permissionCode == SIPermission.PermissionCode.TRUE and "SICore.权限管理-权限-有权限" or "SICore.权限管理-权限-无权限" } } ,
							tooltip = { "SICore.权限管理-窗口-查询-列表-原始编码-提示" , permissionID , globalSettings.PermissionTooltips[permissionID] } ,
							style = SIConstants_Core.raw.Styles.Permission_Check_ListItemPermission
						}
						if permissionID == settings.data.check.permissionID then
							button.enabled = false
							currentPermissionButton = button
						end
					end
				end
			end
			settings.data.check.items.listPermission = listPermission
			if currentPermissionButton then
				listPermissionScroll.scroll_to_element( currentPermissionButton , "top-third" )
			end
			-- 第 2.2 层
			local checkFlow22 = checkFlow2.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			-- 第 2.2.1 层
			local checkFlow221 = checkFlow22.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_TitleFlow }
			checkFlow221.add{ type = "label" , caption = { "SICore.权限管理-窗口-查询-列表-玩家列表" } , style = SIConstants_Core.raw.Styles.Permission_Check_ListTitlePlayer }
			checkFlow221.add{ type = "label" , caption = { "SICore.权限管理-窗口-查询-列表-权限默认" } , style = SIConstants_Core.raw.Styles.Permission_Check_ListTitleShort }
			checkFlow221.add{ type = "label" , caption = { "SICore.权限管理-窗口-查询-列表-权限启用" } , style = SIConstants_Core.raw.Styles.Permission_Check_ListTitleShort }
			checkFlow221.add{ type = "label" , caption = { "SICore.权限管理-窗口-查询-列表-权限禁用" } , style = SIConstants_Core.raw.Styles.Permission_Check_ListTitleShort }
			-- 第 2.2.2 层
			settings.data.check.items.listPlayer = checkFlow22
			.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Common_ScrollPane }
			.add{ type = "table" , column_count = 4 , style = SIConstants_Core.raw.Styles.Permission_Check_ListPlayer }
			-- 第 3 层 , 操作按钮
			local checkFlow3 = checkFlow.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
			checkFlow3.add{ type = "button" , name = SIPermission.Names.CheckClear , caption = { "SICore.权限管理-窗口-查询-清空" } , tooltip = { "SICore.权限管理-窗口-查询-清空-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonGray }
			checkFlow3.add{ type = "button" , name = SIPermission.Names.CheckBack , caption = { "SICore.权限管理-窗口-查询-撤销" } , tooltip = { "SICore.权限管理-窗口-查询-清空-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonBlue }
			checkFlow3.add{ type = "button" , name = SIPermission.Names.CheckSave , caption = { "SICore.权限管理-窗口-查询-保存" } , tooltip = { "SICore.权限管理-窗口-查询-清空-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonGreen }
			if settings.data.check.current then
				SIPermission.FreshListCheck( settings )
			end
		end
	end ,
	FreshListPlayer = function( settings , globalSettings , isMaster )
		local items = settings.data.player.items
		items.listPermission.clear()
		items.textWhite.text = ""
		items.findWhite.clear()
		items.listWhite.clear()
		items.textBlack.text = ""
		items.findBlack.clear()
		items.listBlack.clear()
		local radios = settings.data.player.radios
		local otherPlayerSettings = settings.data.player.current
		for permissionID , globalPermissionEnabled in pairs( globalSettings.EnabledPermissions ) do
			if globalPermissionEnabled == SIPermission.PermissionCode.TRUE then
				if isMaster or permissionID ~= SIPermission.PermissionIDs.Master then
					local globalPermissionCode = globalSettings.DefaultPermissions[permissionID]
					local permissionCode = otherPlayerSettings.Permissions[permissionID]
					items.listPermission.add
					{
						type = "label" ,
						caption = { SIPermission.BasePermissionIDs[permissionID] and "SICore.权限管理-窗口-玩家-列表-原始编码-原始" or globalSettings.ExpandPermissions[permissionID] and "SICore.权限管理-窗口-玩家-列表-原始编码-扩展" or "SICore.权限管理-窗口-玩家-列表-原始编码-基础" , globalSettings.DefaultNames[permissionID] , { globalPermissionCode == SIPermission.PermissionCode.TRUE and "SICore.权限管理-权限-有权限" or "SICore.权限管理-权限-无权限" } } ,
						tooltip = { "SICore.权限管理-窗口-玩家-列表-原始编码-提示" , permissionID , globalSettings.PermissionTooltips[permissionID] } ,
						style = SIConstants_Core.raw.Styles.Permission_Player_ListLabelPermission
					}
					-- 单选
					radios[permissionID] =
					{
						[SIPermission.PermissionElementCode.DEFAULT] = items.listPermission
						.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Permission_Player_ListFlow }
						.add{ type = "radiobutton" , name = SIPermission.Names.PlayerRadioPrefix .. SIPermission.PermissionElementCode.DEFAULT .. permissionID , state = permissionCode == nil , tooltip = { "SICore.权限管理-窗口-玩家-列表-权限默认-提示" } , style = SIConstants_Core.raw.Styles.Common_RadioBlue } ,
						[SIPermission.PermissionElementCode.TRUE] = items.listPermission
						.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Permission_Player_ListFlow }
						.add{ type = "radiobutton" , name = SIPermission.Names.PlayerRadioPrefix .. SIPermission.PermissionElementCode.TRUE .. permissionID , state = permissionCode == SIPermission.PermissionCode.TRUE , tooltip = { "SICore.权限管理-窗口-玩家-列表-权限启用-提示" } , style = SIConstants_Core.raw.Styles.Common_RadioGreen } ,
						[SIPermission.PermissionElementCode.FALSE] = items.listPermission
						.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Permission_Player_ListFlow }
						.add{ type = "radiobutton" , name = SIPermission.Names.PlayerRadioPrefix .. SIPermission.PermissionElementCode.FALSE .. permissionID , state = permissionCode == SIPermission.PermissionCode.FALSE , tooltip = { "SICore.权限管理-窗口-玩家-列表-权限禁用-提示" } , style = SIConstants_Core.raw.Styles.Common_RadioRed }
					}
				end
			end
		end
		for index , itemName in pairs( otherPlayerSettings.Lists.ItemWhiteList ) do
			local item = prototypes.item[itemName]
			items.listWhite.add{ type = "sprite-button" , name = SIPermission.Names.PlayerItemWhitePrefix .. itemName , sprite = "item/" .. itemName , tooltip = { "SICore.权限管理-窗口-玩家-物品-移除" , item.localised_name } , style = SIConstants_Core.raw.Styles.Permission_ItemIconGreen }
		end
		for index , itemName in pairs( otherPlayerSettings.AddingLists.ItemWhiteList ) do
			local item = prototypes.item[itemName]
			items.listWhite.add{ type = "sprite-button" , name = SIPermission.Names.PlayerItemWhitePrefix .. itemName , sprite = "item/" .. itemName , tooltip = { "SICore.权限管理-窗口-玩家-物品-移除" , item.localised_name } , style = SIConstants_Core.raw.Styles.Permission_ItemIconBlue }
		end
		for index , itemName in pairs( otherPlayerSettings.Lists.ItemBlackList ) do
			local item = prototypes.item[itemName]
			items.listBlack.add{ type = "sprite-button" , name = SIPermission.Names.PlayerItemBlackPrefix .. itemName , sprite = "item/" .. itemName , tooltip = { "SICore.权限管理-窗口-玩家-物品-移除" , item.localised_name } , style = SIConstants_Core.raw.Styles.Permission_ItemIconRed }
		end
		for index , itemName in pairs( otherPlayerSettings.AddingLists.ItemBlackList ) do
			local item = prototypes.item[itemName]
			items.listBlack.add{ type = "sprite-button" , name = SIPermission.Names.PlayerItemBlackPrefix .. itemName , sprite = "item/" .. itemName , tooltip = { "SICore.权限管理-窗口-玩家-物品-移除" , item.localised_name } , style = SIConstants_Core.raw.Styles.Permission_ItemIconOrange }
		end
	end ,
	FreshListCheck = function( settings )
		local listPlayer = settings.data.check.items.listPlayer
		listPlayer.clear()
		local radios = settings.data.check.radios
		local current = settings.data.check.current
		for playerIndex , permissionCodeData in pairs( current.Players ) do
			local player = game.get_player( playerIndex )
			local permissionCode = permissionCodeData.code
			listPlayer.add{ type = "label" , caption = { "SICore.权限管理-窗口-查询-列表-玩家名称" , player.name } , style = SIConstants_Core.raw.Styles.Permission_Check_ListLabelPlayer }
			-- 单选
			radios[tostring( playerIndex )] =
			{
				[SIPermission.PermissionElementCode.DEFAULT] = listPlayer
				.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Permission_Player_ListFlow }
				.add{ type = "radiobutton" , name = SIPermission.Names.CheckRadioPrefix .. SIPermission.PermissionElementCode.DEFAULT .. playerIndex , state = permissionCode == nil , tooltip = { "SICore.权限管理-窗口-查询-列表-权限默认-提示" } , style = SIConstants_Core.raw.Styles.Common_RadioBlue } ,
				[SIPermission.PermissionElementCode.TRUE] = listPlayer
				.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Permission_Player_ListFlow }
				.add{ type = "radiobutton" , name = SIPermission.Names.CheckRadioPrefix .. SIPermission.PermissionElementCode.TRUE .. playerIndex , state = permissionCode == SIPermission.PermissionCode.TRUE , tooltip = { "SICore.权限管理-窗口-查询-列表-权限启用-提示" } , style = SIConstants_Core.raw.Styles.Common_RadioGreen } ,
				[SIPermission.PermissionElementCode.FALSE] = listPlayer
				.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Permission_Player_ListFlow }
				.add{ type = "radiobutton" , name = SIPermission.Names.CheckRadioPrefix .. SIPermission.PermissionElementCode.FALSE .. playerIndex , state = permissionCode == SIPermission.PermissionCode.FALSE , tooltip = { "SICore.权限管理-窗口-查询-列表-权限禁用-提示" } , style = SIConstants_Core.raw.Styles.Common_RadioRed }
			}
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 功能函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	GetBasePermissionGroup = function()
		local globalSettings = SIGlobal.GetGlobalSettings( SIPermission.Settings.Name )
		if not globalSettings.BasePermissionGroup then
			local globalPermissionGroups = game.permissions
			local basePermissionGroup = globalPermissionGroups.get_group( SIPermission.BasePermissionGroupName )
			if not basePermissionGroup then
				basePermissionGroup = globalPermissionGroups.create_group( SIPermission.BasePermissionGroupName )
				for basePermissionID , inputActionName in pairs( SIPermission.BasePermissionIDs ) do
					basePermissionGroup.set_allows_action( inputActionName , globalSettings.DefaultPermissions[basePermissionID] == SIPermission.PermissionCode.TRUE )
				end
			end
			globalSettings.BasePermissionGroup = basePermissionGroup
		end
		return globalSettings.BasePermissionGroup
	end ,
	-- ======================================================================<br>
	-- 这是一个内部函数 , 请勿外部调用<br>
	-- ======================================================================<br>
	FirePermissionChange = function( playerIndex , permissionID )
		local data =
		{
			name = SIPermission.EventID ,
			tick = game.tick ,
			player_index = playerIndex ,
			permission_id = permissionID
		}
		script.raise_event( SIPermission.EventID , data )
	end ,
	-- ======================================================================<br>
	-- 这是一个内部函数 , 请勿外部调用<br>
	-- ======================================================================<br>
	UpdatePlayerPermissionGroup = function( settings , globalSettings )
		local newGroupFlag = false
		for basePermissionID , inputActionName in pairs( SIPermission.BasePermissionIDs ) do
			local permissionCode = settings.Permissions[basePermissionID]
			if permissionCode then
				newGroupFlag = true
				break
			end
		end
		local playerPermissionGroup = settings.PermissionGroup
		local playerIndex = settings.playerIndex
		if newGroupFlag then
			if not playerPermissionGroup or playerPermissionGroup.name == SIPermission.BasePermissionGroupName then
				settings.PermissionGroup = game.permissions.create_group( SIPermission.PlayerPermissionGroupPrefix .. playerIndex )
				playerPermissionGroup = settings.PermissionGroup
				playerPermissionGroup.add_player( game.get_player( playerIndex ) )
				globalSettings.PermissionGroupList[playerIndex] = playerPermissionGroup
			end
			for basePermissionID , inputActionName in pairs( SIPermission.BasePermissionIDs ) do
				local permissionCode = settings.Permissions[basePermissionID] or globalSettings.DefaultPermissions[basePermissionID]
				local allow = permissionCode == SIPermission.PermissionCode.TRUE
				if playerPermissionGroup.allows_action( inputActionName ) ~= allow then
					playerPermissionGroup.set_allows_action( inputActionName , allow )
				end
			end
		else
			if not playerPermissionGroup then
				settings.PermissionGroup = SIPermission.GetBasePermissionGroup()
				settings.PermissionGroup.add_player( game.get_player( playerIndex ) )
			elseif playerPermissionGroup.name ~= SIPermission.BasePermissionGroupName then
				globalSettings.PermissionGroupList[playerIndex] = nil
				local player = game.get_player( playerIndex )
				playerPermissionGroup.remove_player( player )
				playerPermissionGroup.destroy()
				settings.PermissionGroup = SIPermission.GetBasePermissionGroup()
				settings.PermissionGroup.add_player( player )
			end
		end
	end ,
	Save_Global = function( settings )
		SIPermission.ChangingPermissionGroup = true
		local playerGlobalSettings = settings.data.global.current
		-- 填充数据
		for index , itemName in pairs( playerGlobalSettings.AddingLists.ItemWhiteList ) do
			table.insert( playerGlobalSettings.DefaultLists.ItemWhiteList , itemName )
		end
		for index , itemName in pairs( playerGlobalSettings.AddingLists.ItemBlackList ) do
			table.insert( playerGlobalSettings.DefaultLists.ItemBlackList , itemName )
		end
		playerGlobalSettings.AddingLists.ItemWhiteList = {}
		playerGlobalSettings.AddingLists.ItemBlackList = {}
		-- 同步数据 和 更新基础权限组
		local basePermissionGroup = SIPermission.GetBasePermissionGroup()
		local globalSettings = SIGlobal.GetGlobalSettings( SIPermission.Settings.Name )
		local playerSettingsList = SIGlobal.GetAllPlayerSettings( SIPermission.Settings.Name )
		globalSettings.DefaultLists.ItemWhiteList = SIUtils.table.deepcopy( playerGlobalSettings.DefaultLists.ItemWhiteList )
		globalSettings.DefaultLists.ItemBlackList = SIUtils.table.deepcopy( playerGlobalSettings.DefaultLists.ItemBlackList )
		for permissionID , permissionCode in pairs( globalSettings.EnabledPermissions ) do
			local inputActionName = SIPermission.BasePermissionIDs[permissionID]
			local radioList = settings.data.global.radios[permissionID]
			if radioList then
				local oldPermissionCode = globalSettings.DefaultPermissions[permissionID]
				local newPermissionCode = nil
				local radioValue = SIElements.GetRadioValue( radioList )
				if radioValue == SIPermission.PermissionElementCode.TRUE then
					newPermissionCode = SIPermission.PermissionCode.TRUE
				else
					newPermissionCode = SIPermission.PermissionCode.FALSE
				end
				playerGlobalSettings.DefaultPermissions[permissionID] = newPermissionCode
				globalSettings.DefaultPermissions[permissionID] = newPermissionCode
				if inputActionName then
					local allow = newPermissionCode == SIPermission.PermissionCode.TRUE
					if basePermissionGroup.allows_action( inputActionName ) ~= allow then
						basePermissionGroup.set_allows_action( inputActionName , allow )
					end
				end
				-- 触发事件
				if oldPermissionCode ~= newPermissionCode then
					for playerIndex , currentOtherPlayerSettings in pairs( playerSettingsList ) do
						if not currentOtherPlayerSettings.Permissions[permissionID] then
							SIPermission.FirePermissionChange( playerIndex , permissionID )
						end
					end
				end
			end
			local textList = settings.data.global.texts[permissionID]
			if textList then
				local permissionNameLocal = textList.nameLocal.state
				local permissionName = permissionNameLocal and { textList.name.text } or textList.name.text
				playerGlobalSettings.DefaultNames[permissionID] = permissionName
				globalSettings.DefaultNames[permissionID] = permissionName
				if not inputActionName then
					local permissionMessageLocal = textList.messageLocal.state
					local permissionMessage = permissionMessageLocal and { textList.message.text } or textList.message.text
					playerGlobalSettings.DefaultMessages[permissionID] = permissionMessage
					globalSettings.DefaultMessages[permissionID] = permissionMessage
				end
			end
		end
		-- 刷新所有玩家的控件 和 更新玩家的权限组
		for playerIndex , currentOtherPlayerSettings in pairs( playerSettingsList ) do
			SIPermission.UpdatePlayerPermissionGroup( currentOtherPlayerSettings , globalSettings )
			if currentOtherPlayerSettings.frame and currentOtherPlayerSettings.frame.valid then
				SIPermission.FreshList( currentOtherPlayerSettings )
			end
		end
		SIPermission.ChangingPermissionGroup = false
	end ,
	Save_Player = function( settings )
		SIPermission.ChangingPermissionGroup = true
		local otherPlayerSettings = settings.data.player.current
		if otherPlayerSettings then
			-- 填充数据
			for index , itemName in pairs( otherPlayerSettings.AddingLists.ItemWhiteList ) do
				table.insert( otherPlayerSettings.Lists.ItemWhiteList , itemName )
			end
			for index , itemName in pairs( otherPlayerSettings.AddingLists.ItemBlackList ) do
				table.insert( otherPlayerSettings.Lists.ItemBlackList , itemName )
			end
			otherPlayerSettings.AddingLists.ItemWhiteList = {}
			otherPlayerSettings.AddingLists.ItemBlackList = {}
			-- 同步数据
			local currentOtherPlayerSettings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , settings.data.player.playerIndex )
			if #otherPlayerSettings.Lists.ItemWhiteList < 1 then
				currentOtherPlayerSettings.Lists.ItemWhiteList = nil
			else
				currentOtherPlayerSettings.Lists.ItemWhiteList = SIUtils.table.deepcopy( otherPlayerSettings.Lists.ItemWhiteList )
			end
			if #otherPlayerSettings.Lists.ItemBlackList < 1 then
				currentOtherPlayerSettings.Lists.ItemBlackList = nil
			else
				currentOtherPlayerSettings.Lists.ItemBlackList = SIUtils.table.deepcopy( otherPlayerSettings.Lists.ItemBlackList )
			end
			local globalSettings = SIGlobal.GetGlobalSettings( SIPermission.Settings.Name )
			for permissionID , permissionCode in pairs( globalSettings.EnabledPermissions ) do
				local radioList = settings.data.player.radios[permissionID]
				if radioList then
					local oldPermissionCode = currentOtherPlayerSettings.Permissions[permissionID]
					local newPermissionCode = nil
					local radioValue = SIElements.GetRadioValue( radioList )
					if radioValue == SIPermission.PermissionElementCode.TRUE then
						newPermissionCode = SIPermission.PermissionCode.TRUE
					elseif radioValue == SIPermission.PermissionElementCode.FALSE then
						newPermissionCode = SIPermission.PermissionCode.FALSE
					end
					otherPlayerSettings.Permissions[permissionID] = newPermissionCode
					currentOtherPlayerSettings.Permissions[permissionID] = newPermissionCode
					-- 触发事件
					if oldPermissionCode ~= newPermissionCode then
						SIPermission.FirePermissionChange( settings.data.player.playerIndex , permissionID )
					end
				end
			end
			-- 刷新对应玩家的控件 和 更新玩家的权限组
			SIPermission.UpdatePlayerPermissionGroup( currentOtherPlayerSettings , globalSettings )
			if currentOtherPlayerSettings.frame and currentOtherPlayerSettings.frame.valid then
				SIPermission.FreshList( currentOtherPlayerSettings )
			end
		end
		SIPermission.ChangingPermissionGroup = false
	end ,
	Save_Check = function( settings )
		SIPermission.ChangingPermissionGroup = true
		local current = settings.data.check.current
		if current then
			local globalSettings = SIGlobal.GetGlobalSettings( SIPermission.Settings.Name )
			-- 填充数据 和 同步数据
			local permissionID = settings.data.check.permissionID
			for playerIndex , permissionCode in pairs( current.Players ) do
				local radioList = settings.data.check.radios[tostring( playerIndex )]
				if radioList then
					local currentOtherPlayerSettings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
					local oldPermissionCode = currentOtherPlayerSettings.Permissions[permissionID]
					local newPermissionCode = nil
					local radioValue = SIElements.GetRadioValue( radioList )
					if radioValue == SIPermission.PermissionElementCode.TRUE then
						newPermissionCode = SIPermission.PermissionCode.TRUE
					elseif radioValue == SIPermission.PermissionElementCode.FALSE then
						newPermissionCode = SIPermission.PermissionCode.FALSE
					end
					current.Players[playerIndex] = { code = newPermissionCode }
					currentOtherPlayerSettings.Permissions[permissionID] = newPermissionCode
					-- 触发事件
					if oldPermissionCode ~= newPermissionCode then
						SIPermission.FirePermissionChange( playerIndex , permissionID )
					end
					-- 刷新对应玩家的控件 和 更新玩家的权限组
					SIPermission.UpdatePlayerPermissionGroup( currentOtherPlayerSettings , globalSettings )
					if currentOtherPlayerSettings.frame and currentOtherPlayerSettings.frame.valid then
						SIPermission.FreshList( currentOtherPlayerSettings )
					end
				end
			end
		end
		SIPermission.ChangingPermissionGroup = false
	end ,
	Back_Global = function( settings )
		local current = SIUtils.table.deepcopy( settings.data.global.back )
		current.AddingLists =
		{
			ItemWhiteList = {} , -- 物品白名单 , 临时列表 , 关闭窗口时消失
			ItemBlackList = {}   -- 物品黑名单 , 临时列表 , 关闭窗口时消失
		}
		settings.data.global.current = current
		SIPermission.FreshList( settings )
	end ,
	Back_Player = function( settings )
		local current = settings.data.player.current
		if current then
			local back = SIUtils.table.deepcopy( settings.data.player.back )
			current.Permissions = back.Permissions
			current.Lists = back.Lists
			current.AddingLists =
			{
				ItemWhiteList = {} , -- 物品白名单 , 临时列表 , 关闭窗口时消失
				ItemBlackList = {}   -- 物品黑名单 , 临时列表 , 关闭窗口时消失
			}
			local globalSettings = SIGlobal.GetGlobalSettings( SIPermission.Settings.Name )
			local isMaster = SIPermission.HasPermission( SIPermission.PermissionIDs.Master , settings.playerIndex )
			SIPermission.FreshListPlayer( settings , globalSettings , isMaster )
		end
	end ,
	Back_Check = function( settings )
		local current = settings.data.check.current
		if current then
			local back = SIUtils.table.deepcopy( settings.data.check.back )
			current.Players = back.Players
			SIPermission.FreshListCheck( settings )
		end
	end ,
	Reset_Global = function( settings )
		local current = SIUtils.table.deepcopy( SIPermission.Settings.DefaultGlobal )
		current.AddingLists =
		{
			ItemWhiteList = {} , -- 物品白名单 , 临时列表 , 关闭窗口时消失
			ItemBlackList = {}   -- 物品黑名单 , 临时列表 , 关闭窗口时消失
		}
		settings.data.global.current = current
		-- 同步原版的权限
		if SISettings.Startup.SICore.ControlOriginPermission() then
			for basePermissionID , inputActionName in pairs( defines.input_action ) do
				current.EnabledPermissions[basePermissionID] = SIPermission.PermissionCode.TRUE
				current.DefaultPermissions[basePermissionID] = SIPermission.PermissionCode.TRUE
				current.DefaultNames[basePermissionID] = { "SICore.权限名称-" .. basePermissionID }
				current.PermissionTooltips[basePermissionID] = { "SICore.权限提示-" .. basePermissionID }
			end
		end
		-- 根据设置更新控件
		SIPermission.FreshList( settings )
	end ,
	Clear_Player = function( settings )
		local current = settings.data.player.current
		if current then
			local default = SIUtils.table.deepcopy( SIPermission.Settings.DefaultPlayer )
			current.Permissions = default.Permissions
			current.Lists = default.Lists
			current.AddingLists =
			{
				ItemWhiteList = {} , -- 物品白名单 , 临时列表 , 关闭窗口时消失
				ItemBlackList = {}   -- 物品黑名单 , 临时列表 , 关闭窗口时消失
			}
			if not current.Lists.ItemWhiteList then
				current.Lists.ItemWhiteList = {}
			end
			if not current.Lists.ItemBlackList then
				current.Lists.ItemBlackList = {}
			end
			SIPermission.FreshList( settings )
		end
	end ,
	Clear_Check = function( settings )
		local current = settings.data.check.current
		if current then
			current.Players = {}
			for playerIndex , otherPlayerSettings in pairs( SIGlobal.GetAllPlayerSettings( SIPermission.Settings.Name ) ) do
				current.Players[playerIndex] = {}
			end
			SIPermission.FreshListCheck( settings )
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 事件函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	AddPlayerToBasePremissionGroup = function( playerIndex )
		local playerSettings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if not playerSettings.PermissionGroup then
			playerSettings.PermissionGroup = SIPermission.GetBasePermissionGroup()
			playerSettings.PermissionGroup.add_player( game.get_player( playerIndex ) )
		end
	end ,
	CheckPlayerInventory = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		local globalSettings = SIGlobal.GetGlobalSettings( SIPermission.Settings.Name )
		local outWhite = settings.Permissions[SIPermission.PermissionIDs.OutWhite] or globalSettings.DefaultPermissions[SIPermission.PermissionIDs.OutWhite]
		local outBlack = settings.Permissions[SIPermission.PermissionIDs.OutBlack] or globalSettings.DefaultPermissions[SIPermission.PermissionIDs.OutBlack]
		local player = game.get_player( playerIndex )
		if outWhite == SIPermission.PermissionCode.FALSE then
			local whiteList = settings.Lists.ItemWhiteList or globalSettings.DefaultLists.ItemWhiteList
			if #whiteList > 0 then
				local inventory = player.get_main_inventory()
				for itemName , count in pairs( inventory.get_contents() ) do
					if count > 0 and not SITable.Has( whiteList , itemName ) then
						inventory.remove{ name = itemName , count = count }
					end
				end
			end
		end
		if outBlack == SIPermission.PermissionCode.FALSE then
			local blackList = settings.Lists.ItemBlackList or globalSettings.DefaultLists.ItemBlackList
			if #blackList > 0 then
				local inventory = player.get_main_inventory()
				for index , itemName in pairs( blackList ) do
					local count = inventory.get_item_count( itemName )
					if count > 0 then
						inventory.remove{ name = itemName , count = count }
					end
				end
			end
		end
	end ,
	SelectPlayer = function( playerIndex , name )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.data.player.items then
			local currentPlayerIndex = name:sub( SIPermission.Names.PlayerItemPosition )
			for index , playerItemElement in pairs( settings.data.player.items.listPlayer.children ) do
				if playerItemElement.name:sub( SIPermission.Names.PlayerItemPosition ) == currentPlayerIndex then
					playerItemElement.enabled = false
				else
					playerItemElement.enabled = true
				end
			end
			currentPlayerIndex = tonumber( currentPlayerIndex )
			if currentPlayerIndex then
				settings.data.player.playerIndex = currentPlayerIndex
				local otherPlayerSettings = SIUtils.table.deepcopy( SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , currentPlayerIndex ) )
				local back =
				{
					Permissions = otherPlayerSettings.Permissions ,
					Lists = otherPlayerSettings.Lists
				}
				if not back.Lists.ItemWhiteList then
					back.Lists.ItemWhiteList = {}
				end
				if not back.Lists.ItemBlackList then
					back.Lists.ItemBlackList = {}
				end
				settings.data.player.back = back
				settings.data.player.current = SIUtils.table.deepcopy( back )
				settings.data.player.current.AddingLists =
				{
					ItemWhiteList = {} , -- 物品白名单 , 临时列表 , 关闭窗口时消失
					ItemBlackList = {}   -- 物品黑名单 , 临时列表 , 关闭窗口时消失
				}
				local globalSettings = SIGlobal.GetGlobalSettings( SIPermission.Settings.Name )
				local isMaster = SIPermission.HasPermission( SIPermission.PermissionIDs.Master , settings.playerIndex )
				SIPermission.FreshListPlayer( settings , globalSettings , isMaster )
			end
		end
	end ,
	SelectCheck = function( playerIndex , name )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.data.check.items then
			local currentPermissionID = name:sub( SIPermission.Names.CheckItemPosition )
			for index , permissionItemElement in pairs( settings.data.check.items.listPermission.children ) do
				if permissionItemElement.name:sub( SIPermission.Names.CheckItemPosition ) == currentPermissionID then
					permissionItemElement.enabled = false
				else
					permissionItemElement.enabled = true
				end
			end
			settings.data.check.permissionID = currentPermissionID
			local back =
			{
				Players = {}
			}
			for playerIndex , otherPlayerSettings in pairs( SIGlobal.GetAllPlayerSettings( SIPermission.Settings.Name ) ) do
				local permissionCode = otherPlayerSettings.Permissions[currentPermissionID]
				back.Players[playerIndex] = { code = permissionCode }
			end
			settings.data.check.back = back
			settings.data.check.current = SIUtils.table.deepcopy( settings.data.check.back )
			SIPermission.FreshListCheck( settings )
		end
	end ,
	DeleteGlobalItemWhite = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.data.global.items then
			local playerGlobalSettings = settings.data.global.current
			local itemName = name:sub( SIPermission.Names.GlobalItemWhitePosition )
			SITable.Remove( playerGlobalSettings.DefaultLists.ItemWhiteList , itemName )
			SITable.Remove( playerGlobalSettings.AddingLists.ItemWhiteList , itemName )
			element.destroy()
			for index , itemElement in pairs( settings.data.global.items.findWhite.children ) do
				if itemElement.name:sub( SIPermission.Names.GlobalItemWhitePosition ) == itemName then
					itemElement.enabled = true
				end
			end
		end
	end ,
	DeleteGlobalItemBlack = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.data.global.items then
			local playerGlobalSettings = settings.data.global.current
			local itemName = name:sub( SIPermission.Names.GlobalItemBlackPosition )
			SITable.Remove( playerGlobalSettings.DefaultLists.ItemBlackList , itemName )
			SITable.Remove( playerGlobalSettings.AddingLists.ItemBlackList , itemName )
			element.destroy()
			for index , itemElement in pairs( settings.data.global.items.findBlack.children ) do
				if itemElement.name:sub( SIPermission.Names.GlobalItemBlackPosition ) == itemName then
					itemElement.enabled = true
				end
			end
		end
	end ,
	AddGlobalItemWhite = function( playerIndex , name , element , isChooser )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.data.global.items then
			local player = game.get_player( playerIndex )
			local item = nil
			if isChooser then
				local itemName = name
				item = itemName and prototypes.item[itemName] or nil
				element.elem_value = SIConstants_Core.raw.Items.IconFind
			else
				local itemName = name:sub( SIPermission.Names.GlobalItemBluePosition )
				item = prototypes.item[itemName]
			end
			if item then
				local playerGlobalSettings = settings.data.global.current
				if SITable.Has( playerGlobalSettings.DefaultLists.ItemWhiteList , item.name ) or SITable.Has( playerGlobalSettings.AddingLists.ItemWhiteList , item.name ) then
					SIPrint.Warning( player , { "SICore.权限管理-窗口-全局-物品-已存在" , item.localised_name } )
				else
					if isChooser then
						for index , itemElement in pairs( settings.data.global.items.findWhite.children ) do
							if itemElement.name:sub( SIPermission.Names.GlobalItemWhitePosition ) == item.name then
								itemElement.enabled = false
							end
						end
					else
						element.enabled = false
					end
					table.insert( playerGlobalSettings.AddingLists.ItemWhiteList , item.name )
					settings.data.global.items.listWhite.add{ type = "sprite-button" , name = SIPermission.Names.GlobalItemWhitePrefix .. item.name , sprite = "item/" .. item.name , tooltip = { "SICore.权限管理-窗口-全局-物品-移除" , item.localised_name } , style = SIConstants_Core.raw.Styles.Permission_ItemIconBlue }
				end
			end
		end
	end ,
	AddGlobalItemBlack = function( playerIndex , name , element , isChooser )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.data.global.items then
			local player = game.get_player( playerIndex )
			local item = nil
			if isChooser then
				local itemName = name
				item = itemName and prototypes.item[itemName] or nil
				element.elem_value = SIConstants_Core.raw.Items.IconFind
			else
				local itemName = name:sub( SIPermission.Names.GlobalItemOrangePosition )
				item = prototypes.item[itemName]
			end
			if item then
				local playerGlobalSettings = settings.data.global.current
				if SITable.Has( playerGlobalSettings.DefaultLists.ItemBlackList , item.name ) or SITable.Has( playerGlobalSettings.AddingLists.ItemBlackList , item.name ) then
					SIPrint.Warning( player , { "SICore.权限管理-窗口-全局-物品-已存在" , item.localised_name } )
				else
					if isChooser then
						for index , itemElement in pairs( settings.data.global.items.findBlack.children ) do
							if itemElement.name:sub( SIPermission.Names.GlobalItemBlackPosition ) == item.name then
								itemElement.enabled = false
							end
						end
					else
						element.enabled = false
					end
					table.insert( playerGlobalSettings.AddingLists.ItemBlackList , item.name )
					settings.data.global.items.listBlack.add{ type = "sprite-button" , name = SIPermission.Names.GlobalItemBlackPrefix .. item.name , sprite = "item/" .. item.name , tooltip = { "SICore.权限管理-窗口-全局-物品-移除" , item.localised_name } , style = SIConstants_Core.raw.Styles.Permission_ItemIconOrange }
				end
			end
		end
	end ,
	FindAddGlobalItemWhite = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.data.global.items then
			local text = settings.data.global.items.textWhite.text
			if not text or text == "" then
				SIPrint.Warning( playerIndex , { "SICore.权限管理-窗口-全局-物品查询-名称为空" } )
				return
			end
			settings.data.global.items.findWhite.clear()
			local playerGlobalSettings = settings.data.global.current
			local flag = true
			for itemName , item in pairs( prototypes.item ) do
				if itemName:find( text ) then
					flag = false
					local button = settings.data.global.items.findWhite.add{ type = "sprite-button" , name = SIPermission.Names.GlobalItemBluePrefix .. itemName , sprite = "item/" .. itemName , tooltip = { "SICore.权限管理-窗口-全局-物品-添加" , item.localised_name } , style = SIConstants_Core.raw.Styles.Permission_ItemIconBlue }
					if SITable.Has( playerGlobalSettings.DefaultLists.ItemWhiteList , itemName ) or SITable.Has( playerGlobalSettings.AddingLists.ItemWhiteList , itemName ) then
						button.enabled = false
					end
				end
			end
			if flag then
				SIPrint.Warning( playerIndex , { "SICore.权限管理-窗口-全局-物品查询-结果为空" } )
				return
			end
		end
	end ,
	FindAddGlobalItemBlack = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.data.global.items then
			local text = settings.data.global.items.textBlack.text
			if not text or text == "" then
				SIPrint.Warning( playerIndex , { "SICore.权限管理-窗口-全局-物品查询-名称为空" } )
				return
			end
			settings.data.global.items.findBlack.clear()
			local playerGlobalSettings = settings.data.global.current
			local flag = true
			for itemName , item in pairs( prototypes.item ) do
				if itemName:find( text ) then
					flag = false
					local button = settings.data.global.items.findBlack.add{ type = "sprite-button" , name = SIPermission.Names.GlobalItemOrangePrefix .. itemName , sprite = "item/" .. itemName , tooltip = { "SICore.权限管理-窗口-全局-物品-添加" , item.localised_name } , style = SIConstants_Core.raw.Styles.Permission_ItemIconOrange }
					if SITable.Has( playerGlobalSettings.DefaultLists.ItemBlackList , itemName ) or SITable.Has( playerGlobalSettings.AddingLists.ItemBlackList , itemName ) then
						button.enabled = false
					end
				end
			end
			if flag then
				SIPrint.Warning( playerIndex , { "SICore.权限管理-窗口-全局-物品查询-结果为空" } )
				return
			end
		end
	end ,
	DeletePlayerItemWhite = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.data.player.items and settings.data.player.current then
			local otherPlayerSettings = settings.data.player.current
			local itemName = name:sub( SIPermission.Names.PlayerItemWhitePosition )
			SITable.Remove( otherPlayerSettings.Lists.ItemWhiteList , itemName )
			SITable.Remove( otherPlayerSettings.AddingLists.ItemWhiteList , itemName )
			element.destroy()
			for index , itemElement in pairs( settings.data.player.items.findWhite.children ) do
				if itemElement.name:sub( SIPermission.Names.PlayerItemWhitePosition ) == itemName then
					itemElement.enabled = true
				end
			end
		end
	end ,
	DeletePlayerItemBlack = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.data.player.items and settings.data.player.current then
			local otherPlayerSettings = settings.data.player.current
			local itemName = name:sub( SIPermission.Names.PlayerItemBlackPosition )
			SITable.Remove( otherPlayerSettings.Lists.ItemBlackList , itemName )
			SITable.Remove( otherPlayerSettings.AddingLists.ItemBlackList , itemName )
			element.destroy()
			for index , itemElement in pairs( settings.data.player.items.findBlack.children ) do
				if itemElement.name:sub( SIPermission.Names.PlayerItemBlackPosition ) == itemName then
					itemElement.enabled = true
				end
			end
		end
	end ,
	AddPlayerItemWhite = function( playerIndex , name , element , isChooser )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.data.player.items and settings.data.player.current then
			local player = game.get_player( playerIndex )
			local item = nil
			if isChooser then
				local itemName = name
				item = itemName and prototypes.item[itemName] or nil
				element.elem_value = SIConstants_Core.raw.Items.IconFind
			else
				local itemName = name:sub( SIPermission.Names.PlayerItemBluePosition )
				item = prototypes.item[itemName]
			end
			if item then
				local otherPlayerSettings = settings.data.player.current
				if SITable.Has( otherPlayerSettings.Lists.ItemWhiteList , item.name ) or SITable.Has( otherPlayerSettings.AddingLists.ItemWhiteList , item.name ) then
					SIPrint.Warning( player , { "SICore.权限管理-窗口-玩家-物品-已存在" , item.localised_name } )
				else
					if isChooser then
						for index , itemElement in pairs( settings.data.player.items.findWhite.children ) do
							if itemElement.name:sub( SIPermission.Names.PlayerItemWhitePosition ) == item.name then
								itemElement.enabled = false
							end
						end
					else
						element.enabled = false
					end
					table.insert( otherPlayerSettings.AddingLists.ItemWhiteList , item.name )
					settings.data.player.items.listWhite.add{ type = "sprite-button" , name = SIPermission.Names.PlayerItemWhitePrefix .. item.name , sprite = "item/" .. item.name , tooltip = { "SICore.权限管理-窗口-玩家-物品-移除" , item.localised_name } , style = SIConstants_Core.raw.Styles.Permission_ItemIconBlue }
				end
			end
		end
	end ,
	AddPlayerItemBlack = function( playerIndex , name , element , isChooser )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.data.player.items and settings.data.player.current then
			local player = game.get_player( playerIndex )
			local item = nil
			if isChooser then
				local itemName = name
				item = itemName and prototypes.item[itemName] or nil
				element.elem_value = SIConstants_Core.raw.Items.IconFind
			else
				local itemName = name:sub( SIPermission.Names.PlayerItemOrangePosition )
				item = prototypes.item[itemName]
			end
			if item then
				local otherPlayerSettings = settings.data.player.current
				if SITable.Has( otherPlayerSettings.Lists.ItemBlackList , item.name ) or SITable.Has( otherPlayerSettings.AddingLists.ItemBlackList , item.name ) then
					SIPrint.Warning( player , { "SICore.权限管理-窗口-玩家-物品-已存在" , item.localised_name } )
				else
					if isChooser then
						for index , itemElement in pairs( settings.data.player.items.findBlack.children ) do
							if itemElement.name:sub( SIPermission.Names.PlayerItemBlackPosition ) == item.name then
								itemElement.enabled = false
							end
						end
					else
						element.enabled = false
					end
					table.insert( otherPlayerSettings.AddingLists.ItemBlackList , item.name )
					settings.data.player.items.listBlack.add{ type = "sprite-button" , name = SIPermission.Names.PlayerItemBlackPrefix .. item.name , sprite = "item/" .. item.name , tooltip = { "SICore.权限管理-窗口-玩家-物品-移除" , item.localised_name } , style = SIConstants_Core.raw.Styles.Permission_ItemIconOrange }
				end
			end
		end
	end ,
	FindAddPlayerItemWhite = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.data.player.items and settings.data.player.current then
			local text = settings.data.player.items.textWhite.text
			if not text or text == "" then
				SIPrint.Warning( playerIndex , { "SICore.权限管理-窗口-玩家-物品查询-名称为空" } )
				return
			end
			settings.data.player.items.findWhite.clear()
			local otherPlayerSettings = settings.data.player.current
			local flag = true
			for itemName , item in pairs( prototypes.item ) do
				if itemName:find( text ) then
					flag = false
					local button = settings.data.player.items.findWhite.add{ type = "sprite-button" , name = SIPermission.Names.PlayerItemBluePrefix .. itemName , sprite = "item/" .. itemName , tooltip = { "SICore.权限管理-窗口-玩家-物品-添加" , item.localised_name } , style = SIConstants_Core.raw.Styles.Permission_ItemIconBlue }
					if SITable.Has( otherPlayerSettings.Lists.ItemWhiteList , itemName ) or SITable.Has( otherPlayerSettings.AddingLists.ItemWhiteList , itemName ) then
						button.enabled = false
					end
				end
			end
			if flag then
				SIPrint.Warning( playerIndex , { "SICore.权限管理-窗口-玩家-物品查询-结果为空" } )
				return
			end
		end
	end ,
	FindAddPlayerItemBlack = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.data.player.items and settings.data.player.current then
			local text = settings.data.player.items.textBlack.text
			if not text or text == "" then
				SIPrint.Warning( playerIndex , { "SICore.权限管理-窗口-玩家-物品查询-名称为空" } )
				return
			end
			settings.data.player.items.findBlack.clear()
			local otherPlayerSettings = settings.data.player.current
			local flag = true
			for itemName , item in pairs( prototypes.item ) do
				if itemName:find( text ) then
					flag = false
					local button = settings.data.player.items.findBlack.add{ type = "sprite-button" , name = SIPermission.Names.PlayerItemOrangePrefix .. itemName , sprite = "item/" .. itemName , tooltip = { "SICore.权限管理-窗口-玩家-物品-添加" , item.localised_name } , style = SIConstants_Core.raw.Styles.Permission_ItemIconOrange }
					if SITable.Has( otherPlayerSettings.Lists.ItemBlackList , itemName ) or SITable.Has( otherPlayerSettings.AddingLists.ItemBlackList , itemName ) then
						button.enabled = false
					end
				end
			end
			if flag then
				SIPrint.Warning( playerIndex , { "SICore.权限管理-窗口-玩家-物品查询-结果为空" } )
				return
			end
		end
	end ,
	SaveSettings_Global = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			SIPermission.Save_Global( settings )
		end
	end ,
	SaveSettings_Player = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			SIPermission.Save_Player( settings )
		end
	end ,
	SaveSettings_Check = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			SIPermission.Save_Check( settings )
		end
	end ,
	BackSettings_Global = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			SIPermission.Back_Global( settings )
		end
	end ,
	BackSettings_Player = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			SIPermission.Back_Player( settings )
		end
	end ,
	BackSettings_Check = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			SIPermission.Back_Check( settings )
		end
	end ,
	ResetSettings_Global = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			SIPermission.Reset_Global( settings )
		end
	end ,
	ClearSettings_Player = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			SIPermission.Clear_Player( settings )
		end
	end ,
	ClearSettings_Check = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			SIPermission.Clear_Check( settings )
		end
	end ,
	SwitchRadio_Global = function( playerIndex , name )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid and settings.data.global.radios then
			local permissionID = name:sub( SIPermission.Names.GlobalRadioPosition + 1 )
			local radioIndex = name:sub( SIPermission.Names.GlobalRadioPosition , SIPermission.Names.GlobalRadioPosition )
			SIElements.SetRadios( radioIndex , settings.data.global.radios[permissionID] )
		end
	end ,
	SwitchRadio_Player = function( playerIndex , name )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid and settings.data.player.radios then
			local permissionID = name:sub( SIPermission.Names.PlayerRadioPosition + 1 )
			local radioIndex = name:sub( SIPermission.Names.PlayerRadioPosition , SIPermission.Names.PlayerRadioPosition )
			SIElements.SetRadios( radioIndex , settings.data.player.radios[permissionID] )
		end
	end ,
	SwitchRadio_Check = function( playerIndex , name )
		local settings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid and settings.data.check.radios then
			local permissionID = name:sub( SIPermission.Names.CheckRadioPosition + 1 )
			local radioIndex = name:sub( SIPermission.Names.CheckRadioPosition , SIPermission.Names.CheckRadioPosition )
			SIElements.SetRadios( radioIndex , settings.data.check.radios[permissionID] )
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 接口函数 - 窗口 =================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================<br>
	-- 打开指定玩家的权限管理窗口<br>
	-- ======================================================================<br>
	---@param playerIndex integer -- 玩家索引
	OpenFrameByPlayerIndex = function( playerIndex )
		SIPermission.OpenFrame( playerIndex )
	end ,

	-- ======================================================================<br>
	-- 关闭指定玩家的权限管理窗口<br>
	-- ======================================================================<br>
	---@param playerIndex integer -- 玩家索引
	CloseFrameByPlayerIndex = function( playerIndex )
		SIPermission.CloseFrame( playerIndex )
	end ,

	-- ======================================================================<br>
	-- 打开所有玩家的权限管理窗口<br>
	-- ======================================================================<br>
	OpenFrames = function()
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIPermission.Settings.Name ) ) do
			SIPermission.OpenFrame( playerIndex )
		end
	end ,

	-- ======================================================================<br>
	-- 关闭所有玩家的权限管理窗口<br>
	-- ======================================================================<br>
	CloseFrames = function()
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIPermission.Settings.Name ) ) do
			SIPermission.CloseFrame( playerIndex )
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 接口函数 - 权限管理 =============================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================<br>
	-- 注册一个新的权限<br>
	-- 此函数只能在 on_init 或 on_configuration_changed 中使用<br>
	-- ======================================================================<br>
	---@param permissionID string -- 权限名称
	---@param tooltip string|table -- 权限的含义说明 , 是本地化字符串
	---@param defaultValue integer -- 默认值 , 不能为 nil , 布尔值参考 SIPermission.PermissionCode 的定义 , 当然也可以是其他值
	---@param showName string|table -- 权限的显示名称 , 字符串
	---@param isLocalName boolean -- 权限的显示名称字符串是否为本地化字符串 , 是的话会自动加上大括号
	---@param message string|table -- 玩家未持有权限时提示的信息
	---@param isLocalMsg boolean -- 提示的信息字符串是否为本地化字符串 , 是的话会自动加上大括号
	RegisterPermission = function( permissionID , tooltip , defaultValue , showName , isLocalName , message , isLocalMsg )
		if not defaultValue then
			return
		end
		local globalSettings = SIGlobal.GetGlobalSettings( SIPermission.Settings.Name )
		if globalSettings.EnabledPermissions[permissionID] then
			return
		end
		globalSettings.EnabledPermissions[permissionID] = SIPermission.PermissionCode.TRUE
		globalSettings.DefaultPermissions[permissionID] = defaultValue or SIPermission.PermissionCode.TRUE
		globalSettings.DefaultNames[permissionID] = showName and ( isLocalName and { showName } or showName ) or "未知"
		globalSettings.DefaultMessages[permissionID] = message and ( isLocalMsg and { message } or message ) or "发生了未知错误"
		globalSettings.PermissionTooltips[permissionID] = tooltip or { "SICore.权限提示-无" }
		globalSettings.ExpandPermissions[permissionID] = true
		for playerIndex , playerSettings in pairs( SIGlobal.GetAllPlayerSettings( SIPermission.Settings.Name ) ) do
			if playerSettings.frame and playerSettings.frame.valid then
				SIPermission.FreshList( playerSettings )
			end
			SIPermission.FirePermissionChange( playerIndex , permissionID )
		end
	end ,

	-- ======================================================================<br>
	-- 注销一个权限<br>
	-- 此函数只能在 on_load 或 on_configuration_changed 中使用<br>
	-- 默认权限无法被注销<br>
	-- ======================================================================<br>
	---@param permissionID string -- 权限名称
	UnregisterPermission = function( permissionID )
		if SITable.Has( SIPermission.PermissionIDs , permissionID ) then
			return
		end
		local globalSettings = SIGlobal.GetGlobalSettings( SIPermission.Settings.Name )
		if not globalSettings.ExpandPermissions[permissionID] then
			return
		end
		globalSettings.EnabledPermissions[permissionID] = nil
		globalSettings.DefaultPermissions[permissionID] = nil
		globalSettings.DefaultNames[permissionID] = nil
		globalSettings.DefaultMessages[permissionID] = nil
		globalSettings.PermissionTooltips[permissionID] = nil
		globalSettings.ExpandPermissions[permissionID] = nil
		for playerIndex , playerSettings in pairs( SIGlobal.GetAllPlayerSettings( SIPermission.Settings.Name ) ) do
			if playerSettings.Permissions[permissionID] then
				playerSettings.Permissions[permissionID] = nil
			end
			if playerSettings.frame and playerSettings.frame.valid then
				SIPermission.FreshList( playerSettings )
			end
			SIPermission.FirePermissionChange( playerIndex , permissionID )
		end
	end ,

	-- ======================================================================<br>
	-- 修改一个权限的默认值<br>
	-- 要修改的权限必须先注册<br>
	-- ======================================================================<br>
	---@param permissionID string -- 权限名称
	---@param value integer -- 默认值 , 不能为 nil , 值参考 SIPermission.PermissionCode 的定义 , 即 1 = 有权限 , 2 = 无权限
	SetDefaultPermission = function( permissionID , value )
		local globalSettings = SIGlobal.GetGlobalSettings( SIPermission.Settings.Name )
		if not globalSettings.DefaultPermissions[permissionID] then
			return
		end
		if value ~= SIPermission.PermissionCode.TRUE then
			value = SIPermission.PermissionCode.FALSE
		end
		globalSettings.DefaultPermissions[permissionID] = value
		for playerIndex , playerSettings in pairs( SIGlobal.GetAllPlayerSettings( SIPermission.Settings.Name ) ) do
			if playerSettings.frame and playerSettings.frame.valid then
				SIPermission.FreshList( playerSettings )
			end
			SIPermission.FirePermissionChange( playerIndex , permissionID )
		end
	end ,

	-- ======================================================================<br>
	-- 修改一个玩家的权限的值<br>
	-- 要修改的权限必须先注册<br>
	-- ======================================================================<br>
	---@param permissionID string -- 权限名称
	---@param value integer|nil -- 默认值 , 为 nil 表示使用默认权限 , 值参考 SIPermission.PermissionCode 的定义 , 即 1 = 有权限 , 2 = 无权限
	---@param playerIndex integer -- 玩家索引
	SetPermission = function( permissionID , value , playerIndex )
		local globalSettings = SIGlobal.GetGlobalSettings( SIPermission.Settings.Name )
		if not globalSettings.DefaultPermissions[permissionID] then
			return
		end
		if value ~= SIPermission.PermissionCode.TRUE and value ~= SIPermission.PermissionCode.FALSE then
			value = nil
		end
		local playerSettings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		playerSettings.Permissions[permissionID] = value
		if playerSettings.frame and playerSettings.frame.valid then
			SIPermission.FreshList( playerSettings )
		end
		SIPermission.FirePermissionChange( playerIndex , permissionID )
	end ,

	-- ======================================================================<br>
	-- 判断一个玩家是否持有指定的权限<br>
	-- 此函数用来判断布尔型的权限 , 通常情况下无法判断非布尔型的权限<br>
	-- ======================================================================<br>
	---@param permissionID string -- 权限名称
	---@param playerIndex integer -- 玩家索引
	---@return boolean -- 是否持有权限 , true = 持有权限 , false = 未持有权限
	HasPermission = function( permissionID , playerIndex )
		if permissionID == SIPermission.PermissionIDs.Master then
			local player = game.get_player( playerIndex )
			local globalSettings = SIGlobal.GetGlobalSettings( SIPermission.Settings.Name )
			if globalSettings.MasterList[player.name] then
				return true
			end
		end
		local globalSettings = SIGlobal.GetGlobalSettings( SIPermission.Settings.Name )
		local globalPermission = globalSettings.DefaultPermissions[permissionID]
		if not globalPermission then
			return false
		end
		local playerSettings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		local permissionCode = playerSettings.Permissions[permissionID]
		if permissionCode then
			return permissionCode == SIPermission.PermissionCode.TRUE
		end
		return globalPermission == SIPermission.PermissionCode.TRUE
	end ,

	-- ======================================================================<br>
	-- 获取指定权限的提示信息<br>
	-- 当需要提示玩家缺少必要权限时 , 应该向该玩家输出此文本信息<br>
	-- ======================================================================<br>
	---@param permissionID string -- 权限名称
	---@return string|table -- 玩家未持有权限时应该提示的文本信息
	GetPermissionMessage = function( permissionID )
		local globalSettings = SIGlobal.GetGlobalSettings( SIPermission.Settings.Name )
		return globalSettings.DefaultMessages[permissionID]
	end ,

	-- ======================================================================<br>
	-- 判断一个玩家是否是管理员<br>
	-- ======================================================================<br>
	---@param playerIndex integer -- 玩家索引
	---@return boolean -- 是否为管理员 , true = 是管理员 , false = 不是管理员
	IsAdmin = function( playerIndex )
		local player = game.get_player( playerIndex )
		local globalSettings = SIGlobal.GetGlobalSettings( SIPermission.Settings.Name )
		if globalSettings.MasterList[player.name] then
			return true
		end
		local playerSettings = SIGlobal.GetPlayerSettings( SIPermission.Settings.Name , playerIndex )
		local master = playerSettings.Permissions[SIPermission.PermissionIDs.Master]
		local operator = playerSettings.Permissions[SIPermission.PermissionIDs.Operator]
		local resultMaster = master and master == SIPermission.PermissionCode.TRUE or globalSettings.DefaultPermissions[SIPermission.PermissionIDs.Master] == SIPermission.PermissionCode.TRUE
		local resultOperator = operator and operator == SIPermission.PermissionCode.TRUE or globalSettings.DefaultPermissions[SIPermission.PermissionIDs.Operator] == SIPermission.PermissionCode.TRUE
		return resultMaster or resultOperator
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 接口函数 - 事件 =================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================<br>
	-- 当一个玩家的权限发生了变动时会触发此事件<br>
	-- 事件会包含 4 个参数 :<br>
	-- name          = 事件的 ID 值<br>
	-- tick          = 当前游戏刻<nr>
	-- player_index  = 权限发生变动的玩家的索引<br>
	-- permission_id = 发生变动的权限<br>
	-- ======================================================================<br>
	---@return integer|string -- 事件的 ID 值
	GetEventID = function()
		return SIPermission.EventID
	end
}

SIPermission.Settings =
{
	Name = "Permission" ,
	DefaultGlobal =
	{
		-- 启用的权限 , 只有这些权限才能显示和编辑
		EnabledPermissions =
		{
			-- 管理员
			Master           = SIPermission.PermissionCode.TRUE , -- 最高管理员 , 可以修改其他人的权限 , 允许任命管理员
			Operator         = SIPermission.PermissionCode.TRUE , -- 管理员 , 可以修改其他人的权限 , 但是不能任命管理员
			-- 以下仅对此 MOD 添加的功能生效
			GameSpeed        = SIPermission.PermissionCode.TRUE , -- 可以调整游戏速度
			DeleteMap        = SIPermission.PermissionCode.TRUE , -- 允许使用粉图圈东西
			OreMap           = SIPermission.PermissionCode.TRUE , -- 允许使用黄图圈东西
			RequestMap       = SIPermission.PermissionCode.TRUE , -- 允许使用紫图圈东西
			AutoInsert       = SIPermission.PermissionCode.TRUE , -- 允许使用自动填充
			OutWhite         = SIPermission.PermissionCode.TRUE , -- 不受物品白名单的影响
			OutBlack         = SIPermission.PermissionCode.TRUE , -- 不受物品黑名单的影响
			RPGGlobalSetting = SIPermission.PermissionCode.TRUE , -- 可以使用 RPG 全局属性
			RPGPlayerStatus  = SIPermission.PermissionCode.TRUE , -- 可以使用 RPG 玩家属性
			RPGPlayerSkill   = SIPermission.PermissionCode.TRUE , -- 可以使用 RPG 玩家技能
			RPGExp           = SIPermission.PermissionCode.TRUE , -- 可以获得 RPG 经验
			RPGSystem        = SIPermission.PermissionCode.TRUE   -- 可以使用 RPG 系统 , 与属性无关
		} ,
		-- 当玩家自己的权限不存在时 , 以此表为准
		DefaultPermissions =
		{
			-- 管理员
			Master           = SIPermission.PermissionCode.TRUE , -- 最高管理员 , 可以修改其他人的权限 , 允许任命管理员
			Operator         = SIPermission.PermissionCode.TRUE , -- 管理员 , 可以修改其他人的权限 , 但是不能任命管理员
			-- 以下仅对此 MOD 添加的功能生效
			GameSpeed        = SIPermission.PermissionCode.TRUE , -- 可以调整游戏速度
			DeleteMap        = SIPermission.PermissionCode.TRUE , -- 允许使用粉图圈东西
			OreMap           = SIPermission.PermissionCode.TRUE , -- 允许使用黄图圈东西
			RequestMap       = SIPermission.PermissionCode.TRUE , -- 允许使用紫图圈东西
			AutoInsert       = SIPermission.PermissionCode.TRUE , -- 允许使用自动填充
			OutWhite         = SIPermission.PermissionCode.TRUE , -- 不受物品白名单的影响
			OutBlack         = SIPermission.PermissionCode.TRUE , -- 不受物品黑名单的影响
			RPGGlobalSetting = SIPermission.PermissionCode.TRUE , -- 可以使用 RPG 全局属性
			RPGPlayerStatus  = SIPermission.PermissionCode.TRUE , -- 可以使用 RPG 玩家属性
			RPGPlayerSkill   = SIPermission.PermissionCode.TRUE , -- 可以使用 RPG 玩家技能
			RPGExp           = SIPermission.PermissionCode.TRUE , -- 可以获得 RPG 经验
			RPGSystem        = SIPermission.PermissionCode.TRUE   -- 可以使用 RPG 系统 , 与属性无关
		} ,
		-- 当玩家自己的列表不存在时 , 以此表为准
		DefaultLists =
		{
			ItemWhiteList = {} , -- 物品白名单 , 只有这些物品可以存在于玩家身上 , 不含模块装甲的模块区域
			ItemBlackList = {}   -- 物品黑名单 , 这些物品无法存在于玩家身上 , 不含模块装甲的模块区域 , 会先检测白名单然后再检测黑名单 , 也就是取交集
		} ,
		-- 当玩家触发权限限制时会收到的消息
		DefaultNames =
		{
			-- 管理员
			Master           = "最高管理员" ,
			Operator         = "管理员" ,
			-- 以下仅对此 MOD 添加的功能生效
			GameSpeed        = "调整游戏速度" ,
			DeleteMap        = "使用粉图" ,
			OreMap           = "使用黄图" ,
			RequestMap       = "使用紫图" ,
			AutoInsert       = "使用自动填充" ,
			OutWhite         = "物品白名单豁免" ,
			OutBlack         = "物品黑名单豁免" ,
			RPGGlobalSetting = "RPG 全局设置" ,
			RPGPlayerStatus  = "RPG 玩家属性" ,
			RPGPlayerSkill   = "RPG 玩家技能" ,
			RPGExp           = "RPG 经验" ,
			RPGSystem        = "RPG 系统"
		} ,
		-- 当玩家触发权限限制时会收到的消息
		DefaultMessages =
		{
			-- 管理员
			Master           = "发生了未知错误" ,
			Operator         = "发生了未知错误" ,
			-- 以下仅对此 MOD 添加的功能生效
			GameSpeed        = "发生了未知错误" ,
			DeleteMap        = "发生了未知错误" ,
			OreMap           = "发生了未知错误" ,
			RequestMap       = "发生了未知错误" ,
			AutoInsert       = "发生了未知错误" ,
			OutWhite         = "发生了未知错误" , -- 当出现不可以存在于玩家身上的物品时 , 移除物品后发出消息
			OutBlack         = "发生了未知错误" , -- 当出现不可以存在于玩家身上的物品时 , 移除物品后发出消息
			RPGGlobalSetting = "发生了未知错误" ,
			RPGPlayerStatus  = "发生了未知错误" ,
			RPGPlayerSkill   = "发生了未知错误" ,
			RPGExp           = "发生了未知错误" ,
			RPGSystem        = "发生了未知错误"
		} ,
		PermissionTooltips =
		{
			-- 管理员
			Master           = { "SICore.权限提示-Master"           } ,
			Operator         = { "SICore.权限提示-Operator"         } ,
			-- 以下仅对此 MOD 添加的功能生效
			GameSpeed        = { "SICore.权限提示-GameSpeed"        } ,
			DeleteMap        = { "SICore.权限提示-DeleteMap"        } ,
			OreMap           = { "SICore.权限提示-OreMap"           } ,
			RequestMap       = { "SICore.权限提示-RequestMap"       } ,
			AutoInsert       = { "SICore.权限提示-AutoInsert"       } ,
			OutWhite         = { "SICore.权限提示-OutWhite"         } ,
			OutBlack         = { "SICore.权限提示-OutBlack"         } ,
			RPGGlobalSetting = { "SICore.权限提示-RPGGlobalSetting" } ,
			RPGPlayerStatus  = { "SICore.权限提示-RPGPlayerStatus"  } ,
			RPGPlayerSkill   = { "SICore.权限提示-RPGPlayerSkill"   } ,
			RPGExp           = { "SICore.权限提示-RPGExp"           } ,
			RPGSystem        = { "SICore.权限提示-RPGSystem"        }
		} ,
		ExpandPermissions = {} , -- 是否为新扩展出来的权限
		MasterList = {} , -- 此列表中的玩家会被视为最高管理员
		BasePermissionGroup = nil ,
		PermissionGroupList = {}
	} ,
	DefaultPlayer =
	{
		frame = nil ,
		frameLocation = nil ,
		tabPane = nil ,
		lastAdmin = false ,
		data =
		{
			look =
			{
				tab = nil ,
				flow = nil
			} ,
			global =
			{
				tab = nil ,
				flow = nil ,
				radios = nil ,
				texts = nil ,
				items = nil ,
				current = nil ,
				back = nil
			} ,
			player =
			{
				tab = nil ,
				flow = nil ,
				radios = nil ,
				items = nil ,
				current = nil ,
				back = nil ,
				playerIndex = nil
			} ,
			check =
			{
				tab = nil ,
				flow = nil ,
				radios = nil ,
				items = nil ,
				current = nil ,
				back = nil ,
				permissionID = nil
			}
		} ,
		PermissionGroup = nil ,
		Permissions = {} ,
		Lists =
		{
			ItemWhiteList = nil ,
			ItemBlackList = nil
		}
	} ,
	InitFunction = function( settings )
		if SISettings.Startup.SICore.ControlOriginPermission() then
			local defaultGlobalSettings = SIGlobal.GetGlobalSettings( SIPermission.Settings.Name )
			for basePermissionID , inputActionName in pairs( defines.input_action ) do
				defaultGlobalSettings.EnabledPermissions[basePermissionID] = SIPermission.PermissionCode.TRUE
				defaultGlobalSettings.DefaultPermissions[basePermissionID] = SIPermission.PermissionCode.TRUE
				defaultGlobalSettings.DefaultNames[basePermissionID] = { "SICore.权限名称-" .. basePermissionID }
				defaultGlobalSettings.PermissionTooltips[basePermissionID] = { "SICore.权限提示-" .. basePermissionID }
			end
		end
	end ,
	ModifyFunction = function( settings )
		local defaultGlobalSettings = SIGlobal.GetGlobalSettings( SIPermission.Settings.Name )
		if not defaultGlobalSettings.EnabledPermissions then
			defaultGlobalSettings.EnabledPermissions = SIUtils.table.deepcopy( SIPermission.Settings.DefaultGlobal.EnabledPermissions )
		end
		if SISettings.Startup.SICore.ControlOriginPermission() then
			for basePermissionID , defultPermissionValue in pairs( defaultGlobalSettings.EnabledPermissions ) do
				if not SIPermission.Settings.DefaultGlobal.EnabledPermissions[basePermissionID] and not SIPermission.BasePermissionIDs[basePermissionID] and not defaultGlobalSettings.ExpandPermissions[basePermissionID] then
					defaultGlobalSettings.EnabledPermissions[basePermissionID] = nil
					defaultGlobalSettings.DefaultPermissions[basePermissionID] = nil
					defaultGlobalSettings.DefaultNames[basePermissionID] = nil
					defaultGlobalSettings.DefaultMessages[basePermissionID] = nil
					defaultGlobalSettings.PermissionTooltips[basePermissionID] = nil
					defaultGlobalSettings.ExpandPermissions[basePermissionID] = nil
				else
					defaultGlobalSettings.EnabledPermissions[basePermissionID] = SIPermission.PermissionCode.TRUE
				end
			end
			for basePermissionID , inputActionName in pairs( defines.input_action ) do
				if not defaultGlobalSettings.EnabledPermissions[basePermissionID] then
					defaultGlobalSettings.EnabledPermissions[basePermissionID] = SIPermission.PermissionCode.TRUE
					defaultGlobalSettings.DefaultPermissions[basePermissionID] = SIPermission.PermissionCode.TRUE
					defaultGlobalSettings.DefaultNames[basePermissionID] = { "SICore.权限名称-" .. basePermissionID }
					defaultGlobalSettings.PermissionTooltips[basePermissionID] = { "SICore.权限提示-" .. basePermissionID }
				end
			end
		else
			for basePermissionID , defultPermissionValue in pairs( defaultGlobalSettings.EnabledPermissions ) do
				if SIPermission.BasePermissionIDs[basePermissionID] then
					defaultGlobalSettings.EnabledPermissions[basePermissionID] = SIPermission.PermissionCode.FALSE
				end
			end
		end
	end
}

-- 添加原版游戏自带的权限
if SISettings.Startup.SICore.ControlOriginPermission() then
	for basePermissionID , inputActionName in pairs( defines.input_action ) do
		SIPermission.BasePermissionIDs[basePermissionID] = inputActionName
	end
end

-- 计算名称前缀的字符串长度
SIPermission.Names.GlobalRadioPosition = #SIPermission.Names.GlobalRadioPrefix + 1
SIPermission.Names.GlobalItemWhitePosition = #SIPermission.Names.GlobalItemWhitePrefix + 1
SIPermission.Names.GlobalItemBlackPosition = #SIPermission.Names.GlobalItemBlackPrefix + 1
SIPermission.Names.GlobalItemBluePosition = #SIPermission.Names.GlobalItemBluePrefix + 1
SIPermission.Names.GlobalItemOrangePosition = #SIPermission.Names.GlobalItemOrangePrefix + 1
SIPermission.Names.PlayerItemPosition = #SIPermission.Names.PlayerItemPrefix + 1
SIPermission.Names.PlayerRadioPosition = #SIPermission.Names.PlayerRadioPrefix + 1
SIPermission.Names.PlayerItemWhitePosition = #SIPermission.Names.PlayerItemWhitePrefix + 1
SIPermission.Names.PlayerItemBlackPosition = #SIPermission.Names.PlayerItemBlackPrefix + 1
SIPermission.Names.PlayerItemBluePosition = #SIPermission.Names.PlayerItemBluePrefix + 1
SIPermission.Names.PlayerItemOrangePosition = #SIPermission.Names.PlayerItemOrangePrefix + 1
SIPermission.Names.CheckItemPosition = #SIPermission.Names.CheckItemPrefix + 1
SIPermission.Names.CheckRadioPosition = #SIPermission.Names.CheckRadioPrefix + 1

-- 工具栏按钮数据
SIPermission.Toolbar =
{
	ID = "SI核心-权限管理" ,
	Name = "权限管理" ,
	IconItemName = SIConstants_Core.raw.Items.IconEdit ,
	LocalizedName = { "SICore.权限管理-工具栏-按钮" } ,
	LocalizedDescription = { "SICore.权限管理-工具栏-提示" } ,
	ActionRemoteInterfaceID = SIPermission.InterfaceID ,
	ActionRemoteFunctionName = "OpenFrameByPlayerIndex" ,
	Permission = nil ,
	Order = "SICore-Permission"
}
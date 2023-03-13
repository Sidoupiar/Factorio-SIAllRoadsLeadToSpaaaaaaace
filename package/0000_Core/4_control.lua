-- ------------------------------------------------------------------------------------------------
-- ---------- 定义信息 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIControl.Init
{
	[SICommon.Types.DamageType] =
	{
		-- 物理伤害
		PhysicWater     = "潮湿" ,
		PhysicDry       = "干燥" ,
		PhysicIce       = "冰冻" ,
		PhysicRadiation	= "辐射" ,
		PhysicCorrosion = "腐蚀" ,
		PhysicSound     = "声波" ,
		PhysicEnergy    = "能量" ,
		PhysicGravity   = "重力" ,
		-- 魔法伤害
		MagicPower      = "力量" ,
		MagicSpirit     = "意念" ,
		MagicBlood      = "献祭" ,
		MagicDisease    = "瘟疫" ,
		MagicFear       = "恐惧" ,
		MagicTwist      = "扭曲" ,
		MagicCorrosion  = "侵蚀" ,
		MagicVoid       = "虚空" ,
		-- 元素伤害
		ElementCut      = "割元素" ,
		ElementHeat     = "炎元素" ,
		ElementGround   = "固元素" ,
		ElementWater    = "流元素" ,
		ElementWind     = "气元素" ,
		ElementLife     = "命元素" ,
		ElementSound    = "音元素" ,
		ElementElectric = "电元素" ,
		ElementLight    = "光元素" ,
		ElementDary     = "影元素" ,
		ElementEnergy   = "能元素" ,
		ElementHeavy    = "质元素" ,
		ElementFull     = "盈元素" ,
		ElementVoid     = "虚元素" ,
		ElementSkill    = "技元素" ,
		-- 其他伤害
		DamageSpace     = "空间" ,
		DamageThought   = "精神" ,
		DamageSoul      = "灵魂"
	} ,
	[SICommon.Types.Items.Item] =
	{
		IconEmpty = "图标空的" ,
		IconFind = "图标查询" ,
		IconEdit = "图标修改" ,
		IconSave = "图标保存" ,
		IconSetting = "图标设置" ,
		IconToolbar = "图标工具" ,
		IconNote = "图标便签" ,
		IconMessage = "图标消息" ,
		IconSettingWhite = "图标设置-白" ,
		IconNext1 = "图标前进1" ,
		IconNext2 = "图标前进2" ,
		IconBack1 = "图标后退1" ,
		IconBack2 = "图标后退2" ,
		IconToUp = "图标向上" ,
		IconToRight = "图标向右" ,
		IconToDown = "图标向下" ,
		IconToLeft = "图标向左" ,
		IconToCenter = "图标向中" ,
		IconOnTop = "图标最顶部" ,
		IconOnRight = "图标最右侧" ,
		IconOnBottom = "图标最底部" ,
		IconOnLeft = "图标最左侧" ,
		IconArrow = "图标箭头" ,
		IconStar = "图标星星" ,
		IconDoc = "图标文档" ,
		IconTip = "图标提示" ,
		IconMini = "图标小窗口" ,
		IconLock = "图标锁定" ,
		IconUnlock = "图标解锁" ,
		IconClose = "图标关闭" ,
		IconAdd = "图标添加" ,
		-- 纯色图标
		IconColorSky = "图标纯色天色" ,
		IconColorCopper = "图标纯色铜色" ,
		IconColorGrass = "图标纯色草色" ,
		IconColorDream = "图标纯色梦色" ,
		IconColorSliver = "图标纯色银色" ,
		IconColorMeat = "图标纯色肉色"
	} ,
	[SICommon.Types.Items.SelectionTool] =
	{
		DeleteMap  = "粉图" ,
		OreMap     = "黄图" ,
		RequestMap = "紫图"
	} ,
	[SICommon.Types.Entities.FlyingText] =
	{
		FlyingText = "飞行文字"
	} ,
	[SICommon.Types.Input] =
	{
		OreMapFrame = "黄图窗口" ,
		RequestMapFrame = "紫图窗口"
	} ,
	Styles =
	{
		-- 通用控件样式
		Common_FrameTitleLabel = "通用-窗口标题标签" ,
		Common_DraggableSpace = "通用-可拖动区域" ,
		Common_FlowTop = "通用-布局上" ,
		Common_FlowBottom = "通用-布局下" ,
		Common_FlowLeft = "通用-布局左" ,
		Common_FlowRight = "通用-布局右" ,
		Common_FlowCenterH = "通用-布局中竖" ,
		Common_FlowCenterV = "通用-布局中横" ,
		Common_TitleFlow = "通用-标题布局" ,
		Common_ScrollPane = "通用-滚动区域" ,
		Common_List = "通用-列表" ,
		Common_ButtonGray = "通用-按钮灰" ,
		Common_ButtonGreen = "通用-按钮绿" ,
		Common_ButtonRed = "通用-按钮红" ,
		Common_ButtonBlue = "通用-按钮蓝" ,
		Common_ButtonPurple = "通用-按钮紫" ,
		Common_ButtonOrange = "通用-按钮橙" ,
		Common_ButtonTitle = "通用-按钮标题" ,
		Common_Radio = "通用-单选" ,
		Common_RadioGreen = "通用-单选绿" ,
		Common_RadioRed = "通用-单选红" ,
		Common_RadioBlue = "通用-单选蓝" ,
		Common_CheckBox = "通用-复选" ,
		Common_CheckBoxGreen = "通用-复选绿" ,
		Common_CheckBoxRed = "通用-复选红" ,
		Common_CheckBoxBlue = "通用-复选蓝" ,
		-- 主面板控件样式
		Mainbar_Frame = "主面板-窗口" ,
		Mainbar_ButtonBig = "主面板-按钮大" ,
		Mainbar_ButtonSmall = "主面板-按钮小" ,
		Mainbar_LabelFlow = "主面板-标签布局" ,
		Mainbar_LabelText = "主面板-标签文本" ,
		Mainbar_ToolbarOpen = "主面板-工具栏-打开" ,
		Mainbar_ToolbarClose = "主面板-工具栏-关闭" ,
		Mainbar_ToolbarCommonFlow = "主面板-工具栏-常用布局" ,
		Mainbar_ToolbarCommonButton = "主面板-工具栏-常用按钮" ,
		Mainbar_ToolbarScroll = "主面板-工具栏滚动区域" ,
		Mainbar_ToolbarList = "主面板-工具栏列表" ,
		Mainbar_ToolbarButton = "主面板-工具栏按钮" ,
		Mainbar_Button_GameSpeed = "主面板-按钮-游戏速度" ,
		Mainbar_Button_GameSpeedSmall = "主面板-按钮-游戏速度小" ,
		Mainbar_Button_Time = "主面板-游戏时间-显示" ,
		Mainbar_Button_TimeSwitch = "主面板-游戏时间-显示切换" ,
		-- 主面板设置管理控件样式
		Mainbar_Setting_Frame = "主面板设置管理-窗口" ,
		Mainbar_Setting_LabelTop = "主面板设置管理-标签顶部" ,
		Mainbar_Setting_ListTitleFlow = "主面板设置管理-列表标题布局" ,
		Mainbar_Setting_ListLabel = "主面板设置管理-列表标签" ,
		Mainbar_Setting_ListCheck = "主面板设置管理-列表复选" ,
		Mainbar_Setting_ListItemFlow = "主面板设置管理-列表元素布局" ,
		Mainbar_Setting_ListPlace = "主面板设置管理-列表占位" ,
		Mainbar_Setting_Slider = "主面板设置管理-滑块" ,
		Mainbar_Setting_Number = "主面板设置管理-数字框" ,
		Mainbar_Setting_DropDown = "主面板设置管理-下拉列表" ,
		-- 主面板便签管理控件样式
		Mainbar_Note_Frame = "主面板便签管理-窗口" ,
		Mainbar_Note_LabelTop = "主面板便签管理-标签顶部" ,
		Mainbar_Note_RightFlow = "主面板便签管理-右侧布局" ,
		Mainbar_Note_ListNoteNormal = "主面板便签管理-列表便签按钮-普通" ,
		Mainbar_Note_ListNoteKey = "主面板便签管理-列表便签按钮-重点" ,
		Mainbar_Note_ListNoteNone = "主面板便签管理-列表便签按钮-暂无" ,
		Mainbar_Note_ListNoteDelete = "主面板便签管理-列表便签按钮-删除" ,
		Mainbar_Note_ListFlow = "主面板便签管理-列表便签布局" ,
		Mainbar_Note_ListTitle = "主面板便签管理-列表便签标题" ,
		Mainbar_Note_ListContent = "主面板便签管理-列表便签内容" ,
		Mainbar_Note_EditFlow = "主面板便签管理-编辑便签布局" ,
		Mainbar_Note_EditLabel = "主面板便签管理-编辑便签标签" ,
		Mainbar_Note_EditTitle = "主面板便签管理-编辑便签标题" ,
		Mainbar_Note_EditContent = "主面板便签管理-编辑便签内容" ,
		Mainbar_Note_EditOrder = "主面板便签管理-编辑便签排序" ,
		Mainbar_Note_EditCheck = "主面板便签管理-编辑便签复选" ,
		-- 主面板消息管理控件样式
		Mainbar_Message_Frame = "主面板消息管理-窗口" ,
		Mainbar_Message_LabelTop = "主面板消息管理-标签顶部" ,
		Mainbar_Message_ListMessageNormal = "主面板消息管理-列表消息按钮-普通" ,
		Mainbar_Message_ListMessageBack = "主面板消息管理-列表消息按钮-反馈" ,
		Mainbar_Message_ListMessageTip = "主面板消息管理-列表消息按钮-提示" ,
		Mainbar_Message_ListMessageWarn = "主面板消息管理-列表消息按钮-警告" ,
		Mainbar_Message_ListMessageError = "主面板消息管理-列表消息按钮-异常" ,
		Mainbar_Message_ListMessageSpecial = "主面板消息管理-列表消息按钮-特殊" ,
		Mainbar_Message_ListFlow = "主面板消息管理-列表消息布局" ,
		Mainbar_Message_ListTitle = "主面板消息管理-列表消息标题" ,
		Mainbar_Message_ListContent = "主面板消息管理-列表消息内容" ,
		-- 权限管理控件样式
		Permission_Frame = "权限管理-窗口" ,
		Permission_TabPane = "权限管理-分页面板" ,
		Permission_Flow = "权限管理-布局" ,
		Permission_LabelTop = "权限管理-标签顶部" ,
		Permission_ItemIconGreen = "权限管理-物品图标绿" ,
		Permission_ItemIconRed = "权限管理-物品图标红" ,
		Permission_ItemIconBlue = "权限管理-物品图标蓝" ,
		Permission_ItemIconOrange = "权限管理-物品图标橙" ,
		Permission_Look_ListTitle = "权限管理-查看-列表标题" ,
		Permission_Look_ListTitleLong = "权限管理-查看-列表标题长" ,
		Permission_Look_List = "权限管理-查看-列表" ,
		Permission_Look_ListLabel = "权限管理-查看-列表标签" ,
		Permission_Look_ListFlow = "权限管理-查看-列表布局" ,
		Permission_Look_ListFlowH = "权限管理-查看-列表布局横" ,
		Permission_Look_ListItem = "权限管理-查看-列表项目" ,
		Permission_Look_ListItemLong = "权限管理-查看-列表项目长" ,
		Permission_Look_ListSub = "权限管理-查看-列表内部" ,
		Permission_Global_ListTitleHead = "权限管理-全局-列表标题头部" ,
		Permission_Global_ListTitleShort = "权限管理-全局-列表标题短" ,
		Permission_Global_ListTitleLong = "权限管理-全局-列表标题长" ,
		Permission_Global_List = "权限管理-全局-列表" ,
		Permission_Global_ListLabelHead = "权限管理-全局-列表标签头部" ,
		Permission_Global_ListLabel = "权限管理-全局-列表标签" ,
		Permission_Global_ListRadioFlow = "权限管理-全局-列表单选布局" ,
		Permission_Global_ListText = "权限管理-全局-列表文本条" ,
		Permission_Global_ListCheck = "权限管理-全局-列表复选" ,
		Permission_Global_ItemTitle = "权限管理-全局-物品标题" ,
		Permission_Global_ItemListFind = "权限管理-全局-物品列表查询" ,
		Permission_Global_ItemListNow = "权限管理-全局-物品列表现有" ,
		Permission_Global_ListSmall = "权限管理-全局-列表小" ,
		Permission_Global_ItemFindFlow = "权限管理-全局-物品查询布局" ,
		Permission_Global_ItemFind = "权限管理-全局-物品查询" ,
		Permission_Global_ItemFindText = "权限管理-全局-物品查询文本条" ,
		Permission_Player_ListTitlePlayer = "权限管理-玩家-列表标题玩家" ,
		Permission_Player_ListTitlePermission = "权限管理-玩家-列表标题权限" ,
		Permission_Player_ListTitleShort = "权限管理-玩家-列表标题短" ,
		Permission_Player_ListPlayer = "权限管理-玩家-列表玩家" ,
		Permission_Player_ListPermission = "权限管理-玩家-列表权限" ,
		Permission_Player_ListItemPlayer = "权限管理-玩家-列表按钮玩家" ,
		Permission_Player_ListLabelPermission = "权限管理-玩家-列表标签权限" ,
		Permission_Player_ListFlow = "权限管理-玩家-列表标签布局" ,
		Permission_Player_ItemTitle = "权限管理-玩家-物品标题" ,
		Permission_Player_ItemListFind = "权限管理-玩家-物品列表查询" ,
		Permission_Player_ItemListNow = "权限管理-玩家-物品列表现有" ,
		Permission_Player_ListSmall = "权限管理-玩家-列表小" ,
		Permission_Player_ItemFindFlow = "权限管理-玩家-物品查询布局" ,
		Permission_Player_ItemFind = "权限管理-玩家-物品查询" ,
		Permission_Player_ItemFindText = "权限管理-玩家-物品查询文本条" ,
		Permission_Check_ListTitlePermission = "权限管理-查询-列表标题权限" ,
		Permission_Check_ListTitlePlayer = "权限管理-查询-列表标题玩家" ,
		Permission_Check_ListTitleShort = "权限管理-查询-列表标题短" ,
		Permission_Check_ListPermission = "权限管理-查询-列表权限" ,
		Permission_Check_ListPlayer = "权限管理-查询-列表玩家" ,
		Permission_Check_ListItemPermission = "权限管理-查询-列表按钮权限" ,
		Permission_Check_ListLabelPlayer = "权限管理-查询-列表标签玩家" ,
		Permission_Check_ListFlow = "权限管理-查询-列表标签布局" ,
		-- 信息查询控件样式
		Finder_Frame = "信息查询-窗口" ,
		Finder_DropDown = "信息查询-下拉列表" ,
		Finder_Flow = "信息查询-布局" ,
		Finder_Chooser = "信息查询-选择" ,
		Finder_Label = "信息查询-选择标签" ,
		Finder_ListLabel = "信息查询-列表标签" ,
		-- 黄图控件样式
		OreMap_Frame = "黄图-窗口" ,
		OreMap_LabelTop = "黄图-标签顶部" ,
		OreMap_Check = "黄图-复选" ,
		OreMap_FlowShort = "黄图-布局短" ,
		OreMap_LabelShort = "黄图-标签短" ,
		OreMap_Number = "黄图-数字框" ,
		OreMap_ButtonGreen = "黄图-绿色按钮" ,
		OreMap_ListTitleIcon = "黄图-列表标题图标" ,
		OreMap_ListTitleLong = "黄图-列表标题长" ,
		OreMap_ListIcon = "黄图-列表图标" ,
		OreMap_ListLabelLong = "黄图-列表标签长" ,
		OreMap_LabelBottom = "黄图-标签底部" ,
		-- 紫图控件样式
		RequestMap_Frame = "紫图-窗口" ,
		RequestMap_TabPane = "紫图-分页面板" ,
		RequestMap_Label = "紫图-标签" ,
		RequestMap_Text = "紫图-文本条" ,
		RequestMap_EmptyFlow = "紫图-空布局" ,
		RequestMap_ListButton = "紫图-列表定位按钮" ,
		RequestMap_ListFlow = "紫图-列表布局" ,
		RequestMap_SubList = "紫图-子列表" ,
	}
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SINeed( "Tool/SIFunctions" )
SINeed( "Tool/SIElements" )

-- ----------------------------------------
-- 初始化<br>
-- ----------------------------------------
SINeed( "System/MainData" )
SINeed( "GUI/Mainbar" )
SINeed( "GUI/MainbarSetting" )
SINeed( "GUI/MainbarNote" )
SINeed( "GUI/MainbarMessage" )
SINeed( "GUI/Permission" )
SINeed( "GUI/Finder" )
SINeed( "GUI/OreMap" )
SINeed( "GUI/RequestMap" )
SIGlobal.CreateSettings( SIMainData.Settings )
SIGlobal.CreateSettings( SIPermission.Settings )
SIGlobal.CreateSettings( SIFinder.Settings )
SIGlobal.CreateSettings( SIOreMap.Settings )
SIGlobal.CreateSettings( SIRequestMap.Settings )

-- ------------------------------------------------------------------------------------------------
-- ---------- 图形界面 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 事件<br>
-- ----------------------------------------
SIEventBus
.Init( function( functionID )
	-- 尝试调出主面板
	for playerIndex , player in pairs( game.players ) do
		SIMainbar.OpenFrame( playerIndex )
	end
	-- 权限管理窗口事件
	SIMainbar.RegisterToolbarButton( SIPermission.Toolbar )
	-- 信息查询窗口事件
	SIMainbar.RegisterToolbarButton( SIFinder.Toolbar )
	-- 黄图的管理窗口事件
	SIMainbar.RegisterToolbarButton( SIOreMap.Toolbar )
	-- 紫图的管理窗口事件
	SIMainbar.RegisterToolbarButton( SIRequestMap.Toolbar )
end )
.Load( function( functionID )
	-- 权限管理窗口事件
	SIMainbar.RegisterToolbarButton( SIPermission.Toolbar )
	-- 信息查询窗口事件
	SIMainbar.RegisterToolbarButton( SIFinder.Toolbar )
	-- 黄图的管理窗口事件
	SIMainbar.RegisterToolbarButton( SIOreMap.Toolbar )
	-- 紫图的管理窗口事件
	SIMainbar.RegisterToolbarButton( SIRequestMap.Toolbar )
end )
.AddNth( 60 , function( event , functionID )
	-- 主面板事件
	SIMainbar.FreshFrameAll_Tick()
end )
.Add( SIConstants_Core.raw.Inputs.OreMapFrame , function( event , functionID )
	local playerIndex = event.player_index
	-- 黄图的管理窗口事件
	if SIPermission.HasPermission( SIPermission.PermissionIDs.OreMap , playerIndex ) then
		SIOreMap.OpenFrame( playerIndex )
	end
end )
.Add( SIConstants_Core.raw.Inputs.RequestMapFrame , function( event , functionID )
	local playerIndex = event.player_index
	-- 紫图的管理窗口事件
	if SIPermission.HasPermission( SIPermission.PermissionIDs.RequestMap , playerIndex ) then
	end
end )
.Add( SIEvents.on_player_joined_game , function( event , functionID )
	local playerIndex = event.player_index
	-- 主面板窗口事件
	SIMainbar.OpenFrame( playerIndex )
	-- 权限管理窗口事件
	SIPermission.AddPlayerToBasePremissionGroup( playerIndex )
end )
.Add( SIEvents.on_player_left_game , function( event , functionID )
	local playerIndex = event.player_index
	-- 主面板窗口事件
	SIMainbar.CloseFrame( playerIndex )
	-- 主面板设置管理窗口事件
	SIMainbarSetting.CloseFrame( playerIndex )
	-- 主面板便签管理窗口事件
	SIMainbarNote.CloseFrame( playerIndex )
	-- 主面板消息管理窗口事件
	SIMainbarMessage.CloseFrame( playerIndex )
	-- 权限管理窗口事件
	SIPermission.CloseFrame( playerIndex )
	-- 信息查询窗口事件
	SIFinder.CloseFrame( playerIndex )
	-- 黄图的管理窗口事件
	SIOreMap.CloseFrame( playerIndex )
	-- 紫图的管理窗口事件
	SIRequestMap.CloseFrame( playerIndex )
end )
.Add( SIEvents.on_runtime_mod_setting_changed , function( event , functionID )
	local playerIndex = event.player_index
	-- 主面板窗口事件
	if event.setting_type == SICommon.SettingAffectTypes.PerUser then
		SIMainbar.OpenFrame( playerIndex )
	end
end )
.Add( SIEvents.on_gui_click , function( event , functionID )
	local element = event.element
	if not element.valid then
		return
	end
	local name = element.name
	local playerIndex = event.player_index
	-- 主面板窗口事件
	if name:StartsWith( SIMainbar.Names.Prefix ) then
		if name == SIMainbar.Names.Setting then
			SIMainbarSetting.OpenFrame( playerIndex )
			return
		end
		if name == SIMainbar.Names.Note then
			SIMainbarNote.OpenFrame( playerIndex )
			return
		end
		if name == SIMainbar.Names.Message then
			SIMainbarMessage.OpenFrame( playerIndex )
			return
		end
		if name == SIMainbar.Names.ToolbarOpen then
			SIMainbar.OpenToolbar( playerIndex )
			return
		end
		if name == SIMainbar.Names.ToolbarClose then
			SIMainbar.CloseToolbar( playerIndex )
			return
		end
		if name:StartsWith( SIMainbar.Names.ToolbarButtonPrefix ) then
			SIMainbar.ClicktoolbarButton( playerIndex , name , event.tick )
			return
		end
		if name == SIMainbar.Names.GameSpeed_MAIN then
			if SIPermission.HasPermission( SIPermission.PermissionIDs.GameSpeed , playerIndex ) then
				SIMainbar.ChangeGameSpeed( playerIndex , nil , event.button == defines.mouse_button_type.right )
			else
				SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.GameSpeed ) )
			end
			return
		end
		if name == SIMainbar.Names.GameSpeed_UP1 then
			if SIPermission.HasPermission( SIPermission.PermissionIDs.GameSpeed , playerIndex ) then
				SIMainbar.ChangeGameSpeed( playerIndex , game.speed < 1 and game.speed + 0.1 or game.speed + 1 )
			else
				SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.GameSpeed ) )
			end
			return
		end
		if name == SIMainbar.Names.GameSpeed_UP2 then
			if SIPermission.HasPermission( SIPermission.PermissionIDs.GameSpeed , playerIndex ) then
				SIMainbar.ChangeGameSpeed( playerIndex , game.speed * 2 )
			else
				SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.GameSpeed ) )
			end
			return
		end
		if name == SIMainbar.Names.GameSpeed_DOWN1 then
			if SIPermission.HasPermission( SIPermission.PermissionIDs.GameSpeed , playerIndex ) then
				SIMainbar.ChangeGameSpeed( playerIndex , game.speed < 1 and game.speed - 0.1 or game.speed - 1 )
			else
				SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.GameSpeed ) )
			end
			return
		end
		if name == SIMainbar.Names.GameSpeed_DOWN2 then
			if SIPermission.HasPermission( SIPermission.PermissionIDs.GameSpeed , playerIndex ) then
				SIMainbar.ChangeGameSpeed( playerIndex , game.speed / 2 )
			else
				SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.GameSpeed ) )
			end
			return
		end
		if name == SIMainbar.Names.GameTime then
			NotClick( playerIndex )
			return
		end
		if name == SIMainbar.Names.GameTimeMode then
			SIMainbar.SwitchGameTimeMode( playerIndex )
			return
		end
		return
	end
	-- 主面板设置管理窗口事件
	if name:StartsWith( SIMainbarSetting.Names.Prefix ) then
		if name == SIMainbarSetting.Names.OK then
			SIMainbarSetting.CloseFrame( playerIndex )
			return
		end
		if name == SIMainbarSetting.Names.Close then
			SIMainbarSetting.BackSettings( playerIndex )
			SIMainbarSetting.CloseFrame( playerIndex )
			return
		end
		if name == SIMainbarSetting.Names.Fresh then
			SIMainbar.CloseFrame( playerIndex )
			SIMainbar.OpenFrame( playerIndex )
			return
		end
		if name == SIMainbarSetting.Names.Save then
			SIMainbarSetting.SaveSettings( playerIndex )
			return
		end
		if name == SIMainbarSetting.Names.Back then
			SIMainbarSetting.BackSettings( playerIndex )
			return
		end
		if name == SIMainbarSetting.Names.Reset then
			SIMainbarSetting.ResetSettings( playerIndex )
			return
		end
		return
	end
	-- 主面板便签管理窗口事件
	if name:StartsWith( SIMainbarNote.Names.Prefix ) then
		if name == SIMainbarNote.Names.New then
			SIMainbarNote.ShowEditView( playerIndex )
			return
		end
		if name == SIMainbarNote.Names.Save then
			SIMainbarNote.SaveData( playerIndex )
			return
		end
		if name == SIMainbarNote.Names.Cancel then
			SIMainbarNote.HideEditView( playerIndex )
			return
		end
		if name == SIMainbarNote.Names.SaveAs then
			SIMainbarNote.SaveDataAs( playerIndex )
			return
		end
		if name == SIMainbarNote.Names.Close then
			SIMainbarNote.CloseFrame( playerIndex )
			return
		end
		if name:StartsWith( SIMainbarNote.Names.NotePrefix ) then
			SIMainbarNote.ShowEditFrame( playerIndex , name )
			return
		end
		if name:StartsWith( SIMainbarNote.Names.DeletePrefix ) then
			SIMainbarNote.DeleteData( playerIndex , name )
			return
		end
		return
	end
	-- 主面板消息管理窗口事件
	if name:StartsWith( SIMainbarMessage.Names.Prefix ) then
		if name == SIMainbarMessage.Names.Clear then
			SIMainbarMessage.ClearMessage( playerIndex )
			return
		end
		if name == SIMainbarMessage.Names.Close then
			SIMainbarMessage.CloseFrame( playerIndex )
			return
		end
		if name:StartsWith( SIMainbarMessage.Names.MessagePrefix ) then
			SIMainbarMessage.ReadMessage( playerIndex , name , element )
			return
		end
		return
	end
	-- 权限管理窗口事件
	if name:StartsWith( SIPermission.Names.Prefix ) then
		if name == SIPermission.Names.Close then
			SIPermission.CloseFrame( playerIndex )
			return
		end
		if name == SIPermission.Names.GlobalSave then
			SIPermission.SaveSettings_Global( playerIndex )
			return
		end
		if name == SIPermission.Names.GlobalBack then
			SIPermission.BackSettings_Global( playerIndex )
			return
		end
		if name == SIPermission.Names.GlobalReset then
			SIPermission.ResetSettings_Global( playerIndex )
			return
		end
		if name == SIPermission.Names.PlayerSave then
			SIPermission.SaveSettings_Player( playerIndex )
			return
		end
		if name == SIPermission.Names.PlayerBack then
			SIPermission.BackSettings_Player( playerIndex )
			return
		end
		if name == SIPermission.Names.PlayerClear then
			SIPermission.ClearSettings_Player( playerIndex )
			return
		end
		if name == SIPermission.Names.CheckSave then
			SIPermission.SaveSettings_Check( playerIndex )
			return
		end
		if name == SIPermission.Names.CheckBack then
			SIPermission.BackSettings_Check( playerIndex )
			return
		end
		if name == SIPermission.Names.CheckClear then
			SIPermission.ClearSettings_Check( playerIndex )
			return
		end
		if name:StartsWith( SIPermission.Names.GlobalItemWhitePrefix ) then
			SIPermission.DeleteGlobalItemWhite( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIPermission.Names.GlobalItemBlackPrefix ) then
			SIPermission.DeleteGlobalItemBlack( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIPermission.Names.GlobalItemBluePrefix ) then
			SIPermission.AddGlobalItemWhite( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIPermission.Names.GlobalItemOrangePrefix ) then
			SIPermission.AddGlobalItemBlack( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIPermission.Names.PlayerItemPrefix ) then
			SIPermission.SelectPlayer( playerIndex , name )
			return
		end
		if name:StartsWith( SIPermission.Names.PlayerItemWhitePrefix ) then
			SIPermission.DeletePlayerItemWhite( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIPermission.Names.PlayerItemBlackPrefix ) then
			SIPermission.DeletePlayerItemBlack( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIPermission.Names.PlayerItemBluePrefix ) then
			SIPermission.AddPlayerItemWhite( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIPermission.Names.PlayerItemOrangePrefix ) then
			SIPermission.AddPlayerItemBlack( playerIndex , name , element )
			return
		end
		if name:StartsWith( SIPermission.Names.CheckItemPrefix ) then
			SIPermission.SelectCheck( playerIndex , name )
			return
		end
		return
	end
	-- 信息查询窗口事件
	if name:StartsWith( SIFinder.Names.Prefix ) then
		if name == SIFinder.Names.Close then
			SIFinder.CloseFrame( playerIndex )
			return
		end
		return
	end
	-- 黄图的管理窗口事件
	if name:StartsWith( SIOreMap.Names.Prefix ) then
		if name == SIOreMap.Names.SortName then
			SIOreMap.SortOreDataName( playerIndex )
			return
		end
		if name == SIOreMap.Names.SortCount then
			SIOreMap.SortOreDataCount( playerIndex )
			return
		end
		if name == SIOreMap.Names.Fresh then
			SIOreMap.Fresh( playerIndex )
			return
		end
		if name == SIOreMap.Names.Clean then
			SIOreMap.CleanOreData( playerIndex )
			return
		end
		if name == SIOreMap.Names.Spawn then
			SIOreMap.CreateOre( playerIndex )
			return
		end
		if name == SIOreMap.Names.Close then
			SIOreMap.CloseFrame( playerIndex )
			return
		end
		if name:StartsWith( SIOreMap.Names.IconNamePrefix ) then
			SIOreMap.SelectOre( playerIndex , name )
			return
		end
		return
	end
	-- 紫图的管理窗口事件
	if name:StartsWith( SIRequestMap.Names.Prefix ) then
		if name == SIRequestMap.Names.Close then
			SIRequestMap.CloseFrame( playerIndex )
			return
		end
		if name == SIRequestMap.Names.Add then
			SIRequestMap.Out_AddTabSettings( playerIndex )
			return
		end
		if name == SIRequestMap.Names.Delete then
			SIRequestMap.Out_DeleteTabSettings( playerIndex )
			return
		end
		if name:StartsWith( SIRequestMap.Names.ListButtonPrefix ) then
			SIRequestMap.ListScroll( playerIndex , name )
			return
		end
		return
	end
end )
.Add( SIEvents.on_gui_value_changed , function( event , functionID )
	local element = event.element
	if not element.valid then
		return
	end
	local name = element.name
	local playerIndex = event.player_index
	-- 主面板设置管理窗口事件
	if name == SIMainbarSetting.Names.ToolbarColumn then
		SIMainbarSetting.ChangeToolbarColumn( playerIndex )
		return
	end
end )
.Add( SIEvents.on_gui_confirmed , function( event , functionID )
	local element = event.element
	if not element.valid then
		return
	end
	local name = element.name
	local playerIndex = event.player_index
	-- 主面板设置管理窗口事件
	if name == SIMainbarSetting.Names.ToolbarColumnText then
		SIMainbarSetting.ChangeToolbarColumnText( playerIndex )
		return
	end
	-- 权限管理窗口事件
	if name == SIPermission.Names.GlobalItemFindTextWhite then
		SIPermission.FindAddGlobalItemWhite( playerIndex )
		return
	end
	if name == SIPermission.Names.GlobalItemFindTextBlack then
		SIPermission.FindAddGlobalItemBlack( playerIndex )
		return
	end
	if name == SIPermission.Names.PlayerItemFindTextWhite then
		SIPermission.FindAddPlayerItemWhite( playerIndex )
		return
	end
	if name == SIPermission.Names.PlayerItemFindTextBlack then
		SIPermission.FindAddPlayerItemBlack( playerIndex )
		return
	end
	-- 紫图的管理窗口事件
	if name == SIRequestMap.Names.TabSettingsName then
		SIRequestMap.Set_TabSettingsName( playerIndex , element )
		return
	end
end )
.Add( SIEvents.on_gui_checked_state_changed , function( event , functionID )
	local element = event.element
	if not element.valid then
		return
	end
	local name = element.name
	local playerIndex = event.player_index
	-- 权限管理窗口事件
	if name:StartsWith( SIPermission.Names.GlobalRadioPrefix ) then
		SIPermission.SwitchRadio_Global( playerIndex , name )
		return
	end
	if name:StartsWith( SIPermission.Names.PlayerRadioPrefix ) then
		SIPermission.SwitchRadio_Player( playerIndex , name )
		return
	end
	if name:StartsWith( SIPermission.Names.CheckRadioPrefix ) then
		SIPermission.SwitchRadio_Check( playerIndex , name )
		return
	end
	-- 紫图的管理窗口事件
	if name == SIRequestMap.Names.GreenToBlue_Check then
		SIRequestMap.Set_GreenToBlue_Check( playerIndex , element )
		return
	end
	if name == SIRequestMap.Names.SetModule_FromInventory then
		SIRequestMap.Set_SetModule_FromInventory( playerIndex , element )
		return
	end
	if name == SIRequestMap.Names.RemoveModule_ToInventory then
		SIRequestMap.Set_RemoveModule_ToInventory( playerIndex , element )
		return
	end
	if name:StartsWith( SIRequestMap.Names.EnablePrefix ) then
		SIRequestMap.EnableFunction( playerIndex , name , element )
		return
	end
end )
.Add( SIEvents.on_gui_selection_state_changed , function( event , functionID )
	local element = event.element
	if not element.valid then
		return
	end
	local name = element.name
	local playerIndex = event.player_index
	-- 信息查询窗口事件
	if name == SIFinder.Names.Selector then
		SIFinder.SelectElementType( playerIndex , element.selected_index )
		return
	end
end )
.Add( SIEvents.on_gui_elem_changed , function( event , functionID )
	local element = event.element
	if not element.valid then
		return
	end
	local name = element.name
	local playerIndex = event.player_index
	-- 权限管理窗口事件
	if name == SIPermission.Names.GlobalItemFindWhite then
		SIPermission.AddGlobalItemWhite( playerIndex , element.elem_value , element , true )
		return
	end
	if name == SIPermission.Names.GlobalItemFindBlack then
		SIPermission.AddGlobalItemBlack( playerIndex , element.elem_value , element , true )
		return
	end
	if name == SIPermission.Names.PlayerItemFindWhite then
		SIPermission.AddPlayerItemWhite( playerIndex , element.elem_value , element , true )
		return
	end
	if name == SIPermission.Names.PlayerItemFindBlack then
		SIPermission.AddPlayerItemBlack( playerIndex , element.elem_value , element , true )
		return
	end
	-- 信息查询窗口事件
	if name:StartsWith( SIFinder.Names.ChooserPrefix ) then
		SIFinder.FreshFrame( playerIndex , element.elem_value )
		return
	end
end )
.Add( SIEvents.on_gui_selected_tab_changed , function( event , functionID )
	local element = event.element
	if not element.valid then
		return
	end
	local name = element.name
	local playerIndex = event.player_index
	-- 紫图的管理窗口事件
	if name == SIRequestMap.Names.TabPane then
		SIRequestMap.SwitchTab( playerIndex )
		return
	end
end )
.Add( SIEvents.on_gui_location_changed , function( event , functionID )
	local element = event.element
	if not element.valid then
		return
	end
	local name = element.name
	local playerIndex = event.player_index
	-- 主面板设置管理窗口事件
	if name == SIMainbarSetting.Names.Frame then
		SIMainbarSetting.MoveFrame( playerIndex )
		return
	end
	-- 主面板便签管理窗口事件
	if name == SIMainbarNote.Names.Frame then
		SIMainbarNote.MoveFrame( playerIndex )
		return
	end
	-- 主面板消息管理窗口事件
	if name == SIMainbarMessage.Names.Frame then
		SIMainbarMessage.MoveFrame( playerIndex )
		return
	end
	-- 权限管理窗口事件
	if name == SIPermission.Names.Frame then
		SIPermission.MoveFrame( playerIndex )
		return
	end
	-- 信息查询窗口事件
	if name == SIFinder.Names.Frame then
		SIFinder.MoveFrame( playerIndex )
		return
	end
	-- 黄图的管理窗口事件
	if name == SIOreMap.Names.Frame then
		SIOreMap.MoveFrame( playerIndex )
		return
	end
	-- 紫图的管理窗口事件
	if name == SIRequestMap.Names.Frame then
		SIRequestMap.MoveFrame( playerIndex )
		return
	end
end )

-- ------------------------------------------------------------------------------------------------
-- ---------- 操作事件 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 事件<br>
-- ----------------------------------------
SIEventBus
.Add( SIEvents.on_entity_died , function( event , functionID )
	local causeEntity = event.cause
	if causeEntity and causeEntity.valid then
		-- 主面板窗口事件
		if event.force then
			for index , player in pairs( event.force.players ) do
				SIMainbar.FreshKillCount( player.index )
			end
		end
	end
end )
.Add( SIEvents.on_player_main_inventory_changed , function( event , functionID )
	local playerIndex = event.player_index
	-- 权限管理窗口事件
	SIPermission.CheckPlayerInventory( playerIndex )
end )
.Add( SIEvents.on_surface_created , function( event , functionID )
	local surfaceIndex = event.surface_index
	-- 主面板窗口事件
	SIMainbar.SaveSurfaceTime( surfaceIndex )
end )
.Add( SIEvents.on_surface_deleted , function( event , functionID )
	local surfaceIndex = event.surface_index
	-- 主面板窗口事件
	SIMainbar.RemoveSurfaceTime( surfaceIndex )
end )
.Add( SIEvents.on_surface_renamed , function( event , functionID )
	local surfaceIndex = event.surface_index
	local oldName = event.old_name
	-- 主面板窗口事件
	SIMainbar.ChangeSurfaceTime( surfaceIndex , oldName )
end )
.Add( SIPermission.EventID , function( event , functionID )
	local playerIndex = event.player_index
	local permissionID = event.permission_id
	-- 主面板窗口事件
	SIMainbar.FreshToolbar( playerIndex )
	-- 权限管理窗口事件
	SIPermission.CheckPlayerInventory( playerIndex )
end )

-- ------------------------------------------------------------------------------------------------
-- ------ 调试物品投掷触发 ------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 事件<br>
-- ----------------------------------------
SIEventBus
.Add( SIEvents.on_script_trigger_effect , function( event , functionID )
	local effectID = event.effect_id
	-- 璀璨之闪耀能量罐头
	if effectID == SIConstants_Core.TriggerID.BrightBar then
		local surface = game.get_surface( event.surface_index )
		surface.create_entity{ name = "medium-explosion" , position = event.target_position }
	end
end )

-- ------------------------------------------------------------------------------------------------
-- -------- 特殊工具触发 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 事件<br>
-- ----------------------------------------
SIEventBus
.Add( SIEvents.on_player_selected_area , function( event , functionID )
	local itemName = event.item
	local playerIndex = event.player_index
	-- 粉图
	if itemName == SIConstants_Core.raw.Items.DeleteMap then
		if SIPermission.HasPermission( SIPermission.PermissionIDs.DeleteMap , playerIndex ) then
			local explosionCount = 0
			for index , entity in pairs( event.entities ) do
				if entity.valid and entity.type ~= "character" then
					local surface = entity.surface
					if entity.health then
						if explosionCount < 200 then
							surface.create_entity{ name = "medium-explosion" , position = entity.position }
							explosionCount = explosionCount + 1
						end
						if entity.prototype.corpses then
							for corpseIndex , corpsePrototype in pairs( entity.prototype.corpses ) do
								surface.create_entity{ name = corpsePrototype.name , direction = entity.direction , position = entity.position }
							end
						else
							surface.create_entity{ name = "small-scorchmark" , direction = entity.direction , position = entity.position }
						end
						entity.destroy{ raise_destroy = true }
					elseif entity.type == SICommon.Types.Entities.Cliff then
						if explosionCount < 200 then
							surface.create_entity{ name = "ground-explosion" , position = entity.position }
							explosionCount = explosionCount + 1
						end
						surface.create_entity{ name = "small-scorchmark" , direction = entity.direction , position = entity.position }
						entity.destroy{ do_cliff_correction = true , raise_destroy = true }
					elseif entity.type == SICommon.Types.Entities.Resource then
						if explosionCount < 200 then
							surface.create_entity{ name = "medium-explosion" , position = entity.position }
							explosionCount = explosionCount + 1
						end
						surface.create_entity{ name = "small-scorchmark" , direction = entity.direction , position = entity.position }
						entity.destroy{ raise_destroy = true }
					else
						entity.destroy{ raise_destroy = true }
					end
				end
			end
		else
			SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.DeleteMap ) )
		end
		return
	end
	-- 黄图
	if itemName == SIConstants_Core.raw.Items.OreMap then
		if SIPermission.HasPermission( SIPermission.PermissionIDs.OreMap , playerIndex ) then
			SIOreMap.SaveOre( playerIndex , event.entities )
		else
			SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.OreMap ) )
		end
		return
	end
	-- 紫图
	if itemName == SIConstants_Core.raw.Items.RequestMap then
		if SIPermission.HasPermission( SIPermission.PermissionIDs.RequestMap , playerIndex ) then
			SIRequestMap.EffectSelect1( playerIndex , event.entities )
		else
			SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.RequestMap ) )
		end
		return
	end
end )
.Add( SIEvents.on_player_reverse_selected_area , function( event , functionID )
	local itemName = event.item
	local playerIndex = event.player_index
	-- 粉图
	if itemName == SIConstants_Core.raw.Items.DeleteMap then
		if SIPermission.HasPermission( SIPermission.PermissionIDs.DeleteMap , playerIndex ) then
			local explosionCount = 0
			for index , entity in pairs( event.entities ) do
				if entity.valid and entity.type ~= "character" and entity.health then
					local surface = entity.surface
					if explosionCount < 200 then
						surface.create_entity{ name = "medium-explosion" , position = entity.position }
						explosionCount = explosionCount + 1
					end
					if entity.prototype.corpses then
						for corpseIndex , corpsePrototype in pairs( entity.prototype.corpses ) do
							surface.create_entity{ name = corpsePrototype.name , direction = entity.direction , position = entity.position }
						end
					else
						surface.create_entity{ name = "small-scorchmark" , direction = entity.direction , position = entity.position }
					end
					entity.destroy{ raise_destroy = true }
				end
			end
		else
			SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.DeleteMap ) )
		end
		return
	end
	-- 紫图
	if itemName == SIConstants_Core.raw.Items.RequestMap then
		if SIPermission.HasPermission( SIPermission.PermissionIDs.RequestMap , playerIndex ) then
			SIRequestMap.EffectSelect2( playerIndex , event.entities )
		else
			SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.RequestMap ) )
		end
		return
	end
end )
.Add( SIEvents.on_player_alt_selected_area , function( event , functionID )
	local itemName = event.item
	local playerIndex = event.player_index
	-- 粉图
	if itemName == SIConstants_Core.raw.Items.DeleteMap then
		if SIPermission.HasPermission( SIPermission.PermissionIDs.DeleteMap , playerIndex ) then
			local surface = game.get_player( playerIndex ).surface
			local positionList = {}
			local totalCount = #event.tiles
			for index , tile in pairs( event.tiles ) do
				if #surface.find_entities_filtered{ area = { { tile.position.x , tile.position.y } , { tile.position.x+1 , tile.position.y+1 } } } < 1 then
					surface.set_tiles{ { name = "deepwater" , position = tile.position } }
					if math.random() < 0.07 or index == totalCount then
						table.insert( positionList , { tile.position.x + 0.5 , tile.position.y + 0.5 } )
					end
				end
			end
			local explosionCount = 0
			for index , position in pairs( positionList ) do
				if explosionCount > 200 then
					break
				end
				surface.create_entity{ name = "medium-explosion" , position = position }
				explosionCount = explosionCount + 1
			end
		else
			SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.DeleteMap ) )
		end
		return
	end
	-- 黄图
	if itemName == SIConstants_Core.raw.Items.OreMap then
		if SIPermission.HasPermission( SIPermission.PermissionIDs.OreMap , playerIndex ) then
			SIOreMap.CreateOreByMap( playerIndex , event.tiles )
		else
			SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.OreMap ) )
		end
		return
	end
	-- 紫图
	if itemName == SIConstants_Core.raw.Items.RequestMap then
		if SIPermission.HasPermission( SIPermission.PermissionIDs.RequestMap , playerIndex ) then
			SIRequestMap.EffectSelect3( playerIndex , event.entities )
		else
			SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.RequestMap ) )
		end
		return
	end
end )
.Add( SIEvents.on_player_alt_reverse_selected_area , function( event , functionID )
	local itemName = event.item
	local playerIndex = event.player_index
	-- 粉图
	if itemName == SIConstants_Core.raw.Items.DeleteMap then
		if SIPermission.HasPermission( SIPermission.PermissionIDs.DeleteMap , playerIndex ) then
			local surface = game.get_player( playerIndex ).surface
			for index , tile in pairs( event.tiles ) do
				surface.set_tiles{ { name = "refined-concrete" , position = tile.position } }
			end
		else
			SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.DeleteMap ) )
		end
		return
	end
	-- 紫图
	if itemName == SIConstants_Core.raw.Items.RequestMap then
		if SIPermission.HasPermission( SIPermission.PermissionIDs.RequestMap , playerIndex ) then
			SIRequestMap.EffectSelect4( playerIndex , event.entities )
		else
			SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.RequestMap ) )
		end
		return
	end
end )

-- ------------------------------------------------------------------------------------------------
-- ---------- 外部接口 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 接口注册<br>
-- ----------------------------------------
SINeed( "RemoteInterface" )
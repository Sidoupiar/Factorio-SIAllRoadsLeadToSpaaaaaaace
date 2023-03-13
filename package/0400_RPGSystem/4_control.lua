-- ------------------------------------------------------------------------------------------------
-- ---------- 定义信息 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local EXPItemList = {}
for prefixID , prefixAlias in pairs
{
	Attack = "-战斗" ,
	Adventure = "-探索" ,
	Craft = "-生存"
} do
	for suffixID , suffixAlias in pairs
	{
		_1 = "-1" ,
		_100 = "-100" ,
		_1W = "-1W" ,
		_100W = "-100W" ,
		_1E = "-1E" ,
		_100E = "-100E" ,
		_1WE = "-1WE" ,
	} do
		EXPItemList["EXP_" .. prefixID .. suffixID] = "经验" .. prefixAlias .. suffixAlias
	end
end

SIControl.Init
{
	[SICommon.Types.Items.Item] =
	{
		IconRPG = "图标RPG" ,
		IconAddRed = "图标添加-红" ,
		IconAddGreen = "图标添加-绿" ,
		IconAddCyan = "图标添加-青"
	} ,
	[SICommon.Types.Items.Capsule] = EXPItemList ,
	[SICommon.Types.Entities.Container] =
	{
		EXPChest = "经验箱子"
	} ,
	Styles =
	{
		-- 玩家属性控件样式
		PlayerStatus_Frame = "玩家属性-窗口" ,
		PlayerStatus_LevelList = "玩家属性-等级列表" ,
		PlayerStatus_LevelTitle = "玩家属性-等级标题" ,
		PlayerStatus_LevelLabel = "玩家属性-等级标签" ,
		PlayerStatus_ProgressRed = "玩家属性-进度条-红" ,
		PlayerStatus_ProgressGreen = "玩家属性-进度条-绿" ,
		PlayerStatus_ProgressCyan = "玩家属性-进度条-青" ,
		PlayerStatus_PointLabel = "玩家属性-点数标签" ,
		PlayerStatus_Flow = "玩家属性-布局" ,
		PlayerStatus_BarList = "玩家属性-条列表" ,
		PlayerStatus_ValueList = "玩家属性-数值列表" ,
		PlayerStatus_ListValue = "玩家属性-列表标签数值" ,
		PlayerStatus_ListValueFlow = "玩家属性-列表布局数值" ,
		PlayerStatus_ListValueLeft = "玩家属性-列表标签数值左" ,
		PlayerStatus_ListValueCenter = "玩家属性-列表标签数值中" ,
		PlayerStatus_ListValueRight = "玩家属性-列表标签数值右" ,
		PlayerStatus_ProgressHealth = "玩家属性-进度条-健康值" ,
		PlayerStatus_ProgressStrength = "玩家属性-进度条-体力值" ,
		PlayerStatus_ProgressMana = "玩家属性-进度条-魔法值" ,
		PlayerStatus_ProgressEnergy = "玩家属性-进度条-能量值" ,
		PlayerStatus_ProgressThought = "玩家属性-进度条-精神值" ,
		PlayerStatus_ProgressSoul = "玩家属性-进度条-灵魂值" ,
		PlayerStatus_List = "玩家属性-列表" ,
		PlayerStatus_ListLabelTitleShort = "玩家属性-列表标签标题-短" ,
		PlayerStatus_ListLabelTitleLong = "玩家属性-列表标签标题-长",
		PlayerStatus_ListLabelLevel = "玩家属性-列表标签等级" ,
		PlayerStatus_ListLabelEffect = "玩家属性-列表标签效果" ,
		PlayerStatus_AddingButton = "玩家属性-添加属性按钮" ,
		PlayerStatus_ListFlow = "玩家属性-列表布局" ,
		PlayerStatus_Slider = "玩家属性-滑块" ,
		PlayerStatus_Number = "玩家属性-数字框" ,
		-- 玩家属性迷你控件样式
		PlayerStatusMini_Frame = "玩家属性迷你-窗口" ,
		PlayerStatusMini_Flow = "玩家属性迷你-布局" ,
		PlayerStatusMini_LevelList = "玩家属性迷你-等级列表" ,
		PlayerStatusMini_LevelLabel = "玩家属性迷你-等级标签" ,
		PlayerStatusMini_ProgressRed = "玩家属性迷你-进度条-红" ,
		PlayerStatusMini_ProgressGreen = "玩家属性迷你-进度条-绿" ,
		PlayerStatusMini_ProgressCyan = "玩家属性迷你-进度条-青" ,
		PlayerStatusMini_ButtonFlow = "玩家属性迷你-按钮布局" ,
		PlayerStatusMini_ButtonList = "玩家属性迷你-按钮列表" ,
		PlayerStatusMini_AddingButton = "玩家属性迷你-添加按钮" ,
		-- 玩家信息控件样式
		PlayerInfo_Frame = "玩家信息-窗口" ,
		PlayerInfo_Flow = "玩家信息-布局" ,
		PlayerInfo_ValueList = "玩家信息-数值列表" ,
		PlayerInfo_ListValueFlow = "玩家信息-列表布局数值" ,
		PlayerInfo_ListValueLeft = "玩家信息-列表标签数值左" ,
		PlayerInfo_ListValueCenter = "玩家信息-列表标签数值中" ,
		PlayerInfo_ListValueRight = "玩家信息-列表标签数值右" ,
		PlayerInfo_ProgressHealth = "玩家信息-进度条-健康值" ,
		PlayerInfo_ProgressStrength = "玩家信息-进度条-体力值" ,
		PlayerInfo_ProgressMana = "玩家信息-进度条-魔法值" ,
		PlayerInfo_ProgressEnergy = "玩家信息-进度条-能量值" ,
		PlayerInfo_ProgressThought = "玩家信息-进度条-精神值" ,
		PlayerInfo_ProgressSoul = "玩家信息-进度条-灵魂值" ,
		PlayerInfo_ButtonFlow = "玩家信息-按钮布局" ,
		PlayerInfo_ButtonList = "玩家信息-按钮列表" ,
		PlayerInfo_AddingButton = "玩家信息-添加按钮" ,
		-- 玩家技能控件样式
		PlayerSkill_Frame = "玩家技能-窗口" ,
		PlayerSkill_PointList = "玩家技能-点数列表" ,
		PlayerSkill_PointLabel = "玩家技能-点数标签" ,
		PlayerSkill_SkillList = "玩家技能-技能列表" ,
		PlayerSkill_ListFlowH = "玩家技能-列表布局横" ,
		PlayerSkill_ListFlowV = "玩家技能-列表布局竖" ,
		PlayerSkill_ListFlowPoint = "玩家技能-列表布局点数" ,
		PlayerSkill_ListFlowSlider = "玩家技能-列表布局滑块" ,
		PlayerSkill_SkillItemButtonBlue = "玩家技能-技能物品按钮蓝" ,
		PlayerSkill_SkillItemButtonPurple = "玩家技能-技能物品按钮紫" ,
		PlayerSkill_SkillItemButtonOrange = "玩家技能-技能物品按钮橙" ,
		PlayerSkill_ListTitle = "玩家技能-列表标题" ,
		PlayerSkill_ListDesc = "玩家技能-列表说明" ,
		PlayerSkill_ListPart = "玩家技能-列表部分" ,
		PlayerSkill_ListLevel = "玩家技能-列表等级" ,
		PlayerSkill_ListValue = "玩家技能-列表数值" ,
		PlayerSkill_AddingButton = "玩家技能-添加属性按钮" ,
		PlayerSkill_Slider = "玩家技能-滑块" ,
		PlayerSkill_Number = "玩家技能-数字框" ,
		-- 玩家技能迷你控件样式
		PlayerSkillMini_Frame = "玩家技能迷你-窗口" ,
		PlayerSkillMini_Flow = "玩家技能迷你-布局" ,
		PlayerSkillMini_List = "玩家技能迷你-列表" ,
		PlayerSkillMini_SkillButton = "玩家技能迷你-技能按钮" ,
		PlayerSkillMini_ButtonFlow = "玩家技能迷你-按钮布局" ,
		PlayerSkillMini_ButtonList = "玩家技能迷你-按钮列表" ,
		PlayerSkillMini_AddingButton = "玩家技能迷你-添加按钮" ,
		-- 玩家设置控件样式
		PlayerSetting_Frame = "玩家设置-窗口" ,
		PlayerSetting_LabelTop = "玩家设置-标签顶部" ,
		PlayerSetting_ListTitleFlow = "玩家设置-列表标题布局" ,
		PlayerSetting_ListLabel = "玩家设置-列表标签" ,
		PlayerSetting_ListCheck = "玩家设置-列表复选" ,
		PlayerSetting_ListItemFlow = "玩家设置-列表元素布局" ,
		PlayerSetting_ListPlace = "玩家设置-列表占位" ,
		PlayerSetting_Slider = "玩家设置-滑块" ,
		PlayerSetting_Number = "玩家设置-数字框" ,
		PlayerSetting_DropDown = "玩家设置-下拉列表" ,
		-- 技能面板洞察控件样式
		SkillUI_OverView_Frame = "技能面板-洞察-窗口" ,
		SkillUI_OverView_LabelTitle = "技能面板-洞察-标签标题" ,
		SkillUI_OverView_LabelPoint = "技能面板-洞察-标签坐标" ,
		SkillUI_OverView_PointList = "技能面板-洞察-坐标列表" ,
		SkillUI_OverView_Map_Camera = "技能面板-洞察-地图-相机"
	}
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 初始化<br>
-- ----------------------------------------
SINeed( "System/RPGSystem" )
SINeed( "GUI/PlayerStatus" )
SINeed( "GUI/PlayerStatusMini" )
SINeed( "GUI/PlayerInfo" )
SINeed( "GUI/PlayerSkill" )
SINeed( "GUI/PlayerSkillMini" )
SINeed( "GUI/PlayerSetting" )
SINeed( "GUI/GlobalSetting" )
SINeed( "SkillGUI/OverView" )
SINeed( "SkillGUI/Other" )
SINeed( "Data/RPGSkill" )
SINeed( "Data/RPGRuinItemSet" )
SIGlobal.CreateSettings( SIRPGSystem.Settings )

-- ----------------------------------------
-- 事件<br>
-- ----------------------------------------
SIEventBus
.Init( function( functionID )
	-- 更新特殊列表
	SIRPGSystem.FreshSpecialList()
	-- 注册技能
	SIRPGSystem.AddSkills( SIRPGSkillData )
	-- 添加遗迹物品补给类型
	if SIConstants_RuinControl then
		SIRuinControl.AddItemSet( SIRPGRuinItemSet )
	end
end )
.ConfigurationChange( function( functionID )
	-- 更新特殊列表
	SIRPGSystem.FreshSpecialList()
	-- 注册和更新技能
	SIRPGSystem.AddSkills( SIRPGSkillData )
	SIRPGSystem.FreshSkills( SIRPGSkillData )
	-- 添加遗迹物品补给类型
	if SIConstants_RuinControl then
		SIRuinControl.AddItemSet( SIRPGRuinItemSet )
	end
end )

-- ------------------------------------------------------------------------------------------------
-- ---------- 图形界面 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 事件<br>
-- ----------------------------------------
SIEventBus
.Init( function( functionID )
	-- 玩家属性窗口事件
	SIMainbar.RegisterToolbarButton( SIRPGPlayerStatus.Toolbar )
end )
.Load( function( functionID )
	-- 玩家属性窗口事件
	SIMainbar.RegisterToolbarButton( SIRPGPlayerStatus.Toolbar )
end )
.Add( SIEvents.on_player_joined_game , function( event , functionID )
	local playerIndex = event.player_index
	-- 玩家属性迷你窗口事件
	SIRPGPlayerStatusMini.OpenFrame( playerIndex )
	-- 玩家信息窗口事件
	SIRPGPlayerInfo.OpenFrame( playerIndex )
	-- 玩家技能迷你窗口事件
	SIRPGPlayerSkillMini.OpenFrame( playerIndex )
end )
.Add( SIEvents.on_player_left_game , function( event , functionID )
	local playerIndex = event.player_index
	-- 玩家属性窗口事件
	SIRPGPlayerStatus.CloseFrame( playerIndex )
	-- 玩家属性迷你窗口事件
	SIRPGPlayerStatusMini.CloseFrame( playerIndex )
	-- 玩家信息窗口事件
	SIRPGPlayerInfo.CloseFrame( playerIndex )
	-- 玩家技能窗口事件
	SIRPGPlayerSkill.CloseFrame( playerIndex )
	-- 玩家技能迷你窗口事件
	SIRPGPlayerSkillMini.CloseFrame( playerIndex )
	-- 玩家设置窗口事件
	SIRPGPlayerSetting.CloseFrame( playerIndex )
end )
.Add( SIEvents.on_gui_click , function( event , functionID )
	local element = event.element
	if not element.valid then
		return
	end
	local name = element.name
	local playerIndex = event.player_index
	local left = event.button == defines.mouse_button_type.left
	local right = event.button == defines.mouse_button_type.right
	local alt = event.alt
	local shift = event.shift
	local control = event.control
	-- 玩家属性窗口事件
	if name:StartsWith( SIRPGPlayerStatus.Names.Prefix ) then
		if name == SIRPGPlayerStatus.Names.Open then
			SIRPGPlayerStatus.OpenFrame( playerIndex )
			return
		end
		if name == SIRPGPlayerStatus.Names.Close then
			SIRPGPlayerStatus.CloseFrame( playerIndex )
			return
		end
		if name:StartsWith( SIRPGPlayerStatus.Names.PropertyAddAttackPrefix ) then
			SIRPGPlayerStatus.UsePoint( playerIndex , name:sub( SIRPGPlayerStatus.Names.PropertyAddAttackPosition ) , left , right , alt , shift , control , SIRPGSystem.PointIDs.Attack , SIRPGSystem.UseAttackPointToProperty )
			return
		end
		if name:StartsWith( SIRPGPlayerStatus.Names.PropertyAddAdventurePrefix ) then
			SIRPGPlayerStatus.UsePoint( playerIndex , name:sub( SIRPGPlayerStatus.Names.PropertyAddAdventurePosition ) , left , right , alt , shift , control , SIRPGSystem.PointIDs.Adventure , SIRPGSystem.UseAdventurePointToProperty )
			return
		end
		if name:StartsWith( SIRPGPlayerStatus.Names.PropertyAddCraftPrefix ) then
			SIRPGPlayerStatus.UsePoint( playerIndex , name:sub( SIRPGPlayerStatus.Names.PropertyAddCraftPosition ) , left , right , alt , shift , control , SIRPGSystem.PointIDs.Craft , SIRPGSystem.UseCraftPointToProperty )
			return
		end
		if name:StartsWith( SIRPGPlayerStatus.Names.AdditionAddAttackPrefix ) then
			SIRPGPlayerStatus.UsePoint( playerIndex , name:sub( SIRPGPlayerStatus.Names.AdditionAddAttackPosition ) , left , right , alt , shift , control , SIRPGSystem.PointIDs.Attack , SIRPGSystem.UseAttackPointToAddition )
			return
		end
		if name:StartsWith( SIRPGPlayerStatus.Names.AdditionAddAdventurePrefix ) then
			SIRPGPlayerStatus.UsePoint( playerIndex , name:sub( SIRPGPlayerStatus.Names.AdditionAddAdventurePosition ) , left , right , alt , shift , control , SIRPGSystem.PointIDs.Adventure , SIRPGSystem.UseAdventurePointToAddition )
			return
		end
		if name:StartsWith( SIRPGPlayerStatus.Names.AdditionAddCraftPrefix ) then
			SIRPGPlayerStatus.UsePoint( playerIndex , name:sub( SIRPGPlayerStatus.Names.AdditionAddCraftPosition ) , left , right , alt , shift , control , SIRPGSystem.PointIDs.Craft , SIRPGSystem.UseCraftPointToAddition )
			return
		end
		return
	end
	-- 玩家属性迷你窗口事件
	if name:StartsWith( SIRPGPlayerStatusMini.Names.Prefix ) then
		if name == SIRPGPlayerStatusMini.Names.Open then
			SIRPGPlayerStatusMini.SwitchMini( playerIndex )
			return
		end
		if name == SIRPGPlayerStatusMini.Names.Lock then
			SIRPGPlayerStatusMini.LockFrame( playerIndex )
			return
		end
		if name == SIRPGPlayerStatusMini.Names.OnTop then
			SIRPGPlayerStatusMini.MoveOnTop( playerIndex )
			return
		end
		if name == SIRPGPlayerStatusMini.Names.OnLeft then
			SIRPGPlayerStatusMini.MoveOnLeft( playerIndex )
			return
		end
		if name == SIRPGPlayerStatusMini.Names.ToUp then
			SIRPGPlayerStatusMini.MoveToUp( playerIndex )
			return
		end
		if name == SIRPGPlayerStatusMini.Names.ToRight then
			SIRPGPlayerStatusMini.MoveToRight( playerIndex )
			return
		end
		if name == SIRPGPlayerStatusMini.Names.ToDown then
			SIRPGPlayerStatusMini.MoveToDown( playerIndex )
			return
		end
		if name == SIRPGPlayerStatusMini.Names.ToLeft then
			SIRPGPlayerStatusMini.MoveToLeft( playerIndex )
			return
		end
		return
	end
	-- 玩家信息窗口事件
	if name:StartsWith( SIRPGPlayerInfo.Names.Prefix ) then
		if name == SIRPGPlayerInfo.Names.Open then
			SIRPGPlayerInfo.SwitchInfo( playerIndex )
			return
		end
		if name == SIRPGPlayerInfo.Names.Lock then
			SIRPGPlayerInfo.LockFrame( playerIndex )
			return
		end
		if name == SIRPGPlayerInfo.Names.OnTop then
			SIRPGPlayerInfo.MoveOnTop( playerIndex )
			return
		end
		if name == SIRPGPlayerInfo.Names.OnLeft then
			SIRPGPlayerInfo.MoveOnLeft( playerIndex )
			return
		end
		if name == SIRPGPlayerInfo.Names.ToUp then
			SIRPGPlayerInfo.MoveToUp( playerIndex )
			return
		end
		if name == SIRPGPlayerInfo.Names.ToRight then
			SIRPGPlayerInfo.MoveToRight( playerIndex )
			return
		end
		if name == SIRPGPlayerInfo.Names.ToDown then
			SIRPGPlayerInfo.MoveToDown( playerIndex )
			return
		end
		if name == SIRPGPlayerInfo.Names.ToLeft then
			SIRPGPlayerInfo.MoveToLeft( playerIndex )
			return
		end
		return
	end
	-- 玩家技能窗口事件
	if name:StartsWith( SIRPGPlayerSkill.Names.Prefix ) then
		if name == SIRPGPlayerSkill.Names.Open then
			SIRPGPlayerSkill.OpenFrame( playerIndex )
			return
		end
		if name == SIRPGPlayerSkill.Names.Close then
			SIRPGPlayerSkill.CloseFrame( playerIndex )
			return
		end
		if name == SIRPGPlayerSkill.Names.NoItem then
			NotClick( playerIndex )
			return
		end
		if name:StartsWith( SIRPGPlayerSkill.Names.SkillItemPrefix ) then
			SIRPGPlayerSkill.MakeSkillItem( playerIndex , name , right )
			return
		end
		if name:StartsWith( SIRPGPlayerSkill.Names.SkillAddAttackPrefix ) then
			SIRPGPlayerSkill.UsePoint( playerIndex , name:sub( SIRPGPlayerSkill.Names.SkillAddAttackPosition ) , left , right , alt , shift , control , SIRPGSystem.PointIDs.Attack , SIRPGSystem.UseAttackPointToSkill )
			return
		end
		if name:StartsWith( SIRPGPlayerSkill.Names.SkillAddAdventurePrefix ) then
			SIRPGPlayerSkill.UsePoint( playerIndex , name:sub( SIRPGPlayerSkill.Names.SkillAddAdventurePosition ) , left , right , alt , shift , control , SIRPGSystem.PointIDs.Adventure , SIRPGSystem.UseAdventurePointToSkill )
			return
		end
		if name:StartsWith( SIRPGPlayerSkill.Names.SkillAddCraftPrefix ) then
			SIRPGPlayerSkill.UsePoint( playerIndex , name:sub( SIRPGPlayerSkill.Names.SkillAddCraftPosition ) , left , right , alt , shift , control , SIRPGSystem.PointIDs.Craft , SIRPGSystem.UseCraftPointToSkill )
			return
		end
		return
	end
	-- 玩家技能迷你窗口事件
	if name:StartsWith( SIRPGPlayerSkillMini.Names.Prefix ) then
		if name == SIRPGPlayerSkillMini.Names.Open then
			SIRPGPlayerSkillMini.SwitchMini( playerIndex )
			return
		end
		if name == SIRPGPlayerSkillMini.Names.Lock then
			SIRPGPlayerSkillMini.LockFrame( playerIndex )
			return
		end
		if name == SIRPGPlayerSkillMini.Names.OnTop then
			SIRPGPlayerSkillMini.MoveOnTop( playerIndex )
			return
		end
		if name == SIRPGPlayerSkillMini.Names.OnLeft then
			SIRPGPlayerSkillMini.MoveOnLeft( playerIndex )
			return
		end
		if name == SIRPGPlayerSkillMini.Names.ToUp then
			SIRPGPlayerSkillMini.MoveToUp( playerIndex )
			return
		end
		if name == SIRPGPlayerSkillMini.Names.ToRight then
			SIRPGPlayerSkillMini.MoveToRight( playerIndex )
			return
		end
		if name == SIRPGPlayerSkillMini.Names.ToDown then
			SIRPGPlayerSkillMini.MoveToDown( playerIndex )
			return
		end
		if name == SIRPGPlayerSkillMini.Names.ToLeft then
			SIRPGPlayerSkillMini.MoveToLeft( playerIndex )
			return
		end
		if name:StartsWith( SIRPGPlayerSkillMini.Names.SkillPrefix ) then
			SIRPGPlayerSkillMini.UseSkill( playerIndex , name , right )
			return
		end
		return
	end
	-- 玩家设置窗口事件
	if name:StartsWith( SIRPGPlayerSetting.Names.Prefix ) then
		if name == SIRPGPlayerSetting.Names.Open then
			SIRPGPlayerSetting.OpenFrame( playerIndex )
			return
		end
		if name == SIRPGPlayerSetting.Names.OK then
			SIRPGPlayerSetting.CloseFrame( playerIndex )
			return
		end
		if name == SIRPGPlayerSetting.Names.Close then
			SIRPGPlayerSetting.BackSettings( playerIndex )
			SIRPGPlayerSetting.CloseFrame( playerIndex )
			return
		end
		if name == SIRPGPlayerSetting.Names.Save then
			SIRPGPlayerSetting.SaveSettings( playerIndex )
			return
		end
		if name == SIRPGPlayerSetting.Names.Back then
			SIRPGPlayerSetting.BackSettings( playerIndex )
			return
		end
		if name == SIRPGPlayerSetting.Names.Reset then
			SIRPGPlayerSetting.ResetSettings( playerIndex )
			return
		end
		return
	end
	-- 技能面板洞察窗口事件
	if name:StartsWith( SIRPGSkillUI_OverView.Names.Prefix ) then
		if name == SIRPGSkillUI_OverView.Names.Close then
			SIRPGSkillUI_OverView.CloseFrame( playerIndex )
			return
		end
		if name == SIRPGSkillUI_OverView.Names.Save then
			SIRPGSkillUI_OverView.SavePoint( playerIndex )
			return
		end
		if name:StartsWith( SIRPGSkillUI_OverView.Names.DefaultPrefix ) then
			SIRPGSkillUI_OverView.SwitchDefault( playerIndex , name )
			return
		end
		if name:StartsWith( SIRPGSkillUI_OverView.Names.UsePrefix ) then
			SIRPGSkillUI_OverView.UseSkill( playerIndex , name )
			return
		end
		if name:StartsWith( SIRPGSkillUI_OverView.Names.DeletePrefix ) then
			SIRPGSkillUI_OverView.DeletePoint( playerIndex , name )
			return
		end
		if name:StartsWith( SIRPGSkillUI_OverView.Names.CloseMapPrefix ) then
			SIRPGSkillUI_OverView.CloseMapFrame( playerIndex , name )
			return
		end
		if name:StartsWith( SIRPGSkillUI_OverView.Names.ZoomOutMapPrefix ) then
			SIRPGSkillUI_OverView.ZoomOutMap( playerIndex , name )
			return
		end
		if name:StartsWith( SIRPGSkillUI_OverView.Names.ZoomDefaultMapPrefix ) then
			SIRPGSkillUI_OverView.ZoomDefaultMap( playerIndex , name )
			return
		end
		if name:StartsWith( SIRPGSkillUI_OverView.Names.ZoomInMapPrefix ) then
			SIRPGSkillUI_OverView.ZoomInMap( playerIndex , name )
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
	-- 玩家属性窗口事件
	if name:StartsWith( SIRPGPlayerStatus.Names.PropertyCountPrefix ) then
		SIRPGPlayerStatus.ChangePropertyCount( playerIndex , name )
		return
	end
	if name:StartsWith( SIRPGPlayerStatus.Names.AdditionCountPrefix ) then
		SIRPGPlayerStatus.ChangeAdditionCount( playerIndex , name )
		return
	end
	-- 玩家技能窗口事件
	if name:StartsWith( SIRPGPlayerSkill.Names.SkillCountAttackPrefix ) then
		SIRPGPlayerSkill.ChangeAttackCount( playerIndex , name )
		return
	end
	if name:StartsWith( SIRPGPlayerSkill.Names.SkillCountAdventurePrefix ) then
		SIRPGPlayerSkill.ChangeAdventureCount( playerIndex , name )
		return
	end
	if name:StartsWith( SIRPGPlayerSkill.Names.SkillCountCraftPrefix ) then
		SIRPGPlayerSkill.ChangeCraftCount( playerIndex , name )
		return
	end
	-- 玩家设置窗口事件
	if name == SIRPGPlayerSetting.Names.SkillColumnCount then
		SIRPGPlayerSetting.ChangeSkillColumnCount( playerIndex )
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
	-- 玩家属性窗口事件
	if name:StartsWith( SIRPGPlayerStatus.Names.PropertyCountTextPrefix ) then
		SIRPGPlayerStatus.ChangePropertyCountText( playerIndex , name )
		return
	end
	if name:StartsWith( SIRPGPlayerStatus.Names.AdditionCountTextPrefix ) then
		SIRPGPlayerStatus.ChangeAdditionCountText( playerIndex , name )
		return
	end
	-- 玩家技能窗口事件
	if name:StartsWith( SIRPGPlayerSkill.Names.SkillCountTextAttackPrefix ) then
		SIRPGPlayerSkill.ChangeAttackCountText( playerIndex , name )
		return
	end
	if name:StartsWith( SIRPGPlayerSkill.Names.SkillCountTextAdventurePrefix ) then
		SIRPGPlayerSkill.ChangeAdventureCountText( playerIndex , name )
		return
	end
	if name:StartsWith( SIRPGPlayerSkill.Names.SkillCountTextCraftPrefix ) then
		SIRPGPlayerSkill.ChangeCraftCountText( playerIndex , name )
		return
	end
	-- 玩家设置窗口事件
	if name == SIRPGPlayerSetting.Names.SkillColumnCountText then
		SIRPGPlayerSetting.ChangeSkillColumnCountText( playerIndex )
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
	-- 玩家属性窗口事件
	if name == SIRPGPlayerStatus.Names.Frame then
		SIRPGPlayerStatus.MoveFrame( playerIndex )
		return
	end
	-- 玩家属性迷你窗口事件
	if name == SIRPGPlayerStatusMini.Names.Frame then
		SIRPGPlayerStatusMini.MoveFrame( playerIndex )
		return
	end
	-- 玩家信息窗口事件
	if name == SIRPGPlayerInfo.Names.Frame then
		SIRPGPlayerInfo.MoveFrame( playerIndex )
		return
	end
	-- 玩家技能控件样式
	if name == SIRPGPlayerSkill.Names.Frame then
		SIRPGPlayerSkill.MoveFrame( playerIndex )
		return
	end
	-- 玩家技能迷你窗口事件
	if name == SIRPGPlayerSkillMini.Names.Frame then
		SIRPGPlayerSkillMini.MoveFrame( playerIndex )
		return
	end
	-- 玩家设置窗口事件
	if name == SIRPGPlayerSetting.Names.Frame then
		SIRPGPlayerSetting.MoveFrame( playerIndex )
		return
	end
	-- 技能面板洞察窗口事件
	if name == SIRPGSkillUI_OverView.Names.Frame then
		SIRPGSkillUI_OverView.MoveFrame( playerIndex )
		return
	end
	if name:StartsWith( SIRPGSkillUI_OverView.Names.FrameMapPrefix ) then
		SIRPGSkillUI_OverView.MoveMapFrame( playerIndex , name )
		return
	end
end )
.Add( SIPermission.EventID , function( event , functionID )
	local playerIndex = event.player_index
	local permissionID = event.permission_id
	-- 玩家属性窗口事件
	if permissionID == SIPermission.PermissionIDs.RPGPlayerStatus then
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
			local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
			SIRPGPlayerStatus.FreshProperty( settings , globalSettings )
			SIRPGPlayerStatus.FreshAddition( settings , globalSettings )
		end
		return
	end
	if permissionID == SIPermission.PermissionIDs.RPGPlayerSkill then
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
			SIRPGPlayerSkill.FreshSkill( settings )
		end
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
.Add( SIEvents.on_entity_damaged , function( event , functionID )
	local entity = event.entity
	if not entity or not entity.valid or SIRPGSystem.IsCalculateDamage then
		return
	end
	local damageType = event.damage_type.name
	-- 处理玩家的防御力
	if entity.type == SICommon.Types.Entities.Character then
		local player = entity.player
		local character = entity
		if player and player.valid and player.is_player() then
			local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , player.index )
			local blockValueID = SIRPGSystem.SpecialDefences[damageType]
			if not blockValueID then
				blockValueID = SIRPGSystem.ValueIDs.BlockNormal
			end
			local defenceData = SIRPGSystem.ValueIsDefence[blockValueID]
			local block = settings.Value.Max[blockValueID]
			local resistance = settings.Value.Max[defenceData.Resistance]
			local defence = settings.Value.Max[defenceData.Defence]
			local health = math.min( character.health , event.final_damage_amount )
			local realDamage = math.max( ( health - block ) * math.max( 1 - resistance , 0 ) - defence , 0 )
			if realDamage < health then
				character.health = character.health + health - realDamage
			end
		end
	end
	-- 处理敌人受到的伤害
	local causeEntity = event.cause
	if not causeEntity or not causeEntity.valid then
		return
	end
	local player = nil
	if causeEntity.is_player() then
		player = causeEntity
	elseif causeEntity.type == SICommon.Types.Entities.Character then
		player = causeEntity.player
	elseif causeEntity.type == SICommon.Types.Entities.Car or causeEntity.type == SICommon.Types.Entities.SpiderVehicle then
		local driver = causeEntity.get_driver()
		if driver and driver.valid then
			if driver.is_player() then
				player = driver
			elseif driver.type == SICommon.Types.Entities.Character then
				player = driver.player
			end
		end
	end
	if player and player.valid and player.is_player() then
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , player.index )
		local attackValueID = SIRPGSystem.SpecialDamages[damageType]
		local isNormal = false
		if not attackValueID then
			isNormal = true
			attackValueID = SIRPGSystem.ValueIDs.AttackNormal
		end
		local critData = SIRPGSystem.ValueCanCrit[attackValueID]
		local attack = settings.Value.Max[attackValueID]
		local chance = settings.Value.Max[critData.Chance]
		local damage = settings.Value.Max[critData.Damage]
		local realDamage = event.original_damage_amount + ( isNormal and attack or 0 )
		if math.random() < chance then
			realDamage = realDamage * damage
		end
		if realDamage > event.original_damage_amount then
			SIRPGSystem.IsCalculateDamage = true
			entity.damage( realDamage - event.original_damage_amount , event.force , damageType , causeEntity )
			SIRPGSystem.IsCalculateDamage = false
		end
	end
end )
.Add( SIEvents.on_entity_died , function( event , functionID )
	local diedEntity = event.entity
	if not diedEntity or not diedEntity.valid then
		return
	end
	local causeEntity = event.cause
	if not causeEntity or not causeEntity.valid then
		return
	end
	-- 玩家战斗经验
	if causeEntity.is_player() then
		SIRPGSystem.CreateAttackKillExp( causeEntity , diedEntity )
		return
	elseif causeEntity.type == SICommon.Types.Entities.Character then
		local player = causeEntity.player
		if player and player.valid and player.is_player() then
			SIRPGSystem.CreateAttackKillExp( player , diedEntity )
		end
		return
	elseif causeEntity.type == SICommon.Types.Entities.Car or causeEntity.type == SICommon.Types.Entities.SpiderVehicle then
		local driver = causeEntity.get_driver()
		if driver and driver.valid then
			if driver.is_player() then
				SIRPGSystem.CreateAttackDriveExp( driver , diedEntity , causeEntity )
			elseif driver.type == SICommon.Types.Entities.Character then
				local player = driver.player
				if player.is_player() then
					SIRPGSystem.CreateAttackDriveExp( player , diedEntity , causeEntity )
				end
			end
		end
		return
	end
end )
.Add( SIEvents.on_player_crafted_item , function( event , functionID )
	local itemStack = event.item_stack
	if not itemStack or not itemStack.valid or not itemStack.valid_for_read then
		return
	end
	local playerIndex = event.player_index
	local player = game.get_player( playerIndex )
	-- 玩家生存经验
	SIRPGSystem.CreateCraftRecipeExp( player , event.recipe )
end )
.Add( SIEvents.on_player_mined_entity , function( event , functionID )
	local entity = event.entity
	if not entity or not entity.valid then
		return
	end
	local playerIndex = event.player_index
	local player = game.get_player( playerIndex )
	-- 玩家生存经验
	if entity.type ~= SICommon.Types.Entities.ItemEntity then
		SIRPGSystem.CreateCraftMiningExp( player , entity )
	end
end )
.Add( SIEvents.on_research_finished , function( event , functionID )
	local technology = event.research
	if not technology or not technology.valid then
		return
	end
	local force = technology.force
	-- 玩家属性窗口事件
	SIRPGPlayerStatus.FreshAllAddition( force )
	-- 排除脚本控制的情况
	if event.by_script then
		return
	end
	-- 玩家生存经验
	SIRPGSystem.CreateCraftTechnologyExp( force , technology )
end )
.Add( SIEvents.on_research_reversed , function( event , functionID )
	local technology = event.research
	if not technology or not technology.valid then
		return
	end
	local force = technology.force
	-- 玩家属性窗口事件
	SIRPGPlayerStatus.FreshAllAddition( force )
	-- 不扣除经验值 , 其实是没法扣
end )
.Add( SIEvents.on_player_joined_game , function( event , functionID )
	local playerIndex = event.player_index
	local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
	local player = game.get_player( playerIndex )
	settings.character = player.character
	if settings.character and settings.character.valid then
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		for name , additionID in pairs( SIRPGSystem.AdditionIDs ) do
			SIRPGSystem.FreshAdditionEffect( settings , globalSettings , additionID , 0 )
		end
	end
end )
.Add( SIEvents.on_pre_player_left_game , function( event , functionID )
	local playerIndex = event.player_index
	local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
	if settings.character and settings.character.valid then
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		for name , additionID in pairs( SIRPGSystem.AdditionIDs ) do
			SIRPGSystem.ClearAdditionEffect( settings , globalSettings , additionID )
		end
	end
	settings.character = nil
end )
.Add( SIEvents.on_player_changed_force , function( event , functionID )
	local playerIndex = event.player_index
	local player = game.get_player( playerIndex )
	if not player or not player.valid then
		return
	end
	local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
	if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		SIRPGPlayerStatus.FreshAddition( settings , globalSettings )
	end
end )
.Add( SIEvents.on_player_toggled_map_editor , function( event , functionID )
	local playerIndex = event.player_index
	local player = game.get_player( playerIndex )
	if not player or not player.valid then
		return
	end
	local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
	if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		SIRPGPlayerStatus.FreshAddition( settings , globalSettings )
	end
end )
.Add( SIEvents.on_surface_created , function( event , functionID )
	local surface = game.get_surface( event.surface_index )
	if not surface or not surface.valid then
		return
	end
	-- 技能面板洞察窗口事件
	SIRPGSkillUI_OverView.FreshSurfaceName( surface )
end )

-- ------------------------------------------------------------------------------------------------
-- ---------- 时间流逝 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 事件<br>
-- ----------------------------------------
SIEventBus
.Add( SIEvents.on_tick , function( event , functionID )
	for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIRPGSystem.Settings.Name ) ) do
		-- 标识
		local showStatus = settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid
		local showInfo = settings.PlayerInfo.frame and settings.PlayerInfo.frame.valid
		-- 检测是否更换了角色实体
		local player = game.get_player( playerIndex )
		if player.connected and settings.character ~= player.character then
			local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
			if settings.character and settings.character.valid then
				for name , additionID in pairs( SIRPGSystem.AdditionIDs ) do
					SIRPGSystem.ClearAdditionEffect( settings , globalSettings , additionID )
				end
			end
			settings.character = player.character
			if settings.character and settings.character.valid then
				for name , additionID in pairs( SIRPGSystem.AdditionIDs ) do
					SIRPGSystem.FreshAdditionEffect( settings , globalSettings , additionID , 0 )
				end
			end
			if showStatus then
				SIRPGPlayerStatus.FreshAddition( settings , globalSettings )
			end
		end
		-- 恢复
		local max = settings.Value.Max
		local current = settings.Value.Current
		for valueBarID , valueRegenID in pairs( SIRPGSystem.ValueBarRegen ) do
			local currentValue = current[valueBarID]
			local maxValue = max[valueBarID]
			if currentValue < maxValue then
				current[valueBarID] = math.max( math.min( currentValue + max[valueRegenID] , maxValue ) , 0 )
				if showStatus then
					SIRPGPlayerStatus.FreshValueLine( settings , valueBarID )
				end
				if showInfo then
					SIRPGPlayerInfo.FreshValueLine( settings , valueBarID )
				end
			end
		end
		-- 技能冷却
		for skillID , skillData in pairs( settings.SkillList ) do
			if skillData.Unlock and skillData.Cooldown > 0 then
				skillData.Cooldown = skillData.Cooldown - 1
			end
		end
	end
end )

-- ------------------------------------------------------------------------------------------------
-- ---------- 投掷触发 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 事件<br>
-- ----------------------------------------
SIEventBus
.Add( SIEvents.on_script_trigger_effect , function( event , functionID )
	local source = event.source_entity
	if not source or not source.valid then
		return
	end
	if source.type ~= SICommon.Types.Entities.Character then
		return
	end
	local player = source.player
	if not player.is_player() then
		return
	end
	local effectID = event.effect_id
	-- 经验物品
	if effectID == SIConstants_RPGSystem.ExpTrigger.Attack_1 then
		SIRPGSystem.MakeAttackExp( player.index , 1.0 , true )
		return
	end
	if effectID == SIConstants_RPGSystem.ExpTrigger.Attack_100 then
		SIRPGSystem.MakeAttackExp( player.index , 100.0 , true )
		return
	end
	if effectID == SIConstants_RPGSystem.ExpTrigger.Attack_1W then
		SIRPGSystem.MakeAttackExp( player.index , 10000.0 , true )
		return
	end
	if effectID == SIConstants_RPGSystem.ExpTrigger.Attack_100W then
		SIRPGSystem.MakeAttackExp( player.index , 1000000.0 , true )
		return
	end
	if effectID == SIConstants_RPGSystem.ExpTrigger.Attack_1E then
		SIRPGSystem.MakeAttackExp( player.index , 100000000.0 , true )
		return
	end
	if effectID == SIConstants_RPGSystem.ExpTrigger.Attack_100E then
		SIRPGSystem.MakeAttackExp( player.index , 10000000000.0 , true )
		return
	end
	if effectID == SIConstants_RPGSystem.ExpTrigger.Attack_1WE then
		SIRPGSystem.MakeAttackExp( player.index , 1000000000000.0 , true )
		return
	end
	if effectID == SIConstants_RPGSystem.ExpTrigger.Adventure_1 then
		SIRPGSystem.MakeAdventureExp( player.index , 1.0 , true )
		return
	end
	if effectID == SIConstants_RPGSystem.ExpTrigger.Adventure_100 then
		SIRPGSystem.MakeAdventureExp( player.index , 100.0 , true )
		return
	end
	if effectID == SIConstants_RPGSystem.ExpTrigger.Adventure_1W then
		SIRPGSystem.MakeAdventureExp( player.index , 10000.0 , true )
		return
	end
	if effectID == SIConstants_RPGSystem.ExpTrigger.Adventure_100W then
		SIRPGSystem.MakeAdventureExp( player.index , 1000000.0 , true )
		return
	end
	if effectID == SIConstants_RPGSystem.ExpTrigger.Adventure_1E then
		SIRPGSystem.MakeAdventureExp( player.index , 100000000.0 , true )
		return
	end
	if effectID == SIConstants_RPGSystem.ExpTrigger.Adventure_100E then
		SIRPGSystem.MakeAdventureExp( player.index , 10000000000.0 , true )
		return
	end
	if effectID == SIConstants_RPGSystem.ExpTrigger.Adventure_1WE then
		SIRPGSystem.MakeAdventureExp( player.index , 1000000000000.0 , true )
		return
	end
	if effectID == SIConstants_RPGSystem.ExpTrigger.Craft_1 then
		SIRPGSystem.MakeCraftExp( player.index , 1.0 , true )
		return
	end
	if effectID == SIConstants_RPGSystem.ExpTrigger.Craft_100 then
		SIRPGSystem.MakeCraftExp( player.index , 100.0 , true )
		return
	end
	if effectID == SIConstants_RPGSystem.ExpTrigger.Craft_1W then
		SIRPGSystem.MakeCraftExp( player.index , 10000.0 , true )
		return
	end
	if effectID == SIConstants_RPGSystem.ExpTrigger.Craft_100W then
		SIRPGSystem.MakeCraftExp( player.index , 1000000.0 , true )
		return
	end
	if effectID == SIConstants_RPGSystem.ExpTrigger.Craft_1E then
		SIRPGSystem.MakeCraftExp( player.index , 100000000.0 , true )
		return
	end
	if effectID == SIConstants_RPGSystem.ExpTrigger.Craft_100E then
		SIRPGSystem.MakeCraftExp( player.index , 10000000000.0 , true )
		return
	end
	if effectID == SIConstants_RPGSystem.ExpTrigger.Craft_1WE then
		SIRPGSystem.MakeCraftExp( player.index , 1000000000000.0 , true )
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
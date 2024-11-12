---@class SIRPGPlayerStatus : SIBaseClass
SIRPGPlayerStatus =
{
	ID = "RPGPlayerStatus" ,
	Code = "RPGPlayerStatus" ,
	Show = "RPG玩家属性" ,
	InterfaceID = "SIRPGSystem-PlayerStatus" ,
	Names =
	{
		Prefix = "SIRPG系统-玩家属性-" ,
		Frame = "SIRPG系统-玩家属性-窗口" ,
		Open = "SIRPG系统-玩家属性-打开" ,
		Close = "SIRPG系统-玩家属性-关闭" ,
		PropertyAddAttackPrefix = "SIRPG系统-玩家属性-属性添加战斗-" ,
		PropertyAddAdventurePrefix = "SIRPG系统-玩家属性-属性添加探索-" ,
		PropertyAddCraftPrefix = "SIRPG系统-玩家属性-属性添加生存-" ,
		PropertyCountPrefix = "SIRPG系统-玩家属性-属性滚动-" ,
		PropertyCountTextPrefix = "SIRPG系统-玩家属性-属性输入-" ,
		AdditionAddAttackPrefix = "SIRPG系统-玩家属性-加成添加战斗-" ,
		AdditionAddAdventurePrefix = "SIRPG系统-玩家属性-加成添加探索-" ,
		AdditionAddCraftPrefix = "SIRPG系统-玩家属性-加成添加生存-" ,
		AdditionCountPrefix = "SIRPG系统-玩家属性-加成滚动-" ,
		AdditionCountTextPrefix = "SIRPG系统-玩家属性-加成输入-"
	} ,
	ValueBarStyles =
	{
		Health   = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ProgressHealth ,
		Strength = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ProgressStrength ,
		Mana     = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ProgressMana ,
		Energy   = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ProgressEnergy ,
		Thought  = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ProgressThought ,
		Soul     = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ProgressSoul
	} ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 窗口函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	OpenFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local status = settings.PlayerStatus
		if status.frame and status.frame.valid then
			SIRPGPlayerStatus.CloseFrame( playerIndex )
		else
			local player = game.get_player( playerIndex )
			-- 显示窗口
			local frame = SIElements.CreateFrame( player , status ,
			{
				Name           = SIRPGPlayerStatus.Names.Frame ,
				Mini           = SIRPGPlayerStatusMini.Names.Open ,
				Setting        = SIRPGPlayerSetting.Names.Open ,
				Close          = SIRPGPlayerStatus.Names.Close ,
				Style          = SIConstants_RPGSystem.raw.Styles.PlayerStatus_Frame ,
				Title          = { "SIRPGSystem.玩家属性-窗口-标题" , player.name } ,
				TitleTooltip   = { "SIRPGSystem.玩家属性-窗口-标题-提示" } ,
				UseTooltip     = { "SIRPGSystem.玩家属性-窗口-使用-提示" , globalSettings.EXP.Max } ,
				MiniTooltip    = { "SIRPGSystem.玩家属性-窗口-迷你-提示" } ,
				SettingTooltip = { "SIRPGSystem.玩家属性-窗口-设置-提示" } ,
				CloseTooltip   = { "SIRPGSystem.玩家属性-窗口-关闭-提示" } ,
				OtherButtons   =
				{
					{
						Name    = SIRPGPlayerSkill.Names.Open ,
						Item    = SIConstants_Core.raw.Items.IconStar ,
						Tooltip = { "SIRPGSystem.玩家属性-窗口-技能-提示" } ,
					} ,
					{
						Name    = SIRPGPlayerInfo.Names.Open ,
						Item    = SIConstants_Core.raw.Items.IconDoc ,
						Tooltip = { "SIRPGSystem.玩家属性-窗口-信息-提示" } ,
					}
				}
			} )
			-- 第 1 层
			local flow1 = frame.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
			-- 第 1.1 层
			local listLevel = flow1.add{ type = "table" , column_count = 4 , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_LevelList }
			status.levelLabelAttack = listLevel.add{ type = "label" , caption = { "SIRPGSystem.经验等级-战斗" } , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_LevelTitle }
			status.levelCountAttack = listLevel.add{ type = "label" , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_LevelLabel }
			status.levelProgressAttack = listLevel.add{ type = "progressbar" , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ProgressRed }
			status.pointLabelAttack = listLevel.add{ type = "label" , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_PointLabel }
			status.levelLabelAdventure = listLevel.add{ type = "label" , caption = { "SIRPGSystem.经验等级-探索" } , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_LevelTitle }
			status.levelCountAdventure = listLevel.add{ type = "label" , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_LevelLabel }
			status.levelProgressAdventure = listLevel.add{ type = "progressbar" , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ProgressGreen }
			status.pointLabelAdventure = listLevel.add{ type = "label" , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_PointLabel }
			status.levelLabelCraft = listLevel.add{ type = "label" , caption = { "SIRPGSystem.经验等级-生存" } , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_LevelTitle }
			status.levelCountCraft = listLevel.add{ type = "label" , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_LevelLabel }
			status.levelProgressCraft = listLevel.add{ type = "progressbar" , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ProgressCyan }
			status.pointLabelCraft = listLevel.add{ type = "label" , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_PointLabel }
			-- 第 1.2 层
			-- 暂无
			-- 第 2 层
			frame.add{ type = "line" , direction = "horizontal" }
			-- 第 3 层
			local listBar = frame.add{ type = "table" , column_count = 5 , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_BarList }
			for valueBarID , valueRegenID in pairs( SIRPGSystem.ValueBarRegen ) do
				local valueBarName = SIRPGSystem.ValueNames[valueBarID]
				local valueRegenName = SIRPGSystem.ValueNames[valueRegenID]
				local valueBarTooltip = { "SIRPGSystem.玩家属性-窗口-数值-提示" , valueBarName , SIRPGSystem.ValueTooltips[valueBarID] }
				local valueRegenTooltip = { "SIRPGSystem.玩家属性-窗口-数值-提示" , valueRegenName , SIRPGSystem.ValueTooltips[valueRegenID] }
				status.ValueLabel[valueBarID] = listBar.add{ type = "label" , caption = valueBarName , tooltip = valueBarTooltip , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ListValue }
				local flow = listBar.add{ type = "flow" , direction = "horizontal" , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ListValueFlow }
				status.ValueTextLeft[valueBarID] = flow.add{ type = "label" , tooltip = valueBarTooltip , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ListValueLeft }
				status.ValueTextCenter[valueBarID] = flow.add{ type = "label" , tooltip = valueBarTooltip , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ListValueCenter }
				status.ValueTextRight[valueBarID] = flow.add{ type = "label" , tooltip = valueBarTooltip , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ListValueRight }
				status.ValueBar[valueBarID] = listBar.add{ type = "progressbar" , tooltip = valueBarTooltip , style = SIRPGPlayerStatus.ValueBarStyles[valueBarID] }
				status.ValueLabel[valueRegenID] = listBar.add{ type = "label" , caption = valueRegenName , tooltip = valueRegenTooltip , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ListValue }
				status.ValueText[valueRegenID] = listBar.add{ type = "label" , tooltip = valueRegenTooltip , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ListValue }
			end
			-- 第 4 层
			frame.add{ type = "line" , direction = "horizontal" }
			-- 第 5 层
			local flow5 = frame.add{ type = "flow" , direction = "horizontal" , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_Flow }
			-- 第 5.1 层
			local listAttack = flow5.add{ type = "table" , column_count = 6 , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ValueList }
			for valueAttackID , critData in pairs( SIRPGSystem.ValueCanCrit ) do
				if SIRPGSystem.ValueViewable[valueAttackID] then
					local valueChanceID = critData.Chance
					local valueDamageID = critData.Damage
					local valueAttackName = SIRPGSystem.ValueNames[valueAttackID]
					local valueChanceName = SIRPGSystem.ValueNames[valueChanceID]
					local valueDamageName = SIRPGSystem.ValueNames[valueDamageID]
					local valueAttackTooltip = { "SIRPGSystem.玩家属性-窗口-数值-提示" , valueAttackName , SIRPGSystem.ValueTooltips[valueAttackID] }
					local valueChanceTooltip = { "SIRPGSystem.玩家属性-窗口-数值-提示" , valueChanceName , SIRPGSystem.ValueTooltips[valueAttackID] }
					local valueDamageTooltip = { "SIRPGSystem.玩家属性-窗口-数值-提示" , valueDamageName , SIRPGSystem.ValueTooltips[valueAttackID] }
					status.ValueLabel[valueAttackID] = listAttack.add{ type = "label" , caption = valueAttackName , tooltip = valueAttackTooltip , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ListValue }
					status.ValueText[valueAttackID] = listAttack.add{ type = "label" , tooltip = valueAttackTooltip , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ListValue }
					status.ValueLabel[valueChanceID] = listAttack.add{ type = "label" , caption = valueChanceName , tooltip = valueChanceTooltip , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ListValue }
					status.ValueText[valueChanceID] = listAttack.add{ type = "label" , tooltip = valueChanceTooltip , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ListValue }
					status.ValueLabel[valueDamageID] = listAttack.add{ type = "label" , caption = valueDamageName , tooltip = valueDamageTooltip , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ListValue }
					status.ValueText[valueDamageID] = listAttack.add{ type = "label" , tooltip = valueDamageTooltip , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ListValue }
				end
			end
			-- 第 5.2 层
			flow5.add{ type = "line" , direction = "vertical" }
			-- 第 5.3 层
			local listDefence = flow5.add{ type = "table" , column_count = 6 , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ValueList }
			for valueBlockID , defenceData in pairs( SIRPGSystem.ValueIsDefence ) do
				if SIRPGSystem.ValueViewable[valueBlockID] then
					local valueResistanceID = defenceData.Resistance
					local valueDefenceID = defenceData.Defence
					local valueBlockName = SIRPGSystem.ValueNames[valueBlockID]
					local valueResistanceName = SIRPGSystem.ValueNames[valueResistanceID]
					local valueDefenceName = SIRPGSystem.ValueNames[valueDefenceID]
					local valueBlockTooltip = { "SIRPGSystem.玩家属性-窗口-数值-提示" , valueBlockName , SIRPGSystem.ValueTooltips[valueBlockID] }
					local valueResistanceTooltip = { "SIRPGSystem.玩家属性-窗口-数值-提示" , valueResistanceName , SIRPGSystem.ValueTooltips[valueResistanceID] }
					local valueDefenceTooltip = { "SIRPGSystem.玩家属性-窗口-数值-提示" , valueDefenceName , SIRPGSystem.ValueTooltips[valueDefenceID] }
					status.ValueLabel[valueBlockID] = listDefence.add{ type = "label" , caption = valueBlockName , tooltip = valueBlockTooltip , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ListValue }
					status.ValueText[valueBlockID] = listDefence.add{ type = "label" , tooltip = valueBlockTooltip , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ListValue }
					status.ValueLabel[valueResistanceID] = listDefence.add{ type = "label" , caption = valueResistanceName , tooltip = valueResistanceTooltip , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ListValue }
					status.ValueText[valueResistanceID] = listDefence.add{ type = "label" , tooltip = valueResistanceTooltip , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ListValue }
					status.ValueLabel[valueDefenceID] = listDefence.add{ type = "label" , caption = valueDefenceName , tooltip = valueDefenceTooltip , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ListValue }
					status.ValueText[valueDefenceID] = listDefence.add{ type = "label" , tooltip = valueDefenceTooltip , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ListValue }
				end
			end
			-- 第 6 层
			frame.add{ type = "line" , direction = "horizontal" }
			-- 第 7 层
			local flow7 = frame.add{ type = "flow" , direction = "horizontal" , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_Flow }
			-- 第 7.1 层
			local listProperty = flow7.add{ type = "table" , column_count = 6 , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_List }
			for name , propertyID in pairs( SIRPGSystem.PropertyIDs ) do
				local propertyName = SIRPGSystem.PropertyNames[propertyID]
				status.PropertyName[propertyID] = listProperty.add{ type = "label" , caption = propertyName , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ListLabelTitleShort }
				status.PropertyLevel[propertyID] = listProperty.add{ type = "label" , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ListLabelLevel }
				local button = {}
				button.attack = listProperty.add
				{
					type = "sprite-button" ,
					name = SIRPGPlayerStatus.Names.PropertyAddAttackPrefix .. propertyID ,
					sprite = "item/" .. SIConstants_RPGSystem.raw.Items.IconAddRed ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_AddingButton
				}
				button.adventure = listProperty.add
				{
					type = "sprite-button" ,
					name = SIRPGPlayerStatus.Names.PropertyAddAdventurePrefix .. propertyID ,
					sprite = "item/" .. SIConstants_RPGSystem.raw.Items.IconAddGreen ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_AddingButton
				}
				button.craft = listProperty.add
				{
					type = "sprite-button" ,
					name = SIRPGPlayerStatus.Names.PropertyAddCraftPrefix .. propertyID ,
					sprite = "item/" .. SIConstants_RPGSystem.raw.Items.IconAddCyan ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_AddingButton
				}
				status.PropertyButton[propertyID] = button
				local flowList = listProperty.add{ type = "flow" , direction = "horizontal" , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ListFlow }
				status.PropertyCount[propertyID] = flowList.add
				{
					type = "slider" ,
					name = SIRPGPlayerStatus.Names.PropertyCountPrefix .. propertyID ,
					value_step = 1 ,
					discrete_slider = false ,
					discrete_values = true ,
					tooltip = { "SIRPGSystem.玩家属性-窗口-适用等级-提示" } ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_Slider
				}
				status.PropertyCountText[propertyID] = flowList.add
				{
					type = "textfield" ,
					name = SIRPGPlayerStatus.Names.PropertyCountTextPrefix .. propertyID ,
					numeric = true ,
					tooltip = { "SIRPGSystem.玩家属性-窗口-适用等级文本-提示" } ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_Number
				}
			end
			-- 第 7.2 层
			flow7.add{ type = "line" , direction = "vertical" }
			-- 第 7.3 层
			local listAddition = flow7.add{ type = "table" , column_count = 7 , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_List }
			for name , additionID in pairs( SIRPGSystem.AdditionIDs ) do
				local additionName = SIRPGSystem.AdditionNames[additionID]
				status.AdditionName[additionID] = listAddition.add{ type = "label" , caption = additionName , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ListLabelTitleLong }
				status.AdditionLevel[additionID] = listAddition.add{ type = "label" , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ListLabelLevel }
				status.AdditionEffect[additionID] = listAddition.add{ type = "label" , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ListLabelEffect }
				local button = {}
				button.attack = listAddition.add
				{
					type = "sprite-button" ,
					name = SIRPGPlayerStatus.Names.AdditionAddAttackPrefix .. additionID ,
					sprite = "item/" .. SIConstants_RPGSystem.raw.Items.IconAddRed ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_AddingButton
				}
				button.adventure = listAddition.add
				{
					type = "sprite-button" ,
					name = SIRPGPlayerStatus.Names.AdditionAddAdventurePrefix .. additionID ,
					sprite = "item/" .. SIConstants_RPGSystem.raw.Items.IconAddGreen ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_AddingButton
				}
				button.craft = listAddition.add
				{
					type = "sprite-button" ,
					name = SIRPGPlayerStatus.Names.AdditionAddCraftPrefix .. additionID ,
					sprite = "item/" .. SIConstants_RPGSystem.raw.Items.IconAddCyan ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_AddingButton
				}
				status.AdditionButton[additionID] = button
				local flowList = listAddition.add{ type = "flow" , direction = "horizontal" , style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_ListFlow }
				status.AdditionCount[additionID] = flowList.add
				{
					type = "slider" ,
					name = SIRPGPlayerStatus.Names.AdditionCountPrefix .. additionID ,
					value_step = 1 ,
					discrete_slider = false ,
					discrete_values = true ,
					tooltip = { "SIRPGSystem.玩家属性-窗口-适用等级-提示" } ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_Slider
				}
				status.AdditionCountText[additionID] = flowList.add
				{
					type = "textfield" ,
					name = SIRPGPlayerStatus.Names.AdditionCountTextPrefix .. additionID ,
					numeric = true ,
					tooltip = { "SIRPGSystem.玩家属性-窗口-适用等级文本-提示" } ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerStatus_Number
				}
			end
			-- 根据设置更新控件
			local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
			SIRPGPlayerStatus.FreshLevel( settings )
			SIRPGPlayerStatus.FreshPoint( settings )
			SIRPGPlayerStatus.FreshValue( settings )
			SIRPGPlayerStatus.FreshProperty( settings , globalSettings )
			SIRPGPlayerStatus.FreshAddition( settings , globalSettings )
		end
	end ,
	CloseFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local status = settings.PlayerStatus
		if status.frame and status.frame.valid then
			status.frame.destroy()
			status.frame = nil
			status.levelLabelAttack = nil
			status.levelLabelAdventure = nil
			status.levelLabelCraft = nil
			status.levelCountAttack = nil
			status.levelCountAdventure = nil
			status.levelCountCraft = nil
			status.levelProgressAttack = nil
			status.levelProgressAdventure = nil
			status.levelProgressCraft = nil
			status.pointLabelAttack = nil
			status.pointLabelAdventure = nil
			status.pointLabelCraft = nil
			status.ValueLabel = {}
			status.ValueText = {}
			status.ValueTextLeft = {}
			status.ValueTextCenter = {}
			status.ValueTextRight = {}
			status.ValueBar = {}
			status.ValueRegen = {}
			status.PropertyName = {}
			status.PropertyLevel = {}
			status.PropertyCount = {}
			status.PropertyCountText = {}
			status.PropertyButton = {}
			status.AdditionName = {}
			status.AdditionLevel = {}
			status.AdditionEffect = {}
			status.AdditionCount = {}
			status.AdditionCountText = {}
			status.AdditionButton = {}
		end
	end ,
	MoveFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
			SIElements.SaveFrameLocation( settings.PlayerStatus )
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 控件函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	FreshLevel = function( settings )
		local status = settings.PlayerStatus
		local exp = settings.EXP
		local attackExp = SITools.FormatNumber4( exp.AttackExp )
		local adventureExp = SITools.FormatNumber4( exp.AdventureExp )
		local craftExp = SITools.FormatNumber4( exp.CraftExp )
		local tooltipAttack = { "SIRPGSystem.玩家属性-窗口-经验等级-提示" , { "SIRPGSystem.经验-战斗" } , { "SIRPGSystem.经验-战斗-提示" } , exp.AttackLevel , attackExp , exp.AttackExpMax }
		local tooltipAdventure = { "SIRPGSystem.玩家属性-窗口-经验等级-提示" , { "SIRPGSystem.经验-探索" } , { "SIRPGSystem.经验-探索-提示" } , exp.AdventureLevel , adventureExp , exp.AdventureExpMax }
		local tooltipCraft = { "SIRPGSystem.玩家属性-窗口-经验等级-提示" , { "SIRPGSystem.经验-生存" } , { "SIRPGSystem.经验-生存-提示" } , exp.CraftLevel , craftExp , exp.CraftExpMax }
		status.levelLabelAttack.tooltip = tooltipAttack
		status.levelLabelAdventure.tooltip = tooltipAdventure
		status.levelLabelCraft.tooltip = tooltipCraft
		status.levelCountAttack.caption = { "SIRPGSystem.玩家属性-窗口-经验等级" , exp.AttackLevel }
		status.levelCountAttack.tooltip = tooltipAttack
		status.levelCountAdventure.caption = { "SIRPGSystem.玩家属性-窗口-经验等级" , exp.AdventureLevel }
		status.levelCountAdventure.tooltip = tooltipAdventure
		status.levelCountCraft.caption = { "SIRPGSystem.玩家属性-窗口-经验等级" , exp.CraftLevel }
		status.levelCountCraft.tooltip = tooltipCraft
		status.levelProgressAttack.value = exp.AttackExp / exp.AttackExpMax
		status.levelProgressAttack.tooltip = { "SIRPGSystem.玩家属性-窗口-经验-提示" , { "SIRPGSystem.经验-战斗" } , { "SIRPGSystem.经验-战斗-提示" } , attackExp , exp.AttackExpMax }
		status.levelProgressAdventure.value = exp.AdventureExp / exp.AdventureExpMax
		status.levelProgressAdventure.tooltip = { "SIRPGSystem.玩家属性-窗口-经验-提示" , { "SIRPGSystem.经验-探索" } , { "SIRPGSystem.经验-探索-提示" } , adventureExp , exp.AdventureExpMax }
		status.levelProgressCraft.value = exp.CraftExp / exp.CraftExpMax
		status.levelProgressCraft.tooltip = { "SIRPGSystem.玩家属性-窗口-经验-提示" , { "SIRPGSystem.经验-生存" } , { "SIRPGSystem.经验-生存-提示" } , craftExp , exp.CraftExpMax }
	end ,
	FreshPoint = function( settings )
		local status = settings.PlayerStatus
		local points = settings.Points
		status.pointLabelAttack.caption = { "SIRPGSystem.玩家属性-窗口-点数-战斗" , points.Current.Attack , points.Max.Attack }
		status.pointLabelAttack.tooltip = { "SIRPGSystem.玩家属性-窗口-点数-战斗-提示" , points.Current.Attack , points.Max.Attack }
		status.pointLabelAdventure.caption = { "SIRPGSystem.玩家属性-窗口-点数-探索" , points.Current.Adventure , points.Max.Adventure }
		status.pointLabelAdventure.tooltip = { "SIRPGSystem.玩家属性-窗口-点数-探索-提示" , points.Current.Adventure , points.Max.Adventure }
		status.pointLabelCraft.caption = { "SIRPGSystem.玩家属性-窗口-点数-生存" , points.Current.Craft , points.Max.Craft }
		status.pointLabelCraft.tooltip = { "SIRPGSystem.玩家属性-窗口-点数-生存-提示" , points.Current.Craft , points.Max.Craft }
	end ,
	FreshValue = function( settings )
		for name , valueID in pairs( SIRPGSystem.ValueIDs ) do
			SIRPGPlayerStatus.FreshValueLine( settings , valueID )
		end
	end ,
	FreshValueLine = function( settings , valueID )
		-- 取值
		local status = settings.PlayerStatus
		local value = settings.Value
		local max = value.Max[valueID]
		-- 更新控件
		if SIRPGSystem.ValueViewable[valueID] then
			if SIRPGSystem.ValueBarRegen[valueID] then
				local current = value.Current[valueID]
				status.ValueTextLeft[valueID].caption = { "SIRPGSystem.玩家属性-窗口-数值-进度条-左" , current }
				status.ValueTextCenter[valueID].caption = { "SIRPGSystem.玩家属性-窗口-数值-进度条-分隔符" }
				status.ValueTextRight[valueID].caption = { "SIRPGSystem.玩家属性-窗口-数值-进度条-右" , max }
				status.ValueBar[valueID].value = current / max
			elseif SIRPGSystem.ValueShowPersent[valueID] then
				status.ValueText[valueID].caption = { "SIRPGSystem.玩家属性-窗口-数值-百分比" , max * 100 }
			elseif SIRPGSystem.ValueShowSecond[valueID] then
				status.ValueText[valueID].caption = { "SIRPGSystem.玩家属性-窗口-数值-每秒" , max * 60 }
			else
				status.ValueText[valueID].caption = { "SIRPGSystem.玩家属性-窗口-数值-普通数值" , max }
			end
		end
	end ,
	FreshProperty = function( settings , globalSettings )
		for name , propertyID in pairs( SIRPGSystem.PropertyIDs ) do
			SIRPGPlayerStatus.FreshPropertyLine( settings , globalSettings , propertyID )
		end
	end ,
	FreshPropertyLine = function( settings , globalSettings , propertyID )
		-- 取值
		local status = settings.PlayerStatus
		local property = settings.Property
		local propertyName = SIRPGSystem.PropertyNames[propertyID]
		local propertyTooltip = SIRPGSystem.PropertyTooltips[propertyID]
		local max = property.Max[propertyID]
		local active = property.Active[propertyID]
		-- 生成通用属性
		local levelTooltip = { "SIRPGSystem.玩家属性-等级" , property.Attack[propertyID] , property.Adventure[propertyID] , property.Craft[propertyID] , max }
		local descriptionTooltip = { "SIRPGSystem.玩家属性-窗口-属性说明-提示" , propertyName , propertyTooltip , active , levelTooltip }
		local effectTooltipItems = {}
		local effectTooltip = { "SIRPGSystem.玩家属性-窗口-属性效果-提示" , propertyName , active , levelTooltip , effectTooltipItems }
		local effectProperty = globalSettings.Setting.PropertyEffects[propertyID]
		-- 计算可以显示的属性的数量
		local effectCount = 0
		for valueID , valueCount in pairs( effectProperty ) do
			if SIRPGSystem.ValueViewable[valueID] then
				effectCount = effectCount + 1
			end
		end
		-- 根据可以显示的属性的数量填充本地化文本
		if effectCount < 1 then
			table.insert( effectTooltipItems , "SIRPGSystem.玩家属性-窗口-属性效果-提示-空的" )
		else
			local currentEffectIndex = 0
			for valueID , valueCount in pairs( effectProperty ) do
				if SIRPGSystem.ValueViewable[valueID] then
					currentEffectIndex = currentEffectIndex + 1
					local showPersent = SIRPGSystem.ValueShowPersent[valueID]
					local showSecond = SIRPGSystem.ValueShowSecond[valueID]
					local currentCount = valueCount * ( showPersent and 100 or showSecond and 60 or 1 )
					table.insert( effectTooltipItems , currentEffectIndex < effectCount and "SIRPGSystem.玩家属性-窗口-属性效果-提示-中间" or "SIRPGSystem.玩家属性-窗口-属性效果-提示-末尾" )
					table.insert( effectTooltipItems , SIRPGSystem.ValueNames[valueID] )
					table.insert( effectTooltipItems , showPersent and { "SIRPGSystem.玩家数值-显示-百分比" , currentCount } or showSecond and { "SIRPGSystem.玩家数值-显示-每秒" , currentCount } or { "SIRPGSystem.玩家数值-显示-数值" , currentCount } )
					if currentEffectIndex < effectCount then
						local effectTooltipItemsNew = {}
						table.insert( effectTooltipItems , effectTooltipItemsNew )
						effectTooltipItems = effectTooltipItemsNew
					end
				end
			end
		end
		local mainTooltip = { "SIRPGSystem.玩家属性-窗口-属性-提示" , descriptionTooltip , effectTooltip }
		-- 更新控件
		status.PropertyName[propertyID].tooltip = mainTooltip
		status.PropertyLevel[propertyID].caption = { "SIRPGSystem.玩家属性-窗口-等级" , active , max }
		status.PropertyLevel[propertyID].tooltip = mainTooltip
		-- 修改滑块
		local slider = status.PropertyCount[propertyID]
		local text = status.PropertyCountText[propertyID]
		if max < 1 then
			slider.enabled = false
			slider.slider_value = 0
			text.enabled = false
		else
			slider.enabled = true
			slider.set_slider_minimum_maximum( 0 , max )
			if math.floor( slider.slider_value ) ~= active then
				slider.slider_value = active
			end
			text.enabled = true
		end
		text.text = tostring( active )
		-- 修改按钮
		local button = status.PropertyButton[propertyID]
		button.attack.tooltip = { "SIRPGSystem.玩家属性-窗口-升级-提示" , { "SIRPGSystem.点数-战斗" } , propertyName , descriptionTooltip , effectTooltip }
		button.adventure.tooltip = { "SIRPGSystem.玩家属性-窗口-升级-提示" , { "SIRPGSystem.点数-探索" } , propertyName , descriptionTooltip , effectTooltip }
		button.craft.tooltip = { "SIRPGSystem.玩家属性-窗口-升级-提示" , { "SIRPGSystem.点数-生存" } , propertyName , descriptionTooltip , effectTooltip }
	end ,
	FreshAddition = function( settings , globalSettings )
		for name , additionID in pairs( SIRPGSystem.AdditionIDs ) do
			SIRPGPlayerStatus.FreshAdditionLine( settings , globalSettings , additionID )
		end
	end ,
	FreshAdditionLine = function( settings , globalSettings , additionID )
		local player = game.get_player( settings.playerIndex )
		local status = settings.PlayerStatus
		-- 取值
		local addition = settings.Addition
		local additionName = SIRPGSystem.AdditionNames[additionID]
		local additionTooltip = SIRPGSystem.AdditionTooltips[additionID]
		local effectMessage = SIRPGSystem.AdditionEffectMessages[additionID]
		local showPersent = SIRPGSystem.AdditionEffectsShowPersent[additionID]
		local max = addition.Max[additionID]
		local active = addition.Active[additionID]
		local effectValue = globalSettings.Setting.AdditionEffects[additionID]
		-- 根据玩家的当前状态 , 生成玩家角色属性 , 并修改控件可用状态
		local playerEffectShow = nil
		local noCharacter = false
		if player.character and player.character.valid then
			-- 生成玩家角色属性
			playerEffectShow = player[SIRPGSystem.AdditionEffects[additionID]]
		else
			noCharacter = true
			-- 生成玩家角色属性
			playerEffectShow = { "SIRPGSystem.玩家属性-显示-无效" }
		end
		-- 生成通用属性
		local showMultiplier = showPersent and 100 or 1
		local activeEffectShow = active * effectValue * showMultiplier
		local maxEffectShow = max * effectValue * showMultiplier
		local levelTooltip = { "SIRPGSystem.玩家属性-等级" , addition.Attack[additionID] , addition.Adventure[additionID] , addition.Craft[additionID] , max }
		local oneEffectTooltip = { effectMessage , effectValue * showMultiplier }
		local activeEffectTooltip = { effectMessage , activeEffectShow }
		local maxEffectTooltip = { effectMessage , maxEffectShow }
		playerEffectShow = showPersent and not noCharacter and playerEffectShow * showMultiplier or playerEffectShow
		local forceEffectShow = player.force[SIRPGSystem.AdditionEffectsForce[additionID]] * showMultiplier
		local realEffectTooltip =
		{
			"SIRPGSystem.玩家属性-实际加成" ,
			showPersent and { "SIRPGSystem.玩家属性-显示-百分比" , playerEffectShow } or playerEffectShow ,
			showPersent and { "SIRPGSystem.玩家属性-显示-百分比" , forceEffectShow } or forceEffectShow ,
			{ effectMessage , noCharacter and 0 or playerEffectShow + forceEffectShow }
		}
		local descriptionTooltip = { "SIRPGSystem.玩家属性-窗口-加成说明-提示" , additionName , additionTooltip }
		local effectTooltip = { "SIRPGSystem.玩家属性-窗口-加成效果-提示" , additionName , active , levelTooltip , oneEffectTooltip , activeEffectTooltip , maxEffectTooltip , realEffectTooltip }
		local mainTooltip = { "SIRPGSystem.玩家属性-窗口-加成-提示" , descriptionTooltip , effectTooltip }
		-- 更新控件
		status.AdditionName[additionID].tooltip = mainTooltip
		status.AdditionLevel[additionID].caption = { "SIRPGSystem.玩家属性-窗口-等级" , active , max }
		status.AdditionLevel[additionID].tooltip = mainTooltip
		status.AdditionEffect[additionID].caption = { effectMessage , { "SIRPGSystem.玩家属性-加成效果" , activeEffectShow , maxEffectShow } }
		status.AdditionEffect[additionID].tooltip = mainTooltip
		-- 修改滑块
		local slider = status.AdditionCount[additionID]
		local text = status.AdditionCountText[additionID]
		if noCharacter or max < 1 then
			slider.enabled = false
			slider.slider_value = 0
			text.enabled = false
		else
			slider.enabled = true
			slider.set_slider_minimum_maximum( 0 , max )
			if math.floor( slider.slider_value ) ~= active then
				slider.slider_value = active
			end
			text.enabled = true
		end
		text.text = tostring( active )
		-- 修改按钮
		local button = status.AdditionButton[additionID]
		if noCharacter then
			button.attack.enabled = false
			button.adventure.enabled = false
			button.craft.enabled = false
		else
			button.attack.enabled = true
			button.adventure.enabled = true
			button.craft.enabled = true
		end
		button.attack.tooltip = { "SIRPGSystem.玩家属性-窗口-升级-提示" , { "SIRPGSystem.点数-战斗" } , additionName , descriptionTooltip , effectTooltip }
		button.adventure.tooltip = { "SIRPGSystem.玩家属性-窗口-升级-提示" , { "SIRPGSystem.点数-探索" } , additionName , descriptionTooltip , effectTooltip }
		button.craft.tooltip = { "SIRPGSystem.玩家属性-窗口-升级-提示" , { "SIRPGSystem.点数-生存" } , additionName , descriptionTooltip , effectTooltip }
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
	ChangePropertyCount = function( playerIndex , name )
		if not SIPermission.HasPermission( SIPermission.PermissionIDs.RPGPlayerStatus , playerIndex ) then
			return
		end
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local status = settings.PlayerStatus
		if status.frame and status.frame.valid then
			local propertyID = name:sub( SIRPGPlayerStatus.Names.PropertyCountPosition )
			local count = SITools.AsNumberInt( status.PropertyCount[propertyID].slider_value , 0 , settings.Property.Max[propertyID] )
			local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
			local oldActive = settings.Property.Active[propertyID]
			if oldActive ~= count then
				settings.Property.Active[propertyID] = count
				status.PropertyCountText[propertyID].text = tostring( count )
				SIRPGSystem.FreshPropertyEffect( settings , globalSettings , propertyID , oldActive )
				for valueID , valueCount in pairs( globalSettings.Setting.PropertyEffects[propertyID] ) do
					SIRPGPlayerStatus.FreshValueLine( settings , valueID )
				end
			end
			SIRPGPlayerStatus.FreshPropertyLine( settings , globalSettings , propertyID )
		end
	end ,
	ChangePropertyCountText = function( playerIndex , name )
		if not SIPermission.HasPermission( SIPermission.PermissionIDs.RPGPlayerStatus , playerIndex ) then
			return
		end
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local status = settings.PlayerStatus
		if status.frame and status.frame.valid then
			local propertyID = name:sub( SIRPGPlayerStatus.Names.PropertyCountTextPosition )
			local count = SITools.AsNumberInt( status.PropertyCountText[propertyID].text , 0 , settings.Property.Max[propertyID] )
			local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
			local oldActive = settings.Property.Active[propertyID]
			if oldActive ~= count then
				settings.Property.Active[propertyID] = count
				status.PropertyCount[propertyID].slider_value = count
				SIRPGSystem.FreshPropertyEffect( settings , globalSettings , propertyID , oldActive )
				for valueID , valueCount in pairs( globalSettings.Setting.PropertyEffects[propertyID] ) do
					SIRPGPlayerStatus.FreshValueLine( settings , valueID )
				end
			end
			SIRPGPlayerStatus.FreshPropertyLine( settings , globalSettings , propertyID )
		end
	end ,
	ChangeAdditionCount = function( playerIndex , name )
		if not SIPermission.HasPermission( SIPermission.PermissionIDs.RPGPlayerStatus , playerIndex ) then
			return
		end
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local status = settings.PlayerStatus
		if status.frame and status.frame.valid then
			local additionID = name:sub( SIRPGPlayerStatus.Names.AdditionCountPosition )
			local count = SITools.AsNumberInt( status.AdditionCount[additionID].slider_value , 0 , settings.Addition.Max[additionID] )
			local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
			local oldActive = settings.Addition.Active[additionID]
			if oldActive ~= count then
				settings.Addition.Active[additionID] = count
				status.AdditionCountText[additionID].text = tostring( count )
				SIRPGSystem.FreshAdditionEffect( settings , globalSettings , additionID , oldActive )
			end
			SIRPGPlayerStatus.FreshAdditionLine( settings , globalSettings , additionID )
		end
	end ,
	ChangeAdditionCountText = function( playerIndex , name )
		if not SIPermission.HasPermission( SIPermission.PermissionIDs.RPGPlayerStatus , playerIndex ) then
			return
		end
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local status = settings.PlayerStatus
		if status.frame and status.frame.valid then
			local additionID = name:sub( SIRPGPlayerStatus.Names.AdditionCountTextPosition )
			local count = SITools.AsNumberInt( status.AdditionCountText[additionID].text , 0 , settings.Addition.Max[additionID] )
			local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
			local oldActive = settings.Addition.Active[additionID]
			if oldActive ~= count then
				settings.Addition.Active[additionID] = count
				status.AdditionCount[additionID].slider_value = count
				SIRPGSystem.FreshAdditionEffect( settings , globalSettings , additionID , oldActive )
			end
			SIRPGPlayerStatus.FreshAdditionLine( settings , globalSettings , additionID )
		end
	end ,
	UsePoint = function( playerIndex , ID , left , right , alt , shift , control , pointType , useFunc )
		if not SIPermission.HasPermission( SIPermission.PermissionIDs.RPGPlayerStatus , playerIndex ) then
			SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.RPGPlayerSkill ) )
			return
		end
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local player = game.get_player( playerIndex )
		if not player.character or not player.character.valid then
			if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
				local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
				SIRPGPlayerStatus.FreshAddition( settings , globalSettings )
			end
			return
		end
		local count = 0
		if left then
			if alt then
				count = math.min( settings.Points.Current[pointType] , 10 )
			elseif shift then
				count = math.min( settings.Points.Current[pointType] , 40 )
			elseif control then
				count = math.min( settings.Points.Current[pointType] , 100 )
			else
				count = 1
			end
		elseif right then
			if alt then
				count = math.floor( ( settings.Points.Current[pointType] + 9 ) / 10 )
			elseif shift then
				count = math.floor( ( settings.Points.Current[pointType] + 1 ) / 2 )
			elseif control then
				count = settings.Points.Current[pointType]
			else
				count = math.min( settings.Points.Current[pointType] , 5 )
			end
		end
		if count < 1 then
			return
		end
		useFunc( playerIndex , ID , count )
	end ,
	FreshAllAddition = function( force )
		for index , player in pairs( force.players ) do
			local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , player.index )
			if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
				local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
				SIRPGPlayerStatus.FreshAddition( settings , globalSettings )
			end
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
		SIRPGPlayerStatus.OpenFrame( playerIndex )
	end ,

	-- ======================================================================<br>
	-- 关闭指定玩家的权限管理窗口<br>
	-- ======================================================================<br>
	---@param playerIndex integer -- 玩家索引
	CloseFrameByPlayerIndex = function( playerIndex )
		SIRPGPlayerStatus.CloseFrame( playerIndex )
	end ,

	-- ======================================================================<br>
	-- 打开所有玩家的权限管理窗口<br>
	-- ======================================================================<br>
	OpenFrames = function()
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIRPGSystem.Settings.Name ) ) do
			SIRPGPlayerStatus.OpenFrame( playerIndex )
		end
	end ,

	-- ======================================================================<br>
	-- 关闭所有玩家的权限管理窗口<br>
	-- ======================================================================<br>
	CloseFrames = function()
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIRPGSystem.Settings.Name ) ) do
			SIRPGPlayerStatus.CloseFrame( playerIndex )
		end
	end
}

SIRPGPlayerStatus.Names.PropertyAddAttackPosition = #SIRPGPlayerStatus.Names.PropertyAddAttackPrefix + 1
SIRPGPlayerStatus.Names.PropertyAddAdventurePosition = #SIRPGPlayerStatus.Names.PropertyAddAdventurePrefix + 1
SIRPGPlayerStatus.Names.PropertyAddCraftPosition = #SIRPGPlayerStatus.Names.PropertyAddCraftPrefix + 1
SIRPGPlayerStatus.Names.PropertyCountPosition = #SIRPGPlayerStatus.Names.PropertyCountPrefix + 1
SIRPGPlayerStatus.Names.PropertyCountTextPosition = #SIRPGPlayerStatus.Names.PropertyCountTextPrefix + 1
SIRPGPlayerStatus.Names.AdditionAddAttackPosition = #SIRPGPlayerStatus.Names.AdditionAddAttackPrefix + 1
SIRPGPlayerStatus.Names.AdditionAddAdventurePosition = #SIRPGPlayerStatus.Names.AdditionAddAdventurePrefix + 1
SIRPGPlayerStatus.Names.AdditionAddCraftPosition = #SIRPGPlayerStatus.Names.AdditionAddCraftPrefix + 1
SIRPGPlayerStatus.Names.AdditionCountPosition = #SIRPGPlayerStatus.Names.AdditionCountPrefix + 1
SIRPGPlayerStatus.Names.AdditionCountTextPosition = #SIRPGPlayerStatus.Names.AdditionCountTextPrefix + 1

-- 工具栏按钮数据
SIRPGPlayerStatus.Toolbar =
{
	ID = "SIRPG系统-玩家属性" ,
	Name = "RPG系统-玩家属性" ,
	IconItemName = SIConstants_RPGSystem.raw.Items.IconRPG ,
	LocalizedName = { "SIRPGSystem.玩家属性-工具栏-按钮" } ,
	LocalizedDescription = { "SIRPGSystem.玩家属性-工具栏-提示" } ,
	ActionRemoteInterfaceID = SIRPGPlayerStatus.InterfaceID ,
	ActionRemoteFunctionName = "OpenFrameByPlayerIndex" ,
	Permission = SIPermission.PermissionIDs.RPGPlayerStatus ,
	Order = "SIRPGSystem-PlayerStatus"
}
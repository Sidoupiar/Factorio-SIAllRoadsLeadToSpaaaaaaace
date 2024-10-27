SIRPGPlayerSkill =
{
	ID = "RPGPlayerSkill" ,
	Code = "RPGPlayerSkill" ,
	Show = "RPG玩家技能" ,
	Names =
	{
		Prefix = "SIRPG系统-玩家技能-" ,
		Frame = "SIRPG系统-玩家技能-窗口" ,
		Open = "SIRPG系统-玩家技能-打开" ,
		Close = "SIRPG系统-玩家技能-关闭" ,
		NoItem = "SIRPG系统-玩家技能-无技能物品" ,
		SkillItemPrefix = "SIRPG系统-玩家技能-技能物品-" ,
		SkillAddAttackPrefix = "SIRPG系统-玩家技能-添加战斗-" ,
		SkillCountAttackPrefix = "SIRPG系统-玩家技能-数量战斗-" ,
		SkillCountTextAttackPrefix = "SIRPG系统-玩家技能-文本战斗-" ,
		SkillAddAdventurePrefix = "SIRPG系统-玩家技能-添加探索-" ,
		SkillCountAdventurePrefix = "SIRPG系统-玩家技能-数量探索-" ,
		SkillCountTextAdventurePrefix = "SIRPG系统-玩家技能-文本探索-" ,
		SkillAddCraftPrefix = "SIRPG系统-玩家技能-添加生存-" ,
		SkillCountCraftPrefix = "SIRPG系统-玩家技能-数量生存-" ,
		SkillCountTextCraftPrefix = "SIRPG系统-玩家技能-文本生存-" ,
	} ,
	SkillTabNames =
	{
		Active = { "SIRPGSystem.玩家技能-窗口-面板-主动技能" } ,
		Passive = { "SIRPGSystem.玩家技能-窗口-面板-被动技能" } ,
		Buff = { "SIRPGSystem.玩家技能-窗口-面板-状态技能" } ,
		Special = { "SIRPGSystem.玩家技能-窗口-面板-特殊技能" }
	} ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 窗口函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	OpenFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local skill = settings.PlayerSkill


		--SIRPGSystem.AddSkills( SIRPGSkillData )
		--SIRPGSystem.FreshSkills( SIRPGSkillData )


		if skill.frame and skill.frame.valid then
			SIRPGPlayerSkill.CloseFrame( playerIndex )
		else
			local player = game.get_player( playerIndex )
			-- 显示窗口
			local frame = SIElements.CreateFrame( player , skill ,
			{
				Name         = SIRPGPlayerSkill.Names.Frame ,
				Mini         = SIRPGPlayerSkillMini.Names.Open ,
				Close        = SIRPGPlayerSkill.Names.Close ,
				Style        = SIConstants_RPGSystem.raw.Styles.PlayerSkill_Frame ,
				Title        = { "SIRPGSystem.玩家技能-窗口-标题" , player.name } ,
				TitleTooltip = { "SIRPGSystem.玩家技能-窗口-标题-提示" } ,
				UseTooltip   = { "SIRPGSystem.玩家技能-窗口-使用-提示" } ,
				MiniTooltip  = { "SIRPGSystem.玩家技能-窗口-迷你-提示" } ,
				CloseTooltip = { "SIRPGSystem.玩家技能-窗口-关闭-提示" }
			} )
			-- 第 1 层
			local listPoint = frame.add{ type = "table" , column_count = 3 , style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_PointList }
			skill.pointLabelAttack = listPoint.add{ type = "label" , style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_PointLabel }
			skill.pointLabelAdventure = listPoint.add{ type = "label" , style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_PointLabel }
			skill.pointLabelCraft = listPoint.add{ type = "label" , style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_PointLabel }
			-- 第 2 层
			local tabPane = frame.add{ type = "tabbed-pane" , style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_TabPane }
			local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
			for skillTypeIndex , skillType in pairs( globalSettings.SkillTypeOrderList ) do
				local tab = tabPane.add{ type = "tab" , caption = { "SIRPGSystem.技能类型-" .. skillType } }
				local flow = tabPane.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
				local list = flow
				.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Common_ScrollPane }
				.add{ type = "table" , column_count = 2 , style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_SkillList }
				list.draw_horizontal_lines = true
				list.draw_vertical_lines = true
				skill.List[skillType] = list
				tabPane.add_tab( tab , flow )
			end
			-- 根据设置更新控件
			SIRPGPlayerSkill.FreshPoint( settings )
			SIRPGPlayerSkill.FreshSkill( settings )
		end
	end ,
	CloseFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local skill = settings.PlayerSkill
		if skill.frame and skill.frame.valid then
			skill.frame.destroy()
			skill.frame = nil
			skill.pointLabelAttack = nil
			skill.pointLabelAdventure = nil
			skill.pointLabelCraft = nil
			skill.List = {}
			skill.AttackLevel = {}
			skill.AttackValue = {}
			skill.AttackCount = {}
			skill.AttackCountText = {}
			skill.AdventureLevel = {}
			skill.AdventureValue = {}
			skill.AdventureCount = {}
			skill.AdventureCountText = {}
			skill.CraftLevel = {}
			skill.CraftValue = {}
			skill.CraftCount = {}
			skill.CraftCountText = {}
		end
	end ,
	MoveFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local skill = settings.PlayerSkill
		if skill.frame and skill.frame.valid then
			SIElements.SaveFrameLocation( skill )
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 控件函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	FreshPoint = function( settings )
		local skill = settings.PlayerSkill
		local points = settings.Points
		skill.pointLabelAttack.caption = { "SIRPGSystem.玩家技能-窗口-点数-战斗" , points.Current.Attack , points.Max.Attack }
		skill.pointLabelAttack.tooltip = { "SIRPGSystem.玩家技能-窗口-点数-战斗-提示" , points.Current.Attack , points.Max.Attack }
		skill.pointLabelAdventure.caption = { "SIRPGSystem.玩家技能-窗口-点数-探索" , points.Current.Adventure , points.Max.Adventure }
		skill.pointLabelAdventure.tooltip = { "SIRPGSystem.玩家技能-窗口-点数-探索-提示" , points.Current.Adventure , points.Max.Adventure }
		skill.pointLabelCraft.caption = { "SIRPGSystem.玩家技能-窗口-点数-生存" , points.Current.Craft , points.Max.Craft }
		skill.pointLabelCraft.tooltip = { "SIRPGSystem.玩家技能-窗口-点数-生存-提示" , points.Current.Craft , points.Max.Craft }
	end ,
	FreshSkill = function( settings )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		for skillTypeIndex , skillType in pairs( globalSettings.SkillTypeOrderList ) do
			SIRPGPlayerSkill.FreshSkillType( settings , globalSettings , skillType )
		end
	end ,
	-- ======================================================================
	-- 只创建控件<br>
	-- ======================================================================
	FreshSkillType = function( settings , globalSettings , skillType )
		local skill = settings.PlayerSkill
		local list = skill.List[skillType]
		list.clear()
		local orderSkillDataList = globalSettings.SkillOrderList[skillType]
		if orderSkillDataList then
			for index , globalSkillData in pairs( orderSkillDataList ) do
				local skillID = globalSkillData.ID
				local playerSkillData = settings.SkillList[skillID]
				if playerSkillData.Unlock then
					local isPassive = globalSkillData.IsPassive
					-- 第 1 层
					local flow1 = list.add{ type = "flow" , direction = "vertical" , style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_ListFlowV }
					-- 第 1.1 层
					local skillName = nil
					if globalSkillData.EffectInterface and globalSkillData.EffectFunctionName then
						if remote.interfaces[globalSkillData.EffectInterface] and remote.interfaces[globalSkillData.EffectInterface][globalSkillData.EffectFunctionName] then
							skillName = globalSkillData.Name
						else
							skillName = { "SIRPGSystem.玩家技能-窗口-技能-失效" , globalSkillData.Name }
						end
					else
						skillName = { "SIRPGSystem.玩家技能-窗口-技能-失效" , globalSkillData.Name }
					end
					local costTooltip = nil
					if globalSkillData.Cost then
						local costList = {}
						if globalSkillData.Cost.Value then
							for valueID , valueCount in pairs( globalSkillData.Cost.Value ) do
								table.insert( costList , { "SIRPGSystem.玩家技能-消耗-数值" , SIRPGSystem.ValueNames[valueID] , valueCount } )
							end
						end
						if globalSkillData.Cost.Item then
							for itemName , itemCount in pairs( globalSkillData.Cost.Item ) do
								local item = prototypes.item[itemName]
								if item then
									table.insert( costList , { "SIRPGSystem.玩家技能-消耗-物品" , itemName , item.localised_name , itemCount } )
								else
									table.insert( costList , { "SIRPGSystem.玩家技能-消耗-物品" , itemName , itemName , itemCount } )
								end
							end
						end
						local costCount = #costList
						if costCount < 1 then
							costTooltip = { "SIRPGSystem.玩家技能-消耗-无" }
						else
							local needEnd = costCount > 15
							local costTooltipLine = nil
							for costIndex , costLine in pairs( costList ) do
								if costIndex < costCount then
									if costTooltipLine then
										local newLine = { "SIRPGSystem.玩家技能-消耗-数量-叠加" , costLine }
										table.insert( costTooltipLine , newLine )
										costTooltipLine = newLine
									else
										costTooltipLine = { "SIRPGSystem.玩家技能-消耗-数量-叠加" , costLine }
										costTooltip = costTooltipLine
									end
								else
									if costTooltipLine then
										local newLine = needEnd and { "SIRPGSystem.玩家技能-消耗-数量-叠加" , costLine , { "SIRPGSystem.玩家技能-消耗-数量-结尾" } } or costLine
										table.insert( costTooltipLine , newLine )
									else
										costTooltip = needEnd and { "SIRPGSystem.玩家技能-消耗-数量-叠加" , costLine , { "SIRPGSystem.玩家技能-消耗-数量-结尾" } } or costLine
									end
								end
							end
						end
					else
						costTooltip = { "SIRPGSystem.玩家技能-消耗-无" }
					end
					local skillTooltip = { "SIRPGSystem.玩家技能-窗口-技能-提示" , skillName , globalSkillData.Description , costTooltip }
					local flow11 = flow1.add{ type = "flow" , direction = "horizontal" , style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_ListFlowH }
					flow11.add
					{
						type = "sprite-button" ,
						name = isPassive and SIRPGPlayerSkill.Names.NoItem or SIRPGPlayerSkill.Names.SkillItemPrefix .. skillID ,
						sprite = "item/" .. ( globalSkillData.IconItem and globalSkillData.IconItem or SIConstants_Core.raw.Items.IconStar ) ,
						tooltip = isPassive and { "SIRPGSystem.玩家技能-窗口-技能-物品-被动-提示" } or globalSkillData.SkillItem and { "SIRPGSystem.玩家技能-窗口-技能-物品-提示" } or { "SIRPGSystem.玩家技能-窗口-技能-物品-面板-提示" } ,
						style = isPassive and SIConstants_RPGSystem.raw.Styles.PlayerSkill_SkillItemButtonOrange or globalSkillData.SkillItem and SIConstants_RPGSystem.raw.Styles.PlayerSkill_SkillItemButtonBlue or SIConstants_RPGSystem.raw.Styles.PlayerSkill_SkillItemButtonPurple
					}
					flow11.add{ type = "label" , caption = skillName , tooltip = skillTooltip , style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_ListTitle }
					-- 第 1.2 层
					flow1.add{ type = "label" , caption = globalSkillData.Description , tooltip = skillTooltip , style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_ListDesc }
					-- 第 2 层
					local flow2 = list.add{ type = "flow" , direction = "vertical" , style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_ListFlowV }
					-- 第 2.1 层
					local flow21 = flow2.add{ type = "flow" , direction = "horizontal" , style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_ListFlowPoint }
					local attackTooltip = { "SIRPGSystem.玩家技能-窗口-技能-战斗-提示" , globalSkillData.Attack.Value and { globalSkillData.Attack.Tooltip , globalSkillData.Attack.Value , globalSkillData.Attack.Max } or { globalSkillData.Attack.Tooltip } }
					flow21.add
					{
						type = "label" ,
						caption = { "SIRPGSystem.玩家技能-窗口-技能-战斗" , globalSkillData.Attack.Value and { globalSkillData.Attack.Name , globalSkillData.Attack.Value , globalSkillData.Attack.Max } or { globalSkillData.Attack.Name } } ,
						tooltip = attackTooltip ,
						style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_ListPart
					}
					skill.AttackLevel[skillID] = flow21.add
					{
						type = "label" ,
						tooltip = attackTooltip ,
						style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_ListLevel
					}
					skill.AttackValue[skillID] = flow21.add
					{
						type = "label" ,
						tooltip = attackTooltip ,
						style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_ListValue
					}
					flow21.add
					{
						type = "sprite-button" ,
						name = SIRPGPlayerSkill.Names.SkillAddAttackPrefix .. skillID ,
						sprite = "item/" .. SIConstants_RPGSystem.raw.Items.IconAddRed ,
						tooltip = { "SIRPGSystem.玩家技能-窗口-升级-提示" , { "SIRPGSystem.点数-战斗" } , globalSkillData.Name } ,
						style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_AddingButton
					}
					local flow21Slider = flow21.add{ type = "flow" , direction = "horizontal" , style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_ListFlowSlider }
					skill.AttackCount[skillID] = flow21Slider.add
					{
						type = "slider" ,
						name = SIRPGPlayerSkill.Names.SkillCountAttackPrefix .. skillID ,
						value_step = 1 ,
						discrete_slider = false ,
						discrete_values = true ,
						tooltip = { "SIRPGSystem.玩家技能-窗口-适用等级-提示" } ,
						style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_Slider
					}
					skill.AttackCountText[skillID] = flow21Slider.add
					{
						type = "textfield" ,
						name = SIRPGPlayerSkill.Names.SkillCountTextAttackPrefix .. skillID ,
						numeric = true ,
						tooltip = { "SIRPGSystem.玩家技能-窗口-适用等级文本-提示" } ,
						style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_Number
					}
					-- 第 2.2 层
					local flow22 = flow2.add{ type = "flow" , direction = "horizontal" , style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_ListFlowPoint }
					local adventureTooltip = { "SIRPGSystem.玩家技能-窗口-技能-探索-提示" , globalSkillData.Adventure.Value and { globalSkillData.Adventure.Tooltip , globalSkillData.Adventure.Value , globalSkillData.Adventure.Max } or { globalSkillData.Adventure.Tooltip } }
					flow22.add
					{
						type = "label" ,
						caption = { "SIRPGSystem.玩家技能-窗口-技能-探索" , globalSkillData.Adventure.Value and { globalSkillData.Adventure.Name , globalSkillData.Adventure.Value , globalSkillData.Adventure.Max } or { globalSkillData.Adventure.Name } } ,
						tooltip = adventureTooltip ,
						style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_ListPart
					}
					skill.AdventureLevel[skillID] = flow22.add
					{
						type = "label" ,
						tooltip = adventureTooltip ,
						style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_ListLevel
					}
					skill.AdventureValue[skillID] = flow22.add
					{
						type = "label" ,
						tooltip = adventureTooltip ,
						style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_ListValue
					}
					flow22.add
					{
						type = "sprite-button" ,
						name = SIRPGPlayerSkill.Names.SkillAddAdventurePrefix .. skillID ,
						sprite = "item/" .. SIConstants_RPGSystem.raw.Items.IconAddGreen ,
						tooltip = { "SIRPGSystem.玩家技能-窗口-升级-提示" , { "SIRPGSystem.点数-探索" } , globalSkillData.Name } ,
						style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_AddingButton
					}
					local flow22Slider = flow22.add{ type = "flow" , direction = "horizontal" , style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_ListFlowSlider }
					skill.AdventureCount[skillID] = flow22Slider.add
					{
						type = "slider" ,
						name = SIRPGPlayerSkill.Names.SkillCountAdventurePrefix .. skillID ,
						value_step = 1 ,
						discrete_slider = false ,
						discrete_values = true ,
						tooltip = { "SIRPGSystem.玩家技能-窗口-适用等级-提示" } ,
						style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_Slider
					}
					skill.AdventureCountText[skillID] = flow22Slider.add
					{
						type = "textfield" ,
						name = SIRPGPlayerSkill.Names.SkillCountTextAdventurePrefix .. skillID ,
						numeric = true ,
						tooltip = { "SIRPGSystem.玩家技能-窗口-适用等级文本-提示" } ,
						style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_Number
					}
					-- 第 2.3 层
					local flow23 = flow2.add{ type = "flow" , direction = "horizontal" , style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_ListFlowPoint }
					local craftTooltip = { "SIRPGSystem.玩家技能-窗口-技能-生存-提示" , globalSkillData.Craft.Value and { globalSkillData.Craft.Tooltip , globalSkillData.Craft.Value , globalSkillData.Craft.Max } or { globalSkillData.Craft.Tooltip } }
					flow23.add
					{
						type = "label" ,
						caption = { "SIRPGSystem.玩家技能-窗口-技能-生存" , globalSkillData.Craft.Value and { globalSkillData.Craft.Name , globalSkillData.Craft.Value , globalSkillData.Craft.Max } or { globalSkillData.Craft.Name } } ,
						tooltip = craftTooltip ,
						style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_ListPart
					}
					skill.CraftLevel[skillID] = flow23.add
					{
						type = "label" ,
						tooltip = craftTooltip ,
						style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_ListLevel
					}
					skill.CraftValue[skillID] = flow23.add
					{
						type = "label" ,
						tooltip = craftTooltip ,
						style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_ListValue
					}
					flow23.add
					{
						type = "sprite-button" ,
						name = SIRPGPlayerSkill.Names.SkillAddCraftPrefix .. skillID ,
						sprite = "item/" .. SIConstants_RPGSystem.raw.Items.IconAddCyan ,
						tooltip = { "SIRPGSystem.玩家技能-窗口-升级-提示" , { "SIRPGSystem.点数-生存" } , globalSkillData.Name } ,
						style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_AddingButton
					}
					local flow23Slider = flow23.add{ type = "flow" , direction = "horizontal" , style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_ListFlowSlider }
					skill.CraftCount[skillID] = flow23Slider.add
					{
						type = "slider" ,
						name = SIRPGPlayerSkill.Names.SkillCountCraftPrefix .. skillID ,
						value_step = 1 ,
						discrete_slider = false ,
						discrete_values = true ,
						tooltip = { "SIRPGSystem.玩家技能-窗口-适用等级-提示" } ,
						style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_Slider
					}
					skill.CraftCountText[skillID] = flow23Slider.add
					{
						type = "textfield" ,
						name = SIRPGPlayerSkill.Names.SkillCountTextCraftPrefix .. skillID ,
						numeric = true ,
						tooltip = { "SIRPGSystem.玩家技能-窗口-适用等级文本-提示" } ,
						style = SIConstants_RPGSystem.raw.Styles.PlayerSkill_Number
					}
					SIRPGPlayerSkill.FreshSkillLine( settings , globalSettings , skillID )
				end
			end
		end
	end ,
	-- ======================================================================
	-- 只更新控件的数据<br>
	-- ======================================================================
	FreshSkillLine = function( settings , globalSettings , skillID )
		local skill = settings.PlayerSkill
		local globalSkillData = globalSettings.SkillList[skillID]
		local playerSkillData = settings.SkillList[skillID]
		if playerSkillData.Unlock then
			-- 战斗点数
			local attackMax = playerSkillData.Level.Attack.Max
			local attackActive = playerSkillData.Level.Attack.Active
			local attackSkillValue = globalSkillData.Attack.Value
			skill.AttackLevel[skillID].caption = { "SIRPGSystem.玩家技能-窗口-技能-等级" , attackActive , attackMax }
			skill.AttackValue[skillID].caption = globalSkillData.Attack.ShowValue and attackSkillValue and { globalSkillData.Attack.ShowValue , attackActive * attackSkillValue , attackMax * attackSkillValue } or { "SIRPGSystem.技能显示-默认" }
			local attackSlider = skill.AttackCount[skillID]
			local attackText = skill.AttackCountText[skillID]
			if attackMax < 1 then
				attackSlider.enabled = false
				attackSlider.slider_value = 0
				attackText.enabled = false
			else
				attackSlider.enabled = true
				attackSlider.set_slider_minimum_maximum( 0 , attackMax )
				if math.floor( attackSlider.slider_value ) ~= attackActive then
					attackSlider.slider_value = attackActive
				end
				attackText.enabled = true
			end
			attackText.text = tostring( attackActive )
			-- 探索点数
			local adventureMax = playerSkillData.Level.Adventure.Max
			local adventureActive = playerSkillData.Level.Adventure.Active
			local adventureSkillValue = globalSkillData.Adventure.Value
			skill.AdventureLevel[skillID].caption = { "SIRPGSystem.玩家技能-窗口-技能-等级" , adventureActive , adventureMax }
			skill.AdventureValue[skillID].caption = globalSkillData.Adventure.ShowValue and adventureSkillValue and { globalSkillData.Adventure.ShowValue , adventureActive * adventureSkillValue , adventureMax * adventureSkillValue } or { "SIRPGSystem.技能显示-默认" }
			local adventureSlider = skill.AdventureCount[skillID]
			local adventureText = skill.AdventureCountText[skillID]
			if adventureMax < 1 then
				adventureSlider.enabled = false
				adventureSlider.slider_value = 0
				adventureText.enabled = false
			else
				adventureSlider.enabled = true
				adventureSlider.set_slider_minimum_maximum( 0 , adventureMax )
				if math.floor( adventureSlider.slider_value ) ~= adventureActive then
					adventureSlider.slider_value = adventureActive
				end
				adventureText.enabled = true
			end
			adventureText.text = tostring( adventureActive )
			-- 生存点数
			local craftMax = playerSkillData.Level.Craft.Max
			local craftActive = playerSkillData.Level.Craft.Active
			local craftSkillValue = globalSkillData.Craft.Value
			skill.CraftLevel[skillID].caption = { "SIRPGSystem.玩家技能-窗口-技能-等级" , craftActive , craftMax }
			skill.CraftValue[skillID].caption = globalSkillData.Craft.ShowValue and craftSkillValue and { globalSkillData.Craft.ShowValue , craftActive * craftSkillValue , craftMax * craftSkillValue } or { "SIRPGSystem.技能显示-默认" }
			local craftSlider = skill.CraftCount[skillID]
			local craftText = skill.CraftCountText[skillID]
			if craftMax < 1 then
				craftSlider.enabled = false
				craftSlider.slider_value = 0
				craftText.enabled = false
			else
				craftSlider.enabled = true
				craftSlider.set_slider_minimum_maximum( 0 , craftMax )
				if math.floor( craftSlider.slider_value ) ~= craftActive then
					craftSlider.slider_value = craftActive
				end
				craftText.enabled = true
			end
			craftText.text = tostring( craftActive )
		end
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
	ChangeAttackCount = function( playerIndex , name )
		if not SIPermission.HasPermission( SIPermission.PermissionIDs.RPGPlayerSkill , playerIndex ) then
			return
		end
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local skill = settings.PlayerSkill
		if skill.frame and skill.frame.valid then
			local skillID = name:sub( SIRPGPlayerSkill.Names.SkillCountAttackPosition )
			local playerSkillData = settings.SkillList[skillID]
			local count = SITools.AsNumberInt( skill.AttackCount[skillID].slider_value , 0 , playerSkillData.Level.Attack.Max )
			local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
			if playerSkillData.Level.Attack.Active ~= count then
				playerSkillData.Level.Attack.Active = count
				skill.AttackCountText[skillID].text = tostring( count )
				local globalSkillData = globalSettings.SkillList[skillID]
				if globalSkillData.IsPassive then
					SIRPGSystem.FireSkillInterface( playerIndex , globalSkillData , playerSkillData , false )
				end
			end
			SIRPGPlayerSkill.FreshSkillLine( settings , globalSettings , skillID )
		end
	end ,
	ChangeAttackCountText = function( playerIndex , name )
		if not SIPermission.HasPermission( SIPermission.PermissionIDs.RPGPlayerSkill , playerIndex ) then
			return
		end
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local skill = settings.PlayerSkill
		if skill.frame and skill.frame.valid then
			local skillID = name:sub( SIRPGPlayerSkill.Names.SkillCountTextAttackPosition )
			local playerSkillData = settings.SkillList[skillID]
			local count = SITools.AsNumberInt( skill.AttackCountText[skillID].text , 0 , playerSkillData.Level.Attack.Max )
			local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
			if playerSkillData.Level.Attack.Active ~= count then
				playerSkillData.Level.Attack.Active = count
				skill.AttackCount[skillID].slider_value = count
				local globalSkillData = globalSettings.SkillList[skillID]
				if globalSkillData.IsPassive then
					SIRPGSystem.FireSkillInterface( playerIndex , globalSkillData , playerSkillData , false )
				end
			end
			SIRPGPlayerSkill.FreshSkillLine( settings , globalSettings , skillID )
		end
	end ,
	ChangeAdventureCount = function( playerIndex , name )
		if not SIPermission.HasPermission( SIPermission.PermissionIDs.RPGPlayerSkill , playerIndex ) then
			return
		end
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local skill = settings.PlayerSkill
		if skill.frame and skill.frame.valid then
			local skillID = name:sub( SIRPGPlayerSkill.Names.SkillCountAdventurePosition )
			local playerSkillData = settings.SkillList[skillID]
			local count = SITools.AsNumberInt( skill.AdventureCount[skillID].slider_value , 0 , playerSkillData.Level.Adventure.Max )
			local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
			if playerSkillData.Level.Adventure.Active ~= count then
				playerSkillData.Level.Adventure.Active = count
				skill.AdventureCountText[skillID].text = tostring( count )
				local globalSkillData = globalSettings.SkillList[skillID]
				if globalSkillData.IsPassive then
					SIRPGSystem.FireSkillInterface( playerIndex , globalSkillData , playerSkillData , false )
				end
			end
			SIRPGPlayerSkill.FreshSkillLine( settings , globalSettings , skillID )
		end
	end ,
	ChangeAdventureCountText = function( playerIndex , name )
		if not SIPermission.HasPermission( SIPermission.PermissionIDs.RPGPlayerSkill , playerIndex ) then
			return
		end
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local skill = settings.PlayerSkill
		if skill.frame and skill.frame.valid then
			local skillID = name:sub( SIRPGPlayerSkill.Names.SkillCountTextAdventurePosition )
			local playerSkillData = settings.SkillList[skillID]
			local count = SITools.AsNumberInt( skill.AdventureCountText[skillID].text , 0 , playerSkillData.Level.Adventure.Max )
			local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
			if playerSkillData.Level.Adventure.Active ~= count then
				playerSkillData.Level.Adventure.Active = count
				skill.AdventureCount[skillID].slider_value = count
				local globalSkillData = globalSettings.SkillList[skillID]
				if globalSkillData.IsPassive then
					SIRPGSystem.FireSkillInterface( playerIndex , globalSkillData , playerSkillData , false )
				end
			end
			SIRPGPlayerSkill.FreshSkillLine( settings , globalSettings , skillID )
		end
	end ,
	ChangeCraftCount = function( playerIndex , name )
		if not SIPermission.HasPermission( SIPermission.PermissionIDs.RPGPlayerSkill , playerIndex ) then
			return
		end
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local skill = settings.PlayerSkill
		if skill.frame and skill.frame.valid then
			local skillID = name:sub( SIRPGPlayerSkill.Names.SkillCountCraftPosition )
			local playerSkillData = settings.SkillList[skillID]
			local count = SITools.AsNumberInt( skill.CraftCount[skillID].slider_value , 0 , playerSkillData.Level.Craft.Max )
			local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
			if playerSkillData.Level.Craft.Active ~= count then
				playerSkillData.Level.Craft.Active = count
				skill.CraftCountText[skillID].text = tostring( count )
				local globalSkillData = globalSettings.SkillList[skillID]
				if globalSkillData.IsPassive then
					SIRPGSystem.FireSkillInterface( playerIndex , globalSkillData , playerSkillData , false )
				end
			end
			SIRPGPlayerSkill.FreshSkillLine( settings , globalSettings , skillID )
		end
	end ,
	ChangeCraftCountText = function( playerIndex , name )
		if not SIPermission.HasPermission( SIPermission.PermissionIDs.RPGPlayerSkill , playerIndex ) then
			return
		end
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local skill = settings.PlayerSkill
		if skill.frame and skill.frame.valid then
			local skillID = name:sub( SIRPGPlayerSkill.Names.SkillCountTextCraftPosition )
			local playerSkillData = settings.SkillList[skillID]
			local count = SITools.AsNumberInt( skill.CraftCountText[skillID].text , 0 , playerSkillData.Level.Craft.Max )
			local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
			if playerSkillData.Level.Craft.Active ~= count then
				playerSkillData.Level.Craft.Active = count
				skill.CraftCount[skillID].slider_value = count
				local globalSkillData = globalSettings.SkillList[skillID]
				if globalSkillData.IsPassive then
					SIRPGSystem.FireSkillInterface( playerIndex , globalSkillData , playerSkillData , false )
				end
			end
			SIRPGPlayerSkill.FreshSkillLine( settings , globalSettings , skillID )
		end
	end ,
	MakeSkillItem = function( playerIndex , name , right )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		local skillID = name:sub( SIRPGPlayerSkill.Names.SkillItemPosition )
		local playerSkillData = settings.SkillList[skillID]
		local globalSkillData = globalSettings.SkillList[skillID]
		local skillItemName = globalSkillData.SkillItem
		if skillItemName then
			local skillItem = prototypes.item[skillItemName]
			if skillItem then
				local skillItemStack = { name = skillItemName , count = skillItem.stack_size }
				local player = game.get_player( playerIndex )
				local inventory = player.get_main_inventory()
				if inventory and inventory.valid and inventory.can_insert( skillItemStack ) then
					if player.cursor_stack.valid_for_read then
						inventory.insert( skillItemStack )
					else
						player.cursor_stack.swap_stack( skillItemStack )
					end
				else
					SIPrint.Message( playerIndex , { "SIRPGSystem.技能提示-无法获得技能物品" , skillItem.localised_name } )
				end
			else
				SIPrint.Message( playerIndex , { "SIRPGSystem.技能提示-无效技能物品" , skillItemName } )
			end
			return
		end
		if right then
			SIRPGPlayerSkillMini.AddSkillToList( playerIndex , skillID )
		else
			SIRPGSystem.FireSkillInterface( playerIndex , globalSkillData , playerSkillData , false )
		end
	end ,
	UsePoint = function( playerIndex , ID , left , right , alt , shift , control , pointType , useFunc )
		if not SIPermission.HasPermission( SIPermission.PermissionIDs.RPGPlayerSkill , playerIndex ) then
			SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.RPGPlayerSkill ) )
			return
		end
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
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
	end
}

SIRPGPlayerSkill.Names.SkillItemPosition = #SIRPGPlayerSkill.Names.SkillItemPrefix + 1
SIRPGPlayerSkill.Names.SkillAddAttackPosition = #SIRPGPlayerSkill.Names.SkillAddAttackPrefix + 1
SIRPGPlayerSkill.Names.SkillCountAttackPosition = #SIRPGPlayerSkill.Names.SkillCountAttackPrefix + 1
SIRPGPlayerSkill.Names.SkillCountTextAttackPosition = #SIRPGPlayerSkill.Names.SkillCountTextAttackPrefix + 1
SIRPGPlayerSkill.Names.SkillAddAdventurePosition = #SIRPGPlayerSkill.Names.SkillAddAdventurePrefix + 1
SIRPGPlayerSkill.Names.SkillCountAdventurePosition = #SIRPGPlayerSkill.Names.SkillCountAdventurePrefix + 1
SIRPGPlayerSkill.Names.SkillCountTextAdventurePosition = #SIRPGPlayerSkill.Names.SkillCountTextAdventurePrefix + 1
SIRPGPlayerSkill.Names.SkillAddCraftPosition = #SIRPGPlayerSkill.Names.SkillAddCraftPrefix + 1
SIRPGPlayerSkill.Names.SkillCountCraftPosition = #SIRPGPlayerSkill.Names.SkillCountCraftPrefix + 1
SIRPGPlayerSkill.Names.SkillCountTextCraftPosition = #SIRPGPlayerSkill.Names.SkillCountTextCraftPrefix + 1
SIRPGPlayerSkillMini =
{
	ID = "RPGPlayerSkillMini" ,
	Name = "RPG玩家技能迷你" ,
	Names =
	{
		Prefix = "SIRPG系统-玩家技能迷你-" ,
		Frame = "SIRPG系统-玩家技能迷你-窗口" ,
		Open = "SIRPG系统-玩家技能迷你-打开" ,
		Lock = "SIRPG系统-玩家技能迷你-锁定" ,
		OnTop = "SIRPG系统-玩家技能迷你-最顶部" ,
		OnLeft = "SIRPG系统-玩家技能迷你-最左侧" ,
		ToUp = "SIRPG系统-玩家技能迷你-向上方" ,
		ToRight = "SIRPG系统-玩家技能迷你-向右侧" ,
		ToDown = "SIRPG系统-玩家技能迷你-向下方" ,
		ToLeft = "SIRPG系统-玩家技能迷你-向左侧" ,
		SkillPrefix = "SIRPG系统-玩家技能迷你-使用-" ,
	} ,
	ListColumnMin = 4 ,
	ListColumnMax = 20 ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 窗口函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	OpenFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		if settings.PlayerSetting.Base.showPlayerSkillMini then
			local skill = settings.PlayerSkillMini
			if not skill.frame or not skill.frame.valid then
				local player = game.get_player( playerIndex )
				-- 显示窗口
				local frame = SIElements.CreateFrame( player , skill ,
				{
					Name           = SIRPGPlayerSkillMini.Names.Frame ,
					Lock           = SIRPGPlayerSkillMini.Names.Lock ,
					Style          = SIConstants_RPGSystem.raw.Styles.PlayerSkillMini_Frame ,
					Title          = { "SIRPGSystem.玩家技能迷你-窗口-标题" } ,
					TitleTooltip   = { "SIRPGSystem.玩家技能迷你-窗口-标题-提示" } ,
					UseTooltip     = { "SIRPGSystem.玩家技能迷你-窗口-使用-提示" } ,
					LockTooltip    = { "SIRPGSystem.玩家技能迷你-窗口-锁定-提示" } ,
					isLocked       = skill.frameLocked
				} )
				-- 第 1 层
				local flow1 = frame.add{ type = "flow" , direction = "horizontal" , style = SIConstants_RPGSystem.raw.Styles.PlayerSkillMini_Flow }
				-- 第 1.1 层
				skill.list = flow1.add{ type = "table" , column_count = settings.PlayerSetting.Base.skillColumnCount , style = SIConstants_RPGSystem.raw.Styles.PlayerSkillMini_List }
				-- 第 1.2 层
				local flow12 = flow1.add{ type = "flow" , direction = "vertical" , style = SIConstants_RPGSystem.raw.Styles.PlayerSkillMini_ButtonFlow }
				-- 第 1.2.1 层
				local listOnDirection = flow12.add{ type = "table" , column_count = 2 , style = SIConstants_RPGSystem.raw.Styles.PlayerSkillMini_ButtonList }
				local onTop = listOnDirection.add
				{
					type = "sprite-button" ,
					name = SIRPGPlayerSkillMini.Names.OnTop ,
					sprite = "item/" .. SIConstants_Core.raw.Items.IconOnTop ,
					tooltip = { "SIRPGSystem.玩家技能迷你-窗口-最顶部-提示" } ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerSkillMini_AddingButton
				}
				local onLeft = listOnDirection.add
				{
					type = "sprite-button" ,
					name = SIRPGPlayerSkillMini.Names.OnLeft ,
					sprite = "item/" .. SIConstants_Core.raw.Items.IconOnLeft ,
					tooltip = { "SIRPGSystem.玩家技能迷你-窗口-最左侧-提示" } ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerSkillMini_AddingButton
				}
				-- 第 1.2.2 层
				local listToDirection = flow12.add{ type = "table" , column_count = 2 , style = SIConstants_RPGSystem.raw.Styles.PlayerSkillMini_ButtonList }
				local toUp = listToDirection.add
				{
					type = "sprite-button" ,
					name = SIRPGPlayerSkillMini.Names.ToUp ,
					sprite = "item/" .. SIConstants_Core.raw.Items.IconToUp ,
					tooltip = { "SIRPGSystem.玩家技能迷你-窗口-向上方-提示" } ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerSkillMini_AddingButton
				}
				local toRight = listToDirection.add
				{
					type = "sprite-button" ,
					name = SIRPGPlayerSkillMini.Names.ToRight ,
					sprite = "item/" .. SIConstants_Core.raw.Items.IconToRight ,
					tooltip = { "SIRPGSystem.玩家技能迷你-窗口-向右侧-提示" } ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerSkillMini_AddingButton
				}
				local toDown = listToDirection.add
				{
					type = "sprite-button" ,
					name = SIRPGPlayerSkillMini.Names.ToDown ,
					sprite = "item/" .. SIConstants_Core.raw.Items.IconToDown ,
					tooltip = { "SIRPGSystem.玩家技能迷你-窗口-向下方-提示" } ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerSkillMini_AddingButton
				}
				local toLeft = listToDirection.add
				{
					type = "sprite-button" ,
					name = SIRPGPlayerSkillMini.Names.ToLeft ,
					sprite = "item/" .. SIConstants_Core.raw.Items.IconToLeft ,
					tooltip = { "SIRPGSystem.玩家技能迷你-窗口-向左侧-提示" } ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerSkillMini_AddingButton
				}
				-- 根据设置更新控件
				if skill.frameLocked then
					flow12.visible = false
					onTop.enabled = false
					onLeft.enabled = false
					toUp.enabled = false
					toRight.enabled = false
					toDown.enabled = false
					toLeft.enabled = false
				else
					flow12.visible = true
					onTop.enabled = true
					onLeft.enabled = true
					toUp.enabled = true
					toRight.enabled = true
					toDown.enabled = true
					toLeft.enabled = true
				end
				-- 根据设置更新控件
				SIRPGPlayerSkillMini.FreshSkill( settings )
			end
		else
			SIRPGPlayerSkillMini.CloseFrame( playerIndex )
		end
	end ,
	CloseFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local skill = settings.PlayerSkillMini
		if skill.frame and skill.frame.valid then
			skill.frame.destroy()
			skill.frame = nil
			skill.list = nil
		end
	end ,
	MoveFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local skill = settings.PlayerSkillMini
		if skill.frame and skill.frame.valid then
			SIElements.SaveFrameLocation( skill )
		end
	end ,
	LockFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local skill = settings.PlayerSkillMini
		if skill.frame and skill.frame.valid then
			if skill.frameLocked then
				skill.frameLocked = false
			else
				skill.frameLocked = true
			end
			SIRPGPlayerSkillMini.CloseFrame( playerIndex )
			SIRPGPlayerSkillMini.OpenFrame( playerIndex )
		end
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 功能函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	FreshSkill = function( settings )
		local list = settings.PlayerSkillMini.list
		list.clear()
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		for skillTypeIndex , skillType in pairs( globalSettings.SkillTypeOrderList ) do
			local orderSkillDataList = globalSettings.SkillOrderList[skillType]
			if orderSkillDataList then
				for index , globalSkillData in pairs( orderSkillDataList ) do
					local skillID = globalSkillData.ID
					if settings.PlayerSkillMini.SkillList[skillID] then
						local skillName = nil
						if globalSkillData.EffectInterface and globalSkillData.EffectFunctionName then
							if remote.interfaces[globalSkillData.EffectInterface] and remote.interfaces[globalSkillData.EffectInterface][globalSkillData.EffectFunctionName] then
								skillName = globalSkillData.Name
							else
								skillName = { "SIRPGSystem.玩家技能迷你-窗口-技能-失效" , globalSkillData.Name }
							end
						else
							skillName = { "SIRPGSystem.玩家技能迷你-窗口-技能-失效" , globalSkillData.Name }
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
									local item = game.item_prototypes[itemName]
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
						local skillTooltip = { "SIRPGSystem.玩家技能迷你-窗口-技能-提示" , skillName , globalSkillData.Description , costTooltip }
						list.add
						{
							type = "sprite-button" ,
							name = SIRPGPlayerSkillMini.Names.SkillPrefix .. skillID ,
							sprite = "item/" .. ( globalSkillData.IconItem and globalSkillData.IconItem or SIConstants_Core.raw.Items.IconStar ) ,
							tooltip = skillTooltip ,
							style = SIConstants_RPGSystem.raw.Styles.PlayerSkillMini_SkillButton
						}
					end
				end
			end
		end
	end ,
	UseSkill = function( playerIndex , name , right )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		local skillID = name:sub( SIRPGPlayerSkill.Names.SkillItemPosition )
		local playerSkillData = settings.SkillList[skillID]
		local globalSkillData = globalSettings.SkillList[skillID]
		SIRPGSystem.FireSkillInterface( playerIndex , globalSkillData , playerSkillData , right )
	end ,
	AddSkillToList = function( playerIndex , skillID )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local skill = settings.PlayerSkillMini
		if skill.SkillList[skillID] then
			skill.SkillList[skillID] = nil
		else
			skill.SkillList[skillID] = true
		end
		if skill.frame and skill.frame.valid then
			SIRPGPlayerSkillMini.FreshSkill( settings )
		end
	end ,
	SwitchMini = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		if settings.PlayerSetting.Base.showPlayerSkillMini then
			settings.PlayerSetting.Base.showPlayerSkillMini = false
		else
			settings.PlayerSetting.Base.showPlayerSkillMini = true
		end
		SIRPGPlayerSkillMini.OpenFrame( playerIndex )
	end ,
	MoveOnTop = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local skill = settings.PlayerSkillMini
		if skill.frame and skill.frame.valid then
			local location = skill.frame.location
			location.y = 0
			skill.frame.location = location
			SIElements.SaveFrameLocation( skill )
		end
	end ,
	MoveOnLeft = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local skill = settings.PlayerSkillMini
		if skill.frame and skill.frame.valid then
			local location = skill.frame.location
			location.x = 0
			skill.frame.location = location
			SIElements.SaveFrameLocation( skill )
		end
	end ,
	MoveToUp = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local skill = settings.PlayerSkillMini
		if skill.frame and skill.frame.valid then
			local location = skill.frame.location
			location.y = location.y - 1
			skill.frame.location = location
			SIElements.SaveFrameLocation( skill )
		end
	end ,
	MoveToRight = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local skill = settings.PlayerSkillMini
		if skill.frame and skill.frame.valid then
			local location = skill.frame.location
			location.x = location.x + 1
			skill.frame.location = location
			SIElements.SaveFrameLocation( skill )
		end
	end ,
	MoveToDown = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local skill = settings.PlayerSkillMini
		if skill.frame and skill.frame.valid then
			local location = skill.frame.location
			location.y = location.y + 1
			skill.frame.location = location
			SIElements.SaveFrameLocation( skill )
		end
	end ,
	MoveToLeft = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local skill = settings.PlayerSkillMini
		if skill.frame and skill.frame.valid then
			local location = skill.frame.location
			location.x = location.x - 1
			skill.frame.location = location
			SIElements.SaveFrameLocation( skill )
		end
	end
}

SIRPGPlayerSkillMini.Names.SkillPosition = #SIRPGPlayerSkillMini.Names.SkillPrefix + 1
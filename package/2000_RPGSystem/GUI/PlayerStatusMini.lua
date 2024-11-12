---@class SIRPGPlayerStatusMini : SIBaseClass
SIRPGPlayerStatusMini =
{
	ID = "RPGPlayerStatusMini" ,
	Code = "RPGPlayerStatusMini" ,
	Show = "RPG玩家属性迷你" ,
	Names =
	{
		Prefix = "SIRPG系统-玩家属性迷你-" ,
		Frame = "SIRPG系统-玩家属性迷你-窗口" ,
		Open = "SIRPG系统-玩家属性迷你-打开" ,
		Lock = "SIRPG系统-玩家属性迷你-锁定" ,
		Level = "SIRPG系统-玩家属性迷你-玩家属性" ,
		Skill = "SIRPG系统-玩家属性迷你-技能列表" ,
		Info = "SIRPG系统-玩家属性迷你-玩家信息" ,
		Setting = "SIRPG系统-玩家属性迷你-玩家设置" ,
		OnTop = "SIRPG系统-玩家属性迷你-最顶部" ,
		OnLeft = "SIRPG系统-玩家属性迷你-最左侧" ,
		ToUp = "SIRPG系统-玩家属性迷你-向上方" ,
		ToRight = "SIRPG系统-玩家属性迷你-向右侧" ,
		ToDown = "SIRPG系统-玩家属性迷你-向下方" ,
		ToLeft = "SIRPG系统-玩家属性迷你-向左侧"
	} ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 窗口函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	OpenFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		if settings.PlayerSetting.Base.showPlayerStatusMini then
			local status = settings.PlayerStatusMini
			if not status.frame or not status.frame.valid then
				local player = game.get_player( playerIndex )
				-- 显示窗口
				local frame = SIElements.CreateFrame( player , status ,
				{
					Name         = SIRPGPlayerStatusMini.Names.Frame ,
					Lock         = SIRPGPlayerStatusMini.Names.Lock ,
					Style        = SIConstants_RPGSystem.raw.Styles.PlayerStatusMini_Frame ,
					Title        = { "SIRPGSystem.玩家属性迷你-窗口-标题" } ,
					TitleTooltip = { "SIRPGSystem.玩家属性迷你-窗口-标题-提示" } ,
					UseTooltip   = { "SIRPGSystem.玩家属性迷你-窗口-使用-提示" , globalSettings.EXP.Max } ,
					LockTooltip  = { "SIRPGSystem.玩家属性迷你-窗口-锁定-提示" } ,
					isLocked     = status.frameLocked
				} )
				-- 第 1 层
				local flow1 = frame.add{ type = "flow" , direction = "horizontal" , style = SIConstants_RPGSystem.raw.Styles.PlayerStatusMini_Flow }
				-- 第 1.1 层
				local listLevel = flow1.add{ type = "table" , column_count = 3 , style = SIConstants_RPGSystem.raw.Styles.PlayerStatusMini_LevelList }
				status.levelCountAttack = listLevel.add{ type = "label" , style = SIConstants_RPGSystem.raw.Styles.PlayerStatusMini_LevelLabel }
				status.levelPointAttack = listLevel.add{ type = "label" , style = SIConstants_RPGSystem.raw.Styles.PlayerStatusMini_LevelLabel }
				status.levelProgressAttack = listLevel.add{ type = "progressbar" , style = SIConstants_RPGSystem.raw.Styles.PlayerStatusMini_ProgressRed }
				status.levelCountAdventure = listLevel.add{ type = "label" , style = SIConstants_RPGSystem.raw.Styles.PlayerStatusMini_LevelLabel }
				status.levelPointAdventure = listLevel.add{ type = "label" , style = SIConstants_RPGSystem.raw.Styles.PlayerStatusMini_LevelLabel }
				status.levelProgressAdventure = listLevel.add{ type = "progressbar" , style = SIConstants_RPGSystem.raw.Styles.PlayerStatusMini_ProgressGreen }
				status.levelCountCraft = listLevel.add{ type = "label" , style = SIConstants_RPGSystem.raw.Styles.PlayerStatusMini_LevelLabel }
				status.levelPointCraft = listLevel.add{ type = "label" , style = SIConstants_RPGSystem.raw.Styles.PlayerStatusMini_LevelLabel }
				status.levelProgressCraft = listLevel.add{ type = "progressbar" , style = SIConstants_RPGSystem.raw.Styles.PlayerStatusMini_ProgressCyan }
				-- 第 1.2 层
				local listButton = flow1.add{ type = "table" , column_count = 2 , style = SIConstants_RPGSystem.raw.Styles.PlayerStatusMini_ButtonList }
				listButton.add
				{
					type = "sprite-button" ,
					name = SIRPGPlayerStatus.Names.Open ,
					sprite = "item/" .. SIConstants_Core.raw.Items.IconArrow ,
					tooltip = { "SIRPGSystem.玩家属性迷你-窗口-打开玩家属性-提示" } ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerStatusMini_AddingButton
				}
				listButton.add
				{
					type = "sprite-button" ,
					name = SIRPGPlayerSkill.Names.Open ,
					sprite = "item/" .. SIConstants_Core.raw.Items.IconStar ,
					tooltip = { "SIRPGSystem.玩家属性迷你-窗口-打开技能列表-提示" } ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerStatusMini_AddingButton
				}
				listButton.add
				{
					type = "sprite-button" ,
					name = SIRPGPlayerInfo.Names.Open ,
					sprite = "item/" .. SIConstants_Core.raw.Items.IconDoc ,
					tooltip = { "SIRPGSystem.玩家属性迷你-窗口-打开玩家信息-提示" } ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerStatusMini_AddingButton
				}
				listButton.add
				{
					type = "sprite-button" ,
					name = SIRPGPlayerSetting.Names.Open ,
					sprite = "item/" .. SIConstants_Core.raw.Items.IconSettingWhite ,
					tooltip = { "SIRPGSystem.玩家属性迷你-窗口-打开玩家设置-提示" } ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerStatusMini_AddingButton
				}
				-- 第 1.3 层
				local flow13 = flow1.add{ type = "flow" , direction = "vertical" , style = SIConstants_RPGSystem.raw.Styles.PlayerStatusMini_ButtonFlow }
				-- 第 1.3.1 层
				local listOnDirection = flow13.add{ type = "table" , column_count = 2 , style = SIConstants_RPGSystem.raw.Styles.PlayerStatusMini_ButtonList }
				local onTop = listOnDirection.add
				{
					type = "sprite-button" ,
					name = SIRPGPlayerStatusMini.Names.OnTop ,
					sprite = "item/" .. SIConstants_Core.raw.Items.IconOnTop ,
					tooltip = { "SIRPGSystem.玩家属性迷你-窗口-最顶部-提示" } ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerStatusMini_AddingButton
				}
				local onLeft = listOnDirection.add
				{
					type = "sprite-button" ,
					name = SIRPGPlayerStatusMini.Names.OnLeft ,
					sprite = "item/" .. SIConstants_Core.raw.Items.IconOnLeft ,
					tooltip = { "SIRPGSystem.玩家属性迷你-窗口-最左侧-提示" } ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerStatusMini_AddingButton
				}
				-- 第 1.3.2 层
				local listToDirection = flow13.add{ type = "table" , column_count = 2 , style = SIConstants_RPGSystem.raw.Styles.PlayerStatusMini_ButtonList }
				local toUp = listToDirection.add
				{
					type = "sprite-button" ,
					name = SIRPGPlayerStatusMini.Names.ToUp ,
					sprite = "item/" .. SIConstants_Core.raw.Items.IconToUp ,
					tooltip = { "SIRPGSystem.玩家属性迷你-窗口-向上方-提示" } ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerStatusMini_AddingButton
				}
				local toRight = listToDirection.add
				{
					type = "sprite-button" ,
					name = SIRPGPlayerStatusMini.Names.ToRight ,
					sprite = "item/" .. SIConstants_Core.raw.Items.IconToRight ,
					tooltip = { "SIRPGSystem.玩家属性迷你-窗口-向右侧-提示" } ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerStatusMini_AddingButton
				}
				local toDown = listToDirection.add
				{
					type = "sprite-button" ,
					name = SIRPGPlayerStatusMini.Names.ToDown ,
					sprite = "item/" .. SIConstants_Core.raw.Items.IconToDown ,
					tooltip = { "SIRPGSystem.玩家属性迷你-窗口-向下方-提示" } ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerStatusMini_AddingButton
				}
				local toLeft = listToDirection.add
				{
					type = "sprite-button" ,
					name = SIRPGPlayerStatusMini.Names.ToLeft ,
					sprite = "item/" .. SIConstants_Core.raw.Items.IconToLeft ,
					tooltip = { "SIRPGSystem.玩家属性迷你-窗口-向左侧-提示" } ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerStatusMini_AddingButton
				}
				-- 根据设置更新控件
				if status.frameLocked then
					flow13.visible = false
					onTop.enabled = false
					onLeft.enabled = false
					toUp.enabled = false
					toRight.enabled = false
					toDown.enabled = false
					toLeft.enabled = false
				else
					flow13.visible = true
					onTop.enabled = true
					onLeft.enabled = true
					toUp.enabled = true
					toRight.enabled = true
					toDown.enabled = true
					toLeft.enabled = true
				end
				SIRPGPlayerStatusMini.FreshLevel( settings )
			end
		else
			SIRPGPlayerStatusMini.CloseFrame( playerIndex )
		end
	end ,
	CloseFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local status = settings.PlayerStatusMini
		if status.frame and status.frame.valid then
			status.frame.destroy()
			status.frame = nil
			status.levelCountAttack = nil
			status.levelCountAdventure = nil
			status.levelCountCraft = nil
			status.levelPointAttack = nil
			status.levelPointAdventure = nil
			status.levelPointCraft = nil
			status.levelProgressAttack = nil
			status.levelProgressAdventure = nil
			status.levelProgressCraft = nil
		end
	end ,
	MoveFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local status = settings.PlayerStatusMini
		if status.frame and status.frame.valid then
			SIElements.SaveFrameLocation( status )
		end
	end ,
	LockFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local status = settings.PlayerStatusMini
		if status.frame and status.frame.valid then
			if status.frameLocked then
				status.frameLocked = false
			else
				status.frameLocked = true
			end
			SIRPGPlayerStatusMini.CloseFrame( playerIndex )
			SIRPGPlayerStatusMini.OpenFrame( playerIndex )
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 控件函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	FreshLevel = function( settings )
		local status = settings.PlayerStatusMini
		local exp = settings.EXP
		local points = settings.Points
		local attackExp = SITools.FormatNumber4( exp.AttackExp )
		local adventureExp = SITools.FormatNumber4( exp.AdventureExp )
		local craftExp = SITools.FormatNumber4( exp.CraftExp )
		local pointAttackText = { "SIRPGSystem.玩家属性迷你-窗口-点数-战斗" , points.Current.Attack , points.Max.Attack }
		local pointAdventureText = { "SIRPGSystem.玩家属性迷你-窗口-点数-探索" , points.Current.Adventure , points.Max.Adventure }
		local pointCraftText = { "SIRPGSystem.玩家属性迷你-窗口-点数-生存" , points.Current.Craft , points.Max.Craft }
		status.levelCountAttack.caption = { "SIRPGSystem.玩家属性迷你-窗口-经验等级-战斗" , exp.AttackLevel }
		status.levelCountAttack.tooltip = { "SIRPGSystem.玩家属性迷你-窗口-经验等级-提示" , { "SIRPGSystem.经验-战斗" } , { "SIRPGSystem.经验-战斗-提示" } , exp.AttackLevel , attackExp , exp.AttackExpMax }
		status.levelCountAdventure.caption = { "SIRPGSystem.玩家属性迷你-窗口-经验等级-探索" , exp.AdventureLevel }
		status.levelCountAdventure.tooltip = { "SIRPGSystem.玩家属性迷你-窗口-经验等级-提示" , { "SIRPGSystem.经验-探索" } , { "SIRPGSystem.经验-探索-提示" } , exp.AdventureLevel , adventureExp , exp.AdventureExpMax }
		status.levelCountCraft.caption = { "SIRPGSystem.玩家属性迷你-窗口-经验等级-生存" , exp.CraftLevel }
		status.levelCountCraft.tooltip = { "SIRPGSystem.玩家属性迷你-窗口-经验等级-提示" , { "SIRPGSystem.经验-生存" } , { "SIRPGSystem.经验-生存-提示" } , exp.CraftLevel , craftExp , exp.CraftExpMax }
		status.levelPointAttack.caption = pointAttackText
		status.levelPointAttack.tooltip = { "SIRPGSystem.玩家属性迷你-窗口-点数-提示" , { "SIRPGSystem.经验-战斗" } , { "SIRPGSystem.经验-战斗-提示" } , { "SIRPGSystem.点数-战斗" } , pointAttackText }
		status.levelPointAdventure.caption = pointAdventureText
		status.levelPointAdventure.tooltip = { "SIRPGSystem.玩家属性迷你-窗口-点数-提示" , { "SIRPGSystem.经验-探索" } , { "SIRPGSystem.经验-探索-提示" } , { "SIRPGSystem.点数-探索" } , pointAdventureText }
		status.levelPointCraft.caption = pointCraftText
		status.levelPointCraft.tooltip = { "SIRPGSystem.玩家属性迷你-窗口-点数-提示" , { "SIRPGSystem.经验-生存" } , { "SIRPGSystem.经验-生存-提示" } , { "SIRPGSystem.点数-生存" } , pointCraftText }
		status.levelProgressAttack.value = exp.AttackExp / exp.AttackExpMax
		status.levelProgressAttack.tooltip = { "SIRPGSystem.玩家属性迷你-窗口-经验-提示" , { "SIRPGSystem.经验-战斗" } , { "SIRPGSystem.经验-战斗-提示" } , attackExp , exp.AttackExpMax }
		status.levelProgressAdventure.value = exp.AdventureExp / exp.AdventureExpMax
		status.levelProgressAdventure.tooltip = { "SIRPGSystem.玩家属性迷你-窗口-经验-提示" , { "SIRPGSystem.经验-探索" } , { "SIRPGSystem.经验-探索-提示" } , adventureExp , exp.AdventureExpMax }
		status.levelProgressCraft.value = exp.CraftExp / exp.CraftExpMax
		status.levelProgressCraft.tooltip = { "SIRPGSystem.玩家属性迷你-窗口-经验-提示" , { "SIRPGSystem.经验-生存" } , { "SIRPGSystem.经验-生存-提示" } , craftExp , exp.CraftExpMax }
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
	SwitchMini = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		if settings.PlayerSetting.Base.showPlayerStatusMini then
			settings.PlayerSetting.Base.showPlayerStatusMini = false
		else
			settings.PlayerSetting.Base.showPlayerStatusMini = true
		end
		SIRPGPlayerStatusMini.OpenFrame( playerIndex )
	end ,
	MoveOnTop = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local status = settings.PlayerStatusMini
		if status.frame and status.frame.valid then
			local location = status.frame.location
			location.y = 0
			status.frame.location = location
			SIElements.SaveFrameLocation( status )
		end
	end ,
	MoveOnLeft = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local status = settings.PlayerStatusMini
		if status.frame and status.frame.valid then
			local location = status.frame.location
			location.x = 0
			status.frame.location = location
			SIElements.SaveFrameLocation( status )
		end
	end ,
	MoveToUp = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local status = settings.PlayerStatusMini
		if status.frame and status.frame.valid then
			local location = status.frame.location
			location.y = location.y - 1
			status.frame.location = location
			SIElements.SaveFrameLocation( status )
		end
	end ,
	MoveToRight = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local status = settings.PlayerStatusMini
		if status.frame and status.frame.valid then
			local location = status.frame.location
			location.x = location.x + 1
			status.frame.location = location
			SIElements.SaveFrameLocation( status )
		end
	end ,
	MoveToDown = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local status = settings.PlayerStatusMini
		if status.frame and status.frame.valid then
			local location = status.frame.location
			location.y = location.y + 1
			status.frame.location = location
			SIElements.SaveFrameLocation( status )
		end
	end ,
	MoveToLeft = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local status = settings.PlayerStatusMini
		if status.frame and status.frame.valid then
			local location = status.frame.location
			location.x = location.x - 1
			status.frame.location = location
			SIElements.SaveFrameLocation( status )
		end
	end
}
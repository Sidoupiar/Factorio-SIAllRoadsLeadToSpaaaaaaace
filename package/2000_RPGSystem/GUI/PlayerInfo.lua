SIRPGPlayerInfo =
{
	ID = "RPGPlayerInfo" ,
	Code = "RPGPlayerInfo" ,
	Show = "RPG玩家信息" ,
	Names =
	{
		Prefix = "SIRPG系统-玩家信息-" ,
		Frame = "SIRPG系统-玩家信息-窗口" ,
		Open = "SIRPG系统-玩家信息-打开" ,
		Lock = "SIRPG系统-玩家信息-锁定" ,
		OnTop = "SIRPG系统-玩家信息-最顶部" ,
		OnLeft = "SIRPG系统-玩家信息-最左侧" ,
		ToUp = "SIRPG系统-玩家信息-向上方" ,
		ToRight = "SIRPG系统-玩家信息-向右侧" ,
		ToDown = "SIRPG系统-玩家信息-向下方" ,
		ToLeft = "SIRPG系统-玩家信息-向左侧"
	} ,
	ValueBarStyles =
	{
		Health   = SIConstants_RPGSystem.raw.Styles.PlayerInfo_ProgressHealth ,
		Strength = SIConstants_RPGSystem.raw.Styles.PlayerInfo_ProgressStrength ,
		Mana     = SIConstants_RPGSystem.raw.Styles.PlayerInfo_ProgressMana ,
		Energy   = SIConstants_RPGSystem.raw.Styles.PlayerInfo_ProgressEnergy ,
		Thought  = SIConstants_RPGSystem.raw.Styles.PlayerInfo_ProgressThought ,
		Soul     = SIConstants_RPGSystem.raw.Styles.PlayerInfo_ProgressSoul
	} ,
	ValueBarShow =
	{
		Health   = "SIRPGSystem.玩家信息-窗口-数值-健康值" ,
		Strength = "SIRPGSystem.玩家信息-窗口-数值-体力值" ,
		Mana     = "SIRPGSystem.玩家信息-窗口-数值-魔法值" ,
		Energy   = "SIRPGSystem.玩家信息-窗口-数值-能量值" ,
		Thought  = "SIRPGSystem.玩家信息-窗口-数值-精神值" ,
		Soul     = "SIRPGSystem.玩家信息-窗口-数值-灵魂值"
	} ,
	ValueBarShowFull =
	{
		Health   = "SIRPGSystem.玩家信息-窗口-数值-健康值-满" ,
		Strength = "SIRPGSystem.玩家信息-窗口-数值-体力值-满" ,
		Mana     = "SIRPGSystem.玩家信息-窗口-数值-魔法值-满" ,
		Energy   = "SIRPGSystem.玩家信息-窗口-数值-能量值-满" ,
		Thought  = "SIRPGSystem.玩家信息-窗口-数值-精神值-满" ,
		Soul     = "SIRPGSystem.玩家信息-窗口-数值-灵魂值-满"
	} ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 窗口函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	OpenFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		if settings.PlayerSetting.Base.showPlayerInfo then
			local info = settings.PlayerInfo
			if not info.frame or not info.frame.valid then
				local player = game.get_player( playerIndex )
				-- 显示窗口
				local frame = SIElements.CreateFrame( player , info ,
				{
					Name           = SIRPGPlayerInfo.Names.Frame ,
					Lock           = SIRPGPlayerInfo.Names.Lock ,
					Style          = SIConstants_RPGSystem.raw.Styles.PlayerInfo_Frame ,
					Title          = { "SIRPGSystem.玩家信息-窗口-标题" } ,
					TitleTooltip   = { "SIRPGSystem.玩家信息-窗口-标题-提示" } ,
					UseTooltip     = { "SIRPGSystem.玩家信息-窗口-使用-提示" } ,
					LockTooltip    = { "SIRPGSystem.玩家信息-窗口-锁定-提示" } ,
					isLocked       = info.frameLocked
				} )
				-- 第 1 层
				local flow1 = frame.add{ type = "flow" , direction = "horizontal" , style = SIConstants_RPGSystem.raw.Styles.PlayerInfo_Flow }
				-- 第 1.1 层
				local listBar = flow1.add{ type = "table" , column_count = 2 , style = SIConstants_RPGSystem.raw.Styles.PlayerInfo_ValueList }
				for valueBarID , valueRegenID in pairs( SIRPGSystem.ValueBarRegen ) do
					local valueBarTooltip = { "SIRPGSystem.玩家信息-窗口-数值-提示" , SIRPGSystem.ValueNames[valueBarID] , SIRPGSystem.ValueTooltips[valueBarID] }
					local flow = listBar.add{ type = "flow" , direction = "horizontal" , style = SIConstants_RPGSystem.raw.Styles.PlayerInfo_ListValueFlow }
					info.ValueTextLeft[valueBarID] = flow.add{ type = "label" , tooltip = valueBarTooltip , style = SIConstants_RPGSystem.raw.Styles.PlayerInfo_ListValueLeft }
					info.ValueTextCenter[valueBarID] = flow.add{ type = "label" , tooltip = valueBarTooltip , style = SIConstants_RPGSystem.raw.Styles.PlayerInfo_ListValueCenter }
					info.ValueTextRight[valueBarID] = flow.add{ type = "label" , tooltip = valueBarTooltip , style = SIConstants_RPGSystem.raw.Styles.PlayerInfo_ListValueRight }
					info.ValueBar[valueBarID] = listBar.add{ type = "progressbar" , tooltip = valueBarTooltip , style = SIRPGPlayerInfo.ValueBarStyles[valueBarID] }
				end
				-- 第 1.2 层
				local flow12 = flow1.add{ type = "flow" , direction = "vertical" , style = SIConstants_RPGSystem.raw.Styles.PlayerInfo_ButtonFlow }
				-- 第 1.2.1 层
				local listOnDirection = flow12.add{ type = "table" , column_count = 2 , style = SIConstants_RPGSystem.raw.Styles.PlayerInfo_ButtonList }
				local onTop = listOnDirection.add
				{
					type = "sprite-button" ,
					name = SIRPGPlayerInfo.Names.OnTop ,
					sprite = "item/" .. SIConstants_Core.raw.Items.IconOnTop ,
					tooltip = { "SIRPGSystem.玩家信息-窗口-最顶部-提示" } ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerInfo_AddingButton
				}
				local onLeft = listOnDirection.add
				{
					type = "sprite-button" ,
					name = SIRPGPlayerInfo.Names.OnLeft ,
					sprite = "item/" .. SIConstants_Core.raw.Items.IconOnLeft ,
					tooltip = { "SIRPGSystem.玩家信息-窗口-最左侧-提示" } ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerInfo_AddingButton
				}
				-- 第 1.2.2 层
				local listToDirection = flow12.add{ type = "table" , column_count = 2 , style = SIConstants_RPGSystem.raw.Styles.PlayerInfo_ButtonList }
				local toUp = listToDirection.add
				{
					type = "sprite-button" ,
					name = SIRPGPlayerInfo.Names.ToUp ,
					sprite = "item/" .. SIConstants_Core.raw.Items.IconToUp ,
					tooltip = { "SIRPGSystem.玩家信息-窗口-向上方-提示" } ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerInfo_AddingButton
				}
				local toRight = listToDirection.add
				{
					type = "sprite-button" ,
					name = SIRPGPlayerInfo.Names.ToRight ,
					sprite = "item/" .. SIConstants_Core.raw.Items.IconToRight ,
					tooltip = { "SIRPGSystem.玩家信息-窗口-向右侧-提示" } ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerInfo_AddingButton
				}
				local toDown = listToDirection.add
				{
					type = "sprite-button" ,
					name = SIRPGPlayerInfo.Names.ToDown ,
					sprite = "item/" .. SIConstants_Core.raw.Items.IconToDown ,
					tooltip = { "SIRPGSystem.玩家信息-窗口-向下方-提示" } ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerInfo_AddingButton
				}
				local toLeft = listToDirection.add
				{
					type = "sprite-button" ,
					name = SIRPGPlayerInfo.Names.ToLeft ,
					sprite = "item/" .. SIConstants_Core.raw.Items.IconToLeft ,
					tooltip = { "SIRPGSystem.玩家信息-窗口-向左侧-提示" } ,
					style = SIConstants_RPGSystem.raw.Styles.PlayerInfo_AddingButton
				}
				-- 根据设置更新控件
				if info.frameLocked then
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
				SIRPGPlayerInfo.FreshValue( settings )
			end
		else
			SIRPGPlayerInfo.CloseFrame( playerIndex )
		end
	end ,
	CloseFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local info = settings.PlayerInfo
		if info.frame and info.frame.valid then
			info.frame.destroy()
			info.frame = nil
			info.ValueTextLeft = {}
			info.ValueTextCenter = {}
			info.ValueTextRight = {}
			info.ValueBar = {}
		end
	end ,
	MoveFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local info = settings.PlayerInfo
		if info.frame and info.frame.valid then
			SIElements.SaveFrameLocation( info )
		end
	end ,
	LockFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local info = settings.PlayerInfo
		if info.frame and info.frame.valid then
			if info.frameLocked then
				info.frameLocked = false
			else
				info.frameLocked = true
			end
			SIRPGPlayerInfo.CloseFrame( playerIndex )
			SIRPGPlayerInfo.OpenFrame( playerIndex )
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 控件函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	FreshValue = function( settings )
		for valueBarID , valueRegenID in pairs( SIRPGSystem.ValueBarRegen ) do
			SIRPGPlayerInfo.FreshValueLine( settings , valueBarID )
		end
	end ,
	FreshValueLine = function( settings , valueBarID )
		if not SIRPGSystem.ValueBarRegen[valueBarID] then
			return
		end
		local info = settings.PlayerInfo
		local value = settings.Value
		local max = value.Max[valueBarID]
		local current = value.Current[valueBarID]
		info.ValueTextLeft[valueBarID].caption = { current == max and SIRPGPlayerInfo.ValueBarShowFull[valueBarID] or SIRPGPlayerInfo.ValueBarShow[valueBarID] , current }
		info.ValueTextCenter[valueBarID].caption = { "SIRPGSystem.玩家信息-窗口-数值-分隔符" }
		info.ValueTextRight[valueBarID].caption = { SIRPGPlayerInfo.ValueBarShowFull[valueBarID] , max }
		info.ValueBar[valueBarID].value = current / max
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
	SwitchInfo = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		if settings.PlayerSetting.Base.showPlayerInfo then
			settings.PlayerSetting.Base.showPlayerInfo = false
		else
			settings.PlayerSetting.Base.showPlayerInfo = true
		end
		SIRPGPlayerInfo.OpenFrame( playerIndex )
	end ,
	MoveOnTop = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local info = settings.PlayerInfo
		if info.frame and info.frame.valid then
			local location = info.frame.location
			location.y = 0
			info.frame.location = location
			SIElements.SaveFrameLocation( info )
		end
	end ,
	MoveOnLeft = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local info = settings.PlayerInfo
		if info.frame and info.frame.valid then
			local location = info.frame.location
			location.x = 0
			info.frame.location = location
			SIElements.SaveFrameLocation( info )
		end
	end ,
	MoveToUp = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local info = settings.PlayerInfo
		if info.frame and info.frame.valid then
			local location = info.frame.location
			location.y = location.y - 1
			info.frame.location = location
			SIElements.SaveFrameLocation( info )
		end
	end ,
	MoveToRight = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local info = settings.PlayerInfo
		if info.frame and info.frame.valid then
			local location = info.frame.location
			location.x = location.x + 1
			info.frame.location = location
			SIElements.SaveFrameLocation( info )
		end
	end ,
	MoveToDown = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local info = settings.PlayerInfo
		if info.frame and info.frame.valid then
			local location = info.frame.location
			location.y = location.y + 1
			info.frame.location = location
			SIElements.SaveFrameLocation( info )
		end
	end ,
	MoveToLeft = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local info = settings.PlayerInfo
		if info.frame and info.frame.valid then
			local location = info.frame.location
			location.x = location.x - 1
			info.frame.location = location
			SIElements.SaveFrameLocation( info )
		end
	end
}
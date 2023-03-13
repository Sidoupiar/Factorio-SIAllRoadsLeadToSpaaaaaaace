SIMainbar =
{
	ID = "Mainbar" ,
	Name = "主面板" ,
	InterfaceID = "SICore-Mainbar" ,
	Names =
	{
		Prefix = "SI核心-主面板-" ,
		Setting = "SI核心-主面板-设置" ,
		Note = "SI核心-主面板-便签" ,
		Message = "SI核心-主面板-消息" ,
		ToolbarOpen = "SI核心-主面板-工具栏-打开" ,
		ToolbarClose = "SI核心-主面板-工具栏-关闭" ,
		GameSpeed_MAIN = "SI核心-主面板-游戏速度0" ,
		GameSpeed_UP1 = "SI核心-主面板-游戏速度1" ,
		GameSpeed_UP2 = "SI核心-主面板-游戏速度2" ,
		GameSpeed_DOWN1 = "SI核心-主面板-游戏速度3" ,
		GameSpeed_DOWN2 = "SI核心-主面板-游戏速度4" ,
		GameTime = "SI核心-主面板-游戏时间" ,
		GameTimeMode = "SI核心-主面板-切换游戏时间" ,
		ToolbarButtonPrefix = "SI核心-主面板-工具栏按钮"
	} ,
	ToolbarColumnMin = 5 ,
	ToolbarColumnMax = 30 ,
	GameSpeedMin = 0.01 ,
	GameSpeedMax = 1000 ,
	GameTimeModeCount = 4 , -- 1 = 模式 Normal , 2 = 模式 Game , 3 = 模式 Real , 4 = 模式 Area
	-- 工具栏按钮数据包数字
	ToolbarButtonDataList = {} ,
	ToolbarButtonDropDownList =
	{
		{ "SICore.主面板设置管理-窗口-设置-工具栏常用按钮-无" }
	} ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 窗口函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	OpenFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		if SISettings.PerUser.SICore.ShowMainbar( playerIndex ) then
			if not settings.mainbar or not settings.mainbar.valid then
				local player = game.get_player( playerIndex )
				-- 显示主面板
				local mainbar = player.gui.top.add{ type = "frame" , direction = "horizontal" , index = 1 , style = SIConstants_Core.raw.Styles.Mainbar_Frame }
				settings.mainbar = mainbar
				-- 第 1 层
				local flow1 = mainbar.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
				-- 第 1.1 层
				flow1.add{ type = "sprite-button" , name = SIMainbar.Names.Setting , sprite = "item/" .. SIConstants_Core.raw.Items.IconSetting , tooltip = { "SICore.主面板-设置-打开-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_ButtonBig }
				-- 第 1.2 层
				local flow11 = flow1.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
				flow11.add{ type = "sprite-button" , name = SIMainbar.Names.Note , sprite = "item/" .. SIConstants_Core.raw.Items.IconNote , tooltip = { "SICore.主面板-便签-打开-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_ButtonSmall }
				flow11.add{ type = "sprite-button" , name = SIMainbar.Names.Message , sprite = "item/" .. SIConstants_Core.raw.Items.IconMessage , tooltip = { "SICore.主面板-消息-打开-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_ButtonSmall }
				-- 第 2 层
				settings.mainbarFlow2 = mainbar.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Mainbar_LabelFlow }
				-- 第 3 层 , 工具栏
				local panelToolbar = mainbar.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
				settings.Toolbar.panel = panelToolbar
				-- 第 3.1 层
				local toolbarFlow1 = panelToolbar.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
				-- 第 3.1.1 层
				local toolbarFlow11 = toolbarFlow1.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
				settings.Toolbar.open = toolbarFlow11.add{ type = "sprite-button" , name = SIMainbar.Names.ToolbarOpen , sprite = "item/" .. SIConstants_Core.raw.Items.IconToolbar , tooltip = { "SICore.主面板-工具栏-打开" } , style = SIConstants_Core.raw.Styles.Mainbar_ToolbarOpen }
				settings.Toolbar.hide = toolbarFlow11.add{ type = "sprite-button" , name = SIMainbar.Names.ToolbarClose , sprite = "item/" .. SIConstants_Core.raw.Items.IconToolbar , tooltip = { "SICore.主面板-工具栏-关闭" } , style = SIConstants_Core.raw.Styles.Mainbar_ToolbarClose }
				-- 第 3.1.2 层
				local toolbarFlow12 = toolbarFlow1.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
				settings.Toolbar.flow1 = toolbarFlow12.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Mainbar_ToolbarCommonFlow }
				settings.Toolbar.flow2 = toolbarFlow12.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Mainbar_ToolbarCommonFlow }
				-- 第 3.2 层
				settings.Toolbar.list = settings.Toolbar.panel
				.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "never" , style = SIConstants_Core.raw.Styles.Mainbar_ToolbarScroll }
				.add{ type = "table" , column_count = settings.Setting.Base.toolbarColumnCount , style = SIConstants_Core.raw.Styles.Mainbar_ToolbarList }
				-- 根据设置更新控件
				SIMainbar.UpdateFrame( settings )
			end
		else
			SIMainbar.CloseFrame( playerIndex )
		end
	end ,
	CloseFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		-- 关闭/隐藏主面板
		if settings.mainbar and settings.mainbar.valid then
			settings.mainbar.destroy()
			-- 清除相关引用
			settings.mainbar = nil
			settings.Toolbar.panel = nil
			settings.Toolbar.open = nil
			settings.Toolbar.hide = nil
			settings.Toolbar.list = nil
			settings.Toolbar.flow1 = nil
			settings.Toolbar.flow2 = nil
			settings.GameSpeed.panel = nil
			settings.GameTime.panel = nil
			settings.KillCount.panel = nil
			settings.Evolution.panel = nil
			settings.NewMessage.panel = nil
			settings.KeyNote.panel = nil
		end
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 功能函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	UpdateFrame = function( settings )
		-- 根据设置维护控件
		if settings.mainbar then
			local base = settings.Setting.Base
			-- 更新布局
			-- 第 2 层
			local flow2 = settings.mainbarFlow2
			flow2.clear()
			-- 第 2.1 层
			local flow21 = flow2.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowCenterH }
			settings.GameSpeed.panel = flow21.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowCenterH }
			settings.GameTime.panel = flow21.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowCenterH }
			-- 第 2.2 层
			local flow22 = flow2.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Mainbar_LabelFlow }
			settings.KillCount.panel = flow22.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			settings.Evolution.panel = flow22.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			settings.NewMessage.panel = flow22.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			settings.KeyNote.panel = flow22.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			local useFlag = false
			-- 工具栏
			if base.showToolbar then
				SIMainbar.ShowPanel_Toolbar( settings )
			else
				SIMainbar.HidePanel_Toolbar( settings )
			end
			-- 游戏速度
			if base.showGameSpeed then
				SIMainbar.ShowPanel_GameSpeed( settings )
				useFlag = true
			else
				SIMainbar.HidePanel_GameSpeed( settings )
			end
			-- 游戏时间
			if base.showGameTime then
				SIMainbar.ShowPanel_GameTime( settings )
				useFlag = true
			else
				SIMainbar.HidePanel_GameTime( settings )
			end
			-- 击杀数量
			if base.showKillCount then
				SIMainbar.ShowPanel_KillCount( settings )
				useFlag = true
			else
				SIMainbar.HidePanel_KillCount( settings )
			end
			-- 进化因子
			if base.showEvolution then
				SIMainbar.ShowPanel_Evolution( settings )
				useFlag = true
			else
				SIMainbar.HidePanel_Evolution( settings )
			end
			-- 最新消息
			if base.showNewMessage then
				SIMainbar.ShowPanel_NewMessage( settings )
				useFlag = true
			else
				SIMainbar.HidePanel_NewMessage( settings )
			end
			-- 重点便签
			if base.showKeyNote then
				SIMainbar.ShowPanel_KeyNote( settings )
				useFlag = true
			else
				SIMainbar.HidePanel_KeyNote( settings )
			end
			-- 如果没有使用功能 , 则隐藏中间栏
			flow2.visible = useFlag
		end
	end ,
	FreshFrame = function( settings )
		-- 根据设置更新显示的数据
		if settings.mainbar then
			local base = settings.Setting.Base
			-- 游戏速度
			if base.showGameSpeed then
				SIMainbar.FreshPanel_GameSpeed( settings )
			end
			-- 游戏时间
			if base.showGameTime then
				SIMainbar.FreshPanel_GameTime( settings )
			end
			-- 击杀数量
			if base.showKillCount then
				SIMainbar.FreshPanel_KillCount( settings )
			end
			-- 进化因子
			if base.showEvolution then
				SIMainbar.FreshPanel_Evolution( settings )
			end
			-- 最新消息
			if base.showNewMessage then
				SIMainbar.FreshPanel_NewMessage( settings )
			end
			-- 重点便签
			if base.showKeyNote then
				SIMainbar.FreshPanel_KeyNote( settings )
			end
		end
	end ,
	FreshFrame_Tick = function( settings )
		-- 根据设置更新显示的数据
		if settings.mainbar then
			local base = settings.Setting.Base
			-- 游戏时间
			if base.showGameTime then
				SIMainbar.FreshPanel_GameTime( settings )
			end
			-- 进化因子
			if base.showEvolution then
				SIMainbar.FreshPanel_Evolution( settings )
			end
		end
	end ,
	ShowPanel_Toolbar = function( settings )
		settings.Toolbar.open.visible = false
		settings.Toolbar.hide.visible = true
		settings.Toolbar.list.visible = true
		-- 根据设置更新控件
		SIMainbar.FreshPanel_Toolbar( settings )
	end ,
	ShowPanel_GameSpeed = function( settings )
		local panel = settings.GameSpeed.panel
		panel.clear()
		panel.visible = true
		settings.GameSpeed.down2 = panel.add{ type = "sprite-button" , name = SIMainbar.Names.GameSpeed_DOWN2 , sprite = "item/" .. SIConstants_Core.raw.Items.IconBack2 , tooltip = { "SICore.主面板-游戏速度-降低2-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Button_GameSpeedSmall }
		settings.GameSpeed.down1 = panel.add{ type = "sprite-button" , name = SIMainbar.Names.GameSpeed_DOWN1 , sprite = "item/" .. SIConstants_Core.raw.Items.IconBack1 , tooltip = { "SICore.主面板-游戏速度-降低1-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Button_GameSpeedSmall }
		settings.GameSpeed.main = panel.add{ type = "button" , name = SIMainbar.Names.GameSpeed_MAIN , style = SIConstants_Core.raw.Styles.Mainbar_Button_GameSpeed }
		settings.GameSpeed.up1 = panel.add{ type = "sprite-button" , name = SIMainbar.Names.GameSpeed_UP1 , sprite = "item/" .. SIConstants_Core.raw.Items.IconNext1 , tooltip = { "SICore.主面板-游戏速度-提高1-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Button_GameSpeedSmall }
		settings.GameSpeed.up2 = panel.add{ type = "sprite-button" , name = SIMainbar.Names.GameSpeed_UP2 , sprite = "item/" .. SIConstants_Core.raw.Items.IconNext2 , tooltip = { "SICore.主面板-游戏速度-提高2-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Button_GameSpeedSmall }
		-- 根据设置更新控件
		SIMainbar.FreshPanel_GameSpeed( settings )
	end ,
	ShowPanel_GameTime = function( settings )
		local panel = settings.GameTime.panel
		panel.clear()
		panel.visible = true
		settings.GameTime.view = panel.add{ type = "button" , name = SIMainbar.Names.GameTime , style = SIConstants_Core.raw.Styles.Mainbar_Button_Time }
		panel.add{ type = "sprite-button" , name = SIMainbar.Names.GameTimeMode , sprite = "item/" .. SIConstants_Core.raw.Items.IconSettingWhite , tooltip = { "SICore.主面板-游戏时间-切换" , SIMainbar.GameTimeModeCount } , style = SIConstants_Core.raw.Styles.Mainbar_Button_TimeSwitch }
		-- 根据设置更新控件
		SIMainbar.FreshPanel_GameTime( settings )
	end ,
	ShowPanel_KillCount = function( settings )
		local panel = settings.KillCount.panel
		panel.clear()
		panel.visible = true
		settings.KillCount.view = panel.add{ type = "label" , style = SIConstants_Core.raw.Styles.Mainbar_LabelText }
		-- 根据设置更新控件
		SIMainbar.FreshPanel_KillCount( settings )
	end ,
	ShowPanel_Evolution = function( settings )
		local panel = settings.Evolution.panel
		panel.clear()
		panel.visible = true
		settings.Evolution.view = panel.add{ type = "label" , style = SIConstants_Core.raw.Styles.Mainbar_LabelText }
		-- 根据设置更新控件
		SIMainbar.FreshPanel_Evolution( settings )
	end ,
	ShowPanel_NewMessage = function( settings )
		local panel = settings.NewMessage.panel
		panel.clear()
		panel.visible = true
		settings.NewMessage.view = panel.add{ type = "label" , style = SIConstants_Core.raw.Styles.Mainbar_LabelText }
		-- 根据设置更新控件
		SIMainbar.FreshPanel_NewMessage( settings )
	end ,
	ShowPanel_KeyNote = function( settings )
		local panel = settings.KeyNote.panel
		panel.clear()
		panel.visible = true
		settings.KeyNote.view = panel.add{ type = "label" , style = SIConstants_Core.raw.Styles.Mainbar_LabelText }
		-- 根据设置更新控件
		SIMainbar.FreshPanel_KeyNote( settings )
	end ,
	HidePanel_Toolbar = function( settings )
		settings.Toolbar.open.visible = true
		settings.Toolbar.hide.visible = false
		settings.Toolbar.list.visible = false
		-- 根据设置更新控件
		SIMainbar.FreshPanel_Toolbar( settings )
	end ,
	HidePanel_GameSpeed = function( settings )
		local panel = settings.GameSpeed.panel
		panel.clear()
		panel.visible = false
		settings.GameSpeed.main = nil
		settings.GameSpeed.up1 = nil
		settings.GameSpeed.up2 = nil
		settings.GameSpeed.down1 = nil
		settings.GameSpeed.down2 = nil
	end ,
	HidePanel_GameTime = function( settings )
		local panel = settings.GameTime.panel
		panel.clear()
		panel.visible = false
		settings.GameTime.view = nil
	end ,
	HidePanel_KillCount = function( settings )
		local panel = settings.KillCount.panel
		panel.clear()
		panel.visible = false
		settings.KillCount.view = nil
	end ,
	HidePanel_Evolution = function( settings )
		local panel = settings.Evolution.panel
		panel.clear()
		panel.visible = false
		settings.Evolution.view = nil
	end ,
	HidePanel_NewMessage = function( settings )
		local panel = settings.NewMessage.panel
		panel.clear()
		panel.visible = false
		settings.NewMessage.view = nil
	end ,
	HidePanel_KeyNote = function( settings )
		local panel = settings.KeyNote.panel
		panel.clear()
		panel.visible = false
		settings.KeyNote.view = nil
	end ,
	FreshPanel_Toolbar = function( settings )
		settings.Toolbar.flow1.clear()
		settings.Toolbar.flow2.clear()
		local list = settings.Toolbar.list
		list.clear()
		for index , toolbarButtonData in pairs( SIMainbar.ToolbarButtonDataList ) do
			if not toolbarButtonData.Permission or SIPermission.HasPermission( toolbarButtonData.Permission , settings.playerIndex ) then
				if list.visible then
					list.add
					{
						type = "sprite-button" ,
						name = SIMainbar.Names.ToolbarButtonPrefix .. toolbarButtonData.Name ,
						sprite = "item/" .. toolbarButtonData.IconItemName ,
						tooltip = { "SICore.主面板-工具栏按钮-提示" , toolbarButtonData.LocalizedName , toolbarButtonData.LocalizedDescription } ,
						style = SIConstants_Core.raw.Styles.Mainbar_ToolbarButton
					}
				end
				if index == settings.Setting.Base.commonToolbar1 then
					settings.Toolbar.flow1.clear()
					settings.Toolbar.flow1.add
					{
						type = "sprite-button" ,
						name = SIMainbar.Names.ToolbarButtonPrefix .. toolbarButtonData.Name ,
						sprite = "item/" .. toolbarButtonData.IconItemName ,
						tooltip = { "SICore.主面板-工具栏按钮-提示" , toolbarButtonData.LocalizedName , toolbarButtonData.LocalizedDescription } ,
						style = SIConstants_Core.raw.Styles.Mainbar_ToolbarCommonButton
					}
				end
				if index == settings.Setting.Base.commonToolbar2 then
					settings.Toolbar.flow2.clear()
					settings.Toolbar.flow2.add
					{
						type = "sprite-button" ,
						name = SIMainbar.Names.ToolbarButtonPrefix .. toolbarButtonData.Name ,
						sprite = "item/" .. toolbarButtonData.IconItemName ,
						tooltip = { "SICore.主面板-工具栏按钮-提示" , toolbarButtonData.LocalizedName , toolbarButtonData.LocalizedDescription } ,
						style = SIConstants_Core.raw.Styles.Mainbar_ToolbarCommonButton
					}
				end
			end
		end
	end ,
	FreshPanel_GameSpeed = function( settings )
		local speed = game.speed
		settings.GameSpeed.main.caption = { "SICore.主面板-游戏速度" , speed }
		settings.GameSpeed.main.tooltip = { "SICore.主面板-游戏速度-提示" , settings.GameSpeed.speedLast or { "SICore.主面板-游戏速度-提示-无记录" } }
		if speed <= SIMainbar.GameSpeedMin then
			settings.GameSpeed.down1.enabled = false
			settings.GameSpeed.down2.enabled = false
		else
			settings.GameSpeed.down1.enabled = true
			settings.GameSpeed.down2.enabled = true
		end
		if speed >= SIMainbar.GameSpeedMax then
			settings.GameSpeed.up1.enabled = false
			settings.GameSpeed.up2.enabled = false
		else
			settings.GameSpeed.up1.enabled = true
			settings.GameSpeed.up2.enabled = true
		end
	end ,
	FreshPanel_GameTime = function( settings )
		local player = game.get_player( settings.playerIndex )
		local caption = nil
		local tooltip = nil
		if settings.Setting.Base.showGameTimeMode == 2 then
			-- 模式 Game
			local day , hour , minute = SIDate.FormatDateByTick( game.ticks_played )
			local dayReal , hourReal , minuteReal , secondReal = SIDate.FormatDateByTickReal( game.ticks_played )
			local dayOnline , hourOnline , minuteOnline , secondOnline = SIDate.FormatDateByTickReal( player.online_time )
			caption =
			{
				"SICore.主面板-游戏时间-模式Game" ,
				{ "SICommon.每天日期" , hour , minute }
			}
			tooltip =
			{
				"SICore.主面板-游戏时间-模式Game-提示" ,
				{ "SICommon.游戏日期" , day , hour , minute } ,
				{ "SICommon.实际日期" , dayReal , hourReal , minuteReal , secondReal } ,
				{ "SICommon.实际日期" , dayOnline , hourOnline , minuteOnline , secondOnline } ,
				player.surface.name
			}
		elseif settings.Setting.Base.showGameTimeMode == 3 then
			-- 模式 Real
			local day , hour , minute = SIDate.FormatDateByTick( game.ticks_played )
			local dayReal , hourReal , minuteReal , secondReal = SIDate.FormatDateByTickReal( game.ticks_played )
			local dayOnline , hourOnline , minuteOnline , secondOnline = SIDate.FormatDateByTickReal( player.online_time )
			caption =
			{
				"SICore.主面板-游戏时间-模式Real" ,
				{ "SICommon.实际日期" , dayReal , hourReal , minuteReal , secondReal }
			}
			tooltip =
			{
				"SICore.主面板-游戏时间-模式Real-提示" ,
				{ "SICommon.游戏日期" , day , hour , minute } ,
				{ "SICommon.实际日期" , dayOnline , hourOnline , minuteOnline , secondOnline } ,
				player.surface.name
			}
		elseif settings.Setting.Base.showGameTimeMode == 4 then
			-- 模式 Area
			local globalSettings = SIGlobal.GetGlobalSettings( SIMainData.Settings.Name )
			local day , hour , minute = SIDate.FormatDateByTick( game.ticks_played )
			local areaDay , areaHour , areaMinute = SIDate.FormatDateByTickPerDay( game.ticks_played - ( globalSettings.SurfaceTime[player.surface.name] or 0 ) , player.surface.ticks_per_day )
			local dayReal , hourReal , minuteReal , secondReal = SIDate.FormatDateByTickReal( game.ticks_played )
			local dayOnline , hourOnline , minuteOnline , secondOnline = SIDate.FormatDateByTickReal( player.online_time )
			caption =
			{
				"SICore.主面板-游戏时间-模式Area" ,
				{ "SICommon.游戏日期" , areaDay , areaHour , areaMinute } ,
			}
			tooltip =
			{
				"SICore.主面板-游戏时间-模式Area-提示" ,
				{ "SICommon.游戏日期" , day , hour , minute } ,
				{ "SICommon.实际日期" , dayReal , hourReal , minuteReal , secondReal } ,
				{ "SICommon.实际日期" , dayOnline , hourOnline , minuteOnline , secondOnline } ,
				player.surface.name
			}
		else
			-- 模式 Normal
			local day , hour , minute = SIDate.FormatDateByTick( game.ticks_played )
			local dayReal , hourReal , minuteReal , secondReal = SIDate.FormatDateByTickReal( game.ticks_played )
			local dayOnline , hourOnline , minuteOnline , secondOnline = SIDate.FormatDateByTickReal( player.online_time )
			caption =
			{
				"SICore.主面板-游戏时间-模式Normal" ,
				{ "SICommon.游戏日期" , day , hour , minute }
			}
			tooltip =
			{
				"SICore.主面板-游戏时间-模式Normal-提示" ,
				{ "SICommon.实际日期" , dayReal , hourReal , minuteReal , secondReal } ,
				{ "SICommon.实际日期" , dayOnline , hourOnline , minuteOnline , secondOnline } ,
				player.surface.name
			}
		end
		settings.GameTime.view.caption = caption
		settings.GameTime.view.tooltip = tooltip
	end ,
	FreshPanel_KillCount = function( settings )
		local statistics = game.get_player( settings.playerIndex ).force.kill_count_statistics
		local totalCount = 0
		local bitCount = 0
		local spawnerCount = 0
		local turretCount = 0
		for name , count in pairs( statistics.input_counts ) do
			totalCount = totalCount + count
		end
		for name , data in pairs( game.get_filtered_entity_prototypes{ { filter = "type" , type = "unit" } } ) do
			bitCount = bitCount + statistics.get_input_count( name )
		end
		for name , data in pairs( game.get_filtered_entity_prototypes{ { filter = "type" , type = "unit-spawner" } } ) do
			spawnerCount = spawnerCount + statistics.get_input_count( name )
		end
		for name , data in pairs( game.get_filtered_entity_prototypes{ { filter = "type" , type = "turret" } } ) do
			turretCount = turretCount + statistics.get_input_count( name )
		end
		settings.KillCount.view.caption = { "SICore.主面板-击杀数量" , bitCount , spawnerCount , turretCount , totalCount-bitCount-spawnerCount-turretCount }
	end ,
	FreshPanel_Evolution = function( settings )
		local player = game.get_player( settings.playerIndex )
		settings.Evolution.view.caption =
		{
			"SICore.主面板-进化因子" ,
			SITools.FormatNumber4( game.forces.enemy.evolution_factor * 100 ) ,
			SITools.FormatNumber2( player.surface.get_pollution( player.position ) ) ,
			SITools.FormatNumber2( player.surface.get_total_pollution() )
		}
	end ,
	FreshPanel_NewMessage = function( settings )
		local listSize = #settings.Message.MessageList
		settings.NewMessage.view.caption = { "SICore.主面板-最新消息" , listSize > 0 and settings.Message.MessageList[listSize].title or { "SICore.主面板-最新消息-无" } }
	end ,
	FreshPanel_KeyNote = function( settings )
		local keyNoteIndex = settings.Note.KeyNoteIndex
		settings.KeyNote.view.caption = { "SICore.主面板-重点便签" , keyNoteIndex and settings.Note.NoteList[keyNoteIndex].title or { "SICore.主面板-重点便签-无" } }
	end ,
	FreshFrameAll = function()
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIMainData.Settings.Name ) ) do
			SIMainbar.FreshFrame( settings )
		end
	end ,
	FreshFrameAll_Tick = function()
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIMainData.Settings.Name ) ) do
			SIMainbar.FreshFrame_Tick( settings )
		end
	end ,
	OpenToolbar = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		if settings.Toolbar.panel then
			settings.Setting.Base.showToolbar = true
			SIMainbar.ShowPanel_Toolbar( settings )
		end
	end ,
	CloseToolbar = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		if settings.Toolbar.panel then
			settings.Setting.Base.showToolbar = false
			SIMainbar.HidePanel_Toolbar( settings )
		end
	end ,
	FreshToolbar = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		if settings.Toolbar.panel and settings.Setting.Base.showToolbar then
			SIMainbar.FreshPanel_Toolbar( settings )
		end
	end ,
	ClicktoolbarButton = function( playerIndex , toolbarButtonName , gameTick )
		local name = toolbarButtonName:sub( SIMainbar.Names.ToolbarButtonPosition )
		local toolbarButtonData = SITable.GetWithName( SIMainbar.ToolbarButtonDataList , name )
		if toolbarButtonData and toolbarButtonData.ActionRemoteInterfaceID and toolbarButtonData.ActionRemoteFunctionName then
			if remote.interfaces[toolbarButtonData.ActionRemoteInterfaceID] and remote.interfaces[toolbarButtonData.ActionRemoteInterfaceID][toolbarButtonData.ActionRemoteFunctionName] then
				if not toolbarButtonData.Permission or SIPermission.HasPermission( toolbarButtonData.Permission , playerIndex ) then
					remote.call( toolbarButtonData.ActionRemoteInterfaceID , toolbarButtonData.ActionRemoteFunctionName , playerIndex , toolbarButtonData.ID , gameTick )
				else
					SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( toolbarButtonData.Permission ) )
				end
			else
				SIPrint.Alert( playerIndex , { "SICore.主面板-工具栏按钮-功能失效" } )
			end
		end
	end ,
	ChangeGameSpeed = function( playerIndexModified , currentGameSpeed , isRightClick )
		local playerSettings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndexModified )
		if currentGameSpeed == nil then
			if isRightClick then
				currentGameSpeed = playerSettings.GameSpeed.speedLast or 1
				playerSettings.GameSpeed.speedLast = game.speed
			else
				if game.speed ~= 1 then
					playerSettings.GameSpeed.speedLast = game.speed
				end
				currentGameSpeed = 1
			end
		else
			playerSettings.GameSpeed.speedLast = game.speed
		end
		if currentGameSpeed < SIMainbar.GameSpeedMin then
			currentGameSpeed = SIMainbar.GameSpeedMin
		end
		if currentGameSpeed > SIMainbar.GameSpeedMax then
			currentGameSpeed = SIMainbar.GameSpeedMax
		end
		game.speed = currentGameSpeed
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIMainData.Settings.Name ) ) do
			if settings.mainbar and settings.Setting.Base.showGameSpeed then
				SIMainbar.FreshPanel_GameSpeed( settings )
			end
		end
	end ,
	FreshKillCount = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		if settings.KillCount.panel and settings.Setting.Base.showKillCount then
			SIMainbar.FreshPanel_KillCount( settings )
		end
	end ,
	SwitchGameTimeMode = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		if settings.GameTime.panel and settings.Setting.Base.showGameTime then
			-- 1 = 模式 Normal , 2 = 模式 Game , 3 = 模式 Real , 4 = 模式 Area
			settings.Setting.Base.showGameTimeMode = math.fmod( settings.Setting.Base.showGameTimeMode or 0 , SIMainbar.GameTimeModeCount ) + 1
			SIMainbar.FreshPanel_GameTime( settings )
		end
	end ,
	SaveSurfaceTime = function( surface_index )
		local globalSettings = SIGlobal.GetGlobalSettings( SIMainData.Settings.Name )
		local surface = game.get_surface( surface_index )
		if surface and surface.valid then
			globalSettings.SurfaceTime[surface.name] = game.ticks_played
		end
	end ,
	RemoveSurfaceTime = function( surface_index )
		local globalSettings = SIGlobal.GetGlobalSettings( SIMainData.Settings.Name )
		local surface = game.get_surface( surface_index )
		if surface then
			globalSettings.SurfaceTime[surface.name] = nil
		end
	end ,
	ChangeSurfaceTime = function( surface_index , oldName )
		local globalSettings = SIGlobal.GetGlobalSettings( SIMainData.Settings.Name )
		local surface = game.get_surface( surface_index )
		if surface and surface.valid then
			globalSettings.SurfaceTime[surface.name] = globalSettings.SurfaceTime[oldName] or 0
			globalSettings.SurfaceTime[oldName] = nil
		end
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ----- 接口函数 -- 主面板 -----------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------

	-- ----------------------------------------
	-- 当对主面板上的显示的原始游戏数据进行了调整时 , 可以通过此函数来刷新主面板<br>
	-- ----------------------------------------
	-- playerIndex       = 玩家索引<br>
	-- ----------------------------------------
	Fresh = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		SIMainbar.FreshFrame( settings )
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ----- 接口函数 -- 工具栏 -----------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------

	-- ----------------------------------------
	-- 展开指定玩家的工具栏<br>
	-- ----------------------------------------
	-- playerIndex       = 玩家索引<br>
	-- ----------------------------------------
	OpenToolbarByPlayerIndex = function( playerIndex )
		SIMainbar.OpenToolbar( playerIndex )
	end ,

	-- ----------------------------------------
	-- 收起指定玩家的工具栏<br>
	-- ----------------------------------------
	-- playerIndex       = 玩家索引<br>
	-- ----------------------------------------
	CloseToolbarByPlayerIndex = function( playerIndex )
		SIMainbar.CloseToolbar( playerIndex )
	end ,

	-- ----------------------------------------
	-- 展开所有玩家的工具栏<br>
	-- ----------------------------------------
	-- 无参数<br>
	-- ----------------------------------------
	OpenToolbars = function()
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIMainData.Settings.Name ) ) do
			SIMainbar.OpenToolbar( playerIndex )
		end
	end ,

	-- ----------------------------------------
	-- 收起所有玩家的工具栏<br>
	-- ----------------------------------------
	-- 无参数<br>
	-- ----------------------------------------
	CloseToolbars = function()
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIMainData.Settings.Name ) ) do
			SIMainbar.CloseToolbar( playerIndex )
		end
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- --- 接口函数 -- 工具栏按钮 ---------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------

	-- ----------------------------------------
	-- 在主面板上的工具栏注册一个新的按钮<br>
	-- 工具栏不会持久化保存按钮 , 因此每次启动游戏均需要进行注册<br>
	-- 当然 , 工具栏按钮是可以随用随加的 , 也可以随时取消注册<br>
	-- 如果拿不准之前是否注册过的话 , 可以再注册一次 , 可以放心注册<br>
	-- 除非之前已经注销了 , 否则 [ Name ] 属性相同的工具栏按钮只有第一次才会生效<br>
	-- 如果想游戏一开始就加上工具栏按钮 , 那么应该在 on_init 和 on_load 中都添加注册代码<br>
	-- 因为需要的属性比较多 , 不慎将 nil 作为参数传递进来后果自负<br>
	-- ----------------------------------------
	-- toolbarButtonData = 工具栏按钮数据包<br>
	-- ----------------------------------------
	-- 工具栏按钮数据包中包含的属性 :<br>
	-- ID                       = 工具栏按钮的 ID , 用于移除此工具栏按钮 , 以及用于内部函数调用 , 定义 ID 只是为了避免重名<br>
	-- Name                     = 工具栏按钮的名称 , 用于 on_gui_click 事件的判断 , 事件监听不需要手动添加 , 内部函数已经处理了 , 如果 Name 属性重复 , 那么在绘制控件时会弹窗<br>
	-- IconItemName             = 工具栏按钮的按钮图标所使用的物品原型的 [ name ] 值 , 因为一些设定 , 这里需要一个物品原型 , 并使用这个物品的图标图片来充当图标<br>
	-- LocalizedName            = 工具栏按钮的显示名称的本地化字符串 , 当然你愿意的话 , 也可以传递普通字符串<br>
	-- LocalizedDescription     = 工具栏按钮的提示信息的本地化字符串 , 当然你愿意的话 , 也可以传递普通字符串<br>
	-- ActionRemoteInterfaceID  = 工具栏按钮被点击时会执行一个 remote 接口函数 , 此项定义接口的名称 , 如果为 nil 则不会调用 remote 接口函数<br>
	-- ActionRemoteFunctionName = 工具栏按钮被点击时会执行一个 remote 接口函数 , 此项定义接口的函数名称<br>
	-- Permission               = 工具栏按钮需要的权限项目 , 如果没有相应的权限项目 , 则此工具栏按钮不会显示 , 不需要权限则填写 nil<br>
	-- Order                    = 工具栏按钮的排序字符串<br>
	-- ----------------------------------------
	-- 当工具栏按钮被玩家点击时 , 会立刻调用指定的 remote 接口函数<br>
	-- 每次调用时 , 都会传递三个参数 :<br>
	-- 参数 1 = 玩家索引<br>
	-- 参数 2 = 按钮的 ID 属性的值<br>
	-- 参数 3 = 游戏时间 , tick<br>
	-- ----------------------------------------
	RegisterToolbarButton = function( toolbarButtonData )
		if SITable.GetWithID( SIMainbar.ToolbarButtonDataList , toolbarButtonData.ID ) then
			return
		end
		if SITable.GetWithName( SIMainbar.ToolbarButtonDataList , toolbarButtonData.Name ) then
			return
		end
		table.insert( SIMainbar.ToolbarButtonDataList , toolbarButtonData )
		table.sort( SIMainbar.ToolbarButtonDataList , function( a , b )
			return a.Order < b.Order
		end )
		SIMainbar.ToolbarButtonDropDownList =
		{
			{ "SICore.主面板设置管理-窗口-设置-工具栏常用按钮-无" }
		}
		for index , currentToolbarButtonData in pairs( SIMainbar.ToolbarButtonDataList ) do
			table.insert( SIMainbar.ToolbarButtonDropDownList , { "SICore.主面板设置管理-窗口-设置-工具栏常用按钮-标题" , currentToolbarButtonData.LocalizedName } )
		end
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIMainData.Settings.Name ) ) do
			if settings.Toolbar.panel then
				SIMainbar.FreshPanel_Toolbar( settings )
			end
			if settings.Setting.frame and settings.Setting.frame.valid then
				SIMainbarSetting.FreshDropDown( settings )
			end
		end
	end ,

	-- ----------------------------------------
	-- 把一个工具栏按钮从主面板的工具栏中注销掉<br>
	-- 默认工具栏按钮无法被注销<br>
	-- ----------------------------------------
	-- toolbarButtonID   = 工具栏按钮名称<br>
	-- ----------------------------------------
	UnregisterToolbarButton = function( toolbarButtonID )
		local toolbarButtonData , index = SITable.GetWithID( SIMainbar.ToolbarButtonDataList , toolbarButtonID )
		if toolbarButtonData then
			table.remove( SIMainbar.ToolbarButtonDataList , index )
			table.remove( SIMainbar.ToolbarButtonDropDownList , index )
			for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIMainData.Settings.Name ) ) do
				if settings.Toolbar.panel then
					SIMainbar.FreshPanel_Toolbar( settings )
				end
				if settings.Setting.frame and settings.Setting.frame.valid then
					SIMainbarSetting.FreshDropDown( settings )
				end
			end
		end
	end
}

SIMainbar.Names.ToolbarButtonPosition = #SIMainbar.Names.ToolbarButtonPrefix + 1
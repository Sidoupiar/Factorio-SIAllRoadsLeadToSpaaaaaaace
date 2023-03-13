SIMainbarSetting =
{
	ID = "MainbarSetting" ,
	Name = "主面板设置管理" ,
	Names =
	{
		Prefix = "SI核心-主面板设置管理-" ,
		Frame = "SI核心-主面板设置管理-窗口" ,
		OK = "SI核心-主面板设置管理-确定" ,
		Close = "SI核心-主面板设置管理-取消" ,
		Fresh = "SI核心-主面板设置管理-刷新" ,
		Save = "SI核心-主面板设置管理-保存" ,
		Back = "SI核心-主面板设置管理-撤销" ,
		Reset = "SI核心-主面板设置管理-默认" ,
		ToolbarColumn = "SI核心-主面板设置管理-工具栏数量" ,
		ToolbarColumnText = "SI核心-主面板设置管理-工具栏数量文本"
	} ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 窗口函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	OpenFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		if settings.Setting.frame and settings.Setting.frame.valid then
			SIMainbarSetting.CloseFrame( playerIndex )
		else
			local player = game.get_player( playerIndex )
			-- 显示窗口 , 标题栏
			local frame = SIElements.CreateFrame( player , settings.Setting ,
			{
				Name         = SIMainbarSetting.Names.Frame ,
				Close        = SIMainbarSetting.Names.Close ,
				Style        = SIConstants_Core.raw.Styles.Mainbar_Setting_Frame ,
				Title        = { "SICore.主面板设置管理-窗口-标题" } ,
				TitleTooltip = { "SICore.主面板设置管理-窗口-标题-提示" } ,
				UseTooltip   = { "SICore.主面板设置管理-窗口-使用-提示" } ,
				CloseTooltip = { "SICore.主面板设置管理-窗口-关闭-提示" }
			} )
			-- 第 1 层
			local flow1 = frame.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
			flow1.add{ type = "label" , caption = { "SICore.主面板设置管理-窗口-说明" } , style = SIConstants_Core.raw.Styles.Mainbar_Setting_LabelTop }
			-- 第 2 层
			settings.Setting.list = frame
			.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Common_ScrollPane }
			.add{ type = "table" , column_count = 3 , style = SIConstants_Core.raw.Styles.Common_List }
			-- 第 3 层
			local flow3 = frame.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
			flow3.add{ type = "button" , name = SIMainbarSetting.Names.Reset , caption = { "SICore.主面板设置管理-窗口-默认" } , tooltip = { "SICore.主面板设置管理-窗口-默认-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonGray }
			flow3.add{ type = "button" , name = SIMainbarSetting.Names.Back , caption = { "SICore.主面板设置管理-窗口-撤销" } , tooltip = { "SICore.主面板设置管理-窗口-撤销-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonBlue }
			flow3.add{ type = "button" , name = SIMainbarSetting.Names.Save , caption = { "SICore.主面板设置管理-窗口-保存" } , tooltip = { "SICore.主面板设置管理-窗口-保存-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonGreen }
			flow3.add{ type = "button" , name = SIMainbarSetting.Names.Fresh , caption = { "SICore.主面板设置管理-窗口-刷新主面板" } , tooltip = { "SICore.主面板设置管理-窗口-刷新主面板-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonPurple }
			-- 第 4 层
			local flow4 = frame.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowRight }
			flow4.add{ type = "line" , direction = "horizontal" }
			-- 第 4.1 层
			local flow41 = flow4.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
			flow41.add{ type = "button" , name = SIMainbarSetting.Names.Close , caption = { "SICore.主面板设置管理-窗口-取消" } , tooltip = { "SICore.主面板设置管理-窗口-取消-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonRed }
			flow41.add{ type = "button" , name = SIMainbarSetting.Names.OK , caption = { "SICore.主面板设置管理-窗口-确定" } , tooltip = { "SICore.主面板设置管理-窗口-确定-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonGreen }
			-- 根据设置更新控件
			settings.Setting.back = SIUtils.table.deepcopy( settings.Setting.Base )
			settings.Setting.back.showMainbar = SISettings.PerUser.SICore.ShowMainbar( playerIndex )
			SIMainbarSetting.FreshList( settings )
		end
	end ,
	CloseFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		if settings.Setting.frame and settings.Setting.frame.valid then
			SIMainbarSetting.Save( settings , true )
			settings.Setting.frame.destroy()
			settings.Setting.frame = nil
			settings.Setting.list = nil
			for key , element in pairs( settings.Setting.Elements ) do
				settings.Setting.Elements[key] = nil
			end
			settings.Setting.back = nil
		end
	end ,
	MoveFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		if settings.Setting.frame and settings.Setting.frame.valid then
			SIElements.SaveFrameLocation( settings.Setting )
		end
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 功能函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	Save = function( settings , isClosing )
		local elements = settings.Setting.Elements
		local base = settings.Setting.Base
		local default = SIMainData.Settings.DefaultPlayer.Setting.Base
		-- 保存设置数据
		-- 主窗口
		local showMainbar = true
		if elements.itemMainbar then
			showMainbar = elements.itemMainbar.state
		end
		SISettings.PerUserChange.SICore.ShowMainbar( settings.playerIndex , showMainbar )
		-- 工具栏
		if elements.itemToolbar then
			base.showToolbar = elements.itemToolbar.state
		else
			base.showToolbar = default.showToolbar
		end
		-- 工具栏数量
		if elements.itemToolbarColumn then
			base.toolbarColumnCount = SITools.AsNumberInt( elements.itemToolbarColumn.slider_value , SIMainbar.ToolbarColumnMin , SIMainbar.ToolbarColumnMax )
		else
			base.toolbarColumnCount = default.toolbarColumnCount
		end
		-- 游戏速度
		if elements.itemGameSpeed then
			base.showGameSpeed = elements.itemGameSpeed.state
		else
			base.showGameSpeed = default.showGameSpeed
		end
		-- 游戏时间
		if elements.itemGameTime then
			base.showGameTime = elements.itemGameTime.state
		else
			base.showGameTime = default.showGameTime
		end
		-- 击杀数量
		if elements.itemKillCount then
			base.showKillCount = elements.itemKillCount.state
		else
			base.showKillCount = default.showKillCount
		end
		-- 进化因子
		if elements.itemEvolution then
			base.showEvolution = elements.itemEvolution.state
		else
			base.showEvolution = default.showEvolution
		end
		-- 最新消息
		if elements.itemNewMessage then
			base.showNewMessage = elements.itemNewMessage.state
		else
			base.showNewMessage = default.showNewMessage
		end
		-- 重点便签
		if elements.itemKeyNote then
			base.showKeyNote = elements.itemKeyNote.state
		else
			base.showKeyNote = default.showKeyNote
		end
		-- 从游戏设置读取
		if elements.itemLoadFromUser then
			base.loadFromUserSettings = elements.itemLoadFromUser.state
		else
			base.loadFromUserSettings = default.loadFromUserSettings
		end
		-- 工具栏常用按钮 1
		if elements.itemCommonToolbar1 then
			local selectedIndex = elements.itemCommonToolbar1.selected_index - 1
			base.commonToolbar1 = selectedIndex ~= 0 and selectedIndex or nil
		else
			base.commonToolbar1 = default.commonToolbar1
		end
		-- 工具栏常用按钮 2
		if elements.itemCommonToolbar2 then
			local selectedIndex = elements.itemCommonToolbar2.selected_index - 1
			base.commonToolbar2 = selectedIndex ~= 0 and selectedIndex or nil
		else
			base.commonToolbar2 = default.commonToolbar2
		end
		-- 应用设置数据
		-- 根据设置数据更新控件
		if showMainbar then
			if settings.mainbar and settings.mainbar.valid then
				SIMainbar.UpdateFrame( settings )
			else
				SIMainbar.OpenFrame( settings.playerIndex )
			end
		else
			SIMainbar.CloseFrame( settings.playerIndex )
		end
		if not isClosing then
			SIMainbarSetting.FreshList( settings )
		end
	end ,
	Back = function( settings )
		if not settings.Setting.back then
			return
		end
		local elements = settings.Setting.Elements
		local back = settings.Setting.back
		local default = SIMainData.Settings.DefaultPlayer.Setting.Base
		-- 修改控件的值
		if elements.itemMainbar then
			elements.itemMainbar.state = back.showMainbar
		end
		if elements.itemToolbar then
			elements.itemToolbar.state = back.showToolbar
		end
		if elements.itemToolbarColumn then
			elements.itemToolbarColumn.slider_value = back.toolbarColumnCount or default.toolbarColumnCount
		end
		if elements.itemToolbarColumnText then
			elements.itemToolbarColumnText.text = tostring( back.toolbarColumnCount or default.toolbarColumnCount )
		end
		if elements.itemGameSpeed then
			elements.itemGameSpeed.state = back.showGameSpeed
		end
		if elements.itemGameTime then
			elements.itemGameTime.state = back.showGameTime
		end
		if elements.itemKillCount then
			elements.itemKillCount.state = back.showKillCount
		end
		if elements.itemEvolution then
			elements.itemEvolution.state = back.showEvolution
		end
		if elements.itemNewMessage then
			elements.itemNewMessage.state = back.showNewMessage
		end
		if elements.itemKeyNote then
			elements.itemKeyNote.state = back.showKeyNote
		end
		if elements.itemLoadFromUser then
			elements.itemLoadFromUser.state = back.loadFromUserSettings
		end
		if elements.itemCommonToolbar1 then
			elements.itemCommonToolbar1.selected_index = ( back.commonToolbar1 or 0 ) + 1
		end
		if elements.itemCommonToolbar2 then
			elements.itemCommonToolbar2.selected_index = ( back.commonToolbar2 or 0 ) + 1
		end
	end ,
	Reset = function( settings )
		local elements = settings.Setting.Elements
		local default = SIMainData.Settings.DefaultPlayer.Setting.Base
		-- 修改控件的值
		if elements.itemMainbar then
			elements.itemMainbar.state = true
		end
		if elements.itemToolbar then
			elements.itemToolbar.state = default.showToolbar
		end
		if elements.itemToolbarColumn then
			elements.itemToolbarColumn.slider_value = default.toolbarColumnCount
		end
		if elements.itemToolbarColumnText then
			elements.itemToolbarColumnText.text = tostring( default.toolbarColumnCount )
		end
		if elements.itemGameSpeed then
			elements.itemGameSpeed.state = default.showGameSpeed
		end
		if elements.itemGameTime then
			elements.itemGameTime.state = default.showGameTime
		end
		if elements.itemKillCount then
			elements.itemKillCount.state = default.showKillCount
		end
		if elements.itemEvolution then
			elements.itemEvolution.state = default.showEvolution
		end
		if elements.itemNewMessage then
			elements.itemNewMessage.state = default.showNewMessage
		end
		if elements.itemKeyNote then
			elements.itemKeyNote.state = default.showKeyNote
		end
		if elements.itemLoadFromUser then
			elements.itemLoadFromUser.state = default.loadFromUserSettings
		end
		if elements.itemCommonToolbar1 then
			elements.itemCommonToolbar1.selected_index = ( default.commonToolbar1 or 0 ) + 1
		end
		if elements.itemCommonToolbar2 then
			elements.itemCommonToolbar2.selected_index = ( default.commonToolbar2 or 0 ) + 1
		end
	end ,
	FreshList = function( settings )
		local list = settings.Setting.list
		if list then
			list.clear()
			local elements = settings.Setting.Elements
			local base = settings.Setting.Base
			-- 第 1 层 , 主面板
			local flow1_Label = list.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListTitleFlow }
			flow1_Label.add{ type = "label" , caption = { "SICore.主面板设置管理-窗口-设置-主面板" } , tooltip = { "SICore.主面板设置管理-窗口-设置-主面板-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListLabel }
			flow1_Label.add{ type = "sprite" , sprite = "info" , tooltip = { "SICore.主面板设置管理-窗口-设置-主面板-提示" } }
			elements.itemMainbar = list.add{ type = "checkbox" , state = SISettings.PerUser.SICore.ShowMainbar( settings.playerIndex ) , tooltip = { "SICore.主面板设置管理-窗口-设置-主面板-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListCheck }
			list.add{ type = "label" , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListPlace }
			-- 第 2 层 , 工具栏
			local flow2_Label = list.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListTitleFlow }
			flow2_Label.add{ type = "label" , caption = { "SICore.主面板设置管理-窗口-设置-工具栏" } , tooltip = { "SICore.主面板设置管理-窗口-设置-工具栏-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListLabel }
			flow2_Label.add{ type = "sprite" , sprite = "info" , tooltip = { "SICore.主面板设置管理-窗口-设置-工具栏-提示" } }
			elements.itemToolbar = list.add{ type = "checkbox" , state = base.showToolbar , tooltip = { "SICore.主面板设置管理-窗口-设置-工具栏-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListCheck }
			list.add{ type = "label" , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListPlace }
			-- 第 3 层 , 工具栏按钮每行数量
			local flow3_Label = list.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListTitleFlow }
			flow3_Label.add{ type = "label" , caption = { "SICore.主面板设置管理-窗口-设置-工具栏按钮每行数量" } , tooltip = { "SICore.主面板设置管理-窗口-设置-工具栏按钮每行数量-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListLabel }
			flow3_Label.add{ type = "sprite" , sprite = "info" , tooltip = { "SICore.主面板设置管理-窗口-设置-工具栏按钮每行数量-提示" } }
			local toolbarColumn = settings.Setting.Base.toolbarColumnCount or SIMainData.Settings.DefaultPlayer.Setting.Base.toolbarColumnCount
			local flow3_flow = list.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListItemFlow }
			elements.itemToolbarColumn = flow3_flow.add
			{
				type = "slider" ,
				name = SIMainbarSetting.Names.ToolbarColumn ,
				value = toolbarColumn ,
				value_step = 1 ,
				minimum_value = SIMainbar.ToolbarColumnMin ,
				maximum_value = SIMainbar.ToolbarColumnMax ,
				discrete_slider = false ,
				discrete_values = true ,
				tooltip = { "SICore.主面板设置管理-窗口-设置-工具栏按钮每行数量-提示" } ,
				style = SIConstants_Core.raw.Styles.Mainbar_Setting_Slider
			}
			-- SIPrint.Print( SITable.TableToString( elements.itemToolbarColumn.children ) )
			elements.itemToolbarColumnText = flow3_flow.add
			{
				type = "textfield" ,
				name = SIMainbarSetting.Names.ToolbarColumnText ,
				text = tostring( toolbarColumn ) ,
				numeric = true ,
				tooltip = { "SICore.主面板设置管理-窗口-设置-工具栏按钮每行数量文本-提示" } ,
				style = SIConstants_Core.raw.Styles.Mainbar_Setting_Number
			}
			list.add{ type = "label" , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListPlace }
			-- 第 4 层 , 游戏速度
			local flow4_Label = list.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListTitleFlow }
			flow4_Label.add{ type = "label" , caption = { "SICore.主面板设置管理-窗口-设置-游戏速度" } , tooltip = { "SICore.主面板设置管理-窗口-设置-游戏速度-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListLabel }
			flow4_Label.add{ type = "sprite" , sprite = "info" , tooltip = { "SICore.主面板设置管理-窗口-设置-游戏速度-提示" } }
			elements.itemGameSpeed = list.add{ type = "checkbox" , state = base.showGameSpeed , tooltip = { "SICore.主面板设置管理-窗口-设置-游戏速度-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListCheck }
			list.add{ type = "label" , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListPlace }
			-- 第 5 层 , 游戏时间
			local flow5_Label = list.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListTitleFlow }
			flow5_Label.add{ type = "label" , caption = { "SICore.主面板设置管理-窗口-设置-游戏时间" } , tooltip = { "SICore.主面板设置管理-窗口-设置-游戏时间-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListLabel }
			flow5_Label.add{ type = "sprite" , sprite = "info" , tooltip = { "SICore.主面板设置管理-窗口-设置-游戏时间-提示" } }
			elements.itemGameTime = list.add{ type = "checkbox" , state = base.showGameTime , tooltip = { "SICore.主面板设置管理-窗口-设置-游戏时间-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListCheck }
			list.add{ type = "label" , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListPlace }
			-- 第 6 层 , 击杀数量
			local flow6_Label = list.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListTitleFlow }
			flow6_Label.add{ type = "label" , caption = { "SICore.主面板设置管理-窗口-设置-击杀数量" } , tooltip = { "SICore.主面板设置管理-窗口-设置-击杀数量-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListLabel }
			flow6_Label.add{ type = "sprite" , sprite = "info" , tooltip = { "SICore.主面板设置管理-窗口-设置-击杀数量-提示" } }
			elements.itemKillCount = list.add{ type = "checkbox" , state = base.showKillCount , tooltip = { "SICore.主面板设置管理-窗口-设置-击杀数量-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListCheck }
			list.add{ type = "label" , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListPlace }
			-- 第 7 层 , 进化因子
			local flow7_Label = list.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListTitleFlow }
			flow7_Label.add{ type = "label" , caption = { "SICore.主面板设置管理-窗口-设置-进化因子" } , tooltip = { "SICore.主面板设置管理-窗口-设置-进化因子-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListLabel }
			flow7_Label.add{ type = "sprite" , sprite = "info" , tooltip = { "SICore.主面板设置管理-窗口-设置-进化因子-提示" } }
			elements.itemEvolution = list.add{ type = "checkbox" , state = base.showEvolution , tooltip = { "SICore.主面板设置管理-窗口-设置-进化因子-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListCheck }
			list.add{ type = "label" , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListPlace }
			-- 第 8 层 , 最新消息
			local flow8_Label = list.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListTitleFlow }
			flow8_Label.add{ type = "label" , caption = { "SICore.主面板设置管理-窗口-设置-最新消息" } , tooltip = { "SICore.主面板设置管理-窗口-设置-最新消息-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListLabel }
			flow8_Label.add{ type = "sprite" , sprite = "info" , tooltip = { "SICore.主面板设置管理-窗口-设置-最新消息-提示" } }
			elements.itemNewMessage = list.add{ type = "checkbox" , state = base.showNewMessage , tooltip = { "SICore.主面板设置管理-窗口-设置-最新消息-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListCheck }
			list.add{ type = "label" , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListPlace }
			-- 第 9 层 , 重点便签
			local flow9_Label = list.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListTitleFlow }
			flow9_Label.add{ type = "label" , caption = { "SICore.主面板设置管理-窗口-设置-重点便签" } , tooltip = { "SICore.主面板设置管理-窗口-设置-重点便签-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListLabel }
			flow9_Label.add{ type = "sprite" , sprite = "info" , tooltip = { "SICore.主面板设置管理-窗口-设置-重点便签-提示" } }
			elements.itemKeyNote = list.add{ type = "checkbox" , state = base.showKeyNote , tooltip = { "SICore.主面板设置管理-窗口-设置-重点便签-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListCheck }
			list.add{ type = "label" , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListPlace }
			-- 第 10 层 , 从游戏设置读取
			local loadFromUserTooltip = { "SICore.主面板设置管理-窗口-设置-从游戏设置读取-提示" , game.mod_setting_prototypes[SIConstants_Core.raw.Settings.ShowMainbar].localised_name , { "gui-menu.settings" } , { "gui-menu.other" } , { "gui-other-settings.use-mod-settings-per-save" } }
			local flow10_Label = list.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListTitleFlow }
			flow10_Label.add{ type = "label" , caption = { "SICore.主面板设置管理-窗口-设置-从游戏设置读取" } , tooltip = loadFromUserTooltip , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListLabel }
			flow10_Label.add{ type = "sprite" , sprite = "info" , tooltip = loadFromUserTooltip }
			elements.itemLoadFromUser = list.add{ type = "checkbox" , state = base.loadFromUserSettings , tooltip = loadFromUserTooltip , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListCheck }
			list.add{ type = "label" , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListPlace }
			-- 第 11 层 , 工具栏常用按钮 1
			local flow11_Label = list.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListTitleFlow }
			flow11_Label.add{ type = "label" , caption = { "SICore.主面板设置管理-窗口-设置-工具栏常用按钮1" } , tooltip = { "SICore.主面板设置管理-窗口-设置-工具栏常用按钮1-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListLabel }
			flow11_Label.add{ type = "sprite" , sprite = "info" , tooltip = { "SICore.主面板设置管理-窗口-设置-工具栏常用按钮1-提示" } }
			elements.itemCommonToolbar1 = list.add{ type = "drop-down" , caption = { "SICore.主面板设置管理-窗口-设置-工具栏常用按钮-无" } , tooltip = { "SICore.主面板设置管理-窗口-设置-工具栏常用按钮1-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Setting_DropDown }
			list.add{ type = "label" , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListPlace }
			-- 第 12 层 , 工具栏常用按钮 2
			local flow12_Label = list.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListTitleFlow }
			flow12_Label.add{ type = "label" , caption = { "SICore.主面板设置管理-窗口-设置-工具栏常用按钮2" } , tooltip = { "SICore.主面板设置管理-窗口-设置-工具栏常用按钮2-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListLabel }
			flow12_Label.add{ type = "sprite" , sprite = "info" , tooltip = { "SICore.主面板设置管理-窗口-设置-工具栏常用按钮2-提示" } }
			elements.itemCommonToolbar2 = list.add{ type = "drop-down" , caption = { "SICore.主面板设置管理-窗口-设置-工具栏常用按钮-无" } , tooltip = { "SICore.主面板设置管理-窗口-设置-工具栏常用按钮2-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Setting_DropDown }
			list.add{ type = "label" , style = SIConstants_Core.raw.Styles.Mainbar_Setting_ListPlace }
			-- 根据设置更新控件
			SIMainbarSetting.FreshDropDown( settings )
		end
	end ,
	FreshDropDown = function( settings )
		local elements = settings.Setting.Elements
		local base = settings.Setting.Base
		if elements.itemCommonToolbar1 then
			elements.itemCommonToolbar1.items = SIMainbar.ToolbarButtonDropDownList
			local selectedIndex = ( base.commonToolbar1 or 0 ) + 1
			if selectedIndex > #SIMainbar.ToolbarButtonDropDownList then
				selectedIndex = 1
			end
			elements.itemCommonToolbar1.selected_index = selectedIndex
		end
		if elements.itemCommonToolbar2 then
			elements.itemCommonToolbar2.items = SIMainbar.ToolbarButtonDropDownList
			local selectedIndex = ( base.commonToolbar2 or 0 ) + 1
			if selectedIndex > #SIMainbar.ToolbarButtonDropDownList then
				selectedIndex = 1
			end
			elements.itemCommonToolbar2.selected_index = selectedIndex
		end
	end ,
	SaveSettings = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		if settings.Setting.frame and settings.Setting.frame.valid then
			SIMainbarSetting.Save( settings , false )
		end
	end ,
	BackSettings = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		if settings.Setting.frame and settings.Setting.frame.valid then
			SIMainbarSetting.Back( settings )
		end
	end ,
	ResetSettings = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		if settings.Setting.frame and settings.Setting.frame.valid then
			SIMainbarSetting.Reset( settings )
		end
	end ,
	ChangeToolbarColumn = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		local elements = settings.Setting.Elements
		if settings.Setting.frame and settings.Setting.frame.valid and elements.itemToolbarColumnText then
			local toolbarColumn = SITools.AsNumberInt( elements.itemToolbarColumn.slider_value , SIMainbar.ToolbarColumnMin , SIMainbar.ToolbarColumnMax )
			elements.itemToolbarColumnText.text = tostring( toolbarColumn )
		end
	end ,
	ChangeToolbarColumnText = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		local elements = settings.Setting.Elements
		if settings.Setting.frame and settings.Setting.frame.valid and elements.itemToolbarColumn then
			local toolbarColumn = SITools.AsNumberInt( elements.itemToolbarColumnText.text , SIMainbar.ToolbarColumnMin , SIMainbar.ToolbarColumnMax )
			elements.itemToolbarColumn.slider_value = toolbarColumn
		end
	end
}
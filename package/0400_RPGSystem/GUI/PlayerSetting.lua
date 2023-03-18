SIRPGPlayerSetting =
{
	ID = "RPGPlayerSetting" ,
	Name = "RPG玩家设置" ,
	InterfaceID = "SIRPGSystem-PlayerSetting" ,
	Names =
	{
		Prefix = "SIRPG系统-玩家设置-" ,
		Frame = "SIRPG系统-玩家设置-窗口" ,
		Open = "SIRPG系统-玩家设置-打开" ,
		OK = "SIRPG系统-玩家设置-确定" ,
		Close = "SIRPG系统-玩家设置-取消" ,
		Save = "SIRPG系统-玩家设置-保存" ,
		Back = "SIRPG系统-玩家设置-撤销" ,
		Reset = "SIRPG系统-玩家设置-默认" ,
		SkillColumnCount = "SIRPG系统-玩家设置-技能数量" ,
		SkillColumnCountText = "SIRPG系统-玩家设置-技能数量文本"
	} ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 窗口函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	OpenFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		if settings.PlayerSetting.frame and settings.PlayerSetting.frame.valid then
			SIRPGPlayerSetting.CloseFrame( playerIndex )
		else
			local player = game.get_player( playerIndex )
			-- 显示窗口
			local frame = SIElements.CreateFrame( player , settings.PlayerSetting ,
			{
				Name           = SIRPGPlayerSetting.Names.Frame ,
				Close          = SIRPGPlayerSetting.Names.Close ,
				Style          = SIConstants_RPGSystem.raw.Styles.PlayerSetting_Frame ,
				Title          = { "SIRPGSystem.玩家设置-窗口-标题" , player.name } ,
				TitleTooltip   = { "SIRPGSystem.玩家设置-窗口-标题-提示" } ,
				UseTooltip     = { "SIRPGSystem.玩家设置-窗口-使用-提示" } ,
				CloseTooltip   = { "SIRPGSystem.玩家设置-窗口-关闭-提示" }
			} )
			-- 第 1 层
			local flow1 = frame.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
			flow1.add{ type = "label" , caption = { "SIRPGSystem.玩家设置-窗口-说明" } , style = SIConstants_RPGSystem.raw.Styles.PlayerSetting_LabelTop }
			-- 第 2 层
			settings.PlayerSetting.list = frame
			.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Common_ScrollPane }
			.add{ type = "table" , column_count = 3 , style = SIConstants_Core.raw.Styles.Common_List }
			-- 第 3 层
			local flow3 = frame.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
			flow3.add{ type = "button" , name = SIRPGPlayerSetting.Names.Reset , caption = { "SIRPGSystem.玩家设置-窗口-默认" } , tooltip = { "SIRPGSystem.玩家设置-窗口-默认-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonGray }
			flow3.add{ type = "button" , name = SIRPGPlayerSetting.Names.Back , caption = { "SIRPGSystem.玩家设置-窗口-撤销" } , tooltip = { "SIRPGSystem.玩家设置-窗口-撤销-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonBlue }
			flow3.add{ type = "button" , name = SIRPGPlayerSetting.Names.Save , caption = { "SIRPGSystem.玩家设置-窗口-保存" } , tooltip = { "SIRPGSystem.玩家设置-窗口-保存-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonGreen }
			-- 第 4 层
			local flow4 = frame.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowRight }
			flow4.add{ type = "line" , direction = "horizontal" }
			-- 第 4.1 层
			local flow41 = flow4.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
			flow41.add{ type = "button" , name = SIRPGPlayerSetting.Names.Close , caption = { "SIRPGSystem.玩家设置-窗口-取消" } , tooltip = { "SIRPGSystem.玩家设置-窗口-取消-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonRed }
			flow41.add{ type = "button" , name = SIRPGPlayerSetting.Names.OK , caption = { "SIRPGSystem.玩家设置-窗口-确定" } , tooltip = { "SIRPGSystem.玩家设置-窗口-确定-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonGreen }
			-- 根据设置更新控件
			settings.PlayerSetting.back = SIUtils.table.deepcopy( settings.PlayerSetting.Base )
			SIRPGPlayerSetting.FreshList( settings )
		end
	end ,
	CloseFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		if settings.PlayerSetting.frame and settings.PlayerSetting.frame.valid then
			SIRPGPlayerSetting.Save( settings , true )
			settings.PlayerSetting.frame.destroy()
			settings.PlayerSetting.frame = nil
			settings.PlayerSetting.list = nil
			settings.PlayerSetting.Elements = {}
			settings.PlayerSetting.back = nil
		end
	end ,
	MoveFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		if settings.PlayerSetting.frame and settings.PlayerSetting.frame.valid then
			SIElements.SaveFrameLocation( settings.PlayerSetting )
		end
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 控件函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	FreshList = function( settings )
		local list = settings.PlayerSetting.list
		if list then
			list.clear()
			local elements = settings.PlayerSetting.Elements
			local base = settings.PlayerSetting.Base
			-- 第 1 层 , 显示悬浮文字提示
			local flow1_Label = list.add{ type = "flow" , direction = "horizontal" , style = SIConstants_RPGSystem.raw.Styles.PlayerSetting_ListTitleFlow }
			flow1_Label.add{ type = "label" , caption = { "SIRPGSystem.玩家设置-窗口-设置-显示悬浮文字提示" } , tooltip = { "SIRPGSystem.玩家设置-窗口-设置-显示悬浮文字提示-提示" } , style = SIConstants_RPGSystem.raw.Styles.PlayerSetting_ListLabel }
			flow1_Label.add{ type = "sprite" , sprite = "info" , tooltip = { "SIRPGSystem.玩家设置-窗口-设置-显示悬浮文字提示-提示" } }
			elements.itemFlyingText = list.add{ type = "checkbox" , state = base.showFlyingText , tooltip = { "SIRPGSystem.玩家设置-窗口-设置-显示悬浮文字提示-提示" } , style = SIConstants_RPGSystem.raw.Styles.PlayerSetting_ListCheck }
			list.add{ type = "label" , style = SIConstants_RPGSystem.raw.Styles.PlayerSetting_ListPlace }
			-- 第 2 层 , 玩家技能迷你每行显示的技能数量
			local flow2_Label = list.add{ type = "flow" , direction = "horizontal" , style = SIConstants_RPGSystem.raw.Styles.PlayerSetting_ListTitleFlow }
			flow2_Label.add{ type = "label" , caption = { "SIRPGSystem.玩家设置-窗口-设置-玩家技能迷你每行显示的技能数量" } , tooltip = { "SIRPGSystem.玩家设置-窗口-设置-玩家技能迷你每行显示的技能数量-提示" } , style = SIConstants_RPGSystem.raw.Styles.PlayerSetting_ListLabel }
			flow2_Label.add{ type = "sprite" , sprite = "info" , tooltip = { "SIRPGSystem.玩家设置-窗口-设置-玩家技能迷你每行显示的技能数量-提示" } }
			local skillColumnCount = settings.PlayerSetting.Base.skillColumnCount or SIRPGSystem.Settings.DefaultPlayer.PlayerSetting.Base.skillColumnCount
			local flow2_flow = list.add{ type = "flow" , direction = "horizontal" , style = SIConstants_RPGSystem.raw.Styles.PlayerSetting_ListItemFlow }
			elements.itemSkillColumnCount = flow2_flow.add
			{
				type = "slider" ,
				name = SIRPGPlayerSetting.Names.SkillColumnCount ,
				value = skillColumnCount ,
				value_step = 1 ,
				minimum_value = SIRPGPlayerSkillMini.ListColumnMin ,
				maximum_value = SIRPGPlayerSkillMini.ListColumnMax ,
				discrete_slider = false ,
				discrete_values = true ,
				tooltip = { "SIRPGSystem.玩家设置-窗口-设置-玩家技能迷你每行显示的技能数量-提示" } ,
				style = SIConstants_RPGSystem.raw.Styles.PlayerSetting_Slider
			}
			elements.itemSkillColumnCountText = flow2_flow.add
			{
				type = "textfield" ,
				name = SIRPGPlayerSetting.Names.SkillColumnCountText ,
				text = tostring( skillColumnCount ) ,
				numeric = true ,
				tooltip = { "SIRPGSystem.玩家设置-窗口-设置-玩家技能迷你每行显示的技能数量-提示" } ,
				style = SIConstants_RPGSystem.raw.Styles.PlayerSetting_Number
			}
			list.add{ type = "label" , style = SIConstants_RPGSystem.raw.Styles.PlayerSetting_ListPlace }
			-- 根据设置更新控件
		end
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 功能函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	Save = function( settings , isClosing )
		local elements = settings.PlayerSetting.Elements
		local base = settings.PlayerSetting.Base
		local default = SIRPGSystem.Settings.DefaultPlayer.PlayerSetting.Base
		-- 保存设置数据
		-- 显示悬浮文字提示
		if elements.itemFlyingText then
			base.showFlyingText = elements.itemFlyingText.state
		else
			base.showFlyingText = default.showFlyingText
		end
		-- 玩家技能迷你每行显示的技能数量
		if elements.itemSkillColumnCount then
			base.skillColumnCount = SITools.AsNumberInt( elements.itemSkillColumnCount.slider_value , SIRPGPlayerSkillMini.ListColumnMin , SIRPGPlayerSkillMini.ListColumnMax )
		else
			base.skillColumnCount = default.skillColumnCount
		end
		-- 应用设置数据
		-- 根据设置数据更新控件
		if settings.PlayerSkillMini.frame and settings.PlayerSkillMini.frame.valid then
			SIRPGPlayerSkillMini.CloseFrame( settings.playerIndex )
			SIRPGPlayerSkillMini.OpenFrame( settings.playerIndex )
		end
		if not isClosing then
			SIRPGPlayerSetting.FreshList( settings )
		end
	end ,
	Back = function( settings )
		if not settings.PlayerSetting.back then
			return
		end
		local elements = settings.PlayerSetting.Elements
		local back = settings.PlayerSetting.back
		local default = SIRPGSystem.Settings.DefaultPlayer.PlayerSetting.Base
		-- 修改控件的值
		if elements.itemFlyingText then
			elements.itemFlyingText.state = back.showFlyingText
		end
		if elements.itemSkillColumnCount then
			elements.itemSkillColumnCount.slider_value = back.skillColumnCount or default.skillColumnCount
		end
		if elements.itemSkillColumnCountText then
			elements.itemSkillColumnCountText.text = tostring( back.skillColumnCount or default.skillColumnCount )
		end
	end ,
	Reset = function( settings )
		local elements = settings.PlayerSetting.Elements
		local default = SIRPGSystem.Settings.DefaultPlayer.PlayerSetting.Base
		-- 修改控件的值
		if elements.itemFlyingText then
			elements.itemFlyingText.state = default.showFlyingText
		end
		if elements.itemSkillColumnCount then
			elements.itemSkillColumnCount.slider_value = default.skillColumnCount
		end
		if elements.itemSkillColumnCountText then
			elements.itemSkillColumnCountText.text = tostring( default.skillColumnCount )
		end
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 事件函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	SaveSettings = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		if settings.PlayerSetting.frame and settings.PlayerSetting.frame.valid then
			SIRPGPlayerSetting.Save( settings , false )
		end
	end ,
	BackSettings = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		if settings.PlayerSetting.frame and settings.PlayerSetting.frame.valid then
			SIRPGPlayerSetting.Back( settings )
		end
	end ,
	ResetSettings = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		if settings.PlayerSetting.frame and settings.PlayerSetting.frame.valid then
			SIRPGPlayerSetting.Reset( settings )
		end
	end ,
	ChangeSkillColumnCount = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local elements = settings.PlayerSetting.Elements
		if settings.PlayerSetting.frame and settings.PlayerSetting.frame.valid and elements.itemSkillColumnCountText then
			local skillColumnCount = SITools.AsNumberInt( elements.itemSkillColumnCount.slider_value , SIRPGPlayerSkillMini.ListColumnMin , SIRPGPlayerSkillMini.ListColumnMax )
			elements.itemSkillColumnCountText.text = tostring( skillColumnCount )
		end
	end ,
	ChangeSkillColumnCountText = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local elements = settings.PlayerSetting.Elements
		if settings.PlayerSetting.frame and settings.PlayerSetting.frame.valid and elements.itemSkillColumnCount then
			local skillColumnCount = SITools.AsNumberInt( elements.itemSkillColumnCountText.text , SIRPGPlayerSkillMini.ListColumnMin , SIRPGPlayerSkillMini.ListColumnMax )
			elements.itemSkillColumnCount.slider_value = skillColumnCount
		end
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ---- 接口函数 -- 导入导出 ----------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------

	-- ----------------------------------------
	-- 导入数据<br>
	-- ----------------------------------------
	-- playerIndex    = 点击按钮的玩家索引<br>
	-- data           = 导出时保存的数据 , 根据导出时导出接口函数返回的数据 , 此参数可能为 nil<br>
	-- settingsDataID = 导入导出设置数据包的 ID<br>
	-- gameTick       = 导出数据时的游戏时间 , tick<br>
	-- ----------------------------------------
	ImpoerSettingsData = function( playerIndex , data , settingsDataID , gameTick )
		if not data then
			return
		end
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		settings.PlayerSetting.Base = data
		SIRPGPlayerSetting.FreshList( settings )
		SIRPGPlayerSetting.Save( settings , false )
	end ,

	-- ----------------------------------------
	-- 导出数据<br>
	-- ----------------------------------------
	-- playerIndex    = 点击按钮的玩家索引<br>
	-- settingsDataID = 导入导出设置数据包的 ID<br>
	-- gameTick       = 当前的游戏时间 , tick<br>
	-- ----------------------------------------
	-- 返回值 = 导出的数据<br>
	-- ----------------------------------------
	ExportSettingsData = function( playerIndex , settingsDataID , gameTick )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		return settings.PlayerSetting.Base
	end
}

SIRPGPlayerSetting.SettingsData =
{
	ID = "SIRPG系统-玩家设置" ,
	ImportRemoteInterfaceID = SIRPGPlayerSetting.InterfaceID ,
	ImportRemoteFunctionName = "ImpoerSettingsData" ,
	ExportRemoteInterfaceID = SIRPGPlayerSetting.InterfaceID ,
	ExportRemoteFunctionName = "ExportSettingsData"
}
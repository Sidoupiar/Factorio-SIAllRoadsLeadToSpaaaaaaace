SIMainbarMessage =
{
	ID = "MainbarMessage" ,
	Code = "MainbarMessage" ,
	Show = "主面板消息管理" ,
	InterfaceID = "SICore-MainbarMessage" ,
	Names =
	{
		Prefix = "SI核心-主面板消息管理-" ,
		Frame = "SI核心-主面板消息管理-窗口" ,
		Clear = "SI核心-主面板消息管理-清空" ,
		Close = "SI核心-主面板消息管理-关闭" ,
		MessagePrefix = "SI核心-主面板消息管理-消息-"
	} ,
	MessageTypes =
	{
		Normal  = 1 ,
		Back    = 2 ,
		Tip     = 3 ,
		Warn    = 4 ,
		Error   = 5 ,
		Special = 6
	} ,
	MessageCountMax = 100 ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 窗口函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	OpenFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		if settings.Message.frame and settings.Message.frame.valid then
			SIMainbarMessage.CloseFrame( playerIndex )
		else
			local player = game.get_player( playerIndex )
			-- 显示窗口
			local frame = SIElements.CreateFrame( player , settings.Message ,
			{
				Name           = SIMainbarMessage.Names.Frame ,
				Setting        = SIMainbar.Names.Setting ,
				Close          = SIMainbarMessage.Names.Close ,
				Style          = SIConstants_Core.raw.Styles.Mainbar_Message_Frame ,
				Title          = { "SICore.主面板消息管理-窗口-标题" } ,
				TitleTooltip   = { "SICore.主面板消息管理-窗口-标题-提示" } ,
				UseTooltip     = { "SICore.主面板消息管理-窗口-使用-提示" } ,
				SettingTooltip = { "SICore.主面板消息管理-窗口-设置-提示" } ,
				CloseTooltip   = { "SICore.主面板消息管理-窗口-关闭-提示" }
			} )
			-- 第 1 层
			local flow1 = frame.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
			flow1.add{ type = "label" , caption = { "SICore.主面板消息管理-窗口-说明" } , style = SIConstants_Core.raw.Styles.Mainbar_Message_LabelTop }
			-- 第 2 层
			settings.Message.list = frame
			.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Common_ScrollPane }
			.add{ type = "table" , column_count = 1 , style = SIConstants_Core.raw.Styles.Common_List }
			-- 第 3 层
			local flow3 = frame.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
			flow3.add{ type = "button" , name = SIMainbarMessage.Names.Clear , caption = { "SICore.主面板消息管理-窗口-清空" } , tooltip = { "SICore.主面板消息管理-窗口-清空-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonRed }
			-- 根据设置更新控件
			SIMainbarMessage.FreshList( settings )
		end
	end ,
	CloseFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		if settings.Message.frame and settings.Message.frame.valid then
			settings.Message.frame.destroy()
			settings.Message.frame = nil
			settings.Message.list = nil
		end
	end ,
	MoveFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		if settings.Message.frame and settings.Message.frame.valid then
			SIElements.SaveFrameLocation( settings.Message )
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 控件函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	FreshList = function( settings )
		local list = settings.Message.list
		if list then
			list.clear()
			if #settings.Message.MessageList < 1 then
				SIMainbarMessage.AddNoneButton( list )
			else
				for index , messageData in pairs( settings.Message.MessageList ) do
					SIMainbarMessage.AddMessageButton( list , messageData )
				end
			end
		end
	end ,
	-- ======================================================================
	-- 这是一个内部函数 , 请勿外部调用<br>
	-- ======================================================================
	AddMessageButton = function( list , messageData )
		local button = list.add{ type = "button" , name = SIMainbarMessage.Names.MessagePrefix .. messageData.ID , tooltip = { "SICore.主面板消息管理-窗口-列表消息-提示" } , index = 1 , style = SIMainbarMessage.MessageButtonTypes[messageData.type] }
		local flow = button.add{ type = "flow" , direction = "vertical" , ignored_by_interaction = true , style = SIConstants_Core.raw.Styles.Mainbar_Message_ListFlow }
		flow.add{ type = "label" , ignored_by_interaction = true , caption = messageData.title , style = SIConstants_Core.raw.Styles.Mainbar_Message_ListTitle }
		flow.add{ type = "label" , ignored_by_interaction = true , caption = messageData.content , style = SIConstants_Core.raw.Styles.Mainbar_Message_ListContent }
	end ,
	-- ======================================================================
	-- 这是一个内部函数 , 请勿外部调用<br>
	-- ======================================================================
	AddNoneButton = function( list )
		local button = list.add{ type = "button" , tooltip = { "SICore.主面板消息管理-窗口-列表消息-无-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Message_ListMessageTip }
		local flow = button.add{ type = "flow" , direction = "vertical" , ignored_by_interaction = true , style = SIConstants_Core.raw.Styles.Mainbar_Message_ListFlow }
		flow.add{ type = "label" , ignored_by_interaction = true , caption = { "SICore.主面板消息管理-窗口-列表消息-无-标题" } , style = SIConstants_Core.raw.Styles.Mainbar_Message_ListTitle }
		flow.add{ type = "label" , ignored_by_interaction = true , caption = { "SICore.主面板消息管理-窗口-列表消息-无-内容" } , style = SIConstants_Core.raw.Styles.Mainbar_Message_ListContent }
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
	ReadMessage = function( playerIndex , name , element )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		local messageID = name:sub( SIMainbarMessage.Names.MessagePosition )
		local messageData , index = SITable.GetWithID( settings.Message.MessageList , messageID )
		if messageData then
			table.remove( settings.Message.MessageList , index )
			if element then
				element.destroy()
			end
			if #settings.Message.MessageList < 1 then
				local list = settings.Message.list
				if list then
					list.clear()
					SIMainbarMessage.AddNoneButton( list )
				end
			end
			if settings.Setting.Base.showNewMessage then
				SIMainbar.FreshPanel_NewMessage( settings )
			end
		end
	end ,
	ClearMessage = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		settings.Message.MessageList = {}
		if settings.Message.frame and settings.Message.frame.valid then
			SIMainbarMessage.FreshList( settings )
			if settings.Setting.Base.showNewMessage then
				SIMainbar.FreshPanel_NewMessage( settings )
			end
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 接口函数 - 窗口 =================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================
	-- 打开指定玩家的消息管理窗口<br>
	-- ======================================================================
	-- playerIndex       = 玩家索引<br>
	-- ======================================================================
	OpenFrameByPlayerIndex = function( playerIndex )
		SIMainbarMessage.OpenFrame( playerIndex )
	end ,

	-- ======================================================================
	-- 关闭指定玩家的消息管理窗口<br>
	-- ======================================================================
	-- playerIndex       = 玩家索引<br>
	-- ======================================================================
	CloseFrameByPlayerIndex = function( playerIndex )
		SIMainbarMessage.CloseFrame( playerIndex )
	end ,

	-- ======================================================================
	-- 打开所有玩家的消息管理窗口<br>
	-- ======================================================================
	-- 无参数<br>
	-- ======================================================================
	OpenFrames = function()
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIMainData.Settings.Name ) ) do
			SIMainbarMessage.OpenFrame( playerIndex )
		end
	end ,

	-- ======================================================================
	-- 关闭所有玩家的消息管理窗口<br>
	-- ======================================================================
	-- 无参数<br>
	-- ======================================================================
	CloseFrames = function()
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIMainData.Settings.Name ) ) do
			SIMainbarMessage.CloseFrame( playerIndex )
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 接口函数 - 消息列表 =============================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================
	-- 给指定玩家添加一条消息<br>
	-- 由于一些技术原因 , 目前最多只能显示 3 行消息内容 , 且消息部分的文字不要改变字体大小<br>
	-- ======================================================================
	-- playerIndex       = 玩家索引<br>
	-- messageName       = 消息的 [ name ] 值 , 从接口中删除消息需要使用这个属性<br>
	-- title             = 消息的标题<br>
	-- content           = 消息的内容<br>
	-- type              = 消息按钮的颜色 , 参考值请见 SIMainbarMessage.MessageTypes<br>
	-- ======================================================================
	AddMessage = function( playerIndex , messageName , title , content , type )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		settings.Message.MessageOrder = settings.Message.MessageOrder + 1
		local messageData =
		{
			ID = tostring( settings.Message.MessageOrder ) ,
			Name = messageName ,
			title = title ,
			content = content ,
			type = SIMainbarMessage.MessageTypes[type] and type or SIMainbarMessage.MessageTypes.Normal
		}
		local messageList = settings.Message.MessageList
		table.insert( messageList , messageData )
		local messageCount = #messageList
		while messageCount > SIMainbarMessage.MessageCountMax do
			table.remove( messageList , 1 )
			messageCount = #messageList
		end
		if settings.Message.frame and settings.Message.frame.valid then
			local list = settings.Message.list
			if messageCount == 1 then
				list.clear()
			end
			SIMainbarMessage.AddMessageButton( list , messageData )
		end
		if settings.Setting.Base.showNewMessage then
			SIMainbar.FreshPanel_NewMessage( settings )
		end
	end ,

	-- ======================================================================
	-- 删除指定玩家的一条消息<br>
	-- 如果多条消息拥有相同的 [ name ] 属性 , 那么会删除匹配到的第一条消息<br>
	-- ======================================================================
	-- playerIndex       = 玩家索引<br>
	-- messageName       = 消息的 [ name ] 值 , 从接口中删除消息需要使用这个属性<br>
	-- ======================================================================
	RemoveMessage = function( playerIndex , messageName )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		local messageData , index = SITable.GetWithName( settings.Message.MessageList , messageName )
		if messageData then
			table.remove( settings.Message.MessageList , index )
			if settings.Message.frame and settings.Message.frame.valid then
				if #settings.Message.MessageList < 1 then
					local list = settings.Message.list
					list.clear()
					SIMainbarMessage.AddNoneButton( list )
				else
					local messageID = SIMainbarMessage.Names.MessagePrefix .. messageData.ID
					for index , messageButton in pairs( settings.Message.list.children ) do
						if messageButton.name == messageID then
							messageButton.destroy()
							break
						end
					end
				end
			end
			if settings.Setting.Base.showNewMessage then
				SIMainbar.FreshPanel_NewMessage( settings )
			end
		end
	end
}

SIMainbarMessage.Names.MessagePosition = #SIMainbarMessage.Names.MessagePrefix + 1

-- 消息类型相关数据
SIMainbarMessage.MessageButtonTypes =
{
	[SIMainbarMessage.MessageTypes.Normal]  = SIConstants_Core.raw.Styles.Mainbar_Message_ListMessageNormal ,
	[SIMainbarMessage.MessageTypes.Back]    = SIConstants_Core.raw.Styles.Mainbar_Message_ListMessageBack ,
	[SIMainbarMessage.MessageTypes.Tip]     = SIConstants_Core.raw.Styles.Mainbar_Message_ListMessageTip ,
	[SIMainbarMessage.MessageTypes.Warn]    = SIConstants_Core.raw.Styles.Mainbar_Message_ListMessageWarn ,
	[SIMainbarMessage.MessageTypes.Error]   = SIConstants_Core.raw.Styles.Mainbar_Message_ListMessageError ,
	[SIMainbarMessage.MessageTypes.Special] = SIConstants_Core.raw.Styles.Mainbar_Message_ListMessageSpecial
}
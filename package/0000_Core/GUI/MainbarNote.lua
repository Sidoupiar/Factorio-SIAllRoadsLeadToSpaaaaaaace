SIMainbarNote =
{
	ID = "MainbarNote" ,
	Name = "主面板便签管理" ,
	InterfaceID = "SICore-MainbarNote" ,
	Names =
	{
		Prefix = "SI核心-主面板便签管理-" ,
		Frame = "SI核心-主面板便签管理-窗口" ,
		New = "SI核心-主面板便签管理-新增" ,
		Save = "SI核心-主面板便签管理-保存" ,
		Cancel = "SI核心-主面板便签管理-取消" ,
		SaveAs = "SI核心-主面板便签管理-另存" ,
		Close = "SI核心-主面板便签管理-关闭" ,
		NotePrefix = "SI核心-主面板便签管理-便签-" ,
		DeletePrefix = "SI核心-主面板便签管理-删除-"
	} ,
	NoteCountMax = 100 ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 窗口函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	OpenFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		if settings.Note.frame and settings.Note.frame.valid then
			SIMainbarNote.CloseFrame( playerIndex )
		else
			local player = game.get_player( playerIndex )
			-- 显示窗口
			local frame = SIElements.CreateFrame( player , settings.Note ,
			{
				Name           = SIMainbarNote.Names.Frame ,
				Setting        = SIMainbar.Names.Setting ,
				Close          = SIMainbarNote.Names.Close ,
				Style          = SIConstants_Core.raw.Styles.Mainbar_Note_Frame ,
				Title          = { "SICore.主面板便签管理-窗口-标题" } ,
				TitleTooltip   = { "SICore.主面板便签管理-窗口-标题-提示" } ,
				UseTooltip     = { "SICore.主面板便签管理-窗口-使用-提示" } ,
				SettingTooltip = { "SICore.主面板便签管理-窗口-设置-提示" } ,
				CloseTooltip   = { "SICore.主面板便签管理-窗口-关闭-提示" }
			} )
			-- 第 1 层
			local flow1 = frame.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
			flow1.add{ type = "label" , caption = { "SICore.主面板便签管理-窗口-说明" } , style = SIConstants_Core.raw.Styles.Mainbar_Note_LabelTop }
			-- 第 2 层
			local flow2 = frame.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
			-- 第 2.1 层
			local flow21 = flow2.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			-- 第 2.1.1 层
			settings.Note.list = flow21
			.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Common_ScrollPane }
			.add{ type = "table" , column_count = 2 , style = SIConstants_Core.raw.Styles.Common_List }
			-- 第 2.1.2 层
			local flow212 = flow21.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
			flow212.add{ type = "button" , name = SIMainbarNote.Names.New , caption = { "SICore.主面板便签管理-窗口-新增" } , tooltip = { "SICore.主面板便签管理-窗口-新增-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonGreen }
			-- 第 2.2 层
			settings.Note.edit = flow2.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Mainbar_Note_RightFlow }
			settings.Note.edit.visible = false
			-- 根据设置更新控件
			SIMainbarNote.FreshList( settings )
		end
	end ,
	CloseFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		if settings.Note.frame and settings.Note.frame.valid then
			settings.Note.frame.destroy()
			settings.Note.frame = nil
			settings.Note.list = nil
			settings.Note.edit = nil
			for key , value in pairs( settings.Note.Elements ) do
				settings.Note.Elements[key] = nil
			end
		end
	end ,
	MoveFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		if settings.Note.frame and settings.Note.frame.valid then
			SIElements.SaveFrameLocation( settings.Note )
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 控件函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	ShowEdit = function( settings , noteID , defaultNoteData )
		-- 读取数据
		local noteData = nil
		if noteID then
			noteData = SITable.GetWithID( settings.Note.NoteList , noteID )
		else
			if #settings.Note.NoteList > SIMainbarNote.NoteCountMax then
				SIPrint.Warning( settings.playerIndex , { "SICore.主面板便签管理-设置-便签过多" } )
				return
			end
		end
		local elements = settings.Note.Elements
		-- 清理布局
		local edit = settings.Note.edit
		edit.visible = true
		edit.clear()
		-- 第 1 层 , 便签 ID
		local flow1 = edit.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
		flow1.add{ type = "label" , caption = { "SICore.主面板便签管理-窗口-便签-ID" , noteData and noteData.ID or { "SICore.主面板便签管理-窗口-便签-ID-无" } } , style = SIConstants_Core.raw.Styles.Mainbar_Note_EditLabel }
		elements.id = flow1.add{ type = "label" , caption = noteData and noteData.ID or "" }
		elements.id.visible = false
		-- 分隔
		edit.add{ type = "line" , direction = "horizontal" }
		-- 第 2 层 , 便签标题
		local flow2 = edit.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
		local flow21 = flow2.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Mainbar_Note_EditFlow }
		flow21.add{ type = "label" , caption = { "SICore.主面板便签管理-窗口-便签-标题" } , tooltip = { "SICore.主面板便签管理-窗口-便签-标题-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Note_EditLabel }
		flow21.add{ type = "sprite" , sprite = "info" , tooltip = { "SICore.主面板便签管理-窗口-便签-标题-提示" } }
		elements.title = flow2.add{ type = "textfield" , text = noteData and noteData.title or defaultNoteData and defaultNoteData.title or "" , tooltip = { "SICore.主面板便签管理-窗口-便签-标题-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Note_EditTitle }
		-- 第 3 层 , 便签内容
		local flow3 = edit.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
		local flow31 = flow3.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Mainbar_Note_EditFlow }
		flow31.add{ type = "label" , caption = { "SICore.主面板便签管理-窗口-便签-内容" } , tooltip = { "SICore.主面板便签管理-窗口-便签-内容-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Note_EditLabel }
		flow31.add{ type = "sprite" , sprite = "info" , tooltip = { "SICore.主面板便签管理-窗口-便签-内容-提示" } }
		elements.content = flow3.add{ type = "text-box" , text = noteData and noteData.content or defaultNoteData and defaultNoteData.content or "" , tooltip = { "SICore.主面板便签管理-窗口-便签-内容-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Note_EditContent }
		-- 第 4 层 , 排序字符
		local flow4 = edit.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
		local flow41 = flow4.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Mainbar_Note_EditFlow }
		flow41.add{ type = "label" , caption = { "SICore.主面板便签管理-窗口-便签-排序" } , tooltip = { "SICore.主面板便签管理-窗口-便签-排序-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Note_EditLabel }
		flow41.add{ type = "sprite" , sprite = "info" , tooltip = { "SICore.主面板便签管理-窗口-便签-排序-提示" } }
		elements.order = flow4.add{ type = "textfield" , text = noteData and noteData.order or defaultNoteData and defaultNoteData.order or "01" , tooltip = { "SICore.主面板便签管理-窗口-便签-排序-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Note_EditOrder }
		-- 第 5 层 , 便签重点
		local flow5 = edit.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowRight }
		flow5.add{ type = "line" , direction = "horizontal" }
		local flow51 = flow5.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
		elements.isKey = flow51.add{ type = "checkbox" , state = noteData and noteData.isKey or defaultNoteData and defaultNoteData.isKey or false , caption = { "SICore.主面板便签管理-窗口-便签-重点" } , tooltip = { "SICore.主面板便签管理-窗口-便签-重点-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Note_EditCheck }
		flow51.add{ type = "sprite" , sprite = "info" , tooltip = { "SICore.主面板便签管理-窗口-便签-重点-提示" } }
		-- 第 6 层 , 操作按钮
		local flow6 = edit.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowRight }
		flow6.add{ type = "line" , direction = "horizontal" }
		local flow61 = flow6.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
		flow61.add{ type = "button" , name = SIMainbarNote.Names.SaveAs , caption = { "SICore.主面板便签管理-窗口-另存" } , tooltip = { "SICore.主面板便签管理-窗口-另存-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonBlue }
		flow61.add{ type = "button" , name = SIMainbarNote.Names.Cancel , caption = { "SICore.主面板便签管理-窗口-取消" } , tooltip = { "SICore.主面板便签管理-窗口-取消-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonRed }
		flow61.add{ type = "button" , name = SIMainbarNote.Names.Save , caption = { "SICore.主面板便签管理-窗口-保存" } , tooltip = { "SICore.主面板便签管理-窗口-保存-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonGreen }
	end ,
	HideEdit = function( settings )
		settings.Note.edit.clear()
		settings.Note.edit.visible = false
		for key , value in pairs( settings.Note.Elements ) do
			settings.Note.Elements[key] = nil
		end
	end ,
	FreshList = function( settings )
		local list = settings.Note.list
		if list then
			list.clear()
			if #settings.Note.NoteList < 1 then
				SIMainbarNote.AddNoneButton( list )
			else
				if settings.Note.KeyNoteIndex then
					SIMainbarNote.AddNoteButton( list , settings.Note.NoteList[settings.Note.KeyNoteIndex] )
				end
				for index , noteData in pairs( settings.Note.NoteList ) do
					if index ~= settings.Note.KeyNoteIndex then
						SIMainbarNote.AddNoteButton( list , noteData )
					end
				end
			end
		end
	end ,
	-- ======================================================================
	-- 这是一个内部函数 , 请勿外部调用<br>
	-- ======================================================================
	AddNoteButton = function( list , noteData )
		local button1 = list.add{ type = "button" , name = SIMainbarNote.Names.NotePrefix .. noteData.ID , tooltip = { "SICore.主面板便签管理-窗口-列表便签-提示" } , style = noteData.isKey and SIConstants_Core.raw.Styles.Mainbar_Note_ListNoteKey or SIConstants_Core.raw.Styles.Mainbar_Note_ListNoteNormal }
		local flow = button1.add{ type = "flow" , direction = "vertical" , ignored_by_interaction = true , style = SIConstants_Core.raw.Styles.Mainbar_Note_ListFlow }
		flow.add{ type = "label" , ignored_by_interaction = true , caption = noteData.title , style = SIConstants_Core.raw.Styles.Mainbar_Note_ListTitle }
		flow.add{ type = "label" , ignored_by_interaction = true , caption = noteData.content , style = SIConstants_Core.raw.Styles.Mainbar_Note_ListContent }
		list.add{ type = "sprite-button" , name = SIMainbarNote.Names.DeletePrefix .. noteData.ID , sprite = "item/" .. SIConstants_Core.raw.Items.IconClose , tooltip = { "SICore.主面板便签管理-窗口-列表便签-删除-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Note_ListNoteDelete }
	end ,
	-- ======================================================================
	-- 这是一个内部函数 , 请勿外部调用<br>
	-- ======================================================================
	AddNoneButton = function( list )
		local button1 = list.add{ type = "button" , tooltip = { "SICore.主面板便签管理-窗口-列表便签-无-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Note_ListNoteNone }
		local flow = button1.add{ type = "flow" , direction = "vertical" , ignored_by_interaction = true , style = SIConstants_Core.raw.Styles.Mainbar_Note_ListFlow }
		flow.add{ type = "label" , ignored_by_interaction = true , caption = { "SICore.主面板便签管理-窗口-列表便签-无-标题" } , style = SIConstants_Core.raw.Styles.Mainbar_Note_ListTitle }
		flow.add{ type = "label" , ignored_by_interaction = true , caption = { "SICore.主面板便签管理-窗口-列表便签-无-内容" } , style = SIConstants_Core.raw.Styles.Mainbar_Note_ListContent }
		local button2 = list.add{ type = "sprite-button" , sprite = "item/" .. SIConstants_Core.raw.Items.IconClose , tooltip = { "SICore.主面板便签管理-窗口-列表便签-删除-提示" } , style = SIConstants_Core.raw.Styles.Mainbar_Note_ListNoteDelete }
		button2.enabled = false
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 功能函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	Save = function( settings )
		local elements = settings.Note.Elements
		if not elements.title or elements.title.text:len() < 1 then
			SIPrint.Warning( settings.playerIndex , { "SICore.主面板便签管理-设置-标题-空" } )
			return
		end
		if not elements.order or elements.order.text:len() < 1 then
			SIPrint.Warning( settings.playerIndex , { "SICore.主面板便签管理-设置-排序-空" } )
			return
		end
		local ID = elements.id.caption
		local noteData = nil
		if ID:len() > 0 then
			noteData = SITable.GetWithID( settings.Note.NoteList , ID )
			if not noteData then
				SIPrint.Warning( settings.playerIndex , { "SICore.主面板便签管理-设置-便签无效" } )
				return
			end
		else
			if #settings.Note.NoteList > SIMainbarNote.NoteCountMax then
				SIPrint.Warning( settings.playerIndex , { "SICore.主面板便签管理-设置-便签过多" } )
				return
			end
			settings.Note.NoteOrder = settings.Note.NoteOrder + 1
			noteData =
			{
				ID = tostring( settings.Note.NoteOrder ) ,
				order = "" ,
				isKey = false
			}
			table.insert( settings.Note.NoteList , noteData )
		end
		local orderOld = noteData.order
		local isKeyOld = noteData.isKey
		noteData.title = elements.title.text
		noteData.content = elements.content.text
		noteData.order = elements.order.text
		noteData.isKey = elements.isKey.state
		if orderOld ~= noteData.order then
			table.sort( settings.Note.NoteList , function( a , b )
				return a.order > b.order
			end )
		end
		if noteData.isKey then
			if not isKeyOld then
				local keyIndex = 0
				for index , otherNoteData in pairs( settings.Note.NoteList ) do
					if noteData.ID == otherNoteData.ID then
						keyIndex = index
					else
						otherNoteData.isKey = false
					end
				end
				settings.Note.KeyNoteIndex = keyIndex
			end
		else
			if isKeyOld then
				settings.Note.KeyNoteIndex = nil
			end
		end
		SIMainbarNote.FreshList( settings )
		SIMainbarNote.ShowEdit( settings , noteData.ID )
		if settings.Setting.Base.showKeyNote then
			SIMainbar.FreshPanel_KeyNote( settings )
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 事件函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	ShowEditView = function( playerIndex , name )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		if settings.Note.frame and settings.Note.frame.valid then
			local noteID = nil
			if name then
				noteID = name:sub( SIMainbarNote.Names.NotePosition )
			end
			SIMainbarNote.ShowEdit( settings , noteID )
		end
	end ,
	HideEditView = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		if settings.Note.frame and settings.Note.frame.valid then
			SIMainbarNote.HideEdit( settings )
		end
	end ,
	SaveData = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		if settings.Note.Elements.id then
			SIMainbarNote.Save( settings )
		end
	end ,
	SaveDataAs = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		if settings.Note.Elements.id then
			settings.Note.Elements.id.caption = ""
			SIMainbarNote.Save( settings )
		end
	end ,
	DeleteData = function( playerIndex , name )
		local settings = SIGlobal.GetPlayerSettings( SIMainData.Settings.Name , playerIndex )
		local ID = name:sub( SIMainbarNote.Names.DeletePosition )
		local noteData , index = SITable.GetWithID( settings.Note.NoteList , ID )
		if noteData then
			table.remove( settings.Note.NoteList , index )
			if noteData.isKey then
				settings.Note.KeyNoteIndex = nil
			end
			SIMainbarNote.FreshList( settings )
			if settings.Note.Elements.id and noteData.ID == settings.Note.Elements.id.caption then
				SIMainbarNote.ShowEdit( settings , nil , noteData )
			end
			if settings.Setting.Base.showKeyNote then
				SIMainbar.FreshPanel_KeyNote( settings )
			end
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 接口函数 - 窗口 =================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================
	-- 打开指定玩家的便签管理窗口<br>
	-- ======================================================================
	-- playerIndex = 玩家索引<br>
	-- ======================================================================
	OpenFrameByPlayerIndex = function( playerIndex )
		SIMainbarNote.OpenFrame( playerIndex )
	end ,

	-- ======================================================================
	-- 关闭指定玩家的便签管理窗口<br>
	-- ======================================================================
	-- playerIndex = 玩家索引<br>
	-- ======================================================================
	CloseFrameByPlayerIndex = function( playerIndex )
		SIMainbarNote.CloseFrame( playerIndex )
	end ,

	-- ======================================================================
	-- 打开所有玩家的便签管理窗口<br>
	-- ======================================================================
	-- 无参数<br>
	-- ======================================================================
	OpenFrames = function()
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIMainData.Settings.Name ) ) do
			SIMainbarNote.OpenFrame( playerIndex )
		end
	end ,

	-- ======================================================================
	-- 关闭所有玩家的便签管理窗口<br>
	-- ======================================================================
	-- 无参数<br>
	-- ======================================================================
	CloseFrames = function()
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIMainData.Settings.Name ) ) do
			SIMainbarNote.CloseFrame( playerIndex )
		end
	end
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 接口函数 - 便签列表 =============================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
}

SIMainbarNote.Names.NotePosition = #SIMainbarNote.Names.NotePrefix + 1
SIMainbarNote.Names.DeletePosition = #SIMainbarNote.Names.DeletePrefix + 1
SIColorPanel =
{
	ID = "SIColorPanel" ,
	Name = "多彩调色盘拾色器" ,
	InterfaceID = "SIColorful-ColorPanel" ,
	Names =
	{
		Prefix = "SI多彩-多彩调色盘拾色器-" ,
		Frame = "SI多彩-多彩调色盘拾色器-窗口" ,
		Close = "SI多彩-多彩调色盘拾色器-关闭" ,
		PixelPrefix = "SI多彩-多彩调色盘拾色器-颜色-"
	} ,
	Settings =
	{
		Name = "SIColorPanel" ,
		Default =
		{
			frame = nil ,
			frameLocation = nil ,
			label = nil ,
			list = nil ,
			pixels = nil
		}
	} ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 窗口函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	OpenFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIColorPanel.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid and not settings.pixels then
			SIColorPanel.CloseFrame( playerIndex )
		else
			local player = game.get_player( playerIndex )
			-- 显示窗口
			local frame = SIElements.CreateFrame( player , settings ,
			{
				Name         = SIColorPanel.Names.Frame ,
				Close        = SIColorPanel.Names.Close ,
				Style        = SIConstants_Colorful.raw.Styles.ColorPanel_Frame ,
				Title        = { "SIColorful.多彩调色盘拾色器-窗口-标题" } ,
				TitleTooltip = { "SIColorful.多彩调色盘拾色器-窗口-标题-提示" } ,
				UseTooltip   = { "SIColorful.多彩调色盘拾色器-窗口-使用-提示" } ,
				CloseTooltip = { "SIColorful.多彩调色盘拾色器-窗口-关闭-提示" }
			} )
			-- 第 1 层
			frame.add{ type = "label" , caption = { "SIColorful.多彩调色盘拾色器-窗口-说明" } , style = SIConstants_Colorful.raw.Styles.ColorPanel_LabelTop }
			-- 第 2 层
			settings.label = frame.add{ type = "label" , caption = { "SIColorful.多彩调色盘拾色器-窗口-像素" , #settings.pixels } , style = SIConstants_Colorful.raw.Styles.ColorPanel_LabelTop }
			-- 第 3 层
			settings.list = frame.add{ type = "table" , column_count = 27 , style = SIConstants_Colorful.raw.Styles.ColorPanel_List }
			-- 第 4 层
			local flow4 = frame.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowRight }
			flow4.add{ type = "line" , direction = "horizontal" }
			local flow41 = flow4.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
			flow41.add{ type = "button" , name = SIColorPanel.Names.Close , caption = { "SIColorful.多彩调色盘拾色器-窗口-取消" } , tooltip = { "SIColorful.多彩调色盘拾色器-窗口-取消-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonRed }
			-- 根据设置更新控件
			SIColorPanel.FreshList( settings )
		end
	end ,
	CloseFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIColorPanel.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			settings.pixels = nil
			settings.frame.destroy()
			settings.frame = nil
			settings.label = nil
			settings.list = nil
		end
	end ,
	MoveFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIColorPanel.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			SIElements.SaveFrameLocation( settings )
		end
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 功能函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	FreshList = function( settings )
		local list = settings.list
		if list then
			list.clear()
			local pixelPrefix = SIConstants_Colorful.raw.Entities.PixelPrefix
			local buttonStyle = SIConstants_Colorful.raw.Styles.ColorPanel_Pixel
			for gBase = 0 , SIConstants_Colorful.ColorMax - 1 , SIConstants_Colorful.ColorStepBig do
				for r = 0 , SIConstants_Colorful.ColorMax , SIConstants_Colorful.ColorStep do
					for gAdden = 0 , SIConstants_Colorful.ColorStepBig - 1 , SIConstants_Colorful.ColorStep do
						local g = gBase + gAdden
						for b = 0 , SIConstants_Colorful.ColorMax , SIConstants_Colorful.ColorStep do
							local pixelName = pixelPrefix .. r .. "-" .. g .. "-" .. b
							list.add{ type = "sprite-button" , name = SIColorPanel.Names.PixelPrefix .. pixelName , sprite = "entity/" .. pixelName , style = buttonStyle }
						end
					end
				end
			end
		end
	end ,
	ChangePixel = function( playerIndex , name )
		local settings = SIGlobal.GetPlayerSettings( SIColorPanel.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			local pixelName = name:sub( SIColorPanel.Names.PixelPosition )
			local pixels = {}
			for index , pixelEntity in pairs( settings.pixels ) do
				local newPixelEntity = pixelEntity.surface.create_entity
				{
					name = pixelName ,
					position = pixelEntity.position ,
					direction = pixelEntity.direction ,
					force = pixelEntity.force ,
					player = pixelEntity.last_user.index ,
					raise_built = false ,
					create_build_effect_smoke = true ,
					move_stuck_players = false ,
					render_player_index = pixelEntity.render_player and pixelEntity.render_player.index or nil
				}
				table.insert( pixels , newPixelEntity )
				pixelEntity.destroy{ do_cliff_correction = false , raise_destroy = false }
			end
			settings.pixels = pixels
		end
	end ,
	SetPixels = function( playerIndex , pixels )
		local settings = SIGlobal.GetPlayerSettings( SIColorPanel.Settings.Name , playerIndex )
		settings.pixels = pixels
		if settings.frame and settings.frame.valid then
			settings.label.caption = { "SIColorful.多彩调色盘拾色器-窗口-像素" , #settings.pixels }
		else
			SIColorPanel.OpenFrame( playerIndex )
		end
	end ,
	AddPixels = function( playerIndex , pixels )
		local settings = SIGlobal.GetPlayerSettings( SIColorPanel.Settings.Name , playerIndex )
		if settings.pixels then
			for index , pixel in pairs( pixels ) do
				local addFlag = true
				for innerIndex , innerPixel in pairs( settings.pixels ) do
					if innerPixel.unit_number == pixel.unit_number then
						addFlag = false
						break
					end
				end
				if addFlag then
					table.insert( settings.pixels , pixel )
				end
			end
		else
			settings.pixels = pixels
		end
		if settings.frame and settings.frame.valid then
			settings.label.caption = { "SIColorful.多彩调色盘拾色器-窗口-像素" , #settings.pixels }
		else
			SIColorPanel.OpenFrame( playerIndex )
		end
	end ,
	RemovePixels = function( playerIndex , pixels )
		local settings = SIGlobal.GetPlayerSettings( SIColorPanel.Settings.Name , playerIndex )
		if not settings.frame or not settings.frame.valid or not settings.pixels then
			return
		end
		local newPixels = {}
		for innerIndex , innerPixel in pairs( settings.pixels ) do
			local addFlag = true
			for index , pixel in pairs( pixels ) do
				if innerPixel.unit_number == pixel.unit_number then
					addFlag = false
					break
				end
			end
			if addFlag then
				table.insert( newPixels , innerPixel )
			end
		end
		settings.pixels = newPixels
		settings.label.caption = { "SIColorful.多彩调色盘拾色器-窗口-像素" , #settings.pixels }
	end
	-- ------------------------------------------------------------------------------------------------
	-- ------ 接口函数 -- 窗口 ------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
}

SIColorPanel.Names.PixelPosition = #SIColorPanel.Names.PixelPrefix + 1
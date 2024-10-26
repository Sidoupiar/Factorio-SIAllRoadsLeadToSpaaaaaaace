SIOreMap =
{
	ID = "OreMap" ,
	Name = "黄图" ,
	InterfaceID = "SICore-OreMap" ,
	Names =
	{
		Prefix = "SI工具图-黄图-" ,
		Frame = "SI工具图-黄图-窗口" ,
		SortName = "SI工具图-黄图-排序名称" ,
		SortCount = "SI工具图-黄图-排序数量" ,
		Fresh = "SI工具图-黄图-刷新" ,
		Clean = "SI工具图-黄图-清空" ,
		Spawn = "SI工具图-黄图-铺设" ,
		Close = "SI工具图-黄图-关闭" ,
		AsDefault = "SI工具图-黄图-设为默认" ,
		TotalMode = "SI工具图-黄图-总量模式" ,
		Count = "SI工具图-黄图-数量" ,
		IconNamePrefix = "SI工具图-黄图-矿物" ,
	} ,
	Settings =
	{
		Name = "OreMap" ,
		Default =
		{
			frame = nil ,
			frameLocation = nil ,
			Elements =
			{
				asDefault = nil ,
				totalMode = nil ,
				count = nil ,
				list = nil
			} ,
			asDefault = false ,
			totalMode = false ,
			count = 0 ,
			selectedOreName = nil ,
			tiles = nil ,
			oreData = {}
		}
	} ,
	MaxCount = 4294967295 ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 窗口函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	OpenFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIOreMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			SIOreMap.CloseFrame( playerIndex )
		else
			local player = game.get_player( playerIndex )
			-- 显示窗口
			local frame = SIElements.CreateFrame( player , settings ,
			{
				Name         = SIOreMap.Names.Frame ,
				Close        = SIOreMap.Names.Close ,
				Style        = SIConstants_Core.raw.Styles.OreMap_Frame ,
				Title        = { "SIToolMap.黄图-窗口-标题" } ,
				TitleTooltip = { "SIToolMap.黄图-窗口-标题-提示" , { "item-name.infinity-chest" } , { "SIToolMapName.物品-黄图" } } ,
				UseTooltip   = { "SIToolMap.黄图-窗口-使用-提示" , { "item-name.infinity-chest" } , { "SIToolMapName.物品-黄图" } } ,
				CloseTooltip = { "SIToolMap.黄图-窗口-关闭-提示" }
			} )
			-- 第 1 层
			local flow1 = frame.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
			flow1.add{ type = "label" , caption = { "SIToolMap.黄图-窗口-说明" , { "item-name.infinity-chest" } , { "SIToolMapName.物品-黄图" } } , style = SIConstants_Core.raw.Styles.OreMap_LabelTop }
			-- 第 2 层
			local flow2 = frame.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			flow2.add{ type = "line" , direction = "horizontal" }
			flow2.add{ type = "label" , caption = { "SIToolMap.黄图-窗口-设置" } , style = SIConstants_Core.raw.Styles.OreMap_LabelTop }
			-- 第 2.1 层
			local flow21 = flow2.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowCenterH }
			settings.Elements.asDefault = flow21.add{ type = "checkbox" , name = SIOreMap.Names.AsDefault , state = settings.asDefault , caption = { "SIToolMap.黄图-窗口-设置-设为默认" } , tooltip = { "SIToolMap.黄图-窗口-设置-设为默认-提示" } , style = SIConstants_Core.raw.Styles.OreMap_Check }
			flow21.add{ type = "sprite" , sprite = "info" , tooltip = { "SIToolMap.黄图-窗口-设置-设为默认-提示" } }
			-- 第 2.2 层
			local flow22 = flow2.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowCenterH }
			settings.Elements.totalMode = flow22.add{ type = "checkbox" , name = SIOreMap.Names.TotalMode , state = settings.totalMode , caption = { "SIToolMap.黄图-窗口-设置-总量模式" } , tooltip = { "SIToolMap.黄图-窗口-设置-总量模式-提示" } , style = SIConstants_Core.raw.Styles.OreMap_Check }
			flow22.add{ type = "sprite" , sprite = "info" , tooltip = { "SIToolMap.黄图-窗口-设置-总量模式-提示" } }
			-- 第 2.3 层
			local flow23 = flow2.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowCenterH }
			local flow23Label = flow23.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.OreMap_FlowShort }
			flow23Label.add{ type = "label" , caption = { "SIToolMap.黄图-窗口-设置-数量" } , tooltip = { "SIToolMap.黄图-窗口-设置-数量-提示" } , style = SIConstants_Core.raw.Styles.OreMap_LabelShort }
			flow23Label.add{ type = "sprite" , sprite = "info" , tooltip = { "SIToolMap.黄图-窗口-设置-数量-提示" } }
			settings.Elements.count = flow23.add{ type = "textfield" , name = SIOreMap.Names.Count , text = tostring( settings.count or 0 ) , numeric = true , tooltip = { "SIToolMap.黄图-窗口-设置-数量-提示" } , style = SIConstants_Core.raw.Styles.OreMap_Number }
			-- 第 3 层
			local flow3 = frame.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			flow3.add{ type = "line" , direction = "horizontal" }
			-- 第 3.1 层
			local flow31 = flow3.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
			flow31.add{ type = "button" , name = SIOreMap.Names.Clean , caption = { "SIToolMap.黄图-窗口-去除" } , tooltip = { "SIToolMap.黄图-窗口-去除-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonGray }
			flow31.add{ type = "button" , name = SIOreMap.Names.Fresh , caption = { "SIToolMap.黄图-窗口-刷新" } , tooltip = { "SIToolMap.黄图-窗口-刷新-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonBlue }
			flow31.add{ type = "button" , name = SIOreMap.Names.SortCount , caption = { "SIToolMap.黄图-窗口-数量排序" } , tooltip = { "SIToolMap.黄图-窗口-数量排序-提示" } , style = SIConstants_Core.raw.Styles.OreMap_ButtonGreen }
			flow31.add{ type = "button" , name = SIOreMap.Names.SortName , caption = { "SIToolMap.黄图-窗口-名称排序" } , tooltip = { "SIToolMap.黄图-窗口-名称排序-提示" } , style = SIConstants_Core.raw.Styles.OreMap_ButtonGreen }
			-- 第 4 层
			local flow4 = frame.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowLeft }
			flow4.add{ type = "line" , direction = "horizontal" }
			-- 第 4.1 层
			local flow41 = flow4.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_TitleFlow }
			flow41.add{ type = "label" , caption = { "SIToolMap.黄图-窗口-标题-选择" } , style = SIConstants_Core.raw.Styles.OreMap_ListTitleIcon }
			flow41.add{ type = "label" , caption = { "SIToolMap.黄图-窗口-标题-名称" } , style = SIConstants_Core.raw.Styles.OreMap_ListTitleLong }
			flow41.add{ type = "label" , caption = { "SIToolMap.黄图-窗口-标题-数量" } , style = SIConstants_Core.raw.Styles.OreMap_ListTitleLong }
			-- 第 5 层
			settings.Elements.list = frame
			.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Common_ScrollPane }
			.add{ type = "table" , column_count = 3 , style = SIConstants_Core.raw.Styles.Common_List }
			if settings.tiles then
				-- 第 6 层
				local flow6 = frame.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowRight }
				flow6.add{ type = "line" , direction = "horizontal" }
				-- 第 6.1 层
				flow6.add{ type = "label" , caption = { "SIToolMap.黄图-窗口-地板-选择数量" , #settings.tiles } , style = SIConstants_Core.raw.Styles.OreMap_LabelBottom }
				-- 第 6.2 层
				local flow61 = flow6.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
				flow61.add{ type = "button" , name = SIOreMap.Names.Close , caption = { "SIToolMap.黄图-窗口-取消" } , tooltip = { "SIToolMap.黄图-窗口-取消-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonRed }
				flow61.add{ type = "button" , name = SIOreMap.Names.Spawn , caption = { "SIToolMap.黄图-窗口-铺设" } , tooltip = { "SIToolMap.黄图-窗口-铺设-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonGreen }
			end
			-- 根据设置更新控件
			SIOreMap.FreshList( settings )
		end
	end ,
	CloseFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIOreMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 清除临时数据
			settings.tiles = nil
			settings.frame.destroy()
			settings.frame = nil
			settings.Elements = {}
		end
	end ,
	MoveFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIOreMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			SIElements.SaveFrameLocation( settings )
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 控件函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	FreshList = function( settings )
		local list = settings.Elements.list
		if list then
			list.clear()
			if SITable.Size( settings.oreData ) < 1 then
				local button = list.add{ type = "sprite-button" , sprite = "item/" .. SIConstants_Core.raw.Items.IconEmpty , style = SIConstants_Core.raw.Styles.OreMap_ListIcon }
				button.enabled = false
				list.add{ type = "label" , caption = { "SIToolMap.黄图-窗口-矿物-空的" } , style = SIConstants_Core.raw.Styles.OreMap_ListLabelLong }
				list.add{ type = "label" , caption = { "SIToolMap.黄图-窗口-矿物-无限" } , style = SIConstants_Core.raw.Styles.OreMap_ListLabelLong }
			else
				for oreName , oreCount in pairs( settings.oreData ) do
					if oreName == settings.selectedOreName then
						local button = list.add{ type = "sprite-button" , sprite = "entity/" .. oreName , tooltip = { "SIToolMap.黄图-窗口-矿物-已选择-提示" } , style = SIConstants_Core.raw.Styles.OreMap_ListIcon }
						button.enabled = false
						list.add{ type = "label" , caption = { "SIToolMap.黄图-窗口-矿物-选中" , prototypes.entity[oreName].localised_name } , style = SIConstants_Core.raw.Styles.OreMap_ListLabelLong }
						list.add{ type = "label" , caption = { "SIToolMap.黄图-窗口-矿物-选中" , { "SIToolMap.黄图-窗口-矿物-数量" , oreCount } } , style = SIConstants_Core.raw.Styles.OreMap_ListLabelLong }
					else
						list.add{ type = "sprite-button" , name = SIOreMap.Names.IconNamePrefix .. oreName , sprite = "entity/" .. oreName , tooltip = { "SIToolMap.黄图-窗口-矿物-未选择-提示" } , style = SIConstants_Core.raw.Styles.OreMap_ListIcon }
						list.add{ type = "label" , caption = prototypes.entity[oreName].localised_name , style = SIConstants_Core.raw.Styles.OreMap_ListLabelLong }
						list.add{ type = "label" , caption = { "SIToolMap.黄图-窗口-矿物-数量" , oreCount } , style = SIConstants_Core.raw.Styles.OreMap_ListLabelLong }
					end
				end
			end
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 功能函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	SpawnOre = function( settings )
		local player = game.get_player( settings.playerIndex )
		if settings.count < 1 then
			SIPrint.Warning( player , { "SIToolMap.黄图-设置-空-信息" , { settings.asDefault and "SIToolMap.黄图-设置-取消默认" or "SIToolMap.黄图-设置-取消放置" } } )
			return false
		end
		if not settings.selectedOreName then
			SIPrint.Warning( player , { "SIToolMap.黄图-设置-尚未选择-信息" } )
			return false
		end
		local oreCount = settings.oreData[settings.selectedOreName]
		local tileCount = #settings.tiles
		local count = 0
		if settings.totalMode then
			if settings.count > oreCount then
				SIPrint.Warning( player , { "SIToolMap.黄图-设置-数量不足-信息" } )
				return false
			end
			count = math.floor( settings.count/tileCount )
			if count > SIOreMap.MaxCount then
				SIPrint.Warning( player , { "SIToolMap.黄图-设置-数量过多-信息" , SIOreMap.MaxCount , { "SIToolMap.黄图-设置-取消放置" } } )
				return false
			end
			settings.oreData[settings.selectedOreName] = oreCount - count * tileCount
		else
			count = settings.count
			local totalCount = count * tileCount
			if totalCount > oreCount then
				SIPrint.Warning( player , { "SIToolMap.黄图-设置-数量不足-信息" } )
				return false
			end
			if count > SIOreMap.MaxCount then
				SIPrint.Warning( player , { "SIToolMap.黄图-设置-数量过多-信息" , SIOreMap.MaxCount , { "SIToolMap.黄图-设置-取消放置" } } )
				return false
			end
			settings.oreData[settings.selectedOreName] = oreCount - totalCount
		end
		local surface = player.surface
		for index , tile in pairs( settings.tiles ) do
			surface.create_entity{ name = settings.selectedOreName , position = tile.position , amount = count }
		end
		if settings.asDefault then
			settings.tiles = nil
		end
		SIPrint.Tip( player , { "SIToolMap.黄图-铺设完毕-信息" } )
		return true
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 事件函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	Set_AsDefault = function( playerIndex , element )
		local settings = SIGlobal.GetPlayerSettings( SIOreMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [设置默认] 复选框的值
			settings.asDefault = element.state
		end
	end ,
	Set_TotalMode = function( playerIndex , element )
		local settings = SIGlobal.GetPlayerSettings( SIOreMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [总量模式] 复选框的值
			settings.totalMode = element.state
		end
	end ,
	Set_Count = function( playerIndex , element )
		local settings = SIGlobal.GetPlayerSettings( SIOreMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			-- 保存 [数量] 填写的数量
			settings.count = SIElements.GetInputNumber( element )
		end
	end ,
	SortOreDataName = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIOreMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			local oreList = {}
			for oreName , oreCount in pairs( settings.oreData ) do
				table.insert( oreList , { name = oreName , localizedName = oreName } )
			end
			table.sort( oreList , function( a , b )
				return a.localizedName < b.localizedName
			end )
			local oreDataNew = {}
			for index , oreData in pairs( oreList ) do
				oreDataNew[oreData.name] = settings.oreData[oreData.name]
			end
			settings.oreData = oreDataNew
			SIOreMap.FreshList( settings )
		end
	end ,
	SortOreDataCount = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIOreMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			local oreList = {}
			for oreName , oreCount in pairs( settings.oreData ) do
				table.insert( oreList , { name = oreName , count = oreCount } )
			end
			table.sort( oreList , function( a , b )
				return a.count < b.count
			end )
			local oreDataNew = {}
			for index , oreData in pairs( oreList ) do
				oreDataNew[oreData.name] = settings.oreData[oreData.name]
			end
			settings.oreData = oreDataNew
			SIOreMap.FreshList( settings )
		end
	end ,
	CleanOreData = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIOreMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			for oreName , oreCount in pairs( settings.oreData ) do
				if oreCount == 0 then
					settings.oreData[oreName] = nil
				end
			end
			SIOreMap.FreshList( settings )
		end
	end ,
	Fresh = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIOreMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			SIOreMap.FreshList( settings )
		end
	end ,
	SelectOre = function( playerIndex , oreListItemName )
		local settings = SIGlobal.GetPlayerSettings( SIOreMap.Settings.Name , playerIndex )
		if settings.frame and settings.frame.valid then
			settings.selectedOreName = oreListItemName:sub( SIOreMap.Names.IconNamePosition )
			SIOreMap.FreshList( settings )
		end
	end ,
	SaveOre = function( playerIndex , entities )
		local settings = SIGlobal.GetPlayerSettings( SIOreMap.Settings.Name , playerIndex )
		for index , entity in pairs( entities ) do
			if entity.type == SICommon.Types.Entities.Resource then
				local count = settings.oreData[entity.name]
				if not count then
					count = 0
				end
				count = count + entity.amount
				settings.oreData[entity.name] = count
				entity.destroy{ raise_destroy = true }
			end
		end
		if settings.frame and settings.frame.valid then
			SIOreMap.FreshList( settings )
		end
	end ,
	CreateOre = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIOreMap.Settings.Name , playerIndex )
		if SIOreMap.SpawnOre( settings ) then
			SIOreMap.CloseFrame( playerIndex )
		end
	end ,
	CreateOreByMap = function( playerIndex , selectedTiles )
		local settings = SIGlobal.GetPlayerSettings( SIOreMap.Settings.Name , playerIndex )
		if settings.asDefault then
			if settings.count < 1 then
				settings.asDefault = false
				game.get_player( playerIndex ).print( { "SIToolMap.黄图-设置-空-信息" , { "SIToolMap.黄图-设置-取消默认" } } , SICommon.Colors.Print.ORANGE )
			else
				settings.tiles = selectedTiles
				if SIOreMap.SpawnOre( settings ) and settings.frame and settings.frame.valid then
					SIOreMap.FreshList( settings )
				end
			end
		else
			if settings.frame and settings.frame.valid then
				SIOreMap.CloseFrame( playerIndex )
			end
			settings.tiles = selectedTiles
			SIOreMap.OpenFrame( playerIndex )
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 接口函数 - 窗口 =================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================
	-- 打开指定玩家的黄图的管理窗口<br>
	-- ======================================================================
	-- playerIndex    = 玩家索引<br>
	-- ======================================================================
	OpenFrameByPlayerIndex = function( playerIndex )
		SIOreMap.OpenFrame( playerIndex )
	end ,

	-- ======================================================================
	-- 关闭指定玩家的黄图的管理窗口<br>
	-- ======================================================================
	-- playerIndex    = 玩家索引<br>
	-- ======================================================================
	CloseFrameByPlayerIndex = function( playerIndex )
		SIOreMap.CloseFrame( playerIndex )
	end ,

	-- ======================================================================
	-- 打开所有玩家的黄图的管理窗口<br>
	-- ======================================================================
	-- 无参数<br>
	-- ======================================================================
	OpenFrames = function()
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIOreMap.Settings.Name ) ) do
			SIOreMap.OpenFrame( playerIndex )
		end
	end ,

	-- ======================================================================
	-- 关闭所有玩家的黄图的管理窗口<br>
	-- ======================================================================
	-- 无参数<br>
	-- ======================================================================
	CloseFrames = function()
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIOreMap.Settings.Name ) ) do
			SIOreMap.CloseFrame( playerIndex )
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 接口函数 - 导入导出 =============================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================
	-- 导入数据<br>
	-- ======================================================================
	-- playerIndex    = 点击按钮的玩家索引<br>
	-- data           = 导出时保存的数据 , 根据导出时导出接口函数返回的数据 , 此参数可能为 nil<br>
	-- settingsDataID = 导入导出设置数据包的 ID<br>
	-- gameTick       = 导出数据时的游戏时间 , tick<br>
	-- ======================================================================
	ImpoerSettingsData = function( playerIndex , data , settingsDataID , gameTick )
		if not data then
			return
		end
		local settings = SIGlobal.GetPlayerSettings( SIOreMap.Settings.Name , playerIndex )
		settings.asDefault = data.asDefault or false
		settings.totalMode = data.totalMode or false
		settings.count = data.count or 0
		if settings.frame and settings.frame.valid then
			settings.Elements.asDefault.state = settings.asDefault
			settings.Elements.totalMode.state = settings.totalMode
			settings.Elements.count.text = tostring( settings.count )
		end
	end ,

	-- ======================================================================
	-- 导出数据<br>
	-- ======================================================================
	-- playerIndex    = 点击按钮的玩家索引<br>
	-- settingsDataID = 导入导出设置数据包的 ID<br>
	-- gameTick       = 当前的游戏时间 , tick<br>
	-- ======================================================================
	-- 返回值 = 导出的数据<br>
	-- ======================================================================
	ExportSettingsData = function( playerIndex , settingsDataID , gameTick )
		local settings = SIGlobal.GetPlayerSettings( SIOreMap.Settings.Name , playerIndex )
		return
		{
			asDefault = settings.asDefault ,
			totalMode = settings.totalMode ,
			count = settings.count
		}
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 接口函数 - 数据操作 =============================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================
	-- 向玩家数据内添加矿物<br>
	-- ======================================================================
	-- playerIndex    = 玩家索引<br>
	-- oreName        = 矿物实体名称<br>
	-- count          = 添加的数量 , 不能小于 1<br>
	-- ======================================================================
	AddOre = function( playerIndex , oreName , count )
		if count > 0 then
			local settings = SIGlobal.GetPlayerSettings( SIOreMap.Settings.Name , playerIndex )
			local sourceCount = settings.oreData[oreName]
			if sourceCount then
				settings.oreData[oreName] = sourceCount + count
			else
				settings.oreData[oreName] = count
			end
			if settings.frame and settings.frame.valid then
				SIOreMap.FreshList( settings )
			end
		end
	end ,

	-- ======================================================================
	-- 从玩家数据中移除矿物<br>
	-- 数量不足时会直接删除条目<br>
	-- ======================================================================
	-- playerIndex    = 玩家索引<br>
	-- oreName        = 矿物实体名称<br>
	-- count          = 移除的数量 , 不能小于 1<br>
	-- ======================================================================
	RemoveOre = function( playerIndex , oreName , count )
		if count > 0 then
			local settings = SIGlobal.GetPlayerSettings( SIOreMap.Settings.Name , playerIndex )
			local sourceCount = settings.oreData[oreName]
			if sourceCount then
				if sourceCount > count then
					settings.oreData[oreName] = sourceCount - count
				else
					settings.oreData[oreName] = nil
				end
				if settings.frame and settings.frame.valid then
					SIOreMap.FreshList( settings )
				end
			end
		end
	end
}

SIOreMap.Names.IconNamePosition = #SIOreMap.Names.IconNamePrefix + 1
SIOreMap.Toolbar =
{
	ID = "SI工具图-黄图" ,
	Name = "黄图" ,
	IconItemName = SIConstants_Core.raw.Items.OreMap ,
	LocalizedName = { "SIToolMap.黄图-工具栏-按钮" } ,
	LocalizedDescription = { "SIToolMap.黄图-工具栏-提示" , { "item-name.infinity-chest" } , { "SIToolMapName.物品-黄图" } } ,
	ActionRemoteInterfaceID = SIOreMap.InterfaceID ,
	ActionRemoteFunctionName = "OpenFrameByPlayerIndex" ,
	Permission = SIPermission.PermissionIDs.OreMap ,
	Order = "SICore-MapOre"
}
SIOreMap.SettingsData =
{
	ID = "SI工具图-黄图" ,
	Tooltip = { "SIToolMap.黄图-导出设置-提示" } ,
	ImportRemoteInterfaceID = SIOreMap.InterfaceID ,
	ImportRemoteFunctionName = "ImpoerSettingsData" ,
	ExportRemoteInterfaceID = SIOreMap.InterfaceID ,
	ExportRemoteFunctionName = "ExportSettingsData"
}
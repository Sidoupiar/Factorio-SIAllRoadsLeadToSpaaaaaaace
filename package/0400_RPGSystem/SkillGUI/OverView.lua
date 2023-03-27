SIRPGSkillUI_OverView =
{
	ID = "RPGSkillUI_OverView" ,
	Name = "RPG技能面板-洞察" ,
	InterfaceID = "SIRPGSystem-SkillUI-OverView" ,
	Names =
	{
		Prefix = "SIRPG系统-技能面板-洞察-" ,
		Frame = "SIRPG系统-技能面板-洞察-窗口" ,
		Close = "SIRPG系统-技能面板-洞察-关闭" ,
		Save = "SIRPG系统-技能面板-洞察-保存" ,
		DefaultPrefix = "SIRPG系统-技能面板-洞察-默认-" ,
		UsePrefix = "SIRPG系统-技能面板-洞察-使用-" ,
		DeletePrefix = "SIRPG系统-技能面板-洞察-删除-" ,
		FrameMapPrefix = "SIRPG系统-技能面板-洞察-地图-窗口-" ,
		CloseMapPrefix = "SIRPG系统-技能面板-洞察-地图-关闭-" ,
		ZoomOutMapPrefix = "SIRPG系统-技能面板-洞察-地图-缩小-" ,
		ZoomDefaultMapPrefix = "SIRPG系统-技能面板-洞察-地图-默认-" ,
		ZoomInMapPrefix = "SIRPG系统-技能面板-洞察-地图-放大-"
	} ,
	SkillID = "SI技能-洞察" ,
	ZoomMax = 3 ,
	ZoomMin = 0.05 ,
	ZoomStep = 1.2 ,
	ZoomDefault = 1.0 ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 窗口函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------

	-- ----------------------------------------
	-- 技能入口接口<br>
	-- [ 洞察 ] 技能<br>
	-- ----------------------------------------
	-- playerIndex     = 玩家索引<br>
	-- globalSkillData = 全局技能数据 , 静态数据<br>
	-- playerSkillData = 玩家技能数据 , 当前技能的玩家相关的数据 , 动态数据<br>
	-- gameTick        = 游戏帧<br>
	-- ----------------------------------------
	OpenFrame = function( playerIndex , globalSkillData , playerSkillData , isQuickUse , gameTick )
		if isQuickUse and playerSkillData.CustomData.DefaultPointDataIndex then
			SIRPGSkillUI_OverView.UseSkillInner( playerIndex , playerSkillData.CustomData.DefaultPointDataIndex )
			return
		end
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local skill = settings.SkillUI.OverView
		if skill.frame and skill.frame.valid then
			SIRPGSkillUI_OverView.CloseFrame( playerIndex )
		else
			local player = game.get_player( playerIndex )
			-- 显示窗口
			local frame = SIElements.CreateFrame( player , skill ,
			{
				Name           = SIRPGSkillUI_OverView.Names.Frame ,
				Close          = SIRPGSkillUI_OverView.Names.Close ,
				Style          = SIConstants_RPGSystem.raw.Styles.SkillUI_OverView_Frame ,
				Title          = { "SIRPGSystem.技能面板-洞察-窗口-标题" } ,
				TitleTooltip   = { "SIRPGSystem.技能面板-洞察-窗口-标题-提示" } ,
				UseTooltip     = { "SIRPGSystem.技能面板-洞察-窗口-使用-提示" } ,
				CloseTooltip   = { "SIRPGSystem.技能面板-洞察-窗口-关闭-提示" }
			} )
			-- 第 1 层
			frame.add{ type = "label" , caption = { "SIRPGSystem.技能面板-洞察-窗口-临时坐标" } , style = SIConstants_RPGSystem.raw.Styles.SkillUI_OverView_LabelTitle }
			-- 第 2 层
			local flow2 = frame.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowRight }
			local current = playerSkillData.CustomData.CurrentPoint
			local pointText = nil
			if current then
				pointText = { "SIRPGSystem.技能面板-洞察-窗口-坐标" , current.name , current.x , current.y }
			else
				pointText = { "SIRPGSystem.技能面板-洞察-窗口-坐标" , { "SIRPGSystem.技能面板-洞察-坐标-空值" } , { "SIRPGSystem.技能面板-洞察-坐标-空值" } , { "SIRPGSystem.技能面板-洞察-坐标-空值" } }
			end
			skill.point = flow2.add{ type = "label" , caption = pointText , tooltip = pointText , style = SIConstants_RPGSystem.raw.Styles.SkillUI_OverView_LabelPoint }
			local flow21 = flow2.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowCenterH }
			flow21.add{ type = "button" , name = SIRPGSkillUI_OverView.Names.UsePrefix .. 0 , caption = { "SIRPGSystem.技能面板-洞察-窗口-洞察临时" } , tooltip = { "SIRPGSystem.技能面板-洞察-窗口-洞察临时-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonGreen }
			flow21.add{ type = "button" , name = SIRPGSkillUI_OverView.Names.Save , caption = { "SIRPGSystem.技能面板-洞察-窗口-永久" } , tooltip = { "SIRPGSystem.技能面板-洞察-窗口-永久-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonBlue }
			-- 第 3 层
			frame.add{ type = "line" , direction = "horizontal" }
			-- 第 4 层
			frame.add{ type = "label" , caption = { "SIRPGSystem.技能面板-洞察-窗口-永久坐标" } , style = SIConstants_RPGSystem.raw.Styles.SkillUI_OverView_LabelTitle }
			-- 第 5 层
			skill.list = frame
			.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" , style = SIConstants_Core.raw.Styles.Common_ScrollPane }
			.add{ type = "table" , column_count = 1 , style = SIConstants_RPGSystem.raw.Styles.SkillUI_OverView_PointList }
			-- 根据设置更新控件
			SIRPGSkillUI_OverView.FreshList( settings , playerSkillData )
		end
	end ,
	CloseFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local skill = settings.SkillUI.OverView
		if skill.frame and skill.frame.valid then
			skill.frame.destroy()
			skill.frame = nil
			skill.point = nil
			skill.list = nil
		end
	end ,
	MoveFrame = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local skill = settings.SkillUI.OverView
		if skill.frame and skill.frame.valid then
			SIElements.SaveFrameLocation( skill )
		end
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 功能函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	FreshList = function( settings , playerSkillData )
		local list = settings.SkillUI.OverView.list
		list.clear()
		for pointDataIndex , pointData in pairs( playerSkillData.CustomData.PointList ) do
			local flow = list.add{ type = "flow" , direction = "vertical" , style = SIConstants_Core.raw.Styles.Common_FlowRight }
			local pointText = { "SIRPGSystem.技能面板-洞察-窗口-坐标" , pointData.name , pointData.x , pointData.y }
			flow.add{ type = "label" , caption = pointText , tooltip = pointText , style = SIConstants_RPGSystem.raw.Styles.SkillUI_OverView_LabelPoint }
			local flow1 = flow.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowCenterH }
			if playerSkillData.CustomData.DefaultPointDataIndex == pointDataIndex then
				flow1.add{ type = "button" , name = SIRPGSkillUI_OverView.Names.DefaultPrefix .. pointDataIndex , caption = { "SIRPGSystem.技能面板-洞察-窗口-取消默认" } , tooltip = { "SIRPGSystem.技能面板-洞察-窗口-取消默认-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonOrange }
			else
				flow1.add{ type = "button" , name = SIRPGSkillUI_OverView.Names.DefaultPrefix .. pointDataIndex , caption = { "SIRPGSystem.技能面板-洞察-窗口-设为默认" } , tooltip = { "SIRPGSystem.技能面板-洞察-窗口-设为默认-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonBlue }
			end
			flow1.add{ type = "button" , name = SIRPGSkillUI_OverView.Names.UsePrefix .. pointDataIndex , caption = { "SIRPGSystem.技能面板-洞察-窗口-洞察永久" } , tooltip = { "SIRPGSystem.技能面板-洞察-窗口-洞察永久-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonGreen }
			flow1.add{ type = "button" , name = SIRPGSkillUI_OverView.Names.DeletePrefix .. pointDataIndex , caption = { "SIRPGSystem.技能面板-洞察-窗口-删除" } , tooltip = { "SIRPGSystem.技能面板-洞察-窗口-删除-提示" } , style = SIConstants_Core.raw.Styles.Common_ButtonRed }
		end
	end ,
	SwitchDefault = function( playerIndex , name )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local skill = settings.SkillUI.OverView
		if skill.frame and skill.frame.valid then
			local globalSkillData , playerSkillData = SIRPGSystem.GetPlayerSkillData( playerIndex , SIRPGSkillUI_OverView.SkillID )
			local pointDataIndex = tonumber( name:sub( SIRPGSkillUI_OverView.Names.DefaultPosition ) ) or 0
			if pointDataIndex > 0 then
				if playerSkillData.CustomData.DefaultPointDataIndex == pointDataIndex then
					playerSkillData.CustomData.DefaultPointDataIndex = nil
				else
					playerSkillData.CustomData.DefaultPointDataIndex = pointDataIndex
				end
				SIRPGSystem.SavePlayerSkillData( playerIndex , SIRPGSkillUI_OverView.SkillID , playerSkillData )
				SIRPGSkillUI_OverView.FreshList( settings , playerSkillData )
			end
		end
	end ,
	UseSkill = function( playerIndex , name )
		local pointDataIndex = tonumber( name:sub( SIRPGSkillUI_OverView.Names.UsePosition ) ) or 0
		SIRPGSkillUI_OverView.UseSkillInner( playerIndex , pointDataIndex )
	end ,
	-- ----------------------------------------
	-- 这是一个内部函数 , 请勿外部调用<br>
	-- ----------------------------------------
	UseSkillInner = function( playerIndex , pointDataIndex )
		if not SIPermission.HasPermission( SIPermission.PermissionIDs.RPGPlayerSkill , playerIndex ) then
			SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.RPGPlayerSkill ) )
			return
		end
		local globalSkillData , playerSkillData = SIRPGSystem.GetPlayerSkillData( playerIndex , SIRPGSkillUI_OverView.SkillID )
		if not playerSkillData.Unlock then
			SIPrint.Warning( playerIndex , { "SIRPGSystem.技能提示-尚未解锁" , globalSkillData.Name } )
			return
		end
		if playerSkillData.Cooldown > 0 then
			SIPrint.Warning( playerIndex , { "SIRPGSystem.技能提示-技能冷却中" , globalSkillData.Name } )
			return
		end
		if SIRPGSystem.TakeSkillCost( playerIndex , SIRPGSkillUI_OverView.SkillID ) then
			local pointData = nil
			if pointDataIndex == 0 then
				local player = game.get_player( playerIndex )
				pointData =
				{
					name = player.surface.name ,
					surface = player.surface.index ,
					x = math.floor( player.position.x ) ,
					y = math.floor( player.position.y )
				}
				playerSkillData.CustomData.CurrentPoint = pointData
				local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
				local skill = settings.SkillUI.OverView
				if skill.frame and skill.frame.valid then
					local pointText = { "SIRPGSystem.技能面板-洞察-窗口-坐标" , pointData.name , pointData.x , pointData.y }
					skill.point.caption = pointText
					skill.point.tooltip = pointText
				end
			else
				pointData = playerSkillData.CustomData.PointList[pointDataIndex]
				if not pointData or not game.get_surface( pointData.surface ) then
					SIPrint.Warning( playerIndex , { "SIRPGSystem.技能面板-洞察-无效坐标" } )
					return
				end
			end
			if SIRPGSkillUI_OverView.OpenMapFrame( playerIndex , pointDataIndex , pointData , playerSkillData.Level.Attack.Active * globalSkillData.Attack.Value * 60 + 300 ) then
				playerSkillData.Cooldown = math.max( globalSkillData.Cooldown - playerSkillData.Level.Adventure.Active * globalSkillData.Adventure.Value * 60 , 0 )
			else
				playerSkillData.Cooldown = math.max( globalSkillData.Cooldown - playerSkillData.Level.Adventure.Active * globalSkillData.Adventure.Value * 60 , 0 ) / 2
			end
			SIRPGSystem.SavePlayerSkillData( playerIndex , SIRPGSkillUI_OverView.SkillID , playerSkillData )
		else
			SIPrint.Warning( playerIndex , { "SIRPGSystem.技能提示-条件不足" , globalSkillData.Name } )
		end
	end ,
	SavePoint = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local skill = settings.SkillUI.OverView
		if skill.frame and skill.frame.valid then
			local globalSkillData , playerSkillData = SIRPGSystem.GetPlayerSkillData( playerIndex , SIRPGSkillUI_OverView.SkillID )
			if not playerSkillData.Unlock then
				SIPrint.Warning( playerIndex , { "SIRPGSystem.技能提示-尚未解锁" , globalSkillData.Name } )
				return
			end
			local pointData = playerSkillData.CustomData.CurrentPoint
			if not pointData then
				SIPrint.Warning( playerIndex , { "SIRPGSystem.技能面板-洞察-空的坐标" } )
				return
			end
			local totalCount = math.floor( playerSkillData.Level.Craft.Active / 50 ) + 1
			if #playerSkillData.CustomData.PointList >= totalCount then
				SIPrint.Warning( playerIndex , { "SIRPGSystem.技能面板-洞察-栏位不足" } )
				return
			end
			table.insert( playerSkillData.CustomData.PointList , SIUtils.table.deepcopy( pointData ) )
			local newIndex = #playerSkillData.CustomData.PointList
			if not skill.PointList[newIndex] then
				skill.PointList[newIndex] =
				{
					frame = nil ,
					frameLocation = nil ,
					map = nil ,
					zoom = SIRPGSkillUI_OverView.ZoomDefault
				}
			end
			SIRPGSystem.SavePlayerSkillData( playerIndex , SIRPGSkillUI_OverView.SkillID , playerSkillData )
			SIRPGSkillUI_OverView.FreshList( settings , playerSkillData )
		end
	end ,
	DeletePoint = function( playerIndex , name )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local skill = settings.SkillUI.OverView
		if skill.frame and skill.frame.valid then
			local globalSkillData , playerSkillData = SIRPGSystem.GetPlayerSkillData( playerIndex , SIRPGSkillUI_OverView.SkillID )
			local pointDataIndex = tonumber( name:sub( SIRPGSkillUI_OverView.Names.DeletePosition ) ) or 0
			local pointData = playerSkillData.CustomData.PointList[pointDataIndex]
			if pointData then
				table.remove( playerSkillData.CustomData.PointList , pointDataIndex )
				if playerSkillData.CustomData.DefaultPointDataIndex == pointDataIndex then
					playerSkillData.CustomData.DefaultPointDataIndex = nil
				end
				SIRPGSystem.SavePlayerSkillData( playerIndex , SIRPGSkillUI_OverView.SkillID , playerSkillData )
				SIRPGSkillUI_OverView.FreshList( settings , playerSkillData )
			end
		end
	end ,
	FreshSurfaceName = function( surface )
		local surfaceName = surface.name
		for surfacePrefix , value in pairs( SIConfigs.SIRPGSystem.SurfacePrefixWhiteList ) do
			if surfaceName:StartsWith( surfacePrefix ) then
				local surfaceIndex = surface.index
				for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIRPGSystem.Settings.Name ) ) do
					local skill = settings.SkillUI.OverView
					local globalSkillData , playerSkillData = SIRPGSystem.GetPlayerSkillData( playerIndex , SIRPGSkillUI_OverView.SkillID )
					local changeFlag = false
					local currentPointData = playerSkillData.CustomData.CurrentPoint
					if currentPointData and currentPointData.name:StartsWith( surfacePrefix ) then
						currentPointData.name = surfaceName
						currentPointData.surface = surfaceIndex
						changeFlag = true
						if skill.frame and skill.frame.valid then
							local pointText = { "SIRPGSystem.技能面板-洞察-窗口-坐标" , currentPointData.name , currentPointData.x , currentPointData.y }
							skill.point.caption = pointText
							skill.point.tooltip = pointText
						end
					end
					for pointDataIndex , pointData in pairs( playerSkillData.CustomData.PointList ) do
						if pointData.name:StartsWith( surfacePrefix ) then
							pointData.name = surfaceName
							pointData.surface = surfaceIndex
							changeFlag = true
						end
					end
					if changeFlag then
						if skill.frame and skill.frame.valid then
							SIRPGSkillUI_OverView.FreshList( settings , playerSkillData )
						end
						SIRPGSystem.SavePlayerSkillData( playerIndex , SIRPGSkillUI_OverView.SkillID , playerSkillData )
					end
				end
				break
			end
		end
	end ,
	ChangeSurfaceName = function( surface , oldName )
		local oldSurfaceName = oldName or surface.name
		local newSurfaceName = surface.name
		local surfaceIndex = surface.index
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIRPGSystem.Settings.Name ) ) do
			local skill = settings.SkillUI.OverView
			local globalSkillData , playerSkillData = SIRPGSystem.GetPlayerSkillData( playerIndex , SIRPGSkillUI_OverView.SkillID )
			local changeFlag = false
			local currentPointData = playerSkillData.CustomData.CurrentPoint
			if currentPointData and currentPointData.name == oldSurfaceName then
				currentPointData.name = newSurfaceName
				currentPointData.surface = surfaceIndex
				changeFlag = true
				if skill.frame and skill.frame.valid then
					local pointText = { "SIRPGSystem.技能面板-洞察-窗口-坐标" , currentPointData.name , currentPointData.x , currentPointData.y }
					skill.point.caption = pointText
					skill.point.tooltip = pointText
				end
			end
			for pointDataIndex , pointData in pairs( playerSkillData.CustomData.PointList ) do
				if pointData.name == oldSurfaceName then
					pointData.name = newSurfaceName
					pointData.surface = surfaceIndex
					changeFlag = true
				end
			end
			if changeFlag then
				if skill.frame and skill.frame.valid then
					SIRPGSkillUI_OverView.FreshList( settings , playerSkillData )
				end
				SIRPGSystem.SavePlayerSkillData( playerIndex , SIRPGSkillUI_OverView.SkillID , playerSkillData )
			end
		end
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 地图窗口 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	OpenMapFrame = function( playerIndex , pointDataIndex , pointData , durationTime )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local map = pointDataIndex == 0 and settings.SkillUI.OverView.CurrentPoint or settings.SkillUI.OverView.PointList[pointDataIndex]
		if not map or map.frame and map.frame.valid then
			SIPrint.Warning( playerIndex , { "SIRPGSystem.技能面板-洞察-正在洞察" } )
			return false
		end
		local player = game.get_player( playerIndex )
		-- 显示窗口
		local frameName = SIRPGSkillUI_OverView.Names.FrameMapPrefix .. pointDataIndex
		local frame = SIElements.CreateFrame( player , map ,
		{
			Name         = frameName ,
			Close        = SIRPGSkillUI_OverView.Names.CloseMapPrefix .. pointDataIndex ,
			Style        = SIConstants_RPGSystem.raw.Styles.SkillUI_OverView_Frame ,
			Title        = { "SIRPGSystem.技能面板-洞察-地图-标题" } ,
			TitleTooltip = { "SIRPGSystem.技能面板-洞察-地图-标题-提示" , { "SIRPGSystem.技能面板-洞察-窗口-坐标" , pointData.name , pointData.x , pointData.y } } ,
			CloseTooltip = { "SIRPGSystem.技能面板-洞察-地图-关闭-提示" } ,
			OtherButtons =
			{
				{
					Name    = SIRPGSkillUI_OverView.Names.ZoomOutMapPrefix .. pointDataIndex ,
					Item    = SIConstants_Core.raw.Items.IconToUp ,
					Tooltip = { "SIRPGSystem.技能面板-洞察-地图-缩小-提示" } ,
				} ,
				{
					Name    = SIRPGSkillUI_OverView.Names.ZoomDefaultMapPrefix .. pointDataIndex ,
					Item    = SIConstants_Core.raw.Items.IconToCenter ,
					Tooltip = { "SIRPGSystem.技能面板-洞察-地图-默认-提示" } ,
				} ,
				{
					Name    = SIRPGSkillUI_OverView.Names.ZoomInMapPrefix .. pointDataIndex ,
					Item    = SIConstants_Core.raw.Items.IconToDown ,
					Tooltip = { "SIRPGSystem.技能面板-洞察-地图-放大-提示" } ,
				}
			}
		} )
		-- 第 1 层
		map.map = frame.add
		{
			type = "camera" ,
			surface_index = pointData.surface ,
			position = { x = pointData.x + 0.5 , y = pointData.y + 0.5 } ,
			zoom = map.zoom ,
			ignored_by_interaction = true ,
			style = SIConstants_RPGSystem.raw.Styles.SkillUI_OverView_Map_Camera
		}
		-- 添加延时关闭事件
		SIEventBus.AddAsyncData
		{
			[durationTime] =
			{
				data =
				{
					playerIndex = playerIndex ,
					name = frameName
				} ,
				funcName = "SIRPGSkillUI_OverView_CloseMapFrame"
			}
		}
		return true
	end ,
	CloseMapFrame = function( playerIndex , name )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local pointDataIndex = tonumber( name:sub( SIRPGSkillUI_OverView.Names.CloseMapPosition ) ) or 0
		local map = pointDataIndex == 0 and settings.SkillUI.OverView.CurrentPoint or settings.SkillUI.OverView.PointList[pointDataIndex]
		if map and map.frame and map.frame.valid then
			map.frame.destroy()
			map.frame = nil
			map.map = nil
		end
	end ,
	MoveMapFrame = function( playerIndex , name )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local pointDataIndex = tonumber( name:sub( SIRPGSkillUI_OverView.Names.FrameMapPosition ) ) or 0
		local map = pointDataIndex == 0 and settings.SkillUI.OverView.CurrentPoint or settings.SkillUI.OverView.PointList[pointDataIndex]
		if map and map.frame and map.frame.valid then
			SIElements.SaveFrameLocation( map )
		end
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 地图操作 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	ZoomOutMap = function( playerIndex , name )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local pointDataIndex = tonumber( name:sub( SIRPGSkillUI_OverView.Names.ZoomOutMapPosition ) ) or 0
		local map = pointDataIndex == 0 and settings.SkillUI.OverView.CurrentPoint or settings.SkillUI.OverView.PointList[pointDataIndex]
		if map and map.frame and map.frame.valid then
			map.zoom = math.max( map.map.zoom / SIRPGSkillUI_OverView.ZoomStep , SIRPGSkillUI_OverView.ZoomMin )
			map.map.zoom = map.zoom
		end
	end ,
	ZoomDefaultMap = function( playerIndex , name )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local pointDataIndex = tonumber( name:sub( SIRPGSkillUI_OverView.Names.ZoomDefaultMapPosition ) ) or 0
		local map = pointDataIndex == 0 and settings.SkillUI.OverView.CurrentPoint or settings.SkillUI.OverView.PointList[pointDataIndex]
		if map and map.frame and map.frame.valid then
			map.zoom = SIRPGSkillUI_OverView.ZoomDefault
			map.map.zoom = map.zoom
		end
	end ,
	ZoomInMap = function( playerIndex , name )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local pointDataIndex = tonumber( name:sub( SIRPGSkillUI_OverView.Names.ZoomInMapPosition ) ) or 0
		local map = pointDataIndex == 0 and settings.SkillUI.OverView.CurrentPoint or settings.SkillUI.OverView.PointList[pointDataIndex]
		if map and map.frame and map.frame.valid then
			map.zoom = math.min( map.map.zoom * SIRPGSkillUI_OverView.ZoomStep , SIRPGSkillUI_OverView.ZoomMax )
			map.map.zoom = map.zoom
		end
	end
}

SIRPGSkillUI_OverView.Names.DefaultPosition = #SIRPGSkillUI_OverView.Names.DefaultPrefix + 1
SIRPGSkillUI_OverView.Names.UsePosition = #SIRPGSkillUI_OverView.Names.UsePrefix + 1
SIRPGSkillUI_OverView.Names.DeletePosition = #SIRPGSkillUI_OverView.Names.DeletePrefix + 1
SIRPGSkillUI_OverView.Names.FrameMapPosition = #SIRPGSkillUI_OverView.Names.FrameMapPrefix + 1
SIRPGSkillUI_OverView.Names.CloseMapPosition = #SIRPGSkillUI_OverView.Names.CloseMapPrefix + 1
SIRPGSkillUI_OverView.Names.ZoomOutMapPosition = #SIRPGSkillUI_OverView.Names.ZoomOutMapPrefix + 1
SIRPGSkillUI_OverView.Names.ZoomDefaultMapPosition = #SIRPGSkillUI_OverView.Names.ZoomDefaultMapPrefix + 1
SIRPGSkillUI_OverView.Names.ZoomInMapPosition = #SIRPGSkillUI_OverView.Names.ZoomInMapPrefix + 1

function SIRPGSkillUI_OverView_CloseMapFrame( gameTick , data )
	SIRPGSkillUI_OverView.CloseMapFrame( data.playerIndex , data.name )
end
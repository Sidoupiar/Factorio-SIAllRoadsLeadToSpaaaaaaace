-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 迁移核心持久化数据 ==============================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIGlobal.Set( SIMainData.Settings.Name , SIGlobal.Get( "Mainbar" ) )
SIGlobal.Set( "Mainbar" , nil )
local mainData = SIGlobal.GetGlobalSettings( SIMainData.Settings.Name )
mainData.InnerVersion = 0

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 调整持久化数据 ==================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- 维护主面板数据
for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIMainData.Settings.Name ) ) do
	-- 修改主面板窗口数据
	if settings.Setting.view then
		settings.Setting.frame = settings.Setting.view
		settings.Setting.view = nil
	end
	if settings.Note.view then
		settings.Note.frame = settings.Note.view
		settings.Note.view = nil
	end
	if settings.Message.view then
		settings.Message.frame = settings.Message.view
		settings.Message.view = nil
	end
	-- 修改主面板设置数据
	if not settings.Setting.Base.showGameTimeMode then
		settings.Setting.Base.showGameTimeMode = 1
	end
	-- 重新绘制主面板
	SIMainbar.CloseFrame( playerIndex )
	SIMainbar.OpenFrame( playerIndex )
end

-- 维护信息查询数据
for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIFinder.Settings.Name ) ) do
	-- 修改窗口数据
	if settings.view then
		settings.frame = settings.view
		settings.view = nil
	end
end

-- 维护权限管理数据
for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIPermission.Settings.Name ) ) do
	-- 修改窗口数据
	if settings.view then
		settings.frame = settings.view
		settings.view = nil
	end
end

-- 维护黄图数据
for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIOreMap.Settings.Name ) ) do
	-- 修改窗口数据
	if settings.view then
		settings.frame = settings.view
		settings.view = nil
	end
end

-- 维护 RPG 系统数据
local rpgGlobalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
rpgGlobalSettings.Setting.AttackPointPerLevel         = SIRPGSystem.Settings.DefaultGlobal.Setting.AttackPointPerLevel
rpgGlobalSettings.Setting.AttackPointExtraWithEnd5    = SIRPGSystem.Settings.DefaultGlobal.Setting.AttackPointExtraWithEnd5
rpgGlobalSettings.Setting.AttackPointExtraWithEnd0    = SIRPGSystem.Settings.DefaultGlobal.Setting.AttackPointExtraWithEnd0
rpgGlobalSettings.Setting.AdventurePointPerLevel      = SIRPGSystem.Settings.DefaultGlobal.Setting.AdventurePointPerLevel
rpgGlobalSettings.Setting.AdventurePointExtraWithEnd5 = SIRPGSystem.Settings.DefaultGlobal.Setting.AdventurePointExtraWithEnd5
rpgGlobalSettings.Setting.AdventurePointExtraWithEnd0 = SIRPGSystem.Settings.DefaultGlobal.Setting.AdventurePointExtraWithEnd0
rpgGlobalSettings.Setting.CraftPointPerLevel          = SIRPGSystem.Settings.DefaultGlobal.Setting.CraftPointPerLevel
rpgGlobalSettings.Setting.CraftPointExtraWithEnd5     = SIRPGSystem.Settings.DefaultGlobal.Setting.CraftPointExtraWithEnd5
rpgGlobalSettings.Setting.CraftPointExtraWithEnd0     = SIRPGSystem.Settings.DefaultGlobal.Setting.CraftPointExtraWithEnd0
rpgGlobalSettings.SkillList = {}
rpgGlobalSettings.SkillOrderList = {}
rpgGlobalSettings.SkillTypeOrderList = {}
rpgGlobalSettings.Setting.PropertyEffects = SIUtils.table.deepcopy( SIRPGSystem.Settings.DefaultGlobal.Setting.PropertyEffects )
if not rpgGlobalSettings.EXP then
	rpgGlobalSettings.EXP = SIUtils.table.deepcopy( SIRPGSystem.Settings.DefaultGlobal.EXP )
	SIRPGSystem.FreshSpecialList()
end
for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIRPGSystem.Settings.Name ) ) do
	-- 添加新数据
	if not settings.PlayerStatusMini then
		settings.PlayerStatusMini =
		{
			frame = nil ,
			frameLocation = nil ,
			frameLocked = false ,
			levelCountAttack = nil ,
			levelCountAdventure = nil ,
			levelCountCraft = nil ,
			levelProgressAttack = nil ,
			levelProgressAdventure = nil ,
			levelProgressCraft = nil
		}
		settings.PlayerSetting.Base.showPlayerStatusMini = false
	end
	if not settings.PlayerSetting.Elements then
		settings.PlayerSetting.Elements =
		{
			itemFlyingText = nil
		}
	end
	settings.PlayerSetting.Base = SIUtils.table.deepcopy( SIRPGSystem.Settings.DefaultPlayer.PlayerSetting.Base )
	settings.EXP = SIUtils.table.deepcopy( settings.Exp )
	settings.Exp = nil
	settings.Base = nil
	settings.Current = nil
	settings.Value = SIUtils.table.deepcopy( SIRPGSystem.Settings.DefaultPlayer.Value )
	settings.PlayerStatus.ValueLabel = {}
	settings.PlayerStatus.ValueText = {}
	settings.PlayerStatus.ValueTextLeft = {}
	settings.PlayerStatus.ValueTextCenter = {}
	settings.PlayerStatus.ValueTextRight = {}
	settings.PlayerStatus.ValueBar = {}
	settings.PlayerStatus.AdditionButtons = {}
	settings.PlayerSkill = SIUtils.table.deepcopy( SIRPGSystem.Settings.DefaultPlayer.PlayerSkill )
	settings.PlayerInfo.ValueTextLeft = {}
	settings.PlayerInfo.ValueTextCenter = {}
	settings.PlayerInfo.ValueTextRight = {}
	settings.PlayerInfo.ValueBar = {}
	settings.SkillUI = SIUtils.table.deepcopy( SIRPGSystem.Settings.DefaultPlayer.SkillUI )
	SIRPGSystem.ClearPoints( playerIndex )
end
SIRPGSystem.AddSkills( SIRPGSkillData )

-- 添加新增的权限项目
if SIGlobal.HasGlobalSettings( SIPermission.Settings.Name ) then
	local permissionGlobalSettings = SIGlobal.GetGlobalSettings( SIPermission.Settings.Name )
	local DefaultPermissions = {}
	local DefaultNames = {}
	local DefaultMessages = {}
	local PermissionTooltips = {}
	for code , permissionID in pairs( SIPermission.PermissionIDs ) do
		DefaultPermissions[permissionID] = permissionGlobalSettings.DefaultPermissions[permissionID] or SIPermission.Settings.DefaultGlobal.DefaultPermissions[permissionID]
		DefaultNames[permissionID] = permissionGlobalSettings.DefaultNames[permissionID] or SIPermission.Settings.DefaultGlobal.DefaultNames[permissionID]
		DefaultMessages[permissionID] = permissionGlobalSettings.DefaultMessages[permissionID] or SIPermission.Settings.DefaultGlobal.DefaultMessages[permissionID]
		PermissionTooltips[permissionID] = permissionGlobalSettings.PermissionTooltips[permissionID] or SIPermission.Settings.DefaultGlobal.PermissionTooltips[permissionID]
	end
	for basePermissionID , inputActionName in pairs( defines.input_action ) do
		DefaultPermissions[basePermissionID] = permissionGlobalSettings.DefaultPermissions[basePermissionID] or SIPermission.PermissionCode.TRUE
		DefaultNames[basePermissionID] = permissionGlobalSettings.DefaultNames[basePermissionID] or { "SICore.权限名称-" .. basePermissionID }
		PermissionTooltips[basePermissionID] = permissionGlobalSettings.PermissionTooltips[basePermissionID] or { "SICore.权限提示-" .. basePermissionID }
	end
	for permissionID , isExpand in pairs( permissionGlobalSettings.ExpandPermissions ) do
		if isExpand then
			DefaultPermissions[permissionID] = permissionGlobalSettings.DefaultPermissions[permissionID] or SIPermission.PermissionCode.TRUE
			DefaultNames[permissionID] = permissionGlobalSettings.DefaultNames[permissionID] or "未知"
			DefaultMessages[permissionID] = permissionGlobalSettings.DefaultMessages[permissionID] or "发生了未知错误"
			PermissionTooltips[permissionID] = permissionGlobalSettings.PermissionTooltips[permissionID] or { "SICore.权限提示-无" }
		end
	end
	permissionGlobalSettings.DefaultPermissions = DefaultPermissions
	permissionGlobalSettings.DefaultNames = DefaultNames
	permissionGlobalSettings.DefaultMessages = DefaultMessages
	permissionGlobalSettings.PermissionTooltips = PermissionTooltips
end
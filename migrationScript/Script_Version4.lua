-- ------------------------------------------------------------------------------------------------
-- ------- 调整持久化数据 -------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

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
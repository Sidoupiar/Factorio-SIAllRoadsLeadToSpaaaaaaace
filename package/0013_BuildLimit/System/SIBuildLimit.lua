SIBuildLimit =
{
	ID = "SIBuildLimit" ,
	Name = "建造限制" ,
	InterfaceID = "SIBuildLimit" ,
	Settings =
	{
		Name = "SIBuildLimit" ,
		DefaultGlobal =
		{
			LimitData = {} ,
			Machines = {} ,
			Beacons = {} ,
			Modules = {} ,
			Icons = {} ,
		} ,
		DefaultPlayer =
		{
			CurrentEntity = nil
		}
	} ,
	ModuleMachine =
	{
		[SICommon.Types.Entities.Mining] = true ,
		[SICommon.Types.Entities.Furnace] = true ,
		[SICommon.Types.Entities.Machine] = true ,
		[SICommon.Types.Entities.Lab] = true ,
		[SICommon.Types.Entities.RocketSilo] = true
	} ,
	ModuleEntity =
	{
		[SICommon.Types.Entities.Mining] = true ,
		[SICommon.Types.Entities.Furnace] = true ,
		[SICommon.Types.Entities.Machine] = true ,
		[SICommon.Types.Entities.Lab] = true ,
		[SICommon.Types.Entities.RocketSilo] = true ,
		[SICommon.Types.Entities.Beacon] = true
	} ,
	-- ------------------------------------------------------------------------------------------------
	-- ----------- 初始化 -----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	InitData = function()
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 功能函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	CreateAlertBeacon = function( entity )
		local globalSettings = SIGlobal.GetGlobalSettings( SIBuildLimit.Settings.Name )
		local unitNumber = entity.unit_number
		local iconData = globalSettings.Icons[unitNumber]
		if not iconData or not iconData.Beacon then
			local prototype = entity.prototype
			local iconID = rendering.draw_sprite
			{
				sprite = SIConstants_BuildLimit.raw.Sprites.Beacon ,
				orientation = 0 ,
				orientation_target = nil ,
				orientation_target_offset = nil ,
				oriented_offset = nil ,
				x_scale = prototype.alert_icon_scale or 1.0 ,
				y_scale = prototype.alert_icon_scale or 1.0 ,
				tint = nil ,
				render_layer = SICommon.Flags.RenderLayer.AirEntityInfoIcon ,
				target = entity ,
				target_offset = prototype.alert_icon_shift or { 0 , 0 } ,
				surface = entity.surface ,
				time_to_live = nil ,
				forces = { entity.force } ,
				players = nil ,
				visible = true ,
				only_in_alt_mode = false
			}
			if iconData then
				iconData.Beacon = iconID
			else
				globalSettings.Icons[unitNumber] = { Beacon = iconID }
			end
		end
	end ,
	CreateAlertModule = function( entity )
		local globalSettings = SIGlobal.GetGlobalSettings( SIBuildLimit.Settings.Name )
		local unitNumber = entity.unit_number
		local iconData = globalSettings.Icons[unitNumber]
		if not iconData or not iconData.Module then
			local prototype = entity.prototype
			local iconID = rendering.draw_sprite
			{
				sprite = SIConstants_BuildLimit.raw.Sprites.Module ,
				orientation = 0 ,
				orientation_target = nil ,
				orientation_target_offset = nil ,
				oriented_offset = nil ,
				x_scale = prototype.alert_icon_scale or 1.0 ,
				y_scale = prototype.alert_icon_scale or 1.0 ,
				tint = nil ,
				render_layer = SICommon.Flags.RenderLayer.AirEntityInfoIcon ,
				target = entity ,
				target_offset = prototype.alert_icon_shift or { 0 , 0 } ,
				surface = entity.surface ,
				time_to_live = nil ,
				forces = { entity.force } ,
				players = nil ,
				visible = true ,
				only_in_alt_mode = false
			}
			if iconData then
				iconData.Module = iconID
			else
				globalSettings.Icons[unitNumber] = { Module = iconID }
			end
		end
	end ,
	ShowFlyingText = function( entity , isInventory , realShow )
		if not realShow then
			return
		end
		if isInventory then
			SIFunctions.FlyingTextForce( { "SIBuildLimit.不支持的插件-容器" } , entity , 1 , entity.force )
		else
			SIFunctions.FlyingTextForce( { "SIBuildLimit.不支持的插件-请求" } , entity , 1 , entity.force )
		end
	end ,
	RemoveAlertBeacon = function( entity )
		local globalSettings = SIGlobal.GetGlobalSettings( SIBuildLimit.Settings.Name )
		local unitNumber = entity.unit_number
		local iconData = globalSettings.Icons[unitNumber]
		if iconData then
			if iconData.Beacon then
				rendering.destroy( iconData.Beacon )
				iconData.Beacon = nil
			end
			if not iconData.Module then
				globalSettings.Icons[unitNumber] = nil
			end
		end
	end ,
	RemoveAlertModule = function( entity )
		local globalSettings = SIGlobal.GetGlobalSettings( SIBuildLimit.Settings.Name )
		local unitNumber = entity.unit_number
		local iconData = globalSettings.Icons[unitNumber]
		if iconData then
			if iconData.Module then
				rendering.destroy( iconData.Module )
				iconData.Module = nil
			end
			if not iconData.Beacon then
				globalSettings.Icons[unitNumber] = nil
			end
		end
	end ,
	EffectMachine = function( globalSettings , machine , removedBeacon )
		local name = machine.name
		local removedBeaconNumber = removedBeacon and removedBeacon.unit_number or nil
		local beaconList = machine.get_beacons() or {}
		local entityLimitDataIDList = globalSettings.Machines[name]
		if #beaconList > 0 or entityLimitDataIDList then
			-- 统计设备插件塔情况
			local beaconCount = machine.beacons_count
			if removedBeacon then
				beaconCount = beaconCount - 1
			end
			local beaconCountList = {}
			for index , beacon in pairs( machine.get_beacons() or {} ) do
				if beacon.unit_number ~= removedBeaconNumber then
					local beaconName = beacon.name
					beaconCountList[beaconName] = ( beaconCountList[beaconName] or 0 ) + 1
				end
			end
			-- 遍历建造限制数据包 - 插件塔
			if #beaconList > 0 then
				for index , beacon in pairs( beaconList ) do
					if beacon.unit_number ~= removedBeaconNumber then
						local beaconName = beacon.name
						local beaconLimitDataIDList = globalSettings.Beacons[beaconName]
						if beaconLimitDataIDList then
							for limitDataIDIndex , limitDataID in pairs( beaconLimitDataIDList ) do
								local limitData = globalSettings.LimitData[limitDataID]
								if beaconCount < limitData.MinBeaconCount then
									machine.active = false
									SIBuildLimit.CreateAlertBeacon( machine )
									return
								end
								if beaconCount > limitData.MaxBeaconCount then
									machine.active = false
									SIBuildLimit.CreateAlertBeacon( machine )
									return
								end
								local whiteList = limitData.WhiteList
								if whiteList then
									if not whiteList[name] then
										machine.active = false
										SIBuildLimit.CreateAlertBeacon( machine )
										return
									end
									local count = beaconCountList[beaconName] or 0
									if count > whiteList[name] then
										machine.active = false
										SIBuildLimit.CreateAlertBeacon( machine )
										return
									end
								end
							end
						end
					end
				end
			end
			-- 遍历建造限制数据包 - 设备
			if entityLimitDataIDList then
				for limitDataIDIndex , limitDataID in pairs( entityLimitDataIDList ) do
					local limitData = globalSettings.LimitData[limitDataID]
					if beaconCount < limitData.MinBeaconCount then
						machine.active = false
						SIBuildLimit.CreateAlertBeacon( machine )
						return
					end
					if beaconCount > limitData.MaxBeaconCount then
						machine.active = false
						SIBuildLimit.CreateAlertBeacon( machine )
						return
					end
					if limitData.RequireList then
						for beaconName , requireCount in pairs( limitData.RequireList ) do
							local count = beaconCountList[beaconName] or 0
							if count < requireCount then
								machine.active = false
								SIBuildLimit.CreateAlertBeacon( machine )
								return
							end
						end
					end
					local whiteList = limitData.WhiteList
					if whiteList then
						for beaconName , count in pairs( beaconCountList ) do
							if not whiteList[beaconName] then
								machine.active = false
								SIBuildLimit.CreateAlertBeacon( machine )
								return
							end
							if count > whiteList[beaconName] then
								machine.active = false
								SIBuildLimit.CreateAlertBeacon( machine )
								return
							end
						end
					end
				end
			end
		end
		machine.active = true
		SIBuildLimit.RemoveAlertBeacon( machine )
	end ,
	EffectModule = function( globalSettings , playerIndex , entity , showFlyingText )
		local type = entity.type
		if type == SICommon.Types.Entities.GhostEntity then
			local limitDataIDList = globalSettings.Modules[entity.ghost_prototype.name]
			if limitDataIDList then
				-- 统计设备插件情况
				local moduleCount = 0
				local moduleCountList = {}
				for itemName , count in pairs( entity.item_requests or {} ) do
					moduleCount = moduleCount + count
					moduleCountList[itemName] = count
				end
				-- 遍历建造限制数据包
				for limitDataIDIndex , limitDataID in pairs( limitDataIDList ) do
					local limitData = globalSettings.LimitData[limitDataID]
					if moduleCount < limitData.MinModuleCount then
						entity.item_requests = {}
						SIBuildLimit.ShowFlyingText( entity , false , showFlyingText )
						return
					end
					if moduleCount > limitData.MaxModuleCount then
						entity.item_requests = {}
						SIBuildLimit.ShowFlyingText( entity , false , showFlyingText )
						return
					end
					if limitData.NeedModuleList then
						for moduleName , needCount in pairs( limitData.NeedModuleList ) do
							local count = moduleCountList[moduleName] or 0
							if count < needCount then
								entity.item_requests = {}
								SIBuildLimit.ShowFlyingText( entity , false , showFlyingText )
								return
							end
						end
					end
					local supportModuleList = limitData.SupportModuleList
					if supportModuleList then
						for moduleName , count in pairs( moduleCountList ) do
							if not supportModuleList[moduleName] then
								entity.item_requests = {}
								SIBuildLimit.ShowFlyingText( entity , false , showFlyingText )
								return
							end
							if count > supportModuleList[moduleName] then
								entity.item_requests = {}
								SIBuildLimit.ShowFlyingText( entity , false , showFlyingText )
								return
							end
						end
					end
				end
			end
		elseif type == SICommon.Types.Entities.ProxyItemRequest then
			local targetEntity = entity.proxy_target
			local limitDataIDList = globalSettings.Modules[targetEntity.name]
			if limitDataIDList then
				local position = targetEntity.position
				local selectionBox = targetEntity.prototype.selection_box
				local proxyList = targetEntity.surface.find_entities_filtered
				{
					type = SICommon.Types.Entities.ProxyItemRequest ,
					area = { { selectionBox.left_top.x + position.x , selectionBox.left_top.y + position.y } , { selectionBox.right_bottom.x + position.x , selectionBox.right_bottom.y + position.y } }
				}
				if #proxyList > 0 then
					local unitNumber = targetEntity.unit_number
					-- 统计设备插件情况
					local moduleCount = 0
					local moduleCountList = {}
					local newProxyList = {}
					for index , proxy in pairs( proxyList ) do
						if proxy.proxy_target.unit_number == unitNumber then
							for itemName , count in pairs( proxy.item_requests or {} ) do
								moduleCount = moduleCount + count
								moduleCountList[itemName] = ( moduleCountList[itemName] or 0 ) + count
								table.insert( newProxyList , proxy )
							end
						end
					end
					-- 遍历建造限制数据包
					for limitDataIDIndex , limitDataID in pairs( limitDataIDList ) do
						local limitData = globalSettings.LimitData[limitDataID]
						if moduleCount < limitData.MinModuleCount then
							for index , proxy in pairs( newProxyList ) do
								proxy.item_requests = {}
							end
							SIBuildLimit.ShowFlyingText( entity , false , showFlyingText )
							return
						end
						if moduleCount > limitData.MaxModuleCount then
							for index , proxy in pairs( newProxyList ) do
								proxy.item_requests = {}
							end
							SIBuildLimit.ShowFlyingText( entity , false , showFlyingText )
							return
						end
						if limitData.NeedModuleList then
							for moduleName , needCount in pairs( limitData.NeedModuleList ) do
								local count = moduleCountList[moduleName] or 0
								if count < needCount then
									for index , proxy in pairs( newProxyList ) do
										proxy.item_requests = {}
									end
									SIBuildLimit.ShowFlyingText( entity , false , showFlyingText )
									return
								end
							end
						end
						local supportModuleList = limitData.SupportModuleList
						if supportModuleList then
							for moduleName , count in pairs( moduleCountList ) do
								if not supportModuleList[moduleName] then
									for index , proxy in pairs( newProxyList ) do
										proxy.item_requests = {}
									end
									SIBuildLimit.ShowFlyingText( entity , false , showFlyingText )
									return
								end
								if count > supportModuleList[moduleName] then
									for index , proxy in pairs( newProxyList ) do
										proxy.item_requests = {}
									end
									SIBuildLimit.ShowFlyingText( entity , false , showFlyingText )
									return
								end
							end
						end
					end
				end
			end
		elseif SIBuildLimit.ModuleEntity[type] then
			local limitDataIDList = globalSettings.Modules[entity.name]
			if limitDataIDList then
				-- 额外检测物品请求实体
				local position = entity.position
				local selectionBox = entity.prototype.selection_box
				local proxyList = entity.surface.find_entities_filtered
				{
					type = SICommon.Types.Entities.ProxyItemRequest ,
					area = { { selectionBox.left_top.x + position.x , selectionBox.left_top.y + position.y } , { selectionBox.right_bottom.x + position.x , selectionBox.right_bottom.y + position.y } }
				}
				local unitNumber = entity.unit_number
				local newProxyList = {}
				-- 统计设备插件情况
				local moduleCount = 0
				local moduleCountList = {}
				local moduleCountSelf = 0
				local moduleCountListSelf = {}
				local moduleInventory = entity.get_module_inventory()
				if moduleInventory then
					for itemName , count in pairs( moduleInventory.get_contents() ) do
						moduleCount = moduleCount + count
						moduleCountSelf = moduleCountSelf + count
						moduleCountList[itemName] = count
						moduleCountListSelf[itemName] = count
					end
				end
				if #proxyList > 0 then
					for index , proxy in pairs( proxyList ) do
						if proxy.proxy_target.unit_number == unitNumber then
							for itemName , count in pairs( proxy.item_requests or {} ) do
								moduleCount = moduleCount + count
								moduleCountList[itemName] = ( moduleCountList[itemName] or 0 ) + count
							end
							table.insert( newProxyList , proxy )
						end
					end
				end
				-- 遍历建造限制数据包
				for limitDataIDIndex , limitDataID in pairs( limitDataIDList ) do
					local limitData = globalSettings.LimitData[limitDataID]
					if moduleCount < limitData.MinModuleCount then
						if moduleCountSelf < limitData.MinModuleCount then
							entity.active = false
							SIBuildLimit.CreateAlertModule( entity )
						end
						if #newProxyList > 0 then
							for index , proxy in pairs( newProxyList ) do
								proxy.item_requests = {}
							end
						end
						SIBuildLimit.ShowFlyingText( entity , moduleCountSelf < limitData.MinModuleCount , showFlyingText )
						return
					end
					if moduleCount > limitData.MaxModuleCount then
						if moduleCountSelf > limitData.MinModuleCount then
							entity.active = false
							SIBuildLimit.CreateAlertModule( entity )
						end
						if #newProxyList > 0 then
							for index , proxy in pairs( newProxyList ) do
								proxy.item_requests = {}
							end
						end
						SIBuildLimit.ShowFlyingText( entity , moduleCountSelf > limitData.MinModuleCount , showFlyingText )
						return
					end
					if limitData.NeedModuleList then
						for moduleName , needCount in pairs( limitData.NeedModuleList ) do
							local count = moduleCountList[moduleName] or 0
							if count < needCount then
								local countSelf = moduleCountListSelf[moduleName] or 0
								if countSelf < needCount then
									entity.active = false
									SIBuildLimit.CreateAlertModule( entity )
								end
								if #newProxyList > 0 then
									for index , proxy in pairs( newProxyList ) do
										proxy.item_requests = {}
									end
								end
								SIBuildLimit.ShowFlyingText( entity , countSelf < needCount , showFlyingText )
								return
							end
						end
					end
					local supportModuleList = limitData.SupportModuleList
					if supportModuleList then
						for moduleName , count in pairs( moduleCountList ) do
							if not supportModuleList[moduleName] then
								if moduleCountListSelf[moduleName] then
									entity.active = false
									SIBuildLimit.CreateAlertModule( entity )
								end
								if #newProxyList > 0 then
									for index , proxy in pairs( newProxyList ) do
										proxy.item_requests = {}
									end
								end
								SIBuildLimit.ShowFlyingText( entity , moduleCountListSelf[moduleName] , showFlyingText )
								return
							end
							local supportCount = supportModuleList[moduleName]
							if count > supportCount then
								local countSelf = moduleCountListSelf[moduleName] or 0
								if countSelf > supportCount then
									entity.active = false
									SIBuildLimit.CreateAlertModule( entity )
								end
								if #newProxyList > 0 then
									for index , proxy in pairs( newProxyList ) do
										proxy.item_requests = {}
									end
								end
								SIBuildLimit.ShowFlyingText( entity , countSelf > supportCount , showFlyingText )
								return
							end
						end
					end
				end
			end
			entity.active = true
			SIBuildLimit.RemoveAlertModule( entity )
		end
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 事件函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	BuildEntity = function( playerIndex , entity )
		local globalSettings = SIGlobal.GetGlobalSettings( SIBuildLimit.Settings.Name )
		local type = entity.type
		if type == SICommon.Types.Entities.Beacon then
			for index , machine in pairs( entity.get_beacon_effect_receivers() ) do
				SIBuildLimit.EffectMachine( globalSettings , machine , nil )
				if machine.active then
					SIBuildLimit.EffectModule( globalSettings , playerIndex , machine , true )
				end
			end
			SIBuildLimit.EffectModule( globalSettings , playerIndex , entity , true )
		elseif SIBuildLimit.ModuleMachine[type] then
			SIBuildLimit.EffectMachine( globalSettings , entity , nil )
			if entity.active then
				SIBuildLimit.EffectModule( globalSettings , playerIndex , entity , true )
			end
		end
	end ,
	DestroyEntity = function( playerIndex , entity )
		local globalSettings = SIGlobal.GetGlobalSettings( SIBuildLimit.Settings.Name )
		if entity.type == SICommon.Types.Entities.Beacon then
			for index , machine in pairs( entity.get_beacon_effect_receivers() ) do
				SIBuildLimit.EffectMachine( globalSettings , machine , entity )
				if machine.active then
					SIBuildLimit.EffectModule( globalSettings , playerIndex , machine , true )
				end
			end
		end
		SIBuildLimit.DestroyEntityIcons( entity.unit_number )
	end ,
	CheckModule = function( playerIndex , entity , showFlyingText )
		local globalSettings = SIGlobal.GetGlobalSettings( SIBuildLimit.Settings.Name )
		SIBuildLimit.EffectModule( globalSettings , playerIndex , entity , showFlyingText )
		if entity.active and SIBuildLimit.ModuleMachine[entity.type] then
			SIBuildLimit.EffectMachine( globalSettings , entity , nil )
		end
	end ,
	PlayerOpenEntity = function( playerIndex , entity )
		if SIBuildLimit.ModuleEntity[entity.type] then
			local settings = SIGlobal.GetPlayerSettings( SIBuildLimit.Settings.Name , playerIndex )
			settings.CurrentEntity = entity
		end
	end ,
	PlayerCloseEntity = function( playerIndex , entity )
		local settings = SIGlobal.GetPlayerSettings( SIBuildLimit.Settings.Name , playerIndex )
		settings.CurrentEntity = nil
		local globalSettings = SIGlobal.GetGlobalSettings( SIBuildLimit.Settings.Name )
		SIBuildLimit.EffectModule( globalSettings , playerIndex , entity , true )
		if entity.active and SIBuildLimit.ModuleMachine[entity.type] then
			SIBuildLimit.EffectMachine( globalSettings , entity , nil )
		end
	end ,
	DestroyEntityIcons = function( unitNumber )
		local globalSettings = SIGlobal.GetGlobalSettings( SIBuildLimit.Settings.Name )
		local iconData = globalSettings.Icons[unitNumber]
		if iconData then
			if iconData.Beacon then
				rendering.destroy( iconData.Beacon )
			end
			if iconData.Module then
				rendering.destroy( iconData.Module )
			end
			globalSettings.Icons[unitNumber] = nil
		end
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ------ 接口函数 -- 注册 ------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------

	-- ----------------------------------------
	-- 添加一个建造限制数据包<br>
	-- 仅对新建的设备和插件塔生效<br>
	-- ----------------------------------------
	-- limitData     = 建造限制数据包 , 其结构见文件末尾的注释<br>
	-- ----------------------------------------
	AddLimitData = function( limitData )
		local globalSettings = SIGlobal.GetGlobalSettings( SIBuildLimit.Settings.Name )
		local limitDataID = limitData.ID
		if not limitDataID or globalSettings.LimitData[limitDataID] then
			return
		end
		limitData.MinBeaconCount = limitData.MinBeaconCount or -1
		limitData.MaxBeaconCount = limitData.MaxBeaconCount or 256
		limitData.MinModuleCount = limitData.MinModuleCount or -1
		limitData.MaxModuleCount = limitData.MaxModuleCount or 256
		globalSettings.LimitData[limitDataID] = limitData
		local entityName = nil
		if limitData.Machine then
			entityName = limitData.Machine
			local limitDataIDList = globalSettings.Machines[entityName]
			if not limitDataIDList then
				limitDataIDList = {}
				globalSettings.Machines[entityName] = limitDataIDList
			end
			table.insert( limitDataIDList , limitDataID )
		elseif limitData.Beacon then
			entityName = limitData.Beacon
			local limitDataIDList = globalSettings.Beacons[entityName]
			if not limitDataIDList then
				limitDataIDList = {}
				globalSettings.Beacons[entityName] = limitDataIDList
			end
			table.insert( limitDataIDList , limitDataID )
		end
		if entityName then
			local limitDataIDList = globalSettings.Modules[entityName]
			if not limitDataIDList then
				limitDataIDList = {}
				globalSettings.Modules[entityName] = limitDataIDList
			end
			table.insert( limitDataIDList , limitDataID )
		end
	end ,

	-- ----------------------------------------
	-- 添加多个建造限制数据包<br>
	-- 仅对新建的设备和插件塔生效<br>
	-- ----------------------------------------
	-- limitDataList = 建造限制数据包数组 , 其中包含多个建造限制数据包 , 其结构见文件末尾的注释<br>
	-- ----------------------------------------
	AddLimitDataList = function( limitDataList )
		local globalSettings = SIGlobal.GetGlobalSettings( SIBuildLimit.Settings.Name )
		for index , limitData in pairs( limitDataList ) do
			local limitDataID = limitData.ID
			if limitDataID and not globalSettings.LimitData[limitDataID] then
				limitData.MinBeaconCount = limitData.MinBeaconCount or -1
				limitData.MaxBeaconCount = limitData.MaxBeaconCount or 256
				limitData.MinModuleCount = limitData.MinModuleCount or -1
				limitData.MaxModuleCount = limitData.MaxModuleCount or 256
				globalSettings.LimitData[limitDataID] = limitData
				local entityName = nil
				if limitData.Machine then
					entityName = limitData.Machine
					local limitDataIDList = globalSettings.Machines[entityName]
					if not limitDataIDList then
						limitDataIDList = {}
						globalSettings.Machines[entityName] = limitDataIDList
					end
					table.insert( limitDataIDList , limitDataID )
				elseif limitData.Beacon then
					entityName = limitData.Beacon
					local limitDataIDList = globalSettings.Beacons[entityName]
					if not limitDataIDList then
						limitDataIDList = {}
						globalSettings.Beacons[entityName] = limitDataIDList
					end
					table.insert( limitDataIDList , limitDataID )
				end
				if entityName then
					local limitDataIDList = globalSettings.Modules[entityName]
					if not limitDataIDList then
						limitDataIDList = {}
						globalSettings.Modules[entityName] = limitDataIDList
					end
					table.insert( limitDataIDList , limitDataID )
				end
			end
		end
	end ,

	-- ----------------------------------------
	-- 更新一个建造限制数据包<br>
	-- 仅对新建的设备和插件塔生效<br>
	-- ----------------------------------------
	-- limitData     = 建造限制数据包 , 其结构见文件末尾的注释<br>
	-- ----------------------------------------
	FreshLimitData = function( limitData )
		local globalSettings = SIGlobal.GetGlobalSettings( SIBuildLimit.Settings.Name )
		local limitDataID = limitData.ID
		if not limitDataID or not globalSettings.LimitData[limitDataID] then
			return
		end
		local oldLimitData = globalSettings.LimitData[limitDataID]
		if oldLimitData.Machine then
			SITable.Remove( globalSettings.Machines[oldLimitData.Machine] , limitDataID )
			SITable.Remove( globalSettings.Modules[oldLimitData.Machine] , limitDataID )
		elseif oldLimitData.Beacon then
			SITable.Remove( globalSettings.Beacons[oldLimitData.Beacon] , limitDataID )
			SITable.Remove( globalSettings.Modules[oldLimitData.Beacon] , limitDataID )
		end
		limitData.MinBeaconCount = limitData.MinBeaconCount or -1
		limitData.MaxBeaconCount = limitData.MaxBeaconCount or 256
		limitData.MinModuleCount = limitData.MinModuleCount or -1
		limitData.MaxModuleCount = limitData.MaxModuleCount or 256
		globalSettings.LimitData[limitDataID] = limitData
		local entityName = nil
		if limitData.Machine then
			entityName = limitData.Machine
			local limitDataIDList = globalSettings.Machines[entityName]
			if not limitDataIDList then
				limitDataIDList = {}
				globalSettings.Machines[entityName] = limitDataIDList
			end
			table.insert( limitDataIDList , limitDataID )
		elseif limitData.Beacon then
			entityName = limitData.Beacon
			local limitDataIDList = globalSettings.Beacons[entityName]
			if not limitDataIDList then
				limitDataIDList = {}
				globalSettings.Beacons[entityName] = limitDataIDList
			end
			table.insert( limitDataIDList , limitDataID )
		end
		if entityName then
			local limitDataIDList = globalSettings.Modules[entityName]
			if not limitDataIDList then
				limitDataIDList = {}
				globalSettings.Modules[entityName] = limitDataIDList
			end
			table.insert( limitDataIDList , limitDataID )
		end
	end ,

	-- ----------------------------------------
	-- 更新多个建造限制数据包<br>
	-- 仅对新建的设备和插件塔生效<br>
	-- ----------------------------------------
	-- limitDataList = 建造限制数据包数组 , 其中包含多个建造限制数据包 , 其结构见文件末尾的注释<br>
	-- ----------------------------------------
	FreshLimitDataList = function( limitDataList )
		local globalSettings = SIGlobal.GetGlobalSettings( SIBuildLimit.Settings.Name )
		for index , limitData in pairs( limitDataList ) do
			local limitDataID = limitData.ID
			if limitDataID and globalSettings.LimitData[limitDataID] then
				local oldLimitData = globalSettings.LimitData[limitDataID]
				if oldLimitData.Machine then
					SITable.Remove( globalSettings.Machines[oldLimitData.Machine] , limitDataID )
					SITable.Remove( globalSettings.Modules[oldLimitData.Machine] , limitDataID )
				elseif oldLimitData.Beacon then
					SITable.Remove( globalSettings.Beacons[oldLimitData.Beacon] , limitDataID )
					SITable.Remove( globalSettings.Modules[oldLimitData.Beacon] , limitDataID )
				end
				limitData.MinBeaconCount = limitData.MinBeaconCount or -1
				limitData.MaxBeaconCount = limitData.MaxBeaconCount or 256
				limitData.MinModuleCount = limitData.MinModuleCount or -1
				limitData.MaxModuleCount = limitData.MaxModuleCount or 256
				globalSettings.LimitData[limitDataID] = limitData
				local entityName = nil
				if limitData.Machine then
					entityName = limitData.Machine
					local limitDataIDList = globalSettings.Machines[entityName]
					if not limitDataIDList then
						limitDataIDList = {}
						globalSettings.Machines[entityName] = limitDataIDList
					end
					table.insert( limitDataIDList , limitDataID )
				elseif limitData.Beacon then
					entityName = limitData.Beacon
					local limitDataIDList = globalSettings.Beacons[entityName]
					if not limitDataIDList then
						limitDataIDList = {}
						globalSettings.Beacons[entityName] = limitDataIDList
					end
					table.insert( limitDataIDList , limitDataID )
				end
				if entityName then
					local limitDataIDList = globalSettings.Modules[entityName]
					if not limitDataIDList then
						limitDataIDList = {}
						globalSettings.Modules[entityName] = limitDataIDList
					end
					table.insert( limitDataIDList , limitDataID )
				end
			end
		end
	end
}

-- ----------------------------------------
-- 注意 :
-- 1. ID 不可以为 nil
-- 2. Machine 和 Beacon 需要二选一 , 都填写使用 Machine , 这两个参数决定了建造限制数据包的类型
-- ----------------------------------------
-- 建造限制数据包的数据结构如下 :
-- ID             = "建造限制数据包的 ID , 用于各种事件的判断" ,
-- Name           = { "解锁数据包的名称 , 本地化字符串" } ,
-- Description    = { "解锁数据包的名称 , 本地化字符串" } ,
-- Machine        = "设备原型的 name 值" ,     -- 要求填写一个可以支持插件或插件塔的设备 (机器) , 不符合下列条件时 , 它会被代码禁用 , 一个设备可以拥有多个限制 , 限制之间结果合并方式为并集
-- Beacon         = "插件塔原型的 name 值" ,   -- 要求填写一个插件塔 , 此类型下各个 "插件塔原型的 name 值" 改为 "设备原型的 name 值" , RequireList 失效 , 不在白名单内的设备均会被代码禁用 , 禁用对象仍为设备而非插件塔
--
-- -- 插件塔条件列表
-- MinBeaconCount = 最小插件塔数量 ,    -- 默认 -1 , 也就是没有最小值
-- MaxBeaconCount = 最大插件塔数量 ,    -- 默认 256
-- RequireList =    -- 设备必须被这么多种类和数量的插件塔影响 , 它才会工作 , 否则会被代码禁用
-- {
--     ["插件塔原型的 name 值"] = 必要数量 ,
--     ...
-- } ,
-- WhiteList =    -- 白名单模式 , 设备可以且只可以被这些插件塔影响 , 且最多不超过这么多插件塔
-- {
--     ["插件塔原型的 name 值"] = 最大数量 ,
--     ...
-- } ,
--
-- -- 插件条件列表
-- MinModuleCount = 最小插件数量 ,    -- 默认 -1 , 也就是没有最小值
-- MaxModuleCount = 最大插件数量 ,    -- 默认 256
-- NeedModuleList =    -- 必须的插件 , 设备或插件塔必须持有这些种类这么多数量的插件才能工作
-- {
--     ["插件原型的 name 值"] = 必要数量 ,
--     ...
-- }
-- SupportModuleList =    -- 支持的插件 , 设备或插件塔只能使用这些种类 , 这么多数量的插件
-- {
--     ["插件原型的 name 值"] = 最大数量 ,
--     ...
-- }
-- ----------------------------------------
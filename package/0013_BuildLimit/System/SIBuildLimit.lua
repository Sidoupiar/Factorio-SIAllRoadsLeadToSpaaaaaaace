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
			Modules = {}
		} ,
		DefaultPlayer =
		{
			CurrentEntity = nil
		}
	} ,
	-- ------------------------------------------------------------------------------------------------
	-- ----------- 初始化 -----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	InitData = function()
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 功能函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	EffectMachine = function( globalSettings , machine , removedBeacon )
		local name = machine.name
		local removedBeaconNumber = removedBeacon and removedBeacon.unit_number or nil
		for index , beacon in pairs( machine.get_beacons() or {} ) do
			if beacon.unit_number ~= removedBeaconNumber then
				local limitDataIDList = globalSettings.Beacons[beacon.name]
				if limitDataIDList then
					for limitDataIDIndex , limitDataID in pairs( limitDataIDList ) do
						local limitData = globalSettings.LimitData[limitDataID]
						if not limitData.WhiteList[name] then
							machine.active = false
							return
						end
					end
				end
			end
		end
		local limitDataIDList = globalSettings.Machines[name]
		if limitDataIDList then
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
			-- 遍历建造限制数据包
			for limitDataIDIndex , limitDataID in pairs( limitDataIDList ) do
				local limitData = globalSettings.LimitData[limitDataID]
				if beaconCount < limitData.MinBeaconCount then
					machine.active = false
					return
				end
				if beaconCount > limitData.MaxBeaconCount then
					machine.active = false
					return
				end
				if limitData.RequireList then
					for beaconName , requireCount in pairs( limitData.RequireList ) do
						local count = beaconCountList[beaconName] or 0
						if count < requireCount then
							machine.active = false
							return
						end
					end
				end
				local whiteList = limitData.WhiteList
				if whiteList then
					for beaconName , count in pairs( beaconCountList ) do
						if not whiteList[beaconName] then
							machine.active = false
							return
						end
						if count > whiteList[beaconName] then
							machine.active = false
							return
						end
					end
				end
			end
		end
		machine.active = true
	end ,
	EffectModule = function( globalSettings , entity )
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
						return
					end
					if moduleCount > limitData.MaxModuleCount then
						entity.item_requests = {}
						return
					end
					if limitData.NeedModuleList then
						for moduleName , needCount in pairs( limitData.NeedModuleList ) do
							local count = moduleCountList[moduleName] or 0
							if count < needCount then
								entity.item_requests = {}
								return
							end
						end
					end
					local supportModuleList = limitData.SupportModuleList
					if supportModuleList then
						for moduleName , count in pairs( moduleCountList ) do
							if not supportModuleList[moduleName] then
								entity.item_requests = {}
								return
							end
							if count > supportModuleList[moduleName] then
								entity.item_requests = {}
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
					local unit_number = targetEntity.unit_number
					-- 统计设备插件情况
					local moduleCount = 0
					local moduleCountList = {}
					local newProxyList = {}
					for index , proxy in pairs( proxyList ) do
						if proxy.proxy_target.unit_number == unit_number then
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
							return
						end
						if moduleCount > limitData.MaxModuleCount then
							for index , proxy in pairs( newProxyList ) do
								proxy.item_requests = {}
							end
							return
						end
						if limitData.NeedModuleList then
							for moduleName , needCount in pairs( limitData.NeedModuleList ) do
								local count = moduleCountList[moduleName] or 0
								if count < needCount then
									for index , proxy in pairs( newProxyList ) do
										proxy.item_requests = {}
									end
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
									return
								end
								if count > supportModuleList[moduleName] then
									for index , proxy in pairs( newProxyList ) do
										proxy.item_requests = {}
									end
									return
								end
							end
						end
					end
				end
			end
		else
			local limitDataIDList = globalSettings.Modules[entity.name]
			if limitDataIDList then
				-- 统计设备插件情况
				local moduleCount = 0
				local moduleCountList = {}
				local moduleInventory = entity.get_module_inventory()
				if moduleInventory then
					for itemName , count in pairs( moduleInventory.get_contents() ) do
						moduleCount = moduleCount + count
						moduleCountList[itemName] = count
					end
				end
				-- 遍历建造限制数据包
				for limitDataIDIndex , limitDataID in pairs( limitDataIDList ) do
					local limitData = globalSettings.LimitData[limitDataID]
					if moduleCount < limitData.MinModuleCount then
						entity.active = false
						return
					end
					if moduleCount > limitData.MaxModuleCount then
						entity.active = false
						return
					end
					if limitData.NeedModuleList then
						for moduleName , needCount in pairs( limitData.NeedModuleList ) do
							local count = moduleCountList[moduleName] or 0
							if count < needCount then
								entity.active = false
								return
							end
						end
					end
					local supportModuleList = limitData.SupportModuleList
					if supportModuleList then
						for moduleName , count in pairs( moduleCountList ) do
							if not supportModuleList[moduleName] then
								entity.active = false
								return
							end
							if count > supportModuleList[moduleName] then
								entity.active = false
								return
							end
						end
					end
				end
				-- 额外检测物品请求实体
				local position = entity.position
				local selectionBox = entity.prototype.selection_box
				local proxyList = entity.surface.find_entities_filtered
				{
					type = SICommon.Types.Entities.ProxyItemRequest ,
					area = { { selectionBox.left_top.x + position.x , selectionBox.left_top.y + position.y } , { selectionBox.right_bottom.x + position.x , selectionBox.right_bottom.y + position.y } }
				}
				if #proxyList > 0 then
					local unit_number = entity.unit_number
					moduleCount = 0
					moduleCountList = {}
					local newProxyList = {}
					for index , proxy in pairs( proxyList ) do
						if proxy.proxy_target.unit_number == unit_number then
							for itemName , count in pairs( proxy.item_requests or {} ) do
								moduleCount = moduleCount + count
								moduleCountList[itemName] = ( moduleCountList[itemName] or 0 ) + count
								table.insert( newProxyList , proxy )
							end
						end
					end
					-- 额外遍历建造限制数据包来检测物品请求实体
					for limitDataIDIndex , limitDataID in pairs( limitDataIDList ) do
						local limitData = globalSettings.LimitData[limitDataID]
						if moduleCount < limitData.MinModuleCount then
							for index , proxy in pairs( newProxyList ) do
								proxy.item_requests = {}
							end
							break
						end
						if moduleCount > limitData.MaxModuleCount then
							for index , proxy in pairs( newProxyList ) do
								proxy.item_requests = {}
							end
							break
						end
						if limitData.NeedModuleList then
							for moduleName , needCount in pairs( limitData.NeedModuleList ) do
								local count = moduleCountList[moduleName] or 0
								if count < needCount then
									for index , proxy in pairs( newProxyList ) do
										proxy.item_requests = {}
									end
									break
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
									break
								end
								if count > supportModuleList[moduleName] then
									for index , proxy in pairs( newProxyList ) do
										proxy.item_requests = {}
									end
									break
								end
							end
						end
					end
				end
			end
			entity.active = true
		end
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 事件函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	BuildEntity = function( entity )
		local type = entity.type
		if type == SICommon.Types.Entities.Smoke or type == SICommon.Types.Entities.Corpse then
			return
		end
		local globalSettings = SIGlobal.GetGlobalSettings( SIBuildLimit.Settings.Name )
		if type == SICommon.Types.Entities.Beacon then
			for index , machine in pairs( entity.get_beacon_effect_receivers() ) do
				SIBuildLimit.EffectMachine( globalSettings , machine , nil )
			end
		else
			SIBuildLimit.EffectMachine( globalSettings , entity , nil )
		end
		SIBuildLimit.EffectModule( globalSettings , entity )
	end ,
	DestroyEntity = function( entity )
		local type = entity.type
		if type == SICommon.Types.Entities.GhostEntity or type == SICommon.Types.Entities.Smoke or type == SICommon.Types.Entities.Corpse then
			return
		end
		local globalSettings = SIGlobal.GetGlobalSettings( SIBuildLimit.Settings.Name )
		if type == SICommon.Types.Entities.Beacon then
			for index , machine in pairs( entity.get_beacon_effect_receivers() ) do
				SIBuildLimit.EffectMachine( globalSettings , machine , entity )
			end
		end
	end ,
	CheckModule = function( entity )
		local globalSettings = SIGlobal.GetGlobalSettings( SIBuildLimit.Settings.Name )
		SIBuildLimit.EffectModule( globalSettings , entity )
	end ,
	PlayerOpenEntity = function( playerIndex , entity )
		local settings = SIGlobal.GetPlayerSettings( SIBuildLimit.Settings.Name , playerIndex )
		settings.CurrentEntity = entity
	end ,
	PlayerCloseEntity = function( playerIndex , entity )
		local settings = SIGlobal.GetPlayerSettings( SIBuildLimit.Settings.Name , playerIndex )
		settings.CurrentEntity = nil
		local globalSettings = SIGlobal.GetGlobalSettings( SIBuildLimit.Settings.Name )
		SIBuildLimit.EffectModule( globalSettings , entity )
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
-- Beacon         = "插件塔原型的 name 值" ,   -- 要求填写一个插件塔 , 此类型下只有 [ 插件塔条件列表下的白名单 ] 和 [ 插件条件列表的各项生效 ] , 且白名单其中的数量设置会被忽视 , 不在白名单内的设备均会被代码禁用
--
-- -- 插件塔条件列表
-- MinBeaconCount = 最小插件塔数量 ,    -- 默认 -1 , 也就是没有最小值
-- MaxBeaconCount = 最大插件塔数量 ,    -- 默认 256
-- RequireList =    -- 设备必须被这么多种类和数量的插件塔影响 , 它才会工作 , 否则会被代码禁用
-- {
--     ["插件塔原型的 name 值"] = 必要数量 ,
--     ...
-- } ,
-- WhiteList =    -- 白名单模式 , 设备可以且只可以被这些插件塔影响 , 且最多不超过这么多插件塔 , 如果是用于插件塔 , 最大数量请填写 1
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
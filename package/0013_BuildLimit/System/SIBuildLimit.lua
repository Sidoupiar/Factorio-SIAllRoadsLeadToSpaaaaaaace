SIBuildLimit =
{
	ID = "SIBuildLimit" ,
	Name = "建造限制" ,
	InterfaceID = "SIBuildLimit" ,
	Settings =
	{
		Name = "SIBuildLimit" ,
		Default =
		{
			LimitData = {} ,
			Machines = {} ,
			Beacons = {}
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
	EffectMachine = function( globalSettings , machine )
		local name = machine.name
		for index , beacon in pairs( machine.get_beacons() or {} ) do
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
		local limitDataIDList = globalSettings.Machines[name]
		if limitDataIDList then
			for limitDataIDIndex , limitDataID in pairs( limitDataIDList ) do
				local limitData = globalSettings.LimitData[limitDataID]
				local beaconCount = machine.beacons_count
				if beaconCount < limitData.MinBeaconCount then
					machine.active = false
					return
				end
				if beaconCount > limitData.MaxBeaconCount then
					machine.active = false
					return
				end
				local beaconCountList = {}
				for index , beacon in pairs( machine.get_beacons() or {} ) do
					local beaconName = beacon.name
					beaconCountList[beaconName] = ( beaconCountList[beaconName] or 0 ) + 1
				end
				for beaconName , count in pairs( limitData.Require ) do
					if beaconCountList[beaconName] < count then
						machine.active = false
						return
					end
				end
				local whiteList = limitData.WhiteList
				for beaconName , count in pairs( beaconCountList ) do
					if not whiteList[beaconName] then
						machine.active = false
						return
					end
					if whiteList[beaconName] < count then
						machine.active = false
						return
					end
				end
			end
		end
		machine.active = true
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 事件函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	BuildEntity = function( entity )
		local type = entity.type
		if type == SICommon.Types.Entities.GhostEntity or type == SICommon.Types.Entities.Smoke or type == SICommon.Types.Entities.Corpse then
			return
		end
		local globalSettings = SIGlobal.GetGlobalSettings( SIBuildLimit.Settings.Name )
		if type == SICommon.Types.Entities.Beacons then
			for index , machine in pairs( entity.get_beacon_effect_receivers() ) do
				SIBuildLimit.EffectMachine( globalSettings , machine )
			end
		else
			SIBuildLimit.EffectMachine( globalSettings , entity )
		end
	end ,
	DestroyEntity = function( entity )
		local type = entity.type
		if type == SICommon.Types.Entities.GhostEntity or type == SICommon.Types.Entities.Smoke or type == SICommon.Types.Entities.Corpse then
			return
		end
		local globalSettings = SIGlobal.GetGlobalSettings( SIBuildLimit.Settings.Name )
		if type == SICommon.Types.Entities.Beacons then
			for index , machine in pairs( entity.get_beacon_effect_receivers() ) do
				SIBuildLimit.EffectMachine( globalSettings , machine )
			end
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
		limitData.Require = limitData.Require or {}
		limitData.WhiteList = limitData.WhiteList or {}
		globalSettings.LimitData[limitDataID] = limitData
		if limitData.Machine then
			local limitDataIDList = globalSettings.Machines[limitData.Machine]
			if not limitDataIDList then
				limitDataIDList = {}
				globalSettings.Machines[limitData.Machine] = limitDataIDList
			end
			table.insert( limitDataIDList , limitDataID )
		elseif limitData.Beacon then
			local limitDataIDList = globalSettings.Beacons[limitData.Beacon]
			if not limitDataIDList then
				limitDataIDList = {}
				globalSettings.Beacons[limitData.Beacon] = limitDataIDList
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
				limitData.Require = limitData.Require or {}
				limitData.WhiteList = limitData.WhiteList or {}
				globalSettings.LimitData[limitDataID] = limitData
				if limitData.Machine then
					local limitDataIDList = globalSettings.Machines[limitData.Machine]
					if not limitDataIDList then
						limitDataIDList = {}
						globalSettings.Machines[limitData.Machine] = limitDataIDList
					end
					table.insert( limitDataIDList , limitDataID )
				elseif limitData.Beacon then
					local limitDataIDList = globalSettings.Beacons[limitData.Beacon]
					if not limitDataIDList then
						limitDataIDList = {}
						globalSettings.Beacons[limitData.Beacon] = limitDataIDList
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
		elseif oldLimitData.Beacon then
			SITable.Remove( globalSettings.Beacons[oldLimitData.Beacon] , limitDataID )
		end
		limitData.MinBeaconCount = limitData.MinBeaconCount or -1
		limitData.MaxBeaconCount = limitData.MaxBeaconCount or 256
		limitData.Require = limitData.Require or {}
		limitData.WhiteList = limitData.WhiteList or {}
		globalSettings.LimitData[limitDataID] = limitData
		if limitData.Machine then
			local limitDataIDList = globalSettings.Machines[limitData.Machine]
			if not limitDataIDList then
				limitDataIDList = {}
				globalSettings.Machines[limitData.Machine] = limitDataIDList
			end
			table.insert( limitDataIDList , limitDataID )
		elseif limitData.Beacon then
			local limitDataIDList = globalSettings.Beacons[limitData.Beacon]
			if not limitDataIDList then
				limitDataIDList = {}
				globalSettings.Beacons[limitData.Beacon] = limitDataIDList
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
				elseif oldLimitData.Beacon then
					SITable.Remove( globalSettings.Beacons[oldLimitData.Beacon] , limitDataID )
				end
				limitData.MinBeaconCount = limitData.MinBeaconCount or -1
				limitData.MaxBeaconCount = limitData.MaxBeaconCount or 256
				limitData.Require = limitData.Require or {}
				limitData.WhiteList = limitData.WhiteList or {}
				globalSettings.LimitData[limitDataID] = limitData
				if limitData.Machine then
					local limitDataIDList = globalSettings.Machines[limitData.Machine]
					if not limitDataIDList then
						limitDataIDList = {}
						globalSettings.Machines[limitData.Machine] = limitDataIDList
					end
					table.insert( limitDataIDList , limitDataID )
				elseif limitData.Beacon then
					local limitDataIDList = globalSettings.Beacons[limitData.Beacon]
					if not limitDataIDList then
						limitDataIDList = {}
						globalSettings.Beacons[limitData.Beacon] = limitDataIDList
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
-- Beacon         = "插件塔原型的 name 值" ,   -- 要求填写一个插件塔 , 此类型下只有白名单生效 , 且其中的数量设置会被忽视 , 不在白名单内的设备均会被代码禁用
--
-- -- 条件列表
-- MinBeaconCount = 最小插件塔数量 ,    -- 默认 -1 , 也就是没有最小值
-- MaxBeaconCount = 最大插件塔数量 ,    -- 默认 256
-- Require =    -- 设备必须被这么多种类和数量的插件塔影响 , 它才会工作 , 否则会被代码禁用
-- {
--     ["插件塔原型的 name 值"] = 数量 ,
--     ...
-- } ,
-- WhiteList =    -- 白名单模式 , 设备可以且只可以被这些插件塔影响 , 且最多不超过这么多插件塔 , 如果是用作插件塔 , 最大数量请填写 1
-- {
--     ["插件塔原型的 name 值"] = 最大数量 ,
--     ...
-- }
-- ----------------------------------------
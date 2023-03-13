-- ------------------------------------------------------------------------------------------------
-- ---------- 定义信息 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------------------------
-- ---------- 操作事件 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus
.ConfigurationChange( function( functionID )
	-- 初始化隐藏科技
	for forceName , force in pairs( game.forces ) do
		if force.name == "neutral" or force.name == "enemy" then
			return
		end
		for subName , subTechnology in pairs( force.technologies ) do
			local technologyPrototype = subTechnology.prototype
			if not technologyPrototype.enabled and not SIConfigs.SIOverhaul.HideTechnologyBlackList[subName] then
				local enableFlag = true
				for prerequisiteName , prerequisiteTechnology in pairs( subTechnology.prerequisites ) do
					enableFlag = enableFlag and prerequisiteTechnology.researched
					if not enableFlag then
						break
					end
				end
				if enableFlag then
					subTechnology.enabled = true
					subTechnology.visible_when_disabled = true
				else
					subTechnology.enabled = false
					subTechnology.visible_when_disabled = false
				end
			end
			-- 如果一个科技不可用 , 则取消研究
			local queue = force.research_queue
			for index , queueTechnology in pairs( queue ) do
				if queueTechnology.name == subName then
					table.remove( queue , index )
					force.research_queue = queue
					break
				end
			end
		end
	end
end )
.Add( SIEvents.on_research_finished , function( event , functionID )
	local technology = event.research
	if not technology or not technology.valid then
		return
	end
	local name = technology.name
	local force = technology.force
	-- 显示隐藏的科技
	for subName , subTechnology in pairs( force.technologies ) do
		local technologyPrototype = subTechnology.prototype
		if not subTechnology.enabled and not technologyPrototype.enabled and not SIConfigs.SIOverhaul.HideTechnologyBlackList[subName] then
			local enableFlag = true
			for prerequisiteName , prerequisiteTechnology in pairs( subTechnology.prerequisites ) do
				enableFlag = enableFlag and prerequisiteTechnology.researched
				if not enableFlag then
					break
				end
			end
			if enableFlag then
				-- 科技变为可见
				subTechnology.enabled = true
				subTechnology.visible_when_disabled = true
			end
		end
	end
end )
.Add( SIEvents.on_research_reversed , function( event , functionID )
	local technology = event.research
	if not technology or not technology.valid then
		return
	end
	local name = technology.name
	local force = technology.force
	-- 重新把科技隐藏
	for subName , subTechnology in pairs( force.technologies ) do
		local technologyPrototype = subTechnology.prototype
		if subTechnology.enabled and not technologyPrototype.enabled and not SIConfigs.SIOverhaul.HideTechnologyBlackList[subName] then
			for prerequisiteName , prerequisiteTechnology in pairs( subTechnology.prerequisites ) do
				if not prerequisiteTechnology.researched then
					-- 科技变为隐藏
					subTechnology.enabled = false
					subTechnology.visible_when_disabled = false
					break
				end
			end
		end
	end
end )
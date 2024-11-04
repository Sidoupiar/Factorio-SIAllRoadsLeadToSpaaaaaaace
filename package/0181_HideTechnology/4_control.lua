-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 定义信息 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 基础数据 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================
-- 初始化
-- ======================================================================
local hideTechnologySelf = SIConfigs.SIHideTechnology.HideTechnologySelf ~= nil and SISettings.Startup.SIHideTechnology.HideTechnologySelf() or false

-- ======================================================================
-- 事件
-- ======================================================================

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 操作事件 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================
-- 事件
-- ======================================================================
SIEventBus
.ConfigurationChange( function( functionID )
	-- 初始化隐藏科技
	if hideTechnologySelf then
		local orderPrefix = SIOrderPrefix()
		for forceName , force in pairs( game.forces ) do
			if force.name == "neutral" or force.name == "enemy" then
				return
			end
			for subName , subTechnology in pairs( force.technologies ) do
				local technologyPrototype = subTechnology.prototype
				if not technologyPrototype.enabled and technologyPrototype.order:StartsWith( orderPrefix ) then
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
	else
		for forceName , force in pairs( game.forces ) do
			if force.name == "neutral" or force.name == "enemy" then
				return
			end
			for subName , subTechnology in pairs( force.technologies ) do
				local technologyPrototype = subTechnology.prototype
				if not technologyPrototype.enabled then
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
	if hideTechnologySelf then
		local orderPrefix = SIOrderPrefix()
		for subName , subTechnology in pairs( force.technologies ) do
			local technologyPrototype = subTechnology.prototype
			if not subTechnology.enabled and not technologyPrototype.enabled and technologyPrototype.order:StartsWith( orderPrefix ) then
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
	else
		for subName , subTechnology in pairs( force.technologies ) do
			local technologyPrototype = subTechnology.prototype
			if not subTechnology.enabled and not technologyPrototype.enabled then
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
	if hideTechnologySelf then
		local orderPrefix = SIOrderPrefix()
		for subName , subTechnology in pairs( force.technologies ) do
			local technologyPrototype = subTechnology.prototype
			if subTechnology.enabled and not technologyPrototype.enabled and technologyPrototype.order:StartsWith( orderPrefix ) then
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
	else
		for subName , subTechnology in pairs( force.technologies ) do
			local technologyPrototype = subTechnology.prototype
			if subTechnology.enabled and not technologyPrototype.enabled then
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
	end
end )

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 外部接口 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================
-- 接口注册
-- ======================================================================
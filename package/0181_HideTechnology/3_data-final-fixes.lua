-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 隐藏科技 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

local hideTechnologySelf = SIConfigs.SIHideTechnology.HideTechnologySelf ~= nil and SISettings.Startup.SIHideTechnology.HideTechnologySelf() or false
if hideTechnologySelf then
	SIGen.ForEachInner( SICommon.Types.Technology , function( prototypeName , prototypeData )
		if prototypeData then
			if SIConfigs.SIHideTechnology.HideTechnologyBlackList and SIConfigs.SIHideTechnology.HideTechnologyBlackList[prototypeName] then
				return
			end
			if not prototypeData.SIGenData then
				return
			end
			if not prototypeData.prerequisites or #prototypeData.prerequisites < 1 then
				return
			end
			prototypeData.enabled = false
			prototypeData.visible_when_disabled = false
		end
	end )
else
	SIGen.ForEach( SICommon.Types.Technology , function( prototypeName , prototypeData )
		if prototypeData then
			if SIConfigs.SIHideTechnology.HideTechnologyBlackList and SIConfigs.SIHideTechnology.HideTechnologyBlackList[prototypeName] then
				return
			end
			if not prototypeData.prerequisites or #prototypeData.prerequisites < 1 then
				return
			end
			prototypeData.enabled = false
			prototypeData.visible_when_disabled = false
		end
	end )
end
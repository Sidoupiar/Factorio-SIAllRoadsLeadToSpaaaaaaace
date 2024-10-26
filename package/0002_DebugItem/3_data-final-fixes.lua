-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 添加特殊模块类型 ================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- 给所有模块区域添加支持的模块类型
SIGen.ForEach( SICommon.Types.EquipmentGrid , function( prototypeName , prototypeData )
	if prototypeData then
		local equipmentCategories = prototypeData.equipment_categories
		if equipmentCategories then
			if not SITable.Has( equipmentCategories , SIConstants_DebugItem.raw.Categories.Equipment.DebugItem ) then
				table.insert( equipmentCategories , SIConstants_DebugItem.raw.Categories.Equipment.DebugItem )
			end
		else
			prototypeData.equipment_categories = { SIConstants_DebugItem.raw.Categories.Equipment.DebugItem }
		end
	end
end )
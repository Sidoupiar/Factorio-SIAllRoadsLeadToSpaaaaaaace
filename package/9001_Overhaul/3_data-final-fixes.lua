-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 修改部分实体的属性 ==============================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

local function AppendFlag( prototypeData , newFlag )
	local flags = prototypeData.flags
	if flags then
		if not SITable.Has( flags , newFlag ) then
			table.insert( flags , newFlag )
		end
	else
		prototypeData.flags = { newFlag }
	end
end

SIGen
-- 修改水蒸气的最高温度
-- 此项不可以禁用或删除
.Find( SICommon.Types.Fluid , "steam" , function( prototypeName , prototypeData )
	if prototypeData then
		prototypeData.max_temperature = 5000
	end
end )

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 调整物品的堆叠 ==================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

if SIConfigs.SIOverhaul.ItemStackSizeModify and SIConfigs.SIOverhaul.ItemStackSizeModify.Enable then
	local config = SIConfigs.SIOverhaul.ItemStackSizeModify
	-- ======================================================================
	-- 倍率修改堆叠
	-- ======================================================================
	if config.EnableItemStackSizeMultiplier and config.ItemStackSizeMultiplier then
		local min = config.ItemStackSizeMultiplier.Min == 0 and SICommon.Numbers.StackSizeMin or SITools.AsNumberInt( config.ItemStackSizeMultiplier.Min , SICommon.Numbers.StackSizeMin , SICommon.Numbers.StackSizeMax )
		local max = config.ItemStackSizeMultiplier.Max == 0 and SICommon.Numbers.StackSizeMax or SITools.AsNumberInt( config.ItemStackSizeMultiplier.Max , SICommon.Numbers.StackSizeMin , SICommon.Numbers.StackSizeMax )
		min = math.min( min , max )
		local multiplier = config.ItemStackSizeMultiplier.Multiplier == 0 and 1 or SITools.AsNumber( config.ItemStackSizeMultiplier.Multiplier , SICommon.Numbers.MultiplierMin , SICommon.Numbers.MultiplierMax )
		if config.ItemStackSizeMultiplier.TypeList then
			for itemType , itemTypeMultiplier in pairs( config.ItemStackSizeMultiplier.TypeList ) do
				local itemStackSizeMultiplier = SITools.AsNumber( itemTypeMultiplier , SICommon.Numbers.MultiplierMin , SICommon.Numbers.MultiplierMax )
				if itemStackSizeMultiplier == 0 then
					itemStackSizeMultiplier = multiplier
				end
				if itemStackSizeMultiplier > 0 and itemStackSizeMultiplier ~= 1 then
					SIGen.ForEach( itemType , function( prototypeName , prototypeData )
						if prototypeData then
							local itemStackSize = SITools.Round( math.floor( ( prototypeData.stack_size or 1 ) * itemStackSizeMultiplier ) , min , max )
							if config.IgnoreCannotStack then
								if itemStackSize == 1 or not prototypeData.flags or not SITable.Has( prototypeData.flags , SICommon.Flags.Item.NotStackable ) then
									prototypeData.stack_size = itemStackSize
									if prototypeData.default_request_amount then
										prototypeData.default_request_amount = math.min( prototypeData.default_request_amount , itemStackSize )
									end
								end
							else
								if itemStackSize > 1 and prototypeData.flags then
									while SITable.Has( prototypeData.flags , SICommon.Flags.Item.NotStackable ) do
										SITable.Remove( prototypeData.flags , SICommon.Flags.Item.NotStackable )
									end
								end
								prototypeData.stack_size = itemStackSize
								if prototypeData.default_request_amount then
									prototypeData.default_request_amount = math.min( prototypeData.default_request_amount , itemStackSize )
								end
							end
						end
					end )
				end
			end
		end
	end
	-- ======================================================================
	-- 加法修改堆叠
	-- ======================================================================
	if config.EnableItemStackSizeAddition and config.ItemStackSizeAddition then
		local min = config.ItemStackSizeAddition.Min == 0 and SICommon.Numbers.StackSizeMin or SITools.AsNumberInt( config.ItemStackSizeAddition.Min , SICommon.Numbers.StackSizeMin , SICommon.Numbers.StackSizeMax )
		local max = config.ItemStackSizeAddition.Max == 0 and SICommon.Numbers.StackSizeMax or SITools.AsNumberInt( config.ItemStackSizeAddition.Max , SICommon.Numbers.StackSizeMin , SICommon.Numbers.StackSizeMax )
		min = math.min( min , max )
		local addition = SITools.AsNumberInt( config.ItemStackSizeAddition.Addition , SICommon.Numbers.StackSizeAdditionMin , SICommon.Numbers.StackSizeAdditionMax )
		if config.ItemStackSizeAddition.TypeList then
			for itemType , itemTypeAddition in pairs( config.ItemStackSizeAddition.TypeList ) do
				local itemStackSizeAddition = SITools.AsNumberInt( itemTypeAddition , SICommon.Numbers.StackSizeAdditionMin , SICommon.Numbers.StackSizeAdditionMax )
				if itemStackSizeAddition == 0 then
					itemStackSizeAddition = addition
				end
				if itemStackSizeAddition ~= 0 then
					SIGen.ForEach( itemType , function( prototypeName , prototypeData )
						if prototypeData then
							local itemStackSize = SITools.Round( math.floor( ( prototypeData.stack_size or 1 ) + itemStackSizeAddition ) , min , max )
							if config.IgnoreCannotStack then
								if itemStackSize == 1 or not prototypeData.flags or not SITable.Has( prototypeData.flags , SICommon.Flags.Item.NotStackable ) then
									prototypeData.stack_size = itemStackSize
									if prototypeData.default_request_amount then
										prototypeData.default_request_amount = math.min( prototypeData.default_request_amount , itemStackSize )
									end
								end
							else
								if itemStackSize > 1 and prototypeData.flags then
									while SITable.Has( prototypeData.flags , SICommon.Flags.Item.NotStackable ) do
										SITable.Remove( prototypeData.flags , SICommon.Flags.Item.NotStackable )
									end
								end
								prototypeData.stack_size = itemStackSize
								if prototypeData.default_request_amount then
									prototypeData.default_request_amount = math.min( prototypeData.default_request_amount , itemStackSize )
								end
							end
						end
					end )
				end
			end
		end
	end
	-- ======================================================================
	-- 单独修改堆叠
	-- ======================================================================
	if config.EnableItemStackSizeList and config.ItemStackSizeList then
		for itemType , itemList in pairs( config.ItemStackSizeList ) do
			if itemList then
				for itemName , stackSize in pairs( itemList ) do
					SIGen.Find( itemType , itemName , function( prototypeName , prototypeData )
						if prototypeData then
							local itemStackSize = SITools.AsNumberInt( math.floor( stackSize ) , SICommon.Numbers.StackSizeMin , SICommon.Numbers.StackSizeMax )
							if config.IgnoreCannotStack then
								if itemStackSize == 1 or not prototypeData.flags or not SITable.Has( prototypeData.flags , SICommon.Flags.Item.NotStackable ) then
									prototypeData.stack_size = itemStackSize
									if prototypeData.default_request_amount then
										prototypeData.default_request_amount = math.min( prototypeData.default_request_amount , itemStackSize )
									end
								end
							else
								if itemStackSize > 1 and prototypeData.flags then
									while SITable.Has( prototypeData.flags , SICommon.Flags.Item.NotStackable ) do
										SITable.Remove( prototypeData.flags , SICommon.Flags.Item.NotStackable )
									end
								end
								prototypeData.stack_size = itemStackSize
								if prototypeData.default_request_amount then
									prototypeData.default_request_amount = math.min( prototypeData.default_request_amount , itemStackSize )
								end
							end
						elseif config.ErrorWhenItemNotExist then
							E( "不存在的物品 : " .. itemName )
						end
					end )
				end
			end
		end
	end
end

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 修改原版 UI 样式 ================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

local function SetStyleProperty( style , propertyID , value )
	if style and style[propertyID] then
		style[propertyID] = value
	end
end

SIGen
-- 此项不可以禁用或删除
.Find( SICommon.Types.Style , "default" , function( prototypeName , prototypeData )
	if prototypeData then
		-- 修改弹出说明的窗口的最大宽度
		SetStyleProperty( prototypeData.tooltip_title_label , "maximal_width" , 406 )
		SetStyleProperty( prototypeData.tooltip_label , "maximal_width" , 406 )
		-- 修改插件槽列表的最大高度
		SetStyleProperty( prototypeData.module_inventory_scroll_pane , "maximal_height" , 350 )
		-- 修改装甲模块区域的最大宽度
		SetStyleProperty( prototypeData.horizontally_limited_equipment_grid_scroll_pane , "maximal_width" , 812 )
	end
end )

-- 此项不可以禁用或删除
.Find( SICommon.Types.Constants , "default" , function( prototypeName , prototypeData )
	if prototypeData then
		-- 修改配方栏的宽度以及每行的配方数量 (包括筛选器)
		local filterLine = SISettings.Startup.SIOverhaul.ChangeFilterLine() or 20
		prototypeData.select_group_row_count = math.floor( filterLine * 0.6 + 0.001 )
		prototypeData.select_slot_row_count = filterLine
		-- 修改背包每行的格子数量
		prototypeData.inventory_width = SISettings.Startup.SIOverhaul.ChangeInventoryLine() or 15
		-- 修改插件槽每行的格子数量
		prototypeData.module_inventory_width = SISettings.Startup.SIOverhaul.ChangeModuleLine() or 15
	end
end )

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 隐藏科技 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

if SIConfigs.SIOverhaul.HideTechnology then
	SIGen.ForEachInner( SICommon.Types.Technology , function( prototypeName , prototypeData )
		if prototypeData then
			if SIConfigs.SIOverhaul.HideTechnologyBlackList[prototypeName] then
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
end
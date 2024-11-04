-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 修改物品堆叠 ====================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

local config = SIConfigs.SIItemStackSizeModify
local ignoreCannotStack = config.IgnoreCannotStack ~= nil and SISettings.Startup.SIItemStackSizeModify.IgnoreCannotStack() or false

-- ======================================================================
-- 倍率修改堆叠
-- ======================================================================
if config.ItemStackSizeMultiplier and config.ItemStackSizeMultiplier.TypeList then
	local min = config.ItemStackSizeMultiplier.Min == 0 and SICommon.Numbers.StackSizeMin or SITools.AsNumberInt( config.ItemStackSizeMultiplier.Min , SICommon.Numbers.StackSizeMin , SICommon.Numbers.StackSizeMax )
	local max = config.ItemStackSizeMultiplier.Max == 0 and SICommon.Numbers.StackSizeMax or SITools.AsNumberInt( config.ItemStackSizeMultiplier.Max , SICommon.Numbers.StackSizeMin , SICommon.Numbers.StackSizeMax )
	min = math.min( min , max )
	for itemType , defaultMultiplier in pairs( config.ItemStackSizeMultiplier.TypeList ) do
		if defaultMultiplier ~= nil then
			local itemStackSizeMultiplier = SISettings.Startup.SIItemStackSizeModify["ItemStackSizeMultiplier-" .. SICommon.Types.StackableItems_Reverse[itemType]]()
			itemStackSizeMultiplier = SITools.AsNumber( itemStackSizeMultiplier , SICommon.Numbers.MultiplierMin , SICommon.Numbers.MultiplierMax )
			if itemStackSizeMultiplier == 0.0 then
				itemStackSizeMultiplier = defaultMultiplier
			end
			if itemStackSizeMultiplier > 0.0 and itemStackSizeMultiplier ~= 1.0 then
				SIGen.ForEach( itemType , function( prototypeName , prototypeData )
					if prototypeData then
						local itemStackSize = SITools.Round( math.floor( ( prototypeData.stack_size or 1 ) * itemStackSizeMultiplier ) , min , max )
						if ignoreCannotStack then
							if itemStackSize > 1 and prototypeData.flags then
								while SITable.Has( prototypeData.flags , SICommon.Flags.Item.NotStackable ) do
									SITable.Remove( prototypeData.flags , SICommon.Flags.Item.NotStackable )
								end
							end
							prototypeData.stack_size = itemStackSize
							if prototypeData.default_request_amount then
								prototypeData.default_request_amount = math.min( prototypeData.default_request_amount , itemStackSize )
							end
						else
							if itemStackSize == 1 or not prototypeData.flags or not SITable.Has( prototypeData.flags , SICommon.Flags.Item.NotStackable ) then
								prototypeData.stack_size = itemStackSize
								if prototypeData.default_request_amount then
									prototypeData.default_request_amount = math.min( prototypeData.default_request_amount , itemStackSize )
								end
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
if config.EnableItemStackSizeList then
	for itemType , itemList in pairs( config.ItemStackSizeList ) do
		if itemList then
			for itemName , stackSize in pairs( itemList ) do
				SIGen.Find( itemType , itemName , function( prototypeName , prototypeData )
					if prototypeData then
						local itemStackSize = SITools.AsNumberInt( math.floor( stackSize ) , SICommon.Numbers.StackSizeMin , SICommon.Numbers.StackSizeMax )
						if ignoreCannotStack then
							if itemStackSize > 1 and prototypeData.flags then
								while SITable.Has( prototypeData.flags , SICommon.Flags.Item.NotStackable ) do
									SITable.Remove( prototypeData.flags , SICommon.Flags.Item.NotStackable )
								end
							end
							prototypeData.stack_size = itemStackSize
							if prototypeData.default_request_amount then
								prototypeData.default_request_amount = math.min( prototypeData.default_request_amount , itemStackSize )
							end
						else
							if itemStackSize == 1 or not prototypeData.flags or not SITable.Has( prototypeData.flags , SICommon.Flags.Item.NotStackable ) then
								prototypeData.stack_size = itemStackSize
								if prototypeData.default_request_amount then
									prototypeData.default_request_amount = math.min( prototypeData.default_request_amount , itemStackSize )
								end
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
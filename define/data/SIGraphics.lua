-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 基础数据 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIGraphics =
{
	-- 固定属性
	ID = "SIGraphics" ,
	Code = "SIGraphics" ,
	Show = "图形管理"
}

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 物品图标 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================<br>
---@return table
function SIGraphics.ItemIcon_SI()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic/item/图标-SI.png" ,
		icon_size = 64 ,
		icon_mipmaps = 4 ,
		shift = { 0 , 0 }
	}
end

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 科技图标 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================<br>
---@return table
function SIGraphics.TechnologyIcon_Add()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic/technology/图标-新增.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

-- ======================================================================<br>
---@return table
function SIGraphics.TechnologyIcon_Health()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic/technology/图标-生命.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

-- ======================================================================<br>
---@return table
function SIGraphics.TechnologyIcon_Damage()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic/technology/图标-伤害.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

-- ======================================================================<br>
---@return table
function SIGraphics.TechnologyIcon_Range()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic/technology/图标-射程.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

-- ======================================================================<br>
---@return table
function SIGraphics.TechnologyIcon_Move()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic/technology/图标-移动.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

-- ======================================================================<br>
---@return table
function SIGraphics.TechnologyIcon_Speed()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic/technology/图标-速度.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

-- ======================================================================<br>
---@return table
function SIGraphics.TechnologyIcon_Time()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic/technology/图标-时间.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

-- ======================================================================<br>
---@return table
function SIGraphics.TechnologyIcon_Productivity()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic/technology/图标-产能.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

-- ======================================================================<br>
---@return table
function SIGraphics.TechnologyIcon_Mining()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic/technology/图标-开采.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

-- ======================================================================<br>
---@return table
function SIGraphics.TechnologyIcon_Logistic()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic/technology/图标-物流.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

-- ======================================================================<br>
---@return table
function SIGraphics.TechnologyIcon_Ghost()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic/technology/图标-虚像.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

-- ======================================================================<br>
---@return table
function SIGraphics.TechnologyIcon_Count()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic/technology/图标-数量.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

-- ======================================================================<br>
---@return table
function SIGraphics.TechnologyIcon_Stack()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic/technology/图标-堆叠.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

-- ======================================================================<br>
---@return table
function SIGraphics.TechnologyIcon_Battery()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic/technology/图标-电池.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

-- ======================================================================<br>
---@return table
function SIGraphics.TechnologyIcon_Robot()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic/technology/图标-机器人.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

-- ======================================================================<br>
---@return table
function SIGraphics.TechnologyIcon_EquipBlack()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic/technology/图标-黑色模块.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

-- ======================================================================<br>
---@return table
function SIGraphics.TechnologyIcon_EquipWhite()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic/technology/图标-白色模块.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

-- ======================================================================<br>
---@return table
function SIGraphics.TechnologyIcon_BrakingForce()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic/technology/图标-刹车力度.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

-- ======================================================================<br>
---@return table
function SIGraphics.TechnologyIcon_MapZoomIn()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic/technology/图标-地图放大.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

-- ======================================================================<br>
---@return table
function SIGraphics.TechnologyIcon_MapZoomOut()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic//technology/图标-地图缩小.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 残骸图片 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================<br>
---@param count integer
---@param layers table
---@return table
function SIGraphics.MakeRemnantsAnimation( count , layers )
	local animations = {}
	for index = 0 , count - 1 , 1 do
		local animationLayers = {}
		for layerIndex , layer in pairs( layers ) do
			-- 普通贴图
			local frameCount = layer.frame_count or 1
			local lineLength = layer.line_length or frameCount
			if lineLength < 1 then
				lineLength = frameCount
			end
			local newLayer = SIUtils.table.deepcopy( layer )
			newLayer.y = index * layer.height * ( frameCount * ( layer.direction_count or 1 ) + lineLength - 1 ) / lineLength
			-- 高清贴图
			if layer.hr_version then
				local frameCountHr = layer.hr_version.frame_count or 1
				local lineLengthHr = layer.hr_version.line_length or frameCountHr
				if lineLengthHr < 1 then
					lineLengthHr = frameCountHr
				end
				newLayer.hr_version.y = index * layer.hr_version.height * ( frameCountHr * ( layer.hr_version.direction_count or 1 ) + lineLengthHr - 1 ) / lineLengthHr
			end
			-- 添加贴图数据
			table.insert( animationLayers , newLayer )
		end
		table.insert( animations , { layers = animationLayers } )
	end
	return animations
end

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 自动创建高清图片 ================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================<br>
---@param layer table
local function CreateHrVersionData( layer )
	layer.hr_version = nil
	local hrData = SIUtils.table.deepcopy( layer )
	local pos = hrData.filename:FindLast( "/" )
	if pos then
		hrData.filename = hrData.filename:sub( 1 , pos ) .. SICommon.ShowNamePrefix.HrVer .. hrData.filename:sub( pos + 1 )
	else
		hrData.filename = SICommon.ShowNamePrefix.HrVer .. hrData.filename
	end
	if hrData.width then
		hrData.width = hrData.width * 2
	end
	if hrData.height then
		hrData.height = hrData.height * 2
	end
	if hrData.size then
		hrData.size = hrData.size * 2
	end
	hrData.scale = ( hrData.scale or 1.0 ) * 0.5
	layer.hr_version = hrData
end

-- ======================================================================<br>
---@param graphicData any
---@return any
function SIGraphics.MakeHrVersionData( graphicData )
	if not SITools.IsTable( graphicData ) then
		return graphicData
	end
	if graphicData.layers then
		for index , layer in pairs( graphicData.layers ) do
			CreateHrVersionData( layer )
		end
	elseif graphicData.filename then
		CreateHrVersionData( graphicData )
	else
		for keyCode , subData in pairs( graphicData ) do
			SIGraphics.MakeHrVersionData( subData )
		end
	end
	return graphicData
end
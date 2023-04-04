SIGraphics =
{
	-- 固定属性
	ID = "SIGraphics" ,
	Name = "图形管理"
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 科技图标 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIGraphics.TechnologyIcon_Add()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic//technology/图标-新增.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

function SIGraphics.TechnologyIcon_Health()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic//technology/图标-生命.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

function SIGraphics.TechnologyIcon_Damage()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic//technology/图标-伤害.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

function SIGraphics.TechnologyIcon_Range()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic//technology/图标-射程.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

function SIGraphics.TechnologyIcon_Move()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic//technology/图标-移动.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

function SIGraphics.TechnologyIcon_Speed()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic//technology/图标-速度.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

function SIGraphics.TechnologyIcon_Time()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic//technology/图标-时间.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

function SIGraphics.TechnologyIcon_Productivity()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic//technology/图标-产能.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

function SIGraphics.TechnologyIcon_Mining()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic//technology/图标-开采.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

function SIGraphics.TechnologyIcon_Logistic()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic//technology/图标-物流.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

function SIGraphics.TechnologyIcon_Ghost()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic//technology/图标-虚像.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

function SIGraphics.TechnologyIcon_Count()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic//technology/图标-数量.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

function SIGraphics.TechnologyIcon_Stack()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic//technology/图标-堆叠.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

function SIGraphics.TechnologyIcon_Battery()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic//technology/图标-电池.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

function SIGraphics.TechnologyIcon_Robot()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic//technology/图标-机器人.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

function SIGraphics.TechnologyIcon_EquipBlack()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic//technology/图标-黑色模块.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

function SIGraphics.TechnologyIcon_EquipWhite()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic//technology/图标-白色模块.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

function SIGraphics.TechnologyIcon_BrakingForce()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic//technology/图标-刹车力度.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

function SIGraphics.TechnologyIcon_MapZoomIn()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic//technology/图标-地图放大.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

function SIGraphics.TechnologyIcon_MapZoomOut()
	return
	{
		icon = GetCorePath() .. "/define/data/graphic//technology/图标-地图缩小.png" ,
		icon_size = 128 ,
		icon_mipmaps = 3 ,
		shift = { 100 , 100 }
	}
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 残骸图片 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIGraphics.MakeRemnantsAnimation( count , layers )
	local animations = {}
	for index = 0 , count - 1 , 1 do
		local animationLayers = {}
		for layerIndex , layer in pairs( layers ) do
			local frameCount = layer.frame_count or 1
			local lineLength = layer.line_length or frameCount
			if lineLength < 1 then
				lineLength = frameCount
			end
			local newLayer = SIUtils.table.deepcopy( layer )
			newLayer.y = index * layer.height * ( frameCount * layer.direction_count + lineLength - 1 ) / lineLength
			table.insert( animationLayers , newLayer )
		end
		table.insert( animations , { layers = animationLayers } )
	end
	return animations
end
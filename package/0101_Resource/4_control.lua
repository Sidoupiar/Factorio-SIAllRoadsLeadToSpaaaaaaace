-- ------------------------------------------------------------------------------------------------
-- ---------- 定义信息 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIControl.Init
{
	[SICommon.Types.Entities.SimpleEntity] =
	{
		Stone_1 = "矿山磐石-1" ,
		Stone_2 = "矿山磐石-2" ,
		Stone_3 = "矿山磐石-3"
	} ,
	[SICommon.Types.Entities.Resource] =
	{
		OreStone = "矿山岩" ,
		CrystalWater = "清水晶石" ,
		CrystalFire = "火苗晶石" ,
		CrystalOld = "悠远晶石" ,
		CrystalQuiet = "宁寂晶石" ,
		CrystalHard = "黑硬的物质"
	}
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 初始化
-- ----------------------------------------
local RockTypeList =
{
	SIConstants_Resource.raw.Entities.Stone_1 ,
	SIConstants_Resource.raw.Entities.Stone_2 ,
	SIConstants_Resource.raw.Entities.Stone_3
}
local RockTypeListCount = #RockTypeList
local ResourceTypeList =
{
	SIConstants_Resource.raw.Entities.OreStone ,
	SIConstants_Resource.raw.Entities.CrystalWater ,
	SIConstants_Resource.raw.Entities.CrystalFire ,
	SIConstants_Resource.raw.Entities.CrystalOld ,
	SIConstants_Resource.raw.Entities.CrystalQuiet
}

-- ----------------------------------------
-- 事件
-- ----------------------------------------

-- ------------------------------------------------------------------------------------------------
-- ---------- 操作事件 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 事件
-- ----------------------------------------
SIEventBus
.Add( SIEvents.on_chunk_generated , function( event , functionID )
	local surface = event.surface
	for index , entity in pairs( surface.find_entities_filtered{ area = event.area , type = ResourceTypeList } ) do
		if entity and entity.valid then
			-- 如果是宁寂矿则选择特殊个体
			
			-- 矿物覆盖矿山磐岩
			local x = entity.position.x
			local y = entity.position.y
			local box = entity.prototype.collision_box
			local width = ( math.ceil( box.right_bottom.x-box.left_top.x ) - 1 ) / 2
			local height = ( math.ceil( box.right_bottom.y-box.left_top.y ) - 1 ) / 2
			for innerX = x - width , x + width , 1 do
				for innerY = y - height , y + height , 1 do
					local name = RockTypeList[math.random( RockTypeListCount )]
					if name then
						surface.create_entity{ name = name , position = { innerX , innerY } , force = "neutral" , raise_built = false }
					end
				end
			end
			for innerX = x - width - 12 , x + width + 12 , 1 do
				for innerY = y - height - 12 , y + height + 12 , 1 do
					if math.random() < 0.00556 then
						local name = RockTypeList[math.random( RockTypeListCount )]
						if name and surface.can_place_entity{ name = name , position = { innerX , innerY } , force = "neutral" } then
							surface.create_entity{ name = name , position = { innerX , innerY } , force = "neutral" , raise_built = false }
						end
					end
				end
			end
		end
	end
end )

-- ------------------------------------------------------------------------------------------------
-- ---------- 外部接口 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 接口注册
-- ----------------------------------------
-- SINeed( "RemoteInterface" )
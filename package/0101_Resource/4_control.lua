-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 定义信息 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

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
		CrystalOreWater = "清水矿" ,
		CrystalOreFire = "火苗矿" ,
		CrystalOreAgent = "悠远矿" ,
		CrystalOreQuiet = "宁寂矿" ,
		CrystalOreQuietActive = "宁寂矿-活化" ,
		CrystalHard = "黑硬的物质"
	} ,
	[SICommon.Types.Entities.Sticker] =
	{
		CrystalSlow = "晶石减速" ,
		QuietSlow = "宁寂减速"
	}
}

SIResourceOreCheckDelay = 120
SIResourceOreCheckRadius = 28
SIResourceOreDamages =
{
	{ Type = "physical"                                    , Amount = 0.5 } ,
	{ Type = SIConstants_Core.raw.DamageTypes.PhysicEnergy , Amount = 2.5 } ,
	{ Type = SIConstants_Core.raw.DamageTypes.MagicVoid    , Amount = 2.5 }
}
SIResourceSettings =
{
	Name = "SIResourceSettings" ,
	Default =
	{
		OreQuietList = {}
	}
}

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 基础数据 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================
-- 初始化
-- ======================================================================
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
SIGlobal.CreateSettings( SIResourceSettings )

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
.Add( SIEvents.on_chunk_generated , function( event , functionID )
	local globalSettings = SIGlobal.GetGlobalSettings( SIResourceSettings.Name )
	local surface = event.surface
	for index , entity in pairs( surface.find_entities_filtered{ area = event.area , type = ResourceTypeList } ) do
		if entity and entity.valid then
			-- 如果是宁寂矿则选择特殊个体
			if entity.name == SIConstants_Resource.raw.Entities.CrystalOreQuiet then
				if math.random() < 0.013 then
					local newEntity = surface.create_entity
					{
						name = SIConstants_Resource.raw.Entities.CrystalOreQuietActive ,
						position = entity.position ,
						force = "neutral" ,
						raise_built = false ,
						amount = entity.amount
					}
					entity.destroy()
					entity = newEntity
					table.insert( globalSettings.OreQuietList , newEntity )
				end
			end
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
.Add( SIEvents.on_tick , function( event , functionID )
	local globalSettings = SIGlobal.GetGlobalSettings( SIResourceSettings.Name )
	local oreList = globalSettings.OreQuietList
	local maxSize = #oreList
	local currentTick = math.fmod( event.tick , SIResourceOreCheckDelay ) + 1
	for index = currentTick , maxSize , SIResourceOreCheckDelay do
		local oreEntity = oreList[index]
		if not oreEntity or not oreEntity.valid then
			table.remove( oreList , index )
			break
		end
		local surface = oreEntity.surface
		local position = oreEntity.position
		for code , character in pairs( surface.find_entities_filtered{ area = { { position.x - SIResourceOreCheckRadius , position.y - SIResourceOreCheckRadius } , { position.x + SIResourceOreCheckRadius , position.y + SIResourceOreCheckRadius } } , type = SICommon.Types.Entities.Character } ) do
			if character and character.valid then
				for damageIndex , damageData in pairs( SIResourceOreDamages ) do
					character.damage( damageData.Amount , "neutral" , damageData.Type , oreEntity )
				end
				surface.create_entity
				{
					name = SIConstants_Resource.raw.Entities.QuietSlow ,
					position = oreEntity.position ,
					force = "neutral" ,
					target = character ,
					raise_built = false
				}
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
-- SINeed( "RemoteInterface" )
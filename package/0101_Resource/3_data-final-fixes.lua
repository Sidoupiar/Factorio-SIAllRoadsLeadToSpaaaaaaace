-- ------------------------------------------------------------------------------------------------
-- ---------- 处理数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- 调整矿山磐岩的碰撞层
for stoneIndex = 1 , 3 , 1 do
	SIGen.Find( SICommon.Types.Entities.SimpleEntity , "Stone_" .. stoneIndex , function( prototypeName , prototypeData )
		if prototypeData then
			local mask = prototypeData.collision_mask
			if mask then
				if not SITable.Has( mask , SICommon.Flags.CollisionMask.NotCollidingWithItself ) then
					table.insert( mask , SICommon.Flags.CollisionMask.NotCollidingWithItself )
				end
			else
				mask = SIUtils.CollisionMask.get_default_mask( SICommon.Types.Entities.SimpleEntity )
				if not SITable.Has( mask , SICommon.Flags.CollisionMask.NotCollidingWithItself ) then
					table.insert( mask , SICommon.Flags.CollisionMask.NotCollidingWithItself )
				end
				prototypeData.collision_mask = mask
			end
		end
	end )
end
-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 修改部分实体的属性 ==============================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- 修改树木血量
if SIConfigs.SIOverhaulBasic.TreeHealth ~= nil and SISettings.Startup.SIOverhaulBasic.TreeHealth() then
	SIGen.ForEach( SICommon.Types.Entities.Tree , function( prototypeName , prototypeData )
		if prototypeData and prototypeData.max_health then
			prototypeData.max_health = prototypeData.max_health * 30
			prototypeData.healing_per_tick = ( prototypeData.healing_per_tick or 0.017 ) * 30
		end
	end )
end

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 降低晚上的亮度 ==================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

if SIConfigs.SIOverhaulBasic.TotalEvening ~= nil and SISettings.Startup.SIOverhaulBasic.TotalEvening() then
	SIGen.Find( SICommon.Types.Constants , "default" , function( prototypeName , prototypeData )
		if prototypeData then
			prototypeData.daytime_color_lookup =
			{
				{ 0.00 , "identity" } ,
				{ 0.15 , "identity" } ,
				{ 0.20 , "identity" } ,
				{ 0.45 , SIGen.MakeRawPicturePath( "世界光线-夜晚" ) } ,
				{ 0.55 , SIGen.MakeRawPicturePath( "世界光线-夜晚" ) } ,
				{ 0.80 , "identity" } ,
				{ 0.85 , "identity" }
			}
			prototypeData.zoom_to_world_daytime_color_lookup =
			{
				{ 0.25 , "identity" } ,
				{ 0.45 , SIGen.MakeRawPicturePath( "世界光线-夜晚" ) } ,
				{ 0.55 , SIGen.MakeRawPicturePath( "世界光线-夜晚" ) } ,
				{ 0.75 , "identity" }
			}
		end
	end )
end

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 修改虫子尸体存在的时间 ==========================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

if SIConfigs.SIOverhaulBasic.EnemyCorpseDuration ~= nil then
	local enemyCorpseDuration = SISettings.Startup.SIOverhaulBasic.EnemyCorpseDuration()
	if enemyCorpseDuration > 0 then
		SIGen.ForEach( SICommon.Types.Entities.Unit , function( unitPrototypeName , unitPrototypeData )
			if unitPrototypeData and unitPrototypeData.corpse then
				SIGen.Find( SICommon.Types.Entities.Corpse , unitPrototypeData.corpse , function( corpsePrototypeName , corpsePrototypeData )
					if corpsePrototypeData then
						local realDuration = math.min( corpsePrototypeData.time_before_removed , enemyCorpseDuration )
						corpsePrototypeData.time_before_removed = realDuration
						if corpsePrototypeData.ground_patch_fade_out_start then
							corpsePrototypeData.ground_patch_fade_out_start = realDuration / 16
						end
						if corpsePrototypeData.ground_patch_fade_out_duration then
							corpsePrototypeData.ground_patch_fade_out_duration = realDuration / 40
						end
					end
				end )
			end
		end )
	end
end

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 显示物品堆叠数量 ================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

if SIConfigs.SIOverhaulBasic.ShowItemStackData ~= nil and SISettings.Startup.SIOverhaulBasic.ShowItemStackData() then
	local forceFlag = SIConfigs.SIOverhaulBasic.ShowItemStackDataForce ~= nil and SISettings.Startup.SIOverhaulBasic.ShowItemStackDataForce() or false
	SIGen.ForEachType( SICommon.Types.StackableItems , function( prototypeName , prototypeData )
		if prototypeData then
			local localDescription = prototypeData.localised_description
			if not localDescription then
				if prototypeData.place_result then
					SIGen.ForEach( SICommon.Types.Entities , function( entityPrototypeName , entityPrototypeData )
						if entityPrototypeName == prototypeData.place_result and entityPrototypeData then
							localDescription = entityPrototypeData.localised_description or { "entity-description." .. entityPrototypeName }
						end
					end )
				end
			end
			prototypeData.localised_description =
			{
				"SIOverhaulBasic.物品信息" ,
				localDescription or forceFlag and { "SIOverhaulBasic.物品信息-无" } or { "item-description." .. prototypeName } ,
				prototypeData.stack_size or 1
			}
		end
	end )
end
SIRPGSystem =
{
	ID = "RPGSystem" ,
	Name = "RPG系统" ,
	InterfaceID = "SIRPGSystem-System" ,
	PointIDs =
	{
		Attack = "Attack" ,
		Adventure = "Adventure" ,
		Craft = "Craft"
	} ,
	PropertyIDs =
	{
		Power       = "Power"       , -- 力量
		Body        = "Body"        , -- 体质
		Strength    = "Strength"    , -- 韧性
		Will        = "Will"        , -- 意志
		Agility     = "Agility"     , -- 敏捷
		Attention   = "Attention"   , -- 专注
		Wisdom      = "Wisdom"      , -- 智慧
		Spirit      = "Spirit"      , -- 精神
		Temperament = "Temperament" , -- 气质
		Mystery     = "Mystery"     , -- 神秘
		Constraint  = "Constraint"  , -- 约束 ( 存在 )
		Luck        = "Luck"          -- 幸运
	} ,
	AdditionIDs =
	{
		CraftSpeed       = "CraftSpeed"       , -- 手搓速度
		MiningSpeed      = "MiningSpeed"      , -- 挖掘速度
		MoveSpeed        = "MoveSpeed"        , -- 移动速度
		BuildDistance    = "BuildDistance"    , -- 建造距离
		ReachDistance    = "ReachDistance"    , -- 操作距离
		ResourceDistance = "ResourceDistance" , -- 资源操作距离
		DropDistance     = "DropDistance"     , -- 丢弃距离
		PickDistance     = "PickDistance"     , -- 拾取物品距离
		LootDistance     = "LootDistance"     , -- 战利品距离
		InventorySize    = "InventorySize"    , -- 背包容量
		MaxHealth        = "MaxHealth"          -- 最大生命值
	} ,
	ValueIDs =
	{
		-- 最大值
		Health             = "Health" ,
		Strength           = "Strength" ,
		Mana               = "Mana" ,
		Energy             = "Energy" ,
		Thought            = "Thought" ,
		Soul               = "Soul" ,
		-- 恢复速度
		HealthRegen        = "HealthRegen" ,
		StrengthRegen      = "StrengthRegen" ,
		ManaRegen          = "ManaRegen" ,
		EnergyRegen        = "EnergyRegen" ,
		ThoughtRegen       = "ThoughtRegen" ,
		SoulRegen          = "SoulRegen" ,
		-- 伤害
		AttackPhysical     = "AttackPhysical" ,
		AttackMagic        = "AttackMagic" ,
		AttackElement      = "AttackElement" ,
		AttackSpace        = "AttackSpace" ,
		AttackThought      = "AttackThought" ,
		AttackSoul         = "AttackSoul" ,
		AttackNormal       = "AttackNormal" ,
		CritChancePhysical = "CritChancePhysical" ,
		CritChanceMagic    = "CritChanceMagic" ,
		CritChanceElement  = "CritChanceElement" ,
		CritChanceSpace    = "CritChanceSpace" ,
		CritChanceThought  = "CritChanceThought" ,
		CritChanceSoul     = "CritChanceSoul" ,
		CritChanceNormal   = "CritChanceNormal" ,
		CritDamagePhysical = "CritDamagePhysical" ,
		CritDamageMagic    = "CritDamageMagic" ,
		CritDamageElement  = "CritDamageElement" ,
		CritDamageSpace    = "CritDamageSpace" ,
		CritDamageThought  = "CritDamageThought" ,
		CritDamageSoul     = "CritDamageSoul" ,
		CritDamageNormal   = "CritDamageNormal" ,
		-- 防御
		BlockPhysical      = "BlockPhysical" ,
		BlockMagic         = "BlockMagic" ,
		BlockElement       = "BlockElement" ,
		BlockSpace         = "BlockSpace" ,
		BlockThought       = "BlockThought" ,
		BlockSoul          = "BlockSoul" ,
		BlockNormal        = "BlockNormal" ,
		ResistancePhysical = "ResistancePhysical" ,
		ResistanceMagic    = "ResistanceMagic" ,
		ResistanceElement  = "ResistanceElement" ,
		ResistanceSpace    = "ResistanceSpace" ,
		ResistanceThought  = "ResistanceThought" ,
		ResistanceSoul     = "ResistanceSoul" ,
		ResistanceNormal   = "ResistanceNormal" ,
		DefencePhysical    = "DefencePhysical" ,
		DefenceMagic       = "DefenceMagic" ,
		DefenceElement     = "DefenceElement" ,
		DefenceSpace       = "DefenceSpace" ,
		DefenceThought     = "DefenceThought" ,
		DefenceSoul        = "DefenceSoul" ,
		DefenceNormal      = "DefenceNormal"
	} ,
	PlayerSkillDataDefault =
	{
		Unlock = false ,
		Cooldown = 0 ,
		Level =
		{
			Attack =
			{
				Max = 0 ,
				Active = 0
			} ,
			Adventure =
			{
				Max = 0 ,
				Active = 0
			} ,
			Craft =
			{
				Max = 0 ,
				Active = 0
			}
		}
	} ,
	InventoryMax = 5000 ,
	IsCalculateDamage = false , -- 通过事件处理附加伤害时 , damage 函数会重复触发事件 , 使用此项全局变量来避免多次结算附加伤害
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 初始化 ==========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================
	-- 计算各个特殊实体 , 配方 , 开采物 , 科技的经验值<br>
	-- ======================================================================
	FreshSpecialList = function()
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		-- 计算实体经验值
		-- 计算配方经验值
		local recipeEXPList = globalSettings.EXP.SpecialRecipeList
		local lastEXP = 0
		lastEXP = SIRPGSystem.FreshSpecialListItem( recipeEXPList , "automation-science-pack" , lastEXP )
		lastEXP = SIRPGSystem.FreshSpecialListItem( recipeEXPList , "logistic-science-pack" , lastEXP )
		lastEXP = SIRPGSystem.FreshSpecialListItem( recipeEXPList , "military-science-pack" , lastEXP )
		lastEXP = SIRPGSystem.FreshSpecialListItem( recipeEXPList , "chemical-science-pack" , lastEXP )
		lastEXP = SIRPGSystem.FreshSpecialListItem( recipeEXPList , "production-science-pack" , lastEXP )
		lastEXP = SIRPGSystem.FreshSpecialListItem( recipeEXPList , "utility-science-pack" , lastEXP )
		local recipe_satellite = prototypes.recipe["satellite"]
		if recipe_satellite then
			local count = 0
			for index , ingredient in pairs( recipe_satellite.ingredients ) do
				count = count + ingredient.amount
			end
			recipeEXPList["satellite"] = math.floor( math.max( count * 2.5 , lastEXP / 2 ) )
		end
		-- 计算开采物经验值
		-- 计算科技经验值
	end ,
	-- ======================================================================
	-- 这是一个内部函数 , 请勿外部调用<br>
	-- ======================================================================
	FreshSpecialListItem = function( expList , name , lastEXP )
		local recipe = prototypes.recipe[name]
		if recipe then
			local energy = recipe.energy * 1.5
			lastEXP = math.floor( math.max( energy ^ 1.87 + 1 , lastEXP * 1.8 ) )
			expList[name] = lastEXP
		end
		return lastEXP
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 功能函数 ========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	CreateAttackKillExp = function( player , diedEntity )
		if not player.character or not player.character.valid or not diedEntity.is_entity_with_health then
			return
		end
		if not player.force.is_enemy( diedEntity.force ) then
			return
		end
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		local entityName = diedEntity.name
		local specialBonus = globalSettings.EXP.SpecialEntityList[entityName]
		if specialBonus then
			specialBonus = specialBonus * globalSettings.Setting.AttackExpMultiplier
			SIRPGSystem.MakeAttackExp( player.index , specialBonus , true )
		else
			local maxHealth = diedEntity.prototype.max_health
			local exp = math.max( maxHealth / 55 - 0.3 , 0.04 )
			exp = math.min( exp ^ 1.88 , globalSettings.EXP.Max ) * globalSettings.Setting.AttackExpMultiplier
			SIRPGSystem.MakeAttackExp( player.index , exp , false )
		end
	end ,
	CreateAttackDriveExp = function( player , diedEntity , driveEntity )
		if not player.character or not player.character.valid or not diedEntity.is_entity_with_health then
			return
		end
		if not player.force.is_enemy( diedEntity.force ) then
			return
		end
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		local entityName = diedEntity.name
		local specialBonus = globalSettings.EXP.SpecialEntityList[entityName]
		if specialBonus then
			specialBonus = specialBonus * globalSettings.Setting.AttackExpMultiplier
			SIRPGSystem.MakeAttackExp( player.index , specialBonus , true )
		else
			local maxHealth = diedEntity.prototype.max_health
			local driveHealth = driveEntity.prototype.max_health
			local exp = math.max( maxHealth * 8.4 / math.max( driveHealth , 400 ) - 0.7 , 0.04 )
			exp = math.min( exp ^ 1.68 , globalSettings.EXP.Max ) * globalSettings.Setting.AttackExpMultiplier
			SIRPGSystem.MakeAttackExp( player.index , exp , false )
		end
	end ,
	CreateAdventureThingExp = function( player , adventureThing )
		if not player.character or not player.character.valid then
			return
		end
	end ,
	CreateCraftRecipeExp = function( player , recipe )
		if not player.character or not player.character.valid then
			return
		end
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		local recipeName = recipe.name
		local specialBonus = globalSettings.EXP.SpecialRecipeList[recipeName]
		if specialBonus then
			specialBonus = specialBonus * globalSettings.Setting.CraftExpMultiplier
			SIRPGSystem.MakeCraftExp( player.index , specialBonus , true )
		else
			local energy = recipe.energy * 1.5
			local time = math.max( energy / ( player.character_crafting_speed_modifier + 1 ) - 0.4 , 0.04 )
			time = math.min( time ^ 1.72 , globalSettings.EXP.Max ) * globalSettings.Setting.CraftExpMultiplier
			SIRPGSystem.MakeCraftExp( player.index , time , false )
		end
	end ,
	CreateCraftMiningExp = function( player , entity )
		if not player.character or not player.character.valid then
			return
		end
		if player.force.index == entity.force.index then
			return
		end
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		local entityName = entity.name
		local specialBonus = globalSettings.EXP.SpecialMiningList[entityName]
		if specialBonus then
			specialBonus = specialBonus * globalSettings.Setting.CraftExpMultiplier
			SIRPGSystem.MakeCraftExp( player.index , specialBonus , true )
		else
			if not entity.prototype.mineable_properties then
				return
			end
			local mining = entity.prototype.mineable_properties.mining_time * 1.2
			local time = math.max( mining / ( player.character_mining_speed_modifier + 1 ) - 0.4 , 0.04 )
			time = math.min( time ^ 1.64 , globalSettings.EXP.Max ) * globalSettings.Setting.CraftExpMultiplier
			SIRPGSystem.MakeCraftExp( player.index , time , false )
		end
	end ,
	CreateCraftTechnologyExp = function( force , technology )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		local technologyName = technology.name
		local specialBonus = globalSettings.EXP.SpecialTechnologyList[technologyName]
		if specialBonus then
			specialBonus = specialBonus * globalSettings.Setting.CraftExpMultiplier
			for index , player in pairs( force.players ) do
				SIRPGSystem.MakeCraftExp( player.index , specialBonus , true )
			end
		else
			local count = 0
			for index , ingredient in pairs( technology.research_unit_ingredients ) do
				count = count + ingredient.amount
			end
			local unitCount = technology.research_unit_count
			if technology.research_unit_count_formula then
				unitCount = load( "local L = " .. ( technology.level - 1 ) .. " return " .. technology.research_unit_count_formula )()
			end
			local exp = math.max( count * unitCount * technology.research_unit_energy / 160 , 1 )
			exp = math.min( exp ^ 1.26 , globalSettings.EXP.Max ) * globalSettings.Setting.CraftExpMultiplier
			for index , player in pairs( force.players ) do
				SIRPGSystem.MakeCraftExp( player.index , exp , false )
			end
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 算法 - 数值计算 =================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	CurrentLevelMaxExp = function( currentLevel )
		if currentLevel < 1 then
			return 8
		elseif currentLevel < 40000 then
			return currentLevel * ( currentLevel + 1 ) + 8
		else
			return 1600000000
		end
	end ,
	CalculateAttackPoint = function( currentLevel , addingLevel )
		local pointCount = 0
		if addingLevel > 0 then
			local realLevel = currentLevel + addingLevel
			local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
			for level = currentLevel + 1 , realLevel , 1 do
				pointCount = pointCount + globalSettings.Setting.AttackPointPerLevel
				if math.fmod( level , 10 ) == 0 then
					pointCount = pointCount + globalSettings.Setting.AttackPointExtraWithEnd0
				elseif math.fmod( level , 5 ) == 0 then
					pointCount = pointCount + globalSettings.Setting.AttackPointExtraWithEnd5
				end
			end
		elseif addingLevel < 0 then
			local realLevel = math.max( currentLevel + addingLevel , 0 ) + 1
			local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
			for level = currentLevel , realLevel , -1 do
				pointCount = pointCount - globalSettings.Setting.AttackPointPerLevel
				if math.fmod( level , 10 ) == 0 then
					pointCount = pointCount - globalSettings.Setting.AttackPointExtraWithEnd0
				elseif math.fmod( level , 5 ) == 0 then
					pointCount = pointCount - globalSettings.Setting.AttackPointExtraWithEnd5
				end
			end
		end
		return pointCount
	end ,
	CalculateAdventurePoint = function( currentLevel , addingLevel )
		local pointCount = 0
		if addingLevel > 0 then
			local realLevel = currentLevel + addingLevel
			local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
			for level = currentLevel + 1 , realLevel , 1 do
				pointCount = pointCount + globalSettings.Setting.AdventurePointPerLevel
				if math.fmod( level , 10 ) == 0 then
					pointCount = pointCount + globalSettings.Setting.AdventurePointExtraWithEnd0
				elseif math.fmod( level , 5 ) == 0 then
					pointCount = pointCount + globalSettings.Setting.AdventurePointExtraWithEnd5
				end
			end
		elseif addingLevel < 0 then
			local realLevel = math.max( currentLevel + addingLevel , 0 ) + 1
			local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
			for level = currentLevel , realLevel , -1 do
				pointCount = pointCount - globalSettings.Setting.AdventurePointPerLevel
				if math.fmod( level , 10 ) == 0 then
					pointCount = pointCount - globalSettings.Setting.AdventurePointExtraWithEnd0
				elseif math.fmod( level , 5 ) == 0 then
					pointCount = pointCount - globalSettings.Setting.AdventurePointExtraWithEnd5
				end
			end
		end
		return pointCount
	end ,
	CalculateCraftPoint = function( currentLevel , addingLevel )
		local pointCount = 0
		if addingLevel > 0 then
			local realLevel = currentLevel + addingLevel
			local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
			for level = currentLevel + 1 , realLevel , 1 do
				pointCount = pointCount + globalSettings.Setting.CraftPointPerLevel
				if math.fmod( level , 10 ) == 0 then
					pointCount = pointCount + globalSettings.Setting.CraftPointExtraWithEnd0
				elseif math.fmod( level , 5 ) == 0 then
					pointCount = pointCount + globalSettings.Setting.CraftPointExtraWithEnd5
				end
			end
		elseif addingLevel < 0 then
			local realLevel = math.max( currentLevel + addingLevel , 0 ) + 1
			local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
			for level = currentLevel , realLevel , -1 do
				pointCount = pointCount - globalSettings.Setting.CraftPointPerLevel
				if math.fmod( level , 10 ) == 0 then
					pointCount = pointCount - globalSettings.Setting.CraftPointExtraWithEnd0
				elseif math.fmod( level , 5 ) == 0 then
					pointCount = pointCount - globalSettings.Setting.CraftPointExtraWithEnd5
				end
			end
		end
		return pointCount
	end ,
	FreshPropertyEffect = function( settings , globalSettings , propertyID , oldLevel )
		local max = settings.Value.Max
		local current = settings.Value.Current
		local effectValueList = globalSettings.Setting.PropertyEffects[propertyID]
		for valueID , effectValue in pairs( effectValueList ) do
			local oldValue = oldLevel * effectValue
			local newValue = settings.Property.Active[propertyID] * effectValue
			local maxValue = max[valueID] - oldValue + newValue
			max[valueID] = maxValue
			local currentValue = current[valueID]
			if currentValue then
				current[valueID] = math.min( currentValue , maxValue )
			end
		end
	end ,
	CanFreshAdditionEffect = function( settings , globalSettings , additionID , newLevel , oldLevel )
		local additionEffect = SIRPGSystem.AdditionEffects[additionID]
		local effectValue = globalSettings.Setting.AdditionEffects[additionID]
		local oldValue = oldLevel * effectValue
		local newValue = newLevel * effectValue
		if SIRPGSystem.AdditionEffectFloor[additionID] then
			oldValue = math.floor( oldValue )
			newValue = math.floor( newValue )
		end
		local max = SIRPGSystem.AdditionEffectMax[additionID]
		if max then
			oldValue = math.min( oldValue , max )
			newValue = math.min( newValue , max )
		end
		local player = game.get_player( settings.playerIndex )
		return player[additionEffect] - oldValue + newValue >= SIRPGSystem.AdditionEffectMin[additionID]
	end ,
	FreshAdditionEffect = function( settings , globalSettings , additionID , oldLevel )
		local player = game.get_player( settings.playerIndex )
		if player.connected and settings.character and settings.character.valid then
			local additionEffect = SIRPGSystem.AdditionEffects[additionID]
			local effectValue = globalSettings.Setting.AdditionEffects[additionID]
			local oldValue = oldLevel * effectValue
			local newValue = settings.Addition.Active[additionID] * effectValue
			if SIRPGSystem.AdditionEffectFloor[additionID] then
				oldValue = math.floor( oldValue )
				newValue = math.floor( newValue )
			end
			local max = SIRPGSystem.AdditionEffectMax[additionID]
			if max then
				oldValue = math.min( oldValue , max )
				newValue = math.min( newValue , max )
			end
			local currentValue = settings.character[additionEffect] - oldValue + newValue
			if currentValue < SIRPGSystem.AdditionEffectMin[additionID] then
				CodeE( SIRPGSystem , "玩家当前 [ 加成 ] 效果小于游戏内核允许的最小值 , 判断为丢失了部分 [ 加成 ] , 原因未知 , 无法继续更新 [ 加成 ] 效果" )
			else
				settings.character[additionEffect] = currentValue
			end
		end
	end ,
	ClearAdditionEffect = function( settings , globalSettings , additionID )
		local player = game.get_player( settings.playerIndex )
		if player.connected and settings.character and settings.character.valid then
			local additionEffect = SIRPGSystem.AdditionEffects[additionID]
			local effectValue = globalSettings.Setting.AdditionEffects[additionID]
			local value = settings.Addition.Active[additionID] * effectValue
			if SIRPGSystem.AdditionEffectFloor[additionID] then
				value = math.floor( value )
			end
			local max = SIRPGSystem.AdditionEffectMax[additionID]
			if max then
				value = math.min( value , max )
			end
			local currentValue = settings.character[additionEffect] - value
			if currentValue < SIRPGSystem.AdditionEffectMin[additionID] then
				CodeE( SIRPGSystem , "玩家当前 [ 加成 ] 效果小于游戏内核允许的最小值 , 判断为丢失了部分 [ 加成 ] , 原因未知 , 无法继续移除 [ 加成 ] 效果" )
			else
				settings.character[additionEffect] = currentValue
			end
		end
	end ,
	FireSkillInterface = function( playerIndex , globalSkillData , playerSkillData , isQuickUse )
		if SIPermission.HasPermission( SIPermission.PermissionIDs.RPGPlayerSkill , playerIndex ) then
			if globalSkillData.Permission then
				if not SIPermission.HasPermission( globalSkillData.Permission , playerIndex ) then
					SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( globalSkillData.Permission ) )
					return
				end
			end
			if globalSkillData.EffectInterface and globalSkillData.EffectFunctionName then
				if remote.interfaces[globalSkillData.EffectInterface] and remote.interfaces[globalSkillData.EffectInterface][globalSkillData.EffectFunctionName] then
					if globalSkillData.IsPassive then
						local returnData = remote.call( globalSkillData.EffectInterface , globalSkillData.EffectFunctionName , playerIndex , globalSkillData , playerSkillData , isQuickUse , game.tick )
						if returnData then
							playerSkillData.CustomData = returnData.CustomData
						end
					elseif globalSkillData.SkillItem then
						if playerSkillData.Cooldown > 0 then
							SIPrint.Message( playerIndex , { "SIRPGSystem.技能提示-技能冷却中" , globalSkillData.Name } )
							return
						end
						if SIRPGSystem.TakeSkillCost( playerIndex , globalSkillData.ID ) then
							playerSkillData.Cooldown = math.max( globalSkillData.Cooldown , 0 )
							local returnData = remote.call( globalSkillData.EffectInterface , globalSkillData.EffectFunctionName , playerIndex , globalSkillData , playerSkillData , isQuickUse , game.tick )
							if returnData then
								playerSkillData.Cooldown = math.max( returnData.Cooldown , 0 )
								playerSkillData.CustomData = returnData.CustomData
							end
						else
							SIPrint.Warning( playerIndex , { "SIRPGSystem.技能提示-条件不足" , globalSkillData.Name } )
						end
					else
						local returnData = remote.call( globalSkillData.EffectInterface , globalSkillData.EffectFunctionName , playerIndex , globalSkillData , playerSkillData , isQuickUse , game.tick )
						if returnData then
							playerSkillData.Cooldown = math.max( returnData.Cooldown , 0 )
							playerSkillData.CustomData = returnData.CustomData
						end
					end
				end
			end
		else
			SIPrint.Alert( playerIndex , SIPermission.GetPermissionMessage( SIPermission.PermissionIDs.RPGPlayerSkill ) )
		end
	end ,
	CheckLockSkillList = function( settings )
		local hasUnlock = false
		for skillID , playerSkillData in pairs( settings.SkillList ) do
			if not playerSkillData.Unlock then
				if SIRPGSystem.CheckLockSkill( settings , skillID ) then
					hasUnlock = true
				end
			end
		end
		return hasUnlock
	end ,
	CheckLockSkill = function( settings , skillID )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		local globalSkillData = globalSettings.SkillList[skillID]
		if globalSkillData.Unlock then
			local unlock = globalSkillData.Unlock
			if unlock.Cannot then
				return false
			end
			if unlock.Level then
				if unlock.Level.Attack and unlock.Level.Attack > settings.EXP.AttackLevel then
					return false
				end
				if unlock.Level.Adventure and unlock.Level.Adventure > settings.EXP.AdventureLevel then
					return false
				end
				if unlock.Level.Craft and unlock.Level.Craft > settings.EXP.CraftLevel then
					return false
				end
			end
			if unlock.Point then
				if unlock.Point.Attack and unlock.Point.Attack > settings.Points.Max.Attack then
					return false
				end
				if unlock.Point.Adventure and unlock.Point.Adventure > settings.Points.Max.Adventure then
					return false
				end
				if unlock.Point.Craft and unlock.Point.Craft > settings.Points.Max.Craft then
					return false
				end
			end
			if unlock.Property then
				for name , propertyID in pairs( SIRPGSystem.PropertyIDs ) do
					if unlock.Property[propertyID] and unlock.Property[propertyID] > settings.Property.Max[propertyID] then
						return false
					end
				end
			end
			if unlock.Addition then
				for name , additionID in pairs( SIRPGSystem.AdditionIDs ) do
					if unlock.Addition[additionID] and unlock.Addition[additionID] > settings.Addition.Max[additionID] then
						return false
					end
				end
			end
		end
		settings.SkillList[skillID].Unlock = true
		return true
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 接口函数 - 经验数据操作 =========================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================
	-- 增加玩家的战斗经验值<br>
	-- 只不过是正常游戏使用的增加经验值的函数 , 会判断权限弹出消息等<br>
	-- 如果只是想修改经验值 , 请使用 AddAttackExp 函数<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- expCount        = 经验值数量 , 不可以是负数<br>
	-- isSpecial       = 是否为特殊经验 , 弹出的消息中显示的文字和颜色不一样而已<br>
	-- ======================================================================
	MakeAttackExp = function( playerIndex , expCount , isSpecial )
		if expCount <= 0 then
			return
		end
		local levelCount = 0
		if SIPermission.HasPermission( SIPermission.PermissionIDs.RPGExp , playerIndex ) then
			levelCount = SIRPGSystem.AddAttackExp( playerIndex , expCount )
		end
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		if settings.PlayerSetting.Base.showFlyingText then
			local player = game.get_player( playerIndex )
			SIFunctions.FlyingTextPlayer( { isSpecial and "SIRPGSystem.获得经验-战斗-特殊" or "SIRPGSystem.获得经验-战斗-普通" , SITools.FormatNumber4( expCount ) } , player , 1 , false )
			if levelCount == 1 then
				SIFunctions.FlyingTextPlayer( { "SIRPGSystem.提升等级-战斗-单次" } , player , 1.5 , false )
			elseif levelCount > 1 then
				SIFunctions.FlyingTextPlayer( { "SIRPGSystem.提升等级-战斗-多次" , levelCount } , player , 1.5 , false )
			end
		end
	end ,

	-- ======================================================================
	-- 增加玩家的探索经验值<br>
	-- 只不过是正常游戏使用的增加经验值的函数 , 会判断权限弹出消息等<br>
	-- 如果只是想修改经验值 , 请使用 AddAdventureExp 函数<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- expCount        = 经验值数量 , 不可以是负数<br>
	-- isSpecial       = 是否为特殊经验 , 弹出的消息中显示的文字和颜色不一样而已<br>
	-- ======================================================================
	MakeAdventureExp = function( playerIndex , expCount , isSpecial )
		if expCount <= 0 then
			return
		end
		local levelCount = 0
		if SIPermission.HasPermission( SIPermission.PermissionIDs.RPGExp , playerIndex ) then
			levelCount = SIRPGSystem.AddAdventureExp( playerIndex , expCount )
		end
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		if settings.PlayerSetting.Base.showFlyingText then
			local player = game.get_player( playerIndex )
			SIFunctions.FlyingTextPlayer( { isSpecial and "SIRPGSystem.获得经验-探索-特殊" or "SIRPGSystem.获得经验-探索-普通" , SITools.FormatNumber4( expCount ) } , player , 1 , false )
			if levelCount == 1 then
				SIFunctions.FlyingTextPlayer( { "SIRPGSystem.提升等级-探索-单次" } , player , 1.5 , false )
			elseif levelCount > 1 then
				SIFunctions.FlyingTextPlayer( { "SIRPGSystem.提升等级-探索-多次" , levelCount } , player , 1.5 , false )
			end
		end
	end ,

	-- ======================================================================
	-- 增加玩家的生存经验值<br>
	-- 只不过是正常游戏使用的增加经验值的函数 , 会判断权限弹出消息等<br>
	-- 如果只是想修改经验值 , 请使用 AddCraftExp 函数<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- expCount        = 经验值数量 , 不可以是负数<br>
	-- isSpecial       = 是否为特殊经验 , 弹出的消息中显示的文字和颜色不一样而已<br>
	-- ======================================================================
	MakeCraftExp = function( playerIndex , expCount , isSpecial )
		if expCount <= 0 then
			return
		end
		local levelCount = 0
		if SIPermission.HasPermission( SIPermission.PermissionIDs.RPGExp , playerIndex ) then
			levelCount = SIRPGSystem.AddCraftExp( playerIndex , expCount )
		end
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		if settings.PlayerSetting.Base.showFlyingText then
			local player = game.get_player( playerIndex )
			SIFunctions.FlyingTextPlayer( { isSpecial and "SIRPGSystem.获得经验-生存-特殊" or "SIRPGSystem.获得经验-生存-普通" , SITools.FormatNumber4( expCount ) } , player , 1 , false )
			if levelCount == 1 then
				SIFunctions.FlyingTextPlayer( { "SIRPGSystem.提升等级-生存-单次" } , player , 1.5 , false )
			elseif levelCount > 1 then
				SIFunctions.FlyingTextPlayer( { "SIRPGSystem.提升等级-生存-多次" , levelCount } , player , 1.5 , false )
			end
		end
	end ,

	-- ======================================================================
	-- 增加玩家的战斗经验值<br>
	-- 经验值每级独立计算 , 也就是说计算后经验值永远是非负的<br>
	-- 不要使用此接口来降低等级 , 降低等级请使用 AddAttackLevel 接口<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- expCount        = 经验值数量 , 可以是负数<br>
	-- ======================================================================
	-- 返回值 = 实际提升的等级<br>
	-- ======================================================================
	AddAttackExp = function( playerIndex , expCount )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local exp = math.max( settings.EXP.AttackExp + expCount , 0 )
		local expMax = settings.EXP.AttackExpMax
		local levelCount = 0
		while exp >= expMax do
			levelCount = levelCount + 1
			exp = exp - expMax
			expMax = SIRPGSystem.CurrentLevelMaxExp( settings.EXP.AttackLevel + levelCount )
		end
		settings.EXP.AttackExp = exp
		if levelCount > 0 then
			local pointCount = SIRPGSystem.CalculateAttackPoint( settings.EXP.AttackLevel , levelCount )
			settings.Points.Max.Attack = settings.Points.Max.Attack + pointCount
			settings.Points.Current.Attack = settings.Points.Current.Attack + pointCount
			settings.EXP.AttackExpMax = expMax
			settings.EXP.AttackLevel = settings.EXP.AttackLevel + levelCount
			local hasUnlock = SIRPGSystem.CheckLockSkillList( settings )
			if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
				SIRPGPlayerStatus.FreshPoint( settings )
			end
			if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
				SIRPGPlayerSkill.FreshPoint( settings )
				if hasUnlock then
					SIRPGPlayerSkill.FreshSkill( settings )
				end
			end
		end
		if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
			SIRPGPlayerStatus.FreshLevel( settings )
		end
		if settings.PlayerStatusMini.frame and settings.PlayerStatusMini.frame.valid then
			SIRPGPlayerStatusMini.FreshLevel( settings )
		end
		return levelCount
	end ,

	-- ======================================================================
	-- 设置玩家的战斗经验值<br>
	-- 经验值每级独立计算 , 也就是说计算后经验值永远是非负的<br>
	-- 不要使用此接口来降低等级 , 降低等级请使用 AddAttackLevel 接口<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- expCount        = 经验值数量 , 虽然可以是负数 , 但是会被当作 0 处理<br>
	-- ======================================================================
	-- 返回值 = 实际提升的等级<br>
	-- ======================================================================
	SetAttackExp = function( playerIndex , expCount )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local exp = math.max( expCount , 0 )
		local expMax = settings.EXP.AttackExpMax
		local levelCount = 0
		while exp >= expMax do
			levelCount = levelCount + 1
			exp = exp - expMax
			expMax = SIRPGSystem.CurrentLevelMaxExp( settings.EXP.AttackLevel + levelCount )
		end
		settings.EXP.AttackExp = exp
		if levelCount > 0 then
			local pointCount = SIRPGSystem.CalculateAttackPoint( settings.EXP.AttackLevel , levelCount )
			settings.Points.Max.Attack = settings.Points.Max.Attack + pointCount
			settings.Points.Current.Attack = settings.Points.Current.Attack + pointCount
			settings.EXP.AttackExpMax = expMax
			settings.EXP.AttackLevel = settings.EXP.AttackLevel + levelCount
			local hasUnlock = SIRPGSystem.CheckLockSkillList( settings )
			if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
				SIRPGPlayerStatus.FreshPoint( settings )
			end
			if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
				SIRPGPlayerSkill.FreshPoint( settings )
				if hasUnlock then
					SIRPGPlayerSkill.FreshSkill( settings )
				end
			end
		end
		if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
			SIRPGPlayerStatus.FreshLevel( settings )
		end
		if settings.PlayerStatusMini.frame and settings.PlayerStatusMini.frame.valid then
			SIRPGPlayerStatusMini.FreshLevel( settings )
		end
		return levelCount
	end ,

	-- ======================================================================
	-- 获取玩家的当前战斗经验值<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- ======================================================================
	-- 返回值 = 当前的战斗经验值<br>
	-- ======================================================================
	GetAttackExp = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		return settings.EXP.AttackExp
	end ,

	-- ======================================================================
	-- 获取玩家的当前战斗经验等级的经验值上限<br>
	-- 当经验值超过上限时 , 玩家就会升级 , 且溢出的经验值会被保留到下一级<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- ======================================================================
	-- 返回值 = 当前战斗经验等级的经验值上限<br>
	-- ======================================================================
	GetCurrentLevelMaxAttackExp = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		return settings.EXP.AttackExpMax
	end ,

	-- ======================================================================
	-- 增加玩家的探索经验值<br>
	-- 经验值每级独立计算 , 也就是说计算后经验值永远是非负的<br>
	-- 不要使用此接口来降低等级 , 降低等级请使用 AddAdventureLevel 接口<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- expCount        = 经验值数量 , 可以是负数<br>
	-- ======================================================================
	-- 返回值 = 实际提升的等级<br>
	-- ======================================================================
	AddAdventureExp = function( playerIndex , expCount )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local exp = math.max( settings.EXP.AdventureExp + expCount , 0 )
		local expMax = settings.EXP.AdventureExpMax
		local levelCount = 0
		while exp >= expMax do
			levelCount = levelCount + 1
			exp = exp - expMax
			expMax = SIRPGSystem.CurrentLevelMaxExp( settings.EXP.AdventureLevel + levelCount )
		end
		settings.EXP.AdventureExp = exp
		if levelCount > 0 then
			local pointCount = SIRPGSystem.CalculateAdventurePoint( settings.EXP.AdventureLevel , levelCount )
			settings.Points.Max.Adventure = settings.Points.Max.Adventure + pointCount
			settings.Points.Current.Adventure = settings.Points.Current.Adventure + pointCount
			settings.EXP.AdventureExpMax = expMax
			settings.EXP.AdventureLevel = settings.EXP.AdventureLevel + levelCount
			local hasUnlock = SIRPGSystem.CheckLockSkillList( settings )
			if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
				SIRPGPlayerStatus.FreshPoint( settings )
			end
			if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
				SIRPGPlayerSkill.FreshPoint( settings )
				if hasUnlock then
					SIRPGPlayerSkill.FreshSkill( settings )
				end
			end
		end
		if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
			SIRPGPlayerStatus.FreshLevel( settings )
		end
		if settings.PlayerStatusMini.frame and settings.PlayerStatusMini.frame.valid then
			SIRPGPlayerStatusMini.FreshLevel( settings )
		end
		return levelCount
	end ,

	-- ======================================================================
	-- 设置玩家的探索经验值<br>
	-- 经验值每级独立计算 , 也就是说计算后经验值永远是非负的<br>
	-- 不要使用此接口来降低等级 , 降低等级请使用 AddAdventureLevel 接口<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- expCount        = 经验值数量 , 虽然可以是负数 , 但是会被当作 0 处理<br>
	-- ======================================================================
	-- 返回值 = 实际提升的等级<br>
	-- ======================================================================
	SetAdventureExp = function( playerIndex , expCount )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local exp = math.max( expCount , 0 )
		local expMax = settings.EXP.AdventureExpMax
		local levelCount = 0
		while exp >= expMax do
			levelCount = levelCount + 1
			exp = exp - expMax
			expMax = SIRPGSystem.CurrentLevelMaxExp( settings.EXP.AdventureLevel + levelCount )
		end
		settings.EXP.AdventureExp = exp
		if levelCount > 0 then
			local pointCount = SIRPGSystem.CalculateAdventurePoint( settings.EXP.AdventureLevel , levelCount )
			settings.Points.Max.Adventure = settings.Points.Max.Adventure + pointCount
			settings.Points.Current.Adventure = settings.Points.Current.Adventure + pointCount
			settings.EXP.AdventureExpMax = expMax
			settings.EXP.AdventureLevel = settings.EXP.AdventureLevel + levelCount
			local hasUnlock = SIRPGSystem.CheckLockSkillList( settings )
			if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
				SIRPGPlayerStatus.FreshPoint( settings )
			end
			if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
				SIRPGPlayerSkill.FreshPoint( settings )
				if hasUnlock then
					SIRPGPlayerSkill.FreshSkill( settings )
				end
			end
		end
		if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
			SIRPGPlayerStatus.FreshLevel( settings )
		end
		if settings.PlayerStatusMini.frame and settings.PlayerStatusMini.frame.valid then
			SIRPGPlayerStatusMini.FreshLevel( settings )
		end
		return levelCount
	end ,

	-- ======================================================================
	-- 获取玩家的当前探索经验值<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- ======================================================================
	-- 返回值 = 当前的探索经验值<br>
	-- ======================================================================
	GetAdventureExp = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		return settings.EXP.AdventureExp
	end ,

	-- ======================================================================
	-- 获取玩家的当前探索经验等级的经验值上限<br>
	-- 当经验值超过上限时 , 玩家就会升级 , 且溢出的经验值会被保留到下一级<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- ======================================================================
	-- 返回值 = 当前探索经验等级的经验值上限<br>
	-- ======================================================================
	GetCurrentLevelMaxAdventureExp = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		return settings.EXP.AdventureExpMax
	end ,

	-- ======================================================================
	-- 增加玩家的生存经验值<br>
	-- 经验值每级独立计算 , 也就是说计算后经验值永远是非负的<br>
	-- 不要使用此接口来降低等级 , 降低等级请使用 AddCraftLevel 接口<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- expCount        = 经验值数量 , 可以是负数<br>
	-- ======================================================================
	-- 返回值 = 实际提升的等级<br>
	-- ======================================================================
	AddCraftExp = function( playerIndex , expCount )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local exp = math.max( settings.EXP.CraftExp + expCount , 0 )
		local expMax = settings.EXP.CraftExpMax
		local levelCount = 0
		while exp >= expMax do
			levelCount = levelCount + 1
			exp = exp - expMax
			expMax = SIRPGSystem.CurrentLevelMaxExp( settings.EXP.CraftLevel + levelCount )
		end
		settings.EXP.CraftExp = exp
		if levelCount > 0 then
			local pointCount = SIRPGSystem.CalculateCraftPoint( settings.EXP.CraftLevel , levelCount )
			settings.Points.Max.Craft = settings.Points.Max.Craft + pointCount
			settings.Points.Current.Craft = settings.Points.Current.Craft + pointCount
			settings.EXP.CraftExpMax = expMax
			settings.EXP.CraftLevel = settings.EXP.CraftLevel + levelCount
			local hasUnlock = SIRPGSystem.CheckLockSkillList( settings )
			if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
				SIRPGPlayerStatus.FreshPoint( settings )
			end
			if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
				SIRPGPlayerSkill.FreshPoint( settings )
				if hasUnlock then
					SIRPGPlayerSkill.FreshSkill( settings )
				end
			end
		end
		if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
			SIRPGPlayerStatus.FreshLevel( settings )
		end
		if settings.PlayerStatusMini.frame and settings.PlayerStatusMini.frame.valid then
			SIRPGPlayerStatusMini.FreshLevel( settings )
		end
		return levelCount
	end ,

	-- ======================================================================
	-- 设置玩家的生存经验值<br>
	-- 经验值每级独立计算 , 也就是说计算后经验值永远是非负的<br>
	-- 不要使用此接口来降低等级 , 降低等级请使用 AddCraftLevel 接口<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- expCount        = 经验值数量 , 虽然可以是负数 , 但是会被当作 0 处理<br>
	-- ======================================================================
	-- 返回值 = 实际提升的等级<br>
	-- ======================================================================
	SetCraftExp = function( playerIndex , expCount )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local exp = math.max( expCount , 0 )
		local expMax = settings.EXP.CraftExpMax
		local levelCount = 0
		while exp >= expMax do
			levelCount = levelCount + 1
			exp = exp - expMax
			expMax = SIRPGSystem.CurrentLevelMaxExp( settings.EXP.CraftLevel + levelCount )
		end
		settings.EXP.CraftExp = exp
		if levelCount > 0 then
			local pointCount = SIRPGSystem.CalculateCraftPoint( settings.EXP.CraftLevel , levelCount )
			settings.Points.Max.Craft = settings.Points.Max.Craft + pointCount
			settings.Points.Current.Craft = settings.Points.Current.Craft + pointCount
			settings.EXP.CraftExpMax = expMax
			settings.EXP.CraftLevel = settings.EXP.CraftLevel + levelCount
			local hasUnlock = SIRPGSystem.CheckLockSkillList( settings )
			if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
				SIRPGPlayerStatus.FreshPoint( settings )
			end
			if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
				SIRPGPlayerSkill.FreshPoint( settings )
				if hasUnlock then
					SIRPGPlayerSkill.FreshSkill( settings )
				end
			end
		end
		if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
			SIRPGPlayerStatus.FreshLevel( settings )
		end
		if settings.PlayerStatusMini.frame and settings.PlayerStatusMini.frame.valid then
			SIRPGPlayerStatusMini.FreshLevel( settings )
		end
		return levelCount
	end ,

	-- ======================================================================
	-- 获取玩家的当前生存经验值<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- ======================================================================
	-- 返回值 = 当前的生存经验值<br>
	-- ======================================================================
	GetCraftExp = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		return settings.EXP.CraftExp
	end ,

	-- ======================================================================
	-- 获取玩家的当前生存经验等级的经验值上限<br>
	-- 当经验值超过上限时 , 玩家就会升级 , 且溢出的经验值会被保留到下一级<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- ======================================================================
	-- 返回值 = 当前生存经验等级的经验值上限<br>
	-- ======================================================================
	GetCurrentLevelMaxCraftExp = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		return settings.EXP.CraftExpMax
	end ,

	-- ======================================================================
	-- 增加玩家的战斗经验等级<br>
	-- 最终计算后的等级不可以是负数 , 升级后会根据设置获得或扣除 [ 纷争点数 ]<br>
	-- 如果等级减少了 , 那么会重置所有的 [ 纷争点数 ] 的分配<br>
	-- 如果升级后经验值超过了当前等级的经验值上限 , 那么会强制把经验值设置成 [ 当前等级的经验值上限 - 1 ] 的值<br>
	-- 不要使用此接口来减少经验值 , 降低经验值请使用 AddAttackExp 接口<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- levelCount      = 等级数量 , 可以是负数<br>
	-- ======================================================================
	-- 返回值 = 实际提升的等级<br>
	-- ======================================================================
	AddAttackLevel = function( playerIndex , levelCount )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local level = math.max( settings.EXP.AttackLevel + levelCount , 0 )
		local pointCount = SIRPGSystem.CalculateAttackPoint( settings.EXP.AttackLevel , levelCount )
		if pointCount < 0 then
			local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
			for propertyID , value in pairs( settings.Property.Attack ) do
				local oldActive = settings.Property.Active[propertyID]
				settings.Property.Attack[propertyID] = 0
				settings.Property.Max[propertyID] = settings.Property.Max[propertyID] - value
				settings.Property.Active[propertyID] = math.min( settings.Property.Active[propertyID] , settings.Property.Max[propertyID] )
				SIRPGSystem.FreshPropertyEffect( settings , globalSettings , propertyID , oldActive )
			end
			for additionID , value in pairs( settings.Addition.Attack ) do
				local oldActive = settings.Addition.Active[additionID]
				settings.Addition.Attack[additionID] = 0
				settings.Addition.Max[additionID] = settings.Addition.Max[additionID] - value
				settings.Addition.Active[additionID] = math.min( settings.Addition.Active[additionID] , settings.Addition.Max[additionID] )
				SIRPGSystem.FreshAdditionEffect( settings , globalSettings , additionID , oldActive )
			end
			for skillType , skillDataList in pairs( settings.SkillList ) do
				for skillID , skillData in pairs( skillDataList ) do
					skillData.Level.Attack.Max = 0
					skillData.Level.Attack.Active = 0
				end
			end
			settings.Points.Max.Attack = math.max( settings.Points.Max.Attack + pointCount , 0 )
			settings.Points.Current.Attack = settings.Points.Max.Attack
			if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
				SIRPGPlayerStatus.FreshValue( settings )
				SIRPGPlayerStatus.FreshProperty( settings , globalSettings )
				SIRPGPlayerStatus.FreshAddition( settings , globalSettings )
			end
			if settings.PlayerInfo.frame and settings.PlayerInfo.frame.valid then
				SIRPGPlayerInfo.FreshValue( settings )
			end
			if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
				SIRPGPlayerSkill.FreshSkill( settings )
			end
		else
			settings.Points.Max.Attack = settings.Points.Max.Attack + pointCount
			settings.Points.Current.Attack = settings.Points.Current.Attack + pointCount
		end
		settings.EXP.AttackLevel = level
		local hasUnlock = SIRPGSystem.CheckLockSkillList( settings )
		if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
			SIRPGPlayerStatus.FreshLevel( settings )
			SIRPGPlayerStatus.FreshPoint( settings )
		end
		if settings.PlayerStatusMini.frame and settings.PlayerStatusMini.frame.valid then
			SIRPGPlayerStatusMini.FreshLevel( settings )
		end
		if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
			SIRPGPlayerSkill.FreshPoint( settings )
			if hasUnlock then
				-- 如果扣等级的话 , 那么这段代码在理论上不会进入
				SIRPGPlayerSkill.FreshSkill( settings )
			end
		end
		return levelCount
	end ,

	-- ======================================================================
	-- 设置玩家的战斗经验等级<br>
	-- 最终计算后的等级不可以是负数 , 升级后会根据设置获得或扣除 [ 纷争点数 ]<br>
	-- 如果等级减少了 , 那么会重置所有的 [ 纷争点数 ] 的分配<br>
	-- 如果升级后经验值超过了当前等级的经验值上限 , 那么会强制把经验值设置成 [ 当前等级的经验值上限 - 1 ] 的值<br>
	-- 不要使用此接口来减少经验值 , 降低经验值请使用 AddAttackExp 接口<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- levelCount      = 等级数量 , 虽然可以是负数 , 但是会被当作 0 处理
	-- ======================================================================
	-- 返回值 = 实际提升的等级<br>
	-- ======================================================================
	SetAttackLevel = function( playerIndex , levelCount )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local level = math.max( levelCount , 0 )
		local pointCount = SIRPGSystem.CalculateAttackPoint( settings.EXP.AttackLevel , levelCount - settings.EXP.AttackLevel )
		if pointCount < 0 then
			local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
			for propertyID , value in pairs( settings.Property.Attack ) do
				local oldActive = settings.Property.Active[propertyID]
				settings.Property.Attack[propertyID] = 0
				settings.Property.Max[propertyID] = settings.Property.Max[propertyID] - value
				settings.Property.Active[propertyID] = math.min( settings.Property.Active[propertyID] , settings.Property.Max[propertyID] )
				SIRPGSystem.FreshPropertyEffect( settings , globalSettings , propertyID , oldActive )
			end
			for additionID , value in pairs( settings.Addition.Attack ) do
				local oldActive = settings.Addition.Active[additionID]
				settings.Addition.Attack[additionID] = 0
				settings.Addition.Max[additionID] = settings.Addition.Max[additionID] - value
				settings.Addition.Active[additionID] = math.min( settings.Addition.Active[additionID] , settings.Addition.Max[additionID] )
				SIRPGSystem.FreshAdditionEffect( settings , globalSettings , additionID , oldActive )
			end
			for skillType , skillDataList in pairs( settings.SkillList ) do
				for skillID , skillData in pairs( skillDataList ) do
					skillData.Level.Attack.Max = 0
					skillData.Level.Attack.Active = 0
				end
			end
			settings.Points.Max.Attack = math.max( settings.Points.Max.Attack + pointCount , 0 )
			settings.Points.Current.Attack = settings.Points.Max.Attack
			if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
				SIRPGPlayerStatus.FreshValue( settings )
				SIRPGPlayerStatus.FreshProperty( settings , globalSettings )
				SIRPGPlayerStatus.FreshAddition( settings , globalSettings )
			end
			if settings.PlayerInfo.frame and settings.PlayerInfo.frame.valid then
				SIRPGPlayerInfo.FreshValue( settings )
			end
			if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
				SIRPGPlayerSkill.FreshSkill( settings )
			end
		else
			settings.Points.Max.Attack = settings.Points.Max.Attack + pointCount
			settings.Points.Current.Attack = settings.Points.Current.Attack + pointCount
		end
		settings.EXP.AttackLevel = level
		local hasUnlock = SIRPGSystem.CheckLockSkillList( settings )
		if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
			SIRPGPlayerStatus.FreshLevel( settings )
			SIRPGPlayerStatus.FreshPoint( settings )
		end
		if settings.PlayerStatusMini.frame and settings.PlayerStatusMini.frame.valid then
			SIRPGPlayerStatusMini.FreshLevel( settings )
		end
		if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
			SIRPGPlayerSkill.FreshPoint( settings )
			if hasUnlock then
				-- 如果扣等级的话 , 那么这段代码在理论上不会进入
				SIRPGPlayerSkill.FreshSkill( settings )
			end
		end
		return levelCount - settings.EXP.AttackLevel
	end ,

	-- ======================================================================
	-- 获取玩家的当前战斗经验等级<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- ======================================================================
	-- 返回值 = 当前的战斗经验等级<br>
	-- ======================================================================
	GetAttackLevel = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		return settings.EXP.AttackLevel
	end ,

	-- ======================================================================
	-- 增加玩家的探索经验等级<br>
	-- 最终计算后的等级不可以是负数 , 升级后会根据设置获得或扣除 [ 奇迹点数 ]<br>
	-- 如果等级减少了 , 那么会重置所有的 [ 奇迹点数 ] 的分配<br>
	-- 如果升级后经验值超过了当前等级的经验值上限 , 那么会强制把经验值设置成 [ 当前等级的经验值上限 - 1 ] 的值<br>
	-- 不要使用此接口来减少经验值 , 降低经验值请使用 AddAdventureExp 接口<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- levelCount      = 等级数量 , 可以是负数<br>
	-- ======================================================================
	-- 返回值 = 实际提升的等级<br>
	-- ======================================================================
	AddAdventureLevel = function( playerIndex , levelCount )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local level = math.max( settings.EXP.AdventureLevel + levelCount , 0 )
		local pointCount = SIRPGSystem.CalculateAdventurePoint( settings.EXP.AdventureLevel , levelCount )
		if pointCount < 0 then
			local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
			for propertyID , value in pairs( settings.Property.Adventure ) do
				local oldActive = settings.Property.Active[propertyID]
				settings.Property.Adventure[propertyID] = 0
				settings.Property.Max[propertyID] = settings.Property.Max[propertyID] - value
				settings.Property.Active[propertyID] = math.min( settings.Property.Active[propertyID] , settings.Property.Max[propertyID] )
				SIRPGSystem.FreshPropertyEffect( settings , globalSettings , propertyID , oldActive )
			end
			for additionID , value in pairs( settings.Addition.Adventure ) do
				local oldActive = settings.Addition.Active[additionID]
				settings.Addition.Adventure[additionID] = 0
				settings.Addition.Max[additionID] = settings.Addition.Max[additionID] - value
				settings.Addition.Active[additionID] = math.min( settings.Addition.Active[additionID] , settings.Addition.Max[additionID] )
				SIRPGSystem.FreshAdditionEffect( settings , globalSettings , additionID , oldActive )
			end
			for skillType , skillDataList in pairs( settings.SkillList ) do
				for skillID , skillData in pairs( skillDataList ) do
					skillData.Level.Adventure.Max = 0
					skillData.Level.Adventure.Active = 0
				end
			end
			settings.Points.Max.Adventure = math.max( settings.Points.Max.Adventure + pointCount , 0 )
			settings.Points.Current.Adventure = settings.Points.Max.Adventure
			if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
				SIRPGPlayerStatus.FreshValue( settings )
				SIRPGPlayerStatus.FreshProperty( settings , globalSettings )
				SIRPGPlayerStatus.FreshAddition( settings , globalSettings )
			end
			if settings.PlayerInfo.frame and settings.PlayerInfo.frame.valid then
				SIRPGPlayerInfo.FreshValue( settings )
			end
			if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
				SIRPGPlayerSkill.FreshSkill( settings )
			end
		else
			settings.Points.Max.Adventure = settings.Points.Max.Adventure + pointCount
			settings.Points.Current.Adventure = settings.Points.Current.Adventure + pointCount
		end
		settings.EXP.AdventureLevel = level
		local hasUnlock = SIRPGSystem.CheckLockSkillList( settings )
		if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
			SIRPGPlayerStatus.FreshLevel( settings )
			SIRPGPlayerStatus.FreshPoint( settings )
		end
		if settings.PlayerStatusMini.frame and settings.PlayerStatusMini.frame.valid then
			SIRPGPlayerStatusMini.FreshLevel( settings )
		end
		if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
			SIRPGPlayerSkill.FreshPoint( settings )
			if hasUnlock then
				-- 如果扣等级的话 , 那么这段代码在理论上不会进入
				SIRPGPlayerSkill.FreshSkill( settings )
			end
		end
		return levelCount
	end ,

	-- ======================================================================
	-- 设置玩家的探索经验等级<br>
	-- 最终计算后的等级不可以是负数 , 升级后会根据设置获得或扣除 [ 奇迹点数 ]<br>
	-- 如果等级减少了 , 那么会重置所有的 [ 奇迹点数 ] 的分配<br>
	-- 如果升级后经验值超过了当前等级的经验值上限 , 那么会强制把经验值设置成 [ 当前等级的经验值上限 - 1 ] 的值<br>
	-- 不要使用此接口来减少经验值 , 降低经验值请使用 AddAdventureExp 接口<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- levelCount      = 等级数量 , 虽然可以是负数 , 但是会被当作 0 处理
	-- ======================================================================
	-- 返回值 = 实际提升的等级<br>
	-- ======================================================================
	SetAdventureLevel = function( playerIndex , levelCount )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local level = math.max( levelCount , 0 )
		local pointCount = SIRPGSystem.CalculateAdventurePoint( settings.EXP.AdventureLevel , levelCount - settings.EXP.AdventureLevel )
		if pointCount < 0 then
			local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
			for propertyID , value in pairs( settings.Property.Adventure ) do
				local oldActive = settings.Property.Active[propertyID]
				settings.Property.Adventure[propertyID] = 0
				settings.Property.Max[propertyID] = settings.Property.Max[propertyID] - value
				settings.Property.Active[propertyID] = math.min( settings.Property.Active[propertyID] , settings.Property.Max[propertyID] )
				SIRPGSystem.FreshPropertyEffect( settings , globalSettings , propertyID , oldActive )
			end
			for additionID , value in pairs( settings.Addition.Adventure ) do
				local oldActive = settings.Addition.Active[additionID]
				settings.Addition.Adventure[additionID] = 0
				settings.Addition.Max[additionID] = settings.Addition.Max[additionID] - value
				settings.Addition.Active[additionID] = math.min( settings.Addition.Active[additionID] , settings.Addition.Max[additionID] )
				SIRPGSystem.FreshAdditionEffect( settings , globalSettings , additionID , oldActive )
			end
			for skillType , skillDataList in pairs( settings.SkillList ) do
				for skillID , skillData in pairs( skillDataList ) do
					skillData.Level.Adventure.Max = 0
					skillData.Level.Adventure.Active = 0
				end
			end
			settings.Points.Max.Adventure = math.max( settings.Points.Max.Adventure + pointCount , 0 )
			settings.Points.Current.Adventure = settings.Points.Max.Adventure
			if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
				SIRPGPlayerStatus.FreshValue( settings )
				SIRPGPlayerStatus.FreshProperty( settings , globalSettings )
				SIRPGPlayerStatus.FreshAddition( settings , globalSettings )
			end
			if settings.PlayerInfo.frame and settings.PlayerInfo.frame.valid then
				SIRPGPlayerInfo.FreshValue( settings )
			end
			if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
				SIRPGPlayerSkill.FreshSkill( settings )
			end
		else
			settings.Points.Max.Adventure = settings.Points.Max.Adventure + pointCount
			settings.Points.Current.Adventure = settings.Points.Current.Adventure + pointCount
		end
		settings.EXP.AdventureLevel = level
		local hasUnlock = SIRPGSystem.CheckLockSkillList( settings )
		if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
			SIRPGPlayerStatus.FreshLevel( settings )
			SIRPGPlayerStatus.FreshPoint( settings )
		end
		if settings.PlayerStatusMini.frame and settings.PlayerStatusMini.frame.valid then
			SIRPGPlayerStatusMini.FreshLevel( settings )
		end
		if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
			SIRPGPlayerSkill.FreshPoint( settings )
			if hasUnlock then
				-- 如果扣等级的话 , 那么这段代码在理论上不会进入
				SIRPGPlayerSkill.FreshSkill( settings )
			end
		end
		return levelCount - settings.EXP.AdventureLevel
	end ,

	-- ======================================================================
	-- 获取玩家的当前探索经验等级<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- ======================================================================
	-- 返回值 = 当前的探索经验等级<br>
	-- ======================================================================
	GetAdventureLevel = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		return settings.EXP.AdventureLevel
	end ,

	-- ======================================================================
	-- 增加玩家的生存经验等级<br>
	-- 最终计算后的等级不可以是负数 , 升级后会根据设置获得或扣除 [ 阅历点数 ]<br>
	-- 如果等级减少了 , 那么会重置所有的 [ 阅历点数 ] 的分配<br>
	-- 如果升级后经验值超过了当前等级的经验值上限 , 那么会强制把经验值设置成 [ 当前等级的经验值上限 - 1 ] 的值<br>
	-- 不要使用此接口来减少经验值 , 降低经验值请使用 AddCraftExp 接口<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- levelCount      = 等级数量 , 可以是负数<br>
	-- ======================================================================
	-- 返回值 = 实际提升的等级<br>
	-- ======================================================================
	AddCraftLevel = function( playerIndex , levelCount )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local level = math.max( settings.EXP.CraftLevel + levelCount , 0 )
		local pointCount = SIRPGSystem.CalculateCraftPoint( settings.EXP.CraftLevel , levelCount )
		if pointCount < 0 then
			local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
			for propertyID , value in pairs( settings.Property.Craft ) do
				local oldActive = settings.Property.Active[propertyID]
				settings.Property.Craft[propertyID] = 0
				settings.Property.Max[propertyID] = settings.Property.Max[propertyID] - value
				settings.Property.Active[propertyID] = math.min( settings.Property.Active[propertyID] , settings.Property.Max[propertyID] )
				SIRPGSystem.FreshPropertyEffect( settings , globalSettings , propertyID , oldActive )
			end
			for additionID , value in pairs( settings.Addition.Craft ) do
				local oldActive = settings.Addition.Active[additionID]
				settings.Addition.Craft[additionID] = 0
				settings.Addition.Max[additionID] = settings.Addition.Max[additionID] - value
				settings.Addition.Active[additionID] = math.min( settings.Addition.Active[additionID] , settings.Addition.Max[additionID] )
				SIRPGSystem.FreshAdditionEffect( settings , globalSettings , additionID , oldActive )
			end
			for skillType , skillDataList in pairs( settings.SkillList ) do
				for skillID , skillData in pairs( skillDataList ) do
					skillData.Level.Craft.Max = 0
					skillData.Level.Craft.Active = 0
				end
			end
			settings.Points.Max.Craft = math.max( settings.Points.Max.Craft + pointCount , 0 )
			settings.Points.Current.Craft = settings.Points.Max.Craft
			if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
				SIRPGPlayerStatus.FreshValue( settings )
				SIRPGPlayerStatus.FreshProperty( settings , globalSettings )
				SIRPGPlayerStatus.FreshAddition( settings , globalSettings )
			end
			if settings.PlayerInfo.frame and settings.PlayerInfo.frame.valid then
				SIRPGPlayerInfo.FreshValue( settings )
			end
			if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
				SIRPGPlayerSkill.FreshSkill( settings )
			end
		else
			settings.Points.Max.Craft = settings.Points.Max.Craft + pointCount
			settings.Points.Current.Craft = settings.Points.Current.Craft + pointCount
		end
		settings.EXP.CraftLevel = level
		local hasUnlock = SIRPGSystem.CheckLockSkillList( settings )
		if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
			SIRPGPlayerStatus.FreshLevel( settings )
			SIRPGPlayerStatus.FreshPoint( settings )
		end
		if settings.PlayerStatusMini.frame and settings.PlayerStatusMini.frame.valid then
			SIRPGPlayerStatusMini.FreshLevel( settings )
		end
		if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
			SIRPGPlayerSkill.FreshPoint( settings )
			if hasUnlock then
				-- 如果扣等级的话 , 那么这段代码在理论上不会进入
				SIRPGPlayerSkill.FreshSkill( settings )
			end
		end
		return levelCount
	end ,

	-- ======================================================================
	-- 设置玩家的生存经验等级<br>
	-- 最终计算后的等级不可以是负数 , 升级后会根据设置获得或扣除 [ 阅历点数 ]<br>
	-- 如果等级减少了 , 那么会重置所有的 [ 阅历点数 ] 的分配<br>
	-- 如果升级后经验值超过了当前等级的经验值上限 , 那么会强制把经验值设置成 [ 当前等级的经验值上限 - 1 ] 的值<br>
	-- 不要使用此接口来减少经验值 , 降低经验值请使用 AddCraftExp 接口<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- levelCount      = 等级数量 , 虽然可以是负数 , 但是会被当作 0 处理<br>
	-- ======================================================================
	-- 返回值 = 实际提升的等级<br>
	-- ======================================================================
	SetCraftLevel = function( playerIndex , levelCount )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local level = math.max( levelCount , 0 )
		local pointCount = SIRPGSystem.CalculateCraftPoint( settings.EXP.CraftLevel , levelCount - settings.EXP.CraftLevel )
		if pointCount < 0 then
			local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
			for propertyID , value in pairs( settings.Property.Craft ) do
				local oldActive = settings.Property.Active[propertyID]
				settings.Property.Craft[propertyID] = 0
				settings.Property.Max[propertyID] = settings.Property.Max[propertyID] - value
				settings.Property.Active[propertyID] = math.min( settings.Property.Active[propertyID] , settings.Property.Max[propertyID] )
				SIRPGSystem.FreshPropertyEffect( settings , globalSettings , propertyID , oldActive )
			end
			for additionID , value in pairs( settings.Addition.Craft ) do
				local oldActive = settings.Addition.Active[additionID]
				settings.Addition.Craft[additionID] = 0
				settings.Addition.Max[additionID] = settings.Addition.Max[additionID] - value
				settings.Addition.Active[additionID] = math.min( settings.Addition.Active[additionID] , settings.Addition.Max[additionID] )
				SIRPGSystem.FreshAdditionEffect( settings , globalSettings , additionID , oldActive )
			end
			for skillType , skillDataList in pairs( settings.SkillList ) do
				for skillID , skillData in pairs( skillDataList ) do
					skillData.Level.Craft.Max = 0
					skillData.Level.Craft.Active = 0
				end
			end
			settings.Points.Max.Craft = math.max( settings.Points.Max.Craft + pointCount , 0 )
			settings.Points.Current.Craft = settings.Points.Max.Craft
			if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
				SIRPGPlayerStatus.FreshValue( settings )
				SIRPGPlayerStatus.FreshProperty( settings , globalSettings )
				SIRPGPlayerStatus.FreshAddition( settings , globalSettings )
			end
			if settings.PlayerInfo.frame and settings.PlayerInfo.frame.valid then
				SIRPGPlayerInfo.FreshValue( settings )
			end
			if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
				SIRPGPlayerSkill.FreshSkill( settings )
			end
		else
			settings.Points.Max.Craft = settings.Points.Max.Craft + pointCount
			settings.Points.Current.Craft = settings.Points.Current.Craft + pointCount
		end
		settings.EXP.CraftLevel = level
		local hasUnlock = SIRPGSystem.CheckLockSkillList( settings )
		if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
			SIRPGPlayerStatus.FreshLevel( settings )
			SIRPGPlayerStatus.FreshPoint( settings )
		end
		if settings.PlayerStatusMini.frame and settings.PlayerStatusMini.frame.valid then
			SIRPGPlayerStatusMini.FreshLevel( settings )
		end
		if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
			SIRPGPlayerSkill.FreshPoint( settings )
			if hasUnlock then
				-- 如果扣等级的话 , 那么这段代码在理论上不会进入
				SIRPGPlayerSkill.FreshSkill( settings )
			end
		end
		return levelCount - settings.EXP.CraftLevel
	end ,

	-- ======================================================================
	-- 获取玩家的当前生存经验等级<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- ======================================================================
	-- 返回值 = 当前的生存经验等级<br>
	-- ======================================================================
	GetCraftLevel = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		return settings.EXP.CraftLevel
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 接口函数 - 调整点数 =============================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================
	-- 使用 [ 纷争点数 ] 增加属性<br>
	-- 可用的点数不足时 , 不会产生任何变化<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- propertyID      = 增加的属性的 ID<br>
	-- count           = 增加的数量 , 可以是负数 , 负数表示逆向操作<br>
	-- ======================================================================
	UseAttackPointToProperty = function( playerIndex , propertyID , count )
		if not SITable.Has( SIRPGSystem.PropertyIDs , propertyID ) or count == 0 then
			return
		end
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		if count > 0 then
			if settings.Points.Current.Attack < count then
				return
			end
			settings.Points.Current.Attack = settings.Points.Current.Attack - count
			local max = settings.Property.Max[propertyID]
			local oldActive = settings.Property.Active[propertyID]
			settings.Property.Attack[propertyID] = settings.Property.Attack[propertyID] + count
			settings.Property.Max[propertyID] = max + count
			if oldActive == max then
				settings.Property.Active[propertyID] = max + count
				SIRPGSystem.FreshPropertyEffect( settings , globalSettings , propertyID , oldActive )
			end
		else
			if settings.Property.Attack[propertyID] < count then
				return
			end
			settings.Points.Current.Attack = settings.Points.Current.Attack + count
			local max = settings.Property.Max[propertyID] - count
			local oldActive = settings.Property.Active[propertyID]
			settings.Property.Attack[propertyID] = settings.Property.Attack[propertyID] - count
			settings.Property.Max[propertyID] = max
			if oldActive > max then
				settings.Property.Active[propertyID] = max
				SIRPGSystem.FreshPropertyEffect( settings , globalSettings , propertyID , oldActive )
			end
		end
		local hasUnlock = SIRPGSystem.CheckLockSkillList( settings )
		if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
			SIRPGPlayerStatus.FreshPoint( settings )
			SIRPGPlayerStatus.FreshPropertyLine( settings , globalSettings , propertyID )
			for valueID , valueCount in pairs( globalSettings.Setting.PropertyEffects[propertyID] ) do
				SIRPGPlayerStatus.FreshValueLine( settings , valueID )
			end
		end
		if settings.PlayerInfo.frame and settings.PlayerInfo.frame.valid then
			for valueID , valueCount in pairs( globalSettings.Setting.PropertyEffects[propertyID] ) do
				SIRPGPlayerInfo.FreshValueLine( settings , valueID )
			end
		end
		if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
			SIRPGPlayerSkill.FreshPoint( settings )
			if hasUnlock then
				SIRPGPlayerSkill.FreshSkill( settings )
			end
		end
	end ,

	-- ======================================================================
	-- 使用 [ 纷争点数 ] 增加加成<br>
	-- 可用的点数不足时 , 不会产生任何变化<br>
	-- 当玩家没有 character 时 , 不可以使用此函数<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- additionID      = 增加的加成的 ID<br>
	-- count           = 增加的数量 , 可以是负数 , 负数表示逆向操作<br>
	-- ======================================================================
	UseAttackPointToAddition = function( playerIndex , additionID , count )
		if not SITable.Has( SIRPGSystem.AdditionIDs , additionID ) or count == 0 then
			return
		end
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		if count > 0 then
			if settings.Points.Current.Attack < count then
				return
			end
			settings.Points.Current.Attack = settings.Points.Current.Attack - count
			local max = settings.Addition.Max[additionID]
			local oldActive = settings.Addition.Active[additionID]
			settings.Addition.Attack[additionID] = settings.Addition.Attack[additionID] + count
			settings.Addition.Max[additionID] = max + count
			if oldActive == max then
				settings.Addition.Active[additionID] = max + count
				SIRPGSystem.FreshAdditionEffect( settings , globalSettings , additionID , oldActive )
			end
		else
			if settings.Addition.Attack[additionID] < count then
				return
			end
			settings.Points.Current.Attack = settings.Points.Current.Attack + count
			local max = settings.Addition.Max[additionID] - count
			local oldActive = settings.Addition.Active[additionID]
			settings.Addition.Attack[additionID] = settings.Addition.Attack[additionID] - count
			settings.Addition.Max[additionID] = max
			if oldActive > max then
				settings.Addition.Active[additionID] = max
				SIRPGSystem.FreshAdditionEffect( settings , globalSettings , additionID , oldActive )
			end
		end
		local hasUnlock = SIRPGSystem.CheckLockSkillList( settings )
		if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
			SIRPGPlayerStatus.FreshPoint( settings )
			SIRPGPlayerStatus.FreshAdditionLine( settings , globalSettings , additionID )
		end
		if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
			SIRPGPlayerSkill.FreshPoint( settings )
			if hasUnlock then
				SIRPGPlayerSkill.FreshSkill( settings )
			end
		end
	end ,

	-- ======================================================================
	-- 使用 [ 纷争点数 ] 增加技能<br>
	-- 可用的点数不足时 , 不会产生任何变化<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- skillID         = 技能的 ID<br>
	-- count           = 增加的数量 , 可以是负数 , 负数表示逆向操作<br>
	-- ======================================================================
	UseAttackPointToSkill = function( playerIndex , skillID , count )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		local globalSkillData = globalSettings.SkillList[skillID]
		if not globalSkillData then
			return
		end
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local playerSkillData = settings.SkillList[skillID]
		if not playerSkillData.Unlock then
			return
		end
		if count > 0 then
			if settings.Points.Current.Attack < count then
				return
			end
			local max = playerSkillData.Level.Attack.Max
			if globalSkillData.Attack.Max then
				count = math.min( count , globalSkillData.Attack.Max - playerSkillData.Level.Attack.Max )
			end
			settings.Points.Current.Attack = settings.Points.Current.Attack - count
			playerSkillData.Level.Attack.Max = max + count
			if playerSkillData.Level.Attack.Active == max then
				playerSkillData.Level.Attack.Active = max + count
				if globalSkillData.IsPassive then
					SIRPGSystem.FireSkillInterface( playerIndex , globalSkillData , playerSkillData , false )
				end
			end
		else
			if playerSkillData.Level.Attack.Max < count then
				return
			end
			settings.Points.Current.Attack = settings.Points.Current.Attack + count
			local max = playerSkillData.Level.Attack.Max - count
			playerSkillData.Level.Attack.Max = max
			if playerSkillData.Level.Attack.Active > max then
				playerSkillData.Level.Attack.Active = max
				if globalSkillData.IsPassive then
					SIRPGSystem.FireSkillInterface( playerIndex , globalSkillData , playerSkillData , false )
				end
			end
		end
		if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
			SIRPGPlayerStatus.FreshPoint( settings )
		end
		if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
			SIRPGPlayerSkill.FreshPoint( settings )
			SIRPGPlayerSkill.FreshSkillLine( settings , globalSettings , skillID )
		end
	end ,

	-- ======================================================================
	-- 使用 [ 奇迹点数 ] 增加属性<br>
	-- 可用的点数不足时 , 不会产生任何变化<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- propertyID      = 增加的属性的 ID<br>
	-- count           = 增加的数量 , 可以是负数 , 负数表示逆向操作<br>
	-- ======================================================================
	UseAdventurePointToProperty = function( playerIndex , propertyID , count )
		if not SITable.Has( SIRPGSystem.PropertyIDs , propertyID ) or count == 0 then
			return
		end
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		if count > 0 then
			if settings.Points.Current.Adventure < count then
				return
			end
			settings.Points.Current.Adventure = settings.Points.Current.Adventure - count
			local max = settings.Property.Max[propertyID]
			local oldActive = settings.Property.Active[propertyID]
			settings.Property.Adventure[propertyID] = settings.Property.Adventure[propertyID] + count
			settings.Property.Max[propertyID] = max + count
			if oldActive == max then
				settings.Property.Active[propertyID] = max + count
				SIRPGSystem.FreshPropertyEffect( settings , globalSettings , propertyID , oldActive )
			end
		else
			if settings.Property.Adventure[propertyID] < count then
				return
			end
			settings.Points.Current.Adventure = settings.Points.Current.Adventure + count
			local max = settings.Property.Max[propertyID] - count
			local oldActive = settings.Property.Active[propertyID]
			settings.Property.Adventure[propertyID] = settings.Property.Adventure[propertyID] - count
			settings.Property.Max[propertyID] = max
			if oldActive > max then
				settings.Property.Active[propertyID] = max
				SIRPGSystem.FreshPropertyEffect( settings , globalSettings , propertyID , oldActive )
			end
		end
		local hasUnlock = SIRPGSystem.CheckLockSkillList( settings )
		if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
			SIRPGPlayerStatus.FreshPoint( settings )
			SIRPGPlayerStatus.FreshPropertyLine( settings , globalSettings , propertyID )
			for valueID , valueCount in pairs( globalSettings.Setting.PropertyEffects[propertyID] ) do
				SIRPGPlayerStatus.FreshValueLine( settings , valueID )
			end
		end
		if settings.PlayerInfo.frame and settings.PlayerInfo.frame.valid then
			for valueID , valueCount in pairs( globalSettings.Setting.PropertyEffects[propertyID] ) do
				SIRPGPlayerInfo.FreshValueLine( settings , valueID )
			end
		end
		if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
			SIRPGPlayerSkill.FreshPoint( settings )
			if hasUnlock then
				SIRPGPlayerSkill.FreshSkill( settings )
			end
		end
	end ,

	-- ======================================================================
	-- 使用 [ 奇迹点数 ] 增加加成<br>
	-- 可用的点数不足时 , 不会产生任何变化<br>
	-- 当玩家没有 character 时 , 不可以使用此函数<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- additionID      = 增加的加成的 ID<br>
	-- count           = 增加的数量 , 可以是负数 , 负数表示逆向操作<br>
	-- ======================================================================
	UseAdventurePointToAddition = function( playerIndex , additionID , count )
		if not SITable.Has( SIRPGSystem.AdditionIDs , additionID ) or count == 0 then
			return
		end
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		if count > 0 then
			if settings.Points.Current.Adventure < count then
				return
			end
			settings.Points.Current.Adventure = settings.Points.Current.Adventure - count
			local max = settings.Addition.Max[additionID]
			local oldActive = settings.Addition.Active[additionID]
			settings.Addition.Adventure[additionID] = settings.Addition.Adventure[additionID] + count
			settings.Addition.Max[additionID] = max + count
			if oldActive == max then
				settings.Addition.Active[additionID] = max + count
				SIRPGSystem.FreshAdditionEffect( settings , globalSettings , additionID , oldActive )
			end
		else
			if settings.Addition.Adventure[additionID] < count then
				return
			end
			settings.Points.Current.Adventure = settings.Points.Current.Adventure + count
			local max = settings.Addition.Max[additionID] - count
			local oldActive = settings.Addition.Active[additionID]
			settings.Addition.Adventure[additionID] = settings.Addition.Adventure[additionID] - count
			settings.Addition.Max[additionID] = max
			if oldActive > max then
				settings.Addition.Active[additionID] = max
				SIRPGSystem.FreshAdditionEffect( settings , globalSettings , additionID , oldActive )
			end
		end
		local hasUnlock = SIRPGSystem.CheckLockSkillList( settings )
		if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
			SIRPGPlayerStatus.FreshPoint( settings )
			SIRPGPlayerStatus.FreshAdditionLine( settings , globalSettings , additionID )
		end
		if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
			SIRPGPlayerSkill.FreshPoint( settings )
			if hasUnlock then
				SIRPGPlayerSkill.FreshSkill( settings )
			end
		end
	end ,

	-- ======================================================================
	-- 使用 [ 奇迹点数 ] 增加技能<br>
	-- 可用的点数不足时 , 不会产生任何变化<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- skillID         = 技能的 ID<br>
	-- count           = 增加的数量 , 可以是负数 , 负数表示逆向操作<br>
	-- ======================================================================
	UseAdventurePointToSkill = function( playerIndex , skillID , count )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		local globalSkillData = globalSettings.SkillList[skillID]
		if not globalSkillData then
			return
		end
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local playerSkillData = settings.SkillList[skillID]
		if not playerSkillData.Unlock then
			return
		end
		if count > 0 then
			if settings.Points.Current.Adventure < count then
				return
			end
			local max = playerSkillData.Level.Adventure.Max
			if globalSkillData.Adventure.Max then
				count = math.min( count , globalSkillData.Adventure.Max - playerSkillData.Level.Adventure.Max )
			end
			settings.Points.Current.Adventure = settings.Points.Current.Adventure - count
			playerSkillData.Level.Adventure.Max = max + count
			if playerSkillData.Level.Adventure.Active == max then
				playerSkillData.Level.Adventure.Active = max + count
				if globalSkillData.IsPassive then
					SIRPGSystem.FireSkillInterface( playerIndex , globalSkillData , playerSkillData , false )
				end
			end
		else
			if playerSkillData.Level.Adventure.Max < count then
				return
			end
			settings.Points.Current.Adventure = settings.Points.Current.Adventure + count
			local max = playerSkillData.Level.Adventure.Max - count
			playerSkillData.Level.Adventure.Max = max
			if playerSkillData.Level.Adventure.Active > max then
				playerSkillData.Level.Adventure.Active = max
				if globalSkillData.IsPassive then
					SIRPGSystem.FireSkillInterface( playerIndex , globalSkillData , playerSkillData , false )
				end
			end
		end
		if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
			SIRPGPlayerStatus.FreshPoint( settings )
		end
		if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
			SIRPGPlayerSkill.FreshPoint( settings )
			SIRPGPlayerSkill.FreshSkillLine( settings , globalSettings , skillID )
		end
	end ,

	-- ======================================================================
	-- 使用 [ 阅历点数 ] 增加属性<br>
	-- 可用的点数不足时 , 不会产生任何变化<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- propertyID      = 增加的属性的 ID<br>
	-- count           = 增加的数量 , 可以是负数 , 负数表示逆向操作<br>
	-- ======================================================================
	UseCraftPointToProperty = function( playerIndex , propertyID , count )
		if not SITable.Has( SIRPGSystem.PropertyIDs , propertyID ) or count == 0 then
			return
		end
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		if count > 0 then
			if settings.Points.Current.Craft < count then
				return
			end
			settings.Points.Current.Craft = settings.Points.Current.Craft - count
			local max = settings.Property.Max[propertyID]
			local oldActive = settings.Property.Active[propertyID]
			settings.Property.Craft[propertyID] = settings.Property.Craft[propertyID] + count
			settings.Property.Max[propertyID] = max + count
			if oldActive == max then
				settings.Property.Active[propertyID] = max + count
				SIRPGSystem.FreshPropertyEffect( settings , globalSettings , propertyID , oldActive )
			end
		else
			if settings.Property.Craft[propertyID] < count then
				return
			end
			settings.Points.Current.Craft = settings.Points.Current.Craft + count
			local max = settings.Property.Max[propertyID] - count
			local oldActive = settings.Property.Active[propertyID]
			settings.Property.Craft[propertyID] = settings.Property.Craft[propertyID] - count
			settings.Property.Max[propertyID] = max
			if oldActive > max then
				settings.Property.Active[propertyID] = max
				SIRPGSystem.FreshPropertyEffect( settings , globalSettings , propertyID , oldActive )
			end
		end
		local hasUnlock = SIRPGSystem.CheckLockSkillList( settings )
		if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
			SIRPGPlayerStatus.FreshPoint( settings )
			SIRPGPlayerStatus.FreshPropertyLine( settings , globalSettings , propertyID )
			for valueID , valueCount in pairs( globalSettings.Setting.PropertyEffects[propertyID] ) do
				SIRPGPlayerStatus.FreshValueLine( settings , valueID )
			end
		end
		if settings.PlayerInfo.frame and settings.PlayerInfo.frame.valid then
			for valueID , valueCount in pairs( globalSettings.Setting.PropertyEffects[propertyID] ) do
				SIRPGPlayerInfo.FreshValueLine( settings , valueID )
			end
		end
		if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
			SIRPGPlayerSkill.FreshPoint( settings )
			if hasUnlock then
				SIRPGPlayerSkill.FreshSkill( settings )
			end
		end
	end ,

	-- ======================================================================
	-- 使用 [ 阅历点数 ] 增加加成<br>
	-- 可用的点数不足时 , 不会产生任何变化<br>
	-- 当玩家没有 character 时 , 不可以使用此函数<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- additionID      = 增加的加成的 ID<br>
	-- count           = 增加的数量 , 可以是负数 , 负数表示逆向操作<br>
	-- ======================================================================
	UseCraftPointToAddition= function( playerIndex , additionID , count )
		if not SITable.Has( SIRPGSystem.AdditionIDs , additionID ) or count == 0 then
			return
		end
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		if count > 0 then
			if settings.Points.Current.Craft < count then
				return
			end
			settings.Points.Current.Craft = settings.Points.Current.Craft - count
			local max = settings.Addition.Max[additionID]
			local oldActive = settings.Addition.Active[additionID]
			settings.Addition.Craft[additionID] = settings.Addition.Craft[additionID] + count
			settings.Addition.Max[additionID] = max + count
			if oldActive == max then
				settings.Addition.Active[additionID] = max + count
				SIRPGSystem.FreshAdditionEffect( settings , globalSettings , additionID , oldActive )
			end
		else
			if settings.Addition.Craft[additionID] < count then
				return
			end
			settings.Points.Current.Craft = settings.Points.Current.Craft + count
			local max = settings.Addition.Max[additionID] - count
			local oldActive = settings.Addition.Active[additionID]
			settings.Addition.Craft[additionID] = settings.Addition.Craft[additionID] - count
			settings.Addition.Max[additionID] = max
			if oldActive > max then
				settings.Addition.Active[additionID] = max
				SIRPGSystem.FreshAdditionEffect( settings , globalSettings , additionID , oldActive )
			end
		end
		local hasUnlock = SIRPGSystem.CheckLockSkillList( settings )
		if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
			SIRPGPlayerStatus.FreshPoint( settings )
			SIRPGPlayerStatus.FreshAdditionLine( settings , globalSettings , additionID )
		end
		if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
			SIRPGPlayerSkill.FreshPoint( settings )
			if hasUnlock then
				SIRPGPlayerSkill.FreshSkill( settings )
			end
		end
	end ,

	-- ======================================================================
	-- 使用 [ 阅历点数 ] 增加技能<br>
	-- 可用的点数不足时 , 不会产生任何变化<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- skillID         = 技能的 ID<br>
	-- count           = 增加的数量 , 可以是负数 , 负数表示逆向操作<br>
	-- ======================================================================
	UseCraftPointToSkill = function( playerIndex , skillID , count )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		local globalSkillData = globalSettings.SkillList[skillID]
		if not globalSkillData then
			return
		end
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local playerSkillData = settings.SkillList[skillID]
		if not playerSkillData.Unlock then
			return
		end
		if count > 0 then
			if settings.Points.Current.Craft < count then
				return
			end
			local max = playerSkillData.Level.Craft.Max
			if globalSkillData.Craft.Max then
				count = math.min( count , globalSkillData.Craft.Max - playerSkillData.Level.Craft.Max )
			end
			settings.Points.Current.Craft = settings.Points.Current.Craft - count
			playerSkillData.Level.Craft.Max = max + count
			if playerSkillData.Level.Craft.Active == max then
				playerSkillData.Level.Craft.Active = max + count
				if globalSkillData.IsPassive then
					SIRPGSystem.FireSkillInterface( playerIndex , globalSkillData , playerSkillData , false )
				end
			end
		else
			if playerSkillData.Level.Craft.Max < count then
				return
			end
			settings.Points.Current.Craft = settings.Points.Current.Craft + count
			local max = playerSkillData.Level.Craft.Max - count
			playerSkillData.Level.Craft.Max = max
			if playerSkillData.Level.Craft.Active > max then
				playerSkillData.Level.Craft.Active = max
				if globalSkillData.IsPassive then
					SIRPGSystem.FireSkillInterface( playerIndex , globalSkillData , playerSkillData , false )
				end
			end
		end
		if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
			SIRPGPlayerStatus.FreshPoint( settings )
		end
		if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
			SIRPGPlayerSkill.FreshPoint( settings )
			SIRPGPlayerSkill.FreshSkillLine( settings , globalSettings , skillID )
		end
	end ,

	-- ======================================================================
	-- 根据等级重新计算点数<br>
	-- 若新计算后的点数比原来的少 , 则会强制洗点<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- ======================================================================
	FreshPoints = function( playerIndex )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local maxAttack = SIRPGSystem.CalculateAttackPoint( 0 , settings.EXP.AttackLevel )
		local maxAdventure = SIRPGSystem.CalculateAdventurePoint( 0 , settings.EXP.AdventureLevel )
		local maxCraft = SIRPGSystem.CalculateCraftPoint( 0 , settings.EXP.CraftLevel )
		if maxAttack < settings.Points.Max.Attack or maxAdventure < settings.Points.Max.Adventure or maxCraft < settings.Points.Max.Craft then
			SIRPGSystem.ClearPoints( playerIndex )
		else
			local maxAttackOld = settings.Points.Max.Attack
			local maxAdventureOld = settings.Points.Max.Adventure
			local maxCraftOld = settings.Points.Max.Craft
			settings.Points.Max.Attack = maxAttack
			settings.Points.Max.Adventure = maxAdventure
			settings.Points.Max.Craft = maxCraft
			settings.Points.Current.Attack = settings.Points.Max.Attack - maxAttackOld + settings.Points.Current.Attack
			settings.Points.Current.Adventure = settings.Points.Max.Adventure - maxAdventureOld + settings.Points.Current.Adventure
			settings.Points.Current.Craft = settings.Points.Max.Craft - maxCraftOld + settings.Points.Current.Craft
			local hasUnlock = SIRPGSystem.CheckLockSkillList( settings )
			if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
				SIRPGPlayerStatus.FreshPoint( settings )
			end
			if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
				SIRPGPlayerSkill.FreshPoint( settings )
				if hasUnlock then
					SIRPGPlayerSkill.FreshSkill( settings )
				end
			end
		end
	end ,

	-- ======================================================================
	-- 清空所有点数分配<br>
	-- 之后根据等级重新计算点数<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- ======================================================================
	ClearPoints = function( playerIndex )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local canClear = true
		for additionID , value in pairs( settings.Addition.Max ) do
			canClear = canClear and SIRPGSystem.CanFreshAdditionEffect( settings , globalSettings , additionID , 0 , settings.Addition.Active[additionID] )
			if not canClear then
				SIPrint.Log{ "SIRPGSystem.警告-加成丢失" }
				SIPrint.Alert( playerIndex , { "SIRPGSystem.警告-加成丢失" } )
				return
			end
		end
		for propertyID , value in pairs( settings.Property.Max ) do
			local oldActive = settings.Property.Active[propertyID]
			settings.Property.Attack[propertyID] = 0
			settings.Property.Adventure[propertyID] = 0
			settings.Property.Craft[propertyID] = 0
			settings.Property.Max[propertyID] = 0
			settings.Property.Active[propertyID] = 0
			SIRPGSystem.FreshPropertyEffect( settings , globalSettings , propertyID , oldActive )
		end
		for additionID , value in pairs( settings.Addition.Max ) do
			local oldActive = settings.Addition.Active[additionID]
			settings.Addition.Attack[additionID] = 0
			settings.Addition.Adventure[additionID] = 0
			settings.Addition.Craft[additionID] = 0
			settings.Addition.Max[additionID] = 0
			settings.Addition.Active[additionID] = 0
			SIRPGSystem.FreshAdditionEffect( settings , globalSettings , additionID , oldActive )
		end
		for skillType , skillDataList in pairs( settings.SkillList ) do
			for skillID , skillData in pairs( skillDataList ) do
				skillData.Level.Attack.Max = 0
				skillData.Level.Attack.Active = 0
				skillData.Level.Adventure.Max = 0
				skillData.Level.Adventure.Active = 0
				skillData.Level.Craft.Max = 0
				skillData.Level.Craft.Active = 0
			end
		end
		settings.Points.Max.Attack = SIRPGSystem.CalculateAttackPoint( 0 , settings.EXP.AttackLevel )
		settings.Points.Max.Adventure = SIRPGSystem.CalculateAdventurePoint( 0 , settings.EXP.AdventureLevel )
		settings.Points.Max.Craft = SIRPGSystem.CalculateCraftPoint( 0 , settings.EXP.CraftLevel )
		settings.Points.Current.Attack = settings.Points.Max.Attack
		settings.Points.Current.Adventure = settings.Points.Max.Adventure
		settings.Points.Current.Craft = settings.Points.Max.Craft
		local hasUnlock = SIRPGSystem.CheckLockSkillList( settings )
		if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
			SIRPGPlayerStatus.FreshPoint( settings )
			SIRPGPlayerStatus.FreshValue( settings )
			SIRPGPlayerStatus.FreshProperty( settings , globalSettings )
			SIRPGPlayerStatus.FreshAddition( settings , globalSettings )
		end
		if settings.PlayerInfo.frame and settings.PlayerInfo.frame.valid then
			SIRPGPlayerInfo.FreshValue( settings )
		end
		if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
			SIRPGPlayerSkill.FreshPoint( settings )
			SIRPGPlayerSkill.FreshSkill( settings )
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 接口函数 - 技能管理 =============================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================
	-- 注册一个新的技能 , 同 ID 的技能先入为主<br>
	-- 每个技能只需要注册一次即可<br>
	-- 重新载入时不需要在 on_load 中重新注册<br>
	-- 这就导致即使玩家卸载了注册技能的那个 MOD , 他依然可以在技能列表中看到这个技能<br>
	-- ======================================================================
	-- skillData       = 技能数据 , 具体结构请见 SIRPGSkillData 中的元素<br>
	-- ======================================================================
	AddSkill = function( skillData )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		local skillID = skillData.ID
		if globalSettings.SkillList[skillID] then
			return
		end
		local skillType = skillData.Type
		local list = globalSettings.SkillOrderList[skillType]
		if not list then
			list = {}
			globalSettings.SkillOrderList[skillType] = list
			table.insert( globalSettings.SkillTypeOrderList , skillType )
			table.sort( globalSettings.SkillTypeOrderList , function( a , b )
				return a < b
			end )
		end
		globalSettings.SkillList[skillID] = skillData
		table.insert( list , skillData )
		table.sort( list , function( a , b )
			return a.Order < b.Order
		end )
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIRPGSystem.Settings.Name ) ) do
			local playerSkillData = SIUtils.table.deepcopy( SIRPGSystem.PlayerSkillDataDefault )
			playerSkillData.Unlock = skillData.Unlock == nil
			if skillData.DefaultCustomData then
				playerSkillData.CustomData = SIUtils.table.deepcopy( skillData.DefaultCustomData )
			end
			settings.SkillList[skillID] = playerSkillData
			if not playerSkillData.Unlock then
				SIRPGSystem.CheckLockSkill( settings , skillID )
			end
			if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
				SIRPGPlayerSkill.FreshSkillType( settings , globalSettings , skillType )
			end
		end
	end ,

	-- ======================================================================
	-- 注册一堆新的技能 , 同 ID 的技能先入为主<br>
	-- 每个技能只需要注册一次即可<br>
	-- 重新载入时不需要在 on_load 中重新注册<br>
	-- 这就导致即使玩家卸载了注册技能的那个 MOD , 他依然可以在技能列表中看到这个技能<br>
	-- ======================================================================
	-- skillDataList   = 技能数据数组 , 每个元素都是 skillData , 具体结构请见 SIRPGSkillData 中的元素<br>
	-- ======================================================================
	AddSkills = function( skillDataList )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		local skills = {}
		for index , skillData in pairs( skillDataList ) do
			local skillID = skillData.ID
			if not globalSettings.SkillList[skillID] then
				globalSettings.SkillList[skillID] = skillData
				table.insert( skills , skillData )
			end
		end
		local lists = {}
		for index , skillData in pairs( skills ) do
			local skillType = skillData.Type
			local list = globalSettings.SkillOrderList[skillType]
			if not list then
				list = {}
				globalSettings.SkillOrderList[skillType] = list
				table.insert( globalSettings.SkillTypeOrderList , skillType )
				table.sort( globalSettings.SkillTypeOrderList , function( a , b )
					return a < b
				end )
			end
			table.insert( list , skillData )
			lists[skillType] = list
		end
		for skillType , list in pairs( lists ) do
			table.sort( list , function( a , b )
				return a.Order < b.Order
			end )
		end
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIRPGSystem.Settings.Name ) ) do
			for index , skillData in pairs( skills ) do
				local playerSkillData = SIUtils.table.deepcopy( SIRPGSystem.PlayerSkillDataDefault )
				playerSkillData.Unlock = skillData.Unlock == nil
				if skillData.DefaultCustomData then
					playerSkillData.CustomData = SIUtils.table.deepcopy( skillData.DefaultCustomData )
				end
				settings.SkillList[skillData.ID] = playerSkillData
				if not playerSkillData.Unlock then
					SIRPGSystem.CheckLockSkill( settings , skillData.ID )
				end
			end
			if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
				SIRPGPlayerSkill.FreshSkill( settings )
			end
		end
	end ,

	-- ======================================================================
	-- 更新一个技能 , 如果技能没有注册 , 则没有效果<br>
	-- ======================================================================
	-- skillData       = 技能数据 , 具体结构请见 SIRPGSkillData 中的元素<br>
	-- ======================================================================
	FreshSkill = function( skillData )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		local skillID = skillData.ID
		if not globalSettings.SkillList[skillID] then
			return
		end
		local oldList = globalSettings.SkillOrderList[globalSettings.SkillList[skillID].Type]
		local currentSkillData , index = SITable.GetWithID( oldList , skillID )
		table.remove( oldList , index )
		local skillType = skillData.Type
		local newList = globalSettings.SkillOrderList[skillType]
		if newList then
			table.insert( newList , skillData )
			table.sort( newList , function( a , b )
				return a.Order < b.Order
			end )
		else
			newList = { skillData }
			globalSettings.SkillOrderList[skillType] = newList
			table.insert( globalSettings.SkillTypeOrderList , skillType )
			table.sort( globalSettings.SkillTypeOrderList , function( a , b )
				return a < b
			end )
		end
		globalSettings.SkillList[skillID] = skillData
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIRPGSystem.Settings.Name ) ) do
			local playerSkillData = settings.SkillList[skillID]
			if not playerSkillData.Unlock then
				playerSkillData.Unlock = skillData.Unlock == nil
			end
			if skillData.DefaultCustomData and not playerSkillData.CustomData then
				playerSkillData.CustomData = SIUtils.table.deepcopy( skillData.DefaultCustomData )
			end
			if not playerSkillData.Unlock then
				SIRPGSystem.CheckLockSkill( settings , skillID )
			end
			if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
				SIRPGPlayerSkill.FreshSkill( settings )
			end
			if settings.PlayerSkillMini.frame and settings.PlayerSkillMini.frame.valid then
				SIRPGPlayerSkillMini.FreshSkill( settings )
			end
		end
	end ,

	-- ======================================================================
	-- 更新一堆技能 , 如果技能没有注册 , 则没有效果<br>
	-- ======================================================================
	-- skillDataList   = 技能数据数组 , 每个元素都是 skillData , 具体结构请见 SIRPGSkillData 中的元素<br>
	-- ======================================================================
	FreshSkills = function( skillDataList )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		local skills = {}
		for index , newSkillData in pairs( skillDataList ) do
			local skillID = newSkillData.ID
			local oldSkillData = globalSettings.SkillList[skillID]
			if oldSkillData then
				globalSettings.SkillList[skillID] = newSkillData
				skills[skillID] = { old = oldSkillData , new = newSkillData }
			end
		end
		local lists = {}
		for skillID , skillDataPair in pairs( skills ) do
			local oldList = globalSettings.SkillOrderList[skillDataPair.old.Type]
			local currentSkillData , index = SITable.GetWithID( oldList , skillID )
			table.remove( oldList , index )
			local skillData = skillDataPair.new
			local skillType = skillData.Type
			local newList = globalSettings.SkillOrderList[skillType]
			if newList then
				table.insert( newList , skillData )
				lists[skillType] = newList
			else
				newList = { skillData }
				globalSettings.SkillOrderList[skillType] = newList
				table.insert( globalSettings.SkillTypeOrderList , skillType )
				table.sort( globalSettings.SkillTypeOrderList , function( a , b )
					return a < b
				end )
			end
		end
		for skillType , newList in pairs( lists ) do
			table.sort( newList , function( a , b )
				return a.Order < b.Order
			end )
		end
		for playerIndex , settings in pairs( SIGlobal.GetAllPlayerSettings( SIRPGSystem.Settings.Name ) ) do
			for skillID , skillDataPair in pairs( skills ) do
				local skillData = skillDataPair.new
				local playerSkillData = settings.SkillList[skillID]
				if not playerSkillData.Unlock then
					playerSkillData.Unlock = skillData.Unlock == nil
				end
				if skillData.DefaultCustomData and not playerSkillData.CustomData then
					playerSkillData.CustomData = SIUtils.table.deepcopy( skillData.DefaultCustomData )
				end
				if not playerSkillData.Unlock then
					SIRPGSystem.CheckLockSkill( settings , skillData.ID )
				end
			end
			if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
				SIRPGPlayerSkill.FreshSkill( settings )
			end
			if settings.PlayerSkillMini.frame and settings.PlayerSkillMini.frame.valid then
				SIRPGPlayerSkillMini.FreshSkill( settings )
			end
		end
	end ,

	-- ======================================================================
	-- 查询是否存在一个技能<br>
	-- ======================================================================
	-- skillID         = 技能的名称<br>
	-- ======================================================================
	-- 返回值 = 是否存在 , true = 存在 , false = 不存在<br>
	-- ======================================================================
	HasSkill = function( skillID )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		return globalSettings.SkillList[skillID] ~= nil
	end ,

	-- ======================================================================
	-- 获取一个技能的全局数据和玩家数据<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- skillID         = 技能的名称<br>
	-- ======================================================================
	-- 返回值 1 = 技能的全局数据<br>
	-- 返回值 2 = 技能的玩家数据<br>
	-- ======================================================================
	GetPlayerSkillData = function( playerIndex , skillID )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		return globalSettings.SkillList[skillID] , settings.SkillList[skillID]
	end ,

	-- ======================================================================
	-- 保存一个技能的玩家数据<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- skillID         = 技能的名称<br>
	-- playerSkillData = 玩家的技能数据<br>
	-- ======================================================================
	SavePlayerSkillData = function( playerIndex , skillID , playerSkillData )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local currentPlayerSkillData = settings.SkillList[skillID]
		currentPlayerSkillData.Cooldown = math.max( playerSkillData.Cooldown , 0 )
		currentPlayerSkillData.CustomData = playerSkillData.CustomData
	end ,

	-- ======================================================================
	-- 无视条件强制解锁玩家的技能<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- skillID         = 技能的名称<br>
	-- ======================================================================
	UnlockSkill = function( playerIndex , skillID )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local playerSkillData = settings.SkillList[skillID]
		if playerSkillData then
			playerSkillData.Unlock = true
			if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
				SIRPGPlayerSkill.FreshSkill( settings )
			end
			if settings.PlayerSkillMini.frame and settings.PlayerSkillMini.frame.valid then
				SIRPGPlayerSkillMini.FreshSkill( settings )
			end
		end
	end ,

	-- ======================================================================
	-- 重新锁定玩家的技能<br>
	-- 如果玩家自身条件已经满足解锁条件的话 , 即使重新锁定 , 技能也会在下次属性改变时自动解锁 , 因此此函数只适用于特殊需求的情况<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- skillID         = 技能的名称<br>
	-- ======================================================================
	RelockSkill = function( playerIndex , skillID )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local playerSkillData = settings.SkillList[skillID]
		if playerSkillData then
			playerSkillData.Unlock = false
			if settings.PlayerSkill.frame and settings.PlayerSkill.frame.valid then
				SIRPGPlayerSkill.FreshSkill( settings )
			end
			if settings.PlayerSkillMini.frame and settings.PlayerSkillMini.frame.valid then
				SIRPGPlayerSkillMini.FreshSkill( settings )
			end
		end
	end ,

	-- ======================================================================
	-- 应用技能消耗 , 包括各种值和物品<br>
	-- 通过投掷物品的方式使用技能时会自动计算消耗 , 无需再使用此函数<br>
	-- ======================================================================
	-- playerIndex     = 玩家索引<br>
	-- skillID         = 技能的名称<br>
	-- ======================================================================
	-- 返回值 = 是否消耗成功 , true = 是 , false = 否<br>
	-- ======================================================================
	TakeSkillCost = function( playerIndex , skillID )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
		local globalSkillData = globalSettings.SkillList[skillID]
		if not globalSkillData.Cost then
			return true
		end
		-- 判断需求是否满足
		local current = settings.Value.Current
		if globalSkillData.Cost.Value then
			for valueID , valueCount in pairs( globalSkillData.Cost.Value ) do
				if current[valueID] and current[valueID] < valueCount then
					return false
				end
			end
		end
		local player = game.get_player( playerIndex )
		local inventory = player.get_main_inventory()
		if globalSkillData.Cost.Item then
			if not inventory or not inventory.valid then
				return false
			end
			for itemName , itemCount in pairs( globalSkillData.Cost.Item ) do
				if inventory.get_item_count( itemName ) < itemCount then
					return false
				end
			end
		end
		-- 扣除资源
		if globalSkillData.Cost.Value then
			for valueID , valueCount in pairs( globalSkillData.Cost.Value ) do
				if current[valueID] then
					current[valueID] = current[valueID] - valueCount
				end
			end
		end
		if globalSkillData.Cost.Item then
			for itemName , itemCount in pairs( globalSkillData.Cost.Item ) do
				inventory.remove{ name = itemName , count = itemCount }
			end
		end
		return true
	end ,
}

SIRPGSystem.PropertyNames =
{
	Power       = { "SIRPGSystem.属性-力量" } ,
	Body        = { "SIRPGSystem.属性-体质" } ,
	Strength    = { "SIRPGSystem.属性-韧性" } ,
	Will        = { "SIRPGSystem.属性-意志" } ,
	Attention   = { "SIRPGSystem.属性-专注" } ,
	Agility     = { "SIRPGSystem.属性-敏捷" } ,
	Wisdom      = { "SIRPGSystem.属性-智慧" } ,
	Spirit      = { "SIRPGSystem.属性-精神" } ,
	Temperament = { "SIRPGSystem.属性-气质" } ,
	Mystery     = { "SIRPGSystem.属性-神秘" } ,
	Constraint  = { "SIRPGSystem.属性-约束" } ,
	Luck        = { "SIRPGSystem.属性-幸运" }
}
SIRPGSystem.PropertyTooltips =
{
	Power       = { "SIRPGSystem.属性-力量-提示" } ,
	Body        = { "SIRPGSystem.属性-体质-提示" } ,
	Strength    = { "SIRPGSystem.属性-韧性-提示" } ,
	Will        = { "SIRPGSystem.属性-意志-提示" } ,
	Attention   = { "SIRPGSystem.属性-专注-提示" } ,
	Agility     = { "SIRPGSystem.属性-敏捷-提示" } ,
	Wisdom      = { "SIRPGSystem.属性-智慧-提示" } ,
	Spirit      = { "SIRPGSystem.属性-精神-提示" } ,
	Temperament = { "SIRPGSystem.属性-气质-提示" } ,
	Mystery     = { "SIRPGSystem.属性-神秘-提示" } ,
	Constraint  = { "SIRPGSystem.属性-约束-提示" } ,
	Luck        = { "SIRPGSystem.属性-幸运-提示" }
}
SIRPGSystem.AdditionNames =
{
	CraftSpeed       = { "SIRPGSystem.加成-手搓速度" } ,
	MiningSpeed      = { "SIRPGSystem.加成-挖掘速度" } ,
	MoveSpeed        = { "SIRPGSystem.加成-移动速度" } ,
	BuildDistance    = { "SIRPGSystem.加成-建造距离" } ,
	ReachDistance    = { "SIRPGSystem.加成-操作距离" } ,
	ResourceDistance = { "SIRPGSystem.加成-资源操作距离" } ,
	DropDistance     = { "SIRPGSystem.加成-丢弃距离" } ,
	PickDistance     = { "SIRPGSystem.加成-拾取物品距离" } ,
	LootDistance     = { "SIRPGSystem.加成-拾取战利品距离" } ,
	InventorySize    = { "SIRPGSystem.加成-背包容量" } ,
	MaxHealth        = { "SIRPGSystem.加成-最大生命值" }
}
SIRPGSystem.AdditionTooltips =
{
	CraftSpeed       = { "SIRPGSystem.加成-手搓速度-提示" } ,
	MiningSpeed      = { "SIRPGSystem.加成-挖掘速度-提示" } ,
	MoveSpeed        = { "SIRPGSystem.加成-移动速度-提示" } ,
	BuildDistance    = { "SIRPGSystem.加成-建造距离-提示" } ,
	ReachDistance    = { "SIRPGSystem.加成-操作距离-提示" } ,
	ResourceDistance = { "SIRPGSystem.加成-资源操作距离-提示" } ,
	DropDistance     = { "SIRPGSystem.加成-丢弃距离-提示" } ,
	PickDistance     = { "SIRPGSystem.加成-拾取物品距离-提示" } ,
	LootDistance     = { "SIRPGSystem.加成-拾取战利品距离-提示" } ,
	InventorySize    = { "SIRPGSystem.加成-背包容量-提示" , SIRPGSystem.InventoryMax } ,
	MaxHealth        = { "SIRPGSystem.加成-最大生命值-提示" }
}
SIRPGSystem.AdditionEffects =
{
	CraftSpeed       = "character_crafting_speed_modifier" ,
	MiningSpeed      = "character_mining_speed_modifier" ,
	MoveSpeed        = "character_running_speed_modifier" ,
	BuildDistance    = "character_build_distance_bonus" ,
	ReachDistance    = "character_reach_distance_bonus" ,
	ResourceDistance = "character_resource_reach_distance_bonus" ,
	DropDistance     = "character_item_drop_distance_bonus" ,
	PickDistance     = "character_item_pickup_distance_bonus" ,
	LootDistance     = "character_loot_pickup_distance_bonus" ,
	InventorySize    = "character_inventory_slots_bonus" ,
	MaxHealth        = "character_health_bonus"
}
SIRPGSystem.AdditionEffectsForce =
{
	CraftSpeed       = "manual_crafting_speed_modifier" ,
	MiningSpeed      = "manual_mining_speed_modifier" ,
	MoveSpeed        = "character_running_speed_modifier" ,
	BuildDistance    = "character_build_distance_bonus" ,
	ReachDistance    = "character_reach_distance_bonus" ,
	ResourceDistance = "character_resource_reach_distance_bonus" ,
	DropDistance     = "character_item_drop_distance_bonus" ,
	PickDistance     = "character_item_pickup_distance_bonus" ,
	LootDistance     = "character_loot_pickup_distance_bonus" ,
	InventorySize    = "character_inventory_slots_bonus" ,
	MaxHealth        = "character_health_bonus"
}
SIRPGSystem.AdditionEffectMessages =
{
	CraftSpeed       = "SIRPGSystem.玩家属性-加成-百分比" ,
	MiningSpeed      = "SIRPGSystem.玩家属性-加成-百分比" ,
	MoveSpeed        = "SIRPGSystem.玩家属性-加成-百分比" ,
	BuildDistance    = "SIRPGSystem.玩家属性-加成-格子" ,
	ReachDistance    = "SIRPGSystem.玩家属性-加成-格子" ,
	ResourceDistance = "SIRPGSystem.玩家属性-加成-格子" ,
	DropDistance     = "SIRPGSystem.玩家属性-加成-格子" ,
	PickDistance     = "SIRPGSystem.玩家属性-加成-格子" ,
	LootDistance     = "SIRPGSystem.玩家属性-加成-格子" ,
	InventorySize    = "SIRPGSystem.玩家属性-加成-格子" ,
	MaxHealth        = "SIRPGSystem.玩家属性-加成-点数"
}
SIRPGSystem.AdditionEffectsShowPersent =
{
	CraftSpeed       = true ,
	MiningSpeed      = true ,
	MoveSpeed        = true ,
	BuildDistance    = false ,
	ReachDistance    = false ,
	ResourceDistance = false ,
	DropDistance     = false ,
	PickDistance     = false ,
	LootDistance     = false ,
	InventorySize    = false ,
	MaxHealth        = false
}
SIRPGSystem.AdditionEffectFloor =
{
	CraftSpeed       = false ,
	MiningSpeed      = false ,
	MoveSpeed        = false ,
	BuildDistance    = true ,
	ReachDistance    = true ,
	ResourceDistance = true ,
	DropDistance     = true ,
	PickDistance     = true ,
	LootDistance     = true ,
	InventorySize    = true ,
	MaxHealth        = true
}
SIRPGSystem.AdditionEffectMax =
{
	CraftSpeed       = false ,
	MiningSpeed      = false ,
	MoveSpeed        = false ,
	BuildDistance    = false ,
	ReachDistance    = false ,
	ResourceDistance = false ,
	DropDistance     = false ,
	PickDistance     = false ,
	LootDistance     = false ,
	InventorySize    = SIRPGSystem.InventoryMax ,
	MaxHealth        = false
}
SIRPGSystem.AdditionEffectMin =
{
	CraftSpeed       = -1 ,
	MiningSpeed      = -1 ,
	MoveSpeed        = -1 ,
	BuildDistance    = 0 ,
	ReachDistance    = 0 ,
	ResourceDistance = 0 ,
	DropDistance     = 0 ,
	PickDistance     = 0 ,
	LootDistance     = 0 ,
	InventorySize    = 0 ,
	MaxHealth        = 0
}
SIRPGSystem.ValueNames =
{
	-- 最大值
	Health             = { "SIRPGSystem.数值-健康值" } ,
	Strength           = { "SIRPGSystem.数值-体力值" } ,
	Mana               = { "SIRPGSystem.数值-魔法值" } ,
	Energy             = { "SIRPGSystem.数值-能量值" } ,
	Thought            = { "SIRPGSystem.数值-精神值" } ,
	Soul               = { "SIRPGSystem.数值-灵魂值" } ,
	-- 恢复速度
	HealthRegen        = { "SIRPGSystem.数值-健康恢复" } ,
	StrengthRegen      = { "SIRPGSystem.数值-体力恢复" } ,
	ManaRegen          = { "SIRPGSystem.数值-魔法恢复" } ,
	EnergyRegen        = { "SIRPGSystem.数值-能量恢复" } ,
	ThoughtRegen       = { "SIRPGSystem.数值-精神恢复" } ,
	SoulRegen          = { "SIRPGSystem.数值-灵魂恢复" } ,
	-- 伤害
	AttackPhysical     = { "SIRPGSystem.数值-物理伤害" } ,
	AttackMagic        = { "SIRPGSystem.数值-魔法伤害" } ,
	AttackElement      = { "SIRPGSystem.数值-元素伤害" } ,
	AttackSpace        = { "SIRPGSystem.数值-空间伤害" } ,
	AttackThought      = { "SIRPGSystem.数值-精神伤害" } ,
	AttackSoul         = { "SIRPGSystem.数值-灵魂伤害" } ,
	AttackNormal       = { "SIRPGSystem.数值-普通伤害" } ,
	CritChancePhysical = { "SIRPGSystem.数值-物理暴击" } ,
	CritChanceMagic    = { "SIRPGSystem.数值-魔法暴击" } ,
	CritChanceElement  = { "SIRPGSystem.数值-元素暴击" } ,
	CritChanceSpace    = { "SIRPGSystem.数值-空间暴击" } ,
	CritChanceThought  = { "SIRPGSystem.数值-精神暴击" } ,
	CritChanceSoul     = { "SIRPGSystem.数值-灵魂暴击" } ,
	CritChanceNormal   = { "SIRPGSystem.数值-普通暴击" } ,
	CritDamagePhysical = { "SIRPGSystem.数值-物理爆伤" } ,
	CritDamageMagic    = { "SIRPGSystem.数值-魔法爆伤" } ,
	CritDamageElement  = { "SIRPGSystem.数值-元素爆伤" } ,
	CritDamageSpace    = { "SIRPGSystem.数值-空间爆伤" } ,
	CritDamageThought  = { "SIRPGSystem.数值-精神爆伤" } ,
	CritDamageSoul     = { "SIRPGSystem.数值-灵魂爆伤" } ,
	CritDamageNormal   = { "SIRPGSystem.数值-普通爆伤" } ,
	-- 防御
	BlockPhysical      = { "SIRPGSystem.数值-物理格挡" } ,
	BlockMagic         = { "SIRPGSystem.数值-魔法格挡" } ,
	BlockElement       = { "SIRPGSystem.数值-元素格挡" } ,
	BlockSpace         = { "SIRPGSystem.数值-空间格挡" } ,
	BlockThought       = { "SIRPGSystem.数值-精神格挡" } ,
	BlockSoul          = { "SIRPGSystem.数值-灵魂格挡" } ,
	BlockNormal        = { "SIRPGSystem.数值-普通格挡" } ,
	ResistancePhysical = { "SIRPGSystem.数值-物理抵抗" } ,
	ResistanceMagic    = { "SIRPGSystem.数值-魔法抵抗" } ,
	ResistanceElement  = { "SIRPGSystem.数值-元素抵抗" } ,
	ResistanceSpace    = { "SIRPGSystem.数值-空间抵抗" } ,
	ResistanceThought  = { "SIRPGSystem.数值-精神抵抗" } ,
	ResistanceSoul     = { "SIRPGSystem.数值-灵魂抵抗" } ,
	ResistanceNormal   = { "SIRPGSystem.数值-普通抵抗" } ,
	DefencePhysical    = { "SIRPGSystem.数值-物理防御" } ,
	DefenceMagic       = { "SIRPGSystem.数值-魔法防御" } ,
	DefenceElement     = { "SIRPGSystem.数值-元素防御" } ,
	DefenceSpace       = { "SIRPGSystem.数值-空间防御" } ,
	DefenceThought     = { "SIRPGSystem.数值-精神防御" } ,
	DefenceSoul        = { "SIRPGSystem.数值-灵魂防御" } ,
	DefenceNormal      = { "SIRPGSystem.数值-普通防御" }
}
SIRPGSystem.ValueTooltips =
{
	-- 最大值
	Health             = { "SIRPGSystem.数值-健康值-提示" } ,
	Strength           = { "SIRPGSystem.数值-体力值-提示" } ,
	Mana               = { "SIRPGSystem.数值-魔法值-提示" } ,
	Energy             = { "SIRPGSystem.数值-能量值-提示" } ,
	Thought            = { "SIRPGSystem.数值-精神值-提示" } ,
	Soul               = { "SIRPGSystem.数值-灵魂值-提示" } ,
	-- 恢复速度
	HealthRegen        = { "SIRPGSystem.数值-健康恢复-提示" } ,
	StrengthRegen      = { "SIRPGSystem.数值-体力恢复-提示" } ,
	ManaRegen          = { "SIRPGSystem.数值-魔法恢复-提示" } ,
	EnergyRegen        = { "SIRPGSystem.数值-能量恢复-提示" } ,
	ThoughtRegen       = { "SIRPGSystem.数值-精神恢复-提示" } ,
	SoulRegen          = { "SIRPGSystem.数值-灵魂恢复-提示" } ,
	-- 伤害
	AttackPhysical     = { "SIRPGSystem.数值-物理伤害-提示" } ,
	AttackMagic        = { "SIRPGSystem.数值-魔法伤害-提示" } ,
	AttackElement      = { "SIRPGSystem.数值-元素伤害-提示" } ,
	AttackSpace        = { "SIRPGSystem.数值-空间伤害-提示" } ,
	AttackThought      = { "SIRPGSystem.数值-精神伤害-提示" } ,
	AttackSoul         = { "SIRPGSystem.数值-灵魂伤害-提示" } ,
	AttackNormal       = { "SIRPGSystem.数值-普通伤害-提示" } ,
	CritChancePhysical = { "SIRPGSystem.数值-物理暴击-提示" } ,
	CritChanceMagic    = { "SIRPGSystem.数值-魔法暴击-提示" } ,
	CritChanceElement  = { "SIRPGSystem.数值-元素暴击-提示" } ,
	CritChanceSpace    = { "SIRPGSystem.数值-空间暴击-提示" } ,
	CritChanceThought  = { "SIRPGSystem.数值-精神暴击-提示" } ,
	CritChanceSoul     = { "SIRPGSystem.数值-灵魂暴击-提示" } ,
	CritChanceNormal   = { "SIRPGSystem.数值-普通暴击-提示" } ,
	CritDamagePhysical = { "SIRPGSystem.数值-物理爆伤-提示" } ,
	CritDamageMagic    = { "SIRPGSystem.数值-魔法爆伤-提示" } ,
	CritDamageElement  = { "SIRPGSystem.数值-元素爆伤-提示" } ,
	CritDamageSpace    = { "SIRPGSystem.数值-空间爆伤-提示" } ,
	CritDamageThought  = { "SIRPGSystem.数值-精神爆伤-提示" } ,
	CritDamageSoul     = { "SIRPGSystem.数值-灵魂爆伤-提示" } ,
	CritDamageNormal   = { "SIRPGSystem.数值-普通爆伤-提示" } ,
	-- 防御
	BlockPhysical      = { "SIRPGSystem.数值-物理格挡-提示" } ,
	BlockMagic         = { "SIRPGSystem.数值-魔法格挡-提示" } ,
	BlockElement       = { "SIRPGSystem.数值-元素格挡-提示" } ,
	BlockSpace         = { "SIRPGSystem.数值-空间格挡-提示" } ,
	BlockThought       = { "SIRPGSystem.数值-精神格挡-提示" } ,
	BlockSoul          = { "SIRPGSystem.数值-灵魂格挡-提示" } ,
	BlockNormal        = { "SIRPGSystem.数值-普通格挡-提示" } ,
	ResistancePhysical = { "SIRPGSystem.数值-物理抵抗-提示" } ,
	ResistanceMagic    = { "SIRPGSystem.数值-魔法抵抗-提示" } ,
	ResistanceElement  = { "SIRPGSystem.数值-元素抵抗-提示" } ,
	ResistanceSpace    = { "SIRPGSystem.数值-空间抵抗-提示" } ,
	ResistanceThought  = { "SIRPGSystem.数值-精神抵抗-提示" } ,
	ResistanceSoul     = { "SIRPGSystem.数值-灵魂抵抗-提示" } ,
	ResistanceNormal   = { "SIRPGSystem.数值-普通抵抗-提示" } ,
	DefencePhysical    = { "SIRPGSystem.数值-物理防御-提示" } ,
	DefenceMagic       = { "SIRPGSystem.数值-魔法防御-提示" } ,
	DefenceElement     = { "SIRPGSystem.数值-元素防御-提示" } ,
	DefenceSpace       = { "SIRPGSystem.数值-空间防御-提示" } ,
	DefenceThought     = { "SIRPGSystem.数值-精神防御-提示" } ,
	DefenceSoul        = { "SIRPGSystem.数值-灵魂防御-提示" } ,
	DefenceNormal      = { "SIRPGSystem.数值-普通防御-提示" }
}
SIRPGSystem.ValueShowPersent =
{
	-- 最大值
	Health             = false ,
	Strength           = false ,
	Mana               = false ,
	Energy             = false ,
	Thought            = false ,
	Soul               = false ,
	-- 恢复速度
	HealthRegen        = false ,
	StrengthRegen      = false ,
	ManaRegen          = false ,
	EnergyRegen        = false ,
	ThoughtRegen       = false ,
	SoulRegen          = false ,
	-- 伤害
	AttackPhysical     = false ,
	AttackMagic        = false ,
	AttackElement      = false ,
	AttackSpace        = false ,
	AttackThought      = false ,
	AttackSoul         = false ,
	AttackNormal       = false ,
	CritChancePhysical = true ,
	CritChanceMagic    = true ,
	CritChanceElement  = true ,
	CritChanceSpace    = true ,
	CritChanceThought  = true ,
	CritChanceSoul     = true ,
	CritChanceNormal   = true ,
	CritDamagePhysical = true ,
	CritDamageMagic    = true ,
	CritDamageElement  = true ,
	CritDamageSpace    = true ,
	CritDamageThought  = true ,
	CritDamageSoul     = true ,
	CritDamageNormal   = true ,
	-- 防御
	BlockPhysical      = false ,
	BlockMagic         = false ,
	BlockElement       = false ,
	BlockSpace         = false ,
	BlockThought       = false ,
	BlockSoul          = false ,
	BlockNormal        = false ,
	ResistancePhysical = true ,
	ResistanceMagic    = true ,
	ResistanceElement  = true ,
	ResistanceSpace    = true ,
	ResistanceThought  = true ,
	ResistanceSoul     = true ,
	ResistanceNormal   = true ,
	DefencePhysical    = false ,
	DefenceMagic       = false ,
	DefenceElement     = false ,
	DefenceSpace       = false ,
	DefenceThought     = false ,
	DefenceSoul        = false ,
	DefenceNormal      = false ,
}
SIRPGSystem.ValueShowSecond =
{
	-- 最大值
	Health             = false ,
	Strength           = false ,
	Mana               = false ,
	Energy             = false ,
	Thought            = false ,
	Soul               = false ,
	-- 恢复速度
	HealthRegen        = true ,
	StrengthRegen      = true ,
	ManaRegen          = true ,
	EnergyRegen        = true ,
	ThoughtRegen       = true ,
	SoulRegen          = true ,
	-- 伤害
	AttackPhysical     = false ,
	AttackMagic        = false ,
	AttackElement      = false ,
	AttackSpace        = false ,
	AttackThought      = false ,
	AttackSoul         = false ,
	AttackNormal       = false ,
	CritChancePhysical = false ,
	CritChanceMagic    = false ,
	CritChanceElement  = false ,
	CritChanceSpace    = false ,
	CritChanceThought  = false ,
	CritChanceSoul     = false ,
	CritChanceNormal   = false ,
	CritDamagePhysical = false ,
	CritDamageMagic    = false ,
	CritDamageElement  = false ,
	CritDamageSpace    = false ,
	CritDamageThought  = false ,
	CritDamageSoul     = false ,
	CritDamageNormal   = false ,
	-- 防御
	BlockPhysical      = false ,
	BlockMagic         = false ,
	BlockElement       = false ,
	BlockSpace         = false ,
	BlockThought       = false ,
	BlockSoul          = false ,
	BlockNormal        = false ,
	ResistancePhysical = false ,
	ResistanceMagic    = false ,
	ResistanceElement  = false ,
	ResistanceSpace    = false ,
	ResistanceThought  = false ,
	ResistanceSoul     = false ,
	ResistanceNormal   = false ,
	DefencePhysical    = false ,
	DefenceMagic       = false ,
	DefenceElement     = false ,
	DefenceSpace       = false ,
	DefenceThought     = false ,
	DefenceSoul        = false ,
	DefenceNormal      = false
}
SIRPGSystem.ValueBarRegen =
{
	Health   = SIRPGSystem.ValueIDs.HealthRegen ,
	Strength = SIRPGSystem.ValueIDs.StrengthRegen ,
	Mana     = SIRPGSystem.ValueIDs.ManaRegen ,
	Energy   = SIRPGSystem.ValueIDs.EnergyRegen ,
	Thought  = SIRPGSystem.ValueIDs.ThoughtRegen ,
	Soul     = SIRPGSystem.ValueIDs.SoulRegen
}
SIRPGSystem.ValueCanCrit =
{
	AttackPhysical = { Chance = SIRPGSystem.ValueIDs.CritChancePhysical , Damage = SIRPGSystem.ValueIDs.CritDamagePhysical } ,
	AttackMagic    = { Chance = SIRPGSystem.ValueIDs.CritChanceMagic    , Damage = SIRPGSystem.ValueIDs.CritDamageMagic    } ,
	AttackElement  = { Chance = SIRPGSystem.ValueIDs.CritChanceElement  , Damage = SIRPGSystem.ValueIDs.CritDamageElement  } ,
	AttackSpace    = { Chance = SIRPGSystem.ValueIDs.CritChanceSpace    , Damage = SIRPGSystem.ValueIDs.CritDamageSpace    } ,
	AttackThought  = { Chance = SIRPGSystem.ValueIDs.CritChanceThought  , Damage = SIRPGSystem.ValueIDs.CritDamageThought  } ,
	AttackSoul     = { Chance = SIRPGSystem.ValueIDs.CritChanceSoul     , Damage = SIRPGSystem.ValueIDs.CritDamageSoul     } ,
	AttackNormal   = { Chance = SIRPGSystem.ValueIDs.CritChanceNormal   , Damage = SIRPGSystem.ValueIDs.CritDamageNormal   }
}
SIRPGSystem.ValueIsDefence =
{
	BlockPhysical = { Resistance = SIRPGSystem.ValueIDs.ResistancePhysical , Defence = SIRPGSystem.ValueIDs.DefencePhysical } ,
	BlockMagic    = { Resistance = SIRPGSystem.ValueIDs.ResistanceMagic    , Defence = SIRPGSystem.ValueIDs.DefenceMagic    } ,
	BlockElement  = { Resistance = SIRPGSystem.ValueIDs.ResistanceElement  , Defence = SIRPGSystem.ValueIDs.DefenceElement  } ,
	BlockSpace    = { Resistance = SIRPGSystem.ValueIDs.ResistanceSpace    , Defence = SIRPGSystem.ValueIDs.DefenceSpace    } ,
	BlockThought  = { Resistance = SIRPGSystem.ValueIDs.ResistanceThought  , Defence = SIRPGSystem.ValueIDs.DefenceThought  } ,
	BlockSoul     = { Resistance = SIRPGSystem.ValueIDs.ResistanceSoul     , Defence = SIRPGSystem.ValueIDs.DefenceSoul     } ,
	BlockNormal   = { Resistance = SIRPGSystem.ValueIDs.ResistanceNormal   , Defence = SIRPGSystem.ValueIDs.DefenceNormal   }
}
SIRPGSystem.SpecialDamages =
{
	-- 物理伤害
	[SIConstants_Core.raw.DamageTypes.PhysicWater]     = SIRPGSystem.ValueIDs.AttackPhysical , -- 潮湿
	[SIConstants_Core.raw.DamageTypes.PhysicDry]       = SIRPGSystem.ValueIDs.AttackPhysical , -- 干燥
	[SIConstants_Core.raw.DamageTypes.PhysicIce]       = SIRPGSystem.ValueIDs.AttackPhysical , -- 冰冻
	[SIConstants_Core.raw.DamageTypes.PhysicRadiation] = SIRPGSystem.ValueIDs.AttackPhysical , -- 辐射
	[SIConstants_Core.raw.DamageTypes.PhysicCorrosion] = SIRPGSystem.ValueIDs.AttackPhysical , -- 腐蚀
	[SIConstants_Core.raw.DamageTypes.PhysicSound]     = SIRPGSystem.ValueIDs.AttackPhysical , -- 声波
	[SIConstants_Core.raw.DamageTypes.PhysicEnergy]    = SIRPGSystem.ValueIDs.AttackPhysical , -- 能量
	[SIConstants_Core.raw.DamageTypes.PhysicGravity]   = SIRPGSystem.ValueIDs.AttackPhysical , -- 重力
	-- 魔法伤害
	[SIConstants_Core.raw.DamageTypes.MagicPower]      = SIRPGSystem.ValueIDs.AttackMagic    , -- 力量
	[SIConstants_Core.raw.DamageTypes.MagicSpirit]     = SIRPGSystem.ValueIDs.AttackMagic    , -- 意念
	[SIConstants_Core.raw.DamageTypes.MagicBlood]      = SIRPGSystem.ValueIDs.AttackMagic    , -- 献祭
	[SIConstants_Core.raw.DamageTypes.MagicDisease]    = SIRPGSystem.ValueIDs.AttackMagic    , -- 瘟疫
	[SIConstants_Core.raw.DamageTypes.MagicFear]       = SIRPGSystem.ValueIDs.AttackMagic    , -- 恐惧
	[SIConstants_Core.raw.DamageTypes.MagicTwist]      = SIRPGSystem.ValueIDs.AttackMagic    , -- 扭曲
	[SIConstants_Core.raw.DamageTypes.MagicCorrosion]  = SIRPGSystem.ValueIDs.AttackMagic    , -- 侵蚀
	[SIConstants_Core.raw.DamageTypes.MagicVoid]       = SIRPGSystem.ValueIDs.AttackMagic    , -- 虚空
	-- 元素伤害
	[SIConstants_Core.raw.DamageTypes.ElementCut]      = SIRPGSystem.ValueIDs.AttackElement  , -- 割元素
	[SIConstants_Core.raw.DamageTypes.ElementHeat]     = SIRPGSystem.ValueIDs.AttackElement  , -- 炎元素
	[SIConstants_Core.raw.DamageTypes.ElementGround]   = SIRPGSystem.ValueIDs.AttackElement  , -- 固元素
	[SIConstants_Core.raw.DamageTypes.ElementWater]    = SIRPGSystem.ValueIDs.AttackElement  , -- 流元素
	[SIConstants_Core.raw.DamageTypes.ElementWind]     = SIRPGSystem.ValueIDs.AttackElement  , -- 气元素
	[SIConstants_Core.raw.DamageTypes.ElementLife]     = SIRPGSystem.ValueIDs.AttackElement  , -- 命元素
	[SIConstants_Core.raw.DamageTypes.ElementSound]    = SIRPGSystem.ValueIDs.AttackElement  , -- 音元素
	[SIConstants_Core.raw.DamageTypes.ElementElectric] = SIRPGSystem.ValueIDs.AttackElement  , -- 电元素
	[SIConstants_Core.raw.DamageTypes.ElementLight]    = SIRPGSystem.ValueIDs.AttackElement  , -- 光元素
	[SIConstants_Core.raw.DamageTypes.ElementDary]     = SIRPGSystem.ValueIDs.AttackElement  , -- 影元素
	[SIConstants_Core.raw.DamageTypes.ElementEnergy]   = SIRPGSystem.ValueIDs.AttackElement  , -- 能元素
	[SIConstants_Core.raw.DamageTypes.ElementHeavy]    = SIRPGSystem.ValueIDs.AttackElement  , -- 质元素
	[SIConstants_Core.raw.DamageTypes.ElementFull]     = SIRPGSystem.ValueIDs.AttackElement  , -- 盈元素
	[SIConstants_Core.raw.DamageTypes.ElementVoid]     = SIRPGSystem.ValueIDs.AttackElement  , -- 虚元素
	[SIConstants_Core.raw.DamageTypes.ElementSkill]    = SIRPGSystem.ValueIDs.AttackElement  , -- 技元素
	-- 其他伤害
	[SIConstants_Core.raw.DamageTypes.DamageSpace]     = SIRPGSystem.ValueIDs.AttackSpace    , -- 空间
	[SIConstants_Core.raw.DamageTypes.DamageThought]   = SIRPGSystem.ValueIDs.AttackThought  , -- 精神
	[SIConstants_Core.raw.DamageTypes.DamageSoul]      = SIRPGSystem.ValueIDs.AttackSoul       -- 灵魂
}
SIRPGSystem.SpecialDefences =
{
	-- 物理伤害
	[SIConstants_Core.raw.DamageTypes.PhysicWater]     = SIRPGSystem.ValueIDs.BlockPhysical , -- 潮湿
	[SIConstants_Core.raw.DamageTypes.PhysicDry]       = SIRPGSystem.ValueIDs.BlockPhysical , -- 干燥
	[SIConstants_Core.raw.DamageTypes.PhysicIce]       = SIRPGSystem.ValueIDs.BlockPhysical , -- 冰冻
	[SIConstants_Core.raw.DamageTypes.PhysicRadiation] = SIRPGSystem.ValueIDs.BlockPhysical , -- 辐射
	[SIConstants_Core.raw.DamageTypes.PhysicCorrosion] = SIRPGSystem.ValueIDs.BlockPhysical , -- 腐蚀
	[SIConstants_Core.raw.DamageTypes.PhysicSound]     = SIRPGSystem.ValueIDs.BlockPhysical , -- 声波
	[SIConstants_Core.raw.DamageTypes.PhysicEnergy]    = SIRPGSystem.ValueIDs.BlockPhysical , -- 能量
	[SIConstants_Core.raw.DamageTypes.PhysicGravity]   = SIRPGSystem.ValueIDs.BlockPhysical , -- 重力
	-- 魔法伤害
	[SIConstants_Core.raw.DamageTypes.MagicPower]      = SIRPGSystem.ValueIDs.BlockMagic    , -- 力量
	[SIConstants_Core.raw.DamageTypes.MagicSpirit]     = SIRPGSystem.ValueIDs.BlockMagic    , -- 意念
	[SIConstants_Core.raw.DamageTypes.MagicBlood]      = SIRPGSystem.ValueIDs.BlockMagic    , -- 献祭
	[SIConstants_Core.raw.DamageTypes.MagicDisease]    = SIRPGSystem.ValueIDs.BlockMagic    , -- 瘟疫
	[SIConstants_Core.raw.DamageTypes.MagicFear]       = SIRPGSystem.ValueIDs.BlockMagic    , -- 恐惧
	[SIConstants_Core.raw.DamageTypes.MagicTwist]      = SIRPGSystem.ValueIDs.BlockMagic    , -- 扭曲
	[SIConstants_Core.raw.DamageTypes.MagicCorrosion]  = SIRPGSystem.ValueIDs.BlockMagic    , -- 侵蚀
	[SIConstants_Core.raw.DamageTypes.MagicVoid]       = SIRPGSystem.ValueIDs.BlockMagic    , -- 虚空
	-- 元素伤害
	[SIConstants_Core.raw.DamageTypes.ElementCut]      = SIRPGSystem.ValueIDs.BlockElement  , -- 割元素
	[SIConstants_Core.raw.DamageTypes.ElementHeat]     = SIRPGSystem.ValueIDs.BlockElement  , -- 炎元素
	[SIConstants_Core.raw.DamageTypes.ElementGround]   = SIRPGSystem.ValueIDs.BlockElement  , -- 固元素
	[SIConstants_Core.raw.DamageTypes.ElementWater]    = SIRPGSystem.ValueIDs.BlockElement  , -- 流元素
	[SIConstants_Core.raw.DamageTypes.ElementWind]     = SIRPGSystem.ValueIDs.BlockElement  , -- 气元素
	[SIConstants_Core.raw.DamageTypes.ElementLife]     = SIRPGSystem.ValueIDs.BlockElement  , -- 命元素
	[SIConstants_Core.raw.DamageTypes.ElementSound]    = SIRPGSystem.ValueIDs.BlockElement  , -- 音元素
	[SIConstants_Core.raw.DamageTypes.ElementElectric] = SIRPGSystem.ValueIDs.BlockElement  , -- 电元素
	[SIConstants_Core.raw.DamageTypes.ElementLight]    = SIRPGSystem.ValueIDs.BlockElement  , -- 光元素
	[SIConstants_Core.raw.DamageTypes.ElementDary]     = SIRPGSystem.ValueIDs.BlockElement  , -- 影元素
	[SIConstants_Core.raw.DamageTypes.ElementEnergy]   = SIRPGSystem.ValueIDs.BlockElement  , -- 能元素
	[SIConstants_Core.raw.DamageTypes.ElementHeavy]    = SIRPGSystem.ValueIDs.BlockElement  , -- 质元素
	[SIConstants_Core.raw.DamageTypes.ElementFull]     = SIRPGSystem.ValueIDs.BlockElement  , -- 盈元素
	[SIConstants_Core.raw.DamageTypes.ElementVoid]     = SIRPGSystem.ValueIDs.BlockElement  , -- 虚元素
	[SIConstants_Core.raw.DamageTypes.ElementSkill]    = SIRPGSystem.ValueIDs.BlockElement  , -- 技元素
	-- 其他伤害
	[SIConstants_Core.raw.DamageTypes.DamageSpace]     = SIRPGSystem.ValueIDs.BlockSpace    , -- 空间
	[SIConstants_Core.raw.DamageTypes.DamageThought]   = SIRPGSystem.ValueIDs.BlockThought  , -- 精神
	[SIConstants_Core.raw.DamageTypes.DamageSoul]      = SIRPGSystem.ValueIDs.BlockSoul       -- 灵魂
}

SIRPGSystem.Settings =
{
	Name = "RPGSystem" ,
	DefaultGlobal =
	{
		Setting =
		{
			-- 点数获取
			AttackPointPerLevel         = 2 ,
			AttackPointExtraWithEnd5    = 2 ,
			AttackPointExtraWithEnd0    = 5 ,
			AdventurePointPerLevel      = 1 ,
			AdventurePointExtraWithEnd5 = 2 ,
			AdventurePointExtraWithEnd0 = 2 ,
			CraftPointPerLevel          = 3 ,
			CraftPointExtraWithEnd5     = 3 ,
			CraftPointExtraWithEnd0     = 9 ,
			-- 经验倍率
			AttackExpMultiplier    = 1.0 ,
			AdventureExpMultiplier = 1.0 ,
			CraftExpMultiplier     = 1.0 ,
			-- 属性效果
			PropertyEffects =
			{
				Power       = --[[ 力量 ]] { Health   = 2.0 , Energy       = 2.0  , StrengthRegen  = 0.05 , AttackPhysical = 1.5  , AttackElement = 0.2  , BlockPhysical = 1.0  , BlockElement   = 0.1 } ,
				Body        = --[[ 体质 ]] { Health   = 8.0 , Strength     = 0.5  , HealthRegen    = 0.01 , StrengthRegen  = 0.05 , AttackElement = 0.5  , BlockPhysical = 0.1  , BlockSoul      = 0.6 } ,
				Strength    = --[[ 韧性 ]] { Health   = 0.5 , Strength     = 7.0  , Soul           = 0.5  , HealthRegen    = 0.06 , StrengthRegen = 0.03 , EnergyRegen   = 0.02 , BlockSoul      = 0.2 } ,
				Will        = --[[ 意志 ]] { Health   = 1.0 , Strength     = 3.0  , Energy         = 1.5  , Thought        = 2.5  , EnergyRegen   = 0.03 , ThoughtRegen  = 0.01 , AttackSoul     = 0.3 } ,
				Agility     = --[[ 敏捷 ]] { Strength = 1.5 , Energy       = 2.5  , StrengthRegen  = 0.02 , AttackPhysical = 0.5  , BlockPhysical = 0.6  , BlockElement  = 1.3  , BlockSpace     = 0.3 } ,
				Attention   = --[[ 专注 ]] { Mana     = 2.5 , Thought      = 2.5  , ThoughtRegen   = 0.01 , AttackThought  = 0.5  , AttackSoul    = 0.1  , BlockPhysical = 0.3  , BlockThought   = 0.3 } ,
				Wisdom      = --[[ 智慧 ]] { Mana     = 1.5 , Thought      = 0.5  , ManaRegen      = 0.01 , ThoughtRegen   = 0.01 , AttackMagic   = 1.5  , AttackThought = 0.4  , BlockSoul      = 0.1 } ,
				Spirit      = --[[ 精神 ]] { Mana     = 7.0 , Thought      = 2.0  , AttackMagic    = 0.1  , AttackThought  = 0.1  , BlockMagic    = 0.9  , BlockThought  = 0.5  , BlockSoul      = 0.1 } ,
				Temperament = --[[ 气质 ]] { Health   = 0.5 , Soul         = 3.5  , HealthRegen    = 0.02 , AttackMagic    = 0.2  , AttackElement = 0.8  , AttackSoul    = 0.4  , BlockMagic     = 0.6 } ,
				Mystery     = --[[ 神秘 ]] { Mana     = 1.0 , Soul         = 3.0  , ManaRegen      = 0.03 , EnergyRegen    = 0.01 , AttackMagic   = 0.2  , AttackSpace   = 0.6  , BlockThought   = 0.2 } ,
				Constraint  = --[[ 约束 ]] { Energy   = 6.0 , Soul         = 1.0  , SoulRegen      = 0.01 , AttackSpace    = 0.1  , AttackSoul    = 0.2  , BlockMagic    = 0.1  , BlockElement   = 0.1 } ,
				Luck        = --[[ 幸运 ]] { Thought  = 0.5 , ManaRegen    = 0.02 , AttackElement  = 0.5  , AttackSpace    = 0.3  , BlockMagic    = 0.4  , BlockElement  = 0.5  , BlockSpace     = 0.7 }
			} ,
			-- 加成效力
			AdditionEffects =
			{
				CraftSpeed       = 0.004 , -- 手搓速度
				MiningSpeed      = 0.006 , -- 挖掘速度
				MoveSpeed        = 0.002 , -- 移动速度
				BuildDistance    = 0.1   , -- 建造距离
				ReachDistance    = 0.1   , -- 操作距离
				ResourceDistance = 0.1   , -- 资源操作距离
				DropDistance     = 0.1   , -- 丢弃距离
				PickDistance     = 0.05  , -- 拾取物品距离
				LootDistance     = 0.05  , -- 战利品距离
				InventorySize    = 0.3   , -- 背包容量
				MaxHealth        = 1       -- 最大生命值
			}
		} ,
		EXP =
		{
			Max = 1000000.0 ,
			SpecialEntityList = {} ,
			SpecialRecipeList = {} ,
			SpecialMiningList = {} ,
			SpecialTechnologyList = {}
		} ,
		SkillList = {} ,
		SkillOrderList = {} ,
		SkillTypeOrderList = {} ,
		Friendly = {} ,
		Enemy = {} ,
		Nature = {}
	} ,
	DefaultPlayer =
	{
		-- 基础信息
		character = nil ,
		-- 玩家属性窗口
		PlayerStatus =
		{
			frame = nil ,
			frameLocation = nil ,
			levelLabelAttack = nil ,
			levelLabelAdventure = nil ,
			levelLabelCraft = nil ,
			levelCountAttack = nil ,
			levelCountAdventure = nil ,
			levelCountCraft = nil ,
			levelProgressAttack = nil ,
			levelProgressAdventure = nil ,
			levelProgressCraft = nil ,
			pointLabelAttack = nil ,
			pointLabelAdventure = nil ,
			pointLabelCraft = nil ,
			ValueLabel = {} ,
			ValueText = {} ,
			ValueTextLeft = {} ,
			ValueTextCenter = {} ,
			ValueTextRight = {} ,
			ValueBar = {} ,
			PropertyName = {} ,
			PropertyLevel = {} ,
			PropertyCount = {} ,
			PropertyCountText = {} ,
			PropertyButton = {} ,
			AdditionName = {} ,
			AdditionLevel = {} ,
			AdditionEffect = {} ,
			AdditionCount = {} ,
			AdditionCountText = {} ,
			AdditionButton = {}
		} ,
		-- 玩家属性迷你窗口
		PlayerStatusMini =
		{
			frame = nil ,
			frameLocation = nil ,
			frameLocked = false ,
			levelCountAttack = nil ,
			levelCountAdventure = nil ,
			levelCountCraft = nil ,
			levelProgressAttack = nil ,
			levelProgressAdventure = nil ,
			levelProgressCraft = nil
		} ,
		-- 玩家信息窗口
		PlayerInfo =
		{
			frame = nil ,
			frameLocation = nil ,
			frameLocked = false ,
			ValueTextLeft = {} ,
			ValueTextCenter = {} ,
			ValueTextRight = {} ,
			ValueBar = {}
		} ,
		-- 玩家技能窗口
		PlayerSkill =
		{
			frame = nil ,
			frameLocation = nil ,
			pointLabelAttack = nil ,
			pointLabelAdventure = nil ,
			pointLabelCraft = nil ,
			List = {} ,
			AttackLevel = {} ,
			AttackValue = {} ,
			AttackCount = {} ,
			AttackCountText = {} ,
			AdventureLevel = {} ,
			AdventureValue = {} ,
			AdventureCount = {} ,
			AdventureCountText = {} ,
			CraftLevel = {} ,
			CraftValue = {} ,
			CraftCount = {} ,
			CraftCountText = {}
		} ,
		-- 玩家技能快捷窗口
		PlayerSkillMini =
		{
			frame = nil ,
			frameLocation = nil ,
			frameLocked = false ,
			list = nil ,
			SkillList = {}
		} ,
		-- 玩家设置窗口
		PlayerSetting =
		{
			frame = nil ,
			frameLocation = nil ,
			list = nil ,
			Elements =
			{
				itemFlyingText = nil ,
				itemSkillColumnCount = nil ,
				itemSkillColumnCountText = nil
			} ,
			Base =
			{
				showFlyingText = false ,
				skillColumnCount = 4 ,
				-- 不由设置窗口修改的设置数据
				showPlayerStatusMini = false ,
				showPlayerInfo = false ,
				showPlayerSkillMini = false
			} ,
			back = nil
		} ,
		-- 全局设置窗口
		GlobalSetting =
		{
			frame = nil ,
			frameLocation = nil ,
			back = nil
		} ,
		-- 经验数据
		EXP =
		{
			-- 等级信息
			AttackExp       = 0 ,
			AdventureExp    = 0 ,
			CraftExp        = 0 ,
			AttackLevel     = 0 ,
			AdventureLevel  = 0 ,
			CraftLevel      = 0 ,
			AttackExpMax    = 8 ,
			AdventureExpMax = 8 ,
			CraftExpMax     = 8
		} ,
		-- 点数数据
		Points =
		{
			Max =
			{
				Attack    = 0 ,
				Adventure = 0 ,
				Craft     = 0
			} ,
			Current =
			{
				Attack    = 0 ,
				Adventure = 0 ,
				Craft     = 0
			}
		} ,
		-- 属性数据
		Property =
		{
			Attack    = {} ,
			Adventure = {} ,
			Craft     = {} ,
			Max       = {} ,
			Active    = {}
		} ,
		-- 加成数据
		Addition =
		{
			Attack    = {} ,
			Adventure = {} ,
			Craft     = {} ,
			Max       = {} ,
			Active    = {}
		} ,
		Value =
		{
			-- 包含了属性 , buff 和技能的基础能力值
			Max =
			{
				-- 最大值
				Health             = 100 ,
				Strength           = 100 ,
				Mana               = 100 ,
				Energy             = 100 ,
				Thought            = 100 ,
				Soul               = 100 ,
				-- 恢复速度
				HealthRegen        = 0.09 ,
				StrengthRegen      = 0.15 ,
				ManaRegen          = 0.06 ,
				EnergyRegen        = 0.06 ,
				ThoughtRegen       = 0.03 ,
				SoulRegen          = 0.01 ,
				-- 伤害
				AttackPhysical     = 0 ,
				AttackMagic        = 0 ,
				AttackElement      = 0 ,
				AttackSpace        = 0 ,
				AttackThought      = 0 ,
				AttackSoul         = 0 ,
				AttackNormal       = 0 ,
				CritChancePhysical = 0.05 ,
				CritChanceMagic    = 0.05 ,
				CritChanceElement  = 0.05 ,
				CritChanceSpace    = 0.05 ,
				CritChanceThought  = 0.05 ,
				CritChanceSoul     = 0.05 ,
				CritChanceNormal   = 0.0 ,
				CritDamagePhysical = 1.5 ,
				CritDamageMagic    = 1.5 ,
				CritDamageElement  = 1.5 ,
				CritDamageSpace    = 1.5 ,
				CritDamageThought  = 1.5 ,
				CritDamageSoul     = 1.5 ,
				CritDamageNormal   = 1.0 ,
				-- 防御
				BlockPhysical      = 0 ,
				BlockMagic         = 0 ,
				BlockElement       = 0 ,
				BlockSpace         = 0 ,
				BlockThought       = 0 ,
				BlockSoul          = 0 ,
				BlockNormal        = 0 ,
				ResistancePhysical = 0 ,
				ResistanceMagic    = 0 ,
				ResistanceElement  = 0 ,
				ResistanceSpace    = 0 ,
				ResistanceThought  = 0 ,
				ResistanceSoul     = 0 ,
				ResistanceNormal   = 0 ,
				DefencePhysical    = 0 ,
				DefenceMagic       = 0 ,
				DefenceElement     = 0 ,
				DefenceSpace       = 0 ,
				DefenceThought     = 0 ,
				DefenceSoul        = 0 ,
				DefenceNormal      = 0
			} ,
			-- 当前有效的属性
			Current =
			{
				-- 最大值
				Health = 100 ,
				Strength = 100 ,
				Mana = 100 ,
				Energy = 100 ,
				Thought = 100 ,
				Soul = 100
			}
		} ,
		-- 背包数据
		Inventory =
		{
			Main = {} ,
			Adventure = {}
		} ,
		-- 标识数据
		Flag = {} ,
		-- buff 列表
		BuffList = {} ,
		-- 技能列表
		SkillList = {} ,
		SkillUI =
		{
			Strong =
			{
				Attack = 0 ,
				Adventure = 0 ,
				Craft = 0
			} ,
			OverView =
			{
				frame = nil ,
				frameLocation = nil ,
				point = nil ,
				list = nil ,
				CurrentPoint =
				{
					frame = nil ,
					frameLocation = nil ,
					map = nil ,
					zoom = 1.0
				} ,
				PointList = {}
			}
		}
	} ,
	CreateFunction = function( settingName , settings , settingType )
		if settingType == SIGlobal.SettingTypeDefine.Player then
			local globalSettings = SIGlobal.GetGlobalSettings( SIRPGSystem.Settings.Name )
			for skillID , skillData in pairs( globalSettings.SkillList ) do
				local playerSkillData = SIUtils.table.deepcopy( SIRPGSystem.PlayerSkillDataDefault )
				playerSkillData.Unlock = skillData.Unlock == nil
				if skillData.DefaultCustomData then
					playerSkillData.CustomData = SIUtils.table.deepcopy( skillData.DefaultCustomData )
				end
				settings.SkillList[skillID] = playerSkillData
				SIRPGSystem.CheckLockSkill( settings , skillID )
			end
		end
	end
}

local property = SIRPGSystem.Settings.DefaultPlayer.Property
for name , propertyID in pairs( SIRPGSystem.PropertyIDs ) do
	property.Attack[propertyID] = 0
	property.Adventure[propertyID] = 0
	property.Craft[propertyID] = 0
	property.Max[propertyID] = 0
	property.Active[propertyID] = 0
end

local addition = SIRPGSystem.Settings.DefaultPlayer.Addition
for name , additionID in pairs( SIRPGSystem.AdditionIDs ) do
	addition.Attack[additionID] = 0
	addition.Adventure[additionID] = 0
	addition.Craft[additionID] = 0
	addition.Max[additionID] = 0
	addition.Active[additionID] = 0
end











-- AABBC =
-- {
-- 	Health         = 0.0833 ,
-- 	Strength       = 0.0833 ,
-- 	Mana           = 0.0833 ,
-- 	Energy         = 0.0833 ,
-- 	Thought        = 0.125 ,
-- 	Soul           = 0.125 ,

-- 	HealthRegen    = 11.11 ,
-- 	StrengthRegen  = 6.67 ,
-- 	ManaRegen      = 16.67 ,
-- 	EnergyRegen    = 16.67 ,
-- 	ThoughtRegen   = 33.33 ,
-- 	SoulRegen      = 100.0 ,

-- 	AttackPhysical = 0.5 ,
-- 	AttackMagic    = 0.5 ,
-- 	AttackElement  = 0.5 ,
-- 	AttackSpace    = 1.0 ,
-- 	AttackThought  = 1.0 ,
-- 	AttackSoul     = 1.0 ,

-- 	BlockPhysical  = 0.5 ,
-- 	BlockMagic     = 0.5 ,
-- 	BlockElement   = 0.5 ,
-- 	BlockSpace     = 1.0 ,
-- 	BlockThought   = 1.0 ,
-- 	BlockSoul      = 1.0
-- }
-- AABBD =
-- {
-- 	Health         = 12 ,
-- 	Strength       = 12 ,
-- 	Mana           = 12 ,
-- 	Energy         = 12 ,
-- 	Thought        = 8 ,
-- 	Soul           = 8 ,

-- 	HealthRegen    = 0.09 ,
-- 	StrengthRegen  = 0.15 ,
-- 	ManaRegen      = 0.06 ,
-- 	EnergyRegen    = 0.06 ,
-- 	ThoughtRegen   = 0.03 ,
-- 	SoulRegen      = 0.01 ,

-- 	AttackPhysical = 2 ,
-- 	AttackMagic    = 2 ,
-- 	AttackElement  = 2 ,
-- 	AttackSpace    = 1 ,
-- 	AttackThought  = 1 ,
-- 	AttackSoul     = 1 ,

-- 	BlockPhysical  = 2 ,
-- 	BlockMagic     = 2 ,
-- 	BlockElement   = 2 ,
-- 	BlockSpace     = 1 ,
-- 	BlockThought   = 1 ,
-- 	BlockSoul      = 1
-- }
--
-- function CALKQ()
-- 	local out = ""
-- 	for propertyID , valueList in pairs( KQPropertyEffects ) do
-- 		local score = 0.0
-- 		for valueID , valueCount in pairs( valueList ) do
-- 			score = score + valueCount * AABBC[valueID]
-- 		end
-- 		out = out .. "\n" .. propertyID .. " = " .. score
-- 	end
-- 	SIPrint.Print( out )
-- end

-- function CALKT()
-- 	local k = {}
-- 	for propertyID , valueList in pairs( KQPropertyEffects ) do
-- 		for valueID , valueCount in pairs( valueList ) do
-- 			local kk = k[valueID] or 0
-- 			kk = kk + valueCount
-- 			k[valueID] = kk
-- 		end
-- 	end
-- 	local out = ""
-- 	for valueID , valueCount in pairs( AABBD ) do
-- 		out = out .. "\n" .. valueID .. " = " .. k[valueID] .. " , " .. valueCount
-- 	end
-- 	SIPrint.Print( out )
-- end
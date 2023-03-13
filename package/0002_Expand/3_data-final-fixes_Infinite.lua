-- ------------------------------------------------------------------------------------------------
-- -------- 扩展无尽科技 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local function AddEffect( effects , prototypeName )
	for index , oldEffect in pairs( effects ) do
		if oldEffect.turret_id and oldEffect.turret_id == prototypeName then
			return
		end
	end
	table.insert( effects ,
	{
		type = SICommon.Flags.TechnologyModifier.TurretAttack ,
		turret_id = prototypeName ,
		modifier = 0.02
	} )
end

local function CheckAttackParameters( effects , ammoCategoryList , sourcePrototypeName , currentPrototypeData )
	if currentPrototypeData and currentPrototypeData.attack_parameters then
		local attackParameters = currentPrototypeData.attack_parameters
		local typeFlag = true
		if attackParameters.ammo_type then
			typeFlag = false
			if attackParameters.ammo_type.category and SITable.Has( ammoCategoryList , attackParameters.ammo_type.category ) then
				AddEffect( effects , sourcePrototypeName )
			end
		end
		if attackParameters.ammo_categories then
			typeFlag = false
			for index , ammo_category in pairs( attackParameters.ammo_categories ) do
				if SITable.Has( ammoCategoryList , ammo_category ) then
					AddEffect( effects , sourcePrototypeName )
				end
			end
		end
		if typeFlag and attackParameters.ammo_category and SITable.Has( ammoCategoryList , attackParameters.ammo_category ) then
			AddEffect( effects , sourcePrototypeName )
		end
	end
end

for technologyName , ammoCategoryList in pairs
{
	[SIConstants_Expand.raw.Technologies.Infinite_WeaponAmmoTurret_1]      = { "bullet" , "shotgun-shell" } ,
	[SIConstants_Expand.raw.Technologies.Infinite_WeaponLaserTurret_1]     = { "laser" , "beam" } ,
	[SIConstants_Expand.raw.Technologies.Infinite_WeaponExplosiveTurret_1] = { "rocket" , "grenade" , "cannon-shell" , "landmine" } ,
	[SIConstants_Expand.raw.Technologies.Infinite_WeaponFlameTurret_1]     = { "flamethrower" } ,
	[SIConstants_Expand.raw.Technologies.Infinite_WeaponEnergyTurret_1]    = { "electric" } ,
	[SIConstants_Expand.raw.Technologies.Infinite_WeaponArtilleryTurret_1] = { "artillery-shell" }
} do
	-- 整理 effects 数组
	local effects = {}
	SIGen.ForEachType( SICommon.Types.WeaponEntities , function( weaponPrototypeName , weaponPrototypeData )
		if SIConfigs.SIExpand.TurretBlackList[weaponPrototypeName] then
			return
		end
		if weaponPrototypeData then
			local guns = nil
			if weaponPrototypeData.gun then
				guns = { weaponPrototypeData.gun }
			elseif weaponPrototypeData.guns then
				guns = weaponPrototypeData.guns
			end
			if guns then
				for index , gunName in pairs( guns ) do
					SIGen.Find( SICommon.Types.Items.Gun , gunName , function( gunPrototypeName , gunPrototypeData )
						CheckAttackParameters( effects , ammoCategoryList , weaponPrototypeName , gunPrototypeData )
					end )
				end
			end
		end
	end )
	SIGen.ForEachType( SICommon.Types.TurretEntities , function( turretPrototypeName , turretPrototypeData )
		if SIConfigs.SIExpand.TurretBlackList[turretPrototypeName] then
			return
		end
		CheckAttackParameters( effects , ammoCategoryList , turretPrototypeName , turretPrototypeData )
	end )
	SIGen.ForEach( SICommon.Types.Entities.LandMine , function( landMinePrototypeName , landMinePrototypeData )
		if SIConfigs.SIExpand.TurretBlackList[landMinePrototypeName] then
			return
		end
		if landMinePrototypeData and landMinePrototypeData.ammo_category and SITable.Has( ammoCategoryList , landMinePrototypeData.ammo_category ) then
			AddEffect( effects , landMinePrototypeName )
		end
	end )
	-- 把整理好的 effects 塞进科技
	local realTechnologyName = technologyName:sub( 1 , technologyName:len() - 2 )
	for level = 1 , 6 , 1 do
		SIGen.Find( SICommon.Types.Technology , realTechnologyName .. "-" .. level , function( technologyPrototypeName , technologyPrototypeData )
			if technologyPrototypeData then
				local currentEffects = SIUtils.table.deepcopy( effects )
				if technologyPrototypeData.effects then
					for index , effect in pairs( currentEffects ) do
						table.insert( technologyPrototypeData.effects , effect )
					end
				else
					technologyPrototypeData.effects = currentEffects
				end
			end
		end )
	end
end
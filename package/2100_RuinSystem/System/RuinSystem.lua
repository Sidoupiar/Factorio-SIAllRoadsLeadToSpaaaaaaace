SIRuinSystem =
{
	ID = "RuinSystem" ,
	Code = "RuinSystem" ,
	Name = "遗迹控制" ,
	InterfaceID = "SIRuinSystem-Main" ,
	Settings =
	{
		Name = "RuinSystem" ,
		Default =
		{
			Surfaces = {} ,
			Controls =
			{
				RuinStyles        = {} ,
				TurretSets        = {} ,
				ItemSets          = {} ,
				MachineSets       = {} ,
				MarketSets        = {} ,
				SpecialEntitySets = {}
			} ,
			Weights =
			{
				RuinStyles        = 0 ,
				TurretSets        = 0 ,
				ItemSets          = 0 ,
				MachineSets       = 0 ,
				MarketSets        = 0 ,
				SpecialEntitySets = 0
			}
		}
	} ,
	ControlNames =
	{
		RuinStyles        = "RuinStyles" ,
		TurretSets        = "TurretSets" ,
		ItemSets          = "ItemSets" ,
		MachineSets       = "MachineSets" ,
		MarketSets        = "MarketSets" ,
		SpecialEntitySets = "SpecialEntitySets"
	} ,
	TurretDirection =
	{
		[1] = defines.direction.north ,
		[2] = defines.direction.east ,
		[3] = defines.direction.south ,
		[4] = defines.direction.west
	} ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 初始化 ==========================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================<br>
	-- 注册基础的遗迹数据<br>
	-- ======================================================================<br>
	FreshRuinData = function()
		local maxLevel = SITable.Size( SIConstants_RuinSystem.LevelValueList )
		-- 注册遗迹样式
		local style =
		{
			ID = "标准遗迹样式" ,
			Weight = 1 ,
			WallList = {} ,
			FloorList = {} ,
			DoorBaseChance = 10.0 ,
			BrokenWallChance = 0.19 ,
			BrokenWallHealth = 0.77 ,
			TurretChance = 1.0 ,
			BrokenTurretChance = 0.19 ,
			BrokenTurretHealth = 0.77
		}
		for level , levelValue in pairs( SIConstants_RuinSystem.LevelValueList ) do
			table.insert( style.WallList , { SIConstants_RuinSystem.raw.Entities.RuinWallPrefix .. level } )
			table.insert( style.FloorList , { SIConstants_RuinSystem.raw.Tiles.RuinFloor } )
		end
		SIRuinSystem.AddRuinStyle( style )
		-- 注册遗迹炮塔
		for name , prefix in pairs
		{
			["遗迹地雷"] = SIConstants_RuinSystem.raw.Entities.RuinLandMinePrefix ,
			["遗迹机枪炮塔"] = SIConstants_RuinSystem.raw.Entities.RuinGunTurretPrefix ,
			["遗迹激光炮塔"] = SIConstants_RuinSystem.raw.Entities.RuinLaserTurretPrefix ,
			["遗迹喷火炮塔"] = SIConstants_RuinSystem.raw.Entities.RuinFlameTurretPrefix
		} do
			local set =
			{
				ID = name ,
				Weight = 10000 ,
				List = {}
			}
			for level , levelValue in pairs( SIConstants_RuinSystem.LevelValueList ) do
				local list = { prefix .. level }
				if level > 1 then
					table.insert( list , prefix .. ( level - 1 ) )
				end
				if level < maxLevel then
					table.insert( list , prefix .. ( level + 1 ) )
				end
				table.insert( set.List , list )
			end
			SIRuinSystem.AddTurretSet( set )
		end
		-- 注册物品
		local itemPackDataList =
		{
			-- 等级 1
			{ { "iron-ore" , 0 , 300 } , { "copper-ore" , 0 , 300 } , { "stone" , 0 , 300 } , { "coal" , 0 , 300 } } ,
			{ { "wood" , 0 , 600 } , { "raw-fish" , 0 , 100 } , { "automation-science-pack" , 0 , 40 } } ,
			{ { "stone-furnace" , 0 , 15 } , { "stone-brick" , 0 , 400 } , { "landfill" , 0 , 100 } } ,
			-- 等级 2
			{ { "small-lamp" , 0 , 50 } , { "medium-electric-pole" , 0 , 10 } } ,
			{ { "firearm-magazine" , 0 , 100 } , { "grenade" , 0 , 25 } , { "repair-pack" , 0 , 40 } } ,
			{ { "electric-mining-drill" , 0 , 10 } , { "pipe" , 0 , 200 } , { "transport-belt" , 0 , 100 } } ,
			-- 等级 3
			{ { "assembling-machine-1" , 0 , 15 } , { "inserter" , 0 , 30 } , { "medium-electric-pole" , 0 , 20 } } ,
			{ { "small-lamp" , 0 , 20 } , { "rail" , 0 , 300 } } ,
			{ { "train-stop" , 0 , 10 } , { "rail-signal" , 0 , 100 } , { "rail-chain-signal" , 0 , 100 } } ,
			-- 等级 4
			{ { "assembling-machine-2" , 0 , 15 } , { "fast-inserter" , 0 , 30 } , { "solar-panel" , 0 , 40 } } ,
			{ { "boiler" , 0 , 10 } , { "steam-engine" , 0 , 20 } , { "accumulator" , 0 , 40 } } ,
			{ { "red-wire" , 0 , 150 } , { "green-wire" , 0 , 150 } , { "arithmetic-combinator" , 0 , 20 } , { "decider-combinator" , 0 , 20 } , { "constant-combinator" , 0 , 20 } } ,
			-- 等级 5
			{ { "logistic-science-pack" , 0 , 100 } , { "military-science-pack" , 0 , 100 } , { "chemical-science-pack" , 0 , 100 } } ,
			{ { "steel-furnace" , 0 , 15 } , { "long-handed-inserter" , 0 , 25 } , { "fast-transport-belt" , 0 , 100 } } ,
			{ { "iron-ore" , 0 , 1000 } , { "copper-ore" , 0 , 1000 } , { "stone" , 0 , 1000 } , { "coal" , 0 , 1000 } } ,
			-- 等级 6
			{ { "piercing-rounds-magazine" , 0 , 100 } , { "rocket" , 0 , 100 } , { "cannon-shell" , 0 , 100 } , { "flamethrower-ammo" , 0 , 100 } } ,
			{ { "oil-refinery" , 0 , 10 } , { "chemical-plant" , 0 , 30 } , { "lab" , 0 , 15 } , { "offshore-pump" , 0 , 10 } } ,
			{ { "advanced-circuit" , 0 , 120 } , { "electric-engine-unit" , 0 , 75 } } ,
			-- 等级 7
			{ { "assembling-machine-3" , 0 , 20 } , { "stack-inserter" , 0 , 35 } , { "express-transport-belt" , 0 , 100 } } ,
			{ { "copper-cable" , 0 , 200 } , { "cluster-grenade" , 0 , 85 } , { "engine-unit" , 0 , 200 } , { "rocket-fuel" , 0 , 60 } } ,
			{ { "centrifuge" , 0 , 10 } , { "processing-unit" , 0 , 25 } , { "low-density-structure" , 0 , 60 } } ,
			-- 等级 8
			{ { "uranium-rounds-magazine" , 0 , 100 } , { "explosive-rocket" , 0 , 100 } , { "explosive-cannon-shell" , 0 , 100 } , { "artillery-shell" , 0 , 30 } } ,
			{ { "satellite" , 1 , 1 } , { "battery" , 0 , 160 } } ,
			{ { "speed-module" , 0 , 20 } , { "effectivity-module" , 0 , 20 } , { "productivity-module" , 0 , 20 } } ,
			-- 等级 9
			{ { "beacon" , 0 , 15 } , { "artillery-turret" , 0 , 1 } , { "radar" , 0 , 10 } } ,
			{ { "rocket-silo" , 1 , 1 } }
		}
		local itemSet =
		{
			ID = "标准物资包" ,
			Weight = 10000 ,
			List = {}
		}
		for level , levelValue in pairs( SIConstants_RuinSystem.LevelValueList ) do
			local itemList = {}
			for itemPackIndex = 1 , math.min( level * 3 , #itemPackDataList ) , 1 do
				local itemPack =
				{
					Chest = SIConstants_RuinSystem.raw.Entities.RuinChestPrefix .. level ,
					Items = {}
				}
				for itemDataIndex , itemDataData in pairs( itemPackDataList[itemPackIndex] ) do
					local itemData =
					{
						Item = itemDataData[1] ,
						Min = itemDataData[2] * level ^ 1.4 ,
						Max = itemDataData[3] * level ^ 2.2
					}
					table.insert( itemPack.Items , itemData )
				end
				table.insert( itemList , itemPack )
			end
			table.insert( itemSet.List , itemList )
		end
		SIRuinSystem.AddItemSet( itemSet )
		-- 注册组装配方
		local recipeList = {}
		for index , data in pairs( SIConstants_RuinSystem.RuinRecipeData ) do
			table.insert( recipeList , SIConstants_RuinSystem.raw.Recipes["RuinRecipe_" .. data.ID] )
		end
		local machineSet =
		{
			ID = "遗迹组装机" ,
			Weight = 10000 ,
			List = {}
		}
		for level , levelValue in pairs( SIConstants_RuinSystem.LevelValueList ) do
			local machineDataList = {}
			for index , recipe in pairs( recipeList ) do
				local machineData =
				{
					Machine = SIConstants_RuinSystem.raw.Entities.RuinMachinePrefix .. level ,
					Recipe = recipe
				}
				table.insert( machineDataList , machineData )
			end
			table.insert( machineSet.List , machineDataList )
		end
		SIRuinSystem.AddMachineSet( machineSet )
		-- 注册市场
	end ,
	GetSurfaceSettings = function( globalSettings , surfaceIndex )
		local surfaceSettings = globalSettings.Surfaces[surfaceIndex]
		if not surfaceSettings then
			surfaceSettings =
			{
				OrderID = 0 ,
				Ruins = {} ,
				Controls =
				{
					RuinStyles        = {} ,
					TurretSets        = {} ,
					ItemSets          = {} ,
					MachineSets       = {} ,
					MarketSets        = {} ,
					SpecialEntitySets = {}
				} ,
				Weights =
				{
					RuinStyles        = 0 ,
					TurretSets        = 0 ,
					ItemSets          = 0 ,
					MachineSets       = 0 ,
					MarketSets        = 0 ,
					SpecialEntitySets = 0
				}
			}
			globalSettings.Surfaces[surfaceIndex] = surfaceSettings
		end
		return surfaceSettings
	end ,
	-- ======================================================================<br>
	-- 这是一个内部函数 , 请勿外部调用<br>
	-- ======================================================================<br>
	MakeRuinCenter = function( chunkPosition )
		return
		{
			x = chunkPosition.x * 32 + 16 ,
			y = chunkPosition.y * 32 + 16
		}
	end ,
	-- ======================================================================<br>
	-- 这是一个内部函数 , 请勿外部调用<br>
	-- ======================================================================<br>
	MakeRuinID = function( chunkPosition , orderID )
		local ruinID = SITools.NumberToString( chunkPosition.x + 1000000 , 5 ) .. "-" .. SITools.NumberToString( chunkPosition.y + 1000000 , 5 ) .. "-"
		if orderID then
			ruinID = ruinID .. orderID
		end
		return ruinID
	end ,
	-- ======================================================================<br>
	-- 这是一个内部函数 , 请勿外部调用<br>
	-- ======================================================================<br>
	GetRandomData = function( globalSettings , surfaceSettings , key )
		local random = math.floor( math.random() * ( globalSettings.Weights[key] + surfaceSettings.Weights[key] ) )
		for index , data in pairs( surfaceSettings.Controls[key] ) do
			random = random - data.Weight
			if random < 0 then
				return data
			end
		end
		for index , data in pairs( globalSettings.Controls[key] ) do
			random = random - data.Weight
			if random < 0 then
				return data
			end
		end
		return nil
	end ,
	-- ======================================================================<br>
	-- 这是一个内部函数 , 请勿外部调用<br>
	-- ======================================================================<br>
	CreateRuinInner = function( surface , globalSettings , surfaceSettings , chunkPosition , ruinCenter , ruinStyle , ruinStrength )
		-- 计算等级
		local levelRaw = math.log( ruinStrength / 10.0 , 2 )
		local level , levelSub = math.modf( levelRaw )
		if math.random() < levelSub then
			level = level + 1
		end
		level = math.max( level , 1 )
		-- 确定遗迹大小 , 半径
		local realSize = math.floor( math.min( level * 0.6 + 7 , 16 ) )
		local size = realSize - 0.5
		-- 获取地砖
		local floorListLength = #ruinStyle.FloorList
		local floorList = level > floorListLength and ruinStyle.FloorList[floorListLength] or ruinStyle.FloorList[level]
		if #floorList < 1 then
			SIPrint.Alert( nil , { "SIRuinSystem.遗迹构建-错误-无法读取遗迹地板" , ruinStyle.ID , ruinStrength , level , ruinCenter.x , ruinCenter.y } )
			return nil
		end
		local floor = floorList[math.random( #floorList )]
		if not prototypes.tile[floor] then
			SIPrint.Alert( nil , { "SIRuinSystem.遗迹构建-错误-遗迹地板不存在" , ruinStyle.ID , ruinStrength , level , ruinCenter.x , ruinCenter.y , floor } )
			return nil
		end
		-- 获取围墙
		local wallListLength = #ruinStyle.WallList
		local wallList = level > wallListLength and ruinStyle.WallList[wallListLength] or ruinStyle.WallList[level]
		if #wallList < 1 then
			SIPrint.Alert( nil , { "SIRuinSystem.遗迹构建-错误-无法读取遗迹围墙" , ruinStyle.ID , ruinStrength , level , ruinCenter.x , ruinCenter.y } )
			return nil
		end
		local wall = wallList[math.random( #wallList )]
		if not prototypes.entity[wall] then
			SIPrint.Alert( nil , { "SIRuinSystem.遗迹构建-错误-遗迹围墙不存在" , ruinStyle.ID , ruinStrength , level , ruinCenter.x , ruinCenter.y , wall } )
			return nil
		end
		-- 创建遗迹数据
		local ruinID = SIRuinSystem.MakeRuinID( chunkPosition , surfaceSettings.OrderID )
		local ruinData =
		{
			RuinID = ruinID ,
			Entities = {} ,
			Market = nil ,
			Goods = {}
		}
		surfaceSettings.OrderID = surfaceSettings.OrderID + 1
		-- surfaceSettings.Ruins[ruinID] = ruinData -- 暂不保存遗迹数据
		-- 清理区域内实体
		local entityList = surface.find_entities{ { ruinCenter.x - realSize , ruinCenter.y - realSize } , { ruinCenter.x + realSize - 1 , ruinCenter.y + realSize - 1 } }
		for index , entity in pairs( entityList ) do
			if entity.valid then
				entity.destroy
				{
					do_cliff_correction = true ,
					raise_destroy = true
				}
			end
		end
		-- 创建地板
		local tiles = {}
		for x = -size , size , 1 do
			for y = -size , size , 1 do
				-- 计算地板位置
				table.insert( tiles ,
				{
					name = floor ,
					position =
					{
						x = ruinCenter.x + x ,
						y = ruinCenter.y + y
					}
				} )
			end
		end
		surface.set_tiles( tiles , true , true , true , true )
		-- 创建墙壁
		local turretLocationList = {}
		local centerSize = math.fmod( realSize - 1 , 3 ) + 3
		centerSize = realSize - centerSize
		local centerTurretSize = centerSize - 1
		local doorBase = math.random() / ( ruinStyle.DoorBaseChance or 20.0 )
		local brokenWallChance = ruinStyle.BrokenWallChance or 0
		local brokenWallHealth = ruinStyle.BrokenWallHealth or 0.3
		local brokenWallHealthLast = 1.0 - brokenWallHealth
		local widthMergeNumber = 0
		local totalMergeNumber = 0
		for x = -size , size , 1 do
			local widthTier = size - math.abs( x )
			local widthLineFlag = widthTier <= centerSize and math.fmod( widthTier , 3 ) == 0
			local widthTurretFlag = widthTier <= centerTurretSize and math.fmod( widthTier , 3 ) == 1
			local widthTierMod = math.fmod( widthTier , 2 )
			widthMergeNumber = math.random()
			for y = -size , size , 1 do
				-- 计算围墙位置
				local heightTier = size - math.abs( y )
				local heightLineFlag = heightTier <= centerSize and math.fmod( heightTier , 3 ) == 0
				local heightTurretFlag = heightTier <= centerTurretSize and math.fmod( heightTier , 3 ) == 1
				local heightTierMod = math.fmod( heightTier , 2 )
				totalMergeNumber = widthMergeNumber * math.random()
				if widthLineFlag and widthTier <= heightTier or heightLineFlag and heightTier <= widthTier then
					if totalMergeNumber > doorBase then
						local wallEntity = surface.create_entity
						{
							name = wall ,
							position =
							{
								x = ruinCenter.x + x ,
								y = ruinCenter.y + y
							} ,
							direction = defines.direction.north ,
							force = "enemy" ,
							fast_replace = false ,
							raise_built = true ,
							create_build_effect_smoke = false ,
							spawn_decorations = false ,
							move_stuck_players = true
						}
						table.insert( ruinData.Entities , wallEntity )
						if brokenWallChance > 0 and math.random() < brokenWallChance then
							wallEntity.health = wallEntity.health * ( math.random() * brokenWallHealth + brokenWallHealthLast )
						end
					end
				end
				if widthTurretFlag and widthTier <= heightTier or heightTurretFlag and heightTier <= widthTier then
					if widthTierMod == 0 and heightTierMod == 0 or widthTierMod == 1 and heightTierMod == 1 then
						if ( x < 0 or x > 1 ) and ( y < 0 or y > 1 ) then
							table.insert( turretLocationList ,
							{
								x = x + ( x < 0 and 0.5 or -0.5 ) ,
								y = y + ( y < 0 and 0.5 or -0.5 )
							} )
						end
					end
				end
			end
		end
		-- 创建炮塔
		local turretChanceModifier = level * ( ruinStyle.TurretChance or 1 )
		local turretCount = -3
		local brokenTurretChance = ruinStyle.BrokenTurretChance or 0
		local brokenTurretHealth = ruinStyle.BrokenTurretHealth or 0.3
		local brokenTurretHealthLast = 1.0 - brokenTurretHealth
		while #turretLocationList > 0 and ( turretCount < 1 or math.random() * turretChanceModifier / turretCount ^ 0.5 > 0.19 ) do
			local turretLocationIndex = math.random( #turretLocationList )
			local turretLocation = turretLocationList[turretLocationIndex]
			table.remove( turretLocationList , turretLocationIndex )
			turretCount = turretCount + 1
			-- 读取炮塔数据
			local turretSet = SIRuinSystem.GetRandomData( globalSettings , surfaceSettings , SIRuinSystem.ControlNames.TurretSets )
			if turretSet then
				local turretListLength = #turretSet.List
				local turretList = level > turretListLength and turretSet.List[turretListLength] or turretSet.List[level]
				if #turretList > 0 then
					local turret = turretList[math.random( #turretList )]
					local turretPrototype = prototypes.entity[turret]
					if turretPrototype then
						local box = turretPrototype.collision_box
						local turretSize = math.floor( - box.left_top.x + box.right_bottom.x + 0.99 )
						if turretSize > 0 then
							if turretSize == 1 then
								for index , position in pairs
								{
									{
										x = ruinCenter.x + turretLocation.x + 0.5 ,
										y = ruinCenter.y + turretLocation.y + 0.5
									} ,
									{
										x = ruinCenter.x + turretLocation.x + 0.5 ,
										y = ruinCenter.y + turretLocation.y - 0.5
									} ,
									{
										x = ruinCenter.x + turretLocation.x - 0.5 ,
										y = ruinCenter.y + turretLocation.y + 0.5
									} ,
									{
										x = ruinCenter.x + turretLocation.x - 0.5 ,
										y = ruinCenter.y + turretLocation.y - 0.5
									}
								} do
									local turretEntity = surface.create_entity
									{
										name = turret ,
										position = position ,
										direction = SIRuinSystem.TurretDirection[math.random( 4 )] ,
										force = "enemy" ,
										fast_replace = false ,
										raise_built = true ,
										create_build_effect_smoke = false ,
										spawn_decorations = false ,
										move_stuck_players = true
									}
									table.insert( ruinData.Entities , turretEntity )
									if brokenTurretChance > 0 and math.random() < brokenTurretChance then
										turretEntity.health = turretEntity.health * ( math.random() * brokenTurretHealth + brokenTurretHealthLast )
									end
								end
							else
								local turretEntity = surface.create_entity
								{
									name = turret ,
									position =
									{
										x = ruinCenter.x + turretLocation.x ,
										y = ruinCenter.y + turretLocation.y
									} ,
									direction = SIRuinSystem.TurretDirection[math.random( 4 )] ,
									force = "enemy" ,
									fast_replace = false ,
									raise_built = true ,
									create_build_effect_smoke = false ,
									spawn_decorations = false ,
									move_stuck_players = true
								}
								table.insert( ruinData.Entities , turretEntity )
								if brokenTurretChance > 0 and math.random() < brokenTurretChance then
									turretEntity.health = turretEntity.health * ( math.random() * brokenTurretHealth + brokenTurretHealthLast )
								end
							end
						else
							SIPrint.Alert( nil , { "SIRuinSystem.遗迹构建-错误-遗迹炮塔体积过小" , ruinStyle.ID , ruinStrength , level , ruinCenter.x , ruinCenter.y , turretSet.ID , turret } )
						end
					else
						SIPrint.Alert( nil , { "SIRuinSystem.遗迹构建-错误-遗迹炮塔不存在" , ruinStyle.ID , ruinStrength , level , ruinCenter.x , ruinCenter.y , turretSet.ID , turret } )
					end
				else
					SIPrint.Alert( nil , { "SIRuinSystem.遗迹构建-错误-无法读取遗迹炮塔" , ruinStyle.ID , ruinStrength , level , ruinCenter.x , ruinCenter.y , turretSet.ID } )
				end
			else
				SIPrint.Alert( nil , { "SIRuinSystem.遗迹构建-错误-无法读取遗迹炮塔" , ruinStyle.ID , ruinStrength , level , ruinCenter.x , ruinCenter.y } )
			end
		end
		-- 中心位置
		local centerPositionList =
		{
			{ x = 1.5 , y = 1.5 } ,
			{ x = 1.5 , y = -1.5 } ,
			{ x = -1.5 , y = 1.5 } ,
			{ x = -1.5 , y = -1.5 }
		}
		-- 创建箱子
		local itemPositionIndex = math.random( #centerPositionList )
		local itemPosition = centerPositionList[itemPositionIndex]
		table.remove( centerPositionList , itemPositionIndex )
		local itemSet = SIRuinSystem.GetRandomData( globalSettings , surfaceSettings , SIRuinSystem.ControlNames.ItemSets )
		if itemSet then
			local itemPackListLength = #itemSet.List
			local itemPackList = level > itemPackListLength and itemSet.List[itemPackListLength] or itemSet.List[level]
			if #itemPackList > 0 then
				local itemPack = itemPackList[math.random( #itemPackList )]
				local chest = itemPack.Chest
				if prototypes.entity[chest] then
					-- 计算坐标
					local itemPositionXFlag = itemPosition.x < 0
					local itemPositionYFlag = itemPosition.y < 0
					itemPosition =
					{
						x = ruinCenter.x + itemPosition.x ,
						y = ruinCenter.y + itemPosition.y
					}
					-- 创建箱子
					local chestEntity = surface.create_entity
					{
						name = chest ,
						position = itemPosition ,
						direction = defines.direction.north ,
						force = "enemy" ,
						fast_replace = false ,
						raise_built = true ,
						create_build_effect_smoke = false ,
						spawn_decorations = false ,
						move_stuck_players = true
					}
					-- 创建爪子
					local xAdden = itemPositionXFlag and 1 or -1
					local chestInserter = surface.create_entity
					{
						name = SIConstants_RuinSystem.raw.Entities.RuinInserter ,
						position =
						{
							x = itemPosition.x + xAdden ,
							y = itemPosition.y
						} ,
						direction = defines.direction.north ,
						force = "enemy" ,
						fast_replace = false ,
						raise_built = true ,
						create_build_effect_smoke = false ,
						spawn_decorations = false ,
						move_stuck_players = true
					}
					chestInserter.pickup_position = itemPosition
					chestInserter.drop_position =
					{
						x = itemPosition.x + xAdden ,
						y = itemPosition.y + ( itemPositionYFlag and 0.9 or -0.9 )
					}
					table.insert( ruinData.Entities , chestEntity )
					table.insert( ruinData.Entities , chestInserter )
					-- 向箱子中装入物品
					local inventory = chestEntity.get_inventory( defines.inventory.chest )
					if inventory then
						for index , itemData in pairs( itemPack.Items ) do
							if prototypes.item[itemData.Item] then
								local count = itemData.Min >= itemData.Max and itemData.Min or math.random( itemData.Min , itemData.Max )
								if count > 0 then
									local itemStack =
									{
										name = itemData.Item ,
										count = count
									}
									if inventory.can_insert( itemStack ) then
										inventory.insert( itemStack )
									else
										break
									end
								end
							end
						end
					end
				end
			end
		end
		-- 创建组装机
		if math.random() < 0.062 * level then
			local machinePositionIndex = math.random( #centerPositionList )
			local machinePosition = centerPositionList[machinePositionIndex]
			table.remove( centerPositionList , machinePositionIndex )
			local machineSet = SIRuinSystem.GetRandomData( globalSettings , surfaceSettings , SIRuinSystem.ControlNames.MachineSets )
			if machineSet then
				local machineDataListLength = #machineSet.List
				local machineDataList = level > machineDataListLength and machineSet.List[machineDataListLength] or machineSet.List[level]
				if #machineDataList > 0 then
					local machineData = machineDataList[math.random( #machineDataList )]
					local machine = machineData.Machine
					if prototypes.entity[machine] then
						-- 计算坐标
						local machinePositionXFlag = machinePosition.x < 0
						local machinePositionYFlag = machinePosition.y < 0
						machinePosition =
						{
							x = ruinCenter.x + machinePosition.x + ( machinePositionXFlag and -0.5 or 0.5 ) ,
							y = ruinCenter.y + machinePosition.y + ( machinePositionYFlag and -0.5 or 0.5 )
						}
						-- 创建组装机
						local machineEntity = surface.create_entity
						{
							name = machine ,
							position = machinePosition ,
							direction = defines.direction.north ,
							force = "enemy" ,
							fast_replace = false ,
							raise_built = true ,
							create_build_effect_smoke = false ,
							spawn_decorations = false ,
							move_stuck_players = true ,
							recipe = machineData.Recipe
						}
						-- 创建爪子
						local xAdden = machinePositionXFlag and 1.5 or -1.5
						local machineInserter = surface.create_entity
						{
							name = SIConstants_RuinSystem.raw.Entities.RuinInserter ,
							position =
							{
								x = machinePosition.x + xAdden ,
								y = machinePosition.y + ( machinePositionYFlag and 0.5 or -0.5 )
							} ,
							direction = defines.direction.north ,
							force = "enemy" ,
							fast_replace = false ,
							raise_built = true ,
							create_build_effect_smoke = false ,
							spawn_decorations = false ,
							move_stuck_players = true
						}
						machineInserter.pickup_position = machinePosition
						machineInserter.drop_position =
						{
							x = machinePosition.x + xAdden ,
							y = machinePosition.y + ( machinePositionYFlag and 1.4 or -1.4 )
						}
						table.insert( ruinData.Entities , machineEntity )
						table.insert( ruinData.Entities , machineInserter )
					end
				end
			end
		end
		-- 创建市场
		-- 创建特殊实体
		return ruinID
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 接口函数 - 遗迹构建 =============================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================<br>
	-- 在指定世界中的指定区块的位置上生成一个遗迹<br>
	-- 无视所有生成遗迹的限制条件<br>
	-- 要求当前区块已经生成 , 无法在未生成区块的位置生成遗迹<br>
	-- ======================================================================<br>
	---@param surfaceIndex integer -- 世界索引
	---@param chunkPosition table -- 区块坐标 , 注意是区块坐标 , 不是实际坐标
	---@param ruinStyleID integer|string -- 遗迹布局类型 ID , 如果为 nil , 则为随机遗迹布局类型
	---@param ruinStrength number -- 遗迹的强度
	---@return integer|string|nil -- 遗迹的 ID , 如果没能成功创建遗迹则返回 nil
	CreateRuin = function( surfaceIndex , chunkPosition , ruinStyleID , ruinStrength )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRuinSystem.Settings.Name )
		local surfaceSettings = SIRuinSystem.GetSurfaceSettings( globalSettings , surfaceIndex )
		local ruinCenter = SIRuinSystem.MakeRuinCenter( chunkPosition )
		local ruinStyle = surfaceSettings.Controls.RuinStyles[ruinStyleID]
		if not ruinStyle then
			ruinStyle = globalSettings.Controls.RuinStyles[ruinStyleID]
		end
		if not ruinStyle then
			SIPrint.Alert( nil , { "SIRuinSystem.遗迹构建-错误-无效遗迹布局类型" } )
			return nil
		end
		local surface = game.get_surface( surfaceIndex )
		return SIRuinSystem.CreateRuinInner( surface , globalSettings , surfaceSettings , chunkPosition , ruinCenter , ruinStyle , ruinStrength )
	end ,

	-- ======================================================================<br>
	-- 在指定世界中的指定区块的位置上生成一个遗迹<br>
	-- 遵循所有生成遗迹的限制条件 , 使用随机遗迹布局类型<br>
	-- 要求当前区块已经生成 , 无法在未生成区块的位置生成遗迹<br>
	-- ======================================================================<br>
	---@param surfaceIndex integer -- 世界索引
	---@param chunkPosition table -- 区块坐标 , 注意是区块坐标 , 不是实际坐标
	---@return integer|string|nil -- 遗迹的 ID , 如果没能成功创建遗迹则返回 nil
	CreateRuinWithChance = function( surfaceIndex , chunkPosition )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRuinSystem.Settings.Name )
		local surfaceSettings = SIRuinSystem.GetSurfaceSettings( globalSettings , surfaceIndex )
		local ruinCenter = SIRuinSystem.MakeRuinCenter( chunkPosition )
		local distance = ( ruinCenter.x ^ 2 + ruinCenter.y ^ 2 ) ^ 0.5
		if distance < ( surfaceSettings.minRuinDistance or SIConfigs.SIRuinSystem.MinRuinDistance ) then
			return nil
		end
		if math.random() > ( surfaceSettings.ruinCreateChance or SIConfigs.SIRuinSystem.RuinCreateChance ) then
			return nil
		end
		local ruinStyle = SIRuinSystem.GetRandomData( globalSettings , surfaceSettings , SIRuinSystem.ControlNames.RuinStyles )
		if not ruinStyle then
			return nil
		end
		local surface = game.get_surface( surfaceIndex )
		local ruinStrength = ( surfaceSettings.ruinStrength or SIConfigs.SIRuinSystem.RuinStrength ) + distance / 32 * ( surfaceSettings.ruinStrengthAdden or SIConfigs.SIRuinSystem.RuinStrengthAdden )
		if ruinStrength > 20 then
			ruinStrength = ruinStrength ^ 1.5
		end
		return SIRuinSystem.CreateRuinInner( surface , globalSettings , surfaceSettings , chunkPosition , ruinCenter , ruinStyle , ruinStrength )
	end ,

	-- ======================================================================<br>
	-- 删除指定世界中的指定遗迹<br>
	-- ======================================================================<br>
	---@param surfaceIndex integer -- 世界索引
	---@param ruinID integer|string -- 遗迹的 ID
	RemoveRuin = function( surfaceIndex , ruinID )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRuinSystem.Settings.Name )
		local surfaceSettings = globalSettings.Surfaces[surfaceIndex]
		if surfaceSettings and surfaceSettings.Ruins[ruinID] then
			local ruinData = surfaceSettings.Ruins[ruinID]
			for index , entity in pairs( ruinData.Entities ) do
				if entity.valid then
					entity.destroy{ raise_destroy = true }
				end
			end
			surfaceSettings.Ruins[ruinID] = nil
		end
	end ,

	-- ======================================================================<br>
	-- 删除指定世界中的位于指定区块上的遗迹<br>
	-- ======================================================================<br>
	---@param surfaceIndex integer -- 世界索引
	---@param chunkPosition table -- 区块坐标 , 注意是区块坐标 , 不是实际坐标
	RemoveRuinWithChunk = function( surfaceIndex , chunkPosition )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRuinSystem.Settings.Name )
		local surfaceSettings = globalSettings.Surfaces[surfaceIndex]
		if surfaceSettings then
			local ruinIDPrefix = SIRuinSystem.MakeRuinID( chunkPosition , nil )
			for ruinID , ruinData in pairs( surfaceSettings.Ruins ) do
				if ruinID:StartsWith( ruinIDPrefix ) then
					for index , entity in pairs( ruinData.Entities ) do
						if entity.valid then
							entity.destroy{ raise_destroy = true }
						end
					end
					surfaceSettings.Ruins[ruinID] = nil
				end
			end
		end
	end ,

	-- ======================================================================<br>
	-- 删除指定世界中的所有遗迹<br>
	-- ======================================================================<br>
	---@param surfaceIndex integer -- 世界索引
	RemoveRuinWithSurface = function( surfaceIndex )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRuinSystem.Settings.Name )
		local surfaceSettings = globalSettings.Surfaces[surfaceIndex]
		if surfaceSettings then
			for ruinID , ruinData in pairs( surfaceSettings.Ruins ) do
				for index , entity in pairs( ruinData.Entities ) do
					if entity.valid then
						entity.destroy{ raise_destroy = true }
					end
				end
			end
			globalSettings.Surfaces[surfaceIndex] = nil
		end
	end ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 接口函数 - 遗迹控制 =============================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================<br>
	-- 设置每个世界的遗迹生成规律<br>
	-- 如果设置已存在 , 则会覆盖原来的值<br>
	-- ======================================================================<br>
	---@param surfaceIndex integer -- 世界索引
	---@param minRuinDistance number -- 安全距离 , 在这个距离内不会生成遗迹
	---@param ruinCreateChance number -- 每个新区块生成遗迹的概率 , 满足距离时才会判断概率
	---@param ruinStrength number -- 遗迹的起始强度系数
	---@param ruinStrengthAdden number -- 随着与地图中心的距离的增加而获得的额外遗迹强度系数 , 每 16 格增加一次
	SetSurfaceSettings = function( surfaceIndex , minRuinDistance , ruinCreateChance , ruinStrength , ruinStrengthAdden )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRuinSystem.Settings.Name )
		local surfaceSettings = SIRuinSystem.GetSurfaceSettings( globalSettings , surfaceIndex )
		surfaceSettings.minRuinDistance = minRuinDistance
		surfaceSettings.ruinCreateChance = ruinCreateChance
		surfaceSettings.ruinStrength = ruinStrength
		surfaceSettings.ruinStrengthAdden = ruinStrengthAdden
	end ,

	-- ======================================================================<br>
	-- 把一个世界的设置复制到另一个世界上<br>
	-- 如果作为复制源的世界设置不存在 , 则不会发生任何事情<br>
	-- ======================================================================<br>
	---@param oldSurfaceIndex integer -- 作为复制源的世界索引
	---@param newSurfaceIndex integer -- 作为复制目标的世界索引
	CopySurfaceSettings = function( oldSurfaceIndex , newSurfaceIndex )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRuinSystem.Settings.Name )
		local oldSurfaceSettings = globalSettings.Surfaces[oldSurfaceIndex]
		if oldSurfaceSettings then
			local newSurfaceSettings = SIRuinSystem.GetSurfaceSettings( globalSettings , newSurfaceIndex )
			newSurfaceSettings.Controls = SIUtils.table.deepcopy( oldSurfaceSettings.Controls )
			newSurfaceSettings.Weights = SIUtils.table.deepcopy( oldSurfaceSettings.Weights )
			newSurfaceSettings.minRuinDistance = oldSurfaceSettings.minRuinDistance
			newSurfaceSettings.ruinCreateChance = oldSurfaceSettings.ruinCreateChance
			newSurfaceSettings.ruinStrength = oldSurfaceSettings.ruinStrength
			newSurfaceSettings.ruinStrengthAdden = oldSurfaceSettings.ruinStrengthAdden
		end
	end ,

	-- ======================================================================<br>
	-- 设置每个世界可用的遗迹布局类型<br>
	-- 如果设置已存在 , 则会覆盖原来的值<br>
	-- ======================================================================<br>
	-- 遗迹布局类型数据的结构如下 :<br>
	-- ID                 = 遗迹布局的 ID<br>
	-- Weight             = 随机到这个遗迹布局的权重<br>
	-- WallList           = 围墙列表 , 本身是一个二维数组 , 对应从 1 到 n 级的围墙数组 , 如果遗迹等级超过 n , 则选取最高等级的围墙数组 , 每个围墙数组都可以包含多种围墙类型 , 每次只会使用一种围墙<br>
	-- FloorList          = 地板列表 , 结构同围墙 , 每次只会使用一种围墙<br>
	-- DoorBaseChance     = 围墙中出现门 (缺口) 的概率 , 值越大门越少 , 值为 1 时平均一半的围墙会变成门 , 值特别小时会导致遗迹全都是门没有围墙<br>
	-- BrokenWallChance   = 遗迹的围墙中残血围墙的比例 , 小数<br>
	-- BrokenWallHealth   = 残血围墙的血量浮动范围 , 小数 , 浮动范围为 [此值] 至 1.0 (满血)<br>
	-- TurretChance       = 遗迹中出现炮塔的概率 , 遗迹中至少出现 4 个炮塔 , 此后炮塔数量和遗迹等级相关 , 此值越高 , 最终炮塔数量越多<br>
	-- BrokenTurretChance = 遗迹的炮塔中残血炮塔的比例 , 小数<br>
	-- BrokenTurretHealth = 残血炮塔的血量浮动范围 , 小数 , 浮动范围为 [此值] 至 1.0 (满血)<br>
	-- ======================================================================<br>
	---@param ruinStyle table -- 遗迹布局类型数据
	---@param surfaceIndexList table|nil -- 世界索引的数组 , 如果为 nil 则全部世界都会使用
	AddRuinStyle = function( ruinStyle , surfaceIndexList )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRuinSystem.Settings.Name )
		local ID = ruinStyle.ID
		ruinStyle.Weight = ruinStyle.Weight or 1
		if surfaceIndexList then
			for index , surfaceIndex in pairs( surfaceIndexList ) do
				local surfaceSettings = SIRuinSystem.GetSurfaceSettings( globalSettings , surfaceIndex )
				if surfaceSettings.Controls.RuinStyles[ID] then
					surfaceSettings.Weights.RuinStyles = surfaceSettings.Weights.RuinStyles - surfaceSettings.Controls.RuinStyles[ID].Weight
				end
				surfaceSettings.Controls.RuinStyles[ID] = ruinStyle
				surfaceSettings.Weights.RuinStyles = surfaceSettings.Weights.RuinStyles + ruinStyle.Weight
			end
		else
			if globalSettings.Controls.RuinStyles[ID] then
				globalSettings.Weights.RuinStyles = globalSettings.Weights.RuinStyles - globalSettings.Controls.RuinStyles[ID].Weight
			end
			globalSettings.Controls.RuinStyles[ID] = ruinStyle
			globalSettings.Weights.RuinStyles = globalSettings.Weights.RuinStyles + ruinStyle.Weight
		end
	end ,

	-- ======================================================================<br>
	-- 设置每个世界可用的炮塔类型<br>
	-- 如果设置已存在 , 则会覆盖原来的值<br>
	-- ======================================================================<br>
	-- 炮塔类型数据的结构如下 :<br>
	-- ID                 = 炮塔类型的 ID<br>
	-- Weight             = 随机到这个炮塔类型的权重<br>
	-- List               = 炮塔列表 , 本身是一个二维数组 , 对应从 1 到 n 级的炮塔数组 , 如果遗迹等级超过 n , 则选取最高等级的炮塔数组 , 每个炮塔数组都可以包含多种炮塔类型 , 每个炮塔位置都会重新随机选择<br>
	-- ======================================================================<br>
	---@param turretSet table -- 炮塔类型数据
	---@param surfaceIndexList table|nil -- 世界索引的数组 , 如果为 nil 则全部世界都会使用
	AddTurretSet = function( turretSet , surfaceIndexList )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRuinSystem.Settings.Name )
		local ID = turretSet.ID
		turretSet.Weight = turretSet.Weight or 1
		if surfaceIndexList then
			for index , surfaceIndex in pairs( surfaceIndexList ) do
				local surfaceSettings = SIRuinSystem.GetSurfaceSettings( globalSettings , surfaceIndex )
				if surfaceSettings.Controls.TurretSets[ID] then
					surfaceSettings.Weights.TurretSets = surfaceSettings.Weights.TurretSets - surfaceSettings.Controls.TurretSets[ID].Weight
				end
				surfaceSettings.Controls.TurretSets[ID] = turretSet
				surfaceSettings.Weights.TurretSets = surfaceSettings.Weights.TurretSets + turretSet.Weight
			end
		else
			if globalSettings.Controls.TurretSets[ID] then
				globalSettings.Weights.TurretSets = globalSettings.Weights.TurretSets - globalSettings.Controls.TurretSets[ID].Weight
			end
			globalSettings.Controls.TurretSets[ID] = turretSet
			globalSettings.Weights.TurretSets = globalSettings.Weights.TurretSets + turretSet.Weight
		end
	end ,

	-- ======================================================================<br>
	-- 设置每个世界可用的物品补给类型<br>
	-- 如果设置已存在 , 则会覆盖原来的值<br>
	-- ======================================================================<br>
	-- 物品补给类型数据的结构如下 :<br>
	-- ID                 = 物品补给类型的 ID<br>
	-- Weight             = 随机到这个物品补给类型的权重<br>
	-- List               = 物品列表 , 本身是一个二维数组 , 对应从 1 到 n 级的物品数据数组 , 如果遗迹等级超过 n , 则选取最高等级的物品数据数组 , 每个物品数据数组都可以包含多种物品数据 , 每个遗迹固定生成一个物品补给<br>
	-- ======================================================================<br>
	-- 物品数据的结构如下 :<br>
	-- Chest              = 盛放物品的箱子实体的名称 , 请确保箱子可以装下所有的物品 , 需要 1x1 的箱子<br>
	-- Items              = 物品包裹数据的列表 , 数组<br>
	-- ======================================================================<br>
	-- 物品包裹数据的结构如下 :<br>
	-- Item               = 物品原型的名称<br>
	-- Min                = 物品数量的最小值<br>
	-- Max                = 物品数量的最大值<br>
	-- ======================================================================<br>
	---@param itemSet table -- 物品补给类型数据
	---@param surfaceIndexList table|nil -- 世界索引的数组 , 如果为 nil 则全部世界都会使用
	AddItemSet = function( itemSet , surfaceIndexList )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRuinSystem.Settings.Name )
		local ID = itemSet.ID
		itemSet.Weight = itemSet.Weight or 1
		if surfaceIndexList then
			for index , surfaceIndex in pairs( surfaceIndexList ) do
				local surfaceSettings = SIRuinSystem.GetSurfaceSettings( globalSettings , surfaceIndex )
				if surfaceSettings.Controls.ItemSets[ID] then
					surfaceSettings.Weights.ItemSets = surfaceSettings.Weights.ItemSets - surfaceSettings.Controls.ItemSets[ID].Weight
				end
				surfaceSettings.Controls.ItemSets[ID] = itemSet
				surfaceSettings.Weights.ItemSets = surfaceSettings.Weights.ItemSets + itemSet.Weight
			end
		else
			if globalSettings.Controls.ItemSets[ID] then
				globalSettings.Weights.ItemSets = globalSettings.Weights.ItemSets - globalSettings.Controls.ItemSets[ID].Weight
			end
			globalSettings.Controls.ItemSets[ID] = itemSet
			globalSettings.Weights.ItemSets = globalSettings.Weights.ItemSets + itemSet.Weight
		end
	end ,

	-- ======================================================================<br>
	-- 设置每个世界可用的组装机类型<br>
	-- 如果设置已存在 , 则会覆盖原来的值<br>
	-- ======================================================================<br>
	-- 组装机类型数据的结构如下 :<br>
	-- ID                 = 组装机类型的 ID<br>
	-- Weight             = 随机到这个组装机类型的权重<br>
	-- List               = 组装机配方列表 , 本身是一个二维数组 , 对应从 1 到 n 级的组装机数据数组 , 如果遗迹等级超过 n , 则选取最高等级的组装机数据数组 , 每个组装机数据数组都可以包含多种组装机数据 , 每个遗迹概率生成一个组装机<br>
	-- ======================================================================<br>
	-- 组装机数据的结构如下 :<br>
	-- Machine            = 组装机实体的名称 , 请务必和配方匹配 , 需要 2x2 的组装机<br>
	-- Recipe             = 组装机使用的配方<br>
	-- ======================================================================<br>
	---@param machineSet table -- 组装机类型数据
	---@param surfaceIndexList table|nil -- 世界索引的数组 , 如果为 nil 则全部世界都会使用
	AddMachineSet = function( machineSet , surfaceIndexList )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRuinSystem.Settings.Name )
		local ID = machineSet.ID
		machineSet.Weight = machineSet.Weight or 1
		if surfaceIndexList then
			for index , surfaceIndex in pairs( surfaceIndexList ) do
				local surfaceSettings = SIRuinSystem.GetSurfaceSettings( globalSettings , surfaceIndex )
				if surfaceSettings.Controls.MachineSets[ID] then
					surfaceSettings.Weights.MachineSets = surfaceSettings.Weights.MachineSets - surfaceSettings.Controls.MachineSets[ID].Weight
				end
				surfaceSettings.Controls.MachineSets[ID] = machineSet
				surfaceSettings.Weights.MachineSets = surfaceSettings.Weights.MachineSets + machineSet.Weight
			end
		else
			if globalSettings.Controls.MachineSets[ID] then
				globalSettings.Weights.MachineSets = globalSettings.Weights.MachineSets - globalSettings.Controls.MachineSets[ID].Weight
			end
			globalSettings.Controls.MachineSets[ID] = machineSet
			globalSettings.Weights.MachineSets = globalSettings.Weights.MachineSets + machineSet.Weight
		end
	end ,

	-- ======================================================================<br>
	-- 设置每个世界可用的市场类型<br>
	-- 如果设置已存在 , 则会覆盖原来的值<br>
	-- ======================================================================<br>
	-- 待定义
	-- ======================================================================<br>
	---@param marketSet table -- 市场类型数据
	---@param surfaceIndexList table|nil -- 世界索引的数组 , 如果为 nil 则全部世界都会使用
	AddMarketSet = function( marketSet , surfaceIndexList )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRuinSystem.Settings.Name )
		local ID = marketSet.ID
		marketSet.Weight = marketSet.Weight or 1
		if surfaceIndexList then
			for index , surfaceIndex in pairs( surfaceIndexList ) do
				local surfaceSettings = SIRuinSystem.GetSurfaceSettings( globalSettings , surfaceIndex )
				if surfaceSettings.Controls.MarketSets[ID] then
					surfaceSettings.Weights.MarketSets = surfaceSettings.Weights.MarketSets - surfaceSettings.Controls.MarketSets[ID].Weight
				end
				surfaceSettings.Controls.MarketSets[ID] = marketSet
				surfaceSettings.Weights.MarketSets = surfaceSettings.Weights.MarketSets + marketSet.Weight
			end
		else
			if globalSettings.Controls.MarketSets[ID] then
				globalSettings.Weights.MarketSets = globalSettings.Weights.MarketSets - globalSettings.Controls.MarketSets[ID].Weight
			end
			globalSettings.Controls.MarketSets[ID] = marketSet
			globalSettings.Weights.MarketSets = globalSettings.Weights.MarketSets + marketSet.Weight
		end
	end ,

	-- ======================================================================<br>
	-- 设置每个世界可用的特殊实体类型<br>
	-- 如果设置已存在 , 则会覆盖原来的值<br>
	-- ======================================================================<br>
	-- 待定义
	-- ======================================================================<br>
	---@param specialEntitySet table -- 特殊实体类型数据
	---@param surfaceIndexList table|nil -- 世界索引的数组 , 如果为 nil 则全部世界都会使用
	AddSpecialEntitySet = function( specialEntitySet , surfaceIndexList )
		local globalSettings = SIGlobal.GetGlobalSettings( SIRuinSystem.Settings.Name )
		local ID = specialEntitySet.ID
		specialEntitySet.Weight = specialEntitySet.Weight or 1
		if surfaceIndexList then
			for index , surfaceIndex in pairs( surfaceIndexList ) do
				local surfaceSettings = SIRuinSystem.GetSurfaceSettings( globalSettings , surfaceIndex )
				if surfaceSettings.Controls.SpecialEntitySets[ID] then
					surfaceSettings.Weights.SpecialEntitySets = surfaceSettings.Weights.SpecialEntitySets - surfaceSettings.Controls.SpecialEntitySets[ID].Weight
				end
				surfaceSettings.Controls.SpecialEntitySets[ID] = specialEntitySet
				surfaceSettings.Weights.SpecialEntitySets = surfaceSettings.Weights.SpecialEntitySets + specialEntitySet.Weight
			end
		else
			if globalSettings.Controls.SpecialEntitySets[ID] then
				globalSettings.Weights.SpecialEntitySets = globalSettings.Weights.SpecialEntitySets - globalSettings.Controls.SpecialEntitySets[ID].Weight
			end
			globalSettings.Controls.SpecialEntitySets[ID] = specialEntitySet
			globalSettings.Weights.SpecialEntitySets = globalSettings.Weights.SpecialEntitySets + specialEntitySet.Weight
		end
	end
}
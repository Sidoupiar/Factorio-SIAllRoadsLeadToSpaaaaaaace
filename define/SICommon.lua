-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 定义数据 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

---@class SICommon
SICommon =
{
	Colors =
	{
		Base =
		{
			BASE_WHITE      = { r = 1.00 , g = 1.00 , b = 1.00 , a = 1.00 } , -- 纯白
			BASE_BLACK      = { r = 0.00 , g = 0.00 , b = 0.00 , a = 1.00 } , -- 纯黑
			YELLOW          = { r = 1.00 , g = 0.78 , b = 0.00 , a = 1.00 } , -- 黄色
			WHITE           = { r = 0.88 , g = 0.88 , b = 0.88 , a = 1.00 } , -- 白色
			RED             = { r = 0.82 , g = 0.00 , b = 0.00 , a = 1.00 } , -- 红色
			GREEN           = { r = 0.31 , g = 0.90 , b = 0.00 , a = 1.00 } , -- 绿色
			CLAY            = { r = 0.12 , g = 0.88 , b = 0.78 , a = 1.00 } , -- 青色
			BLUE            = { r = 0.12 , g = 0.27 , b = 0.86 , a = 1.00 } , -- 蓝色
			PINK            = { r = 0.94 , g = 0.35 , b = 0.67 , a = 1.00 } , -- 粉色
			PURPLE          = { r = 0.67 , g = 0.00 , b = 0.67 , a = 1.00 } , -- 紫色
			ORANGE          = { r = 0.94 , g = 0.55 , b = 0.00 , a = 1.00 } , -- 橙色
			GRAY            = { r = 0.50 , g = 0.50 , b = 0.50 , a = 1.00 }   -- 灰色
		} ,
		Print =
		{
			WHITE           = { r = 0.88 , g = 0.88 , b = 0.88 , a = 1.00 } , -- 白色
			RED             = { r = 1.00 , g = 0.40 , b = 0.40 , a = 1.00 } , -- 红色
			GREEN           = { r = 0.45 , g = 0.94 , b = 0.09 , a = 1.00 } , -- 绿色
			BLUE            = { r = 0.28 , g = 0.64 , b = 0.96 , a = 1.00 } , -- 蓝色
			YELLOW          = { r = 1.00 , g = 1.00 , b = 0.40 , a = 1.00 } , -- 黄色
			ORANGE          = { r = 1.00 , g = 0.70 , b = 0.40 , a = 1.00 }   -- 橙色
		} ,
		DamageBeam =
		{
			Physical        = { r = 0.90 , g = 0.65 , b = 0.22 , a = 1.00 } , -- 物理伤害
			Impact          = { r = 0.50 , g = 0.50 , b = 0.50 , a = 1.00 } ,
			Poison          = { r = 0.43 , g = 0.86 , b = 0.24 , a = 1.00 } ,
			Explosion       = { r = 0.90 , g = 0.06 , b = 0.65 , a = 1.00 } ,
			Fire            = { r = 0.90 , g = 0.31 , b = 0.06 , a = 1.00 } ,
			Laser           = { r = 0.92 , g = 0.16 , b = 0.16 , a = 1.00 } ,
			Acid            = { r = 0.84 , g = 0.92 , b = 0.16 , a = 1.00 } ,
			Electric        = { r = 0.06 , g = 0.41 , b = 0.90 , a = 1.00 } ,
			Curse           = { r = 0.15 , g = 0.15 , b = 0.15 , a = 1.00 } ,
			Other           = { r = 1.00 , g = 1.00 , b = 1.00 , a = 1.00 }
		} ,
		Equipment =
		{
			Default         = { r = 0.35 , g = 0.35 , b = 0.35 , a = 0.30 } ,
			DefaultHover    = { r = 0.55 , g = 0.55 , b = 0.55 , a = 0.30 } ,
			Border          = { r = 0.10 , g = 0.10 , b = 0.10 , a = 1.00 } ,
			-- 各种类别的模块的背景颜色
			Generator       = { r = 0.04 , g = 0.37 , b = 0.29 , a = 0.30 } ,
			GeneratorHover  = { r = 0.11 , g = 0.48 , b = 0.38 , a = 0.30 } ,
			Building        = { r = 0.03 , g = 0.27 , b = 0.39 , a = 0.30 } ,
			BuildingHover   = { r = 0.10 , g = 0.39 , b = 0.54 , a = 0.30 } ,
			Modify          = { r = 0.36 , g = 0.28 , b = 0.05 , a = 0.30 } ,
			ModifyHover     = { r = 0.49 , g = 0.38 , b = 0.10 , a = 0.30 } ,
			Attack          = { r = 0.42 , g = 0.12 , b = 0.04 , a = 0.30 } ,
			AttackHover     = { r = 0.52 , g = 0.17 , b = 0.08 , a = 0.30 }
		} ,
		Tint =
		{
			DEFAULT         = { r = 0.30 , g = 0.30 , b = 0.30 , a = 0.30 }   -- 深灰
		} ,
		Font =
		{
			Title           = { r = 1.00 , g = 0.90 , b = 0.75 , a = 1.00 } , -- 标题 , 浅橘黄
			Default         = { r = 1.00 , g = 1.00 , b = 1.00 , a = 1.00 } , -- 默认颜色
			BLACK           = { r = 0.00 , g = 0.00 , b = 0.00 , a = 1.00 } , -- 黑色
			RED             = { r = 1.00 , g = 0.00 , b = 0.00 , a = 1.00 } , -- 红色
			YELLOW          = { r = 1.00 , g = 1.00 , b = 0.00 , a = 1.00 } , -- 黄色
			GREEN           = { r = 0.00 , g = 1.00 , b = 0.00 , a = 1.00 } , -- 绿色
			-- 禁用颜色
			Disable_Default = { r = 1.00 , g = 1.00 , b = 1.00 , a = 0.50 }   -- 默认颜色 , 禁用
		} ,
		Dirt =
		{
			-- 特殊颜色
			DEFAULT         = { r = 0.01 , g = 0.01 , b = 0.01 , a = 0.40 } , -- 默认颜色
			SHADOW          = { r = 0.00 , g = 0.00 , b = 0.00 , a = 0.35 } , -- 影子颜色
			GLOW            = { r = 0.90 , g = 0.70 , b = 0.40 , a = 1.00 } , -- 光亮颜色
			Filler          = { r = 0.06 , g = 0.03 , b = 0.01 , a = 0.22 } , -- 填充颜色
			-- 基础颜色
			BLACK           = { r = 0.00 , g = 0.00 , b = 0.00 , a = 1.00 } , -- 黑色
			GRAY            = { r = 0.90 , g = 0.90 , b = 0.30 , a = 0.50 } , -- 灰色
			GREEN           = { r = 0.35 , g = 1.00 , b = 0.35 , a = 0.50 } , -- 绿色
			RED             = { r = 1.00 , g = 0.35 , b = 0.35 , a = 0.50 } , -- 红色
			BLUE            = { r = 0.35 , g = 0.70 , b = 0.95 , a = 0.50 } , -- 蓝色
			PURPLE          = { r = 0.90 , g = 0.50 , b = 0.90 , a = 0.50 } , -- 紫色
			ORANGE          = { r = 0.90 , g = 0.55 , b = 0.35 , a = 0.50 } , -- 橙色
			YELLOW          = { r = 0.90 , g = 0.85 , b = 0.35 , a = 0.50 }   -- 黄色
		}
	} ,
	SettingTypes =
	{
		BOOL    = "bool-setting" ,
		INT     = "int-setting" ,
		DOUBLE  = "double-setting" ,
		STRING  = "string-setting"
	} ,
	SettingAffectTypes =
	{
		StartUp = "startup" ,
		Runtime = "runtime-global:" ,
		PerUser = "runtime-per-user"
	} ,
	SettingUnitTypes =
	{
		Point   = { "SICommon.SettingsDescriptionUnitPoint" } ,
		Block   = { "SICommon.SettingsDescriptionUnitBlock" } ,
		Tick    = { "SICommon.SettingsDescriptionUnitTick" }
	} ,
	Flags =
	{
		Item =
		{
			NotStackable                            = "not-stackable" ,
			DrawLogisticOverlay                     = "draw-logistic-overlay" ,
			AlwaysShow                              = "always-show" ,
			HideFromBonusGUI                        = "hide-from-bonus-gui" ,
			HideFromFuelTooltip                     = "hide-from-fuel-tooltip" ,
			PrimaryPlaceResult                      = "primary-place-result" ,
			ModOpenable                             = "mod-openable" ,
			OnlyInCursor                            = "only-in-cursor" ,
			Spawnable                               = "spawnable" ,
			ExcludedFromTrashUnrequested            = "excluded-from-trash-unrequested" ,
			SpoilResult                             = "spoil-result" ,
			IgnoreSpoilTimeModifier                 = "ignore-spoil-time-modifier"
		} ,
		Entity =
		{
			NoCopyPaste                             = "no-copy-paste" ,
			NoGapFill                               = "no-gap-fill-while-building" ,
			NoAutomatedItemRemoval                  = "no-automated-item-removal" ,
			NoAutomatedItemInsertion                = "no-automated-item-insertion" ,
			NotOnMap                                = "not-on-map" ,
			NotInMadeIn                             = "not-in-made-in" ,
			NotFlammable                            = "not-flammable" ,
			NotRotatable                            = "not-rotatable" ,
			NotRepairable                           = "not-repairable" ,
			NotBlueprintable                        = "not-blueprintable" ,
			NotDeconstructable                      = "not-deconstructable" ,
			NotUpgradable                           = "not-upgradable" ,
			NotSelectableInGame                     = "not-selectable-in-game" ,
			NotInKillStatistics                     = "not-in-kill-statistics" ,
			PlaceableEnemy                          = "placeable-enemy" ,
			PlaceablePlayer                         = "placeable-player" ,
			PlaceableNeutral                        = "placeable-neutral" ,
			PlaceableOffGrid                        = "placeable-off-grid" ,
			HideAltInfo                             = "hide-alt-info" ,
			FastReplaceableBuild                    = "fast-replaceable-no-build-while-moving" ,
			FastReplaceableCross                    = "fast-replaceable-no-cross-type-while-moving" ,
			Building8Way                            = "building-direction-8-way" ,
			BuildingDirection16Way                  = "building-direction-16-way" ,
			BreathsAir                              = "breaths-air" ,
			PlayerCreation                          = "player-creation" ,
			FilterDirections                        = "filter-directions" ,
			GetByUnitNumber                         = "get-by-unit-number" ,
			SnapToRailSupportSpot                   = "snap-to-rail-support-spot"
		} ,
		RenderLayer =
		{
			WaterTile                               = "water-tile" ,
			GroundTile                              = "ground-tile" ,
			TileTransition                          = "tile-transition" ,
			Decals                                  = "decals" ,
			LowerRadiusVisualization                = "lower-radius-visualization" ,
			RadiusVisualization                     = "radius-visualization" ,
			TransportBeltIntegration                = "transport-belt-integration" ,
			Resource                                = "resource" ,
			BuildingSmoke                           = "building-smoke" ,
			Decorative                              = "decorative" ,
			GroundPatch                             = "ground-patch" ,
			GroundPatchHigher                       = "ground-patch-higher" ,
			GroundPatchHigher2                      = "ground-patch-higher2" ,
			Remnants                                = "remnants" ,
			Floor                                   = "floor" ,
			TransportBelt                           = "transport-belt" ,
			TransportBeltEndings                    = "transport-belt-endings" ,
			FloorMechanicsUnderCorpse               = "floor-mechanics-under-corpse" ,
			Corpse                                  = "corpse" ,
			FloorMechanics                          = "floor-mechanics" ,
			Item                                    = "item" ,
			LowerObject                             = "lower-object" ,
			TransportBeltCircuitConnector           = "transport-belt-circuit-connector" ,
			LowerObjectAboveShadow                  = "lower-object-above-shadow" ,
			Object                                  = "object" ,
			HigherObjectUnder                       = "higher-object-under" ,
			HigherObjectAbove                       = "higher-object-above" ,
			ItemInInserterHand                      = "item-in-inserter-hand" ,
			Wires                                   = "wires" ,
			WiresAbove                              = "wires-above" ,
			EntityInfoIcon                          = "entity-info-icon" ,
			EntityInfoIconAbove                     = "entity-info-icon-above" ,
			Explosion                               = "explosion" ,
			Projectile                              = "projectile" ,
			Smoke                                   = "smoke" ,
			AirObject                               = "air-object" ,
			AirEntityInfoIcon                       = "air-entity-info-icon" ,
			LightEffect                             = "light-effect" ,
			SelectionBox                            = "selection-box" ,
			HigherSelectionBox                      = "higher-selection-box" ,
			CollisionSelectionBox                   = "collision-selection-box" ,
			Arrow                                   = "arrow" ,
			Cursor                                  = "cursor"
		} ,
		TechnologyModifier =
		{
			-- 通用效果
			Nothing                                 = "nothing" ,                           -- 无效果
			GiveItem                                = "give-item" ,                         -- 获得物品
			UnlockRecipe                            = "unlock-recipe" ,                     -- 解锁配方
			UnlockSpaceLocation                     = "unlock-space-location" ,             -- 解锁太空地址 , 区域 , 星球等
			SpacePlatforms                          = "unlock-space-platforms" ,            -- 解锁太空平台
			UnlockQuality                           = "unlock-quality" ,                    -- 解锁品质
			CircuitNetwork                          = "unlock-circuit-network" ,            -- 解锁信号网络
			-- 全局加成
			ChangeRecipeProductivity                = "change-recipe-productivity" ,        -- 配方产能加成
			InserterStackSizeBonus                  = "inserter-stack-size-bonus" ,         -- 爪子抓取数量
			BulkInserterCapacityBonusModifier       = "bulk-inserter-capacity-bonus" ,      -- 堆叠爪子抓取数量
			BeltStackSizeBonus                      = "belt-stack-size-bonus" ,             -- 传送带堆叠数量
			MiningDrillProductivityBonus            = "mining-drill-productivity-bonus" ,   -- 矿机开采产能
			TrainBrakingForceBonus                  = "train-braking-force-bonus" ,         -- 火车刹车力度
			LaboratorySpeed                         = "laboratory-speed" ,                  -- 研究球速度
			LaboratoryProductivity                  = "laboratory-productivity" ,           -- 研究球产能
			AmmoDamage                              = "ammo-damage" ,                       -- 子弹攻击力
			TurretAttack                            = "turret-attack" ,                     -- 炮塔攻击力
			GunSpeed                                = "gun-speed" ,                         -- 武器攻击速度
			ArtilleryRange                          = "artillery-range" ,                   -- 重炮射程
			CargoLandingPadLimit                    = "cargo-landing-pad-count" ,           -- 物流接驳站数量限制
--			StackInserterCapacityBonus              = "stack-inserter-capacity-bonus" ,
			-- 机器人相关
			MaximumFollowingRobotsCount             = "maximum-following-robots-count" ,    -- 机器人最大跟随数量
			FollowerRobotLifetime                   = "follower-robot-lifetime" ,           -- 跟随中的机器人的存在时间
			WorkerRobotSpeed                        = "worker-robot-speed" ,                -- 机器人飞行速度
			WorkerRobotStorage                      = "worker-robot-storage" ,              -- 机器人搬运量
			WorkerRobotBattery                      = "worker-robot-battery" ,              -- 机器人电池容量
			-- 建设与拆除
			VehicleLogistics                        = "vehicle-logistics" ,                 -- 载具物流请求许可
			MiningWithFluid                         = "mining-with-fluid" ,                 -- 开采需要流体的矿物的许可
			RailSupportOnDeepOilOcean               = "rail-support-on-deep-oil-ocean" ,    -- 在重油海上建设铁路的许可
			RailPlannerAllowElevatedRails           = "rail-planner-allow-elevated-rails" , -- 建设高架铁路的许可
			BeaconDistribution                      = "beacon-distribution" ,               -- 插件塔分配许可
			CreateGhostOnEntityDeath                = "create-ghost-on-entity-death" ,      -- 实体死亡时在原地生成蓝图虚影许可
			DeconstructionTimeToLive                = "deconstruction-time-to-live" ,       -- 红图标记存在时间
			CliffDeconstructionEnabled              = "cliff-deconstruction-enabled" ,      -- 红图标记悬崖许可
--			GhostTimeToLive                         = "ghost-time-to-live" ,
			-- 玩家属性
			CharacterHealthBonus                    = "character-health-bonus" ,            -- 玩家生命值
			CharacterInventorySlotsBonus            = "character-inventory-slots-bonus" ,   -- 玩家背包格子数量
			CharacterCraftingSpeed                  = "character-crafting-speed" ,          -- 玩家手搓速度
			CharacterMiningSpeed                    = "character-mining-speed" ,            -- 玩家挖掘速度
			CharacterRunningSpeed                   = "character-running-speed" ,           -- 玩家移动速度
			CharacterBuildDistance                  = "character-build-distance" ,          -- 玩家建造距离
			CharacterReachDistance                  = "character-reach-distance" ,          -- 玩家操作设备距离
			CharacterResourceReachDistance          = "character-resource-reach-distance" , -- 玩家操作资源距离
			CharacterItemDropDistance               = "character-item-drop-distance" ,      -- 玩家丢弃物品距离
			CharacterItemPickupDistance             = "character-item-pickup-distance" ,    -- 玩家拾取普通物品距离
			CharacterLootPickupDistance             = "character-loot-pickup-distance" ,    -- 玩家拾取掉落物品距离
			CharacterLogisticTrashSlots             = "character-logistic-trash-slots" ,    -- 玩家回收区域格子数量
			CharacterLogisticRequests               = "character-logistic-requests" ,       -- 玩家物流请求许可
--			CharacterAdditionalMiningCategories     = "character-additional-mining-categories" ,
--			-- 地图操作
--			ZoomToWorldEnabled                      = "zoom-to-world-enabled" ,
--			ZoomToWorldGhostBuildingEnabled         = "zoom-to-world-ghost-building-enabled" ,
--			ZoomToWorldBlueprintEnabled             = "zoom-to-world-blueprint-enabled" ,
--			ZoomToWorldDeconstructionPlannerEnabled = "zoom-to-world-deconstruction-planner-enabled" ,
--			ZoomToWorldUpgradePlannerEnabled        = "zoom-to-world-upgrade-planner-enabled" ,
--			ZoomToWorldSelectionToolEnabled         = "zoom-to-world-selection-tool-enabled" ,
			-- 未知效果
			MaxFailedAttemptsPerTickPerConstructionQueue     = "max-failed-attempts-per-tick-per-construction-queue" ,
			MaxSuccessfulAttemptsPerTickPerConstructionQueue = "max-successful-attempts-per-tick-per-construction-queue"
		} ,
		Direction =
		{
			North           = "north" ,
			East            = "east" ,
			South           = "south" ,
			West            = "west"
		} ,
		TrackType =
		{
			EarlyGame       = "early-game" , -- 载入游戏
			MenuTrack       = "menu-track" , -- 主菜单
			MainTrack       = "main-track" , -- 游戏阶段
			Interlude       = "interlude"    -- 插曲
		} ,
		SciencePack =
		{
			Key             = "description.science-pack-remaining-amount-key" ,
			Value           = "description.science-pack-remaining-amount-value"
		} ,
		ProductType =
		{
			Material        = "material" ,
			Resource        = "resource" ,
			Unit            = "unit"
		} ,
		Condition =
		{
			AND             = "and" ,
			OR              = "or" ,
			NOT             = "not"
		} ,
		LogisticMode =
		{
			None            = "none" ,
			Requester       = "requester" ,
			ActiveProvider  = "active-provider" ,
			PassiveProvider = "passive-provider" ,
			Buffer          = "buffer" ,
			Storage         = "storage"
		} ,
		FluidBox_ProductionType =
		{
			None            = "none" ,
			Input           = "input" ,
			Output          = "output" ,
			InputOutput     = "input-output"
		} ,
		FluidBox_FlowDirection =
		{
			Input           = "input" ,
			Output          = "output" ,
			InputOutput     = "input-output"
		} ,
		FluidBox_PipeConnectionType =
		{
			Normal          = "normal" ,
			Underground     = "underground" ,
			Linked          = "linked"
		} ,
		FluidBox_Direction =
		{
			North           = defines.direction.north ,
			NorthNorthEast  = defines.direction.northnortheast ,
			NorthEast       = defines.direction.northeast ,
			EastNorthEast   = defines.direction.eastnortheast ,
			East            = defines.direction.east ,
			EastSouthEast   = defines.direction.eastsoutheast ,
			SouthEast       = defines.direction.southeast ,
			SouthSouthEast  = defines.direction.southsoutheast ,
			South           = defines.direction.south ,
			SouthSouthWest  = defines.direction.southsouthwest ,
			SouthWest       = defines.direction.southwest ,
			WestSouthWest   = defines.direction.westsouthwest ,
			West            = defines.direction.west ,
			WestNorthWest   = defines.direction.westnorthwest ,
			NorthWest       = defines.direction.northwest ,
			NorthNorthWest  = defines.direction.northnorthwest
		} ,
		EquipmentShapeType =
		{
			Full            = "full" ,
			Manual          = "manual"
		} ,
		EnergySourceType =
		{
			Electric        = "electric" ,
			Burner          = "burner" ,
			Heat            = "heat" ,
			Fluid           = "fluid" ,
			Void            = "void"
		} ,
		ElectricUsagePriority =
		{
			InputPrimary    = "primary-input" ,
			InputSecondary  = "secondary-input" ,
			OutputPrimary   = "primary-output" ,
			OutputSecondary = "secondary-output" ,
			Tertiary        = "tertiary" ,
			Solar           = "solar" ,
			Lamp            = "lamp"
		}
	} ,
	Numbers =
	{
		IconPictureScale          = 0.25 ,
		-- 堆叠数量
		StackSizeMin              = 1 ,
		StackSizeMax              = 1000000000 ,
		StackSizeAdditionMin      = -1000000000 ,
		StackSizeAdditionMax      = 1000000000 ,
		-- 火箭发射数量
		RocketSizeMin             = 1 ,
		RocketSizeMax             = 1000000000 ,
		-- 数量数值
		CountMin                  = 1 ,
		CountMax                  = 100000000 ,
		-- 倍率
		MultiplierMin             = 0 ,
		MultiplierMax             = 1000000000 ,
		-- 耐久
		DurabilityMin             = 0.00001 ,
		DurabilityMax             = 1000000000.0 ,
		-- 持续时间
		DurationMin               = 1 ,
		DurationMax               = 100000 ,
		-- 速度
		SpeedMin                  = 0.00001 ,
		SpeedMax                  = 1000000000.0 ,
		-- 距离
		DistanceMin               = 1 ,
		DistanceMax               = 1000000000 ,
		-- 一些原版的限制值
		PlayerQuickBarSlotCount   = 100 ,
		PlayerRequestBarSlotCount = 100 ,
		UpgradeMapSlotCount       = 24
	} ,
	Types =
	{
		-- 原型类型
		Group                   = "item-group" ,
		Subgroup                = "item-subgroup" ,
		Fluid                   = "fluid" ,
		Tile                    = "tile" ,
		Signal                  = "virtual-signal" ,
		Recipe                  = "recipe" ,
		Technology              = "technology" ,
		DamageType              = "damage-type" ,
		EquipmentGrid           = "equipment-grid" ,
		Decorative              = "optimized-decorative" ,
		Impact                  = "impact-category" , -- 这个原型只有 type 和 name
		Input                   = "custom-input" ,
		AmbientSound            = "ambient-sound" ,
		Font                    = "font" ,
		ControlAutoplace        = "autoplace-control" ,
		Sprite                  = "sprite" ,
		Style                   = "gui-style" ,
		Constants               = "utility-constants" ,
		-- 原型列表
		Categories =
		{
			Ammo                = "ammo-category" ,
			Deliver             = "deliver-category" ,
			Equipment           = "equipment-category" ,
			Fuel                = "fuel-category" ,
			Module              = "module-category" ,
			Recipe              = "recipe-category" ,
			Resource            = "resource-category"
		} ,
		Items =
		{
			Item                = "item" ,
			ItemEntity          = "item-with-entity-data" ,
			Tool                = "tool" ,
			ToolRepair          = "repair-tool" ,
			RailPlanner         = "rail-planner" ,
			Ammo                = "ammo" ,
			Armor               = "armor" ,
			Capsule             = "capsule" ,
			Gun                 = "gun" ,
			Module              = "module" ,
			MiningTool          = "mining-tool" ,
			Blueprint           = "blueprint" ,
			BlueprintBook       = "blueprint-book" ,
			Redprint            = "deconstruction-item" ,
			SelectionTool       = "selection-tool" ,
			CopyPasteTool       = "copy-paste-tool" ,
			ItemTag             = "item-with-tags" ,
			ItemLabel           = "item-with-label" ,
			ItemInventory       = "item-with-inventory"
		} ,
		StackableItems =
		{
			Item                = "item" ,
			ItemEntity          = "item-with-entity-data" ,
			Tool                = "tool" ,
			ToolRepair          = "repair-tool" ,
			RailPlanner         = "rail-planner" ,
			Ammo                = "ammo" ,
			Capsule             = "capsule" ,
			Gun                 = "gun" ,
			Module              = "module"
		} ,
		UnstackableItems =
		{
			Armor               = "armor" ,
			Blueprint           = "blueprint" ,
			BlueprintBook       = "blueprint-book" ,
			Redprint            = "deconstruction-item" ,
			SelectionTool       = "selection-tool" ,
			ItemTag             = "item-with-tags" ,
			ItemLabel           = "item-with-label" ,
			ItemInventory       = "item-with-inventory"
		} ,
		IconableItems =
		{
			Item                = "item" ,
			ItemEntity          = "item-with-entity-data" ,
			Tool                = "tool" ,
			Ammo                = "ammo" ,
			Armor               = "armor" ,
			Capsule             = "capsule" ,
			Gun                 = "gun" ,
			Module              = "module" ,
			-- 因为产物可以有流体 , 所以也把流体加在了这里
			Fluid               = "fluid"
		} ,
		Entities =
		{
			Fire                = "fire" ,
			Beam                = "beam" ,
			Sticker             = "sticker" ,
			Projectile          = "projectile" ,
			Particle            = "particle" ,
			Cliff               = "cliff" ,
			Resource            = "resource" ,           -- 矿物
			Tree                = "tree" ,
			Character           = "character" ,
			Fish                = "fish" ,
			Unit                = "unit" ,
			Spawner             = "unit-spawner" ,
			Corpse              = "corpse" ,
			CorpseCharacter     = "character-corpse" ,
			Boiler              = "boiler" ,             -- 锅炉
			Generator           = "generator" ,          -- 发电机
			BurnerGenerator     = "burner-generator" ,   -- 燃烧发电机
			Solar               = "solar-panel" ,
			Reactor             = "reactor" ,
			Accumulator         = "accumulator" ,
			AccumulatorInfinity = "electric-energy-interface" ,
			Pump                = "pump" ,               -- 泵
			PumpOffshore        = "offshore-pump" ,
			Mining              = "mining-drill" ,       -- 矿机
			Furnace             = "furnace" ,            -- 熔炉
			Machine             = "assembling-machine" , -- 组装机
			Lab                 = "lab" ,
			Beacon              = "beacon" ,
			Market              = "market" ,
			RocketSilo          = "rocket-silo" ,
			RocketRocket        = "rocket-silo-rocket" ,
			RocketShadow        = "rocket-silo-rocket-shadow" ,
			Belt                = "transport-belt" ,
			BeltGround          = "underground-belt" ,
			BeltLinked          = "linked-belt" ,
			BeltLoader          = "loader" ,
			BeltLoaderSmall     = "loader-1x1" ,
			BeltSplitter        = "splitter" ,
			Pipe                = "pipe" ,               -- 管道
			PipeGround          = "pipe-to-ground" ,
			PipeInfinity        = "infinity-pipe" ,
			PipeHeat            = "heat-pipe" ,
			PipeHeatInfinity    = "heat-interface" ,
			RailStraight        = "straight-rail" ,
			RailCurved          = "curved-rail" ,
			RailStop            = "train-stop" ,
			RailSign            = "rail-signal" ,
			RailChain           = "rail-chain-signal" ,
			Inserter            = "inserter" ,
			Container           = "container" ,
			ContainerLogic      = "logistic-container" ,
			ContainerLinked     = "linked-container" ,
			ContainerFluid      = "storage-tank" ,
			ContainerInfinity   = "infinity-container" ,
			Pole                = "electric-pole" ,
			PowerSwitch         = "power-switch" ,
			Lamp                = "lamp" ,
			Car                 = "car" ,
			SpiderVehicle       = "spider-vehicle" ,
			SpiderLeg           = "spider-leg" ,
			WagonLocomotive     = "locomotive" ,
			WagonCargo          = "cargo-wagon" ,
			WagonFluid          = "fluid-wagon" ,
			WagonArtillery      = "artillery-wagon" ,
			RobotConstruct      = "construction-robot" , -- 建设机器人
			RobotLogistic       = "logistic-robot" ,     -- 物流机器人
			RobotCombat         = "combat-robot" ,       -- 攻击机器人
			Roboport            = "roboport" ,           -- 指令平台
			PlayerPort          = "player-port" ,
			Radar               = "radar" ,
			Wall                = "wall" ,
			Gate                = "gate" ,
			Turret              = "turret" ,
			TurretAmmo          = "ammo-turret" ,
			TurretElectric      = "electric-turret" ,
			TurretFluid         = "fluid-turret" ,
			TurretArtillery     = "artillery-turret" ,
			LandMine            = "land-mine" ,
			CombArithmetic      = "arithmetic-combinator" ,
			CombDecider         = "decider-combinator" ,
			CombConstant        = "constant-combinator" ,
			Speaker             = "programmable-speaker" ,
			SimpleEntity        = "simple-entity" ,
			SimpleForce         = "simple-entity-with-force" ,
			SimpleOwner         = "simple-entity-with-owner" ,
			SpeechBubble        = "speech-bubble" ,
			GhostEntity         = "entity-ghost" ,
			GhostTile           = "tile-ghost" ,
			ProxyDeconsTile     = "deconstructible-tile-proxy" ,
			ProxyItemRequest    = "item-request-proxy" ,
			Highlight           = "highlight-box" ,
			Flame               = "flame-thrower-explosion" ,
			Arrow               = "arrow" ,
			Flare               = "artillery-flare" ,
			Smoke               = "trivial-smoke" ,
			Stream              = "stream" ,
			ItemEntity          = "item-entity"
		} ,
		HealthEntities =
		{
			Tree                = "tree" ,
			Character           = "character" ,
			Fish                = "fish" ,
			Unit                = "unit" ,
			Spawner             = "unit-spawner" ,
			Boiler              = "boiler" ,             -- 锅炉
			Generator           = "generator" ,          -- 发电机
			BurnerGenerator     = "burner-generator" ,   -- 燃烧发电机
			Solar               = "solar-panel" ,
			Reactor             = "reactor" ,
			Accumulator         = "accumulator" ,
			AccumulatorInfinity = "electric-energy-interface" ,
			Pump                = "pump" ,               -- 泵
			PumpOffshore        = "offshore-pump" ,
			Mining              = "mining-drill" ,       -- 矿机
			Furnace             = "furnace" ,            -- 熔炉
			Machine             = "assembling-machine" , -- 组装机
			Lab                 = "lab" ,
			Beacon              = "beacon" ,
			Market              = "market" ,
			RocketSilo          = "rocket-silo" ,
			Belt                = "transport-belt" ,
			BeltGround          = "underground-belt" ,
			BeltLinked          = "linked-belt" ,
			BeltLoader          = "loader" ,
			BeltLoaderSmall     = "loader-1x1" ,
			BeltSplitter        = "splitter" ,
			Pipe                = "pipe" ,
			PipeGround          = "pipe-to-ground" ,
			PipeInfinity        = "infinity-pipe" ,
			PipeHeat            = "heat-pipe" ,
			PipeHeatInfinity    = "heat-interface" ,
			RailStraight        = "straight-rail" ,
			RailCurved          = "curved-rail" ,
			RailStop            = "train-stop" ,
			RailSign            = "rail-signal" ,
			RailChain           = "rail-chain-signal" ,
			Inserter            = "inserter" ,
			Container           = "container" ,
			ContainerLogic      = "logistic-container" ,
			ContainerLinked     = "linked-container" ,
			ContainerFluid      = "storage-tank" ,
			ContainerInfinity   = "infinity-container" ,
			Pole                = "electric-pole" ,
			PowerSwitch         = "power-switch" ,
			Lamp                = "lamp" ,
			Car                 = "car" ,
			SpiderVehicle       = "spider-vehicle" ,
			SpiderLeg           = "spider-leg" ,
			WagonLocomotive     = "locomotive" ,
			WagonCargo          = "cargo-wagon" ,
			WagonFluid          = "fluid-wagon" ,
			WagonArtillery      = "artillery-wagon" ,
			RobotConstruct      = "construction-robot" ,
			RobotLogistic       = "logistic-robot" ,
			RobotCombat         = "combat-robot" ,
			Roboport            = "roboport" ,
			PlayerPort          = "player-port" ,
			Radar               = "radar" ,
			Wall                = "wall" ,
			Gate                = "gate" ,
			Turret              = "turret" ,
			TurretAmmo          = "ammo-turret" ,
			TurretElectric      = "electric-turret" ,
			TurretFluid         = "fluid-turret" ,
			TurretArtillery     = "artillery-turret" ,
			LandMine            = "land-mine" ,
			CombArithmetic      = "arithmetic-combinator" ,
			CombDecider         = "decider-combinator" ,
			CombConstant        = "constant-combinator" ,
			Speaker             = "programmable-speaker" ,
			SimpleEntity        = "simple-entity" ,
			SimpleForce         = "simple-entity-with-force" ,
			SimpleOwner         = "simple-entity-with-owner" ,
		} ,
		FreelocEntities =
		{
			Boiler              = "boiler" ,             -- 锅炉
			Generator           = "generator" ,          -- 发电机
			BurnerGenerator     = "burner-generator" ,   -- 燃烧发电机
			Solar               = "solar-panel" ,
			Reactor             = "reactor" ,
			Accumulator         = "accumulator" ,
			AccumulatorInfinity = "electric-energy-interface" ,
			Pump                = "pump" ,               -- 泵
			PumpOffshore        = "offshore-pump" ,
			Mining              = "mining-drill" ,       -- 矿机
			Furnace             = "furnace" ,            -- 熔炉
			Machine             = "assembling-machine" , -- 组装机
			Lab                 = "lab" ,
			Beacon              = "beacon" ,
			Market              = "market" ,
			RocketSilo          = "rocket-silo" ,
			Belt                = "transport-belt" ,
			BeltGround          = "underground-belt" ,
			BeltLinked          = "linked-belt" ,
			BeltLoader          = "loader" ,
			BeltLoaderSmall     = "loader-1x1" ,
			BeltSplitter        = "splitter" ,
			Pipe                = "pipe" ,
			PipeGround          = "pipe-to-ground" ,
			PipeInfinity        = "infinity-pipe" ,
			PipeHeat            = "heat-pipe" ,
			PipeHeatInfinity    = "heat-interface" ,
			RailStraight        = "straight-rail" ,
			RailCurved          = "curved-rail" ,
			RailStop            = "train-stop" ,
			RailSign            = "rail-signal" ,
			RailChain           = "rail-chain-signal" ,
			Inserter            = "inserter" ,
			Container           = "container" ,
			ContainerLogic      = "logistic-container" ,
			ContainerLinked     = "linked-container" ,
			ContainerFluid      = "storage-tank" ,
			ContainerInfinity   = "infinity-container" ,
			Pole                = "electric-pole" ,
			PowerSwitch         = "power-switch" ,
			Lamp                = "lamp" ,
			Roboport            = "roboport" ,
			PlayerPort          = "player-port" ,
			Radar               = "radar" ,
			Wall                = "wall" ,
			Gate                = "gate" ,
			Turret              = "turret" ,
			TurretAmmo          = "ammo-turret" ,
			TurretElectric      = "electric-turret" ,
			TurretFluid         = "fluid-turret" ,
			TurretArtillery     = "artillery-turret" ,
			CombArithmetic      = "arithmetic-combinator" ,
			CombDecider         = "decider-combinator" ,
			CombConstant        = "constant-combinator" ,
			Speaker             = "programmable-speaker"
		} ,
		WeaponEntities = -- 使用 gun 发射武器的实体
		{
			Car                 = "car" ,
			SpiderVehicle       = "spider-vehicle" ,
			WagonArtillery      = "artillery-wagon" ,
			TurretArtillery     = "artillery-turret"
		} ,
		TurretEntities = -- 使用 attack_parameters 发射武器的实体
		{
			RobotCombat         = "combat-robot" ,
			Turret              = "turret" ,
			TurretAmmo          = "ammo-turret" ,
			TurretElectric      = "electric-turret" ,
			TurretFluid         = "fluid-turret"
		} ,
		Machines =
		{
			Pump                = "pump" ,               -- 泵
			Furnace             = "furnace" ,            -- 熔炉
			Machine             = "assembling-machine"   -- 组装机
		} ,
		ContainerEntities =
		{
			Character           = "character" ,
			Container           = "container" ,
			ContainerLogic      = "logistic-container" ,
			ContainerLinked     = "linked-container" ,
			Car                 = "car" ,
			SpiderVehicle       = "spider-vehicle" ,
			WagonCargo          = "cargo-wagon" ,
			WagonArtillery      = "artillery-wagon" ,
			TurretAmmo          = "ammo-turret" ,
		} ,
		Equipments =
		{
			Base                = "equipment" , -- 此项不能使用
			Night               = "night-vision-equipment" ,
			Shield              = "energy-shield-equipment" ,
			Battery             = "battery-equipment" ,
			Solar               = "solar-panel-equipment" ,
			GeneratorEquip      = "generator-equipment" ,
			ActiveDefense       = "active-defense-equipment" ,
			Movement            = "movement-bonus-equipment" ,
			Roboport            = "roboport-equipment" ,
			BeltImmunity        = "belt-immunity-equipment"
		} ,
		All = {} ,
		Raw = {}
	} ,
	SelectPriority =
	{
		Train = 51
	} ,
	CodeName       = {} ,
	CodeNamePrefix = {} ,
	CodeNameSuffix = {} ,
	ShowName       = {} ,
	ShowNamePrefix = {} ,
	ShowNameSuffix = {}
}

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 自动生成类型相关的数据 ==========================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

for type , real in pairs
{
	Group            = { Code = "Groups"            , Show = "分组"} ,
	Fluid            = { Code = "Fluids"            , Show = "流体"} ,
	Tile             = { Code = "Tiles"             , Show = "地板"} ,
	Signal           = { Code = "Signals"           , Show = "信号"} ,
	Recipe           = { Code = "Recipes"           , Show = "配方"} ,
	Technology       = { Code = "Technologies"      , Show = "科技"} ,
	DamageType       = { Code = "DamageTypes"       , Show = "伤害"} ,
	EquipmentGrid    = { Code = "EquipmentGrids"    , Show = "区域"} ,
	Decorative       = { Code = "Decoratives"       , Show = "遮盖"} ,
	Input            = { Code = "Inputs"            , Show = "按键"} ,
	AmbientSound     = { Code = "EmbientSounds"     , Show = "音乐"} ,
	Font             = { Code = "Fonts"             , Show = "字体"} ,
	ControlAutoplace = { Code = "ControlAutoplaces" , Show = "放置"} ,
	Sprite           = { Code = "Sprites"           , Show = "图片"} ,
	Categories       = { Code = "Categories"        , Show = "类别"} ,
	Items            = { Code = "Items"             , Show = "物品"} ,
	Entities         = { Code = "Entities"          , Show = "实体"} ,
	Equipments       = { Code = "Equipments"        , Show = "模块"}
} do
	if SITools.IsTable( SICommon.Types[type] ) then
		---@diagnostic disable-next-line: param-type-mismatch
		for key , value in pairs( SICommon.Types[type] ) do
			SICommon.Types.All[key] = value
			SICommon.Types.Raw[value] = real.Code
			SICommon.CodeName[value] = real.Code
			SICommon.CodeNamePrefix[value] = real.Code .. "-"
			SICommon.ShowName[value] = real.Show
			SICommon.ShowNamePrefix[value] = real.Show .. "-"
		end
	else
		SICommon.Types.All[type] = SICommon.Types[type]
		SICommon.Types.Raw[SICommon.Types[type]] = real.Code
		SICommon.CodeName[SICommon.Types[type]] = real.Code
		SICommon.CodeNamePrefix[SICommon.Types[type]] = real.Code .. "-"
		SICommon.ShowName[SICommon.Types[type]] = real.Show
		SICommon.ShowNamePrefix[SICommon.Types[type]] = real.Show .. "-"
	end
end

for type , real in pairs
{
	ICON  = { Code = "Icon" , Show = "图标" } ,
	HrVer = { Code = "HR"   , Show = "高清" }
} do
	SICommon.CodeName[type] = real.Code
	SICommon.CodeNamePrefix[type] = real.Code .. "-"
	SICommon.CodeNameSuffix[type] = "-" .. real.Code
	SICommon.ShowName[type] = real.Show
	SICommon.ShowNamePrefix[type] = real.Show .. "-"
	SICommon.ShowNameSuffix[type] = "-" .. real.Show
end

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 自动填充各种相关的数据 ==========================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 定义类型相关的数值 ==============================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SICommon.Numbers.IconSettings =
{
	[SICommon.Types.Group] =
	{
		size = 64,
		mipmaps = 0
	} ,
	[SICommon.Types.Technology] =
	{
		size = 256,
		mipmaps = 4
	} ,
	Default =
	{
		size = 64,
		mipmaps = 4
	}
}

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 翻转定义项的键值对 ==========================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

for index , listData in pairs
{
	{ Source = SICommon.Types , ListKey = "StackableItems" }
} do
	local reverseList = {}
	listData.Source[listData.ListKey .. "_Reverse"] = reverseList
	---@diagnostic disable-next-line: param-type-mismatch
	for key , value in pairs( listData.Source[listData.ListKey] ) do
		reverseList[value] = key
	end
end
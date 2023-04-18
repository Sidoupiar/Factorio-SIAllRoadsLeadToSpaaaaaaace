---@diagnostic disable: param-type-mismatch

-- ------------------------------------------------------------------------------------------------
-- ---------- 定义数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

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
		BOOL = "bool" ,
		INT = "int" ,
		DOUBLE = "double" ,
		STRING = "string"
	} ,
	SettingAffectTypes =
	{
		StartUp = "startup" ,
		Runtime = "runtime-global:" ,
		PerUser = "runtime-per-user"
	} ,
	Flags =
	{
		Item =
		{
			Hidden               = "hidden" ,
			NotStackable         = "not-stackable" ,
			DrawLogisticOverlay  = "draw-logistic-overlay" ,
			AlwaysShow           = "always-show" ,
			HideFromBonusGUI     = "hide-from-bonus-gui" ,
			HideFromFuelTooltip  = "hide-from-fuel-tooltip" ,
			CanExtendInventory   = "can-extend-inventory" ,
			PrimaryPlaceResult   = "primary-place-result" ,
			ModOpenable          = "mod-openable" ,
			OnlyInCursor         = "only-in-cursor" ,
			Spawnable            = "spawnable"
		} ,
		Entity =
		{
			Hidden               = "hidden" ,
			NoGapFill            = "no-gap-fill-while-building" ,
			NotOnMap             = "not-on-map" ,
			NotFlammable         = "not-flammable" ,
			NotRotatable         = "not-rotatable" ,
			NotRepairable        = "not-repairable" ,
			NotBlueprintable     = "not-blueprintable" ,
			NotDeconstructable   = "not-deconstructable" ,
			PlaceableEnemy       = "placeable-enemy" ,
			PlaceablePlayer      = "placeable-player" ,
			PlaceableNeutral     = "placeable-neutral" ,
			PlaceableOffGrid     = "placeable-off-grid" ,
			HideAltInfo          = "hide-alt-info" ,
			HideFromBonus        = "hide-from-bonus-gui" ,
			FastReplaceableBuild = "fast-replaceable-no-build-while-moving" ,
			FastReplaceableCross = "fast-replaceable-no-cross-type-while-moving" ,
			Building8Way         = "building-direction-8-way" ,
			BreathsAir           = "breaths-air" ,
			PlayerCreation       = "player-creation" ,
			FilterDirections     = "filter-directions"
		} ,
		Direction =
		{
			North = "north" ,
			East  = "east" ,
			South = "south" ,
			West  = "west"
		} ,
		CollisionMask =
		{
			Ground        = "ground-tile" ,
			Water         = "water-tile" ,
			Resource      = "resource-layer" ,
			Doodad        = "doodad-layer" ,
			Floor         = "floor-layer" ,
			Item          = "item-layer" ,
			Ghost         = "ghost-layer" ,
			Object        = "object-layer" ,
			Player        = "player-layer" ,
			Train         = "train-layer" ,
			Rail          = "rail-layer" ,
			TransportBelt = "transport-belt-layer" ,
			_13           = "layer-13" ,
			_14           = "layer-14" ,
			_15           = "layer-15" ,
			_16           = "layer-16" ,
			_17           = "layer-17" ,
			_18           = "layer-18" ,
			_19           = "layer-19" ,
			_20           = "layer-20" ,
			_21           = "layer-21" ,
			_22           = "layer-22" ,
			_23           = "layer-23" ,
			_24           = "layer-24" ,
			_25           = "layer-25" ,
			_26           = "layer-26" ,
			_27           = "layer-27" ,
			_28           = "layer-28" ,
			_29           = "layer-29" ,
			_30           = "layer-30" ,
			_31           = "layer-31" ,
			_32           = "layer-32" ,
			_33           = "layer-33" ,
			_34           = "layer-34" ,
			_35           = "layer-35" ,
			_36           = "layer-36" ,
			_37           = "layer-37" ,
			_38           = "layer-38" ,
			_39           = "layer-39" ,
			_40           = "layer-40" ,
			_41           = "layer-41" ,
			_42           = "layer-42" ,
			_43           = "layer-43" ,
			_44           = "layer-44" ,
			_45           = "layer-45" ,
			_46           = "layer-46" ,
			_47           = "layer-47" ,
			_48           = "layer-48" ,
			_49           = "layer-49" ,
			_50           = "layer-50" ,
			_51           = "layer-51" ,
			_52           = "layer-52" ,
			_53           = "layer-53" ,
			_54           = "layer-54" ,
			_55           = "layer-55" ,
			NotCollidingWithItself  = "not-colliding-with-itself" ,
			ConsiderTileTransitions = "consider-tile-transitions" ,
			CollidingWithTilesOnly  = "colliding-with-tiles-only"
		} ,
		RenderLayer =
		{
			WaterTile                     = "water-tile" ,
			GroundTile                    = "ground-tile" ,
			TileTransition                = "tile-transition" ,
			Decals                        = "decals" ,
			LowerRadiusVisualization      = "lower-radius-visualization" ,
			RadiusVisualization           = "radius-visualization" ,
			TransportBeltIntegration      = "transport-belt-integration" ,
			Resource                      = "resource" ,
			BuildingSmoke                 = "building-smoke" ,
			Decorative                    = "decorative" ,
			GroundPatch                   = "ground-patch" ,
			GroundPatchHigher             = "ground-patch-higher" ,
			GroundPatchHigher2            = "ground-patch-higher2" ,
			Remnants                      = "remnants" ,
			Floor                         = "floor" ,
			TransportBelt                 = "transport-belt" ,
			TransportBeltEndings          = "transport-belt-endings" ,
			FloorMechanicsUnderCorpse     = "floor-mechanics-under-corpse" ,
			Corpse                        = "corpse" ,
			FloorMechanics                = "floor-mechanics" ,
			Item                          = "item" ,
			LowerObject                   = "lower-object" ,
			TransportBeltCircuitConnector = "transport-belt-circuit-connector" ,
			LowerObjectAboveShadow        = "lower-object-above-shadow" ,
			Object                        = "object" ,
			HigherObjectUnder             = "higher-object-under" ,
			HigherObjectAbove             = "higher-object-above" ,
			ItemInInserterHand            = "item-in-inserter-hand" ,
			Wires                         = "wires" ,
			WiresAbove                    = "wires-above" ,
			EntityInfoIcon                = "entity-info-icon" ,
			EntityInfoIconAbove           = "entity-info-icon-above" ,
			Explosion                     = "explosion" ,
			Projectile                    = "projectile" ,
			Smoke                         = "smoke" ,
			AirObject                     = "air-object" ,
			AirEntityInfoIcon             = "air-entity-info-icon" ,
			LightEffect                   = "light-effect" ,
			SelectionBox                  = "selection-box" ,
			HigherSelectionBox            = "higher-selection-box" ,
			CollisionSelectionBox         = "collision-selection-box" ,
			Arrow                         = "arrow" ,
			Cursor                        = "cursor"
		} ,
		TrackType =
		{
			EarlyGame = "early-game" , -- 载入游戏
			MenuTrack = "menu-track" , -- 主菜单
			MainTrack = "main-track" , -- 游戏阶段
			Interlude = "interlude"    -- 插曲
		} ,
		SciencePack =
		{
			Key   = "description.science-pack-remaining-amount-key" ,
			Value = "description.science-pack-remaining-amount-value"
		} ,
		ProductType =
		{
			Material = "material" ,
			Resource = "resource" ,
			Unit     = "unit"
		} ,
		Condition =
		{
			AND = "and" ,
			OR  = "or" ,
			NOT = "not"
		} ,
		LogisticMode =
		{
			None = "none" ,
			Requester = "requester" ,
			ActiveProvider = "active-provider" ,
			PassiveProvider = "passive-provider" ,
			Buffer = "buffer" ,
			Storage = "storage"
		} ,
		FluidBoxProductionType =
		{
			None = "none" ,
			Input = "input" ,
			Output = "output" ,
			InputOutput = "input-output"
		} ,
		FluidBoxConnectionType =
		{
			Input = "input" ,
			Output = "output" ,
			InputOutput = "input-output"
		} ,
		EquipmentShapeType =
		{
			Full = "full" ,
			Manual = "manual"
		} ,
		EnergySourceType =
		{
			Electric = "electric" ,
			Burner = "burner" ,
			Heat = "heat" ,
			Fluid = "fluid" ,
			Void = "void"
		} ,
		ElectricUsagePriority =
		{
			InputPrimary = "primary-input" ,
			InputSecondary = "secondary-input" ,
			OutputPrimary = "primary-output" ,
			OutputSecondary = "secondary-output" ,
			Tertiary = "tertiary" ,
			Solar = "solar" ,
			Lamp = "lamp"
		} ,
		TechnologyModifier =
		{
			-- 通用效果
			UnlockRecipe                            = "unlock-recipe" ,
			AmmoDamage                              = "ammo-damage" ,
			TurretAttack                            = "turret-attack" ,
			GunSpeed                                = "gun-speed" ,
			ArtilleryRange                          = "artillery-range" ,
			GiveItem                                = "give-item" ,
			Nothing                                 = "nothing" ,
			-- 全局加成
			InserterStackSizeBonus                  = "inserter-stack-size-bonus" ,
			StackInserterCapacityBonus              = "stack-inserter-capacity-bonus" ,
			MiningDrillProductivityBonus            = "mining-drill-productivity-bonus" ,
			TrainBrakingForceBonus                  = "train-braking-force-bonus" ,
			LaboratorySpeed                         = "laboratory-speed" ,
			LaboratoryProductivity                  = "laboratory-productivity" ,
			-- 机器人相关
			MaximumFollowingRobotsCount             = "maximum-following-robots-count" ,
			FollowerRobotLifetime                   = "follower-robot-lifetime" ,
			WorkerRobotSpeed                        = "worker-robot-speed" ,
			WorkerRobotStorage                      = "worker-robot-storage" ,
			WorkerRobotBattery                      = "worker-robot-battery" ,
			-- 建造虚像
			GhostTimeToLive                         = "ghost-time-to-live" ,
			DeconstructionTimeToLive                = "deconstruction-time-to-live" ,
			-- 玩家属性
			CharacterHealthBonus                    = "character-health-bonus" ,
			CharacterInventorySlotsBonus            = "character-inventory-slots-bonus" ,
			CharacterCraftingSpeed                  = "character-crafting-speed" ,
			CharacterMiningSpeed                    = "character-mining-speed" ,
			CharacterRunningSpeed                   = "character-running-speed" ,
			CharacterBuildDistance                  = "character-build-distance" ,
			CharacterReachDistance                  = "character-reach-distance" ,
			CharacterResourceReachDistance          = "character-resource-reach-distance" ,
			CharacterItemDropDistance               = "character-item-drop-distance" ,
			CharacterItemPickupDistance             = "character-item-pickup-distance" ,
			CharacterLootPickupDistance             = "character-loot-pickup-distance" ,
			CharacterLogisticTrashSlots             = "character-logistic-trash-slots" ,
			CharacterLogisticRequests               = "character-logistic-requests" ,
			CharacterAdditionalMiningCategories     = "character-additional-mining-categories" ,
			-- 地图操作
			ZoomToWorldEnabled                      = "zoom-to-world-enabled" ,
			ZoomToWorldGhostBuildingEnabled         = "zoom-to-world-ghost-building-enabled" ,
			ZoomToWorldBlueprintEnabled             = "zoom-to-world-blueprint-enabled" ,
			ZoomToWorldDeconstructionPlannerEnabled = "zoom-to-world-deconstruction-planner-enabled" ,
			ZoomToWorldUpgradePlannerEnabled        = "zoom-to-world-upgrade-planner-enabled" ,
			ZoomToWorldSelectionToolEnabled         = "zoom-to-world-selection-tool-enabled" ,
			-- 不知道
			MaxFailedAttemptsPerTickPerConstructionQueue     = "max-failed-attempts-per-tick-per-construction-queue" ,
			MaxSuccessfulAttemptsPerTickPerConstructionQueue = "max-successful-attempts-per-tick-per-construction-queue"
		}
	} ,
	Numbers =
	{
		IconPictureScale = 0.25 ,
		-- 堆叠数量
		StackSizeMin = 1 ,
		StackSizeMax = 1000000000 ,
		StackSizeAdditionMin = -1000000000 ,
		StackSizeAdditionMax = 1000000000 ,
		-- 倍率
		MultiplierMin = 0 ,
		MultiplierMax = 1000000000 ,
		-- 耐久
		DurabilityMin = 0.00001 ,
		DurabilityMax = 1000000000 ,
		-- 速度
		SpeedMin = 0.00001 ,
		SpeedMax = 1000000000 ,
		-- 距离
		DistanceMin = 1 ,
		DistanceMax = 1000000000
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
			FlyingText          = "flying-text" ,
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
	ShowName = {} ,
	ShowNamePrefix = {} ,
	ShowNameSuffix = {}
}

-- ------------------------------------------------------------------------------------------------
-- --- 自动生成类型相关的数据 ---------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

for type , real in pairs
{
	Group            = { "分组" , "Groups"            } ,
	Fluid            = { "流体" , "Fluids"            } ,
	Tile             = { "地板" , "Tiles"             } ,
	Signal           = { "信号" , "Signals"           } ,
	Recipe           = { "配方" , "Recipes"           } ,
	Technology       = { "科技" , "Technologies"      } ,
	DamageType       = { "伤害" , "DamageTypes"       } ,
	EquipmentGrid    = { "区域" , "EquipmentGrids"    } ,
	Decorative       = { "遮盖" , "Decoratives"       } ,
	Input            = { "按键" , "Inputs"            } ,
	AmbientSound     = { "音乐" , "EmbientSounds"     } ,
	Font             = { "字体" , "Fonts"             } ,
	ControlAutoplace = { "放置" , "ControlAutoplaces" } ,
	Sprite           = { "图片" , "Sprites"           } ,
	Categories       = { "类别" , "Categories"        } ,
	Items            = { "物品" , "Items"             } ,
	Entities         = { "实体" , "Entities"          } ,
	Equipments       = { "模块" , "Equipments"        }
} do
	if SITools.IsTable( SICommon.Types[type] ) then
		for key , value in pairs( SICommon.Types[type] ) do
			SICommon.Types.All[key] = value
			SICommon.Types.Raw[value] = real[2]
			SICommon.ShowName[value] = real[1]
			SICommon.ShowNamePrefix[value] = real[1] .. "-"
		end
	else
		SICommon.Types.All[type] = SICommon.Types[type]
		SICommon.Types.Raw[SICommon.Types[type]] = real[2]
		SICommon.ShowName[SICommon.Types[type]] = real[1]
		SICommon.ShowNamePrefix[SICommon.Types[type]] = real[1] .. "-"
	end
end

for type , real in pairs
{
	ICON  = "图标" ,
	HrVer = "高清"
} do
	SICommon.ShowName[type] = real
	SICommon.ShowNamePrefix[type] = real .. "-"
	SICommon.ShowNameSuffix[type] = "-" .. real
end

-- ------------------------------------------------------------------------------------------------
-- --- 自动填充各种相关的数据 ---------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------------------------
-- ----- 定义类型相关的数值 -----------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

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
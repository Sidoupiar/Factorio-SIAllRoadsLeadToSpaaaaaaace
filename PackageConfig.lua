-- ----------------------------------------
-- 虽然你可以在这里删除任意的功能包以移除它的功能<br>
-- 但是 Core 功能包不可以移除 , 因为它包含了一些公共内容 , 移除后会导致整个 MOD 不可用<br>
-- ----------------------------------------
-- 编号规划 :
-- 0000 - 0009 = 对原版的调整
-- 0010 - 0099 = 非独立的扩展系统 , 主要用作各种逻辑的统一前置存在
-- 0100 - 0199 = 标准生产流程 , 工业类型 , 包括采矿和零件生产
-- 0200 - 0299 = 标准生产流程 , 农业类型 , 包括食品和加工
-- 0300 - 0399 = 标准生产流程 , 特殊类型
-- 0400 - 0499 = 扩展系统
-- 0500 - 0599 = 流程外扩展 , 不影响游戏进度的存在
-- ----------------------------------------
local PackageConfig =
{
	-- ----------------------------------------
	-- Core 模块不可删除 , 它是所有模块的基础<br>
	-- ----------------------------------------
	{
		-- ----------------------------------------
		-- 功能包所在的文件夹名称<br>
		-- ----------------------------------------
		PackageName = "0000_Core" ,

		-- ----------------------------------------
		-- 以下是一些配置项<br>
		-- 它们会影响相应部分的 MOD 内容效果 , 具体效果参见具体属性的注释和说明<br>
		-- 只要是合法的值 , 就不会有任何副作用<br>
		-- ----------------------------------------
		-- 它们和玩家设置 SISettings 不同<br>
		-- 这些配置仅供代码设置和使用 , 玩家无法直接修改这些配置<br>
		-- 这些配置只能用于 data 阶段和 control 阶段 , 且创建完毕对应功能包的 ConstantsData 之后才会有效 ( 即调用完 ConstantsData.AfterLoad 之后 )<br>
		-- ----------------------------------------
		-- 对于 data 阶段的配置 , 除了直接修改配置项的值以外 , 还可以使用其他 MOD 修改它们的值<br>
		-- 位置 : SIConfigs.[ ConstantsData.ID ].[ 配置项 ]<br>
		-- ----------------------------------------
		Configs =
		{
			-- ----------------------------------------
			-- 调试使用的实体的防御能力<br>
			-- 和实体的 resistances 属性的参数一致 , 只不过是对于所有攻击类型的<br>
			-- ----------------------------------------
			-- 除了直接修改以外 , 也可以在其他 MOD 的 data.lua ( 阶段 ) 中使用代码来修改它们的值<br>
			-- 表中的每个值都可以单独修改 , 子表中的也是<br>
			-- ----------------------------------------
			DebugEntityDefence =
			{
				-- ----------------------------------------
				-- 直接减伤<br>
				-- ----------------------------------------
				Decrease = 0 ,

				-- ----------------------------------------
				-- 比例减伤<br>
				-- ----------------------------------------
				Percent = 0.995
			}
		} ,

		-- ----------------------------------------
		-- 强制依赖<br>
		-- ----------------------------------------
		-- 由于每个模块都是可以删除的 , 因此会出现删除部分模块后出现无法处理的异常<br>
		-- 强制依赖会阻止这种情况发生<br>
		-- 强制依赖的模块未加载时 , 当前模块加载时会强制弹出加载错误<br>
		-- 因为是依赖 , 所以强制依赖的模块必须在当前模块之前加载 , 即在此列表中更加靠前的位置<br>
		-- 强制依赖使用 PackageName 而非 ConstantsData.CodeName<br>
		-- ----------------------------------------
		Requires =
		{
			-- Core 模块没有依赖
		}
	} ,
	-- ----------------------------------------
	-- 对原版内容进行修改的模块 , 依赖于 base , 只修改不新增<br>
	-- ----------------------------------------
	{
		PackageName = "0001_Overhaul" ,
		Configs =
		{
			-- ----------------------------------------
			-- 控制修改树木的血量<br>
			-- 填写 true = 开启 , false = 禁用<br>
			-- ----------------------------------------
			-- 除了直接修改以外 , 也可以在其他 MOD 的 data.lua ( 阶段 ) 中使用代码来修改它们的值<br>
			-- ----------------------------------------
			TreeHealth = true ,

			-- ----------------------------------------
			-- 控制矿物上无法摆放机器<br>
			-- 填写 true = 开启 , false = 禁用<br>
			-- ----------------------------------------
			-- 除了直接修改以外 , 也可以在其他 MOD 的 data.lua ( 阶段 ) 中使用代码来修改它们的值<br>
			-- ----------------------------------------
			OreCollision = true ,

			-- ----------------------------------------
			-- 开启矿物上无法摆放机器时 , 数字中的实体不受影响<br>
			-- 数组 , 填写机器原型的 [ name ] 值 , 作为值的 true 是无效的 , 只是语法优化 , 但是请保持其为 true<br>
			-- 数组本体不可为 nil<br>
			-- ----------------------------------------
			-- 除了直接修改以外 , 也可以在其他 MOD 的 data.lua ( 阶段 ) 中使用代码来修改它们的值<br>
			-- ----------------------------------------
			OreCollisionBlackList =
			{
				-- ["机器原型的 [ name ] 值"] = true ,
				-- ...
			} ,

			-- ----------------------------------------
			-- 降低晚上的亮度<br>
			-- ----------------------------------------
			-- 除了直接修改以外 , 也可以在其他 MOD 的 data.lua ( 阶段 ) 中使用代码来修改它们的值<br>
			-- ----------------------------------------
			TotalEvening = true ,

			-- ----------------------------------------
			-- 敌人单位的尸体存在的持续时间<br>
			-- ----------------------------------------
			-- 除了直接修改以外 , 也可以在其他 MOD 的 data.lua ( 阶段 ) 中使用代码来修改它们的值<br>
			-- ----------------------------------------
			EnemyCorpseDuration = 1200 , -- 20 秒

			-- ----------------------------------------
			-- 是否隐藏所有当前不能直接研究的科技<br>
			-- 仅对本 MOD 或使用本 MOD 的框架创建的科技有效 , 不影响已有存档<br>
			-- 如果一个科技没有前置科技 , 则它也不会被影响<br>
			-- ----------------------------------------
			-- 除了直接修改以外 , 也可以在其他 MOD 的 data.lua ( 阶段 ) 中使用代码来修改它们的值<br>
			-- ----------------------------------------
			HideTechnology = true ,

			-- ----------------------------------------
			-- 隐藏科技的白名单<br>
			-- 位于此名单中的科技不会被隐藏<br>
			-- 仅对本 MOD 或使用本 MOD 的框架创建的科技有效 , 不影响已有存档<br>
			-- 数组 , 填写科技原型的 [ name ] 值 , 作为值的 true 是无效的 , 只是语法优化 , 但是请保持其为 true<br>
			-- 数组本体不可为 nil<br>
			-- ----------------------------------------
			-- 除了直接修改以外
			-- 也可以在其他 MOD 的 data.lua ( 阶段 ) 中使用代码来修改它们的值<br>
			-- 如果在其他 MOD 中进行了修改 , 那么同时在 control.lua 的 on_init 和 on_load 阶段中也需要进行修改<br>
			-- 使用代码 [ remote.call( "SIConfigManager" , "Set" , 键 , 值 ) ] 来修改它的值<br>
			-- 使用代码 [ remote.call( "SIConfigManager" , "Get" , 键 ) ] 来读取它的值<br>
			-- ----------------------------------------
			HideTechnologyBlackList =
			{
				-- ["科技原型的 [ name ] 值"] = true ,
				-- ...
			} ,

			-- ----------------------------------------
			-- 修改物品堆叠数量<br>
			-- 虽然有些没开启 , 但是功能都是可用的<br>
			-- 设置为 nil 则跳过此逻辑<br>
			-- ----------------------------------------
			-- 除了直接修改以外 , 也可以在其他 MOD 的 data.lua ( 阶段 ) 中使用代码来修改它们的值<br>
			-- 表中的每个值都可以单独修改 , 子表中的也是<br>
			-- ----------------------------------------
			ItemStackSizeModify =
			{
				-- ----------------------------------------
				-- 是否使用修改物品堆叠数量的逻辑<br>
				-- 总开关<br>
				-- ----------------------------------------
				Enable = true ,

				-- ----------------------------------------
				-- 是否忽略建议禁止堆叠的物品<br>
				-- ----------------------------------------
				IgnoreCannotStack = true ,

				-- ----------------------------------------
				-- 是否使用倍率修改堆叠数量的逻辑<br>
				-- ----------------------------------------
				EnableItemStackSizeMultiplier = false ,

				-- ----------------------------------------
				-- 倍率修改堆叠数量<br>
				-- ----------------------------------------
				ItemStackSizeMultiplier =
				{
					-- ----------------------------------------
					-- 允许的物品堆叠数量最小值 , 任意物品堆叠数量小于此值时 , 会强制变为此值<br>
					-- 如果为 0 则禁用限制<br>
					-- ----------------------------------------
					Min = 0 ,

					-- ----------------------------------------
					-- 允许的物品堆叠数量最大值 , 任意物品堆叠数量大于此值时 , 会强制变为此值<br>
					-- 如果为 0 则禁用限制<br>
					-- ----------------------------------------
					Max = 0 ,

					-- ----------------------------------------
					-- 默认的物品堆叠数量的倍率 , 所有物品的堆叠数量都会乘以此值<br>
					-- 如果为 0 则禁用逻辑<br>
					-- 取值范围 0 至 10 0000 0000<br>
					-- ----------------------------------------
					Multiplier = 1 ,

					-- ----------------------------------------
					-- 指定类别的物品堆叠数量的倍率 , 该类别的所有物品的堆叠数量都会乘以此值<br>
					-- 如果为 0 则使用默认值<br>
					-- 取值范围 0 至 10 0000 0000<br>
					-- 键的可用值请见 SICommon.Types.StackableItems 的定义<br>
					-- ----------------------------------------
					TypeList =
					{
						[SICommon.Types.StackableItems.Item]        = 1 ,
						[SICommon.Types.StackableItems.ItemEntity]  = 1 ,
						[SICommon.Types.StackableItems.Tool]        = 1 ,
						[SICommon.Types.StackableItems.ToolRepair]  = 1 ,
						[SICommon.Types.StackableItems.RailPlanner] = 1 ,
						[SICommon.Types.StackableItems.Ammo]        = 1 ,
						[SICommon.Types.StackableItems.Capsule]     = 1 ,
						[SICommon.Types.StackableItems.Gun]         = 1 ,
						[SICommon.Types.StackableItems.Module]      = 1
					}
				} ,

				-- ----------------------------------------
				-- 是否使用加法修改堆叠数量的逻辑<br>
				-- ----------------------------------------
				EnableItemStackSizeAddition = false ,

				-- ----------------------------------------
				-- 加法修改堆叠数量<br>
				-- ----------------------------------------
				ItemStackSizeAddition =
				{
					-- ----------------------------------------
					-- 允许的物品堆叠数量最小值 , 任意物品堆叠数量小于此值时 , 会强制变为此值<br>
					-- 如果为 0 则禁用限制<br>
					-- ----------------------------------------
					Min = 0 ,

					-- ----------------------------------------
					-- 允许的物品堆叠数量最大值 , 任意物品堆叠数量大于此值时 , 会强制变为此值<br>
					-- 如果为 0 则禁用限制<br>
					-- ----------------------------------------
					Max = 0 ,

					-- ----------------------------------------
					-- 默认的物品堆叠数量的增加量 , 所有物品的堆叠数量都会加上此值<br>
					-- 如果为 0 则禁用逻辑<br>
					-- 取值范围 -10 0000 0000 至 10 0000 0000<br>
					-- ----------------------------------------
					Addition = 0 ,

					-- ----------------------------------------
					-- 指定类别的物品堆叠数量的增加量 , 该类别的所有物品的堆叠数量都会加上此值<br>
					-- 如果为 0 则使用默认值<br>
					-- 取值范围 -10 0000 0000 至 10 0000 0000<br>
					-- 键的可用值请见 SICommon.Types.StackableItems 的定义<br>
					-- ----------------------------------------
					TypeList =
					{
						[SICommon.Types.StackableItems.Item]        = 0 ,
						[SICommon.Types.StackableItems.ItemEntity]  = 0 ,
						[SICommon.Types.StackableItems.Tool]        = 0 ,
						[SICommon.Types.StackableItems.ToolRepair]  = 0 ,
						[SICommon.Types.StackableItems.RailPlanner] = 0 ,
						[SICommon.Types.StackableItems.Ammo]        = 0 ,
						[SICommon.Types.StackableItems.Capsule]     = 0 ,
						[SICommon.Types.StackableItems.Gun]         = 0 ,
						[SICommon.Types.StackableItems.Module]      = 0
					}
				} ,

				-- ----------------------------------------
				-- 是否使用单独修改堆叠数量的逻辑<br>
				-- ----------------------------------------
				EnableItemStackSizeList = true ,

				-- ----------------------------------------
				-- 使用单独修改堆叠数量的逻辑时 , 遇到不存在的物品是否弹出报错信息<br>
				-- ----------------------------------------
				ErrorWhenItemNotExist = true ,

				-- ----------------------------------------
				-- 单独修改堆叠数量<br>
				-- 结构是键值对 , 键是物品的类型 , 可用值请见 SICommon.Types.StackableItems 的定义<br>
				-- 值是物品的 [ name ] 属性值与目标堆叠数量组成的子表<br>
				-- 最终 , 目标堆叠数量会覆盖原始堆叠数量<br>
				-- ----------------------------------------
				ItemStackSizeList =
				{
					[SICommon.Types.StackableItems.Item] =
					{
						-- 资源
						["wood"]                             = 5000 , -- 木头
						["iron-ore"]                         = 5000 , -- 铁矿
						["copper-ore"]                       = 5000 , -- 铜矿
						["uranium-ore"]                      = 5000 , -- 铀矿
						["stone"]                            = 5000 , -- 石矿
						["coal"]                             = 5000 , -- 煤矿
						["uranium-235"]                      = 5000 , -- U235
						["uranium-238"]                      = 5000 , -- U238
						-- 冶炼物
						["iron-plate"]                       = 1000 , -- 铁板
						["steel-plate"]                      = 1000 , -- 钢板
						["copper-plate"]                     = 1000 , -- 铜板
						["plastic-bar"]                      = 1000 , -- 塑料
						-- 地板
						["stone-brick"]                      = 2000 , -- 石砖
						["concrete"]                         = 2000 , -- 混凝土
						["hazard-concrete"]                  = 2000 , -- 警示混凝土
						["refined-concrete"]                 = 2000 , -- 钢筋混凝土
						["refined-hazard-concrete"]          = 2000 , -- 警示钢筋混凝土
						["landfill"]                         = 2000 , -- 填海料
						-- 加工产物
						["iron-stick"]                       = 1000 , -- 铁棒
						["iron-gear-wheel"]                  = 500  , -- 铁齿轮
						["copper-cable"]                     = 1000 , -- 铜丝
						["red-wire"]                         = 500  , -- 红电路线
						["green-wire"]                       = 500  , -- 绿电路线
						["electronic-circuit"]               = 100  , -- 绿板
						["advanced-circuit"]                 = 100  , -- 红板
						["processing-unit"]                  = 100  , -- 蓝板
						["engine-unit"]                      = 100  , -- 内燃机
						["electric-engine-unit"]             = 100  , -- 电动机
						["solid-fuel"]                       = 400  , -- 固体燃料
						["rocket-fuel"]                      = 100  , -- 火箭燃料
						["nuclear-fuel"]                     = 100  , -- 核燃料
						["uranium-fuel-cell"]                = 100  , -- 核燃料罐
						["used-up-uranium-fuel-cell"]        = 100  , -- 用完的核燃料罐
						["sulfur"]                           = 500  , -- 硫磺
						["explosives"]                       = 500  , -- 炸药
						["battery"]                          = 500  , -- 电池
						["flying-robot-frame"]               = 100  , -- 机器人框架
						["low-density-structure"]            = 50   , -- 轻质框架
						["rocket-control-unit"]              = 50   , -- 火箭框架
						["satellite"]                        = 1    , -- 人造卫星
						-- 存储
						["wooden-chest"]                     = 100  , -- 木箱
						["iron-chest"]                       = 100  , -- 铁箱
						["steel-chest"]                      = 100  , -- 钢箱
						["logistic-chest-passive-provider"]  = 100  , -- 红箱
						["logistic-chest-storage"]           = 100  , -- 黄箱
						["logistic-chest-buffer"]            = 100  , -- 绿箱
						["logistic-chest-requester"]         = 100  , -- 蓝箱
						["logistic-chest-active-provider"]   = 100  , -- 紫箱
						["empty-barrel"]                     = 100  , -- 空桶
						-- 机器
						["burner-mining-drill"]              = 20   , -- 热力矿机
						["electric-mining-drill"]            = 20   , -- 电力矿机
						["pumpjack"]                         = 20   , -- 磕头机
						["offshore-pump"]                    = 100  , -- 水泵
						["pipe"]                             = 100  , -- 管道
						["pipe-to-ground"]                   = 100  , -- 地下管道
						["storage-tank"]                     = 100  , -- 水罐
						["pump"]                             = 100  , -- 管道泵
						["heat-pipe"]                        = 100  , -- 热管
						["stone-furnace"]                    = 100  , -- 石炉
						["steel-furnace"]                    = 100  , -- 钢炉
						["electric-furnace"]                 = 100  , -- 电炉
						["burner-inserter"]                  = 100  , -- 黑爪
						["inserter"]                         = 100  , -- 黄爪
						["fast-inserter"]                    = 100  , -- 蓝爪
						["filter-inserter"]                  = 100  , -- 紫爪
						["long-handed-inserter"]             = 100  , -- 红爪
						["stack-inserter"]                   = 100  , -- 绿爪
						["stack-filter-inserter"]            = 100  , -- 白爪
						["boiler"]                           = 100  , -- 锅炉
						["steam-engine"]                     = 20   , -- 蒸汽机
						["steam-turbine"]                    = 20   , -- 蒸汽轮机
						["solar-panel"]                      = 100  , -- 太阳能板
						["accumulator"]                      = 100  , -- 蓄电器
						["nuclear-reactor"]                  = 1    , -- 核反应堆
						["heat-exchanger"]                   = 100  , -- 热量交换机
						["small-electric-pole"]              = 100  , -- 小电线杆
						["medium-electric-pole"]             = 100  , -- 中电线杆
						["big-electric-pole"]                = 100  , -- 大电线杆
						["substation"]                       = 100  , -- 广电线杆
						["small-lamp"]                       = 100  , -- 灯泡
						["assembling-machine-1"]             = 100  , -- 组装机 mk1
						["assembling-machine-2"]             = 100  , -- 组装机 mk2
						["assembling-machine-3"]             = 100  , -- 组装机 mk3
						["oil-refinery"]                     = 100  , -- 炼油厂
						["chemical-plant"]                   = 100  , -- 化工厂
						["centrifuge"]                       = 100  , -- 离心机
						["lab"]                              = 100  , -- 研究球
						["train-stop"]                       = 100  , -- 火车站
						["rail-signal"]                      = 100  , -- 铁路普通信号灯
						["rail-chain-signal"]                = 100  , -- 铁路连锁信号灯
						["transport-belt"]                   = 100  , -- 黄带
						["fast-transport-belt"]              = 100  , -- 红带
						["express-transport-belt"]           = 100  , -- 蓝带
						["underground-belt"]                 = 100  , -- 地下黄带
						["fast-underground-belt"]            = 100  , -- 地下红带
						["express-underground-belt"]         = 100  , -- 地下蓝带
						["splitter"]                         = 100  , -- 黄筛选器
						["fast-splitter"]                    = 100  , -- 红筛选器
						["express-splitter"]                 = 100  , -- 蓝筛选器
						["roboport"]                         = 10   , -- 指令平台
						["beacon"]                           = 100  , -- 插件塔
						["rocket-silo"]                      = 1    , -- 火箭发射井
						["arithmetic-combinator"]            = 100  , -- 运算器
						["decider-combinator"]               = 100  , -- 比较器
						["constant-combinator"]              = 100  , -- 常量器
						["programmable-speaker"]             = 100  , -- 播音器
						["power-switch"]                     = 100  , -- 电闸
						-- 军火
						["stone-wall"]                       = 100  , -- 围墙
						["gate"]                             = 100  , -- 闸门
						["radar"]                            = 10   , -- 雷达
						["land-mine"]                        = 10   , -- 地雷
						["gun-turret"]                       = 10   , -- 机枪炮塔
						["laser-turret"]                     = 10   , -- 激光炮塔
						["flamethrower-turret"]              = 10   , -- 喷火炮塔
						["artillery-turret"]                 = 1    , -- 重炮炮塔
						-- 模块
						["solar-panel-equipment"]            = 1    , -- 太阳能模块
						["fusion-reactor-equipment"]         = 1    , -- 核能模块
						["battery-equipment"]                = 1    , -- 电池模块 mk1
						["battery-mk2-equipment"]            = 1    , -- 电池模块 mk2
						["night-vision-equipment"]           = 1    , -- 夜视模块
						["belt-immunity-equipment"]          = 1    , -- 锚定模块
						["personal-roboport-equipment"]      = 1    , -- 指令平台模块 mk1
						["personal-roboport-mk2-equipment"]  = 1    , -- 指令平台模块 mk2
						["exoskeleton-equipment"]            = 1    , -- 外骨骼模块
						["personal-laser-defense-equipment"] = 1    , -- 激光防御模块
						["discharge-defense-equipment"]      = 1    , -- 放电防御模块
						["energy-shield-equipment"]          = 1    , -- 能量护盾模块 mk1
						["energy-shield-mk2-equipment"]      = 1    , -- 能量护盾模块 mk2
						-- 其他
						["construction-robot"]               = 100  , -- 建设机器人
						["logistic-robot"]                   = 100    -- 物流机器人
					} ,
					[SICommon.Types.StackableItems.ItemEntity] =
					{
						-- 载具
						["locomotive"]                       = 1    , -- 内燃机车
						["cargo-wagon"]                      = 1    , -- 货运车厢
						["fluid-wagon"]                      = 1    , -- 液罐车厢
						["artillery-wagon"]                  = 1      -- 重炮车厢
					} ,
					[SICommon.Types.StackableItems.Tool] =
					{
						-- 科技包
						["automation-science-pack"]          = 1000 , -- 红瓶
						["logistic-science-pack"]            = 1000 , -- 绿瓶
						["military-science-pack"]            = 1000 , -- 灰瓶
						["chemical-science-pack"]            = 1000 , -- 蓝瓶
						["production-science-pack"]          = 1000 , -- 紫瓶
						["utility-science-pack"]             = 1000 , -- 金瓶
						["space-science-pack"]               = 1000   -- 白瓶
					} ,
					[SICommon.Types.StackableItems.ToolRepair] =
					{
						-- 军火
						["repair-pack"]                      = 100    -- 维修包
					} ,
					[SICommon.Types.StackableItems.RailPlanner] =
					{
						-- 机器
						["rail"]                             = 500    -- 铁轨布设器
					} ,
					[SICommon.Types.StackableItems.Ammo] =
					{
						-- 军火
						["firearm-magazine"]                 = 100  , -- 普通弹夹
						["piercing-rounds-magazine"]         = 100  , -- 穿甲弹夹
						["uranium-rounds-magazine"]          = 100  , -- 贫铀弹夹
						["shotgun-shell"]                    = 100  , -- 普通霰弹
						["piercing-shotgun-shell"]           = 100  , -- 穿甲霰弹
						["rocket"]                           = 100  , -- 火箭弹
						["explosive-rocket"]                 = 100  , -- 爆破火箭弹
						["atomic-bomb"]                      = 100  , -- 核能火箭弹
						["cannon-shell"]                     = 100  , -- 坦克炮弹
						["explosive-cannon-shell"]           = 100  , -- 爆破坦克炮弹
						["uranium-cannon-shell"]             = 100  , -- 贫铀坦克炮弹
						["explosive-uranium-cannon-shell"]   = 100  , -- 贫铀爆破坦克炮弹
						["flamethrower-ammo"]                = 100  , -- 喷火燃料罐
						["artillery-shell"]                  = 30     -- 重炮炮弹
					} ,
					[SICommon.Types.StackableItems.Capsule] =
					{
						-- 资源
						["raw-fish"]                         = 100  , -- 鲜鱼
						-- 军火
						["grenade"]                          = 100  , -- 手雷
						["cluster-grenade"]                  = 100  , -- 破片手雷
						["destroyer-capsule"]                = 100  , -- 攻击胶囊
						["defender-capsule"]                 = 100  , -- 防御胶囊
						["poison-capsule"]                   = 100  , -- 毒素胶囊
						["slowdown-capsule"]                 = 100  , -- 减速胶囊
						["distractor-capsule"]               = 100  , -- 放电胶囊
						["cliff-explosives"]                 = 5    , -- 悬崖炸药
						["discharge-defense-remote"]         = 1    , -- 放电防御模块控制器
						["artillery-targeting-remote"]       = 1      -- 重炮控制器
					} ,
					[SICommon.Types.StackableItems.Gun] =
					{
						-- 军火
						["pistol"]                           = 1    , -- 手枪
						["submachine-gun"]                   = 1    , -- 机枪
						["shotgun"]                          = 1    , -- 霰弹枪
						["combat-shotgun"]                   = 1    , -- 战斗霰弹枪
						["rocket-launcher"]                  = 1    , -- 火箭筒
						["flamethrower"]                     = 1      -- 喷火器
					} ,
					[SICommon.Types.StackableItems.Module] =
					{
						-- 插件
						["speed-module"]                     = 100  , -- 速度插件 mk1
						["speed-module-2"]                   = 100  , -- 速度插件 mk2
						["speed-module-3"]                   = 100  , -- 速度插件 mk3
						["effectivity-module"]               = 100  , -- 节能插件 mk1
						["effectivity-module-2"]             = 100  , -- 节能插件 mk2
						["effectivity-module-3"]             = 100  , -- 节能插件 mk3
						["productivity-module"]              = 100  , -- 产能插件 mk1
						["productivity-module-2"]            = 100  , -- 产能插件 mk2
						["productivity-module-3"]            = 100    -- 产能插件 mk3
					}
				}
			} ,

			-- ----------------------------------------
			-- 修改物品属性<br>
			-- 虽然有些没开启 , 但是功能都是可用的<br>
			-- 设置为 nil 则跳过此逻辑<br>
			-- ----------------------------------------
			-- 除了直接修改以外 , 也可以在其他 MOD 的 data.lua ( 阶段 ) 中使用代码来修改它们的值<br>
			-- 表中的每个值都可以单独修改 , 子表中的也是<br>
			-- ----------------------------------------
			ItemPropertyModify =
			{
				-- ----------------------------------------
				-- 是否使用修改物品属性的逻辑<br>
				-- ----------------------------------------
				Enable = false ,

				-- ----------------------------------------
				-- 维修工具耐久度倍率<br>
				-- 取值范围 0 至 10 0000 0000<br>
				-- ----------------------------------------
				RepairToolDurabilityMultiplier = 1 ,

				-- ----------------------------------------
				-- 维修工具维修速度倍率<br>
				-- 取值范围 0 至 10 0000 0000<br>
				-- ----------------------------------------
				RepairToolSpeedMultiplier = 1 ,

				-- ----------------------------------------
				-- 工具 ( 科技包 ) 耐久度倍率<br>
				-- 取值范围 0 至 10 0000 0000<br>
				-- ----------------------------------------
				ToolDurabilityMultiplier = 1 ,

				-- ----------------------------------------
				-- 研究球速度倍率<br>
				-- 取值范围 0 至 10 0000 0000<br>
				-- ----------------------------------------
				LabSpeedMultiplier = 1 ,

				-- ----------------------------------------
				-- 子弹弹夹数量倍率<br>
				-- 取值范围 0 至 10 0000 0000<br>
				-- ----------------------------------------
				MagazineAmmoSizeMultiplier = 1 ,

				-- ----------------------------------------
				-- 电路接线距离倍率<br>
				-- 取值范围 0 至 10 0000 0000<br>
				-- ----------------------------------------
				CircuitDistanceMultiplier = 1 ,

				-- ----------------------------------------
				-- 地下传送带距离倍率<br>
				-- 取值范围 0 至 10 0000 0000<br>
				-- ----------------------------------------
				UndergrundBeltDistanceMultiplier = 1 ,

				-- ----------------------------------------
				-- 地下管道距离倍率<br>
				-- 取值范围 0 至 10 0000 0000<br>
				-- ----------------------------------------
				UndergrundPipeDistanceMultiplier = 1
			}
		} ,
		Requires =
		{
			"0000_Core"
		}
	} ,
	-- ----------------------------------------
	-- 对原版内容进行新增的模块 , 依赖于 base , 只新增不修改<br>
	-- ----------------------------------------
	{
		PackageName = "0002_Expand" ,
		Configs =
		{
			-- ----------------------------------------
			-- 创建灌装和倾倒配方时 , 是否忽略原版流体的建议装桶设置 [ auto_barrel ] <br>
			-- ----------------------------------------
			-- 除了直接修改以外 , 也可以在其他 MOD 的 data.lua ( 阶段 ) 中使用代码来修改它们的值<br>
			-- ----------------------------------------
			IgnoreAutoBarrel = false ,

			-- ----------------------------------------
			-- 每个桶可以装的流体数量 , 默认 1<br>
			-- ----------------------------------------
			-- 除了直接修改以外 , 也可以在其他 MOD 的 data.lua ( 阶段 ) 中使用代码来修改它们的值<br>
			-- ----------------------------------------
			BarrelSize = 100 ,

			-- ----------------------------------------
			-- 禁止装桶的流体的黑名单<br>
			-- 位于此名单中的流体不会创建装桶和倾倒<br>
			-- 数组 , 填写流体原型的 [ name ] 值 , 作为值的 true 是无效的 , 只是语法优化 , 但是请保持其为 true<br>
			-- 数组本体不可为 nil<br>
			-- ----------------------------------------
			-- 除了直接修改以外 , 也可以在其他 MOD 的 data.lua ( 阶段 ) 中使用代码来修改它们的值<br>
			-- ----------------------------------------
			BarrelBlackList =
			{
				-- ["流体原型的 [ name ] 值"] = true ,
				-- ...
			} ,

			-- ----------------------------------------
			-- 位于黑名单中的炮塔/武器/地雷不会被加入无尽科技中<br>
			-- 数组 , 填写炮塔/武器/地雷原型的 [ name ] 值 , 作为值的 true 是无效的 , 只是语法优化 , 但是请保持其为 true<br>
			-- 数组本体不可为 nil<br>
			-- ----------------------------------------
			-- 除了直接修改以外 , 也可以在其他 MOD 的 data.lua ( 阶段 ) 中使用代码来修改它们的值<br>
			-- ----------------------------------------
			TurretBlackList =
			{
				-- ["炮塔/武器/地雷原型的 [ name ] 值"] = true ,
				-- ...
			}
		} ,
		Requires =
		{
			"0000_Core"
		}
	} ,
	-- ----------------------------------------
	-- 书籍逻辑<br>
	-- ----------------------------------------
	{
		PackageName = "0011_Bookshelf" ,
		Requires =
		{
			"0000_Core"
		}
	} ,
	-- ----------------------------------------
	-- 解锁逻辑<br>
	-- ----------------------------------------
	{
		PackageName = "0012_Unlocker" ,
		Requires =
		{
			"0000_Core"
		}
	} ,
	-- ----------------------------------------
	-- 建造限制<br>
	-- ----------------------------------------
	{
		PackageName = "0013_BuildLimit" ,
		Requires =
		{
			"0000_Core"
		}
	} ,
	-- ----------------------------------------
	-- 世界上会出现各种遗迹<br>
	-- ----------------------------------------
	{
		PackageName = "0014_RuinControl" ,
		Configs =
		{
			-- ----------------------------------------
			-- 世界前缀 , 满足这些前缀的世界会生成遗迹<br>
			-- 数组 , 填写世界名称的前缀 , 作为值的 true 是无效的 , 只是语法优化 , 但是请保持其为 true<br>
			-- 数组本体不可为 nil<br>
			-- ----------------------------------------
			-- 除了直接修改以外<br>
			-- 也可以在其他 MOD 的 control.lua 的 on_init 和 on_load 阶段中<br>
			-- 使用代码 [ remote.call( "SIConfigManager" , "Set" , 键 , 值 ) ] 来修改它的值<br>
			-- 使用代码 [ remote.call( "SIConfigManager" , "Get" , 键 ) ] 来读取它的值<br>
			-- ----------------------------------------
			SurfacePrefixWhiteList =
			{
				nauvis = true ,
				warpzone_ = true
			} ,

			-- ----------------------------------------
			-- 在这个距离内不会生成遗迹<br>
			-- 这是默认值 , 会被世界设置覆盖<br>
			-- ----------------------------------------
			-- 除了直接修改以外<br>
			-- 也可以在其他 MOD 的 control.lua 的 on_init 和 on_load 阶段中<br>
			-- 使用代码 [ remote.call( "SIConfigManager" , "Set" , 键 , 值 ) ] 来修改它的值<br>
			-- 使用代码 [ remote.call( "SIConfigManager" , "Get" , 键 ) ] 来读取它的值<br>
			-- ----------------------------------------
			MinRuinDistance = 1000 ,

			-- ----------------------------------------
			-- 符合距离时 , 每个区块生成遗迹的概率<br>
			-- 这是默认值 , 会被世界设置覆盖<br>
			-- ----------------------------------------
			-- 除了直接修改以外<br>
			-- 也可以在其他 MOD 的 control.lua 的 on_init 和 on_load 阶段中<br>
			-- 使用代码 [ remote.call( "SIConfigManager" , "Set" , 键 , 值 ) ] 来修改它的值<br>
			-- 使用代码 [ remote.call( "SIConfigManager" , "Get" , 键 ) ] 来读取它的值<br>
			-- ----------------------------------------
			RuinCreateChance = 0.005 ,

			-- ----------------------------------------
			-- 生成遗迹时 , 遗迹的强度系数<br>
			-- 这是默认值 , 会被世界设置覆盖<br>
			-- ----------------------------------------
			-- 除了直接修改以外<br>
			-- 也可以在其他 MOD 的 control.lua 的 on_init 和 on_load 阶段中<br>
			-- 使用代码 [ remote.call( "SIConfigManager" , "Set" , 键 , 值 ) ] 来修改它的值<br>
			-- 使用代码 [ remote.call( "SIConfigManager" , "Get" , 键 ) ] 来读取它的值<br>
			-- ----------------------------------------
			RuinStrength = 1.0 ,

			-- ----------------------------------------
			-- 生成遗迹时 , 随着与地图中心的距离的增加而获得的额外遗迹强度系数 , 每 32 格增加一次<br>
			-- 这是默认值 , 会被世界设置覆盖<br>
			-- ----------------------------------------
			-- 除了直接修改以外<br>
			-- 也可以在其他 MOD 的 control.lua 的 on_init 和 on_load 阶段中<br>
			-- 使用代码 [ remote.call( "SIConfigManager" , "Set" , 键 , 值 ) ] 来修改它的值<br>
			-- 使用代码 [ remote.call( "SIConfigManager" , "Get" , 键 ) ] 来读取它的值<br>
			-- ----------------------------------------
			RuinStrengthAdden = 0.146
		} ,
		Requires =
		{
			"0000_Core"
		}
	} ,
	-- ----------------------------------------
	-- 增加了若干矿物<br>
	-- ----------------------------------------
	{
		PackageName = "0101_Resource" ,
		Requires =
		{
			"0000_Core" ,
			"0012_Unlocker" ,
			"0013_BuildLimit"
		}
	} ,
	-- ----------------------------------------
	-- 增加了若干野生植物<br>
	-- ----------------------------------------
	{
		PackageName = "0102_Plant" ,
		Requires =
		{
			"0000_Core" ,
			"0012_Unlocker" ,
			"0013_BuildLimit"
		}
	} ,
	-- ----------------------------------------
	-- 增加了若干野生动物<br>
	-- ----------------------------------------
	{
		PackageName = "0103_Animal" ,
		Requires =
		{
			"0000_Core" ,
			"0012_Unlocker" ,
			"0013_BuildLimit"
		}
	} ,
	-- ----------------------------------------
	-- 增加了种植农业生产的内容<br>
	-- ----------------------------------------
	{
		PackageName = "0201_Planting" ,
		Requires =
		{
			"0101_Resource" ,
			"0102_Plant" ,
			"0103_Animal"
		}
	} ,
	-- ----------------------------------------
	-- 增加了畜牧农业生产的内容<br>
	-- ----------------------------------------
	{
		PackageName = "0202_Husbandry" ,
		Requires =
		{
			"0101_Resource" ,
			"0102_Plant" ,
			"0103_Animal"
		}
	} ,
	-- ----------------------------------------
	-- 增加了蒸汽工业生产的内容<br>
	-- ----------------------------------------
	{
		PackageName = "0211_Steam" ,
		Requires =
		{
			"0101_Resource" ,
			"0102_Plant" ,
			"0103_Animal"
		}
	} ,
	-- ----------------------------------------
	-- 增加了电力工业生产的内容<br>
	-- ----------------------------------------
	{
		PackageName = "0212_Electric" ,
		Requires =
		{
			"0101_Resource" ,
			"0102_Plant" ,
			"0103_Animal"
		}
	} ,
	-- ----------------------------------------
	-- 增加了闪耀工业生产的内容<br>
	-- ----------------------------------------
	{
		PackageName = "0213_Glitter" ,
		Requires =
		{
			"0101_Resource" ,
			"0102_Plant" ,
			"0103_Animal"
		}
	} ,
	-- ----------------------------------------
	-- 增加了焦馏工艺生产的内容<br>
	-- ----------------------------------------
	{
		PackageName = "0221_Scorch" ,
		Requires =
		{
			"0101_Resource" ,
			"0102_Plant" ,
			"0103_Animal"
		}
	} ,
	-- ----------------------------------------
	-- 增加了光辉萃取产的内容<br>
	-- ----------------------------------------
	{
		PackageName = "0222_Light" ,
		Requires =
		{
			"0101_Resource" ,
			"0102_Plant" ,
			"0103_Animal"
		}
	} ,
	-- ----------------------------------------
	-- 增加了暗影铸造产的内容<br>
	-- ----------------------------------------
	{
		PackageName = "0223_Shadow" ,
		Requires =
		{
			"0101_Resource" ,
			"0102_Plant" ,
			"0103_Animal"
		}
	} ,
	-- ----------------------------------------
	-- 增加了子弹物资生产的内容<br>
	-- ----------------------------------------
	{
		PackageName = "0291_Ammo" ,
		Requires =
		{
			"0101_Resource" ,
			"0102_Plant" ,
			"0103_Animal"
		}
	} ,
	-- ----------------------------------------
	-- 增加了防御工事生产的内容<br>
	-- ----------------------------------------
	{
		PackageName = "0292_Defence" ,
		Requires =
		{
			"0101_Resource" ,
			"0102_Plant" ,
			"0103_Animal"
		}
	} ,
	-- ----------------------------------------
	-- 增加了用于种植农业生产的各种设备<br>
	-- ----------------------------------------
	{
		PackageName = "0301_PlantingMachine" ,
		Requires =
		{
			"0201_Planting" ,
			"0202_Husbandry" ,
			"0211_Steam" ,
			"0212_Electric" ,
			"0213_Glitter" ,
			"0221_Scorch" ,
			"0222_Light" ,
			"0223_Shadow" ,
			"0291_Ammo" ,
			"0292_Defence"
		}
	} ,
	-- ----------------------------------------
	-- 增加了用于畜牧农业生产的各种设备<br>
	-- ----------------------------------------
	{
		PackageName = "0302_HusbandryMachine" ,
		Requires =
		{
			"0201_Planting" ,
			"0202_Husbandry" ,
			"0211_Steam" ,
			"0212_Electric" ,
			"0213_Glitter" ,
			"0221_Scorch" ,
			"0222_Light" ,
			"0223_Shadow" ,
			"0291_Ammo" ,
			"0292_Defence"
		}
	} ,
	-- ----------------------------------------
	-- 增加了用于蒸汽工业生产的各种设备<br>
	-- ----------------------------------------
	{
		PackageName = "0311_SteamMachine" ,
		Requires =
		{
			"0201_Planting" ,
			"0202_Husbandry" ,
			"0211_Steam" ,
			"0212_Electric" ,
			"0213_Glitter" ,
			"0221_Scorch" ,
			"0222_Light" ,
			"0223_Shadow" ,
			"0291_Ammo" ,
			"0292_Defence"
		}
	} ,
	-- ----------------------------------------
	-- 增加了用于电力工业生产的各种设备<br>
	-- ----------------------------------------
	{
		PackageName = "0312_ElectricMachine" ,
		Requires =
		{
			"0201_Planting" ,
			"0202_Husbandry" ,
			"0211_Steam" ,
			"0212_Electric" ,
			"0213_Glitter" ,
			"0221_Scorch" ,
			"0222_Light" ,
			"0223_Shadow" ,
			"0291_Ammo" ,
			"0292_Defence"
		}
	} ,
	-- ----------------------------------------
	-- 增加了用于闪耀工业生产的各种设备<br>
	-- ----------------------------------------
	{
		PackageName = "0313_GlitterMachine" ,
		Requires =
		{
			"0201_Planting" ,
			"0202_Husbandry" ,
			"0211_Steam" ,
			"0212_Electric" ,
			"0213_Glitter" ,
			"0221_Scorch" ,
			"0222_Light" ,
			"0223_Shadow" ,
			"0291_Ammo" ,
			"0292_Defence"
		}
	} ,
	-- ----------------------------------------
	-- 增加了用于焦馏工艺生产的各种设备<br>
	-- ----------------------------------------
	{
		PackageName = "0321_ScorchMachine" ,
		Requires =
		{
			"0201_Planting" ,
			"0202_Husbandry" ,
			"0211_Steam" ,
			"0212_Electric" ,
			"0213_Glitter" ,
			"0221_Scorch" ,
			"0222_Light" ,
			"0223_Shadow" ,
			"0291_Ammo" ,
			"0292_Defence"
		}
	} ,
	-- ----------------------------------------
	-- 增加了用于光辉萃取生产的各种设备<br>
	-- ----------------------------------------
	{
		PackageName = "0322_LightMachine" ,
		Requires =
		{
			"0201_Planting" ,
			"0202_Husbandry" ,
			"0211_Steam" ,
			"0212_Electric" ,
			"0213_Glitter" ,
			"0221_Scorch" ,
			"0222_Light" ,
			"0223_Shadow" ,
			"0291_Ammo" ,
			"0292_Defence"
		}
	} ,
	-- ----------------------------------------
	-- 增加了用于暗影铸造生产的各种设备<br>
	-- ----------------------------------------
	{
		PackageName = "0323_ShadowMachine" ,
		Requires =
		{
			"0201_Planting" ,
			"0202_Husbandry" ,
			"0211_Steam" ,
			"0212_Electric" ,
			"0213_Glitter" ,
			"0221_Scorch" ,
			"0222_Light" ,
			"0223_Shadow" ,
			"0291_Ammo" ,
			"0292_Defence"
		}
	} ,
	-- ----------------------------------------
	-- 增加了用于子弹物资生产的各种设备<br>
	-- ----------------------------------------
	{
		PackageName = "0391_AmmoMachine" ,
		Requires =
		{
			"0201_Planting" ,
			"0202_Husbandry" ,
			"0211_Steam" ,
			"0212_Electric" ,
			"0213_Glitter" ,
			"0221_Scorch" ,
			"0222_Light" ,
			"0223_Shadow" ,
			"0291_Ammo" ,
			"0292_Defence"
		}
	} ,
	-- ----------------------------------------
	-- 增加了用于防御工事生产的各种设备<br>
	-- ----------------------------------------
	{
		PackageName = "0392_DefenceMachine" ,
		Requires =
		{
			"0201_Planting" ,
			"0202_Husbandry" ,
			"0211_Steam" ,
			"0212_Electric" ,
			"0213_Glitter" ,
			"0221_Scorch" ,
			"0222_Light" ,
			"0223_Shadow" ,
			"0291_Ammo" ,
			"0292_Defence"
		}
	} ,
	-- ----------------------------------------
	-- RPG 系统 , 包括加点 , 技能 , 副本 , 装备等等<br>
	-- ----------------------------------------
	{
		PackageName = "0400_RPGSystem" ,
		Configs =
		{
			-- ----------------------------------------
			-- 世界前缀 , 满足这些前缀的世界进行刷新时 , 会把记录中的旧世界的坐标同步到新世界<br>
			-- 数组 , 填写世界名称的前缀 , 作为值的 true 是无效的 , 只是语法优化 , 但是请保持其为 true<br>
			-- 数组本体不可为 nil<br>
			-- ----------------------------------------
			-- 除了直接修改以外<br>
			-- 也可以在其他 MOD 的 control.lua 的 on_init 和 on_load 阶段中<br>
			-- 使用代码 [ remote.call( "SIConfigManager" , "Set" , 键 , 值 ) ] 来修改它的值<br>
			-- 使用代码 [ remote.call( "SIConfigManager" , "Get" , 键 ) ] 来读取它的值<br>
			-- ----------------------------------------
			SurfacePrefixWhiteList =
			{
				warpzone_ = true
			}
		} ,
		Requires =
		{
			"0000_Core"
		}
	} ,
	-- ----------------------------------------
	-- 提供了一些装饰品 , 以及制作它们的方法<br>
	-- ----------------------------------------
	{
		PackageName = "0500_Colorful" ,
		Requires =
		{
			"0000_Core" ,
			"0012_Unlocker" ,
			"0013_BuildLimit"
		}
	}
}

return PackageConfig
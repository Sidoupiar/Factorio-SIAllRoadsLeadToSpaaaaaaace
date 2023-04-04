local constantsData =
{
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 基础属性 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------

	-- ----------------------------------------
	-- 此 ConstantsData 的名称<br>
	-- 没有此属性会放弃加载 , 同时放弃自动载入此功能包下的其他 lua 文件<br>
	-- ----------------------------------------
	ID = "Core" ,

	-- ----------------------------------------
	-- 此 ConstantsData 的显示名称<br>
	-- 没有此属性会被自动添加 , 默认 : [ ConstantsData.ID ]<br>
	-- ----------------------------------------
	Name = "核心" ,

	-- ----------------------------------------
	-- 决定根据此 [ ConstantsData.ID ] 生成的注册名 [ ClassName ] 是否使用前缀 , 前缀主要是为了防止重名<br>
	-- 因为上面的 [ ClassName ] 会被注册进各种结构中 , 包括一个以 [ ClassName ] 为名称的全局变量<br>
	-- 没有此属性会被自动添加 , 默认 : true<br>
	-- ----------------------------------------
	UseClassPrefix = true ,

	-- ----------------------------------------
	-- 决定根据此 [ ConstantsData.ID ] 生成的注册名 [ ShowName ] 是否使用前缀 , 前缀主要是为了防止重名<br>
	-- 在注册新物品 , 新实体 , 新配方等时 , 它们的 [ name ] 中会添加 [ ShowName ] 前缀 , 不影响本地化翻译项目<br>
	-- 在日志或调试信息中输出中也会使用 [ ShowName ] 属性<br>
	-- 没有此属性会被自动添加 , 默认 : true<br>
	-- ----------------------------------------
	UseShowPrefix = true ,

	-- ----------------------------------------
	-- 此 ConstantsData 的排序字符串<br>
	-- 此排序字符串会影响当前包中创建的所有原型的整体排序 , 体现在它们的排序字符串中<br>
	-- 除非特殊需要 , 一般都使用默认值 , 这使得创建的所有东西都会按照代码生成的顺序进行排序<br>
	-- 没有此属性会被自动添加 , 默认 : 一个不断增加的四位数字字符串 , 从 1000 开始<br>
	-- ----------------------------------------
	Order = "0000" ,

	-- ----------------------------------------
	-- 用于确定加载 ConstantsData 后还需要加载哪些文件<br>
	-- 这些文件是按照载入阶段划分的<br>
	--     data.lua 阶段会加载 [SIInit.StateCodeDefine.Data] 所对应的数组中的文件名称<br>
	--     control.lua 阶段会加载 [SIInit.StateCodeDefine.Control] 所对应的数组中的文件名称<br>
	--     以此类推<br>
	-- 这些加载的文件均位于当前功能包内 , 加载时会自动添加路径前缀 "__ModName__/package/功能包文件夹名称/" , lua 文件不需要写扩展名<br>
	-- <br>
	-- 另外 :<br>
	-- SIInit.StateCodeDefine.Data 往下排是从 1 开始的 , 因此如果每个部分都有对应的文件的话子表中的键可以省略<br>
	-- 详见 utils 中的 SIInit.StateCodeDefine 的定义<br>
	-- 比如下面的子表可以简化成 { { "1_data" } , { "2_data-updates" } , { "3_data-final-fixes" } , { "4_control" } }<br>
	-- 即便没有文件也可以塞一个空的数字来占位置 , 比如 { { "1_data" } , {} , {} , { "4_control" } }<br>
	-- ----------------------------------------
	FileList =
	{
		[SIInit.StateCodeDefine.Data]           = { "1_data_base" , "1_data_special" , "1_data_debug" , "1_data_gui" } ,
		-- [SIInit.StateCodeDefine.DataUpdates]    = { "2_data-updates" } ,
		-- [SIInit.StateCodeDefine.DataFinalFixes] = { "3_data-final-fixes" } ,
		[SIInit.StateCodeDefine.Control]        = { "4_control" }
	} ,

	-- ----------------------------------------
	-- 资源文件夹位置 , 决定此功能包所使用的图片文件和声音文件所在的文件夹的位置<br>
	-- 会在自动生成 [ PicturePath ] 和 [ SoundPath ] , 它们指向图片文件夹和声音文件夹 , 它们的默认值见下方自动生成的属性部分<br>
	-- 文件夹指向完毕后 , 此属性会被删除<br>
	-- 没有此属性时会使用默认值<br>
	-- ----------------------------------------
	Path =
	{
		-- ----------------------------------------
		-- 同时指定图片文件夹和声音文件夹的位置 , 末尾会自动添加 "/"<br>
		-- 需要添加 __ModName__ , 不添加的话将可能无法正确读取文件<br>
		-- 设置此项时 , 将忽略下方的 Picture 和 Sound 的值<br>
		-- 值参考 : "__ModName__/resources"<br>
		-- ----------------------------------------
		Resource = nil ,

		-- ----------------------------------------
		-- 指定图片文件夹的位置 , 末尾会自动添加 "/"<br>
		-- 需要添加 __ModName__ , 不添加的话将可能无法正确读取文件<br>
		-- 值参考 : "__ModName__/graphics"<br>
		-- ----------------------------------------
		Picture = nil ,

		-- ----------------------------------------
		-- 指定声音文件夹的位置 , 末尾会自动添加 "/"<br>
		-- 需要添加 __ModName__ , 不添加的话将可能无法正确读取文件<br>
		-- 值参考 : "__ModName__/sounds"<br>
		-- ----------------------------------------
		Sound = nil
	} ,

	-- ----------------------------------------
	-- 自动创建子表 , 其中定义的内容会根据规则自动创建<br>
	-- 完成自动创建后 , 此属性会被删除<br>
	-- ----------------------------------------
	Autoload =
	{
		-- ----------------------------------------
		-- 用于控制是否把此 ConstantsData 中的一些属性实体化 , 具体实体化的属性请见各个条目<br>
		-- 没有此属性会被自动添加 , 默认 : true<br>
		-- ----------------------------------------
		Enable = true ,

		-- ----------------------------------------
		-- 自动创建设置 , [ ConstantsData.Autoload.Enable ] 为 true 时才会自动创建<br>
		-- 每个设置都是由键值对组成 , 键为设置的 ID , 进而计算成实际的 [ name ] 值 , 而值是一个数组 , 填写了创建一个设置必要的参数<br>
		-- 数组中最多可以有 8 个元素 , 含义分别是 :<br>
		-- 元素 1 : 设置的类型 , 对应原型中的 [ type ] 属性 , 末尾不需要添加 "-setting" , 可以使用 SICommon.SettingTypes 中的预设值<br>
		-- 元素 2 : 设置的生效类型 , 对应原型中的 [ setting_type ] 属性 , 可以使用 SICommon.SettingAffectTypes 中的预设值<br>
		-- 元素 3 : 默认值 , 对应原型中的 [ default_value ] 属性<br>
		-- <br>
		-- 当是布尔型的设置时<br>
		-- 元素 4 : 本地化名称 , 对应原型中的 [ localised_name ] 属性 , 默认 : { "SISettingName.[ ShowName ]-[ SettingID ]" }<br>
		-- 元素 5 : 本地化描述 , 对应原型中的 [ localised_description ] 属性 , 默认 : { "SICommon.SettingsDescription" , ConstantsData.localisedName , { "SISettingDescription.[ ShowName ]-[ SettingID ]" } , [ default_value ] }<br>
		-- <br>
		-- 当是数字型的设置时<br>
		-- 元素 4 : 最小值 , 对应原型中的 [ minimum_value ] 属性<br>
		-- 元素 5 : 最大值 , 对应原型中的 [ maximum_value ] 属性<br>
		-- 元素 6 : 可用值 , 用于制作下拉列表 , 对应原型中的 [ allowed_values ] 属性 , 它是一个数组<br>
		-- 元素 7 : 本地化名称 , 对应原型中的 [ localised_name ] 属性 , 默认 : { "SISettingName.[ ShowName ]-[ SettingID ]" }<br>
		-- 元素 8 : 本地化描述 , 对应原型中的 [ localised_description ] 属性 , 默认 : { "SICommon.SettingsDescription" , ConstantsData.localisedName , { "SISettingDescription.[ ShowName ]-[ SettingID ]" } , [ default_value ] }<br>
		-- <br>
		-- 当是字符串型的设置时<br>
		-- 元素 4 : 是否可以为空 , 对应原型中的 [ allow_blank ] 属性 , 字符串型的设置专用 , 默认 : false<br>
		-- 元素 5 : 可用值 , 用于制作下拉列表 , 对应原型中的 [ allowed_values ] 属性 , 它是一个数组<br>
		-- 元素 6 : 本地化名称 , 对应原型中的 [ localised_name ] 属性 , 默认 : { "SISettingName.[ ShowName ]-[ SettingID ]" }<br>
		-- 元素 7 : 本地化描述 , 对应原型中的 [ localised_description ] 属性 , 默认 : { "SICommon.SettingsDescription" , ConstantsData.localisedName , { "SISettingDescription.[ ShowName ]-[ SettingID ]" } , [ default_value ] }<br>
		-- <br>
		-- 其余的属性比如 order 都是自动补充的<br>
		-- 不使用某个属性时 , 可以填 nil<br>
		-- <br>
		-- 没有此属性会放弃自动创建<br>
		-- ----------------------------------------
		Settings =
		{
			ShowMainbar = { SICommon.SettingTypes.BOOL , SICommon.SettingAffectTypes.PerUser , true } ,
			ShowHiddenEntity = { SICommon.SettingTypes.BOOL , SICommon.SettingAffectTypes.PerUser , false }
		} ,

		-- ----------------------------------------
		-- 自动创建分组 , [ ConstantsData.Autoload.Enable ] 为 true 时才会自动创建<br>
		-- <br>
		-- 每个分组都是由键值对组成 , 键为分组的 ID , 进而计算成实际的 [ name ] 值 , 而值是一个数组 , 其中包含了这个分组的别名和所有子分组的 ID 和别名<br>
		-- 值的结构如下 :<br>
		-- {<br>
		--     Name =  别名 , 在计算 [ name ] 值时代替 ID 进行计算<br>
		--     Order = 排序编号 , 效果等于 [ ConstantsData.Order ] , 只不过它仅在创建分组的时候代替 [ ConstantsData.Order ] 使用<br>
		--     SubOrder = 子分组的排序编号 , 默认 "0"<br>
		--     Subgroups =<br>
		--     {<br>
		--         子分组id1 = 子分组别名1 , 不想写别名就写个布尔型的 false 就行了<br>
		--         子分组id2 = 子分组别名2<br>
		--         ...<br>
		--     }<br>
		-- }<br>
		-- <br>
		-- 自动创建的分组类型会自动创建属性 :<br>
		-- localised_name        = { "[ CodeName ]Name.[ 类型别名 ]-[ 别名或 ID ]" } , 子分组就时子分组的别名和 ID<br>
		-- localised_description = { "[ CodeName ]Description.[ 类型别名 ]-[ 别名或 ID ]" } , 子分组就时子分组的别名和 ID<br>
		-- icon                  = "[ PicturePath ][ 类型别名 ]-[ 别名或 ID ]-[ 类型别名 ICON 项 ].png" , 子分组没有图标 , 默认 : size = 64 , mipmaps = 0<br>
		-- order 会被自动补充<br>
		-- [ 类型别名 ] 请见 SICommon.ShowNamePrefix 表<br>
		-- ----------------------------------------
		Groups =
		{
			Expand =
			{
				Name = "扩展" ,
				Order = "9997" ,
				SubOrder = "0" ,
				Subgroups =
				{
					Misc = "杂项"
				}
			} ,
			Other =
			{
				Name = "杂项" ,
				Order = "9998" ,
				SubOrder = "0" ,
				Subgroups =
				{
					Misc = "杂项"
				}
			} ,
			Hidden =
			{
				Name = "隐藏" ,
				Order = "9999" ,
				SubOrder = "0" ,
				Subgroups =
				{
					Base = "基础" ,
					Debug = "调试物品" ,
					Tool = "特殊工具" ,
					Icon = "图标物品"
				}
			}
		} ,

		-- ----------------------------------------
		-- 自动创建子分组并添加至指定分组 , [ ConstantsData.Autoload.Enable ] 为 true 时才会自动创建<br>
		-- 这是自动创建分组的第二种形式 , 给目标分组添加子分组<br>
		-- 要求执行自动创建时 , 目标分组已经存在 , 即当前 ConstantsData 要比目标 ConstantsData 晚加载<br>
		-- ConstantsData 的加载顺序由 CustomPackageConfig 数组或 PackageConfig.lua 文件决定<br>
		-- 注意 : 在这里自动创建的子分组会归属于当前 ConstantsData<br>
		-- <br>
		-- 每个分组都是由键值对组成 , 键为分组的 ID , 用于从目标 ConstantsData 中读取分组的信息<br>
		-- 值的结构如下 :<br>
		-- {<br>
		--     ConstantsDataCodeName = 目标 ConstantsData 的 CodeName 值 , 可以取当前正在加载的 ConstantsData 的 CodeName 属性 , 也可以通过 BeforeLoad 函数使用代码来添加 , 省去手动计算的麻烦<br>
		--     SubOrder = 子分组的排序编号 , 默认 "0"<br>
		--     Subgroups =<br>
		--     {<br>
		--         子分组id1 = 子分组别名1 , 不想写别名就写个布尔型的 false 就行了<br>
		--         子分组id2 = 子分组别名2<br>
		--         ...<br>
		--     }<br>
		-- }<br>
		-- <br>
		-- 自动创建的子分组类型会自动创建属性 :<br>
		-- localised_name        = { "[ CodeName ]Name.[ 类型别名 ]-[ 别名或 ID ]" } , 子分组就时子分组的别名和 ID<br>
		-- localised_description = { "[ CodeName ]Description.[ 类型别名 ]-[ 别名或 ID ]" } , 子分组就时子分组的别名和 ID<br>
		-- order 会被自动补充<br>
		-- [ 类型别名 ] 请见 SICommon.ShowNamePrefix 表<br>
		-- 属性值全部取自当前 ConstantsData 的属性 , 而非目标 ConstantsData 的属性
		-- ----------------------------------------
		GroupsAppend =
		{
			Other =
			{
				ConstantsDataCodeName = "SICore" , -- 可以通过 BeforeLoad 函数使用目标 ConstantsData 的全局变量来添加它的 CodeName 属性 , 省去手动计算的麻烦
				SubOrder = "9999" ,
				Subgroups =
				{
					Other = "其他"
				}
			}
		} ,

		-- ----------------------------------------
		-- 自动创建伤害类型 , [ ConstantsData.Autoload.Enable ] 为 true 时才会自动创建<br>
		-- <br>
		-- 每个伤害类型都是由键值对组成 , 键为伤害类型的 ID , 进而计算成实际的 [ name ] 值 , 而值是一个表 , 其中包含了这个伤害类型的别名和默认抗性<br>
		-- 值的结构如下 :<br>
		-- {<br>
		--     Name = 别名 , 在计算 [ name ] 值时代替 ID 进行计算<br>
		--     Decrease = 伤害减少数值量<br>
		--     Percent = 伤害百分比减少量<br>
		-- }<br>
		-- 默认抗性在 data-final-fixes 阶段才会被处理<br>
		-- <br>
		-- 自动创建的伤害类型会自动创建属性 :<br>
		-- localised_name        = { "[ CodeName ]Name.[ 类型别名 ]-[ 别名或 ID ]" }<br>
		-- localised_description = { "[ CodeName ]Description.[ 类型别名 ]-[ 别名或 ID ]" }<br>
		-- order 会被自动补充<br>
		-- [ 类型别名 ] 请见 SICommon.ShowNamePrefix 表<br>
		-- ----------------------------------------
		DamageTypes =
		{
			-- 物理伤害
			PhysicWater     = { Name = "潮湿" } ,
			PhysicDry       = { Name = "干燥" } ,
			PhysicIce       = { Name = "冰冻" } ,
			PhysicRadiation	= { Name = "辐射" } ,
			PhysicCorrosion = { Name = "腐蚀" } ,
			PhysicSound     = { Name = "声波" } ,
			PhysicEnergy    = { Name = "能量" } ,
			PhysicGravity   = { Name = "重力" } ,
			-- 魔法伤害
			MagicPower      = { Name = "力量" } ,
			MagicSpirit     = { Name = "意念" } ,
			MagicBlood      = { Name = "献祭" } ,
			MagicDisease    = { Name = "瘟疫" } ,
			MagicFear       = { Name = "恐惧" } ,
			MagicTwist      = { Name = "扭曲" } ,
			MagicCorrosion  = { Name = "侵蚀" } ,
			MagicVoid       = { Name = "虚空" } ,
			-- 元素伤害
			ElementCut      = { Name = "割元素" } ,
			ElementHeat     = { Name = "炎元素" } ,
			ElementGround   = { Name = "固元素" } ,
			ElementWater    = { Name = "流元素" } ,
			ElementWind     = { Name = "气元素" } ,
			ElementLife     = { Name = "命元素" } ,
			ElementSound    = { Name = "音元素" } ,
			ElementElectric = { Name = "电元素" } ,
			ElementLight    = { Name = "光元素" } ,
			ElementDary     = { Name = "影元素" } ,
			ElementEnergy   = { Name = "能元素" } ,
			ElementHeavy    = { Name = "质元素" } ,
			ElementFull     = { Name = "盈元素" } ,
			ElementVoid     = { Name = "虚元素" } ,
			ElementSkill    = { Name = "技元素" } ,
			-- 其他伤害
			DamageSpace     = { Name = "空间" } ,
			DamageThought   = { Name = "精神" } ,
			DamageSoul      = { Name = "灵魂" }
		} ,

		-- ----------------------------------------
		-- 自动创建分类类型 , [ ConstantsData.Autoload.Enable ] 为 true 时才会自动创建<br>
		-- <br>
		-- 每个分类类型都是由键值对组成 , 键为 ID , ID 等于 SICommon.Types.Categories 下的类型的键的值<br>
		-- 值是一个数组 , 数组的每一个键值对就是一个实际的分类类型 , 键是分类类型的 ID , 进而计算成实际的 [ name ] 值 , 值是别名 , 在计算 [ name ] 值时代替 ID 进行计算<br>
		-- <br>
		-- 自动创建的分类类型会自动创建属性 :<br>
		-- localised_name        = { "[ CodeName ]Name.[ 类型别名 ]-[ 别名或 ID ]" }<br>
		-- localised_description = { "[ CodeName ]Description.[ 类型别名 ]-[ 别名或 ID ]" }<br>
		-- order 会被自动补充<br>
		-- [ 类型别名 ] 请见 SICommon.ShowNamePrefix 表<br>
		-- ----------------------------------------
		Categories =
		{
			Ammo =
			{
				Special = "特殊弹药"
			} ,
			Equipment =
			{
				Special = "特殊模块"
			} ,
			Fuel =
			{
				Special = "特殊燃料" ,
			} ,
			Module =
			{
				FishModule = "双鱼插件"
			}
		}
	} ,

	-- ------------------------------------------------------------------------------------------------
	-- ---------- 生命周期 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------

	-- ----------------------------------------
	-- 加载开始前回调 , 用于完善此 ConstantsData 自身的数据<br>
	-- 此时 ClassName , CodeName , ShowName , ShowNamePrefix , OrderPrefix , OrderCode , LocalisedName , LocalisedDescription 属性均已生成<br>
	-- 全局变量已注册 , API 表和 raw 表已创建但未填充<br>
	-- 注意 : 只有 data 阶段和 control 阶段才有 raw 表<br>
	-- 如果没有定义此函数则不会调用<br>
	-- 参数为当前正在加载的 ConstantsData<br>
	-- ----------------------------------------
	-- BeforeLoad = function( constantsData ) end ,

	-- ----------------------------------------
	-- 加载完毕后回调 , 用于完善此 ConstantsData 自身的数据<br>
	-- 此时当前阶段下的所有自动生成属性均已生成 , 所有注册位置均已注册 , API 表和 raw 表已完善 , 此 ConstantsData 对应的 SIConfigs 已加载<br>
	-- 如果没有定义此函数则不会调用<br>
	-- 参数为当前正在加载的 ConstantsData<br>
	-- ----------------------------------------
	-- AfterLoad = function( constantsData ) end ,

	-- ------------------------------------------------------------------------------------------------
	-- ------- 自动生成的属性 -------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------

	-- ----------------------------------------
	-- 自动生成的属性 , 其中的值请勿手动修改
	-- ClassName            = string   , 全局变量名称
	-- CodeName             = string   , 在本地化字符串中用作分组标签 , 以及作为注册名
	-- ShowName             = string   , 在日志或调试信息中输出使用的名称
	-- ShowNamePrefix       = string   , 物品 , 实体 , 配方等的 [ name ] 中会添加此前缀 , 不影响本地化翻译项目
	-- OrderPrefix          = string   , 物品 , 实体 , 配方等的排序字符串的前缀
	-- OrderCode            = int      , 物品 , 实体 , 配方等的排序编号 , 一直递增 , 上限 10000
	-- LocalisedName        = {}       , 此 ConstantsData 的本地化名称 , 值为 "ConstantsDataName.[ CodeName ]" , 其中的所有 "_" 都会被替换成 "-"
	-- LocalisedDescription = {}       , 此 ConstantsData 的本地化描述 , 值为 "ConstantsDataDescription.[ CodeName ]" , 其中的所有 "_" 都会被替换成 "-"
	-- GetOrderString       = function , 是个无参数的函数 , 返回下一个此 ConstantsData 的排序字符串
	-- PicturePath          = string   , 指向了当前功能包所使用的图片文件所在的文件夹位置 , 默认值 : __ModName__/package/[ PackageName ]/graphic/
	-- SoundPath            = string   , 指向了当前功能包所使用的声音文件所在的文件夹位置 , 默认值 : __ModName__/package/[ PackageName ]/sound/
	-- API                  = {}       , 包含了此 ConstantsData 的一些原始属性和自动生成的函数
	-- raw                  = {}       , 包含了自动处理后的各种物品 , 实体 , 配方等的名称
	--
	-- API 中包含的属性 :
	-- API.ID               = string   , 等于此 [ ConstantsData.ID ] 的值
	-- API.PackageName      = string   , 此 ConstantsData 所在的功能包的文件夹名称
	-- API.ClassName        = string   , 等于此 [ CnstantsData.ClassName ] 的值
	-- API.OrderPrefix      = string   , 等于此 [ CnstantsData.OrderPrefix ] 的值
	-- API.GetOrderString   = function , 等于此 [ CnstantsData.GetOrderString ] 的值 , 是个无参数的函数 , 返回下一个此 ConstantsData 的排序字符串
	--
	-- raw 中包含的属性 :
	-- raw.Groups           = {}       , 其中包含了自动创建的子分组的名称 , 键的值等于 [ Autoload ] 中的子分组的名称 , 值的值等于子分组的实际 [ name ] 值 , 结构是 raw.Groups[分组 ID][子分组 ID]
	-- raw.DamageTypes      = {}       , 其中包含了自动创建的伤害类型的名称 , 键的值等于 [ Autoload ] 中的伤害类型的名称 , 值的值等于伤害类型的实际 [ name ] 值
	-- raw.DamageTypeValues = {}       , 其中包含了自动创建的伤害类型的抗性 , 键的值等于 [ Autoload ] 中的伤害类型的名称 , 值的值等于 [ Autoload ] 中伤害类型定义的抗性值 , 已经过处理可以直接使用
	-- ----------------------------------------

	-- ------------------------------------------------------------------------------------------------
	-- -------- 自定义的属性 --------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	
	-- ----------------------------------------
	-- ConstantsData 的属性不是固定的 , 可以自由添加其他属性<br>
	-- 不过这些自定义的属性 , 框架是不会直接处理的 , 需要手动处理<br>
	-- ----------------------------------------
	TankCollisionMaskLayer = SIUtils.CollisionMask.get_first_unused_layer()
}

return constantsData
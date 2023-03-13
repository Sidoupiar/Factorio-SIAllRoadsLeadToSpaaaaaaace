local SkillTypes =
{
	Active = "Active" ,
	Passive = "Passive" ,
	Buff = "Buff" ,
	Special = "Special"
}

SIRPGSkillData =
{
	{
		Type = SkillTypes.Passive ,
		ID = "SI技能-强壮" ,
		Name = { "SIRPGSystem.技能-强壮-名称" } ,
		Description = { "SIRPGSystem.技能-强壮-描述" } ,
		IconItem = nil ,
		SkillItem = nil ,
		TriggerID = nil ,
		IsPassive = true ,
		EffectInterface = SIRPGSkillUI_Other.InterfaceID ,
		EffectFunctionName = "Strong" ,
		Permission = nil ,
		Order = "SI技能-强壮" ,
		Attack =
		{
			Name = "SIRPGSystem.技能-强壮-战斗点数" ,
			Tooltip = "SIRPGSystem.技能-强壮-战斗点数-提示" ,
			ShowValue = "SIRPGSystem.技能显示-点数-提高" ,
			Value = 0.2 , -- 每级提高 0.2 点
			Max = 200
		} ,
		Adventure =
		{
			Name = "SIRPGSystem.技能-强壮-探索点数" ,
			Tooltip = "SIRPGSystem.技能-强壮-探索点数-提示" ,
			ShowValue = "SIRPGSystem.技能显示-百分比-提高" ,
			Value = 0.1 , -- 每级降低 0.1%
			Max = 200
		} ,
		Craft =
		{
			Name = "SIRPGSystem.技能-强壮-生存点数" ,
			Tooltip = "SIRPGSystem.技能-强壮-生存点数-提示" ,
			ShowValue = "SIRPGSystem.技能显示-点数-降低" ,
			Value = 0.2 , -- 每级降低 0.2 点
			Max = 200
		} ,
		Unlock = nil ,
		Cost = nil ,
		Cooldown = 0 , -- 游戏刻 , 被动技能没有冷却时间
		DefaultCustomData = nil
	} ,
	{
		Type = SkillTypes.Special ,
		ID = "SI技能-洞察" ,
		Name = { "SIRPGSystem.技能-洞察-名称" } ,
		Description = { "SIRPGSystem.技能-洞察-描述" , 120 } ,
		IconItem = nil ,
		SkillItem = nil ,
		TriggerID = nil ,
		IsPassive = false ,
		EffectInterface = SIRPGSkillUI_OverView.InterfaceID ,
		EffectFunctionName = "OpenFrame" ,
		Permission = nil ,
		Order = "SI技能-洞察" ,
		Attack =
		{
			Name = "SIRPGSystem.技能-洞察-战斗点数" ,
			Tooltip = "SIRPGSystem.技能-洞察-战斗点数-提示" ,
			ShowValue = "SIRPGSystem.技能显示-时间-提高" ,
			Value = 0.2 , -- 每级提高 0.2 秒
			Max = nil
		} ,
		Adventure =
		{
			Name = "SIRPGSystem.技能-洞察-探索点数" ,
			Tooltip = "SIRPGSystem.技能-洞察-探索点数-提示" ,
			ShowValue = "SIRPGSystem.技能显示-时间-降低" ,
			Value = 0.2 , -- 每级降低 0.2 秒
			Max = 600
		} ,
		Craft =
		{
			Name = "SIRPGSystem.技能-洞察-生存点数" ,
			Tooltip = "SIRPGSystem.技能-洞察-生存点数-提示" ,
			ShowValue = "SIRPGSystem.技能显示-数量-提高" ,
			Value = 0.02 ,
			Max = nil
		} ,
		Unlock = nil ,
		Cost =
		{
			Value =
			{
				Mana = 80 ,
				Energy = 120
			} ,
			Item = nil
		} ,
		Cooldown = 7200 , -- 游戏刻 , 实际 120 秒
		DefaultCustomData =
		{
			DefaultPointDataIndex = nil ,
			CurrentPoint = nil ,
			PointList = {}
		}
	}
}


-- 技能说明
-- 一个完整的技能的数据结构如下 :
--[[
local example =
{
	Type = "技能类型 , 可以是任意字符串 , 显示文本为 SIRPGSystem.技能类型-[ 此值 ] " ,
	ID = "技能的 ID , 不允许重复 , 即使类别不一样" ,
	Name = { "技能的显示名称 , 本地化字符串" } ,
	Description = { "技能的显示描述 , 本地化字符串" } ,
	IconItem = "用来显示的物品图标 , 按钮图标显示的物品的 [ name ] 值" ,
	SkillItem = "技能物品 , 使用技能时丢出的物品的 [ name ] 值 , 没有无技能物品的非被动技能会被视为 [ 面板技能 ]" ,
	TriggerID = "投掷物触发此 ID 时会被视为使用了技能 , 需要和技能物品关联 , 如果技能物品扔不出去或 ID 不匹配 , 则此技能永远都用不出来" ,
	IsPassive = "是否为被动技能 , 被动技能只有在修改等级时才会被使用" ,
	EffectInterface = "使用技能时调用的接口函数集的名称" ,
	EffectFunctionName = "使用技能时调用的接口函数的名称 , 如果函数不存在 , 则技能不可用 , 有五个参数 , 第 1 个是玩家索引 playerIndex , 第 2 个是此技能数据包 (副本) , 第 3 个是玩家技能数据包 (副本) , 第 4 个是是否为快速使用 , 面板技能使用 , 第 5 个是当前游戏刻 , 可以有返回值 , 不同的技能类型返回值的含义不一样" ,
	Permission = "需求的权限 , 拥有权限才能使用这个技能" ,
	Order = "排序字符串" ,
	Attack =
	{
		Name = "战斗点数对应的等级效果 , 本地化字符串的键 , 有两个参数 , 第 1 个是每级效果 , 第 2 个是最高等级" ,
		Tooltip = "战斗点数对应的等级效果 , 详细说明 , 本地化字符串的键 , 有两个参数 , 第 1 个是每级效果 , 第 2 个是最高等级" ,
		ShowValue = "战斗点数对应的等级效果实际加成使用的本地化字符串 , 本地化字符串的键 , 显示于技能等级部分第三列 , 有两个参数 , 第 1 个是生效的效果值 , 第 2 个是最大的效果值" ,
		Value = "每级提高属性 , 正数 , 浮点数" ,
		Max = "最高等级 , 正数 , 整数"
	} ,
	Adventure =
	{
		Name = "探索点数对应的等级效果 , 本地化字符串的键 , 有两个参数 , 第 1 个是每级效果 , 第 2 个是最高等级" ,
		Tooltip = "探索点数对应的等级效果 , 详细说明 , 本地化字符串的键 , 有两个参数 , 第 1 个是每级效果 , 第 2 个是最高等级" ,
		ShowValue = "探索点数对应的等级效果实际加成使用的本地化字符串 , 本地化字符串的键 , 显示于技能等级部分第三列 , 有两个参数 , 第 1 个是生效的效果值 , 第 2 个是最大的效果值" ,
		Value = "每级提高属性 , 正数 , 浮点数" ,
		Max = "最高等级 , 正数 , 整数"
	} ,
	Craft =
	{
		Name = "生存点数对应的等级效果 , 本地化字符串的键 , 有两个参数 , 第 1 个是每级效果 , 第 2 个是最高等级" ,
		Tooltip = "生存点数对应的等级效果 , 详细说明 , 本地化字符串的键 , 有两个参数 , 第 1 个是每级效果 , 第 2 个是最高等级" ,
		ShowValue = "生存点数对应的等级效果实际加成使用的本地化字符串 , 本地化字符串的键 , 显示于技能等级部分第三列 , 有两个参数 , 第 1 个是生效的效果值 , 第 2 个是最大的效果值" ,
		Value = "每级提高属性 , 正数 , 浮点数" ,
		Max = "最高等级 , 正数 , 整数"
	} ,
	Unlock =
	{
		-- 解锁条件
		-- 不写任何解锁条件或为 nil 则注册此技能时会立刻解锁
		-- 条件必须全部满足才可以解锁技能
		-- 未解锁的技能不会在技能面板显示
		Level =
		{
			-- 三种等级 , 玩家对应的等级必须超过才能解锁技能
			Attack = 1 ,
			Adventure = 1 ,
			Craft = 1
		} ,
		Point =
		{
			-- 三种点数 , 玩家对应的点数最大值必须超过才能解锁节能
			Attack = 1 ,
			Adventure = 1 ,
			Craft = 1
		} ,
		Property =
		{
			-- 对应的属性等级必须超过才能解锁技能 , 可用值请见 SIRPGSystem.PropertyIDs
			["PropertyID"] = 1
		} ,
		Addition =
		{
			-- 对应的加成等级必须超过才能解锁技能 , 可用值请见 SIRPGSystem.AdditionIDs
			["AdditionID"] = 1
		}
	} ,
	Cost =
	{
		-- 使用技能的消耗 , 必去满足全部条件才能使用技能
		Value =
		{
			-- 使用技能时消耗的数值
			-- 只能是 Health , Strength , Mana , Energy , Thought , Soul 中的一个
			Health = 1
		} ,
		Item =
		{
			["物品 [ name ] 值 1"] = 1
		}
	} ,
	Cooldown = "技能冷却时间 , 被动技能无冷却时间 , 正数 , 整数 , 游戏刻" ,
	DefaultCustomData =
	{
		-- 这里是自定义数据结构 , 可以是任意结构 , 但是不建议过于复杂
		-- 这部分数据会位于 playerSkillData.CustomData 中
		-- 保存 playerSkillData 时 , 这部分数据也会进行保存
	}
}
]]
-- 关于技能类型 :
-- Type 只是在玩家技能列表分页的标识 , 并不指定具体的技能类型
-- 技能类型一共有三种 :
--
-- 第 1 种是被动技能 , 它们在等级发生变化时被触发 , 没有任何消耗 , 没有任何冷却时间
--        特点是 , SkillItem , TriggerID , Cost 和 Cooldown 的设置是无意义的 , 施放技能时不检测冷却时间
--        如果没有权限则不会被触发
--        接口的返回值中之后 CustomData 会被保存 , 直接覆盖
--
-- 第 2 种是主动技能 , 不管是 Buff , 开关 , 还是别的主动技能 , 它们都是主动技能
--        特点是 , 它们需要先从技能面板领取 [ 技能物品 ] , 然后投掷技能物品引发 TriggerID , 此时使用技能的请求才会触发
--        自动消耗 Cost , 自动进入 Cooldown , 施放技能时自动检测冷却时间
--        如果没有权限则物品白扔
--        接口的返回值中 Cooldown 和 CustomData 会被保存 , 直接覆盖
--
-- 第 3 种是面板技能 , 它们通常都比较复杂 , 拥有特殊的消耗规则或操作方式 , 甚至有窗口可以进行附加操作
--        特点是 , 点击技能面板的按钮时会直接使用 , 而非通过技能物品的投掷 , 施放技能时不检测冷却时间
--        不自动消耗 Cost , 不自动进入 Cooldown , 需要在进入接口后通过返回值和 SIRPGSystem 的接口函数来消耗 Cost 或进入 Cooldown
--        如果没有权限则不会被使用
--        接口的返回值中 Cooldown 和 CustomData 会被保存 , 直接覆盖

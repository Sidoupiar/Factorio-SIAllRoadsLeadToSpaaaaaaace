-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 使用说明 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================
-- [全局持久化]
-- 这是一个本地化的模块 , 每个 contrl 层都需要单独引入
-- ======================================================================
-- [作用]
-- 通过给出一个表名
-- 它会创建一个以这个表名为引用名的全局表
-- 并且会自动在 init 中初始化它 , 在 load 中加载它
-- ======================================================================
-- [注意]
-- 你不能在事件外面修改它创建的全局表
-- 因为这些修改会被 init 和 load 函数行为覆盖
-- ======================================================================

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 基础数据 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

---@class SIGlobal : SIBaseClass
SIGlobal =
{
	ID = "SIGlobal" ,
	Code = "SIGlobal" ,
	Show = "全局持久化" ,
	SettingTypeDefine =
	{
		Global = 0 ,
		Player = 1 ,
		Force = 2
	} ,
	NotAdd = true ,
	SettingDataList = {} ,
	TempGlobal = {}
}

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 检查引用 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

if not SIEventBus then
	UseE( SIGlobal , "必须启用 SIEventBus 之后才能使用 SIGlobal 模块" )
end

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 基础存取函数 ====================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================<br>
-- 把数据保存进 global 表中<br>
-- ======================================================================<br>
---@param name string -- 键
---@param data any -- 值
---@return SIGlobal -- 自身
function SIGlobal.Set( name , data )
	storage[name] = data
	return SIGlobal
end

-- ======================================================================<br>
-- 从 global 表中取出数据<br>
-- ======================================================================<br>
---@param name string -- 键
---@return any -- 值
function SIGlobal.Get( name )
	return storage[name]
end

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 自动创建设置数据 ================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================<br>
-- 在 SIGlobal 中注册一个设置数据<br>
-- ======================================================================<br>
-- 设置数据中包含的属性 :<br>
-- Name           = 引用名称 , 作为设置数据的键存在 , 即 global[引用名称]<br>
-- Default        = 默认数据 , 当需要引用设置数据时 , 如果没有找到可用的设置数据 , 则会根据给定的参数和默认数据初始化一份设置数据<br>
-- DefaultGlobal  = 全局设置使用的默认数据 , 此属性存在时忽略 Default 属性
-- DefaultPlayer  = 玩家设置使用的默认数据 , 此属性存在时忽略 Default 属性
-- DefaultForce   = 阵营设置使用的默认数据 , 此属性存在时忽略 Default 属性
-- InitFunction   = 初始化函数 , 并非是初始化设置时使用的函数 , 而是在 script.on_init 过程中调用的函数 , 有 1 个参数 , 参数 1 = 新创建的数据本体<br>
-- ModifyFunction = 修改函数 , 并非是更改数据时使用的函数 , 而是在 script.on_configuration_changed 过程中调用的函数 , 有 1 个参数 , 参数 1 = 新创建的数据本体<br>
-- CreateFunction = 每次根据给定的参数和默认数据初始化设置数据时 , 会调用一次 , 有 3 个参数 , 参数 1 = 设置的引用名称 , 参数 2 = 刚创建的设置数据子表 , 参数 3 = 1 为玩家设置 , 2 为阵营设置 , 0 为全局设置<br>
-- ======================================================================<br>
---@param settingData table -- 设置数据
---@return SIGlobal -- 自身
function SIGlobal.CreateSettings( settingData )
	if SIGlobal.SettingDataList[settingData.Name] then
		return CodeE( SIGlobal , "设置数据的 [ name ] 属性不能相同 , " .. settingData.Name )
	end
	SIGlobal.SettingDataList[settingData.Name] = SIUtils.table.deepcopy( settingData )
	if SIGlobal.NotAdd then
		SIGlobal.NotAdd = false
		SIEventBus.Init( SIGlobal.CreateOnInit )
		SIEventBus.ConfigurationChange( SIGlobal.ModifyOnChange )
	end
	return SIGlobal
end

-- ======================================================================<br>
-- 通过 SIGlobal 判断是否存在指定的全局设置数据<br>
-- ======================================================================<br>
---@param settingName string -- 设置数据的引用名称
---@return boolean -- 是否存在全局设置数据
function SIGlobal.HasGlobalSettings( settingName )
	local settings = SIGlobal.Get( settingName )
	if not settings then
		CodeE( SIGlobal , "无法负责维护未注册或被外部代码影响的设置数据" )
		return false
	end
	return settings.Global ~= nil
end

-- ======================================================================<br>
-- 通过 SIGlobal 获取全局设置数据<br>
-- 如果还未定义相应的全局设置 , 则会根据注册时的设置数据初始化一份<br>
-- ======================================================================<br>
---@param settingName string -- 设置数据的引用名称
---@return table -- 符合条件的设置数据子表
function SIGlobal.GetGlobalSettings( settingName )
	local settings = SIGlobal.Get( settingName )
	if not settings then
		CodeE( SIGlobal , "无法负责维护未注册或被外部代码影响的设置数据" )
		return {}
	end
	if not settings.Global then
		local settingData = SIGlobal.SettingDataList[settingName]
		if not settingData then
			CodeE( SIGlobal , "无法负责维护未注册或被外部代码影响的设置数据" )
			return {}
		end
		settings.Global = SIUtils.table.deepcopy( settingData.DefaultGlobal or settingData.Default )
		if settingData.CreateFunction then
			settingData.CreateFunction( settingName , settings.Global , SIGlobal.SettingTypeDefine.Global )
		end
	end
	return settings.Global
end

-- ======================================================================<br>
-- 通过 SIGlobal 判断是否存在指定的玩家设置数据<br>
-- ======================================================================<br>
---@param settingName string -- 设置数据的引用名称
---@param playerIndex integer -- 玩家编号
---@return boolean -- 是否存在指定的玩家设置数据
function SIGlobal.HasPlayerSettings( settingName , playerIndex )
	local settings = SIGlobal.Get( settingName )
	if not settings or not settings.Player then
		CodeE( SIGlobal , "无法负责维护未注册或被外部代码影响的设置数据" )
		return false
	end
	return settings.Player[playerIndex] ~= nil
end

-- ======================================================================<br>
-- 通过 SIGlobal 获取玩家设置数据<br>
-- 如果还未定义相应的全局设置 , 则会根据注册时的设置数据初始化一份<br>
-- ======================================================================<br>
---@param settingName string -- 设置数据的引用名称
---@param playerIndex integer -- 玩家编号
---@return table -- 符合条件的设置数据子表
function SIGlobal.GetPlayerSettings( settingName , playerIndex )
	local settings = SIGlobal.Get( settingName )
	if not settings or not settings.Player then
		CodeE( SIGlobal , "无法负责维护未注册或被外部代码影响的设置数据" )
		return {}
	end
	local playerSettings = settings.Player[playerIndex]
	if not playerSettings then
		local settingData = SIGlobal.SettingDataList[settingName]
		if not settingData then
			CodeE( SIGlobal , "无法负责维护未注册或被外部代码影响的设置数据" )
			return {}
		end
		playerSettings = SIUtils.table.deepcopy( settingData.DefaultPlayer or settingData.Default )
		playerSettings.playerIndex = playerIndex
		if settingData.CreateFunction then
			settingData.CreateFunction( settingName , playerSettings , SIGlobal.SettingTypeDefine.Player )
		end
		settings.Player[playerIndex] = playerSettings
	end
	return playerSettings
end

-- ======================================================================<br>
-- 通过 SIGlobal 获取所有玩家的设置数据<br>
-- 如果某个玩家没有数据 , 则并不会帮助初始化 , 因此返回值中不会有他的设置数据<br>
-- ======================================================================<br>
---@param settingName string -- 设置数据的引用名称
---@return table -- 全部玩家的设置数据子表
function SIGlobal.GetAllPlayerSettings( settingName )
	local settings = SIGlobal.Get( settingName )
	if not settings then
		CodeE( SIGlobal , "无法负责维护未注册或被外部代码影响的设置数据" )
		return {}
	end
	return settings.Player
end

-- ======================================================================<br>
-- 通过 SIGlobal 判断是否存在指定的阵营设置数据<br>
-- ======================================================================<br>
---@param settingName string -- 设置数据的引用名称
---@param forceIndex integer -- 阵营编号
---@return boolean -- 是否存在指定的阵营设置数据
function SIGlobal.HasForceSettings( settingName , forceIndex )
	local settings = SIGlobal.Get( settingName )
	if not settings or not settings.Force then
		CodeE( SIGlobal , "无法负责维护未注册或被外部代码影响的设置数据" )
		return false
	end
	return settings.Force[forceIndex] ~= nil
end

-- ======================================================================<br>
-- 通过 SIGlobal 获取阵营设置数据<br>
-- 如果还未定义相应的全局设置 , 则会根据注册时的设置数据初始化一份<br>
-- ======================================================================<br>
---@param settingName string -- 设置数据的引用名称
---@param forceIndex integer -- 阵营编号
---@return table -- 符合条件的设置数据子表
function SIGlobal.GetForceSettings( settingName , forceIndex )
	local settings = SIGlobal.Get( settingName )
	if not settings or not settings.Force then
		CodeE( SIGlobal , "无法负责维护未注册或被外部代码影响的设置数据" )
		return {}
	end
	local forceSettings = settings.Force[forceIndex]
	if not forceSettings then
		local settingData = SIGlobal.SettingDataList[settingName]
		if not settingData then
			CodeE( SIGlobal , "无法负责维护未注册或被外部代码影响的设置数据" )
			return {}
		end
		forceSettings = SIUtils.table.deepcopy( settingData.DefaultForce or settingData.Default )
		forceSettings.forceIndex = forceIndex
		if settingData.CreateFunction then
			settingData.CreateFunction( settingName , forceSettings , SIGlobal.SettingTypeDefine.Force )
		end
		settings.Force[forceIndex] = forceSettings
	end
	return forceSettings
end

-- ======================================================================<br>
-- 通过 SIGlobal 获取所有阵营的设置数据<br>
-- 如果某个阵营没有数据 , 则并不会帮助初始化 , 因此返回值中不会有它的设置数据<br>
-- ======================================================================<br>
---@param settingName string -- 设置数据的引用名称
---@return table -- 全部阵营的设置数据子表
function SIGlobal.GetAllForceSettings( settingName )
	local settings = SIGlobal.Get( settingName )
	if not settings then
		CodeE( SIGlobal , "无法负责维护未注册或被外部代码影响的设置数据" )
		return {}
	end
	return settings.Force
end

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 迁移时构造全局数据包 ============================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================<br>
-- 由于在 migration 中 , 定义在 SIGlobal 中的表不会自动初始化<br>
-- 因此需要手动调用这个函数来初始化它们<br>
-- ======================================================================<br>
function SIGlobal.CreateOnMigrations()
	for settingName , settingData in pairs( SIGlobal.SettingDataList ) do
		SIGlobal.InitData( settingData )
	end
end

-- ======================================================================<br>
-- 由于在 migration 中 , 如果需要对已有的设置进行更改 , 则需要使用此函数<br>
-- ======================================================================<br>
---@param migrationData table -- 迁移设置 , 它的结构和设置数据一致 , 每个属性的含义也是一致的 , 不同的是默认数据中属性的值不再是默认值 , 而是要迁移到的位置 , 多层之间写 "." 符号 , 比如 value 想要迁移到 old.value 的位置 , 则写成 value = "old.value"
function SIGlobal.MigrationSettings( migrationData )
end

-- ======================================================================<br>
-- 重置设置数据<br>
-- 把指定的设置数据全部重置为默认值<br>
-- 通常在 migration 中才会使用到<br>
-- ======================================================================<br>
---@param settingName string -- 设置数据的引用名称
function SIGlobal.ResetAllSettings( settingName )
	local settings = SIGlobal.Get( settingName )
	if not settings then
		CodeE( SIGlobal , "无法负责维护未注册或被外部代码影响的设置数据" )
	end
	-- 重置全局设置数据
	settings.Global = nil
	SIGlobal.GetGlobalSettings( settingName )
	-- 重置玩家设置数据
	local playerSettings = settings.Player
	settings.Player = {}
	for playerIndex , setting in pairs( playerSettings ) do
		SIGlobal.GetPlayerSettings( settingName , playerIndex )
	end
	-- 重置阵营设置数据
	local forceSettings = settings.Force
	settings.Force = {}
	for forceIndex , setting in pairs( forceSettings ) do
		SIGlobal.GetForceSettings( settingName , forceIndex )
	end
end

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 内部函数 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

-- ======================================================================<br>
-- 框架内部函数 , 请勿在外部调用<br>
-- 在 on_init 时初始化 global 的数据<br>
-- ======================================================================<br>
function SIGlobal.CreateOnInit()
	for settingName , settingData in pairs( SIGlobal.SettingDataList ) do
		SIGlobal.InitData( settingData )
	end
end

-- ======================================================================<br>
-- 框架内部函数 , 请勿在外部调用<br>
-- 在 on_configuration_changed 时修改 global 的数据<br>
-- ======================================================================<br>
function SIGlobal.ModifyOnChange()
	for settingName , settingData in pairs( SIGlobal.SettingDataList ) do
		SIGlobal.ModifyData( settingData )
	end
end

-- ======================================================================<br>
-- 框架内部函数 , 请勿在外部调用<br>
-- 在数据迁移时重新初始化 global 的数据时使用<br>
-- ======================================================================<br>
function SIGlobal.CreateOnMigration()
	for settingName , settingData in pairs( SIGlobal.SettingDataList ) do
		SIGlobal.InitData( settingData )
	end
end

-- ======================================================================<br>
-- 框架内部函数<br>
-- 请勿在外部调用<br>
-- 初始化 setting 数据<br>
-- ======================================================================<br>
---@param settingData table -- 设置数据
function SIGlobal.InitData( settingData )
	local settings = SIGlobal.Get( settingData.Name )
	if not settings then
		settings =
		{
			Player = {} ,
			Force = {}
		}
		SIGlobal.Set( settingData.Name , settings )
		if settingData.InitFunction then
			settingData.InitFunction( settings )
		end
	end
end

-- ======================================================================<br>
-- 框架内部函数<br>
-- 请勿在外部调用<br>
-- 修改 setting 数据<br>
-- ======================================================================<br>
---@param settingData table -- 设置数据
function SIGlobal.ModifyData( settingData )
	local settings = SIGlobal.Get( settingData.Name )
	if not settings then
		settings =
		{
			Player = {} ,
			Force = {}
		}
		SIGlobal.Set( settingData.Name , settings )
		if settingData.InitFunction then
			settingData.InitFunction( settings )
		end
	end
	if settingData.ModifyFunction then
		settingData.ModifyFunction( settings )
	end
end
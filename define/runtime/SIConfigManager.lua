-- ------------------------------------------------------------------------------------------------
-- ------------ 说明 ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- [配置管理]
-- 主要用于修改 control 阶段下的配置项
-- ----------------------------------------
-- [作用]
-- 读取和修改 control 阶段下的配置项
-- ----------------------------------------

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIConfigManager =
{
	ID = "SIConfigManager" ,
	Name = "配置管理" ,
	InterfaceID = "SIConfigManager"
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 检查引用 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

if not SIInterface then
	UseE( SIConfigManager , "必须启用 SIInterface 之后才能使用 SIConfigManager 模块" )
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 配置管理 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 保存指定 ConstantsData 的配置项的值<br>
-- ----------------------------------------
-- ConstantsDataCodeName = 配置项所属的 ConstantsData<br>
-- key                   = 配置项的键<br>
-- value                 = 配置项的值<br>
-- ----------------------------------------
function SIConfigManager.Set( ConstantsDataCodeName , key , value )
	local configs = SIConfigs[ConstantsDataCodeName]
	if configs then
		configs[key] = value
	end
end

-- ----------------------------------------
-- 获取指定 ConstantsData 的配置项的值<br>
-- ----------------------------------------
-- ConstantsDataCodeName = 配置项所属的 ConstantsData<br>
-- key                   = 配置项的键<br>
-- ----------------------------------------
-- 返回值 = 指定的配置项 , 如果配置项不存在则返回 nil<br>
-- ----------------------------------------
function SIConfigManager.Get( ConstantsDataCodeName , key )
	local configs = SIConfigs[ConstantsDataCodeName]
	return configs and configs[key] or nil
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 外部接口 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIInterface
.Add( SIConfigManager.InterfaceID ,
{
	Set = SIConfigManager.Set ,
	Get = SIConfigManager.Get
} )
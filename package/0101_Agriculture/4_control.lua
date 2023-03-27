-- ------------------------------------------------------------------------------------------------
-- ---------- 定义信息 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 初始化
-- ----------------------------------------
SINeed( "Data/AgricultureData" )

-- ----------------------------------------
-- 事件
-- ----------------------------------------
SIEventBus
.Init( function( functionID )
	-- 注册建造限制
	SIBuildLimit.AddLimitDataList( SIAgricultureData )
end )
.ConfigurationChange( function( functionID )
	-- 注册和更新建造限制
	SIBuildLimit.AddLimitDataList( SIAgricultureData )
	SIBuildLimit.FreshLimitDataList( SIAgricultureData )
end )

-- ------------------------------------------------------------------------------------------------
-- ---------- 操作事件 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 事件
-- ----------------------------------------

-- ------------------------------------------------------------------------------------------------
-- ---------- 外部接口 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 接口注册
-- ----------------------------------------
-- SINeed( "RemoteInterface" )
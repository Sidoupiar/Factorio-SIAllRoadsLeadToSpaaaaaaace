-- ------------------------------------------------------------------------------------------------
-- ---------- 外部接口 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIInterface

-- ----------------------------------------
-- 解锁逻辑<br>
-- ----------------------------------------
.Add( SIBuildLimit.InterfaceID ,
{
	-- 注册
	AddLimitData = SIBuildLimit.AddLimitData ,
	AddLimitDataList = SIBuildLimit.AddLimitDataList ,
	FreshLimitData = SIBuildLimit.FreshLimitData ,
	FreshLimitDataList = SIBuildLimit.FreshLimitDataList
} )
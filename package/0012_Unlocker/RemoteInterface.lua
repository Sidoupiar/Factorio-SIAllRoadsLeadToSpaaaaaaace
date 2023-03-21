-- ------------------------------------------------------------------------------------------------
-- ---------- 外部接口 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIInterface

-- ----------------------------------------
-- 解锁逻辑<br>
-- ----------------------------------------
.Add( SIUnlocker.InterfaceID ,
{
	-- 注册
	AddUnlockData = SIUnlocker.AddUnlockData ,
	AddUnlockDataList = SIUnlocker.AddUnlockDataList ,
	FreshUnlockData = SIUnlocker.FreshUnlockData ,
	FreshUnlockDataList = SIUnlocker.FreshUnlockDataList ,
	-- 控制
	Unlock = SIUnlocker.Unlock
} )
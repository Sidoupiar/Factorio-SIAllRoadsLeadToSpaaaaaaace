-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 外部接口 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIInterface

-- ======================================================================
-- 遗迹管理<br>
-- ======================================================================
.Add( SIRuinSystem.InterfaceID ,
{
	-- 遗迹构建
	CreateRuin = SIRuinSystem.CreateRuin ,
	CreateRuinWithChance = SIRuinSystem.CreateRuinWithChance ,
	RemoveRuin = SIRuinSystem.RemoveRuin ,
	RemoveRuinWithChunk = SIRuinSystem.RemoveRuinWithChunk ,
	RemoveRuinWithSurface = SIRuinSystem.RemoveRuinWithSurface ,
	-- 遗迹控制
	SetSurfaceSettings = SIRuinSystem.SetSurfaceSettings ,
	CopySurfaceSettings = SIRuinSystem.CopySurfaceSettings ,
	AddRuinStyle = SIRuinSystem.AddRuinStyle ,
	AddTurretSet = SIRuinSystem.AddTurretSet ,
	AddItemSet = SIRuinSystem.AddItemSet ,
	AddMachineSet = SIRuinSystem.AddMachineSet ,
	AddMarketSet = SIRuinSystem.AddMarketSet ,
	AddSpecialEntitySet = SIRuinSystem.AddSpecialEntitySet
} )
-- ------------------------------------------------------------------------------------------------
-- ---------- 外部接口 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIInterface

-- ----------------------------------------
-- 遗迹管理<br>
-- ----------------------------------------
.Add( SIRuinControl.InterfaceID ,
{
	-- 遗迹构建
	CreateRuin = SIRuinControl.CreateRuin ,
	CreateRuinWithChance = SIRuinControl.CreateRuinWithChance ,
	RemoveRuin = SIRuinControl.RemoveRuin ,
	RemoveRuinWithChunk = SIRuinControl.RemoveRuinWithChunk ,
	RemoveRuinWithSurface = SIRuinControl.RemoveRuinWithSurface ,
	-- 遗迹控制
	SetSurfaceSettings = SIRuinControl.SetSurfaceSettings ,
	CopySurfaceSettings = SIRuinControl.CopySurfaceSettings ,
	AddRuinStyle = SIRuinControl.AddRuinStyle ,
	AddTurretSet = SIRuinControl.AddTurretSet ,
	AddItemSet = SIRuinControl.AddItemSet ,
	AddMachineSet = SIRuinControl.AddMachineSet ,
	AddMarketSet = SIRuinControl.AddMarketSet ,
	AddSpecialEntitySet = SIRuinControl.AddSpecialEntitySet
} )
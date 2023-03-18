-- ------------------------------------------------------------------------------------------------
-- ---------- 外部接口 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIInterface

-- ----------------------------------------
-- RPG 系统接口<br>
-- ----------------------------------------
.Add( SIRPGSystem.InterfaceID ,
{
	-- 经验数据操作
	MakeAttackExp = SIRPGSystem.MakeAttackExp ,
	MakeAdventureExp = SIRPGSystem.MakeAdventureExp ,
	MakeCraftExp = SIRPGSystem.MakeCraftExp ,
	AddAttackExp = SIRPGSystem.AddAttackExp ,
	SetAttackExp = SIRPGSystem.SetAttackExp ,
	GetAttackExp = SIRPGSystem.GetAttackExp ,
	GetCurrentLevelMaxAttackExp = SIRPGSystem.GetCurrentLevelMaxAttackExp ,
	AddAdventureExp = SIRPGSystem.AddAdventureExp ,
	SetAdventureExp = SIRPGSystem.SetAdventureExp ,
	GetAdventureExp = SIRPGSystem.GetAdventureExp ,
	GetCurrentLevelMaxAdventureExp = SIRPGSystem.GetCurrentLevelMaxAdventureExp ,
	AddCraftExp = SIRPGSystem.AddCraftExp ,
	SetCraftExp = SIRPGSystem.SetCraftExp ,
	GetCraftExp = SIRPGSystem.GetCraftExp ,
	GetCurrentLevelMaxCraftExp = SIRPGSystem.GetCurrentLevelMaxCraftExp ,
	AddAttackLevel = SIRPGSystem.AddAttackLevel ,
	SetAttackLevel = SIRPGSystem.SetAttackLevel ,
	GetAttackLevel = SIRPGSystem.GetAttackLevel ,
	AddAdventureLevel = SIRPGSystem.AddAdventureLevel ,
	SetAdventureLevel = SIRPGSystem.SetAdventureLevel ,
	GetAdventureLevel = SIRPGSystem.GetAdventureLevel ,
	AddCraftLevel = SIRPGSystem.AddCraftLevel ,
	SetCraftLevel = SIRPGSystem.SetCraftLevel ,
	GetCraftLevel = SIRPGSystem.GetCraftLevel ,
	-- 调整点数
	UseAttackPointToProperty = SIRPGSystem.UseAttackPointToProperty ,
	UseAttackPointToAddition = SIRPGSystem.UseAttackPointToAddition ,
	UseAttackPointToSkill = SIRPGSystem.UseAttackPointToSkill ,
	UseAdventurePointToProperty = SIRPGSystem.UseAdventurePointToProperty ,
	UseAdventurePointToAddition = SIRPGSystem.UseAdventurePointToAddition ,
	UseAdventurePointToSkill = SIRPGSystem.UseAdventurePointToSkill ,
	UseCraftPointToProperty = SIRPGSystem.UseCraftPointToProperty ,
	UseCraftPointToAddition = SIRPGSystem.UseCraftPointToAddition ,
	UseCraftPointToSkill = SIRPGSystem.UseCraftPointToSkill ,
	FreshPoints = SIRPGSystem.FreshPoints ,
	ClearPoints = SIRPGSystem.ClearPoints ,
	-- 技能管理
	AddSkill = SIRPGSystem.AddSkill ,
	AddSkills = SIRPGSystem.AddSkills ,
	FreshSkill = SIRPGSystem.FreshSkill ,
	FreshSkills = SIRPGSystem.FreshSkills ,
	HasSkill = SIRPGSystem.HasSkill ,
	GetPlayerSkillData = SIRPGSystem.GetPlayerSkillData ,
	SavePlayerSkillData = SIRPGSystem.SavePlayerSkillData ,
	UnlockSkill = SIRPGSystem.UnlockSkill ,
	RelockSkill = SIRPGSystem.RelockSkill ,
	TakeSkillCost = SIRPGSystem.TakeSkillCost
} )

-- ----------------------------------------
-- RPG 玩家属性接口<br>
-- ----------------------------------------
.Add( SIRPGPlayerStatus.InterfaceID ,
{
	-- 窗口
	OpenFrameByPlayerIndex = SIRPGPlayerStatus.OpenFrameByPlayerIndex ,
	CloseFrameByPlayerIndex = SIRPGPlayerStatus.CloseFrameByPlayerIndex ,
	OpenFrames = SIRPGPlayerStatus.OpenFrames ,
	CloseFrames = SIRPGPlayerStatus.CloseFrames
} )

-- ----------------------------------------
-- RPG 玩家设置接口<br>
-- ----------------------------------------
.Add( SIRPGPlayerSetting.InterfaceID ,
{
	-- 导入导出
	ImpoerSettingsData = SIRPGPlayerSetting.ImpoerSettingsData ,
	ExportSettingsData = SIRPGPlayerSetting.ExportSettingsData
} )

-- ----------------------------------------
-- RPG 技能 , 洞察<br>
-- ----------------------------------------
.Add( SIRPGSkillUI_OverView.InterfaceID ,
{
	-- 触发
	OpenFrame = SIRPGSkillUI_OverView.OpenFrame
} )

-- ----------------------------------------
-- RPG 技能 , 其他<br>
-- ----------------------------------------
.Add( SIRPGSkillUI_Other.InterfaceID ,
{
	-- 触发
	Strong = SIRPGSkillUI_Other.Strong
} )
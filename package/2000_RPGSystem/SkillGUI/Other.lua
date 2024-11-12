-- 虽然名字是面板 , 但是主要保存的是一些没有面板的技能的函数
---@class SIRPGSkillUI_Other : SIBaseClass
SIRPGSkillUI_Other =
{
	ID = "RPGSkillUI_Other" ,
	Code = "RPGSkillUI_Other" ,
	Show = "RPG技能面板-其他" ,
	InterfaceID = "SIRPGSystem-SkillUI_Other" ,
	-- ============================================================================================================================================
	-- ============================================================================================================================================
	-- ========== 强壮 ============================================================================================================================
	-- ============================================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================<br>
	-- 技能入口接口<br>
	-- [ 强壮 ] 技能<br>
	-- ======================================================================<br>
	---@param playerIndex integer -- 玩家索引
	---@param globalSkillData table -- 全局技能数据 , 静态数据
	---@param playerSkillData table -- 玩家技能数据 , 当前技能的玩家相关的数据 , 动态数据
	---@param isQuickUse boolean -- 是否通过快捷键施放技能
	---@param gameTick integer -- 游戏帧
	Strong = function( playerIndex , globalSkillData , playerSkillData , isQuickUse , gameTick )
		local settings = SIGlobal.GetPlayerSettings( SIRPGSystem.Settings.Name , playerIndex )
		local strong = settings.SkillUI.Strong
		-- 暂时没用接口
		local max = settings.Value.Max
		settings.Value.Max.AttackNormal = settings.Value.Max.AttackNormal + ( playerSkillData.Level.Attack.Active - strong.Attack ) * globalSkillData.Attack.Value
		settings.Value.Max.ResistanceNormal = settings.Value.Max.ResistanceNormal + ( playerSkillData.Level.Adventure.Active - strong.Adventure ) * globalSkillData.Adventure.Value / 100.0
		settings.Value.Max.DefenceNormal = settings.Value.Max.DefenceNormal + ( playerSkillData.Level.Craft.Active - strong.Craft ) * globalSkillData.Craft.Value
		if settings.PlayerStatus.frame and settings.PlayerStatus.frame.valid then
			SIRPGPlayerStatus.FreshValueLine( settings , SIRPGSystem.ValueIDs.AttackNormal )
			SIRPGPlayerStatus.FreshValueLine( settings , SIRPGSystem.ValueIDs.ResistanceNormal )
			SIRPGPlayerStatus.FreshValueLine( settings , SIRPGSystem.ValueIDs.DefenceNormal )
		end
		-- 保存数据
		strong.Attack = playerSkillData.Level.Attack.Active
		strong.Adventure = playerSkillData.Level.Adventure.Active
		strong.Craft = playerSkillData.Level.Craft.Active
	end
}
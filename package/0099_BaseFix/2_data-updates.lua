-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 基础定义 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

local function Append( prototypeList )
	for index , prototype in pairs( prototypeList ) do
		SIGen.Find( prototype.type , prototype.name , function( prototypeName , prototypeData )
			if not prototypeData then
				SIGen.Append{ prototype }
			end
		end )
	end
end

-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 类别补充 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

Append
{
	{
		type = SICommon.Types.Categories.Ammo ,
		name = "laser" ,
		bonus_gui_order = "j"
	} ,
	{
		type = SICommon.Types.Categories.Ammo ,
		name = "bullet" ,
		bonus_gui_order = "l"
	} ,
	{
		type = SICommon.Types.Categories.Ammo ,
		name = "flamethrower" ,
		bonus_gui_order = "m"
	} ,
	{
		type = SICommon.Types.Categories.Ammo ,
		name = "artillery-shell" ,
		bonus_gui_order = "o"
	} ,
	{
		type = SICommon.Types.Categories.Ammo ,
		name = "shotgun-shell" ,
		bonus_gui_order = "p"
	} ,
	{
		type = SICommon.Types.Categories.Ammo ,
		name = "cannon-shell" ,
		bonus_gui_order = "q"
	} ,
	{
		type = SICommon.Types.Categories.Ammo ,
		name = "beam" ,
		bonus_gui_order = "r"
	} ,
	{
		type = SICommon.Types.Categories.Ammo ,
		name = "grenade" ,
		bonus_gui_order = "s"
	} ,
	{
		type = SICommon.Types.Categories.Ammo ,
		name = "landmine" ,
		bonus_gui_order = "t"
	} ,
	{
		type = SICommon.Types.Categories.Ammo ,
		name = "rocket" ,
		bonus_gui_order = "u"
	} ,
	{
		type = SICommon.Types.Categories.Ammo ,
		name = "electric" ,
		bonus_gui_order = "v"
	} ,
	{
		type = SICommon.Types.Categories.Ammo ,
		name = "capsule" ,
		bonus_gui_order = "x"
	} ,
	{
		type = SICommon.Types.Categories.Ammo ,
		name = "melee" ,
		bonus_gui_order = "y"
	} ,
	{
		type = SICommon.Types.Categories.Ammo ,
		name = "biological" ,
		bonus_gui_order = "z"
	} ,
	{
		type = SICommon.Types.Categories.Equipment ,
		name = "armor"
	} ,
	{
		type = SICommon.Types.Categories.Fuel ,
		name = "chemical"
	} ,
	{
		type = SICommon.Types.Categories.Fuel ,
		name = "nuclear"
	} ,
	{
		type = SICommon.Types.Categories.Module ,
		name = "productivity"
	} ,
	{
		type = SICommon.Types.Categories.Module ,
		name = "speed"
	} ,
	{
		type = SICommon.Types.Categories.Module ,
		name = "effectivity"
	} ,
	{
		type = SICommon.Types.Categories.Recipe ,
		name = "crafting"
	} ,
	{
		type = SICommon.Types.Categories.Recipe ,
		name = "advanced-crafting"
	} ,
	{
		type = SICommon.Types.Categories.Recipe ,
		name = "smelting"
	} ,
	{
		type = SICommon.Types.Categories.Recipe ,
		name = "chemistry"
	} ,
	{
		type = SICommon.Types.Categories.Recipe ,
		name = "crafting-with-fluid"
	} ,
	{
		type = SICommon.Types.Categories.Recipe ,
		name = "oil-processing"
	} ,
	{
		type = SICommon.Types.Categories.Recipe ,
		name = "rocket-building"
	} ,
	{
		type = SICommon.Types.Categories.Recipe ,
		name = "centrifuging"
	} ,
	{
		type = SICommon.Types.Categories.Recipe ,
		name = "basic-crafting"
	} ,
	{
		type = SICommon.Types.Categories.Resource ,
		name = "basic-solid"
	} ,
	{
		type = SICommon.Types.Categories.Resource ,
		name = "basic-fluid"
	} ,
	{
		type = SICommon.Types.DamageType ,
		name = "physical"
	} ,
	{
		type = SICommon.Types.DamageType ,
		name = "impact"
	} ,
	{
		type = SICommon.Types.DamageType ,
		name = "poison"
	} ,
	{
		type = SICommon.Types.DamageType ,
		name = "explosion"
	} ,
	{
		type = SICommon.Types.DamageType ,
		name = "fire"
	} ,
	{
		type = SICommon.Types.DamageType ,
		name = "laser"
	} ,
	{
		type = SICommon.Types.DamageType ,
		name = "acid"
	} ,
	{
		type = SICommon.Types.DamageType ,
		name = "electric"
	}
}
-- ------------------------------------------------------------------------------------------------
-- ---------- 定义信息 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local recipeList = {}
for index , data in pairs( SIConstants_RuinControl.RuinRecipeData ) do
	recipeList["RuinRecipe_" .. data.ID] = "遗迹配方-" .. data.alias
end

SIControl.Init
{
	[SICommon.Types.Recipe] = recipeList ,
	[SICommon.Types.Tile] =
	{
		RuinFloor = "遗迹地板" ,
	} ,
	[SICommon.Types.Entities.Turret] =
	{
		RuinInserter = "遗迹爪子" ,
		RuinWallPrefix = "遗迹围墙-" ,
		RuinLandMinePrefix = "遗迹地雷-" ,
		RuinGunTurretPrefix = "遗迹机枪炮塔-" ,
		RuinLaserTurretPrefix = "遗迹激光炮塔-" ,
		RuinFlameTurretPrefix = "遗迹喷火炮塔-" ,
		RuinMachinePrefix = "遗迹组装机-" ,
		RuinChestPrefix = "遗迹箱子-"
	}
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 初始化
-- ----------------------------------------
SINeed( "System/RuinControl" )
SIGlobal.CreateSettings( SIRuinControl.Settings )

-- ----------------------------------------
-- 事件
-- ----------------------------------------
SIEventBus
.Init( function( functionID )
	-- 刷新基础数据
	SIRuinControl.FreshRuinData()
end )
.ConfigurationChange( function( functionID )
	-- 刷新基础数据
	SIRuinControl.FreshRuinData()
end )

-- ------------------------------------------------------------------------------------------------
-- ---------- 操作事件 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 事件
-- ----------------------------------------
SIEventBus
.Add( SIEvents.on_chunk_generated , function( event , functionID )
	local surface = event.surface
	local surfaceName = surface.name
	for surfacePrefix , value in pairs( SIConfigs.SIRuinControl.SurfacePrefixWhiteList ) do
		if surfaceName:StartsWith( surfacePrefix ) then
			-- 生成遗迹
			SIRuinControl.CreateRuinWithChance( surface.index , event.position )
			return
		end
	end
end )
.Add( SIEvents.on_chunk_deleted , function( event , functionID )
	local surfaceIndex = event.surface_index
	local surface = game.get_surface( surfaceIndex )
	local surfaceName = surface.name
	for surfacePrefix , value in pairs( SIConfigs.SIRuinControl.SurfacePrefixWhiteList ) do
		if surfaceName:StartsWith( surfacePrefix ) then
			-- 移除遗迹
			for index , position in pairs( event.positions ) do
				SIRuinControl.RemoveRuinWithChunk( surfaceIndex , position )
			end
			return
		end
	end
end )
.Add( SIEvents.on_surface_deleted , function( event , functionID )
	local surfaceIndex = event.surface_index
	local surface = game.get_surface( surfaceIndex )
	local surfaceName = surface.name
	for surfacePrefix , value in pairs( SIConfigs.SIRuinControl.SurfacePrefixWhiteList ) do
		if surfaceName:StartsWith( surfacePrefix ) then
			-- 移除遗迹
			SIRuinControl.RemoveRuinWithSurface( surfaceIndex )
			return
		end
	end
end )

-- ------------------------------------------------------------------------------------------------
-- ---------- 外部接口 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 接口注册
-- ----------------------------------------
SINeed( "RemoteInterface" )
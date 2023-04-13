-- ------------------------------------------------------------------------------------------------
-- ------- 调整持久化数据 -------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- 维护解锁逻辑数据
local UnlockerGlobalSettings = SIGlobal.GetGlobalSettings( SIUnlocker.Settings.Name )
UnlockerGlobalSettings.SavedForceEffects = {}

-- 维护建造限制逻辑数据
local BuildLImitGlobalSettings = SIGlobal.GetGlobalSettings( SIBuildLimit.Settings.Name )
BuildLImitGlobalSettings.Icons = {}

-- 维护自动填充数据
for playerIndex , playerSettings in pairs( SIGlobal.GetAllPlayerSettings( SIAutoInsert.Settings.Name ) ) do
	for index , tabSettings in pairs( playerSettings.TabSettingsList ) do
		-- 最大格子
		tabSettings.MaxSlot =
		{
			Enable = false ,
			List = {} -- 键为选择的容器实体 , 值为限制的数量
		}
		-- 绿箱向蓝箱供货
		tabSettings.GreenToBlue =
		{
			Enable = false ,
			Check = true
		}
		-- 设置插件
		tabSettings.SetModule =
		{
			Enable = false ,
			List = {} -- 键为选择的设备实体 , 值为插件物品名称列表
		}
	end
end
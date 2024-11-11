SIMainData =
{
	ID = "MainData" ,
	Code = "MainData" ,
	Show = "核心数据" ,
	InterfaceID = "SICore-MainData" ,
	-- 内部版本号与迁移脚本列表
	InnerVersion = 8 ,
	MigrationScriptList =
	{
		[1] = "Version1" , -- 0.0.5
		[2] = "Version2" , -- 0.0.6
		[3] = "Version3" , -- 0.0.9
		[4] = "Version4" , -- 0.1.0
		[5] = "Version5" , -- 0.1.2
		[6] = "Version6" , -- 0.1.3
		[7] = "Version7"   -- 0.1.5
	} ,
	-- ============================================================================================================================================
	-- ========== 处理通关 ========================================================================================================================
	-- ============================================================================================================================================
	InitFinish = function()
		-- 取消默认通关条件
		if remote.interfaces.silo_script and remote.interfaces.silo_script.set_no_victory then
			remote.call( "silo_script" , "set_no_victory" , true )
		end
	end ,
	-- ============================================================================================================================================
	-- ========== 接口函数 - 信息 =================================================================================================================
	-- ============================================================================================================================================

	-- ======================================================================<br>
	-- 获取当前核心数据的内部版本号<br>
	-- ======================================================================<br>
	---@return integer -- 当前核心数据的内部版本号 , 数字
	GetInnerVersion = function()
		local globalSettings = SIGlobal.GetGlobalSettings( SIMainData.Settings.Name )
		return globalSettings.InnerVersion
	end
}

SIMainData.Settings =
{
	Name = "MainData" ,
	DefaultGlobal =
	{
		InnerVersion = SIMainData.InnerVersion ,
		SurfaceTime = {}
	} ,
	DefaultPlayer =
	{
		mainbar = nil ,
		mainbarFlow2 = nil , -- 主面板的第二层布局
		Toolbar =
		{
			panel = nil ,
			open = nil ,
			hide = nil ,
			list = nil ,
			flow1 = nil ,
			flow2 = nil
		} ,
		GameSpeed =
		{
			panel = nil ,
			main = nil ,
			up1 = nil ,
			up2 = nil ,
			down1 = nil ,
			down2 = nil ,
			speedLast = nil
		} ,
		GameTime =
		{
			panel = nil ,
			view = nil
		} ,
		KillCount =
		{
			panel = nil ,
			view = nil
		} ,
		Evolution =
		{
			panel = nil ,
			view = nil
		} ,
		NewMessage =
		{
			panel = nil ,
			view = nil
		} ,
		KeyNote =
		{
			panel = nil ,
			view = nil
		} ,
		Setting =
		{
			frame = nil ,
			frameLocation = nil ,
			list = nil ,
			importText = nil ,
			exportText = nil ,
			Saveing = false ,
			Elements =
			{
				itemMainbar = nil ,
				itemToolbar = nil ,
				itemToolbarColumn = nil ,
				itemToolbarColumnText = nil ,
				itemGameSpeed = nil ,
				itemGameTime = nil ,
				itemKillCount = nil ,
				itemEvolution = nil ,
				itemNewMessage = nil ,
				itemKeyNote = nil ,
				itemLoadFromUser = nil ,
				itemShowHiddenEntity = nil ,
				itemCommonToolbar1 = nil ,
				itemCommonToolbar2 = nil ,
			} ,
			Base =
			{
				showToolbar = false ,
				toolbarColumnCount = 10 ,
				showGameSpeed = false ,
				showGameTime = false ,
				showKillCount = false ,
				showEvolution = false ,
				showNewMessage = false ,
				showKeyNote = false ,
				loadFromUserSettings = false ,
				commonToolbar1 = nil ,
				commonToolbar2 = nil ,
				-- 不由设置窗口修改的设置数据
				showGameTimeMode = 1
			} ,
			-- 这些不会被导入导出控制
			Other =
			{
				importPlayerData = true ,
				exportPlayerData = true ,
				exportType = nil
			} ,
			back = nil -- 表 , 打开窗口时保存未经过修改的设置值 , 用于撤销功能 , 关闭窗口后此值变为 nil
		} ,
		Note =
		{
			frame = nil ,
			frameLocation = nil ,
			list = nil ,
			edit = nil ,
			Elements =
			{
				id = nil ,
				title = nil ,
				content = nil ,
				order = nil ,
				isKey = nil
			} ,
			NoteOrder = 0 ,
			NoteList = {} ,
			KeyNoteIndex = nil
		} ,
		Message =
		{
			frame = nil ,
			frameLocation = nil ,
			list = nil ,
			MessageOrder = 0 ,
			MessageList = {}
		}
	}
}
SIUnlocker =
{
	ID = "SIUnlocker" ,
	Name = "解锁逻辑" ,
	InterfaceID = "SIUnlocker" ,
	Settings =
	{
		Name = "SIUnlocker" ,
		DefaultGlobal =
		{
			UnlockData = {}
		} ,
		DefaultForce =
		{
			UnlockData = {} ,
			Mined = {} ,
			MinedResult = {} ,
			Craft = {} ,
			Build = {} ,
			Destroy = {} ,
			Capsule = {}
		}
	} ,
	-- ------------------------------------------------------------------------------------------------
	-- ----------- 初始化 -----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	InitData = function()
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 功能函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	EffectUnlockData = function( unlockData )
		for triggerType , triggerList in pairs( unlockData.Trigger ) do
			for triggerName , trigger in pairs( triggerList ) do
				if not trigger.Finish then
					return
				end
			end
		end
		for resultType , result in pairs( unlockData.Result ) do
			
		end
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ---------- 事件函数 ----------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	FreshMined = function( forceIndex , entityName )
		local forceSettings = SIGlobal.GetForceSettings( SIUnlocker.Settings.Name , forceIndex )
		local minedDataList = forceSettings.Mined[entityName]
		if not minedDataList then
			return
		end
		for index , unlockDataID in pairs( SIUtils.table.deepcopy( minedDataList ) ) do
			local unlockData = forceSettings.UnlockData[unlockDataID]
			local minedData = unlockData.Trigger.Mined[entityName]
			minedData.Count = minedData.Count + 1
			if minedData.Count > minedData.Max then
				minedData.Finish = true
				table.remove( minedDataList , index )
				SIUnlocker.EffectUnlockData( unlockData )
			end
		end
	end ,
	FreshMinedResult = function( forceIndex , itemName , count )
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ------ 接口函数 -- 注册 ------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	AddUnlockData = function()
	end ,
	AddUnlockDataList = function()
	end ,
	FreshUnlockData = function()
	end ,
	FreshUnlockDataList = function()
	end ,
	-- ------------------------------------------------------------------------------------------------
	-- ------ 接口函数 -- 控制 ------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------------------
	Unlock = function( forceIndex , unlockDataID )
		local forceSettings = SIGlobal.GetForceSettings( SIUnlocker.Settings.Name , forceIndex )
	end
}

SIUnlocker.TriggerTypeID =
{
	Mined       = "Mined" ,
	MinedResult = "MinedResult" ,
	Craft       = "Craft" ,
	Build       = "Build" ,
	Destroy     = "Destroy" ,
	Capsule     = "Capsule"
}
SIUnlocker.ResultTypeID =
{
	AddRecipe     = "AddRecipe"     , -- 解锁配方
	RemoveRecipe  = "RemoveRecipe"  , -- 锁定配方
	AddItem       = "AddItem"       , -- 添加物品 , 阵营内如果有多个玩家 , 则只有其中一个玩家会获得
	MessageForce  = "MessageForce"  , -- 向阵营发送消息
	MessagePlayer = "MessagePlayer" , -- 向最终触发的玩家发送消息
	Interface     = "Interface"       -- 执行 remote 接口函数 , 有五个参数 , 第 1 个参数是解锁数据的 ID , 第 2 个参数是保存在其中的数据包 , 第 3 个参数是触发的阵营编号 , 第 4 个参数是最终触发的玩家编号 , 第 5 个参数是当前游戏刻
}
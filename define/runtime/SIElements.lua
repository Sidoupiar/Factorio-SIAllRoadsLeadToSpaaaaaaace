-- ------------------------------------------------------------------------------------------------
-- ------------ 说明 ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- [控件管理]
-- 用于管理各种复合控件
-- ----------------------------------------
-- [作用]
-- 提供一些通用函数来辅助管理复合控件
-- ----------------------------------------

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIElements =
{
	ID = "SIElements" ,
	Name = "控件管理"
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 控件管理 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 根据给定的参数创建窗口 , 并调整其位置<br>
-- 之后把创建的窗口和它的位置保存进持久化数据中<br>
-- 当没有加载 Core 功能包时 , 下列功能均失效 , 只会返回一个基础的窗口<br>
-- ----------------------------------------
-- player          = 要创建的窗口的玩家<br>
-- settingsElement = 玩家持久化数据的对应部分表 , 用于同步窗口的位置信息 , 会占用 [ settingsElement.frame ] 和 [ settingsElement.frameLocation ] 属性<br>
-- frameData       = 窗口数据<br>
-- ----------------------------------------
-- frameData 是一个数据包 , 由键值对组成 :<br>
-- Name            = 窗口的 name 值<br>
-- Mini            = 窗口的右上角的小窗口按钮的 name 值 , 如果不设定 , 则会没有那个按钮<br>
-- Lock            = 窗口的右上角的锁定按钮的 name 值 , 如果不设定 , 则会没有那个按钮<br>
-- Setting         = 窗口的右上角的设置按钮的 name 值 , 如果不设定 , 则会没有那个按钮<br>
-- Close           = 窗口的右上角的关闭按钮的 name 值 , 如果不设定 , 则会没有那个按钮<br>
-- Style           = 窗口的 style 值<br>
-- Title           = 窗口的标题 , 本地化字符串<br>
-- TitleTooltip    = 窗口的标题的提示信息 , 本地化字符串<br>
-- UseTooltip      = 窗口的使用提示信息 , 本地化字符串 , 如果不设定 , 则不会有提示按钮<br>
-- MiniTooltip     = 窗口的小窗口提示信息 , 本地化字符串<br>
-- LockTooltip     = 窗口的锁定提示信息 , 本地化字符串<br>
-- SettingTooltip  = 窗口的设置提示信息 , 本地化字符串<br>
-- CloseTooltip    = 窗口的关闭提示信息 , 本地化字符串<br>
-- isLocked        = 窗口是否正在锁定 , 不同的锁定状态会显示不同的图标<br>
-- OtherButtons    = 窗口的右上角的按钮数据数组 , 位于小窗口按钮和锁定按钮之间<br>
-- ----------------------------------------
-- OtherButtons 是一个数组 , 每个元素的结构如下 :<br>
-- Name            = 按钮的 name 值 , 如果不设定 , 则会没有那个按钮<br>
-- Item            = 按钮显示的物品图标 , 如果不设定 , 则会显示一个空的按钮<br>
-- Tooltip         = 按钮的提示信息 , 本地化字符串<br>
-- ----------------------------------------
-- 返回值 = 创建的窗口<br>
-- 此外<br>
-- 创建的窗口位于 [ settingsElement.frame ] 属性中<br>
-- 创建的窗口的位置位于 [ settingsElement.frameLocation ] 属性中<br>
-- ----------------------------------------
function SIElements.CreateFrame( player , settingsElement , frameData )
	if not SIConstants_Core then
		return player.gui.screen.add{ type = "frame" , name = frameData.Name , direction = "vertical" , style = frameData.Style }
	end
	local locked = frameData.isLocked
	local frame = player.gui.screen.add{ type = "frame" , name = frameData.Name , direction = "vertical" , style = frameData.Style }
	local titleFlow = frame.add{ type = "flow" , direction = "horizontal" , style = SIConstants_Core.raw.Styles.Common_FlowTop }
	titleFlow.add{ type = "label" , caption = frameData.Title , tooltip = frameData.TitleTooltip , style = SIConstants_Core.raw.Styles.Common_FrameTitleLabel }
	local space = titleFlow.add{ type = "empty-widget" , ignored_by_interaction = locked and true or false , style = SIConstants_Core.raw.Styles.Common_DraggableSpace }
	if frameData.UseTooltip then
		titleFlow.add{ type = "sprite-button" , sprite = "item/" .. SIConstants_Core.raw.Items.IconTip , tooltip = frameData.UseTooltip , style = SIConstants_Core.raw.Styles.Common_ButtonTitle }
	end
	if frameData.Mini then
		titleFlow.add{ type = "sprite-button" , name = frameData.Mini , sprite = "item/" .. SIConstants_Core.raw.Items.IconMini , tooltip = frameData.MiniTooltip , style = SIConstants_Core.raw.Styles.Common_ButtonTitle }
	end
	if frameData.OtherButtons then
		for index , buttonData in pairs( frameData.OtherButtons ) do
			if buttonData.Name then
				titleFlow.add{ type = "sprite-button" , name = buttonData.Name , sprite = "item/" .. buttonData.Item , tooltip = buttonData.Tooltip , style = SIConstants_Core.raw.Styles.Common_ButtonTitle }
			end
		end
	end
	if frameData.Lock then
		titleFlow.add{ type = "sprite-button" , name = frameData.Lock , sprite = "item/" .. ( locked and SIConstants_Core.raw.Items.IconLock or SIConstants_Core.raw.Items.IconUnlock ) , tooltip = frameData.LockTooltip , style = SIConstants_Core.raw.Styles.Common_ButtonTitle }
	end
	if frameData.Setting then
		titleFlow.add{ type = "sprite-button" , name = frameData.Setting , sprite = "item/" .. SIConstants_Core.raw.Items.IconSettingWhite , tooltip = frameData.SettingTooltip , style = SIConstants_Core.raw.Styles.Common_ButtonTitle }
	end
	if frameData.Close then
		titleFlow.add{ type = "sprite-button" , name = frameData.Close , sprite = "item/" .. SIConstants_Core.raw.Items.IconClose , tooltip = frameData.CloseTooltip , style = SIConstants_Core.raw.Styles.Common_ButtonTitle }
	end
	space.drag_target = frame
	settingsElement.frame = frame
	if settingsElement.frameLocation then
		frame.location = settingsElement.frameLocation
	else
		frame.auto_center = true
	end
	return frame
end

-- ----------------------------------------
-- 设置窗口的默认位置 , 如果位置不存在则居中显示<br>
-- ----------------------------------------
-- frame           = 窗口<br>
-- ----------------------------------------
-- 返回值 = 用于持久化的窗口实际位置<br>
-- ----------------------------------------
function SIElements.GetFrameLocation( frame )
	local location = frame.location
	if location.x < 0 then
		location.x = 0
	end
	if location.y < 0 then
		location.y = 0
	end
	return location
end

-- ----------------------------------------
-- 调整持久化数据中的窗口的位置 , 并把更新的结果保存进持久化数据中<br>
-- ----------------------------------------
-- settingsElement = 玩家持久化数据的对应部分表 , 用于同步窗口的位置信息 , 会占用 [ settingsElement.frame ] 和 [ settingsElement.frameLocation ] 属性<br>
-- ----------------------------------------
function SIElements.SaveFrameLocation( settingsElement )
	settingsElement.frameLocation = SIElements.GetFrameLocation( settingsElement.frame )
	settingsElement.frame.auto_center = false
end

-- ----------------------------------------
-- 根据给定的单选按钮名称来控制单选按钮列表的选中状态<br>
-- ----------------------------------------
-- currentIndex    = 事件触发的控件名称<br>
-- radioList       = 单选按钮列表<br>
-- ----------------------------------------
function SIElements.SetRadios( currentIndex , radioList )
	for index , radio in pairs( radioList ) do
		if index == currentIndex then
			radio.state = true
		else
			radio.state = false
		end
	end
end

-- ----------------------------------------
-- 从单选按钮列表中检查被选中的项的索引<br>
-- ----------------------------------------
-- radioList       = 单选按钮列表<br>
-- ----------------------------------------
-- 返回值 = 第一个被选中的单选按钮的索引<br>
-- ----------------------------------------
function SIElements.GetRadioValue( radioList )
	for index , radio in pairs( radioList ) do
		if radio.state then
			return index
		end
	end
end

-- ----------------------------------------
-- 获取文本条中的字符并转化为数字<br>
-- 如果文本条中的是无效数字 , 则会被重置为 0<br>
-- 此函数会自动纠正输入的字符<br>
-- ----------------------------------------
-- textfield       = 文本条控件<br>
-- ----------------------------------------
-- 返回值 = 文本条中输入的数字 , 默认 0<br>
-- ----------------------------------------
function SIElements.GetInputNumber( textfield )
	local inputText = textfield.text
	local number = math.floor( tonumber( inputText:gsub( "[^0-9\\.]" , "" ) , 10 ) or 0 )
	textfield.text = tostring( number )
	return number
end
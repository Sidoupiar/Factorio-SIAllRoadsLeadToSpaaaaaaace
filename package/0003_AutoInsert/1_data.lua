-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 创建控件 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIGen
-- ======================================================================<br>
-- 自动填充控件样式
-- ======================================================================<br>
.AddStyle( "AutoInsert_Frame" , "自动填充-窗口" ,
{
	type = "frame_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Frame ,
	-- 体积
	minimal_width = 100 ,
	height = 700
} )
.AddStyle( "AutoInsert_TabPane" , "自动填充-分页面板" ,
{
	type = "tabbed_pane_style" ,
	-- 偏移
	padding = 0 ,
	-- 体积
	minimal_width = 200 ,
	minimal_height = 250 ,
	-- 元素间距
	vertical_spacing = 0 ,
	-- 标签头部
	tab_content_frame =
	{
		type = "frame_style" ,
		-- 偏移
		top_padding = 8 ,
		right_padding = 4 ,
		bottom_padding = 4 ,
		left_padding = 4 ,
		-- 图形
		graphical_set =
		{
			base =
			{
				-- 选项卡面板是一种嵌入式面板 , 因此下方接触面的阴影不应该绘制
				top =
				{
					position = { 76 , 0 } ,
					size = { 1 , 8 }
				} ,
				bottom =
				{
					position = { 76 , 9 } ,
					size = { 1 , 8 }
				} ,
				center =
				{
					position = { 76 , 8 } ,
					size = { 1 , 1 }
				}
			} ,
			shadow = SIStyle.DirtTop.Shadow
		}
	} ,
	-- 标签本体
	tab_container =
	{
		type = "table_style" ,
		-- 偏移
		right_padding = 12 ,
		left_padding = 12 ,
		-- 元素间距
		horizontal_spacing = 0
	}
} )
.AddStyle( "AutoInsert_Label" , "自动填充-标签" ,
{
	type = "label_style" ,
	-- 偏移
	left_padding = 12 ,
	-- 体积
	width = 120 ,
	-- 对齐
	horizontal_align = "left"
} )
.AddStyle( "AutoInsert_Text" , "自动填充-文本条" ,
{
	type = "textbox_style" ,
	-- 体积
	width = 250
} )
.AddStyle( "AutoInsert_EmptyFlow" , "自动填充-空布局" ,
{
	type = "vertical_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowLeft ,
	-- 体积
	width = 300
} )
.AddStyle( "AutoInsert_DropDown" , "自动填充-下拉列表" ,
{
	type = "dropdown_style" ,
	parent = SIConstants_Core.raw.Styles.Common_DropDown ,
	-- 体积
	width = 250 ,
	height = 28
} )
.AddStyle( "AutoInsert_ListButtonFlow" , "自动填充-列表定位按钮布局" ,
{
	type = "horizontal_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowCenterH ,
	-- 偏移
	top_padding = 2 ,
	bottom_padding = 4
} )
.AddStyle( "AutoInsert_ListButton" , "自动填充-列表定位按钮" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonTitle ,
	-- 偏移
	top_padding = -2 ,
	right_padding = -2 ,
	bottom_padding = -2 ,
	left_padding = -2 ,
	-- 体积
	width = 16 ,
	height = 16
} )
.AddStyle( "AutoInsert_BlankFlow" , "自动填充-空白区" ,
{
	type = "vertical_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowLeft ,
	-- 体积
	minimal_height = 200
} )
.AddStyle( "AutoInsert_ListCheck" , "自动填充-列表复选" ,
{
	type = "checkbox_style" ,
	parent = SIConstants_Core.raw.Styles.Common_CheckBox ,
	-- 体积
	width = 758 ,
} )
.AddStyle( "AutoInsert_ListPanelFlow" , "自动填充-列表面板布局" ,
{
	type = "vertical_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowLeft ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 30 ,
	-- 体积
	minimal_width = 758
} )
.AddStyle( "AutoInsert_SubList" , "自动填充-子列表" ,
{
	type = "table_style" ,
	parent = SIConstants_Core.raw.Styles.Common_List ,
	-- 体积
	minimal_width = 10 ,
	minimal_height = 10 ,
	-- 元素间距
	horizontal_spacing = 10 ,
	vertical_spacing = 5
} )
.AddStyle( "AutoInsert_SelectList" , "自动填充-选择列表" ,
{
	type = "table_style" ,
	parent = SIConstants_Core.raw.Styles.Common_List ,
	-- 体积
	minimal_width = 10 ,
	minimal_height = 10 ,
	-- 元素间距
	cell_spacing = 0 ,
	horizontal_spacing = 2 ,
	vertical_spacing = 2
} )
.AddStyle( "AutoInsert_ListChooser" , "自动填充-列表选择" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonTitle ,
	-- 偏移
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	-- 体积
	width = 32 ,
	height = 32
} )
.AddStyle( "AutoInsert_ListFlow" , "自动填充-列表布局" ,
{
	type = "horizontal_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowCenterH ,
	-- 元素间距
	horizontal_spacing = 6
} )
.AddStyle( "AutoInsert_ListLabel" , "自动填充-列表标签" ,
{
	type = "label_style" ,
	-- 体积
	minimal_width = 10 ,
	-- 对齐
	horizontal_align = "left"
} )
.AddStyle( "AutoInsert_ListText" , "自动填充-列表文本条" ,
{
	type = "textbox_style" ,
	-- 体积
	width = 120
} )
.AddStyle( "AutoInsert_ListDropDown" , "自动填充-列表下拉列表" ,
{
	type = "dropdown_style" ,
	parent = SIConstants_Core.raw.Styles.Common_DropDown ,
	-- 体积
	width = 120 ,
	height = 28
} )
.AddStyle( "AutoInsert_ListEmptyFlow" , "自动填充-列表占位布局" ,
{
	type = "horizontal_flow_style" ,
	parent = SIConstants_Core.raw.Styles.Common_FlowCenterH ,
	-- 体积
	minimal_width = 10
} )
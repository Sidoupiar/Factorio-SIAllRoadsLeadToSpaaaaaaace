-- ------------------------------------------------------------------------------------------------
-- ---------- 创建控件 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen
-- ----------------------------------------
-- 多彩调色盘拾色器控件样式
-- ----------------------------------------
.AddStyle( "ColorPanel_Frame" , "多彩调色盘拾色器-窗口" ,
{
	type = "frame_style" ,
	parent = SIConstants_Core.raw.Styles.Common_Frame ,
	-- 体积
	minimal_width = 100 ,
	minimal_height = 100 ,
	maximal_height = 700
} )
.AddStyle( "ColorPanel_LabelTop" , "多彩调色盘拾色器-标签顶部" ,
{
	type = "label_style" ,
	-- 体积
	width = 400 ,
	-- 对齐
	horizontal_align = "left"
} )
.AddStyle( "ColorPanel_List" , "多彩调色盘拾色器-列表" ,
{
	type = "table_style" ,
	-- 元素间距
	cell_spacing = 0 ,
	horizontal_spacing = 0 ,
	vertical_spacing = 0
} )
.AddStyle( "ColorPanel_Pixel" , "多彩调色盘拾色器-色块" ,
{
	type = "button_style" ,
	parent = SIConstants_Core.raw.Styles.Common_ButtonGray ,
	-- 偏移
	top_padding = -4 ,
	right_padding = -4 ,
	bottom_padding = -4 ,
	left_padding = -4 ,
	-- 体积
	width = 15 ,
	height = 15
} )
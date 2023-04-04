-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIStyle =
{
	-- 固定属性
	ID = "SIStyle" ,
	Name = "控件样式" ,
	-- 颜色数据
	DirtColor =
	{
		-- 特殊颜色
		Default = SICommon.Colors.Dirt.DEFAULT ,
		Shadow = SICommon.Colors.Dirt.SHADOW ,
		Glow = SICommon.Colors.Dirt.GLOW ,
		Filler = SICommon.Colors.Dirt.Filler ,
		-- 基础颜色
		Black = SICommon.Colors.Dirt.BLACK ,
		Gray = SICommon.Colors.Dirt.GRAY ,
		Green = SICommon.Colors.Dirt.GREEN ,
		Red = SICommon.Colors.Dirt.RED ,
		Blue = SICommon.Colors.Dirt.BLUE ,
		Purple = SICommon.Colors.Dirt.PURPLE ,
		Orange = SICommon.Colors.Dirt.ORANGE ,
		Yellow = SICommon.Colors.Dirt.YELLOW
	}
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础函数 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIStyle.CreateGlow( tint , scale )
	return
	{
		position = { 200 , 128 } ,
		corner_size = 8 ,
		tint = tint ,
		scale = scale ,
		draw_type = "outer"
	}
end

function SIStyle.CreateGlowTop( tint , scale )
	return
	{
		top =
		{
			position = { 208 , 128 } ,
			size = { 1 , 8 }
		} ,
		center =
		{
			position = { 208 , 136 } ,
			size = { 1 , 1 }
		} ,
		tint = tint ,
		scale = scale ,
		draw_type = "outer"
	}
end

function SIStyle.CreateGlowInner( tint , scale )
	return
	{
		position = { 183 , 128 } ,
		corner_size = 8 ,
		tint = tint ,
		scale = scale ,
		draw_type = "inner"
	}
end

function SIStyle.CreateGlowRadio( tint , scale )
	return
	{
		stretch_monolith_image_to_size = false ,
		center =
		{
			position = { 123 , 156 } ,
			size = { 34 , 34 } ,
			tint = tint ,
			scale = scale
		}
	}
end

function SIStyle.ColorButton( location , dirt )
	return
	{
		type = "button_style" ,
		-- 偏移
		top_padding = 0 ,
		bottom_padding = 0 ,
		left_padding = 8 ,
		right_padding = 8 ,
		clicked_vertical_offset = 1 ,
		-- 体积
		width = 100 ,
		height = 28 ,
		-- 对齐
		horizontal_align = "center" ,
		vertical_align = "center" ,
		icon_horizontal_align = "center" ,
		-- 字体
		font = "default-semibold" ,
		default_font_color = SICommon.Colors.Font.BLACK ,
		hovered_font_color = SICommon.Colors.Font.BLACK ,
		clicked_font_color = SICommon.Colors.Font.BLACK ,
		disabled_font_color = { 0.7 , 0.7 , 0.7 } ,
		selected_font_color = SICommon.Colors.Font.BLACK ,
		selected_hovered_font_color = SICommon.Colors.Font.BLACK ,
		selected_clicked_font_color = SICommon.Colors.Font.BLACK ,
		strikethrough_color = { 0.5 , 0.5 , 0.5 } ,
		pie_progress_color = { 1 , 1 , 1 } ,
		-- 图像
		default_graphical_set =
		{
			base =
			{
				position = { location , 17 } ,
				corner_size = 8
			} ,
			shadow = SIStyle.Dirt.Default
		} ,
		hovered_graphical_set =
		{
			base =
			{
				position = { location + 34 , 17 } ,
				corner_size = 8
			} ,
			shadow = SIStyle.Dirt.Default ,
			glow = dirt
		} ,
		clicked_graphical_set =
		{
			base =
			{
				position = { location + 51 , 17 } ,
				corner_size = 8
			} ,
			shadow = SIStyle.Dirt.Default
		} ,
		disabled_graphical_set =
		{
			base =
			{
				position = { location + 17 , 17 } ,
				corner_size = 8
			} ,
			shadow = SIStyle.Dirt.Default
		} ,
		selected_graphical_set =
		{
			base =
			{
				position = { 225 , 17 } ,
				corner_size = 8
			} ,
			shadow = SIStyle.Dirt.Default
		} ,
		selected_hovered_graphical_set =
		{
			base =
			{
				position = { 369 , 17 } ,
				corner_size = 8
			} ,
			shadow = SIStyle.Dirt.Default
		} ,
		selected_clicked_graphical_set =
		{
			base =
			{
				position = { 352 , 17 } ,
				corner_size = 8
			} ,
			shadow = SIStyle.Dirt.Default
		} ,
		-- 声音
		left_click_sound =
		{
			SISound.Core( "gui-click" , 1 )
		}
	}
end

function SIStyle.RadioGraphics( x , y )
	return
	{
		default_graphical_set =
		{
			base =
			{
				position = { x , y } ,
				size = { 24 , 24 }
			} ,
			shadow = SIStyle.DirtRadio.Default
		} ,
		hovered_graphical_set =
		{
			base =
			{
				position = { x + 24 , y } ,
				size = { 24 , 24 }
			} ,
			shadow = SIStyle.DirtRadio.Glow
		} ,
		clicked_graphical_set =
		{
			base =
			{
				position = { x + 48 , y } ,
				size = { 24 , 24 }
			} ,
			shadow = SIStyle.DirtRadio.Default
		} ,
		disabled_graphical_set =
		{
			base =
			{
				position = { x + 96 , y } ,
				size = { 24 , 24 }
			} ,
			shadow = SIStyle.DirtRadio.Default
		} ,
		selected_graphical_set =
		{
			base =
			{
				position = { x + 72 , y } ,
				size = { 24 , 24 }
			} ,
			shadow = SIStyle.DirtRadio.Default
		} ,
		selected_hovered_graphical_set =
		{
			base =
			{
				position = { x + 24 , y } ,
				size = { 24 , 24 }
			} ,
			shadow = SIStyle.DirtRadio.Glow
		} ,
		selected_clicked_graphical_set =
		{
			base =
			{
				position = { x + 48 , y } ,
				size = { 24 , 24 }
			} ,
			shadow = SIStyle.DirtRadio.Default
		}
	}
end

function SIStyle.CheckBoxGraphics( x , y )
	return
	{
		default_graphical_set =
		{
			base =
			{
				position = { x , y } ,
				size = { 28 , 28 }
			} ,
			shadow = SIStyle.Dirt.Default
		} ,
		hovered_graphical_set =
		{
			base =
			{
				position = { x + 56 , y } ,
				size = { 28 , 28 }
			} ,
			glow = SIStyle.Dirt.Glow
		} ,
		clicked_graphical_set =
		{
			base =
			{
				position = { x + 84 , y } ,
				size = { 28 , 28 }
			} ,
			glow = SIStyle.Dirt.Glow
		} ,
		disabled_graphical_set =
		{
			base =
			{
				position = { x + 28 , y } ,
				size = { 28 , 28 }
			} ,
			shadow = SIStyle.Dirt.Default
		} ,
		selected_graphical_set =
		{
			base =
			{
				position = { x + 56 , y } ,
				size = { 28 , 28 }
			} ,
			shadow = SIStyle.Dirt.Default
		} ,
		selected_hovered_graphical_set =
		{
			base =
			{
				position = { x + 56 , y } ,
				size = { 28 , 28 }
			} ,
			glow = SIStyle.Dirt.Glow
		} ,
		selected_clicked_graphical_set =
		{
			base =
			{
				position = { x + 84 , y } ,
				size = { 28 , 28 }
			} ,
			glow = SIStyle.Dirt.Glow
		}
	}
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 构建数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIStyle.Dirt =
{
	-- 特殊颜色
	Default = SIStyle.CreateGlow( SIStyle.DirtColor.Default , 0.5 ) ,
	Shadow = SIStyle.CreateGlow( SIStyle.DirtColor.Shadow , 0.5 ) ,
	Glow = SIStyle.CreateGlow( SIStyle.DirtColor.Glow , 0.5 ) ,
	Filler = SIStyle.CreateGlow( SIStyle.DirtColor.Filler , 0.5 ) ,
	-- 基础颜色
	Gray = SIStyle.CreateGlow( SIStyle.DirtColor.Gray , 0.5 ) ,
	Green = SIStyle.CreateGlow( SIStyle.DirtColor.Green , 0.5 ) ,
	Red = SIStyle.CreateGlow( SIStyle.DirtColor.Red , 0.5 ) ,
	Blue = SIStyle.CreateGlow( SIStyle.DirtColor.Blue , 0.5 ) ,
	Purple = SIStyle.CreateGlow( SIStyle.DirtColor.Purple , 0.5 ) ,
	Orange = SIStyle.CreateGlow( SIStyle.DirtColor.Orange , 0.5 ) ,
	Yellow = SIStyle.CreateGlow( SIStyle.DirtColor.Yellow , 0.5 )
}
SIStyle.DirtRadio =
{
	Default = SIStyle.CreateGlowRadio( SIStyle.DirtColor.Default , 0.5 ) ,
	Glow = SIStyle.CreateGlowRadio( SIStyle.DirtColor.Glow , 0.5 )
}
SIStyle.DirtTop =
{
	Shadow = SIStyle.CreateGlowTop( SIStyle.DirtColor.Shadow , 0.5 )
}
SIStyle.DirtInner =
{
	Shadow = SIStyle.CreateGlowInner( SIStyle.DirtColor.Black , 0.5 )
}
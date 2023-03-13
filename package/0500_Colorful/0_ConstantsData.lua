local constantsData =
{
	ID = "Colorful" ,
	Name = "多彩" ,
	FileList =
	{
		[SIInit.StateCodeDefine.Data]    = { "1_data"    } ,
		[SIInit.StateCodeDefine.Control] = { "4_control" }
	} ,
	Autoload =
	{
		Enable = true ,
		Groups =
		{
			Colorful =
			{
				Name = "多彩工艺" ,
				Subgroups =
				{
					Pixel = "像素块" ,
					Tool = "多彩工具"
				}
			}
		}
	} ,
	-- 其他参数
	ColorMax = 256 ,
	ColorStep = 32 ,
	ColorStepBig = 96
}

return constantsData
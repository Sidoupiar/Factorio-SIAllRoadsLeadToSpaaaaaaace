local constantsData =
{
	ID = "Resource" ,
	Name = "自然矿产" ,
	FileList =
	{
		[SIInit.StateCodeDefine.Data] = { "1_data" }
	} ,
	Autoload =
	{
		Enable = true ,
		Groups =
		{
			Resource =
			{
				Name = "自然矿产" ,
				Subgroups =
				{
					Shelling = "开壳"
				}
			}
		}
	}
}

return constantsData
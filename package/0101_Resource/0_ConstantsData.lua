local constantsData =
{
	ID = "Resource" ,
	Name = "自然矿产" ,
	FileList =
	{
		[SIInit.StateCodeDefine.Data]           = { "1_data_rock" , "1_data_ore" , "1_data_crystal" , "1_data-dirt" } ,
		[SIInit.StateCodeDefine.DataFinalFixes] = { "3_data-final-fixes" } ,
		[SIInit.StateCodeDefine.Control]        = { "4_control" }
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
					Rock = "矿山石" ,
					Ore = "矿石" ,
					Crystal = "魔力结晶" ,
					Dirt = "泥土"
				}
			}
		}
	}
}

return constantsData
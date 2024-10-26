local constantsData =
{
	ID = "Planting" ,
	Name = "种植农业" ,
	FileList =
	{
		[SIInit.StateCodeDefine.Data]           = { "1_data" } ,
		[SIInit.StateCodeDefine.DataFinalFixes] = { "3_data-final-fixes" } ,
		[SIInit.StateCodeDefine.Control]        = { "4_control" }
	} ,
	Autoload =
	{
		Enable = true ,
		Groups =
		{
			Planting =
			{
				Name = "种植农业" ,
				SubOrder = "2" ,
				Subgroups =
				{
					Cultivate = "培育" ,
					Improve = "改良" ,
					Craft = "加工" ,
					Poop = "肥料"
				}
			}
		}
	}
}

return constantsData
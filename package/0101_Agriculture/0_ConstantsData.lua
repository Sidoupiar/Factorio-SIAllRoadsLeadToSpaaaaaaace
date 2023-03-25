local constantsData =
{
	ID = "Agriculture" ,
	Name = "农业种植" ,
	FileList =
	{
		[SIInit.StateCodeDefine.Data]           = { "1_data_farm" , "1_data_fruit" } ,
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
				Name = "农业种植" ,
				Subgroups =
				{
					Farm = "农场" ,
					Fruit = "水果"
				}
			}
		}
	}
}

return constantsData
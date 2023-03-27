local constantsData =
{
	ID = "Plant" ,
	Name = "野生植物" ,
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
			Plant =
			{
				Name = "野生植物" ,
				Subgroups =
				{
					Base = "基础植物" ,
					Food = "粮食植物" ,
					Vegetable = "蔬菜植物" ,
					Fruit = "水果植物" ,
					Special = "特殊植物"
				}
			}
		}
	}
}

return constantsData
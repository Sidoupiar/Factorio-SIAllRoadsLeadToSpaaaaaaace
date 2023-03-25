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
			Agriculture =
			{
				Name = "农业种植" ,
				Subgroups =
				{
					Farm = "农场" ,
					Irrigation = "灌溉" ,
					Manure = "施肥" ,
					Manager = "管理" ,
					Base = "基础作物" ,
					Food = "粮食作物" ,
					Vegetable = "蔬菜作物" ,
					Fruit = "水果作物" ,
					Special = "特殊作物"
				}
			}
		}
	}
}

return constantsData
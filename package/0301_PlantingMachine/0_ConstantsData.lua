local constantsData =
{
	ID = "PlantingMachine" ,
	Name = "种植设备" ,
	FileList =
	{
		[SIInit.StateCodeDefine.Data]           = { "1_data" } ,
		[SIInit.StateCodeDefine.DataFinalFixes] = { "3_data-final-fixes" } ,
		[SIInit.StateCodeDefine.Control]        = { "4_control" }
	} ,
	Autoload =
	{
		Enable = true ,
		GroupsAppend =
		{
			Planting =
			{
				ConstantsDataCodeName = nil ,
				SubOrder = "1" ,
				Subgroups =
				{
					Farm = "农场" ,
					Irrigation = "灌溉" ,
					Manure = "施肥" ,
					Manager = "管理"
				}
			}
		}
	} ,
	BeforeLoad = function( constantsData )
		constantsData.Autoload.GroupsAppend.Planting.ConstantsDataCodeName = SIConstants_Planting.CodeName
	end
}

return constantsData
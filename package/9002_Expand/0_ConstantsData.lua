local constantsData =
{
	ID = "Expand" ,
	Name = "原版内容扩展" ,
	FileList =
	{
		[SIInit.StateCodeDefine.Data]           = { "1_data"             } ,
		[SIInit.StateCodeDefine.DataFinalFixes] = { "3_data-final-fixes" } ,
		[SIInit.StateCodeDefine.Control]        = { "4_control"          }
	} ,
	Autoload =
	{
		Enable = true ,
		GroupsAppend =
		{
			Expand =
			{
				ConstantsDataCodeName = nil ,
				Subgroups =
				{
					MakeBarrel = "灌装" ,
					InfiniteTech = "无尽科技"
				}
			}
		} ,
		Categories =
		{
			Recipe =
			{
				MakeBarrel = "灌装" ,
				DropBarrel = "倾倒"
			}
		}
	} ,
	BeforeLoad = function( constantsData )
		constantsData.Autoload.GroupsAppend.Expand.ConstantsDataCodeName = SIConstants_Core.CodeName
	end
}

return constantsData
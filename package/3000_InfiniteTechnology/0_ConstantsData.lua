local constantsData =
{
	ID = "InfiniteTechnology" ,
	Code = "InfiniteTechnology" ,
	Show = "无尽科技" ,
	FileList =
	{
		[SIInit.StateCodeDefine.Data]           = { "1_data" } ,
		[SIInit.StateCodeDefine.DataFinalFixes] = { "3_data-final-fixes" }
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
					InfiniteTechnology = "无尽科技"
				}
			}
		}
	} ,
	BeforeLoad = function( constantsData )
		constantsData.Autoload.GroupsAppend.Expand.ConstantsDataCodeName = SIConstants_Core.CodeName
	end
}

return constantsData
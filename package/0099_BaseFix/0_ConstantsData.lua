local constantsData =
{
	ID = "BaseFix" ,
	Name = "原版兼容修复" ,
	FileList =
	{
		[SIInit.StateCodeDefine.Data]           = { "1_data" } ,
		[SIInit.StateCodeDefine.DataFinalFixes] = { "3_data-final-fixes" } ,
		[SIInit.StateCodeDefine.Control]        = { "4_control" }
	}
}

return constantsData
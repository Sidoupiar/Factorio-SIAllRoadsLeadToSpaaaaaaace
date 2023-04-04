local constantsData =
{
	ID = "BaseFix" ,
	Name = "原版兼容修复" ,
	FileList =
	{
		[SIInit.StateCodeDefine.DataUpdates] = { "2_data-updates" } ,
	} ,
	AfterLoad = function( constantsData )
		if SIModData.Loaded.base then
			constantsData.FileList = nil
		end
	end ,
}

return constantsData
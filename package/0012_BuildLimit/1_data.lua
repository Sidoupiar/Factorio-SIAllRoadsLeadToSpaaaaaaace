-- ============================================================================================================================================
-- ============================================================================================================================================
-- ========== 定义图标 ========================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================

SIGen
.SetGroup( SIConstants_Core.raw.Groups.Hidden.Alert )
.New( SICommon.Types.Sprite , "AlertBeacon" , "提示插件塔过载" )
.Append
{
	layers =
	{
		{
			filename = SIGen.MakeSelfPicturePath( "AlertBeacon" , "提示插件塔过载" ) ,
			priority = "extra-high-no-scale" ,
			flags = { "gui-icon" } ,
			width = 64 ,
			height = 64 ,
			mipmap_count = 1 ,
			scale = 1.0
		}
	}
}
.New( SICommon.Types.Sprite , "AlertModule" , "提示插件过载" )
.Append
{
	layers =
	{
		{
			filename = SIGen.MakeSelfPicturePath( "AlertModule" , "提示插件过载" ) ,
			priority = "extra-high-no-scale" ,
			flags = { "gui-icon" } ,
			width = 64 ,
			height = 64 ,
			mipmap_count = 1 ,
			scale = 1.0
		}
	}
}
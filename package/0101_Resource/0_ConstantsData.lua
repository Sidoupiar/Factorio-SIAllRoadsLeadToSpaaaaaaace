local constantsData =
{
	ID = "Resource" ,
	Name = "自然矿产" ,
	FileList =
	{
		[SIInit.StateCodeDefine.Data]           = { "1_data_rock" , "1_data_ore" , "1_data_crystal" , "1_data-dirt" } ,
		[SIInit.StateCodeDefine.DataFinalFixes] = { "3_data-final-fixes" } ,
		[SIInit.StateCodeDefine.Control]        = { "4_control" }
	} ,
	Path =
	{
		Picture = "__SIAllRoadsLeadToSpaaaaaaaceGraphics1__/package/0101_Resource/graphic" ,
		Sound = "__SIAllRoadsLeadToSpaaaaaaaceGraphics1__/package/0101_Resource/sound"
	} ,
	Autoload =
	{
		Enable = true ,
		Groups =
		{
			Resource =
			{
				Name = "自然矿产" ,
				Subgroups =
				{
					Rock = "矿山石" ,
					PieceRock = "碎裂的矿山石" ,
					StoneRock = "矿山磐石" ,
					Ore = "矿石" ,
					Crystal = "魔力结晶" ,
					Dirt = "泥土"
				}
			}
		} ,
		Categories =
		{
			Recipe =
			{
				Dirt = "掘土"
			}
		}
	} ,
	BeforeLoad = function( constantsData )
		if not SIModData.Loaded.SIAllRoadsLeadToSpaaaaaaaceGraphics1 then
			constantsData.FileList = nil
			constantsData.Autoload = nil
		end
	end
}

return constantsData
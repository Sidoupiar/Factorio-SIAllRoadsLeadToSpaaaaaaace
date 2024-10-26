local constantsData =
{
	ID = "RPGSystem" ,
	Code = "RPGSystem" ,
	Show = "RPG系统" ,
	FileList =
	{
		[SIInit.StateCodeDefine.Data]    = { "1_data"    } ,
		[SIInit.StateCodeDefine.Control] = { "4_control" }
	} ,
	Autoload =
	{
		Enable = true ,
		GroupsAppend =
		{
			Hidden =
			{
				ConstantsDataCodeName = "SICore" ,
				Subgroups =
				{
					EXP = "经验"
				}
			}
		}
	} ,
	ExpTrigger =
	{
		Attack_1 = "SIRPGSystem-EXP-Attack-1" ,
		Attack_100 = "SIRPGSystem-EXP-Attack-100" ,
		Attack_1W = "SIRPGSystem-EXP-Attack-1W" ,
		Attack_100W = "SIRPGSystem-EXP-Attack-100W" ,
		Attack_1E = "SIRPGSystem-EXP-Attack-1E" ,
		Attack_100E = "SIRPGSystem-EXP-Attack-100E" ,
		Attack_1WE = "SIRPGSystem-EXP-Attack-1WE" ,
		Adventure_1 = "SIRPGSystem-EXP-Adventure-1" ,
		Adventure_100 = "SIRPGSystem-EXP-Adventure-100" ,
		Adventure_1W = "SIRPGSystem-EXP-Adventure-1W" ,
		Adventure_100W = "SIRPGSystem-EXP-Adventure-100W" ,
		Adventure_1E = "SIRPGSystem-EXP-Adventure-1E" ,
		Adventure_100E = "SIRPGSystem-EXP-Adventure-100E" ,
		Adventure_1WE = "SIRPGSystem-EXP-Adventure-1WE" ,
		Craft_1 = "SIRPGSystem-EXP-Craft-1" ,
		Craft_100 = "SIRPGSystem-EXP-Craft-100" ,
		Craft_1W = "SIRPGSystem-EXP-Craft-1W" ,
		Craft_100W = "SIRPGSystem-EXP-Craft-100W" ,
		Craft_1E = "SIRPGSystem-EXP-Craft-1E" ,
		Craft_100E = "SIRPGSystem-EXP-Craft-100E" ,
		Craft_1WE = "SIRPGSystem-EXP-Craft-1WE"
	}
}

return constantsData
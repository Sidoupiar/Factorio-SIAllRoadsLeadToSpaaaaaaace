local constantsData =
{
	ID = "RuinSystem" ,
	Code = "RuinSystem" ,
	Show = "遗迹系统" ,
	FileList =
	{
		[SIInit.StateCodeDefine.Data]    = { "1_data_building" , "2_data_recipe" } ,
		[SIInit.StateCodeDefine.Control] = { "4_control" }
	} ,
	Autoload =
	{
		Enable = true ,
		GroupsAppend =
		{
			Hidden =
			{
				ConstantsDataCodeName = nil ,
				Subgroups =
				{
					RuinBuildings = "遗迹建筑" ,
					RuinRecipes = "遗迹配方"
				}
			}
		} ,
		Categories =
		{
			Ammo =
			{
				RuinTurret = "遗迹炮塔"
			} ,
			Recipe =
			{
				RuinMachine = "遗迹装置"
			}
		}
	} ,
	BeforeLoad = function( constantsData )
		constantsData.Autoload.GroupsAppend.Hidden.ConstantsDataCodeName = SIConstants_Core.CodeName
	end ,
	LevelValueList = {} ,
	RuinRecipeData =
	{
		{ ID = "Wood"    , Alias = "木头" , Result = "wood"        , Time = 1.0 } ,
		{ ID = "Icon"    , Alias = "铁矿" , Result = "iron-ore"    , Time = 1.0 } ,
		{ ID = "Copper"  , Alias = "铜矿" , Result = "copper-ore"  , Time = 1.0 } ,
		{ ID = "Uranium" , Alias = "铀矿" , Result = "uranium-ore" , Time = 1.0 } ,
		{ ID = "Stone"   , Alias = "石矿" , Result = "stone"       , Time = 1.0 } ,
		{ ID = "Coal"    , Alias = "煤矿" , Result = "coal"        , Time = 1.0 } ,
		{ ID = "Fish"    , Alias = "鲜鱼" , Result = "raw-fish"    , Time = 1.0 }
	}
}

for level = 1 , 15 , 1 do
	local levelCount = ( level - 1 ) * level / 2
	table.insert( constantsData.LevelValueList ,
	{
		Strength = 2 ^ ( level - 1 ) * 10 ,
		Health   = 1.24 * levelCount + 1.00 ,
		Decrease = 1.20 * level ,
		Defence  = math.floor( ( 1 - 1 / ( 0.084 * levelCount + 1.00 ) ) * 10000.0 ) / 100.0 ,
		Damage   = 0.68 * levelCount + 1.00 ,
		Speed    = 0.09 * levelCount + 1.00 ,
		Range    = 0.04 * levelCount + 1.00
	} )
end

return constantsData
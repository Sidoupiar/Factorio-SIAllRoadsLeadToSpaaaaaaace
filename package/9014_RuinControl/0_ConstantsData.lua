local constantsData =
{
	ID = "RuinControl" ,
	Name = "遗迹管理" ,
	FileList =
	{
		[SIInit.StateCodeDefine.Data]    = { "1_data_building" , "1_data_recipe" } ,
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
		{ ID = "Wood"    , alias = "木头" , result = "wood"        } ,
		{ ID = "Icon"    , alias = "铁矿" , result = "iron-ore"    } ,
		{ ID = "Copper"  , alias = "铜矿" , result = "copper-ore"  } ,
		{ ID = "Uranium" , alias = "铀矿" , result = "uranium-ore" } ,
		{ ID = "Stone"   , alias = "石矿" , result = "stone"       } ,
		{ ID = "Coal"    , alias = "煤矿" , result = "coal"        } ,
		{ ID = "Fish"    , alias = "鲜鱼" , result = "raw-fish"    }
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
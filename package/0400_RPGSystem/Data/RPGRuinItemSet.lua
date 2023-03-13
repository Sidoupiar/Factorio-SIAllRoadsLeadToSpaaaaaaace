SIRPGRuinItemSet =
{
	ID = "RPG物资包" ,
	Weight = 6500 ,
	List = {}
}

local itemPackDataList =
{
	-- 等级 1
	{ { SIConstants_RPGSystem.raw.Items.EXP_Attack_1 , 0 , 33 } , { SIConstants_RPGSystem.raw.Items.EXP_Adventure_1 , 0 , 64 } , { SIConstants_RPGSystem.raw.Items.EXP_Adventure_100 , 0 , 2 } , { SIConstants_RPGSystem.raw.Items.EXP_Craft_1 , 0 , 33 } } ,
	{ { SIConstants_RPGSystem.raw.Items.EXP_Attack_1 , 0 , 50 } , { SIConstants_RPGSystem.raw.Items.EXP_Attack_100 , 0 , 1 } , { SIConstants_RPGSystem.raw.Items.EXP_Adventure_1 , 0 , 80 } , { SIConstants_RPGSystem.raw.Items.EXP_Adventure_100 , 0 , 1 } } ,
	{ { SIConstants_RPGSystem.raw.Items.EXP_Adventure_1 , 0 , 10 } , { SIConstants_RPGSystem.raw.Items.EXP_Adventure_100 , 0 , 2 } , { SIConstants_RPGSystem.raw.Items.EXP_Craft_1 , 0 , 20 } , { SIConstants_RPGSystem.raw.Items.EXP_Craft_100 , 0 , 1 } }
}

for level = 1 , 15 , 1 do
	local itemList = {}
	for itemPackIndex = 1 , math.min( level * 3 , #itemPackDataList ) , 1 do
		local itemPack =
		{
			Chest = SIConstants_RPGSystem.raw.Entities.EXPChest ,
			Items = {}
		}
		for itemDataIndex , itemDataData in pairs( itemPackDataList[itemPackIndex] ) do
			local itemData =
			{
				Item = itemDataData[1] ,
				Min = itemDataData[2] * level ,
				Max = itemDataData[3] * level
			}
			table.insert( itemPack.Items , itemData )
		end
		table.insert( itemList , itemPack )
	end
	table.insert( SIRPGRuinItemSet.List , itemList )
end
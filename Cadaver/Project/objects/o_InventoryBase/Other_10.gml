items_list = 0;

enum item_types
{
	melee,
	ranged,
	tool,
	building,
	resource
}

function create_struct()
{
	var return_struct =
	{
		description : "An item.",
		burn_time : 0,
		item_type : item_types.resource,
		building_obj : o_Campfire
	}

	return return_struct
}

enum item
{
		
}

//Empty
items_list[0] = 
{
	name : "",
	stack : 0,
	spr_index : 0,
	item_data : create_struct()
}
{
	items_list[0].item_data.item_type = item_types.melee
}

items_list[1] =
{
	name : "Stone",
	stack : 10,
	spr_index : 1,
	item_data : create_struct()
}
{
	items_list[1].item_data.item_type = item_types.ranged
	items_list[1].item_data.description = "Heavy.. A very useful resource that is used in many different recipes. Pretty solid huh?"
}

items_list[2] =
{
	name : "Wood",
	stack: 10,
	spr_index : 2,
	item_data : create_struct()
}
{
	items_list[2].item_data.burn_time = 300
}

items_list[3] =
{
	name : "Plastic",
	stack : 10,
	spr_index : 3
}

items_list[4] =
{
	name : "Metal",
	stack : 10,
	spr_index : 4
}

items_list[5] =
{
	name : "Sword",
	stack : 1,
	spr_index : 5,
	item_data : create_struct()
}
{
	items_list[5].item_data.item_type = item_types.melee
	items_list[5].item_data.description = "A versatile weapon for taking down the infected and chopping unwanted foliage."
}

items_list[6] =
{
	name : "Syringe",
	stack : 3,
	spr_index : 6
}

items_list[7] =
{
	name : "Bottle",
	stack : 10,
	spr_index : 7
}

items_list[8] =
{
	name : "Meat",
	stack : 10,
	spr_index : 8
}

items_list[9] =
{
	name : "Cooked Meat",
	stack : 10,
	spr_index : 9
}

items_list[10] =
{
	name : "Salt",
	stack : 10,
	spr_index : 10
}

items_list[11] =
{
	name : "Potato",
	stack : 10,
	spr_index : 10
}

items_list[11] =
{
	name : "Potato",
	stack : 10,
	spr_index : 11
}

items_list[12] =
{
	name : "Uranium",
	stack : 10,
	spr_index : 12
}

items_list[13] =
{
	name : "Bread",
	stack : 10,
	spr_index : 13
}

items_list[14] =
{
	name : "Cheese",
	stack : 10,
	spr_index : 14
}

items_list[15] =
{
	name : "Shell",
	stack : 10,
	spr_index : 15
}

items_list[16] =
{
	name : "Electronics",
	stack : 10,
	spr_index : 16,
	item_data : create_struct()
}
{
	items_list[16].item_data.description = "Simple electronics ready to be used in whatever project you need them for."	
}

items_list[17] =
{
	name : "Plants",
	stack : 10,
	spr_index : 17
}

items_list[18] =
{
	name : "Medical Solution",
	stack : 10,
	spr_index : 18,
	item_data : create_struct()
}
{
	items_list[18].item_data.description = "An effective healing balm made from some plants. Used in crafting basic medicines."
}

items_list[19] =
{
	name : "Medical Kit",
	stack : 10,
	spr_index : 19
}

items_list[20] =
{
	name : "Cloth",
	stack : 10,
	spr_index : 20
}

items_list[21] =
{
	name : "Bandage",
	stack : 10,
	spr_index : 21
}

items_list[22] =
{
	name : "Ice",
	stack : 10,
	spr_index : 22
}

items_list[23] =
{
	name : "Bear Trap",
	stack : 1,
	spr_index : 23,
	item_data : create_struct()
}
{
	items_list[23].item_data.item_type = item_types.building
}

items_list[24] =
{
	name : "Mechanical Parts",
	stack : 10,
	spr_index : 24
}

items_list[25] =
{
	name : "Campfire",
	stack : 1,
	spr_index : 25,
	item_data : create_struct()
}
{
	items_list[25].item_data.item_type = item_types.building
}

items_list[26] =
{
	name : "Pickaxe",
	stack : 1,
	spr_index : 26
}

items_list[27] =
{
	name : "Axe",
	stack : 1,
	spr_index : 27
}	

items_list[28] =
{
	name : "Fries",
	stack : 10,
	spr_index : 28
}

items_list[29] =
{
	name : "Hamburger Meal",
	stack : 10,
	spr_index : 29
}

items_list[30] =
{
	name : "Chemicals",
	stack : 10,
	spr_index : 30
}

items_list[31] =
{
	name : "Rare Plants",
	stack : 10,
	spr_index : 31
}

items_list[32] =
{
	name : "Pipes",
	stack : 10,
	spr_index : 32
}

items_list[33] =
{
	name : "Medical Parts",
	stack : 10,
	spr_index : 33
}

items_list[34] =
{
	name : "Grains",
	stack : 10,
	spr_index : 34
}

items_list[35] =
{
	name : "Raw Metal",
	stack : 10,
	spr_index : 35
}

items_list[36] =
{
	name : "Straw",
	stack : 10,
	spr_index : 36
}

items_list[37] =
{
	name : "Crushed Sand",
	stack : 10,
	spr_index : 37
}

items_list[38] =
{
	name : "Workbench",
	stack : 1,
	spr_index : 38
}

items_list[39] =
{
	name : "Furnace",
	stack : 1,
	spr_index : 39
}

items_list[40] =
{
	name : "Wood Wall",
	stack : 1,
	spr_index : 40,
	item_data : create_struct()
}
{
	items_list[40].item_data.item_type = item_types.building
}
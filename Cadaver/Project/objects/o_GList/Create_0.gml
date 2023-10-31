global.items_list = 0;
global.last_slot = { xx: 0, yy: 0 }

enum item_types
{
	melee,
	ranged,
	tool,
	building,
	resource,
	consumable
}

enum items
{
	air,
	stone,
	wood,
	sword
}

function create_struct()
{
	var return_struct =
	{
		description : "No description has been set for this item.",
		item_type : item_types.resource,
		damage: 0
	}

	return return_struct
}

current_item = 0

function create_item(arg_name)
{
	//Empty
	global.items_list[current_item] = 
	{
		name : arg_name,
		spr_index : current_item,
		item_data : create_struct()
	}
	
	current_item++		
	
	return global.items_list[current_item - 1]
}

//items
{
	var item = create_item("")

	item.item_data.item_type = item_types.melee
	item.item_data.damage = 2
}

{
	var item = create_item("Stone")
	
	item.item_data.item_type = item_types.melee
	item.item_data.description = "Heavy.. A very useful resource that is used in many different recipes. Pretty solid huh? I know, my joke rocks."
}

{
	var item = create_item("Wood")
	
	item.item_data.description = "A log taken from a tree. Can be turned into wood at a workbench or sawmill."
}

{
	var item = create_item("Sword")	
}
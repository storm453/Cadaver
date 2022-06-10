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
	log,
	sledgehammer,
	iron,
	basicknife,
	syringe,
	bottle,
	meat,
	cookedmeat,
	wood,
	stick,
	hammer,
	bread,
	metalblades,
	coal,
	electronics,
	plants,
	medicalsolution,
	medicalkit,
	cloth,
	bandage,
	infectedpiece,
	basecore,
	mechanicalparts,
	campfire,
	pickaxe,
	stonehatchet,
	shoddybed,
	metalfragments,
	chemicals,
	rareplants,
	metalpipes,
	medicalparts,
	grains,
	ironore,
	straw,
	crushedsand,
	workbench,
	furnace,
	woodwall
}

function create_struct()
{
	var return_struct =
	{
		description : "No description has been set for this item.",
		burn_time : 0,
		smelt: items.air,
		mill: 0,
		item_type : item_types.resource,
		building_obj : o_Campfire,
		damage: 0,
		kb: 1,
		sweep: 0,
		hand_sprite: s_Empty
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
	
	item.item_data.item_type = item_types.ranged
	item.item_data.description = "Heavy.. A very useful resource that is used in many different recipes. Pretty solid huh? I know, my joke rocks."
}

{
	var item = create_item("Log")
	
	item.item_data.mill = 8
	item.item_data.description = "A log taken from a tree. Can be turned into wood at a workbench or sawmill."
}

{
	var item = create_item("Sledgehammer")
}

{
	var item = create_item("Iron")
}
	
{
	var item = create_item("Basic Knife")

	item.item_data.item_type = item_types.melee
	item.item_data.description = "A versatile weapon for taking down the infected and chopping unwanted foliage."
	item.item_data.damage = 8
	item.item_data.kb = 0
	item.item_data.sweep = 1
	item.item_data.hand_sprite = s_Sword
}

{
	var item = create_item("Syringe")
}

{
	var item = create_item("Bottle")
}

{
	var item = create_item("Meat")
}

{
	var item = create_item("Cooked Meat")
}

{
	var item = create_item("Wood")
	
	item.item_data.burn_time = 1
	item.item_data.description = "Processed sticks and logs."
}

{
	var item = create_item("Stick")
}

{
	var item = create_item("Hammer")
	
	item.item_data.description = "Used for building bases."
	item.item_data.hand_sprite = s_Hammer
	item.item_data.item_type = item_types.tool
}

{
	var item = create_item("Bread")

	item.item_data.item_type = item_types.consumable
}

{
	var item = create_item("Metal Blades")
	
	item.item_data.description = "Be careful when handling."
}

{
	var item = create_item("Coal")
	
	item.item_data.burn_time = 2
}

{
	var item = create_item("Electronics")
	
	item.item_data.description = "Simple electronics ready to be used in whatever project you need them for."	
}

{
	var item = create_item("Plants")
	
	item.item_data.item_type = item_types.consumable
}

{
	var item = create_item("Medical Solution")
	
	 item.item_data.description = "An effective healing balm made from some plants. Used in crafting basic medicines."
}

{
	var item = create_item("Medical Kit")
}

{
	var item = create_item("Cloth")
}

{
	var item = create_item("Bandage")
}

{
	var item = create_item("Infected Piece")
}

{
	var item = create_item("Base Core")

	item.item_data.item_type = item_types.building
	item.item_data.description = "The most important block for your base. Keep this protected."
}

{
	var item = create_item("Mechanical Parts")
}

{
	var item = create_item("Campfire")

	item.item_data.item_type = item_types.building
	item.item_data.description = "Keeps you warm, cooks food, it's easy to build, and provides a light source. What more could you ask for?"
}

{
	var item = create_item("Pickaxe")

	item.item_data.item_type = item_types.tool
	item.item_data.damage = 4
	item.item_data.kb = 3
	item.item_data.sweep = 1
	item.item_data.hand_sprite = s_Pickaxe
	item.item_data.description = "Breaks rocks."
}
	
{
	var item = create_item("Stone Hatchet")

	item.item_data.item_type = item_types.tool
	item.item_data.damage = 5
	item.item_data.kb = 1.5
	item.item_data.sweep = 1
	item.item_data.hand_sprite = s_Axe
	item.item_data.description = "Cuts small trees."
}	

{
	var item = create_item("Shoddy Bed")

	item.item_data.description = "I mean, yeah, you could sleep here. But the question is, would you want to?"
}

{
	var item = create_item("Metal Fragments")
}

{
	var item = create_item("Chemicals")
}

{
	var item = create_item("Rare Plants")
}

{
	var item = create_item("Metal Pipes")
}

{
	var item = create_item("Medical Parts")
}

{
	var item = create_item("Grains")
}

{
	var item = create_item("Iron Ore")
	
	item.item_data.smelt = items.iron
}

{
	var item = create_item("Straw")
	
	item.item_data.burn_time = 60
}

{
	var item = create_item("Crushed Sand")
	
	item.item_data.smelt = items.stick
}

{
	var item = create_item("Workbench")
}

{
	var item = create_item("Furnace")
	
	item.item_data.item_type = item_types.building
	item.item_data.building_obj = o_Furnace
}

{
	var item = create_item("Wood Wall")

	global.items_list[40].item_data.item_type = item_types.building
}
map = array_create();

alarm[0] = 20

tiles = 16
world = room_width / tiles

for(var i = 0; i < world; i++)
{
	for(var j = 0; j < world; j++)
	{
		map[i,j] = 0;
	}
}

#macro grass_color c_lime
#macro object_color c_red

hp_show = 0;
energy_show = 0;

//crafting
function make_recipe_requirement(item_id, item_mat) 
{
  return { iid: item_id, mat: item_mat }
}

function make_recipe(item, requirements, amount_to_craft)
{
	return array(item, requirements, amount_to_craft)
}

weapons_list = ds_list_create()
tools_list = ds_list_create()
buildings_list = ds_list_create()
consumables_list = ds_list_create()
science_list = ds_list_create()
traps_list = ds_list_create()
ammunition_list = ds_list_create()
resources_list = ds_list_create()

selected_list = weapons_list
selected_mode = 0

ds_list_add(weapons_list, make_recipe(5, array(make_recipe_requirement(2, 1), make_recipe_requirement(4, 1)), 1))

ds_list_add(tools_list, make_recipe(26, array(make_recipe_requirement(2, 1), make_recipe_requirement(4, 2)), 1))
ds_list_add(tools_list, make_recipe(27, array(make_recipe_requirement(2, 1), make_recipe_requirement(4, 2)), 1))

ds_list_add(buildings_list, make_recipe(25, array(make_recipe_requirement(2, 3), make_recipe_requirement(1, 3)), 1))

ds_list_add(consumables_list, make_recipe(13, array(make_recipe_requirement(17, 3)), 1))
ds_list_add(consumables_list, make_recipe(28, array(make_recipe_requirement(11, 3), make_recipe_requirement(10, 1)), 3))
ds_list_add(consumables_list, make_recipe(29, array(make_recipe_requirement(9, 1), make_recipe_requirement(13, 2), make_recipe_requirement(14, 1), make_recipe_requirement(28, 1)), 1))

ds_list_add(science_list, make_recipe(18, array(make_recipe_requirement(7, 1), make_recipe_requirement(17, 3)), 1))
ds_list_add(science_list, make_recipe(21, array(make_recipe_requirement(20, 3)), 1))
ds_list_add(science_list, make_recipe(6, array(make_recipe_requirement(18, 1), make_recipe_requirement(33, 1)), 1))
ds_list_add(science_list, make_recipe(19, array(make_recipe_requirement(21,1), make_recipe_requirement(18, 1), make_recipe_requirement(20, 1)), 1))
ds_list_add(science_list, make_recipe(30, array(make_recipe_requirement(7,1), make_recipe_requirement(17, 3), make_recipe_requirement(31,1)), 3))

ds_list_add(traps_list, make_recipe(23, array(make_recipe_requirement(4, 3), make_recipe_requirement(24, 1)), 1))

ds_list_add(resources_list, make_recipe(16, array(make_recipe_requirement(4, 5), make_recipe_requirement(24, 3)), 1))
ds_list_add(resources_list, make_recipe(24, array(make_recipe_requirement(4, 3), make_recipe_requirement(3, 1)), 1))
ds_list_add(resources_list, make_recipe(32, array(make_recipe_requirement(4, 5)), 1))
ds_list_add(resources_list, make_recipe(33, array(make_recipe_requirement(4, 3), make_recipe_requirement(7, 1), make_recipe_requirement(31, 1)), 3))

buttons_list = ds_list_create()
	
ds_list_add(buttons_list, array(0, "WEAPONS", weapons_list))
ds_list_add(buttons_list, array(1, "TOOLS", tools_list))
ds_list_add(buttons_list, array(2, "BUILDINGS", buildings_list))
ds_list_add(buttons_list, array(3, "CONSUMABLES", consumables_list))
ds_list_add(buttons_list, array(4, "SCIENCE", science_list))
ds_list_add(buttons_list, array(5, "TRAPS", traps_list))
ds_list_add(buttons_list, array(6, "AMMUNITION", ammunition_list))
ds_list_add(buttons_list, array(7, "RESOURCES", resources_list))

crafting_tab = buttons_list[|0][1]

selected_item = 0
craft_amount = 1

counter = 0

queue_list = ds_list_create()
max_queue = 4

info_list = ds_list_create()
info_selected = 0

ds_list_add(info_list, 
	{ 
	name : "Movement", 
	description : "Use WASD to move your character, E is used to interfact with all objects in the game. Left Click to attack or harvest something, right click to build or place something."
	})
	
ds_list_add(info_list, 
	{ 
	name : "Sherwin Salemi", 
	description : "He is very violent, be careful when approaching him, his main weapon is a Fender HSS Stratocaster Special Edition."
	})
	
ds_list_add(info_list, 
	{ 
	name : "Logan Brown", 
	description : "REEEEEEE, Logan was never seen again"
	})

ds_list_add(info_list, 
	{ 
	name : "Adam Mathe",
	description : "A self proclaimed monotone speaker. Always watching for when you become online, and doesn't take no for an answer when it comes to anything you don't want him to do."
	})

//var index = weapons_list[|i]

//index[0] //ITEM TO BE CRAFTED
//index[1] //ARRAY FOR REQUIRED ITEMS

enum gui
{
	NONE,
	INVENTORY,
	CRAFTING,
	PROFILE
}

global.current_gui = gui.NONE

selected_tab = "CRAFTING"

#macro button_color c_dkgray
#macro button_s_color 0x6a6a69
#macro menu_color 0x262626
#macro tab_color 0x171717
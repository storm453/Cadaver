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

function make_recipe(item, requirements)
{
	return array(item, requirements)
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

ds_list_add(weapons_list, make_recipe(1, array(make_recipe_requirement(2, 1), make_recipe_requirement(3,1))))
ds_list_add(tools_list, make_recipe(3, array(make_recipe_requirement(1, 1))))

crafting_tab = "Consumables"

buttons_list = ds_list_create()
	
ds_list_add(buttons_list, array(0, "Weapons", weapons_list))
ds_list_add(buttons_list, array(1, "Tools", tools_list))
ds_list_add(buttons_list, array(2, "Buildings", buildings_list))
ds_list_add(buttons_list, array(3, "Consumables", consumables_list))
ds_list_add(buttons_list, array(4, "Science", science_list))
ds_list_add(buttons_list, array(5, "Traps", traps_list))
ds_list_add(buttons_list, array(6, "Ammunition", ammunition_list))
ds_list_add(buttons_list, array(7, "Resources", resources_list))

selected_item = 0

show_debug_message(weapons_list[|0])

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
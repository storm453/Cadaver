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

tab_sel_present_list = ds_list_create()

ds_list_add(tab_sel_present_list, gui.INVENTORY)
ds_list_add(tab_sel_present_list, gui.JOURNAL)
ds_list_add(tab_sel_present_list, gui.PROFILE)

inv_present_list = ds_list_create()

ds_list_add(inv_present_list, gui.INVENTORY)
ds_list_add(inv_present_list, gui.LOOT)

enum gui
{
	NONE,
	INVENTORY,
	PROFILE,
	JOURNAL,
	LOOT
}

global.current_gui = gui.NONE

enum crafting_lvls
{
	ALL,
	WORKBENCH,
	FURNACE
}

clvl_string[0] = "any"
clvl_string[1] = "workbench"
clvl_string[2] = "furnace"

clvl_allow[0] = 1
clvl_allow[1] = 1
clvl_allow[2] = crafting_lvls.FURNACE

crafting_level = crafting_lvls.ALL
craft_cat_name = "CRAFTING"

craft_name_arr[0] = "CRAFTING"
craft_name_arr[1] = "WORKBENCH"
craft_name_arr[2] = "FURNACE"

hp_show = 0;
energy_show = 0;

global.info_sel_slot = array(-1, -1)

//item log and notication ye5ah
item_log = ds_list_create()

function add_item_notif(message, spriteindex, timer)
{
	ds_list_add(item_log, { msg : message, spr_index : spriteindex , time : timer } )		
}

//crafting
function make_recipe_requirement(item_id, item_mat) 
{
  return { iid: item_id, mat: item_mat }
}

function make_recipe(item, requirements, amount_to_craft, crafting_lvl)
{
	return { item_id: item, req_arr: requirements, craft_amt: amount_to_craft, craft_lvl: crafting_lvl }
}

item_window_name = "None"
list_window_name = "All"

all_list = ds_list_create()
weapons_list = ds_list_create()
tools_list = ds_list_create()
buildings_list = ds_list_create()
consumables_list = ds_list_create()
science_list = ds_list_create()
traps_list = ds_list_create()
ammunition_list = ds_list_create()
resources_list = ds_list_create()

sel_craft_list = science_list
sel_item = -1
sel_item_id = 0

all_list = ds_list_create()

ds_list_add(weapons_list, make_recipe(items.basicknife, array(make_recipe_requirement(items.forgedmetal, 6), make_recipe_requirement(items.wood, 20)), 1, crafting_lvls.WORKBENCH))

ds_list_add(tools_list, make_recipe(26, array(make_recipe_requirement(items.wood, 35), make_recipe_requirement(items.stone, 30)), 1, crafting_lvls.ALL))
ds_list_add(tools_list, make_recipe(27, array(make_recipe_requirement(items.wood, 35), make_recipe_requirement(items.stone, 25)), 1, crafting_lvls.ALL))
ds_list_add(tools_list, make_recipe(items.tools, array(make_recipe_requirement(items.metal, 3)), 1, crafting_lvls.FURNACE))

ds_list_add(buildings_list, make_recipe(25, array(make_recipe_requirement(2, 3), make_recipe_requirement(1, 3)), 1, crafting_lvls.ALL))
ds_list_add(buildings_list, make_recipe(items.furnace, array(make_recipe_requirement(2, 50), make_recipe_requirement(items.stone, 35)), 1, crafting_lvls.ALL))
ds_list_add(buildings_list, make_recipe(items.workbench, array(make_recipe_requirement(items.wood, 5), make_recipe_requirement(items.forgedmetal, 3), make_recipe_requirement(items.tools, 1)), 1, crafting_lvls.ALL))
ds_list_add(buildings_list, make_recipe(items.shoddybed, array(make_recipe_requirement(items.wood, 20)), 1, crafting_lvls.ALL))

ds_list_add(consumables_list, make_recipe(13, array(make_recipe_requirement(17, 3)), 1, crafting_lvls.ALL))

ds_list_add(science_list, make_recipe(18, array(make_recipe_requirement(7, 1), make_recipe_requirement(17, 3)), 1, crafting_lvls.WORKBENCH))
ds_list_add(science_list, make_recipe(21, array(make_recipe_requirement(20, 3)), 1, crafting_lvls.ALL))
ds_list_add(science_list, make_recipe(6, array(make_recipe_requirement(18, 1), make_recipe_requirement(33, 1)), 1, crafting_lvls.WORKBENCH))
ds_list_add(science_list, make_recipe(19, array(make_recipe_requirement(21,1), make_recipe_requirement(18, 1), make_recipe_requirement(20, 1)), 1, crafting_lvls.WORKBENCH))
ds_list_add(science_list, make_recipe(30, array(make_recipe_requirement(7,1), make_recipe_requirement(17, 3), make_recipe_requirement(31,1)), 3, crafting_lvls.WORKBENCH))

ds_list_add(traps_list, make_recipe(23, array(make_recipe_requirement(4, 3), make_recipe_requirement(37, 1)), 1, crafting_lvls.WORKBENCH))

ds_list_add(resources_list, make_recipe(4, array(make_recipe_requirement(15, 5), make_recipe_requirement(items.stone, 1)), 1, crafting_lvls.FURNACE))
ds_list_add(resources_list, make_recipe(items.metalfragments, array(make_recipe_requirement(15, 1)), 1, crafting_lvls.FURNACE))
ds_list_add(resources_list, make_recipe(16, array(make_recipe_requirement(items.metalfragments, 1), make_recipe_requirement(24, 3)), 1, crafting_lvls.WORKBENCH))
ds_list_add(resources_list, make_recipe(24, array(make_recipe_requirement(15, 3), make_recipe_requirement(3, 1)), 1, crafting_lvls.FURNACE))
ds_list_add(resources_list, make_recipe(items.bottle, array(make_recipe_requirement(items.glass, 3)), 1, crafting_lvls.FURNACE))
ds_list_add(resources_list, make_recipe(32, array(make_recipe_requirement(15, 5)), 1, crafting_lvls.FURNACE))
ds_list_add(resources_list, make_recipe(33, array(make_recipe_requirement(15, 3), make_recipe_requirement(7, 1), make_recipe_requirement(31, 1)), 3, crafting_lvls.WORKBENCH))
ds_list_add(resources_list, make_recipe(37, array(make_recipe_requirement(1, 2)), 1, crafting_lvls.WORKBENCH))

cat_buttons = array
(	
	{ uid: 0, name: "All", list_var: weapons_list },
	{ uid: 0, name: "Weapons", list_var: weapons_list },
	{ uid: 0, name: "Tools", list_var: tools_list },
	{ uid: 0, name: "Buildings", list_var: buildings_list },
	{ uid: 0, name: "Consumables", list_var: consumables_list },
	{ uid: 0, name: "Science", list_var: science_list },
	{ uid: 0, name: "Resources", list_var: resources_list }
)

counter = 0

queue_list = ds_list_create()
max_queue = 4

queue_var = queue_list

status_list = ds_list_create()
status_selected = 0

abrasion = { name : "Abrasion", description : "A small, open wound. A bandage will speed up healing." }
cut = { name : "Cuts" , description : "Some small cuts. A bandage will speed up healing." }
laceration = { name : "Laceration", description: "Some deep cuts. Make sure to bandage these to avoid serious danger."}
avulsion = { name : "Avulsion", description: "You are bleeding out. Applying a tourniquet will help this."}

info_list = ds_list_create()
info_selected = 0

ds_list_add(status_list, { status_id : abrasion, time : 60 } )
ds_list_add(status_list, { status_id : laceration, time : 600 } )
ds_list_add(status_list, { status_id : cut, time : 300 } )

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

selected_tab = "CRAFTING"

#macro button_color c_dkgray
#macro title_color c_dkgray
#macro button_s_color 0x7a94ab
#macro button_h_color 0x6a6a69
#macro menu_color 0x262626
#macro tab_color 0x171717
#macro text_color c_ltgray
#macro sprite_color c_ltgray
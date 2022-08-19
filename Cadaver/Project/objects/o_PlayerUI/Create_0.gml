global.open_instance = noone

//guis to draw hud
draw_hud = ds_list_create()

ds_list_add(draw_hud, gui.NONE)

//blueprints for building
blueprints = ds_list_create()

selected_bp = noone
sel_bp_id = -1

//blueprints for hammer building
housing = ds_list_create()

hos_build = false

ds_list_add(housing, { text: "Pine Floor", obj: o_Floor, spr: s_FloorIcon, desc: "Carpet made out of wood!", need: array(recipe_req(items.wood, 1)) } )
ds_list_add(housing, { text: "Pine Wall", obj: o_Wall, spr: s_WallIcon, desc: "Keeps enemies out.", need: array(recipe_req(items.wood, 3)) } )
ds_list_add(housing, { text: "Pine Gate", obj: o_Gate, spr: s_GateIcon, desc: "The way inside.", need: array(recipe_req(items.wood, 5),recipe_req(items.stone, 2)) } )

/// CRAFTING
craft_selcat = 0
craft_categories = ds_list_create()

ds_list_add(craft_categories, "Weapons")
ds_list_add(craft_categories, "Tools")
ds_list_add(craft_categories, "Buildings")
ds_list_add(craft_categories, "Resources")
ds_list_add(craft_categories, "Items")
ds_list_add(craft_categories, "Food")
ds_list_add(craft_categories, "Ammunition")
ds_list_add(craft_categories, "Traps")

//CRAFTING RECIPES
craft_recipes = array(0)
craft_selrec = 0

//recipes
craft_recipes[0] = ds_list_create()
ds_list_add(craft_recipes[0], recipe(items.basicknife, array( recipe_req(items.wood, 3), recipe_req(items.iron, 10) ), 1 ) )
ds_list_add(craft_recipes[0], recipe(items.sledgehammer, array( recipe_req(items.wood, 5), recipe_req(items.iron, 15) ), 1 ) )


craft_recipes[1] = ds_list_create()
ds_list_add(craft_recipes[1], recipe(items.stonehatchet, array( recipe_req(items.stone, 1), recipe_req(items.wood, 2), recipe_req(items.plantfibers, 3) ), 1 ) )
ds_list_add(craft_recipes[1], recipe(items.pickaxe, array( recipe_req(items.stone, 3), recipe_req(items.wood, 2), recipe_req(items.plantfibers, 3) ), 1 ) )
ds_list_add(craft_recipes[1], recipe(items.hammer, array( recipe_req(items.wood, 3), recipe_req(items.iron, 5) ), 1 ) )


craft_recipes[2] = ds_list_create()
ds_list_add(craft_recipes[2], recipe(items.woodwall, array( recipe_req(items.wood, 25) ), 1 ) )
ds_list_add(craft_recipes[2], recipe(items.woodfloor, array( recipe_req(items.wood, 25) ), 1 ) )


craft_recipes[3] = ds_list_create()



craft_recipes[4] = ds_list_create()
ds_list_add(craft_recipes[4], recipe(items.furnace, array( recipe_req(items.wood, 3), recipe_req(items.stone, 50) ), 1 ) )


craft_recipes[5] = ds_list_create()



craft_recipes[6] = ds_list_create()



craft_recipes[7] = ds_list_create()



//sharpener - flint rare drop (flint + stone) = sharpener
//stick + 2 stones = dull axe + sharper = stone aXE

gridx = 10
gridy = 4
			
cel_size = 100
cel_gap = 15
			
dw = (gridx * cel_size) + (gridx - 1) * cel_gap
dh = (gridy * cel_size) + (gridy - 1) * cel_gap
			
dx = display_get_gui_width() / 2 - dw / 2
dy = display_get_gui_height() / 2 - dh / 2
start_dx = dx
start_dy = dy

selected_housing = 0

hos_x = start_dx
hos_y = start_dy

//no exit if in these uis
no_exit = ds_list_create()

ds_list_add(no_exit, gui.CONTAINER)

//recipes 
global.recipe_amount = 4
global.recipes = array_create(global.recipe_amount)

for(var i = 0; i < global.recipe_amount; i++)
{
	global.recipes[i] = ds_list_create()	
}

enum gui
{
	NONE,
	INVENTORY,
	CONTAINER,
	CRAFT
}

global.current_gui = gui.NONE

hp_show = 0;
energy_show = 0;

item_log = ds_list_create()

//recipe example
//ds_list_add([list], make_recipe(items.basicknife, array(make_recipe_requirement(items.forgedmetal, 6), make_recipe_requirement(items.wood, 20)), 1, crafting_lvls.WORKBENCH))

#macro main_color color_hex(0x9babb2)
#macro button_color color_hex(0xc7b08b)
#macro text_color c_white
#macro button_s_color 0x9b8685
#macro confirm_color color_hex(0x71413b)
#macro confirm_s_color 0x69db91
#macro decline_color color_hex(0xb4202a)
#macro decline_s_color 0x8181f6
#macro tab_color color_hex(0xe4d2aa)
#macro dark_color 0x655562
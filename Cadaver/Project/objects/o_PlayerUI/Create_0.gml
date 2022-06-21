global.open_instance = noone

//guis to draw hud
draw_hud = ds_list_create()

ds_list_add(draw_hud, gui.NONE)

//buttons for switching
switch_buttons = ds_list_create()

ds_list_add(switch_buttons, { text: "Inventory", to: gui.INVENTORY } )
ds_list_add(switch_buttons, { text: "Building", to: gui.BUILDING } )

//blueprints for building
blueprints = ds_list_create()

ds_list_add(blueprints, { text: "Furnace", obj: o_Furnace, need: array( { item: items.stone, amt: 20 } ), desc: "Used for smelting ores." } )
ds_list_add(blueprints, { text: "Basic Workbench", obj: o_BasicStation, need: array( { item: items.stick, amt: 5 } ), desc: "Craft items." } )
ds_list_add(blueprints, { text: "Sawing Table", obj: o_SawMill, need: array( { item: items.wood, amt: 20 }, { item: items.metalblades, amt: 1 } ), desc: "Faster wood production." } )
ds_list_add(blueprints, { text: "Campfire", obj: o_Campfire, need: array( { item: items.wood, amt: 5 }, { item: items.stone, amt: 3 } ), desc: "See at night." } )

selected_bp = noone
sel_bp_id = -1

//blueprints for hammer building
housing = ds_list_create()

hos_build = false

ds_list_add(housing, { text: "Pine Floor", obj: o_Floor, spr: s_FloorIcon, desc: "Carpet made out of wood!", need: array(recipe_req(items.wood, 1)) } )
ds_list_add(housing, { text: "Pine Wall", obj: o_Wall, spr: s_WallIcon, desc: "Keeps enemies out.", need: array(recipe_req(items.wood, 3)) } )
ds_list_add(housing, { text: "Pine Gate", obj: o_Gate, spr: s_GateIcon, desc: "The way inside.", need: array(recipe_req(items.wood, 5),recipe_req(items.stone, 2)) } )

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

ds_list_add(no_exit, gui.LOOT)

//recipes 
global.recipe_amount = 4
global.recipes = array_create(global.recipe_amount)

for(var i = 0; i < global.recipe_amount; i++)
{
	global.recipes[i] = ds_list_create()	
}

ds_list_add(global.recipes[0], recipe(items.wood, array(recipe_req(items.stick, 1)), 2 ) )
ds_list_add(global.recipes[0], recipe(items.stonehatchet, array(recipe_req(items.wood, 5), recipe_req(items.stone, 3)), 1 ) )
ds_list_add(global.recipes[0], recipe(items.pickaxe, array(recipe_req(items.wood, 5), recipe_req(items.stone, 5), recipe_req(items.plants, 3)), 1 ) )
ds_list_add(global.recipes[0], recipe(items.metalblades, array(recipe_req(items.iron, 4), recipe_req(items.stone, 1)), 2 ) )
ds_list_add(global.recipes[0], recipe(items.sledgehammer, array(recipe_req(items.iron, 12)), 2 ) )

ds_list_add(global.recipes[1], recipe(items.hammer, array(recipe_req(items.iron, 8), recipe_req(items.wood, 10)), 1 ) )
ds_list_add(global.recipes[1], recipe(items.basicknife, array(recipe_req(items.metalblades, 1), recipe_req(items.wood, 5)), 1 ) )


enum gui
{
	NONE,
	INVENTORY,
	BUILDING,
	CRAFT,
	WIRE,
	SELECTBLUE,
	LOOT,
	JOURNAL,
	PROFILE,
	BASE
}

global.current_gui = gui.NONE

hp_show = 0;
energy_show = 0;

item_log = ds_list_create()

//recipe example
//ds_list_add([list], make_recipe(items.basicknife, array(make_recipe_requirement(items.forgedmetal, 6), make_recipe_requirement(items.wood, 20)), 1, crafting_lvls.WORKBENCH))

#macro main_color color_hex(0x9babb2)
#macro button_color 0x816b6a
#macro text_color c_white
#macro button_s_color 0x9b8685
#macro confirm_color 0x73bc1e
#macro confirm_s_color 0x69db91
#macro decline_color 0x3b3be8
#macro decline_s_color 0x8181f6
#macro tab_color color_hex(0x708189)
#macro dark_color 0x655562
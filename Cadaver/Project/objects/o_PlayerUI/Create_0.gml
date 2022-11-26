global.open_instance = noone

//buttons at top to navigate to craft, inventory, and profile
tabnav = ds_list_create()

//anything here should be able to be navigated to
ds_list_add(tabnav, gui.CRAFT)
ds_list_add(tabnav, gui.INVENTORY)

//navtab button list
tabnav_buttons = ds_list_create()

ds_list_add(tabnav_buttons, { text: "Crafting", ui: gui.CRAFT } )
ds_list_add(tabnav_buttons, { text: "Inventory", ui: gui.INVENTORY } )
ds_list_add(tabnav_buttons, { text: "Profile", ui: gui.CONTAINER } )
ds_list_add(tabnav_buttons, { text: "Injections", ui: gui.CONTAINER } )

//possible stations requirements for crafting items
enum stations
{
	hands,
	workbench
}

//guis to draw hud
draw_hud = ds_list_create()

ds_list_add(draw_hud, gui.NONE)

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

craft_recipes[1] = ds_list_create()

craft_recipes[2] = ds_list_create()
ds_list_add(craft_recipes[2], global.recipes[items.workbench])

craft_recipes[3] = ds_list_create()


craft_recipes[4] = ds_list_create()
ds_list_add(craft_recipes[4], global.recipes[items.researchstation])

craft_recipes[5] = ds_list_create()

craft_recipes[6] = ds_list_create()

craft_recipes[7] = ds_list_create()

gridx = 10
gridy = 4
			
cel_size = 100
cel_gap = 15
			
dw = (gridx * cel_size) + (gridx - 1) * cel_gap
dh = (gridy * cel_size) + (gridy - 1) * cel_gap
			
dx = display_get_gui_width() / 2 - dw / 2
dy = display_get_gui_height() / 2 - dh / 2

//no exit if in these uis
no_exit = ds_list_create()

ds_list_add(no_exit, gui.CONTAINER)

//recipes 
//global.recipe_amount = 4
//global.recipes = array_create(global.recipe_amount)

//for(var i = 0; i < global.recipe_amount; i++)
//{
//	global.recipes[i] = ds_list_create()	
//}

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
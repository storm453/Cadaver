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
ds_list_add(blueprints, { text: "Basic Workbench", obj: o_BasicStation, need: array( { item: items.wood, amt: 10 } ), desc: "Craft items." } )
//ds_list_add(blueprints, { text: "Workbench", obj: o_Workbench, need: array( { item: items.forgedmetal, amt: 5 }, { item: items.wood, amt: 10 } ), desc: "Craft more items." } )

selected_bp = noone

//recipes 
global.recipes = ds_list_create()



ds_list_add(recipes, { item: items.stonehatchet, req: array( { item: items.wood, amt: 5 }, { item: items.stone, amt: 1 } ) } )
ds_list_add(recipes, { item: items.pickaxe, req: array( { item: items.wood, amt: 5 }, { item: items.stone, amt: 1 } ) } )
ds_list_add(recipes, { item: items.bandage, req: array( { item: items.wood, amt: 5 }, { item: items.stone, amt: 1 } ) } )


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
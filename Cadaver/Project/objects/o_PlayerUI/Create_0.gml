depth = 1

global.open_instance = noone

#macro edge_pad 15
#macro pad 5

icons[0] = { label: "Inventory", icon: s_Backpack, key: s_KeyTab }
icons[1] = { label: "Crafting", icon: s_Tools, key: s_KeyC }

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

//guis to draw hud
draw_hud = ds_list_create()

ds_list_add(draw_hud, gui.NONE)

enum gui
{
	NONE,
	INVENTORY,
	CONTAINER,
	CRAFT
}

global.current_gui = gui.NONE

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
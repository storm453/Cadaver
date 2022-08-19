inv = create_inventory(5, 4)

inv_sx = array_length(inv)
inv_sy = array_height(inv)

//add_item(inv, items.wood, 1000)
//add_item(inv, items.ironore, 1000)
//add_item(inv, items.stone, 1000)
//add_item(inv, items.iron, 1000)
//add_item(inv, items.stick, 1000)
//add_item(inv, items.plantfibers, 1000)

depth = 0

overlay_alpha = 0

show_list = ds_list_create()
 
ds_list_add(show_list, gui.INVENTORY)
ds_list_add(show_list, gui.CONTAINER)

#macro inv_offset 150

#macro inv_scale 4
#macro slot_size 16 * inv_scale

//specififcs
#macro slot_from_top 4 * inv_scale //in pixels
#macro slot_spacing 2 * inv_scale //in pixels

global.drag_slot = { xx : 0, yy : 0, inventory: inv }

//amount to shift hotbar away from bottom of the screen
#macro scr_hot_shift 50
#macro inv_hot_shift 20

//alpha variables
inv_alpha = 0

//position vars
hot_x = 0
hot_y = 0
inv_x = 0
inv_y = 0

global.in_hand = 0 

global.hotbar_sel_slot = 0
global.hotbar_sel_item = 0

#macro player_inv_width sprite_get_width(s_Inventory) * inv_scale
#macro player_inv_height sprite_get_height(s_Inventory) * inv_scale
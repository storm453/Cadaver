inv_data = create_inv_data(5, 4, 1)
inv = create_inventory(inv_data.slots_x, inv_data.slots_y)

add_item(inv, inv_data, items.stonehatchet, 1)

overlay_alpha = 0

show_list = ds_list_create()

held = 0

ds_list_add(show_list, gui.INVENTORY)
ds_list_add(show_list, gui.LOOT)
ds_list_add(show_list, gui.CRAFT)

#macro slot_size 18
#macro inv_scale 3.5
#macro slot_gap 6

drag_slot = { xx : 0, yy : 0 }

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

#macro player_inv_width (o_PlayerInventory.inv_data.slots_x * (slot_size * inv_scale)) + ((o_PlayerInventory.inv_data.slots_x - 1) * slot_gap)
#macro player_inv_height ((o_PlayerInventory.inv_data.slots_y * (slot_size * inv_scale)) + ((o_PlayerInventory.inv_data.slots_y - 1) * slot_gap) + scr_hot_shift + inv_hot_shift + 49)	
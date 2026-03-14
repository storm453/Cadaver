inv = create_inventory(4, 3)

inv_sx = array_length(inv)
inv_sy = array_height(inv)

hover_slot = vec2(0, 0)

depth = 0

global.selected = 0
wheel_scale = 0

show_list = ds_list_create()

ds_list_add(show_list, gui.INVENTORY)
ds_list_add(show_list, gui.CONTAINER)

#macro slot_margin 80
#macro slot_size 140
#macro slot_pad 30
#macro inv_marg_y 300

hot_x = 0
hot_y = 0
inv_x = 0
inv_y = 0

global.in_hand = 0 
global.hotbar_data = 0
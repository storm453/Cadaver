//amount to shift hotbar down from inventory
shift = draw_scale * slot_size / 4

//some inventory height variables for drawing ui in o_PlayerUI
player_inventory_height_slots_only = ((slots_y) * slot_size * draw_scale) - 1
player_inventory_height = (slots_y * slot_size * draw_scale) + shift

global.in_hand = 0 

global.hotbar_sel = 0
global.hotbar_sel_item = 0
inv_data = create_inv_data(10, 5, 10, 10, 3)
inv = create_inventory(inv_data.slots_x, inv_data.slots_y)

//amount to shift hotbar down from inventory
shift = inv_data.draw_scale * inv_data.slot_size / 4

//Tab title
title = "INVENTORY";
font_height = string_height_font(title, ft_Title)
title_height = font_height + pad * 2

//some inventory height variables for drawing ui in o_PlayerUI
player_inventory_height_slots_only = ((inv_data.slots_y) * inv_data.slot_size) - 1
player_inventory_height = (inv_data.slots_y * inv_data.slot_size * inv_data.draw_scale) + shift

global.in_hand = 0 

global.hotbar_sel = 0
global.hotbar_sel_item = 0
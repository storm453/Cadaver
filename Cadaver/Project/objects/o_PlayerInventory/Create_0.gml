inv_data = create_inv_data(10, 5, 3)
inv = create_inventory(inv_data.slots_x, inv_data.slots_y)

held = 0
cooldown = 0

//amount to shift hotbar down from inventory
shift = inv_data.slot_space / 4

//Tab title
title = "INVENTORY";
font_height = string_height_font(title, ft_Title)
title_height = font_height + pad * 2

//some inventory height variables for drawing ui in o_PlayerUI
player_inventory_height_slots_only = ((inv_data.slots_y) * inv_data.slot_space) - 1
player_inventory_height = (inv_data.slots_y * inv_data.slot_space) + shift

//position vars
inv_x = 0
inv_y = 0

global.in_hand = 0 

global.hotbar_sel = 0
global.hotbar_sel_item = 0
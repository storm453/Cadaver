var mx = device_mouse_x_to_gui(0)
var my = device_mouse_y_to_gui(0)

var slot_scale = inv_data.slot_space

//if(arg_scale != 1) slot_scale = arg_scale

for(var i = 0; i < inv_data.slots_x; i++)
{
    for(var j = 0; j < inv_data.slots_y; j++)
    {	
        if(point_in_rectangle(mx, my, inv_x + (i * slot_scale), inv_y + (j * slot_scale), inv_x + (i * slot_scale) + slot_scale, inv_y + (j * slot_scale) + slot_scale))
        {
            si = i
            sj = j
            s_slot = inv[i,j]

            cooldown--

            //Left clicking to select an item for info
            if(mouse_check_button(mb_right))
            {
                if(inv[i,j] != 0)
                {
                    o_PlayerUI.sel_item = -1
                    o_PlayerUI.item_window_name = global.items_list[inv[i, j].item].name
                    
                    global.info_sel_slot[0] = i
                    global.info_sel_slot[1] = j
                }
            }

            if(mouse_check_button_pressed(mb_left))
            {
                if(global.current_gui != 0)
                {
                    var old_hand = global.in_hand
    
                    global.in_hand = inv[i, j]
                    array_set(inv[i], j, old_hand)

                    if(global.in_hand != 0)
                    {
                        if(inv[i,j] != 0)
                        {
                            if(inv[i,j].item == global.in_hand.item)
                            {
                                inv[i,j].amt += global.in_hand.amt
                                global.in_hand = 0 
                            }
                        }
                    }
                }
            }

        }  
    }
}
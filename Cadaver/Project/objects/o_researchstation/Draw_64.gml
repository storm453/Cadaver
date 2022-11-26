var mx = device_mouse_x_to_gui(0)
var my = device_mouse_y_to_gui(0)

if(global.open_instance != id) exit;

var rui_x = rui_x_set
var rui_y = rui_y_set

window_text(rui_x, rui_y, "Research", ft_Large, c_aqua)

draw_sprite_ext(s_ResearchUI, 0, rui_x, rui_y, inv_scale, inv_scale, 0, c_white, 1)

rui_x += 12
rui_y += 12

var already_researched = 0

for(var i = 0; i < ds_list_size(researched); i++)
{
	if(inv[0,0] != 0)
	{
		if(inv[0,0].item == researched[|i]) already_researched = 1
	}
}

//clicking and moving items
for(var i = 0; i < array_length(inv); i++)
{
	for(var j = 0; j < array_height(inv); j++)
	{
		var slots_dx = rui_x + (i * (slot_size + slot_spacing))
		var slots_dy = rui_y + (j * (slot_size + slot_spacing))
		
		if(point_in_rectangle(mx, my, slots_dx, slots_dy, slots_dx + slot_size, slots_dy + slot_size))
		{
			if(!researching)
			{
				inv_click_logic(i, j)
			}
				
			draw_sprite_ext(s_GeneralSelected, 0, slots_dx, slots_dy, inv_scale, inv_scale, 0, c_white, 0.2)
		}
			
		draw_item(inv, i, j, slots_dx, slots_dy, false)
		
		if(researching) draw_sprite_ext(s_LockIcon, 0, slots_dx, slots_dy, inv_scale, inv_scale, 0, c_white, 1)	
		if(already_researched) draw_sprite_ext(s_CheckIcon, 0, slots_dx, slots_dy, inv_scale, inv_scale, 0, c_white, 1)	
	}
}

rui_y += 42 * inv_scale

var rb_index = 0

var button_enable = 1

if(already_researched) button_enable = 0

if(inv[0,0] == 0) 
{
	rb_index = 1
}
else
{
	if(researching) 
	{
		rb_index = 1
	}
	
	if(button_enable)
	{
		if(point_in_rectangle(mx, my, rui_x, rui_y, rui_x + 48, rui_y + 48))
		{
			if(!researching)
			{
				rb_index = 2
			
				if(mouse_check_button_pressed(mb_left))
				{
					researching = true		
					ds_list_add(messages_log, "Researching..")
				}
			}
		}
	}
	else
	{
		rb_index = 1
	}
}

if(research_prog > 2000)
{
	researching = false;	
	research_prog = 0
	
	ds_list_add(researched, inv[0,0].item)
	
	for(var i = 0; i < array_length_1d(unlocks_list); i++)
	{
		if(inv[0,0].item != 0)
		{
			if(i == inv[0,0].item)
			{
				//there are blueprint unlocks for item in slot
				var index = unlocks_list[i]
				
				for(var j = 0; j < array_length_1d(index); j++)
				{
					ds_list_add(o_PlayerUI.craft_recipes[index[j].crafting_category_index], index[j])
					
					var cur_item = global.items_list[index[j].item].name
					
					ds_list_add(messages_log, "Recipe: " + string(cur_item))
				}
			}
		}
	}
}

draw_sprite_ext(s_ResearchButton, rb_index, rui_x, rui_y, inv_scale, inv_scale, 0, c_white, 1)

rui_x += 20 * inv_scale
rui_y += 12 * inv_scale

draw_set_color(c_lime)
draw_rectangle(rui_x, rui_y, rui_x + ((102 * inv_scale) / 2000) * research_prog, rui_y + 4 * inv_scale, false)

rui_y = rui_y_set + 12 + pad
rui_x += pad

draw_set_font(ft_20)

if(ds_list_size(messages_log) > 0) 
{
	log_del_timer++
	if(log_del_timer > 60)
	{
		ds_list_delete(messages_log, 0)	
		log_del_timer = 0
	}
}	

for(var i = 0; i < ds_list_size(messages_log); i++)
{
	draw_text(rui_x, rui_y + (i * 40), messages_log[|i])
}
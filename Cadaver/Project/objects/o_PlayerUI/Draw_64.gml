var hp_x = 10;
var hp_y = 10;

var bar_draw = 3

hp_show = lerp(hp_show, o_Player.hp, 0.2);

var hp_w = (hp_show/100)* sprite_get_width(s_HealthBar)
var hp_h = sprite_get_height(s_HealthBar);

draw_sprite_ext(s_HealthBar, 0, hp_x, hp_y, bar_draw, bar_draw, 0, c_white, 1)
draw_sprite_part_ext(s_HealthBar, 1, 0, 0, hp_w, hp_h, hp_x, hp_y, bar_draw, bar_draw, c_white, 1)

//energy bar
hp_y += hp_h * bar_draw + pad

energy_show = lerp(energy_show, o_Player.energy, 0.2);

var en_w = (energy_show/100)* sprite_get_width(s_HealthBar)
var en_h = sprite_get_height(s_HealthBar);

draw_sprite_ext(s_EnergyBar, 0, hp_x, hp_y, bar_draw, bar_draw, 0, c_white, 1)
draw_sprite_part_ext(s_EnergyBar, 1, 0, 0, en_w, en_h, hp_x, hp_y, bar_draw, bar_draw, c_white, 1)

//ITEM PICKUP DROP NOTIFICATIONS LOG HJING YEAH
var log_x = 1700
var log_y = 1000
	
for(var i = 0; i < ds_list_size(item_log); i++)
{
	var log_height = 50
		
	var item_entry = item_log[|i]
		
	var item_spr_index = item_entry.spr_index
	//var item_name = o_iitem_entry.spr_index
	
	var fade_time = 0.5
	var fade_alpha = clamp(item_entry.time / fade_time, 0, 1)
	
	//@TODO Smooth moving
	//@HACK
	draw_set_alpha(fade_alpha)
	ui_draw_title(item_entry.msg, log_x, log_y - (log_height + pad) * i, 200, log_height, tab_color, c_white, false)
	draw_set_alpha(1)	
	
	item_entry.time -= get_delta_time()
		
	if(item_entry.time <= 0)
	{
		ds_list_delete(item_log, i)
	}
}

draw_set_font(ft_Default)

#macro pad 5

#macro switch_button_scale 64

#macro title_button_width 128
#macro title_button_height 32

if(global.current_gui  != 0)
{	
	var inv_width = round(o_PlayerInventory.slots_x * o_PlayerInventory.draw_scale * o_PlayerInventory.slot_size) - 1
	var inv_width_slots_only = o_PlayerInventory.player_inventory_height_slots_only
	var inv_height = o_PlayerInventory.player_inventory_height
	var window_width = inv_width
	var window_height = 300

	var buttons = 3
	var menu_scale = 0;
	
	repeat(round(buttons))
	{
		menu_scale += pad + switch_button_scale
	}
	
	menu_scale += pad

	draw_set_font(ft_Title)
	var title = "THING";
	var title_height = string_height(title) + pad * 2
	
	var switch_x = display_get_gui_width() / 2 - (menu_scale + menu_scale / 4) / 2
	var switch_y = 0
	
	ui_draw_title(selected_tab, switch_x, switch_y, menu_scale + menu_scale / 4, title_height, tab_color, c_white, false)
	draw_set_font(ft_Default)

	switch_x = display_get_gui_width() / 2 - menu_scale / 2
	switch_y = title_height

	ui_draw_rectangle(switch_x, switch_y, menu_scale, switch_button_scale + pad, menu_color, 1, false)

	switch_x += pad

	var button_array = array_create(buttons);
	
	var button_data_array = ""
	
	button_data_array[0] = "Inv"
	button_data_array[1] = "Chr"
	button_data_array[2] = "Map"

	for(var i = 0; i < buttons; i++)
	{
		//button_array[i] = ui_draw_button_color(button_data_array[i], switch_x, switch_y, switch_button_scale, switch_button_scale, button_color, button_s_color, c_white, false)
		button_array[i] = ui_draw_button_sprite(s_Icons, i, switch_x, switch_y, switch_button_scale, switch_button_scale, button_color, button_s_color, c_white, 0.5, false)
		switch_x += pad + switch_button_scale
	}
	
	if(button_array[0][0])
	{
		global.current_gui = gui.INVENTORY
		selected_tab = "CRAFTING"
	}	
	
	if(button_array[1][0])
	{
		global.current_gui = gui.PROFILE
		selected_tab = "PROFILE"
	}
	
	if(button_array[2][0])
	{
		global.current_gui = gui.CRAFTING
		selected_tab = "MAP"
	}	
}

function ui_draw_window(t, sx, sy, w, h)
{
	ui_draw_rectangle(sx, sy, w, h, menu_color, 1, false)
	
	var title_height = string_height_font(t, ft_Title)
	
	sy -= title_height + pad
	
	ui_draw_rectangle(sx, sy, w, pad + title_height, tab_color, 1, false);
	ui_draw_string(sx + pad, sy + pad, t, ft_Title) 
		
	return title_height + pad * 3
}

if(global.current_gui == gui.INVENTORY)
{
	//MAIN UI
	var start_x = display_get_gui_width() / 2 - inv_width / 2
	var start_y = display_get_gui_height() - inv_height - window_height - pad

	var title = "INVENTORY";
	var font_height = string_height_font(title, ft_Title)
	var title_height = font_height + pad * 2
		
	window_height -= title_height

	start_y = display_get_gui_height() - inv_height - title_height
	
	ui_draw_rectangle(start_x, start_y, window_width, title_height, tab_color, 1, false)
	ui_draw_string(start_x + pad, start_y + pad, title, ft_Title)

	var craft_height = 400

	start_y = display_get_gui_height() - inv_height - craft_height - title_height - pad
	
	ui_draw_window("CRAFTING", start_x, start_y, window_width, craft_height)
	
	#macro list_button_scale 50
	
	#macro item_button_width 160
	#macro item_button_height 35
	
	var buttons_x = display_get_gui_width() / 2 - inv_width / 2
	var buttons_y = display_get_gui_height() - inv_height - craft_height - title_height - pad
	
	var list_x = display_get_gui_width() / 2 - inv_width / 2 
	var list_y = display_get_gui_height() - inv_height - craft_height - title_height - pad
	
	buttons_x += pad
	list_x += pad
	
	buttons_x += inv_width / 2 - ds_list_size(buttons_list) * (list_button_scale + pad) / 2 - pad
	buttons_y += pad
	
	for(i = 0; i < ds_list_size(buttons_list); i++)
	{
		var index = buttons_list[|i]
		
		var button = ui_draw_button_sprite(sTab, index[0], buttons_x + (list_button_scale + pad) * i, buttons_y, list_button_scale, list_button_scale, button_color, button_s_color, c_white, 0.07, false)
		if(button[0])
		{
			crafting_tab = index[1]
			selected_list = index[2]
			selected_item = 0
		}
	}
	
	list_y += list_button_scale + pad * 2
	
	ui_draw_title(crafting_tab, list_x, list_y, inv_width - (pad * 2), item_button_height, menu_color, c_white, false)
	
	list_y += item_button_height + pad

	if(ds_list_size(selected_list) > 0)
	{
		for(var i = 0; i < ds_list_size(selected_list); i++)
		{
			if(selected_item == i)
			{
				var button = ui_draw_button_color(o_InventoryBase.items_list[selected_list[|i][0]].name, list_x, list_y + (i * (item_button_height + pad)), item_button_width, item_button_height, button_s_color, button_s_color, c_white, false)
			}
			else
			{
				var button = ui_draw_button_color(o_InventoryBase.items_list[selected_list[|i][0]].name, list_x, list_y + (i * (item_button_height + pad)), item_button_width, item_button_height, button_color, button_s_color, c_white, false)	
			}
			
			if(button[0])
			{
				selected_item = i	
			}
		}
	}
	
	list_x += item_button_width + pad
	
	var sprite_scale = 4
	
	//THIS IS INCREDIBLY JANK PLEAASE CHANGE THIS SOON ADAM GODAMN
	if(ds_list_size(selected_list) > 0)
	{
		var sprite_space = sprite_get_height(s_Items) * sprite_scale
		
		ui_draw_rectangle(list_x, list_y, sprite_get_width(s_Items) * sprite_scale, sprite_get_height(s_Items) * sprite_scale - pad, button_color, 1, false)
		
		var height = craft_height - sprite_get_height(s_Items) * sprite_scale - (pad * 6) - list_button_scale - item_button_height - item_button_height *2
		
		ui_draw_rectangle(list_x, list_y + sprite_get_height(s_Items) * sprite_scale, sprite_get_width(s_Items) * sprite_scale, height, button_color, 1, false)
		
		
		var craft_mode_button = ui_draw_button_sprite(s_Icons, 0, list_x, list_y + sprite_space + pad + height, sprite_space, item_button_height, button_color, button_s_color, c_white, 0.5, false)
		if(craft_mode_button[0])
		{
			selected_mode = 0	
		}
		
		
		var info_button = ui_draw_button_sprite(s_Icons, 3, list_x, list_y + sprite_space + pad + height + item_button_height + pad, sprite_space, item_button_height, button_color, button_s_color, c_white, 0.5, false)
		if(info_button[0])
		{
			selected_mode = 1		
		}
		
		if(!selected_mode)
		{
			
			//CRAFT
			var craft_check = true;

			for(var i = 0; i < array_length_1d(selected_list[|selected_item][1]); i++)
			{
				var check = o_PlayerInventory.check_item(selected_list[|selected_item][1][i].iid, selected_list[|selected_item][1][i].mat * craft_amount)

				if(!check) 
				{
					craft_check = false 
					break;	
				}
			}

			var items_needed = array_create()

			for(var i = 0; i < array_length_1d(selected_list[|selected_item][1]); i++)
			{
				items_needed[i] = 
				{
					uid : selected_list[|selected_item][1][i].iid,
					amt : selected_list[|selected_item][1][i].mat * craft_amount
				}
			}

			var craft_button = ui_draw_button_color("Craft", list_x + sprite_space + pad, list_y + sprite_space + pad + height + item_button_height + pad, inv_width - item_button_width - (sprite_get_width(s_Items) * sprite_scale) - pad * 4, item_button_height, button_color, button_s_color, c_white, false)

			if(craft_button[0])
			{
				if(craft_check)
				{
					ds_list_add(queue_list, {uid : selected_list[|selected_item][0], amount: selected_list[|selected_item][2] * craft_amount, timer: 5})

					for(var i = 0; i < array_length_1d(items_needed); i++)
					{
						o_PlayerInventory.remove_item(items_needed[i].uid, items_needed[i].amt)
					}
				}
			}

			var arrow_width = (inv_width - item_button_width - (sprite_get_width(s_Items) * sprite_scale) - pad * 4) / 6

			var ar_x = list_x + sprite_space + pad
			var ar_y = list_y + sprite_space + pad + height
		
			var counter_width = arrow_width * 6 - (arrow_width + pad) * 4
		
		
			//Small left
			var arrow_button = ui_draw_button_sprite(s_Icons, 4, ar_x, ar_y, arrow_width, item_button_height, button_color, button_s_color, c_white, -0.3, false)
			if(arrow_button[0])
			{
				craft_amount--
			}
		
			ar_x += arrow_width + pad
		
			//Small right
			var arrow_button = ui_draw_button_sprite(s_Icons, 4, ar_x, ar_y, arrow_width, item_button_height, button_color, button_s_color, c_white, 0.3, false)
			if(arrow_button[0])
			{
				craft_amount++	
			}
		
			ar_x += arrow_width + pad
		
			//Big left
			var arrow_button = ui_draw_button_sprite(s_Icons, 5, ar_x, ar_y, arrow_width, item_button_height, button_color, button_s_color, c_white, -0.3, false)
			if(arrow_button[0])
			{
				craft_amount -= 10	
			}
		
			ar_x += arrow_width + pad
		
			//Big right
			var arrow_button = ui_draw_button_sprite(s_Icons, 5, ar_x, ar_y, arrow_width, item_button_height, button_color, button_s_color, c_white, 0.3, false)
			if(arrow_button[0])
			{
				craft_amount += 10	
			}
		
			if(craft_amount <= 0) craft_amount = 1
		
			ar_x += arrow_width + pad
		
			//Counter
			ui_draw_title(craft_amount, ar_x, ar_y, counter_width, item_button_height, button_color, c_white, false)
		}
		
		var selected_item_list = o_InventoryBase.items_list[selected_list[|selected_item][0]]

		draw_sprite_ext(s_Items, selected_item_list.spr_index, list_x, list_y, sprite_scale, sprite_scale, 0, c_white, 1)
		
		var item_display = selected_item_list.name

		if(selected_list[|selected_item][2] * craft_amount > 1)
		{
			item_display = string(selected_item_list.name) + " x" + string(selected_list[|selected_item][2]  * craft_amount)
		}

		list_x += sprite_get_width(s_Items) * sprite_scale + pad

		ui_draw_title(item_display, list_x, list_y, inv_width - item_button_width - (sprite_get_width(s_Items) * sprite_scale) - pad * 4, item_button_height, button_color, c_white, false)
		//selected_item_list.name

		list_y += item_button_height + pad
	
		//description
		if(selected_mode)
		{
			var description = "This is a " + string_lower(string(selected_item_list.name)) + "."

			if(variable_struct_exists(selected_item_list, "description"))
			{
				description = selected_item_list.description
			}

			box_width = inv_width - (pad * 4) - sprite_space - item_button_width
			box_height = string_height(description)
			
			start_x += pad
			
			draw_text_ext(list_x, list_y, description, box_height, box_width - pad)
		}
	
		//prints out requimrents changes color if not have
		for(var i = 0; i < array_length_1d(selected_list[|selected_item][1]); i++)
		{
			var check = o_PlayerInventory.check_item(selected_list[|selected_item][1][i].iid, selected_list[|selected_item][1][i].mat * craft_amount)	
			var prev_scale = 2

			if(!selected_mode)
			{
				var highlight_color = check ? c_white : 0x6357d9
				
				draw_set_color(highlight_color)
				ui_draw_string(list_x, list_y, string(selected_list[|selected_item][1][i].mat * craft_amount) + "x " + string(o_InventoryBase.items_list[selected_list[|selected_item][1][i].iid].name), ft_Default)
					
				draw_sprite_ext(
				s_Items, o_InventoryBase.items_list[selected_list[|selected_item][1][i].iid].spr_index, 
				list_x + string_width(string(selected_list[|selected_item][1][i].mat * craft_amount) + "x " + o_InventoryBase.items_list[selected_list[|selected_item][1][i].iid].name) + pad, 
				list_y - sprite_get_height(s_Items) * prev_scale / 10,
				prev_scale,
				prev_scale,
				0,
				highlight_color,
				1
				)
			}
			
			list_y += string_height("1") + pad
		}
	}
	
	//crafting queue
	que_scale = 75
	que_sprite_scale = 3

	var que_x = display_get_gui_width() / 2 - inv_width / 2 - que_scale - pad
	var que_y = display_get_gui_height() - inv_height - title_height - que_scale - pad
	
	counter++

	for(var i = 0; i < ds_list_size(queue_list); i++)
	{
		var que_button = ui_draw_button_sprite(s_Items, queue_list[|i].uid, que_x, que_y - (que_scale + pad) * i, que_scale, que_scale, menu_color, button_color, c_white, que_sprite_scale, false)
		
		ui_draw_string(que_x, que_y - (que_scale + pad) * i, "0:0" + string(queue_list[|i].timer), ft_Default)

		var amount = queue_list[|i].amount

		ui_draw_string(que_x + que_scale - string_width("x" + string(amount)), que_y + que_scale - string_height(amount), "x" + string(amount), ft_Default)
		
		if(counter > 60)
		{
			 queue_list[|i].timer--
			 counter = 0
			 
			 if(queue_list[|i].timer <= 0)
			 {
				o_PlayerInventory.add_item(queue_list[|i].uid, queue_list[|i].amount)
				ds_list_delete(queue_list, i)
			 }
		}	
	}

	//var buttons_x = display_get_gui_width() / 2 - inv_width / 2
	//var buttons_y = display_get_gui_height() - inv_height - craft_height - title_height - pad
}


if(global.current_gui == gui.PROFILE)
{
	var prof_width = inv_width * 2
	var prof_height = window_height + inv_width_slots_only
	
	//MAIN UI
	var start_x = display_get_gui_width() / 2 - prof_width / 2
	var start_y = display_get_gui_height() - inv_height - window_height - pad

	ui_draw_window("PROFILE", start_x, start_y, prof_width, prof_height)
}

if(global.current_gui == gui.CRAFTING)
{
	var journal_width = 600

	draw_set_font(ft_Title)
	
	//MAIN UI
	var map_height = window_height + inv_width_slots_only
	
	var start_x = display_get_gui_width() / 2 - journal_width / 2
	var start_y = display_get_gui_height() - inv_height - window_height - pad

	var window = ui_draw_window("JOURNAL", start_x, start_y, journal_width, map_height)
	
	start_x += pad
	start_y += pad

	var info_width = 250
	var info_height = 35

	for(var i = 0; i < ds_list_size(info_list); i++)
	{
		var color = button_color
		
		if(info_selected = i) color = button_s_color
		
		var button = ui_draw_button_color(info_list[|i].name, start_x, start_y + (info_height + pad) * i, info_width, info_height, color, button_s_color, c_white, false)
		if(button[0])
		{
			info_selected = i	
		}
	}
	
	start_x += pad + info_width
	
	var title_width = journal_width - (pad * 3) - info_width
	
	ui_draw_title(info_list[|info_selected].name, start_x, start_y, title_width, info_height, menu_color, c_white, false)
	
	start_y += pad + info_height
	
	text = info_list[|info_selected].description

	box_width = title_width
	box_height = string_height(text)
	
	start_x += pad
	
	draw_text_ext(start_x, start_y, text, box_height, box_width - pad)

	//draw_text_

	//world_draw = 384
	
	//ui_draw_rectangle(start_x, start_y, world_draw, world_draw, grass_color, 1, true)
	
	//for(var i = 0; i < world; i++)
	//{
		//for(var j = 0; j < world; j++)
		//{	
			//if(!position_empty(i * tiles, j * tiles))
			//{
				//map[i,j] = 1	
			//}
		//}
	//}
	
	//for(var i = 0; i < world; i++)
	//{
		//for(var j = 0; j < world; j++)
		//{
			//if(map[i,j] == 1)
			//{
				//ui_draw_rectangle(start_x + (i * world_draw / world), start_y + (j * world_draw / world), world_draw / world, world_draw / world, object_color, 1, true)
			//}
		//}
	//}
}
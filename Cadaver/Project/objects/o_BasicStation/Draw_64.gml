if(global.open_instance == id)
{
	ui_draw_rectangle(dx, dy, dw, dh, main_color, 1, false)
	
	window_text(dx, dy, "CRAFTING")
	
	list_panel = make_panel(dx + pad, dy + pad)

	//draw category buttons
	var catw = (dw - (pad * 5)) / 4
	var cath = 60
	
	for(var i = 0; i < ds_list_size(categories); i++)
	{
		var color = button_color
		
		if(selected_list == i) color = button_s_color
		
		var button = ui_draw_button_color(categories[|i], list_panel.at_x + (catw + pad) * i, list_panel.at_y, catw, cath, color, button_s_color, text_color, false)	
		if(button[0])
		{
			//buton clicked
			selected_list = i
			selected_item = -1
		}
	}
	
	pn_row(list_panel, cath + pad)
	
	//draw selected recipe list
	for(var i = 0; i < ds_list_size(global.recipes[selected_list]); i++)
	{
		var button_amt = 6
		var cel_size = (dw - (pad * (button_amt + 1))) / button_amt
		var item = global.recipes[selected_list][|i].item
		
		var color = c_gray
		
		if(selected_item == i) color = c_ltgray
		
		var button = ui_draw_button_sprite(s_Items, item, list_panel.at_x, list_panel.at_y, cel_size, cel_size, color, c_ltgray, c_white, 3, false, true)
		if(button[0])
		{
			selected_item = i
		}
		
		list_panel.at_x += cel_size + pad
		
		if(list_panel.at_x > (list_panel.start_x + dw - cel_size - pad))
		{
			pn_row(list_panel, cel_size + pad)	
		}
	}
	
	//draw selected item data
	if(selected_item != -1)
	{
		if(dx > lerp_x / 2)
		{
			var sx = start_x + dw / 2 + pad
			var sy = dy
		
			ui_draw_rectangle(sx, sy, dw, dh, main_color, 1, false)
			
			sel_panel = make_panel(sx + pad, sy + pad)
			
			var item = global.recipes[selected_list][|selected_item].item
			var req = global.recipes[selected_list][|selected_item].req_arr
			craft_amount = global.recipes[selected_list][|selected_item].craft_amt
			var item_name = global.items_list[item].name
			var desc = global.items_list[item].item_data.description
			
			ui_draw_button_sprite(s_Items, item, sel_panel.at_x, sel_panel.at_y, 60, 60, tab_color, tab_color, c_white, 3, false, true)
			
			pn_col(sel_panel, 60 + pad)
			
			var tw = dw - 60 - (pad * 3)
			
			ui_draw_title(item_name, sel_panel.at_x, sel_panel.at_y, tw, 60, tab_color, text_color, 1)
			
			pn_row(sel_panel, 60 + pad)
			
			draw_set_font(ft_Description)
			draw_set_color(tab_color)
			draw_text_ext(sel_panel.at_x, sel_panel.at_y, desc, string_height(desc), dw - (pad * 2))
			
			var gap = 80
			
			pn_row(sel_panel, gap)

			var max_rec = 4
			
			for(var i = 0; i < max_rec; i++)
			{
				var w = dw - (pad * 2)
				var h = 35
				
				var bord = true
				
				if(i < array_length_1d(req))
				{
					bord = false
				}
				
				ui_draw_rectangle(sel_panel.at_x, sel_panel.at_y + (h + pad) * i, w, h, tab_color, 1, bord)
			}
			
			//draw out the items needed
			var craft = true
			
			for(var i = 0; i < array_length_1d(req); i++)
			{
				var req_item = req[i].item	
				var req_amt = req[i].amt
					
				var text_height = string_height_font("A", ft_Description)
				var offset = h / 2 - text_height / 2
					
				var color = decline_s_color
				var item_amt = get_item_amount(o_PlayerInventory.inv, o_PlayerInventory.inv_data, req_item)
				
				if(item_amt >= req_amt)
				{
					color = confirm_color
				}
				else
				{
					craft = false	
				}
				
				draw_set_color(color)
				var str = global.items_list[req_item].name + " (" + string(item_amt) + "/" + string(req_amt) + ")"
				ui_draw_string(sel_panel.at_x + offset, sel_panel.at_y + offset + (h + pad) * i, str, ft_Description)
			}
			
			var ht = (h + pad) * max_rec
			pn_row(sel_panel, ht + 45)
			
			if(craft)
			{
				var c = ui_draw_button_color("Craft", sel_panel.at_x, sel_panel.at_y, 150, 40, confirm_color, confirm_s_color, c_white, false)
				if(c[0])
				{
					add_item(o_PlayerInventory.inv, o_PlayerInventory.inv_data, item, craft_amount)	
							
					//remove req items
					for(var i = 0; i < array_length_1d(req); i++)
					{
						var req_item = req[i].item	
						var req_amt = req[i].amt
						remove_item(o_PlayerInventory.inv, o_PlayerInventory.inv_data, req_item, req_amt)
					}
				}
			}
			else
			{
				ui_draw_title("Craft", sel_panel.at_x, sel_panel.at_y, 150, 40, tab_color, tab_color, true)	
			}
		}		
	}
}
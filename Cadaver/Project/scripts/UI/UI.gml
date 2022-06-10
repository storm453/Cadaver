function ui_draw_button_color(txt, sx, sy, w, h, c, hov_c, txt_c, brd)
{	
	var mx = device_mouse_x_to_gui(0)
	var my = device_mouse_y_to_gui(0)
	
	var click = false
	
	draw_set_color(c)
	draw_rectangle(sx, sy, sx + w, sy + h, brd)
	
	if(point_in_rectangle(mx, my, sx, sy, sx + w, sy + h))
	{
		draw_set_color(hov_c)
		draw_rectangle(sx, sy, sx + w, sy + h, brd)
		
		if(mouse_check_button_pressed(mb_left))
		{
			click = true		
		}
		else
		{
			click = false	
		}
	}
	
	draw_set_color(txt_c)
	draw_text(sx + (w / 2) - (string_width(txt) / 2), sy + (h / 2) - (string_height(txt) / 2), txt)
	
	draw_set_color(c_white)
	
	var return_data = array(click, w, h)
	return return_data
}

function window_text(arg_x, arg_y, arg_text, arg_font = ft_Default)
{
	var inv_text = arg_text
	var inv_text_height = string_height_font(inv_text, arg_font)

	arg_y -= pad + inv_text_height

	draw_set_color(text_color)
	ui_draw_string(arg_x, arg_y, inv_text, arg_font)
	draw_set_color(c_white)
	draw_set_alpha(1)
}

function rm_draw_button_color(sx, sy, w, h, c, hov_c, txt_c, brd)
{	
	var mx = mouse_x
	var my = mouse_y
	
	var click = false
	
	draw_set_color(c)
	draw_rectangle(sx, sy, sx + w, sy + h, brd)
	
	if(point_in_rectangle(mx, my, sx, sy, sx + w, sy + h))
	{
		draw_set_color(hov_c)
		draw_rectangle(sx, sy, sx + w, sy + h, brd)
		
		if(mouse_check_button_pressed(mb_left))
		{
			click = true		
		}
		else
		{
			click = false	
		}
	}
	
	var return_data = array(click, w, h)
	return return_data
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

function ui_draw_button_color_manual(sel, sx, sy, w, h, c, hov_c, brd)
{	
	draw_set_color(c)
	draw_rectangle(sx, sy, sx + w, sy + h, brd)
	
	if(sel)
	{
		draw_set_color(hov_c)
		draw_rectangle(sx, sy, sx + w, sy + h, brd)
	}

	draw_set_color(c_white)
	
	var return_data = array(w, h)
	return return_data
}

function make_panel(xx, yy)
{
	return { start_x : xx, start_y : yy, at_x : xx, at_y : yy }	
}

function pn_row(panel, row_height)
{
	panel.at_x =  panel.start_x
	panel.at_y += row_height
}

function pn_col(panel, col_width)
{
	panel.at_x += col_width	
}

function ui_draw_button_sprite(spr, spr_sub, sx, sy, w, h, c, hov_c, spr_c, spr_s, brd, mid = false)
{	
	var mx = device_mouse_x_to_gui(0)
	var my = device_mouse_y_to_gui(0)
	
	var click = false
	
	draw_set_color(c)
	draw_rectangle(sx, sy, sx + w, sy + h, brd)
	
	if(point_in_rectangle(mx, my, sx, sy, sx + w, sy + h))
	{
		draw_set_color(hov_c)
		draw_rectangle(sx, sy, sx + w, sy + h, brd)
		
		if(mouse_check_button_pressed(mb_left))
		{
			click = true		
		}
		else
		{
			click = false	
		}
	}
	
	var offset = 0
	
	if(mid == true)
	{
		offset = sprite_get_width(spr) * spr_s / 2	
	}
	
	draw_sprite_ext(spr, spr_sub, sx + w / 2 - (sprite_get_width(spr) * spr_s / 2) + offset, sy + h / 2 - (sprite_get_width(spr) * spr_s / 2) + offset, spr_s, spr_s, 0, spr_c, 1)
	
	draw_set_color(c_white)
	
	var return_data = array(click, w, h)
	return return_data
}

function ui_draw_title(txt, sx, sy, w, h, c, txt_c, brd)
{	
	draw_set_color(c)
	draw_rectangle(sx, sy, sx + w, sy + h, brd)
	
	draw_set_color(txt_c)
	draw_text(sx + (w / 2) - (string_width(txt) / 2), sy + (h / 2) - (string_height(txt) / 2), txt)
	
	draw_set_color(c_white)
	
	var return_data = array(w, h)
	return return_data
}

function ui_draw_rectangle(sx, sy, w, h, c, a, brd)
{	
	draw_set_color(c)
	draw_set_alpha(a)
	draw_rectangle(sx, sy, sx + w - 1, sy + h - 1, brd)
	draw_set_alpha(1)
	draw_set_color(c_white)

	var return_data = array(w, h)
	return return_data
}

function ui_draw_string(sx, sy, t, fnt)
{
	draw_set_font(fnt)
	draw_text(sx, sy, t)	
	draw_set_font(ft_Default)
	
	return string_height_font(t, fnt)
}

function string_height_font(str, fnt)
{
	draw_set_font(fnt)
	return string_height(str)
	draw_set_font(ft_Default)
}

function queue_count(list, inv, inv_data)
{
	counter++

	if(counter > 60)
	{
		counter = 0
		
		if(ds_list_size(list) > 0)
		{
			list[|0].timer--
		
			if(list[|0].timer <= 0)
			{
				add_item(inv, inv_data, list[|0].uid, list[|0].amt)
				ds_list_delete(list, 0)
			}
		}
	}
}

function text_gap(panel, txt)
{
	draw_set_color(text_color)
	ui_draw_string(panel.at_x, panel.at_y, txt, ft_Default)
	pn_row(panel, string_height_font(txt, ft_Default) + pad)
}
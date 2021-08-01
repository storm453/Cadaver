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

function ui_draw_button_sprite(spr, spr_sub, sx, sy, w, h, c, hov_c, spr_c, spr_s, brd)
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
	
	draw_sprite_ext(spr, spr_sub, sx + w / 2 - (sprite_get_width(spr) * spr_s / 2), sy + h / 2 - (sprite_get_width(spr) * spr_s / 2), spr_s, spr_s, 0, spr_c, 1)
	
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
}

function string_height_font(str, fnt)
{
	draw_set_font(fnt)
	return string_height(str)
	draw_set_font(ft_Default)
}
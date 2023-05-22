var _inv_marg_x = 40
var _inv_marg_y = inv_marg_y

var _slot_size = slot_size * global.res_fix
var _slot_pad = slot_pad * global.res_fix

var _inv_width = (_slot_size * inv_sx) + (_slot_pad * (inv_sx - 1)) * global.res_fix

inv_x = display_get_gui_width() / 2 - (_inv_width) - (slot_margin * global.res_fix)
inv_y = _inv_marg_y

var ok_gui = false

for(var i = 0; i < ds_list_size(show_list); i++)
{
	if(global.current_gui = show_list[|i]) ok_gui = true
}

hover_slot = vec2(-1, -1)

if(ok_gui)
{
	//draw inventory
	for(var i = 0; i < inv_sx; i++)
	{
		for(var j = 0; j < inv_sy - 1; j++)
		{
			var _slot_x = inv_x + (i * (_slot_size + _slot_pad))
			var _slot_y = inv_y + (j * (_slot_size + _slot_pad))
			
			do_slot(_slot_x, _slot_y, _slot_size, i, j)
		}
	}
	for(var i = 0; i < inv_sx; i++)
	{
		var _slot_x = inv_x + (i * (_slot_size + _slot_pad))
		var _slot_y = inv_y + ((inv_sy - 0.5) * (_slot_size + _slot_pad))
		
		do_slot(_slot_x, _slot_y, _slot_size, i, j)
	}
	
	inv_x = display_get_gui_width() / 2 + (slot_margin * global.res_fix)

	if(hover_slot.x != -1)
	{
		if(inv[hover_slot.x, hover_slot.y] != 0)
		{
			if(global.current_gui == gui.INVENTORY)
			{
				var _hover_item = inv[hover_slot.x, hover_slot.y].item
				var _hover_item_name = global.items_list[_hover_item].name
				var _hover_item_amount = inv[hover_slot.x, hover_slot.y].amt
				var _hover_item_name_height = string_height_font(_hover_item_name, ft_CurrentUI) * global.res_fix
				var _hover_item_description = global.items_list[_hover_item].item_data.description
			
				draw_set_color(c_white)
				draw_set_alpha(1)
			
				draw_set_font(ft_CurrentUI)
				draw_text(inv_x, inv_y, _hover_item_name)
			
				draw_set_halign(fa_right)
				draw_text(inv_x + _inv_width, inv_y, string(_hover_item_amount) + "x")
				draw_set_halign(fa_left)
			
				var _hover_item_line_width = 2
			
				inv_y += _hover_item_name_height

				draw_line_width(inv_x, inv_y, inv_x + _inv_width, inv_y, _hover_item_line_width)
			
				inv_x += pad
				inv_y += _hover_item_line_width + pad
			
				var _hover_icon_scale = 10 * global.res_fix
				var _hover_icon_space = sprite_get_width(s_Items) * _hover_icon_scale
			
				draw_sprite_ext(s_Items, _hover_item, inv_x, inv_y, _hover_icon_scale, _hover_icon_scale, 0, c_white, 1)
			
				inv_x += _hover_icon_space + pad
			
				var _desc_box_width = _inv_width - (pad * 3) - _hover_icon_space
				var _desc_box_height = _hover_icon_space
			
				ui_draw_rectangle(inv_x, inv_y, make_rectangle(_desc_box_width, _desc_box_height, c_black, 1, false, s_BarBack))
			
				draw_set_color(c_white)
				draw_set_alpha(1)
				draw_set_font(ft_Description)
			
				draw_text_ext(inv_x + pad, inv_y + pad, _hover_item_description, pad + string_height_font("A", ft_Description), _desc_box_width - (pad * 2))
			}
		}
	}
}
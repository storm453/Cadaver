if(global.db_enemy)
{
	var _ui = room_to_gui(x, y)	

	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	
	draw_text_outline(_ui.x, _ui.y - 40, c_black, c_lime, bird_state.names[state], ft_24)
	
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	
	var _target = loiter_target
	
	if(state == bird_state.to_tree)
	{
		_target = to_tree_target	
	}
	
	var _ui_loiter = room_to_gui(_target.x, _target.y)
	
	draw_set_color(c_lime)
	draw_set_alpha(1)
	draw_line(_ui.x, _ui.y, _ui_loiter.x, _ui_loiter.y)
}
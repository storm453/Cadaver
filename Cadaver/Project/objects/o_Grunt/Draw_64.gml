if(global.db_enemy)
{
	var ui = room_to_gui(x, y - sprite_height / 2)
	
	draw_set_halign(fa_center)
	draw_text_outline(ui.x, ui.y, c_black, c_lime, grunt_state.names[state], ft_24);
	
	var ui  = room_to_gui(x, y - sprite_height / 2 - 20)
	draw_text_outline(ui.x, ui.y, c_black, c_aqua, grunt_state.names[state_timer_next], ft_24);
	draw_set_halign(fa_left)
}
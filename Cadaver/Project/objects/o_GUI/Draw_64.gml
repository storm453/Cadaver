var _highest = 30000

//for(var i = 0; i < array_length(history); i++)
//{
//	if(history[i] > _highest)
//	{
//		_highest = history[i]	
//	}
//}

for(var i = 0; i < array_length(history); i++)
{
	var j = i + history_head
	
	j %= array_length(history)
	
	draw_set_color(make_color_rgb(clamp(history[j], 0, _highest) / _highest * 255, 255 - clamp(history[j], 0, _highest) / _highest * 255, 0))
	draw_rectangle(i * global.res_fix, display_get_gui_height() * global.res_fix, (i + 1) * global.res_fix, (display_get_gui_height() - 400 * history[j] / _highest) * global.res_fix, false)
}
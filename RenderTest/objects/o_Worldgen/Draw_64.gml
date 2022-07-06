for(var i = 0; i < ds_list_size(global.map.keys); i++)
{
	draw_text(10, 10 + (i * 15), global.map.keys[|i])
	draw_text(500, 10 + (i * 15), global.map.values[|i])
}
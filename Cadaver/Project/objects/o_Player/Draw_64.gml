if(distance_to_object(current_multi) <= interact_range)
{
	//we're close enough to a multiblock
}
	
draw_sprite_ext(s_Hurt, 0, 0, 0, global.res_fix, global.res_fix, 0, c_white, hit_alpha)

hit_alpha -= get_delta_time()

var _animals = 0

for(var i = 0; i < instance_number(o_WorldParent); i++)
{
	var _current_parent = instance_find(o_WorldParent, i)
	
	if(_current_parent.is_animal)
	{
		_animals++	
	}
}

draw_set_font(ft_24)
draw_set_color(c_black)
draw_set_alpha(1)
if(global.db_chunk) draw_text(10, 200, "Animals: " + string(_animals))
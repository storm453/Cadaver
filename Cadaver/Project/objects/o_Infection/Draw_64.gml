var _dohrnii = 0

for(var i = 0; i < instance_number(o_WorldParent); i++)
{
	var _current_parent = instance_find(o_WorldParent, i)
	
	if(_current_parent.is_parasite)
	{
		_dohrnii++	
	}
}

draw_set_font(ft_24)
draw_set_color(c_black)
draw_set_alpha(1)
//draw_text(10, 400, "Dohrnii: " + string(_dohrnii))
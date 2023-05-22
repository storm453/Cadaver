var _animals_list = ds_list_create()
		
collision_rectangle_list(x, y, x + chunk_size, y + chunk_size, o_WorldParent, false, true, _animals_list, false)
		
var _animals = 0
		
for(var i = 0; i < ds_list_size(_animals_list); i++)
{
	if(_animals_list[|i].is_animal)
	{
		_animals++	
	}
}

if(_animals < 2)
{
	var _animal_x = x + random(chunk_size)
	var _animal_y = y + random(chunk_size)
	
	var _cam_x = o_Camera.x - (o_Camera.x_size * o_Camera.zoom) / 2
	var _cam_y = o_Camera.y - (o_Camera.y_size * o_Camera.zoom) / 2
	
	if(!point_in_rectangle(_animal_x, _animal_y, _cam_x, _cam_y, _cam_x + (o_Camera.x_size * o_Camera.zoom), _cam_y + (o_Camera.y_size * o_Camera.zoom)))
	{
		if(chance(0.002)) instance_create_layer(_animal_x, _animal_y, "World", choose(o_Bird, o_Dog, o_Grunt))
	}
}

ds_list_destroy(_animals_list)
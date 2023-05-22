if(auto_z) z = -bbox_bottom

if(damagable)
{
	if(hp <= 0)
	{
		instance_destroy()	
	}
}

if(is_animal)
{
	var _distance = (o_Camera.x_size * o_Camera.zoom) * 2
	var _player = distance_to_object(o_Player)
	
	if(_player >= _distance)
	{
		instance_destroy()	
	}
}
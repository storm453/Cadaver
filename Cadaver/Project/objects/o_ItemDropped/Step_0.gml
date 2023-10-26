event_inherited()

//fake 3d

if(zz > 0)
{
	x += spd * dx * 60 *  get_delta_time()
	my += spd * dy * 60 *  get_delta_time()

	y = my - ((zz * 60) * get_delta_time())
	zz += vz * 60 *  get_delta_time()
	vz += grav * 60 *  get_delta_time()
}

if(zz < 0)
{
	spd = 0
	vz = 0
	zz = 0
}

if(data != 0)
{
	image_index = data.item
}

if(up)
{
	image_xscale -= 0.1	
	image_yscale -= 0.1	
	
	if(image_xscale <= 0) instance_destroy()
}
else
{
	//scaling
	image_xscale = (5 / (5 - zz / 5) / 3) * 2
	image_yscale = (5 / (5 - zz / 5) / 3) * 2
}

//move toward player

var _player_distance = distance_to_object(o_Player)

if(_player_distance < 100)
{
	var _player = move_towards(o_Player)

	velocity.x += (_player.x * hover_speed - velocity.x) * acc * get_delta_time()
	velocity.y += (_player.y * hover_speed - velocity.y) * acc * get_delta_time()
	
	if(_player_distance < 1)
	{
		instance_destroy()
	}
}
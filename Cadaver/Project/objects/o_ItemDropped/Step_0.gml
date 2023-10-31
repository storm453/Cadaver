event_inherited()

//fake 3d

if(anim_timer < 1)
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

anim_timer += get_delta_time()

if(anim_timer > 1)
{
	var _player_y = o_Player.y - sprite_get_height(s_Player) / 2
	
	var _player_distance = distance_to_point(o_Player.x, _player_y)
	
	if(_player_distance < 100)
	{
		var _player = move_towards_points(o_Player.x, _player_y, 1)
		
		velocity.x += (_player.x * hover_speed - velocity.x) * acc * get_delta_time()
		velocity.y += (_player.y * hover_speed - velocity.y) * acc * get_delta_time()
	
		if(_player_distance < 5)
		{
			//give player item and destroy drop
			instance_destroy()
			
			add_item(o_PlayerInventory.inv, data.item, 1)
		}
	}
	else
	{
		//slow down item a ton	
		delta_dampen(velocity, 0.9)
	}
}
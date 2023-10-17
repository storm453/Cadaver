event_inherited()

//fake 3d

x += spd * dx * 60 *  get_delta_time()
my += spd * dy * 60 *  get_delta_time()

y = my - zz * 60 * get_delta_time()
zz += vz * 60 *  get_delta_time()
vz += grav * 60 *  get_delta_time()

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

var _player = move_towards(o_Player)

x += _player.x
y += _player.y
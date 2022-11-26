function create_collision(x_size = 16, y_size = 16)
{
	var _col = instance_create_layer(x, y, "World", o_Collision)
	
	_col.image_xscale = x_size
	_col.image_yscale = y_size
	
	return _col
}

collision = create_collision()
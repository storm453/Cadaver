function swing()
{
	var swing = instance_create_layer(x, y,  "Instances", o_Swing)
	swing.image_angle = point_direction(x, y - 10, mouse_x, mouse_y)	
}
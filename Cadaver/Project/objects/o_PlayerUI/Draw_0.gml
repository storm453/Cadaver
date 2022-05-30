//draw blueprint in phsyical world
if(selected_bp != noone)
{
	var sprite = object_get_sprite(selected_bp)
	
	var sw = sprite_get_width(sprite)
	var sh = sprite_get_height(sprite)
	
	var ox = 16 * floor(mouse_x / 16)
	var oy = 16 * floor(mouse_y / 16)
		
	var collision = collision_rectangle(ox, oy, ox + sw, oy + sh, all, false, true)
	
	var color = c_red
	
	if(collision == noone)
	{
		color = c_white
		
		if(mouse_check_button_pressed(mb_left))
		{
			instance_create_layer(ox, oy, "World", selected_bp)
			
			selected_bp = noone
		}
	}
	
	draw_sprite_ext(sprite, 0, ox, oy, 1, 1, 0, color, 0.5)
}
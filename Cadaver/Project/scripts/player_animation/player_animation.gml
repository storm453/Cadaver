function player_animation() 
{
	sprite_index = sprites_array[state]

	//exceptions go here!
	if(global.hotbar_sel_item != 0) sprite_index = s_PlayerAttack

	//in water
	var near_x = floor(o_Player.x / chunk_size) * chunk_size
	var near_y = floor(o_Player.y / chunk_size) * chunk_size

	var chunk = instance_nearest(near_x, near_y, o_Chunk)
	
	var block = chunk.grid[# floor((x - chunk.x) / tile_size), floor((y - chunk.y) / tile_size)]
	
	if(block == tile.water)
	{
		sprite_index = s_PlayerSwim
	}
	
	//image_xscale and sacaling
	var sign_mouse = sign(mouse_x - x)

	if(sign_mouse == 0) 
	{
		sign_mouse = 1
	}

    if(in_x != 0 && sign(in_x) != sign_mouse) 
	{
		image_speed = -1
	}
	else {
		image_speed = 1
	}
	
	if(sign_mouse != 0)
	{
		image_xscale = sign_mouse;	
	}
}
function player_animation() 
{
	sprite_index = sprites_array[state]

	//exceptions go here!
	if(global.hotbar_sel_item != 0) sprite_index = s_PlayerAttack

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
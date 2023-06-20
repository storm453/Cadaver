event_inherited()

custom_render = true

anim_alpha = 0
anim_y = 0

particles_emitter = new advanced_part_emitter(particles, x - 8, x - 2, y - 3, y + 2, aps_shape.rectangle, aps_distr.linear);

function my_render()
{
	draw_self();
	
	var player_dis = distance_to_object(o_Player)
	
	var _key_x = x
	var _key_y = y + anim_y
		
	draw_sprite_ext(s_KeyE, 0, _key_x, _key_y, 1, 1, 0, c_white, anim_alpha)
	
	if(player_dis <= 10)
	{
		if(anim_alpha < 1) anim_alpha += 0.05
		
		if(anim_y > -18) anim_y--
		
		if(keyboard_check_pressed(ord("E")))
		{
			instance_destroy()	
			
			add_item(o_PlayerInventory.inv, items.wood, irandom_range(1,3))
		}
	}
	else
	{
		if(anim_y < 0) anim_y++
		if(anim_alpha > 0) anim_alpha -= 0.1
	}
}
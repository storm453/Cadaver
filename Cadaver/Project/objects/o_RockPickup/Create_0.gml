z = 0

anim_alpha = 0
anim_y = 0

function render()
{
	draw_self();
	
	var player_dis = distance_to_object(o_Player)
	
	if(player_dis <= 7)
	{
		if(anim_alpha < 1) anim_alpha += 0.05
		
		if(anim_y > -8) anim_y -= 0.5
		
		if(keyboard_check_pressed(ord("E")))
		{
			instance_destroy()	
			
			add_item(o_PlayerInventory.inv, items.stone, irandom_range(1,3))
		}
	}
	else
	{
		if(anim_alpha > 0) anim_alpha -= 0.2
		if(anim_y < 0) anim_y += 0.25
	}
	
	draw_sprite_ext(e_key, 0, x + 4.5, y + anim_y, 0.2, 0.2, 0, c_white, anim_alpha)	
}


ds_list_add(o_RenderManager.entities, self)
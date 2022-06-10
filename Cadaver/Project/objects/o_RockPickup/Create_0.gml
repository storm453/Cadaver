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
			
			add_item(o_PlayerInventory.inv, o_PlayerInventory.inv_data, items.stone, 1)
		}
	}
	else
	{
		if(anim_alpha > 0) anim_alpha -= 0.2
		if(anim_y < 0) anim_y += 0.25
	}
	
	draw_sprite_ext(e_key, 0, x + 4.5, y + anim_y, 0.2, 0.2, 0, c_white, anim_alpha)	
}

function render_shadow()
{
	//draw_sprite_ext(sprite_index, 0, x + sprite_width / 2, y + sprite_height / 2, 0.5, 0.8, 270, c_blue, 0.2 * (- o_GUI.day_factor / 2 + 0.5));	
	
	//draw_set_alpha(0.2 * (- o_GUI.day_factor / 2 + 0.5))
	//draw_circle_color(x + sprite_width / 2, y + sprite_height / 2, 15, c_blue, c_black, false)
}

ds_list_add(o_RenderManager.entities, self)
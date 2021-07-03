draw_self()

if(global.current_gui == 0)
{
	if(attack)
	{
		if(attack_cooldown <= 0)
		{
			gave_item = false
			attack_cooldown = attack_cooldown_set
		}
	}

	if(attack_cooldown > attack_duration)
	{
		//ui_draw_rectangle(x + sprite_get_width(s_Player) * image_xscale, y, attack_range * image_xscale, attack_range, c_red, 0.5 ,false)
		
		//NEEDS FIXING
		draw_rectangle(x + 10 * image_xscale, y, x + 10 + attack_range * image_xscale, y + attack_range, false)
		
		if(collision_rectangle(x, y, x + attack_range, y + attack_range, o_Tree01, false, true))
		{
			if(!gave_item)
			{
				gave_item = true
			
				for(var i = 0; i < array_length_1d(tree); i++)
				{
					o_PlayerInventory.add_item(tree[i].uid, tree[i].amt)
				}
			}
		}
	}
}
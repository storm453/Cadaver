function infected_attack()
{
	infected_animation()
	infected_movement()

	attacked++

	if(attacked >= attack_time) 
	{
		attacked = 0

		current_state = state.idle
	}

	var rec_x = x + 10 * image_xscale
	var rec_y = y - sprite_height

	var attack_rec = collision_rectangle(rec_x, rec_y, rec_x + attack_range * image_xscale, rec_y + attack_range, all, false, true)

	if(attack_rec != noone)
	{
		if(attack_rec.object_index == o_Player)
		{
			if(!did_damage)
			{
				did_damage = 1
	
				o_EnemyControl.points += 250
				o_Player.hp -= 10
				
				o_Player.hurt_alpha = 1
				
				current_state = state.idle
			}
		}
	}
}
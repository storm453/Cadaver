player_distance = distance_to_object(o_Player)

z = -bbox_bottom

var move_dir = v2(0)

var chase_distance = 256

var attack_distance = 12

if(enemy_data.hp <= 0) 
{
	add_item(o_PlayerInventory.inv, o_PlayerInventory.inv_data, items.infectedpiece, irandom(2))
	instance_destroy()
}

if(current_state == state.idle)
{
	animation()
	
	if(player_distance < chase_distance) current_state = state.move
}

if(current_state == state.move)
{
	animation()
	movement()
	
	if(player_distance > chase_distance) current_state = state.idle
	
	if(player_distance <= attack_distance) 
	{
		current_state = state.attack
		attack_frame = 60
	}
}

if(current_state == state.attack)
{
	animation()
	
	attack_frame--
	
	if(attack_frame <= 0) current_state = state.idle

	var rec_x = x + 10 * image_xscale
	var rec_y = y - sprite_height
	
	var attack_rec = collision_rectangle(rec_x, rec_y, rec_x + attack_range * image_xscale, rec_y + attack_range, all, false, true)

	if(attack_rec != -4)
	{
		if(attack_rec.object_index == o_Player)
		{
			var damage = 1

			if(image_xscale != o_Player.image_xscale) 
			{
				if(mouse_check_button(mb_right))
				{
					damage = 0
				}
			}
			
			if(damage) 
			{
				o_Player.hp -= 1
				
				
			}
		}
	}
}	
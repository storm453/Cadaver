player_distance = distance_to_object(o_Player)

z = -bbox_bottom

var move_dir = v2(0)

var chase_distance = 256

var attack_distance = 12

if(enemy_data.hp <= 0) 
{
	if(chance(0.5)) add_item(o_PlayerInventory.inv, o_PlayerInventory.inv_data, items.infectedpiece, irandom_range(1,3))
	if(chance(0.8)) add_item(o_PlayerInventory.inv, o_PlayerInventory.inv_data, items.cloth, irandom_range(1,2))
	
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
		current_state = state.charging
	}
}

if(current_state == state.charging)
{
	animation()
	movement(0)

	charged++

	if(charged >= 60)
	{
		show_debug_message("attack!")
		current_state = state.attack

		charged = 0
	}
}

if(current_state == state.attack)
{
	animation()
	movement()

	attacked++

	if(attacked >= attack_time) 
	{
		attacked = 0

		current_state = state.idle
	}

	var rec_x = x + 10 * image_xscale
	var rec_y = y - sprite_height

	var attack_rec = collision_rectangle(rec_x, rec_y, rec_x + attack_range * image_xscale, rec_y + attack_range, all, false, true)

	if(attack_rec != -4)
	{
		if(attack_rec.object_index == o_Player)
		{
			if(!did_damage)
			{
				did_damage = 1
	
				o_EnemyControl.points += 250
				o_Player.hp -= 10
			}
		}
	}
}
else
{
	did_damage = 0
}

// if(current_state == state.attack)
// {
// 	animation()
	
// 	attack_frame--
	
// 	if(attack_frame <= 0) current_state = state.idle

// 	var rec_x = x + 10 * image_xscale
// 	var rec_y = y - sprite_height
	
// 	var attack_rec = collision_rectangle(rec_x, rec_y, rec_x + attack_range * image_xscale, rec_y + attack_range, all, false, true)

// 	if(attack_rec != -4)
// 	{
// 		if(attack_rec.object_index == o_Player)
// 		{
// 			var damage = 1

// 			if(image_xscale != o_Player.image_xscale) 
// 			{
// 				if(mouse_check_button(mb_right))
// 				{
// 					damage = 0
// 				}
// 			}
			
// 			if(damage) 
// 			{
// 				o_Player.hp -= 1
				
// 				o_EnemyControl.points += 10
// 			}
// 		}
// 	}
// }	
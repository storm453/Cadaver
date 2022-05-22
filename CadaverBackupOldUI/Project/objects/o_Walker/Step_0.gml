player_distance = distance_to_object(o_Player)

z = -bbox_bottom

var move_dir = v2(0)

var chase_distance = 256

if(enemy_data.hp <= 0) 
{
	add_item(o_PlayerInventory.inv, o_PlayerInventory.inv_data, items.infectedpiece, irandom_range(3,8))
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
}

if(player_distance <= 7)
{
	if(attack_cooldown <= 0)
	{
		attack_cooldown = 120
		
		o_Player.hp -= 25 + (1 - ((enemy_data.hp + 50) / 100 ) * 18 )
	}
}

attack_cooldown--
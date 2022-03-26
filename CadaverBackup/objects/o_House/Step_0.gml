event_inherited();

if(distance_to_point(o_Player.x, o_Player.y) < 50)
{
	new_alpha = 0	
}
else
{
	new_alpha = 1	
}

alpha = lerp(alpha, new_alpha, 0.1)
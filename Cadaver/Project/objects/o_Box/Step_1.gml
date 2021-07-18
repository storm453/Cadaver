var distance = distance_to_object(o_Player)

if(distance < 10)
{
	if(keyboard_check_pressed(ord("E")))
	{
		open = true	
	}
}

if(distance > 10) open = false
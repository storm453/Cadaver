if(points >= points_needed[level + 1])
{
	level++
}

switch(level)
{
	case(0):
	
		//level one
		if(chance(0.0005))
		{
			if(spawn_timer >= spawn_set)
			{
				spawn_timer = 0
			
				repeat( irandom_range(1, 2) )
				{
					spawn_enemy(150, 500, o_Infected)	
				}
			}
		}
		
	break;
	
	case(1):
	
		//level two
		if(chance(0.001))
		{
			if(spawn_timer >= spawn_set)
			{
				spawn_timer = 0
			
				repeat( irandom_range(2, 5) )
				{
					spawn_enemy(150, 500, o_Infected)	
				}
			}
		}
		
	break;
}

if(o_GUI.day_factor > 0.9)
{
	///spawn enemies at night
	if(!night) 
	{
		//repeat(7) spawn_enemy(75, o_Infected)
		night = true
	}
}

spawn_timer++

//@TEMP
if(keyboard_check(ord("G")))
{
	points += 100
}
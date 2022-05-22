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
					spawn_enemy(500, o_Mutant)	
				}
			}
		}
		
	break;
	
	case(1):
	
		//level one
		if(chance(0.003))
		{
			if(spawn_timer >= spawn_set / 2)
			{
				spawn_timer = 0
			
				repeat( irandom_range(2, 5) )
				{
					spawn_enemy(450, o_Mutant)	
				}
				
				//vaulkers
				if(chance(0.005))
				{
					spawn_enemy(300, o_Walker)	
				}
			}
		}
		
		
	break;
}

if(o_GUI.day_factor == 1.00)
{
	//spawn enemies at night
	repeat(3) spawn_enemy(175, o_Mutant)
}

spawn_timer++
var map = 0;
	
for(var i = 0; i < world; i++)
{
	for(var j = 0; j < world; j++)
	{
		map[i,j] = 0;
			
			
			
		if(!position_empty(i * tiles, j * tiles))
		{
			map[i,j] = 1	
			show_debug_message("kurat")
				
		}
	}
}
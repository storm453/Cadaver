z = -bbox_bottom

var empty = true

for(var i = 0; i < inv_data.slots_x; i++)
{
	for(var j = 0; j < inv_data.slots_y; j++)
	{
		if(inv[i,j] != 0)
		{
			empty = false	
		}
	}
}

if(empty) instance_destroy()
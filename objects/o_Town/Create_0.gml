width = irandom_range(2, 3)
height = irandom_range(1, 3)

plot_size = irandom_range(50, 100)

for(var i = 0; i < width; i++)
{
	for(var j = 0; j < height; j++)
	{
		if(chance(0.5))
		{
			var _offset_x = irandom_range(-5, 5)
			var _offset_y = irandom_range(-5, 5)
		
			randomize()
			var _to_spawn = choose(o_CampTent, o_CampCampfire, o_CampWell, o_CampFlag, o_CampCrops)
		
			instance_create_layer(x + (i * plot_size) + (plot_size / 2) + _offset_x, y + (plot_size * j) + (plot_size / 2) + _offset_y, "World", _to_spawn)
		}
	}
}
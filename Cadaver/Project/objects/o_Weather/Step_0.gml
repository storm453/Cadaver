var _spawn_width = o_Camera.x_size * o_Camera.zoom
var _spawn_height = o_Camera.y_size * o_Camera.zoom

if(weather == weather_type.rain)
{
	for(var i = 0; i < 10; i++)
	{
		var _spawn_x = o_Camera.x + irandom_range(-_spawn_width, _spawn_width)
		var _spawn_y = o_Camera.y - o_Camera.y_size * o_Camera.zoom

		part_particles_create(particles, _spawn_x, _spawn_y, global.pt_rain, 5)
	
		var _splash_x = o_Camera.x + irandom_range(-_spawn_width, _spawn_width)
		var _splash_y = o_Camera.y + irandom_range(-_spawn_height, _spawn_height)
	
		part_particles_create(particles, _splash_x, _splash_y, global.pt_splash, 10)
	}
}

for(var i = 0; i < 2; i++)
{
	var _dust_x = o_Camera.x + irandom_range(-_spawn_width, _spawn_width)
	var _dust_y = o_Camera.y + irandom_range(-_spawn_height, _spawn_height)

	part_type_direction(global.pt_dust, 0, 360, false, false)
	part_type_speed(global.pt_dust, 0.05, 0.1, false, false)
	part_particles_create(particles, _dust_x, _dust_y, global.pt_dust, 1)
}

timer += get_delta_time()

if(timer >= 20)
{
	timer = 0
	
	weather = choose(weather_type.clear, weather_type.rain)
}
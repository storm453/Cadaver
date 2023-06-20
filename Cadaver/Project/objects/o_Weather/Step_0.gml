particles.step()

var _spawn_width = o_Camera.x_size * o_Camera.zoom
var _spawn_height = o_Camera.y_size * o_Camera.zoom

if(weather == weather_type.rain)
{
	for(var i = 0; i < 10; i++)
	{
		var _spawn_x = o_Camera.x + irandom_range(-_spawn_width, _spawn_width)
		var _spawn_y = o_Camera.y - o_Camera.y_size * o_Camera.zoom
		
		//advanced_part_particles_create(particles, _spawn_x, _spawn_y, global.particle_rain, 5)
		
		//var _splash_x = o_Camera.x + irandom_range(-_spawn_width, _spawn_width)
		//var _splash_y = o_Camera.y + irandom_range(-_spawn_height, _spawn_height)
		
		//var _min_speed = 12 * get_delta_time()
		//var _max_speed = 30 * get_delta_time()
		
		//var _min_life = (30 / 60) / get_delta_time()
		//var _max_life = (60 / 60) / get_delta_time()
		
		//var _size_dec = -0.3 * get_delta_time()
		
		//part_type_size(global.pt_splash, 0.1, 0, _size_dec, 0)
		//part_type_life(global.pt_splash, _min_life, _max_life)
		//part_type_speed(global.pt_splash, _min_speed, _max_speed, 0, 0)
		//part_particles_create(particles, _splash_x, _splash_y, global.pt_splash, 10)
	}
}

for(var i = 0; i < 1; i++)
{
	var _dust_x = o_Camera.x + irandom_range(-_spawn_width, _spawn_width)
	var _dust_y = o_Camera.y + irandom_range(-_spawn_height, _spawn_height)
	
	//var _min_speed = 3 * get_delta_time()
	//var _max_speed = 6 * get_delta_time()
	
	//part_type_speed(global.pt_dust, _min_speed, _max_speed, false, false)
	if(dust) advanced_part_particles_create(particles, _dust_x, _dust_y, global.particle_dust, 1)
}

timer += get_delta_time()

if(timer >= 20)
{
	timer = 0
	
	//weather = choose(weather_type.clear, weather_type.rain)
}
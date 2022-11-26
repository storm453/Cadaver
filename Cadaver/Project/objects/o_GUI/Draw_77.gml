if (colour_grade)
{

	surface_set_target(temp_surface);
	shader_set(shdr_colour_grade);

	var texture_slot_day = shader_get_sampler_index(shdr_colour_grade, "u_lut_day");
	
	texture_set_stage(texture_slot_day, texture_lut_day);
	
	var texture_slot_night = shader_get_sampler_index(shdr_colour_grade, "u_lut_night");
	
	texture_set_stage(texture_slot_night, texture_lut_night);
	
	var uvs_day = sprite_get_uvs(spr_lut, 0);
	shader_set_uniform_f(shader_get_uniform(shdr_colour_grade, "u_lutUvs_day"), uvs_day[0],uvs_day[1],uvs_day[2],uvs_day[3]);
	
	var uvs_night = sprite_get_uvs(spr_night, 0);
	shader_set_uniform_f(shader_get_uniform(shdr_colour_grade, "u_lutUvs_night"), uvs_night[0],uvs_night[1],uvs_night[2],uvs_night[3]);

	shader_set_uniform_f(shader_get_uniform(shdr_colour_grade, "u_bf"), day_factor); 
	
	draw_surface(application_surface, 0, 0);
	
	shader_reset()
	surface_reset_target()
	surface_set_target(application_surface)
	draw_surface(temp_surface, 0, 0)
	surface_reset_target()
}
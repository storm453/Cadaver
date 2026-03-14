event_inherited()

custom_render = true

function my_render()
{
	shader_set(sh_parallax)
	
	shader_set_uniform_f(shader_get_uniform(sh_parallax, "fBbox"), bbox_bottom)
	shader_set_uniform_f(shader_get_uniform(sh_parallax, "fObjVecOf"), (bbox_right + bbox_left)/2, (bbox_bottom))
	shader_set_uniform_f(shader_get_uniform(sh_parallax, "fBboxHeight"), (bbox_bottom-bbox_top));
	
	draw_self()
	
	shader_reset()
}
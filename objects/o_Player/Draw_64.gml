if(distance_to_object(current_multi) <= interact_range)
{
	//we're close enough to a multiblock
}
	
draw_sprite_ext(s_Infected, 0, 0, 0, global.res_fix, global.res_fix, 0, c_white, infect_alpha)
draw_sprite_ext(s_Hurt, 0, 0, 0, global.res_fix, global.res_fix, 0, c_white, hit_alpha)

hit_alpha -= get_delta_time()
infect_alpha -= get_delta_time()
z = -bbox_bottom

var pathing = mp_grid_path(nearest_chunk.path_grid, path, x, y, o_Player.x, o_Player.y, 1)

path_start(path, 1, path_action_stop, 1)	

if(!pathing)
{
	//player is unreachable start breaking walls
	show_debug_message("Player is unreachable" + string(random(3)))
}	

path_delete(path)
path = path_add()

var check_x = floor(x / chunk_size) * chunk_size
var check_y = floor(y / chunk_size) * chunk_size

nearest_chunk = instance_nearest(check_x, check_y, o_Chunk)

var pathing = mp_grid_path(nearest_chunk.path_grid, path, x, y, o_Player.x, o_Player.y, 1)

path_start(path, 1, path_action_stop, 1)	

if(!pathing)
{		
	instance_destroy(o_Wall)
}

alarm[0] = 30
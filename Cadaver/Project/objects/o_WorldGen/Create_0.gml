chunk_load = 3

oldest_chunk = noone
newest_chunk = noone

global.infect_seed_x = random(100000)
global.infect_seed_y = random(100000)

#macro chunk_size 128
#macro tile_size 16

enum tile
{
	grass,
	water,
	sand,
	waterdeep,
	dirt,
	stone,
	infected,
	length
}

//@TODO swtich to array
current_chunks = 0
check_list = ds_list_create()
load_queue = ds_list_create()
chunk_lut  = ds_grid_create(2 * chunk_load + 1, 2 * chunk_load + 1)
chunk_lut2 = ds_grid_create(2 * chunk_load + 1, 2 * chunk_load + 1)

function resize_chunk_lut()
{
	ds_grid_destroy(chunk_lut)
	ds_grid_destroy(chunk_lut2)
	
	chunk_lut  = ds_grid_create(2 * chunk_load + 1, 2 * chunk_load + 1)
	chunk_lut2  = ds_grid_create(2 * chunk_load + 1, 2 * chunk_load + 1)

	for(var j = -chunk_load; j <= chunk_load; j++)
	{
		for(var i = -chunk_load; i <= chunk_load; i++)
		{
			chunk_lut[# i + chunk_load, j + chunk_load] = noone
			chunk_lut2[# i + chunk_load, j + chunk_load] = noone
		}
	}
	
	while(current_chunks > 0)
	{
		var px = o_Player.x
		var py = o_Player.y
		
		var _to_destroy = oldest_chunk
	
		var p_locx = floor(px / chunk_size)
		var p_locy = floor(py / chunk_size)
	
		if(_to_destroy.idx - p_locx >= -chunk_load) && (_to_destroy.idx - p_locx <= chunk_load) && (_to_destroy.idy - p_locy >= -chunk_load) && (_to_destroy.idy - p_locy <= chunk_load)
		{
			chunk_lut[# (_to_destroy.idx - p_locx + chunk_load), (_to_destroy.idy - p_locy + chunk_load)] = noone
		}
	
		if(oldest_chunk.newer != noone)
		{
			oldest_chunk.newer.older = noone
		}
		
		oldest_chunk = oldest_chunk.newer
	
		if(oldest_chunk != noone)assert(oldest_chunk.older == noone)
	
		instance_destroy(_to_destroy, true)
		current_chunks--
	}
}

resize_chunk_lut()

previous_p_locx = 0
previous_p_locy = 0

function check_chunk(i, j)
{
	var p_locx = floor(px / chunk_size)
	var p_locy = floor(py / chunk_size)
	
	var grid_locx = p_locx + i
	var grid_locy = p_locy + j
		
	var lookup = lookup_chunk(grid_locx, grid_locy)
		
	if(lookup == noone)
	{
		var _found = false
			
		for(var l = 0; l < ds_list_size(load_queue); l++)
		{
			if(load_queue[|l].idx == grid_locx) && (load_queue[|l].idy == grid_locy)
			{
				_found = true
				break;
			}
		}
			
		if(!_found)
		{
			ds_list_add(load_queue, { idx: grid_locx, idy: grid_locy } )
		}
	}
	else
	{
		visit_chunk(lookup)	
	}	
}

function lookup_chunk(idx, idy)
{
	var p_locx = floor(px / chunk_size)
	var p_locy = floor(py / chunk_size)
	
	var _x = idx - p_locx
	var _y = idy - p_locy
	
	if(_x >= -chunk_load) && (_x <= chunk_load) && (_y >= -chunk_load) && (_y <= chunk_load)
	{ 
		return chunk_lut[# _x + chunk_load, _y + chunk_load]
	}
	
	return noone
}

function visit_chunk(chunk_visited)
{
	if(chunk_visited.older != noone)
	{
		if(newest_chunk == chunk_visited)
		{
			newest_chunk = chunk_visited.older
		}
		
		chunk_visited.older.newer = chunk_visited.newer
	}
	if(chunk_visited.newer != noone)
	{
		if(oldest_chunk == chunk_visited)
		{
			oldest_chunk = chunk_visited.newer
		}
		
		chunk_visited.newer.older = chunk_visited.older
	}
	if(!chunk_visited.visited)
	{
		chunk_visited.visited = true
		current_chunks++
	}
	
	if(oldest_chunk == noone)
	{
		oldest_chunk = chunk_visited
		newest_chunk = chunk_visited
	}
	else
	{
		if(newest_chunk != chunk_visited)
		{
			newest_chunk.newer = chunk_visited
			chunk_visited.older = newest_chunk
			newest_chunk = chunk_visited
			newest_chunk.newer = noone
		}
	}
	
	assert(oldest_chunk.older == noone)
	assert(newest_chunk.newer == noone)
}

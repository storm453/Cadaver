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
	var _it = newest_chunk
	
	while(_it != noone)
	{
		var chunk = _it
		
		if(chunk.idx == idx) && (chunk.idy == idy)
		{
			return chunk;
		}
		
		_it = _it.older
	}
	
	return noone;
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

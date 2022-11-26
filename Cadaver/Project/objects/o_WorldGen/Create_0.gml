chunk_load = 4

global.infect_seed_x = random(100000)
global.infect_seed_y = random(100000)

#macro chunk_size 64
#macro tile_size 16

#macro gen_deep_start 0.0
#macro gen_deep_end 0.25
#macro gen_shallow_start 0.25
#macro gen_shallow_end 0.35
#macro gen_shore_start 0.35
#macro gen_shore_end 0.4
#macro gen_grass_start 0.4
#macro gen_grass_end 0.6
#macro gen_dirt_start 0.6
#macro gen_dirt_end 1

enum tile
{
	snow,
	stone,
	dirt,
	grass,
	sand,
	water,
	waterdeep,
	infected
}

//@TODO swtich to array
chunk_list = ds_list_create()

check_list = ds_list_create()

loading = 0

function lookup_chunk(idx, idy)
{
	for(var i = 0; i < ds_list_size(chunk_list); i++)
	{
		var chunk = chunk_list[|i]
		
		if(chunk.idx == idx) && (chunk.idy == idy)
		{
			return chunk;
		}
	}
	
	return undefined;
}	

function visit_chunk(chunk_visited)
{
	var index = ds_list_find_index(chunk_list, chunk_visited)
	
	for(var i = index; i < ds_list_size(chunk_list) - 1; i++)
	{
		chunk_list[|i] = chunk_list[|i + 1];
	}
	
	chunk_list[|ds_list_size(chunk_list) - 1] = chunk_visited
}

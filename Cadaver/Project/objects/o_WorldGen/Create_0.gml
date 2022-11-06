chunk_load = 1

#macro chunk_size 256
#macro tile_size 16

enum tile
{
	snow,
	stone,
	dirt,
	grass,
	sand,
	water,
	waterdeep
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

chunk_load = 1

#macro chunk_size 256

randomize()
seed = random(2048)

//@TODO swtich to array
chunk_list = ds_list_create()

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
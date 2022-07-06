#macro chunk_size 256
#macro tile_size 16

#macro chunks_load 3

global.map = create_map()

randomize()
global.seed = random(2048)

chunk_list = ds_list_create()

function check_chunk(worldx, worldy)
{
	for(var i = 0; i < ds_list_size(chunk_list); i++)
	{
		var chunk = chunk_list[|i]
		
		if(chunk.x == worldx) && (chunk.y == worldy)
		{
			return chunk
		}
	}
	
	return undefined
}

function visit_chunk(chnk)
{
	var index = ds_list_find_index(chunk_list, chnk)
	
	for(var i = index; i < ds_list_size(chunk_list) - 1; i++)
	{
		chunk_list[|i] = chunk_list[|i + 1]	
	}
	
	chunk_list[|ds_list_size(chunk_list) - 1] = chnk
}
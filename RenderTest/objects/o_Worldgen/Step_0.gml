px = floor(o_Player.x / chunk_size)
py = floor(o_Player.y / chunk_size)

for(var i = -chunks_load; i < chunks_load; i++)
{
	for(var j = -chunks_load; j < chunks_load; j++)
	{
		//grid coords
		var chunk_gridx = px + i
		var chunk_gridy = py + j
		
		//world coords
		var world_x = chunk_gridx * chunk_size
		var world_y = chunk_gridy * chunk_size
	
		var chunk = check_chunk(world_x, world_y)
		
		if(chunk == undefined)
		{
			//doesnt exist in the list yet, so we create the chunk
			var new_chunk = instance_create_layer(world_x, world_y, "Instances_1", o_Chunk)
			ds_list_add(chunk_list, new_chunk)
			
			new_chunk.init_chunk()
			
			map_push(global.map, chunk_gridx, chunk_gridy, new_chunk.data)
		}
		else
		{
			//move current chunk to bottom of list so isnt deleted
			visit_chunk(chunk)
		}
	}
}

//delete chunks when too many
var max_chunks = (chunks_load * 2) * (chunks_load * 2)

if(ds_list_size(chunk_list) > max_chunks)
{
	instance_destroy(chunk_list[|0])
	ds_list_delete(chunk_list, 0)
}

//lookup
if(keyboard_check_pressed(ord("Y")))
{
	show_debug_message(map_lookup(global.map, { kx: 2, ky : 4 } ))
}
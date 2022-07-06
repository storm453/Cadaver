px = o_Player.x
py = o_Player.y

if(keyboard_check_pressed(ord("L")))
{
	chunk_load++	
}

var p_locx = floor(px / chunk_size)
var p_locy = floor(py / chunk_size)

for(var j = -chunk_load; j <= chunk_load; j++)
{
	for(var i = -chunk_load; i <= chunk_load; i++)
	{
		var grid_locx = p_locx + i
		var grid_locy = p_locy + j
		
		var lookup = lookup_chunk(grid_locx, grid_locy)
		
		if(lookup == undefined)
		{
			var new_chunk = instance_create_layer(grid_locx * chunk_size, grid_locy * chunk_size, "World", o_Chunk)
			ds_list_add(chunk_list, new_chunk)
			
			//ini_open(string(global.seed) + "map.ini")
			//ini_write_real("Chunks", "ch" + string(grid_locx) + "x", grid_locx)
			//ini_write_real("Chunks", "ch" + string(grid_locy) + "y", grid_locy)
			//ini_close()
			
			new_chunk.init_chunk(grid_locx, grid_locy)
		}
		else
		{
			visit_chunk(lookup)	
		}
	}	
}	

var max_chunks = (2 * chunk_load + 1) * (2 * chunk_load + 1);

while(ds_list_size(chunk_list) > max_chunks)
{
	instance_destroy(chunk_list[|0], true)
	ds_list_delete(chunk_list, 0)	
}
px = o_Player.x
py = o_Player.y
	
if(keyboard_check_pressed(ord("L")))
{
	//chunk_load++	
}

for(var j = -chunk_load; j <= chunk_load; j++)
{
	for(var i = -chunk_load; i <= chunk_load; i++)
	{
		check_chunk(i, j)
	}
}

var max_chunks = (2 * chunk_load + 1) * (2 * chunk_load + 1);

while(current_chunks > max_chunks)
{
	var _to_destroy = oldest_chunk
	
	oldest_chunk.newer.older = noone
	oldest_chunk = oldest_chunk.newer
	
	assert(oldest_chunk.older == noone)
	
	instance_destroy(_to_destroy, true)
	current_chunks--
}

if(ds_list_size(load_queue) > 0)
{
	var _closest = 0
	
	for(var i = 1; i < ds_list_size(load_queue); i++)
	{
		var _closest_loc = load_queue[|_closest]
		var _current_loc = load_queue[|i]
		
		if(point_distance(_closest_loc.idx * chunk_size, _closest_loc.idy * chunk_size, o_Player.x, o_Player.y) > point_distance(_current_loc.idx * chunk_size, _current_loc.idy * chunk_size, o_Player.x, o_Player.y))
		{
			_closest = i	
		}
	}
	
	var _chunk_id = load_queue[|_closest]
	
	ds_list_delete(load_queue, _closest)
	
	var new_chunk = instance_create_layer(_chunk_id.idx * chunk_size, _chunk_id.idy * chunk_size, "World", o_Chunk)
	visit_chunk(new_chunk)
	
	new_chunk.init_chunk(_chunk_id.idx, _chunk_id.idy)
}
px = o_Player.x
py = o_Player.y

{
	var p_locx = floor(px / chunk_size)
	var p_locy = floor(py / chunk_size)
	
	for(var j = -chunk_load; j <= chunk_load; j++)
	{
		for(var i = -chunk_load; i <= chunk_load; i++)
		{
			chunk_lut2[# i + chunk_load, j + chunk_load] = chunk_lut[# i + chunk_load, j + chunk_load]
		}
	}
	
	if(p_locx != previous_p_locx) || (p_locy != previous_p_locy)
	{
		for(var j = -chunk_load; j <= chunk_load; j++)
		{
			for(var i = -chunk_load; i <= chunk_load; i++)
			{
				var _new_i = i + (p_locx - previous_p_locx)
				var _new_j = j + (p_locy - previous_p_locy)
				
				if(_new_i >= -chunk_load) && (_new_i <= chunk_load) && (_new_j >= -chunk_load) && (_new_j <= chunk_load)
				{
					chunk_lut[# i + chunk_load, j + chunk_load] = chunk_lut2[# _new_i + chunk_load, _new_j + chunk_load]
				}
				else
				{
					chunk_lut[# i + chunk_load, j + chunk_load] = noone
				}
			}
		}
		
		previous_p_locx = p_locx
		previous_p_locy = p_locy
	}
}

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
	
	if(oldest_chunk != noone) assert(oldest_chunk.older == noone)
	
	instance_destroy(_to_destroy, true)
	current_chunks--
}

var _load_size = ds_list_size(load_queue)

if(_load_size > 0)
{
	var _closest = 0
	
	for(var i = 1; i < _load_size; i++)
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
	
	var p_locx = floor(px / chunk_size)
	var p_locy = floor(py / chunk_size)
	
	chunk_lut[# (_chunk_id.idx - p_locx + chunk_load), (_chunk_id.idy - p_locy + chunk_load)] = new_chunk
	
	visit_chunk(new_chunk)
	
	new_chunk.init_chunk(_chunk_id.idx, _chunk_id.idy)
}
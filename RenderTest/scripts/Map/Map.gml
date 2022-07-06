function create_map()
{
	return { keys: ds_list_create(), values: ds_list_create() }	
}

function map_push(map, _x, _y, value)
{
	var key = { kx : _x, ky: _y }
	
	ds_list_add(map.keys, key)	
	ds_list_add(map.values, value)	
}

function map_lookup(map, key)
{
	for(var check = 0; check < ds_list_size(map.keys); check++)
	{
		if(map.keys[|check].kx == key.kx) 
		{
			if(map.keys[|check].ky == key.ky)
			{
				return map.values[|check]	
			}
		}
	}
}
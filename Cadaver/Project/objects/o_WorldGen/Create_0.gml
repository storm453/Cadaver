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

//ideas for keys & maps
//function create_map() {
//    return { keys: ds_list_create(), values: ds_list_create() };
//}

//function add_to_map(map, key, value)
//{
//    // TODO: make sure the map doesnt have the key you're about to add
//    ds_list_add(map.keys, key);
//    ds_list_add(map.values, value);
//}

//function lookup_map(map, key)
//{
//    for (var idx = 0; idx < ds_list_size(map.keys); idx++)
//    {
//        if (map.keys[|idx] == key) return map.values[|idx];
//    }
//}

//make a function that returns an object, like create_map()
//and in that object u have an array of keys and values
//so
//2 ds_lists
//and in order to insert a thing into the map, u add the key and value to the respective array
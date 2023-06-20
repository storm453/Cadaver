z = 999 - y

idx = 0
idy = 0

visited = false
older = noone
newer = noone

objects = [];

enum biome_type
{
	desert,
	savannah,
	rainforest,
	plains,
	forest,
	marsh,
	tundra,
	snow,
	taiga,
	waterbody
}

function pick_biome(_temp, _humi)
{
	_temp = (1 - cos(pi * _temp)) / 2
	_humi = (1 - cos(pi * _humi)) / 2

	if(_humi > 0.9) && (_temp < 0.9)
	{
		return biome_type.waterbody
	}

	var _low_scan = 0.4
	var _med_scan = 0.6

	if(_temp < _low_scan)
	{
		if(_humi < _low_scan)
		{
			return biome_type.tundra
		}
		else if(_humi < _med_scan)
		{
			return biome_type.snow
		}
		else
		{
			return biome_type.taiga
		}
	}
	else if(_temp < _med_scan)
	{
		if(_humi < _low_scan)
		{
			return biome_type.plains
		}
		else if(_humi < _med_scan)
		{
			return biome_type.forest
		}
		else
		{
			return biome_type.marsh
		}
	}
	else
	{
		if(_humi < _low_scan)
		{
			return biome_type.desert
		}
		else if(_humi < _med_scan)
		{
			return biome_type.savannah
		}
		else
		{
			return biome_type.rainforest
		}
	}
}

function render()
{
	bfSubmit(buffer)
}

function rand01()
{
	return (squirrel3(_incrementer++, _my_seed) % (1 << 30)) / (1 << 30);
}

function chunk_object(_x, _y, _object)
{
	var _obj = instance_create_layer(_x, _y, "World", _object)

	array_push(objects, _obj)
}

function init_chunk(loc_x, loc_y)
{
	idx = loc_x
	idy = loc_y
	
	//random_set_seed(rand(idx, idy) * 10000 + global.seed)
	
	//grid = ds_grid_create(chunk_size / tile_size, chunk_size / tile_size)
	buffer = bfCreate()
	
	_my_seed = global.seed + (77643221 * (idx *chunk_size) + 826303 * (idy * chunk_size))
	_incrementer = 0;

	for(var j = 0; j < chunk_size / 16; j++)
	{
		for(var i = 0; i < chunk_size / 16; i++)
		{
			var tile_x = idx * chunk_size + i * 16
			var tile_y = idy * chunk_size + j * 16
			
			var _octaves = 8
			var _frequency = 0.0001
			
			var _temp_noise = value_noise(tile_x, tile_y, _octaves, 0.5, _frequency, 2.1042)
			var _humi_noise = value_noise(tile_x + 13241237, tile_y + 13241237, _octaves, 0.5, _frequency, 2.1042)
			
			var _temp_color = make_color_rgb(255 * _temp_noise, 0, 255 * _humi_noise)
			
			bfDraw(buffer, idx * chunk_size + i * 16, idy * chunk_size + j * 16, 16, 16, 0, s_ChunkTest, 0, _temp_color, 0.5)

			var _biome = pick_biome(_temp_noise, _humi_noise)
			var _tile_sprite = s_Patch
			var _tile_object = noone

			switch(_biome)
			{
				case(biome_type.desert):
				{
					_tile_sprite = s_TileSand
					_tile_object = o_StickPickup
				}
				break;

				case(biome_type.savannah):
				{
					_tile_sprite = s_TileSavannah
					_tile_object = o_Plants1
				}
				break;

				case(biome_type.rainforest):
				{
					_tile_sprite = s_TileMoss
					_tile_object = o_Plants3
				}
				break;

				case(biome_type.plains):
				{
					_tile_sprite = s_TileGrass
					_tile_object = o_Rock1
				}
				break;

				case(biome_type.forest):
				{
					_tile_sprite = s_TileForest
					_tile_object = o_Tree1
				}
				break;

				case(biome_type.marsh):
				{
					_tile_sprite = s_TileSwamp
					_tile_object = o_Plants3
				}
				break;

				case(biome_type.tundra):
				{
					_tile_sprite = s_TileDirt
					_tile_object = o_StickPickup
				}
				break;

				case(biome_type.snow):
				{
					_tile_sprite = s_TileSnow
					_tile_object = o_Rock1
				}
				break;

				case(biome_type.taiga):
				{
					_tile_sprite = s_TileTaiga
					_tile_object = o_Henge1
				}
				break;

				case(biome_type.waterbody):
				{
					_tile_sprite = s_TileWater
					_tile_object = noone
				}
				break;
			}

			bfDraw(buffer, idx * chunk_size + i * 16, idy * chunk_size + j * 16, 16, 16, 0, _tile_sprite, 0, c_white, 1)

			neighbors = array_create(9, 0)

			for (var k = -1; k <= 1; ++k) 
			{
				for (var l = -1; l <= 1; ++l) 
				{
					neighbors[(k+1)+(l+1)*3] = value_noise((tile_x + tile_size * k), (tile_y + tile_size * l), 1, 0.5, 0.5, 2.1042)
				}
			}

			var _heighest = 0

			for(var k = 1; k < array_length(neighbors); k++)
			{
				if(neighbors[_heighest] < neighbors[k])
				{
					_heighest = k
				}
			}

			if(_heighest == (1 + 1 * 3))
			{
				if(value_noise(tile_x, tile_y, 1, 0.5, 0.5, 2.1042) > 0.99)
				{
					if(_tile_object != noone) chunk_object(tile_x, tile_y, _tile_object)
				}
			}
		}
	}
	
	//setup pathfinding grid
	//path_grid = mp_grid_create(idx * chunk_size - chunk_size, idy * chunk_size - chunk_size, (chunk_size * 3) / tile_size, (chunk_size * 3) / tile_size, tile_size, tile_size)
			
	//mp_grid_add_instances(path_grid, o_Collision, 0)
	
	bfFinish(buffer)
}

ds_list_add(o_RenderManager.terrain, self)
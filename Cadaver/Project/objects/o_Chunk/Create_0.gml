z = 999 - y

idx = 0
idy = 0

//@TODO REMOVE IF NOT USED!!!
visited = false
inited = false
older = noone
newer = noone

render_next = noone
render_prev = noone

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
	//return biome_type.forest
	
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
	inited = true
	
	idx = loc_x
	idy = loc_y
	
	temp_corners = array_create(4, 0)
	humi_corners = array_create(4, 0)
	
	var _tx = idx * chunk_size
	var _ty = idy * chunk_size
	
	var _octaves = 8
	var _frequency = 0.0003
	
	temp_corners[0] = value_noise(_tx, _ty, _octaves, 0.5, _frequency, 2.1042)
	temp_corners[1] = value_noise(_tx + chunk_size, _ty, _octaves, 0.5, _frequency, 2.1042)
	temp_corners[2] = value_noise(_tx, _ty + chunk_size, _octaves, 0.5, _frequency, 2.1042)
	temp_corners[3] = value_noise(_tx + chunk_size, _ty + chunk_size, _octaves, 0.5, _frequency, 2.1042)
	
	humi_corners[0] = value_noise(_tx + 13241237, _ty + 13241237, _octaves, 0.5, _frequency, 2.1042)
	humi_corners[1] = value_noise(_tx + chunk_size + 13241237, _ty + 13241237, _octaves, 0.5, _frequency, 2.1042)
	humi_corners[2] = value_noise(_tx + 13241237, _ty + chunk_size + 13241237, _octaves, 0.5, _frequency, 2.1042)
	humi_corners[3] = value_noise(_tx + chunk_size + 13241237, _ty + chunk_size + 13241237, _octaves, 0.5, _frequency, 2.1042)
	
	buffer = bfCreate()
	
	_my_seed = global.seed + (77643221 * (idx *chunk_size) + 826303 * (idy * chunk_size))
	_incrementer = 0;

	for(var j = 0; j < chunk_size / 16; j++)
	{
		for(var i = 0; i < chunk_size / 16; i++)
		{
			var tile_x = idx * chunk_size + i * 16
			var tile_y = idy * chunk_size + j * 16
			
			var _temp_noise = lerp(lerp(temp_corners[0], temp_corners[1], i / (chunk_size / 16)), lerp(temp_corners[2], temp_corners[3], i / (chunk_size / 16)), j / (chunk_size / 16))
			var _humi_noise = lerp(lerp(humi_corners[0], humi_corners[1], i / (chunk_size / 16)), lerp(humi_corners[2], humi_corners[3], i / (chunk_size / 16)), j / (chunk_size / 16))
			
			var _temp_color = make_color_rgb(255 * _temp_noise, 0, 255 * _humi_noise)
			
			//bfDraw(buffer, idx * chunk_size + i * 16, idy * chunk_size + j * 16, 16, 16, 0, s_ChunkTest, 0, _temp_color, 0.5)

			var _biome = pick_biome(_temp_noise, _humi_noise)
			var _tile_sprite = s_Arrow
			var _tile_object = noone
			var _spawn_chance = 0.95
			
			switch(_biome)
			{
				case(biome_type.desert):
				{
					_tile_sprite = s_TileSand
					_tile_object = o_Cactus
					_spawn_chance = 0.995
				}
				break;

				case(biome_type.savannah):
				{
					_tile_sprite = s_TileSavannah
					_tile_object = o_TreeSavannah
					_spawn_chance = 0.995
				}
				break;

				case(biome_type.rainforest):
				{
					_tile_sprite = s_TileMoss
					_tile_object = o_TreeJungle
					_spawn_chance = 0.99
				}
				break;

				case(biome_type.plains):
				{
					_tile_sprite = s_TilePlains
				}
				break;

				case(biome_type.forest):
				{
					_tile_sprite = s_TileForest
					_tile_object = choose(o_Tree2, o_Bush, o_Tree1)
				}
				break;

				case(biome_type.marsh):
				{
					_tile_sprite = s_TileSwamp
					_tile_object = choose(o_TreeSwamp, o_TreeFallenSwamp)
					_spawn_chance = 0.99
				}
				break;

				case(biome_type.tundra):
				{
					_tile_sprite = s_TileDirt
				}
				break;

				case(biome_type.snow):
				{
					_tile_sprite = s_TileSnow
				}
				break;

				case(biome_type.taiga):
				{
					_tile_sprite = s_TileTaiga
				}
				break;

				case(biome_type.waterbody):
				{
					_tile_sprite = s_TileWater
				}
				break;
			}

			
	
			//GROUND
			var _ground_noise = value_noise(tile_x, tile_y, 3, 0.5, 0.005, 2.1042) * 55 + 200

			var _color = make_color_rgb(_ground_noise, _ground_noise, _ground_noise)
			
			bfDraw(buffer, idx * chunk_size + i * 16, idy * chunk_size + j * 16, 16, 16, 0, _tile_sprite, 0, _color, 1)
			
			neighbors = array_create(9, 0)

			for (var k = -1; k <= 1; ++k) 
			{
				for (var l = -1; l <= 1; ++l) 
				{
					neighbors[(k+1)+(l+1)*3] = value_noise((tile_x + tile_size * k), (tile_y + tile_size * l), 1, 0.05, 0.5, 2.1042)
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
				if(value_noise(tile_x, tile_y, 1, 0.5, 0.5, 2.1042) > _spawn_chance)
				{
					if(_tile_object != noone) chunk_object(tile_x, tile_y, _tile_object)
				}
			}

			if(_biome == biome_type.forest)
			{
				if(rand01() > 0.8)
				{
					bfDraw(buffer, tile_x, tile_y, 16, 16, 0, s_Grass, 0, _color, 1)
				}
			}
			if(_biome == biome_type.desert)
			{
				if(rand01() > 0.95)
				{
					//@TEMP replcae the choose in the line below
					bfDraw(buffer, tile_x, tile_y, 16, 16, 0, s_DesertFoliage, choose(0, 1, 2, 3), _color, 1)
				}
			}
			if(_biome == biome_type.marsh)
			{
				if(rand01() > 0.9)
				{
					bfDraw(buffer, tile_x, tile_y, 16, 16, 0, s_FoliageSwamp, choose(0, 1, 2, 3, 4, 5), _color, 1)
				}
			}
			if(_biome == biome_type.plains)
			{
				if(rand01() > 0.9)
				{
					bfDraw(buffer, tile_x, tile_y, 16, 16, 0, s_Grass, 0, _color, 1)
				}
			}
		}
	}
	
	// for(var j = 0; j < chunk_size / 16; j++)
	// {
	// 	for(var i = 0; i < chunk_size / 16; i++)
	// 	{
	// 		var tile_x = idx * chunk_size + i * 16
	// 		var tile_y = idy * chunk_size + j * 16
			
	// 		var _grass_x = tile_x + (tile_size / 2) * rand01()
	// 		var _grass_y = tile_y + (tile_size / 2) * rand01()
				
	// 		bfDraw(buffer, _grass_x, _grass_y, 16, 16, 0, s_Grass, 0, c_white, 1)
	// 	}
	// }
	
	bfFinish(buffer)
	o_RenderManager.terrain_add(self)
}
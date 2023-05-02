z = 999 - y

idx = 0
idy = 0

objects = ds_list_create()

function render()
{
	bfSubmit(buffer)
	
	//mp_grid_draw(path_grid)
	
	//ui_draw_rectangle(x, y, chunk_size, chunk_size, c_red, 0.3, 1)
	//ui_draw_string(x + 5, y + 5, string(idx) + " ," + string(idy), ft_17)
}

function init_chunk(loc_x, loc_y)
{
	idx = loc_x
	idy = loc_y
	
	random_set_seed(rand(idx, idy) * 10000 + global.seed)

	//we need to check if this chunk save already exists
	//file_name = string(idx) + "_" + string(idy) + ".chunk"
	//if(file_exists(MAPDIR + file_name))
	//{
	//	//file exists load!
	//	var bf = buffer_load(MAPDIR + file_name)
		
	//	var count = buffer_read(bf, buffer_u32)
		
	//	for(var i = 0; i < count; i++)
	//	{
	//		var uid = buffer_read(bf, buffer_u32)
	//		var _x  = buffer_read(bf, buffer_f64)
	//		var _y  = buffer_read(bf, buffer_f64)	
			
	//		create_obj_chunk(uid, _x, _y)	
	//	}
		
	//	buffer_delete(bf)
	//}
	//else
	//{
	//	//it doesnt exist!

	//	//create a file
	//	var file = file_bin_open(MAPDIR + file_name, 1)
	//	file_bin_close(file)
	//}

	grid = ds_grid_create(chunk_size / tile_size, chunk_size / tile_size)
	buffer = bfCreate()
	
	for(var i = 0; i < chunk_size / 16; i++)
	{
		for(var j = 0; j < chunk_size / 16; j++)
		{
			var tile_x = idx * chunk_size + i * 16
			var tile_y = idy * chunk_size + j * 16

			var current_noise = value_noise(tile_x, tile_y, 1, 0.5, 0.001, 2.1042)
			
			var grass_noise = value_noise(idx * chunk_size + i * 16, idy * chunk_size + j * 16, 1, 0.5, 0.001, 2.1042)
			
			var spr = s_BasicQuarry
			
			if(in_range(current_noise, gen_dirt_start, gen_dirt_end))
			{
				spr = s_TileDirt
				ds_grid_set(grid, i, j, tile.dirt)
			}
			else if(in_range(current_noise, gen_grass_start, gen_grass_end))
			{
				spr = s_TileGrass
				ds_grid_set(grid, i, j, tile.grass)

				//spawn grass
				if(in_range(current_noise, gen_grass_start + 0.009, gen_grass_end - 0.009))
				{
					var tree = 0
						
					for(var lx = -1; lx <= 1; lx++)
					{
						for(var ly = -1; ly <= 1; ly++)
						{
							if(rand(idx * chunk_size / tile_size + i + 17000 + lx + 1, idy * chunk_size / tile_size + j + 17000 + ly + 1) < 0.01)
							{
								tree = 1
							}
						}
					}

					if(!tree)
					{
						for(var lx = 0; lx < tile_size; lx += 4)
						{
							for(var ly = 0; ly < tile_size; ly += 4)
							{
								var grass_rand_x = rand(idx * chunk_size + i * tile_size + lx, idy * chunk_size + j * tile_size + ly) * tile_size
								var grass_rand_y = rand(idy * chunk_size + j * tile_size + ly, idx * chunk_size + i * tile_size + lx + 5000) * tile_size
								
								var stochastic = rand(idx * chunk_size + i * tile_size + lx, idy * chunk_size + j * tile_size + ly - 500000)

								stochastic = power(stochastic,1/4)
									
								var grass_color = clamp(200 + grass_noise * 3 * 30 + 15, 0, 255)

								if(grass_noise > stochastic) && (grass_noise > 0.2)
								{
									bfDraw(buffer, idx * chunk_size + i * tile_size + grass_rand_x + lx, idy * chunk_size + j * tile_size + grass_rand_y + ly, ((rand(i,j) > 0.5) ? 1 : -1) * 16, 16, 0, s_Plants2, 0, make_color_rgb(grass_color, grass_color, grass_color), 1)
								}
							}
						}
					}
				}
				
				if(rand(idx * chunk_size / tile_size + i + 17000, idy * chunk_size / tile_size + j + 17000) < 0.01)
				{
					create_obj_chunk(o_Tree1, idx * chunk_size + (i * 16), idy * chunk_size + (j * 16))	
						
					for(var k = 0; k < 32; k++)
					{
						var leaf_x = rand(idx * chunk_size + i * tile_size, idy * chunk_size + j * tile_size + k) * 2 - 1
						var leaf_y = rand(idy * chunk_size + j * tile_size, idx * chunk_size + i * tile_size + 100000 + k) * 2 - 1
							
						var leaf_spread = 30
							
						//bfDraw(buffer, idx * chunk_size + i * tile_size + leaf_x * leaf_spread - tile_size / 2, idy * chunk_size + j * tile_size + leaf_y * leaf_spread - tile_size / 2, 16, 16, 0, s_Leaves, 0, choose(color_hex(0xc2d64f), color_hex(0xb77862)), 1)
					}
				}
			}
			else if(in_range(current_noise, gen_shore_start, gen_shore_end))
			{
				spr = s_TileSand
				ds_grid_set(grid, i, j, tile.sand)
				
				if(rand(idx * chunk_size / tile_size + i + 20000, idy * chunk_size / tile_size + j + 20000) < 0.005)
				{
					//create_obj_chunk(o_RockPickup, idx * chunk_size + (i * 16), idy * chunk_size + (j * 16))	
				}
			}
			else if(in_range(current_noise, gen_shallow_start, gen_shallow_end))
			{
				spr = s_TileWater
				ds_grid_set(grid, i, j, tile.water)
			}
			
			//debug: draw noise
			//bfDraw(buffer, idx * chunk_size + i * 16, idy * chunk_size + j * 16, 16, 16, 0, s_ChunkTest, 0, current_noise * 255, 0.5)
			
			//draw tile
			bfDraw(buffer, idx * chunk_size + i * tile_size, idy * chunk_size + j * tile_size, tile_size, tile_size, 10, spr, 0, c_white, 1)	
		}
	}
	
	//setup pathfinding grid
	path_grid = mp_grid_create(idx * chunk_size - chunk_size, idy * chunk_size - chunk_size, (chunk_size * 3) / tile_size, (chunk_size * 3) / tile_size, tile_size, tile_size)
			
	mp_grid_add_instances(path_grid, o_Collision, 0)
	
	//borders
	for(var i = 0; i < chunk_size / tile_size; i++)
	{
		for(var j = 0; j < chunk_size / tile_size; j++)
		{
			//get chunks around
			var left_chunk = instance_position((idx - 1) * chunk_size, idy * chunk_size, o_Chunk)
			var right_chunk = instance_position((idx + 1) * chunk_size, idy * chunk_size, o_Chunk)
			var up_chunk = instance_position(idx * chunk_size, (idy - 1) * chunk_size, o_Chunk)
			var down_chunk = instance_position(idx * chunk_size, (idy + 1) * chunk_size, o_Chunk)
			
			var left = grid[# i - 1, j]
			
			if(i == 0)
			{
				var gen_noise = value_noise((idx - 1) * chunk_size + 3 * 16, idy * chunk_size + j * 16, 1, 0.5, 0.001, 2.1042)
				
				if(in_range(gen_noise, gen_grass_start, gen_grass_end))
				{
					left = tile.grass
				}
				
				//if(in_range(infect_noise, 0, 0.45)) left = tile.infected
			}
			
			var right = grid[# i + 1,j]
			
			if(i == 3)
			{
				var gen_noise = value_noise((idx + 1) * chunk_size, idy * chunk_size + j * 16, 1, 0.5, 0.001, 2.1042)
					
				if(in_range(gen_noise, gen_grass_start, gen_grass_end))
				{
					right = tile.grass
				}

				//if(in_range(infect_noise, 0, 0.45)) right = tile.infected
			}
			
			var up = grid[# i, j - 1]
			
			if(j == 0)
			{
				var gen_noise = value_noise(idx * chunk_size + i * 16, (idy - 1) * chunk_size + 3 * 16, 1, 0.5, 0.001, 2.1042)
				
				if(in_range(gen_noise, gen_grass_start, gen_grass_end))
				{
					up = tile.grass
				}

				//if(in_range(infect_noise, 0, 0.45)) up = tile.infected
			}
			
			var down = grid[# i, j + 1]
			
			if(j == 3)
			{
				var gen_noise = value_noise(idx * chunk_size + i * 16, (idy + 1) * chunk_size, 1, 0.5, 0.001, 2.1042)
				
				if(in_range(gen_noise, gen_grass_start, gen_grass_end))
				{
					down = tile.grass
				}

				//if(in_range(infect_noise, 0, 0.45)) down = tile.infected
			}
			
			//dirt
			if(grid[# i,j] == tile.dirt)
			{
				var rand_index = round(rand(idx * chunk_size + i * tile_size + 27000, idy * chunk_size + j * tile_size + 15000)) * 2
				
				if(left == tile.grass)
				{
					bfDraw(buffer, idx * chunk_size + (i * tile_size), idy * chunk_size + (j * tile_size), tile_size, tile_size, 9, s_GrassEdgeH, rand_index, c_white, 1)
				}
				if(right == tile.grass)
				{
					bfDraw(buffer, idx * chunk_size + (i * tile_size) + tile_size, idy * chunk_size + (j * tile_size), -tile_size, tile_size, 9, s_GrassEdgeH, rand_index, c_white, 1)
				}
				if(up == tile.grass)
				{
					bfDraw(buffer, idx * chunk_size + (i * tile_size), idy * chunk_size + (j * tile_size), tile_size, tile_size, 9, s_GrassEdgeV, rand_index, c_white, 1)
				}
				if(down == tile.grass)
				{
					bfDraw(buffer, idx * chunk_size + (i * tile_size), idy * chunk_size + (j * tile_size) + tile_size, tile_size, -tile_size, 9, s_GrassEdgeV, rand_index, c_white, 1)
				}	
			}
			//shore / sand
			if(grid[# i,j] == tile.sand)
			{
				if(left == tile.grass)
				{
					bfDraw(buffer, idx * chunk_size + (i * tile_size), idy * chunk_size + (j * tile_size), tile_size, tile_size, 9, s_GrassEdgeH, 0, c_white, 1)
				}
				if(right == tile.grass)
				{
					bfDraw(buffer, idx * chunk_size + (i * tile_size) + tile_size, idy * chunk_size + (j * tile_size), -tile_size, tile_size, 9, s_GrassEdgeH, 0, c_white, 1)
				}
				if(up == tile.grass)
				{
					bfDraw(buffer, idx * chunk_size + (i * tile_size), idy * chunk_size + (j * tile_size), tile_size, tile_size, 9, s_GrassEdgeV, 0, c_white, 1)
				}
				if(down == tile.grass)
				{
					bfDraw(buffer, idx * chunk_size + (i * tile_size), idy * chunk_size + (j * tile_size) + tile_size, tile_size, -tile_size, 9, s_GrassEdgeV, 0, c_white, 1)
				}
			}
		}
	}

	bfFinish(buffer)
}

ds_list_add(o_RenderManager.terrain, self)
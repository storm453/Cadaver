z = 999 - y

idx = 0
idy = 0

objects = ds_list_create()

function render()
{
	bfSubmit(buffer)
}

function init_chunk(loc_x, loc_y)
{
	idx = loc_x
	idy = loc_y
	
	random_set_seed(rand(idx, idy) * 10000 + global.seed)

	//we need to check if this chunk save already exists
	file_name = string(idx) + "_" + string(idy) + ".chunk"
	if(file_exists(MAPDIR + file_name))
	{
		//file exists load!
		var bf = buffer_load(MAPDIR + file_name)
		
		var count = buffer_read(bf, buffer_u32)
		
		for(var i = 0; i < count; i++)
		{
			var uid = buffer_read(bf, buffer_u32)
			var _x  = buffer_read(bf, buffer_f64)
			var _y  = buffer_read(bf, buffer_f64)	
			
			create_obj_chunk(uid, _x, _y)	
		}
		
		buffer_delete(bf)
	}
	else
	{
		//it doesnt exist!

		//create a file
		var file = file_bin_open(MAPDIR + file_name, 1)
		file_bin_close(file)
	}

	buffer = bfCreate()
	grid = ds_grid_create(chunk_size / tile_size, chunk_size / tile_size)

	for(var i = 0; i < chunk_size / 16; i++)
	{
		for(var j = 0; j < chunk_size / 16; j++)
		{
			var current_noise = value_noise(idx * chunk_size + i * 16, idy * chunk_size + j * 16, 3, 0.5, 0.001, 2.1042)
			
			var waterlevel = 0.2
			var spr = 0
			
			//grass
			if(in_range(current_noise, 0.4, 0.7))
			{
				var rnd = rand(i, j)
				
				if(rnd > max((current_noise - 0.6) / 0.1, 0))
				{
					bfDraw(buffer, floor(idx * chunk_size + i * 16 + rand(i,j) * (tile_size * choose(-1,1))), floor(idy * chunk_size + j * 16 + rand(j,i) * (tile_size * choose(-1,1))), 32, 32, -1, s_GrassTest, round(rand(i + 5000,j + 5000)), c_white, 1)	
				}
			}
			if(in_range(current_noise, 0.675, 1))
			{
				var rnd = rand(i, j)
				
				//if(rnd < max((current_noise - 0.9) / 0.1, 0))
				//{
					bfDraw(buffer, floor(idx * chunk_size + i * 16 + rand(i,j) * (tile_size * choose(-1,1))), floor(idy * chunk_size + j * 16 + rand(j,i) * (tile_size * choose(-1,1))), 32, 32, -1, s_TundraGrass, round(rand(i + 10000, j + 10000)), c_white, 1)	
				//}
			}
			
			if(in_range(current_noise, 0.6, 1))
			{
				spr = s_TileDirt
				ds_grid_set(grid, i, j, tile.dirt)
				
				if(rand(idx * chunk_size / tile_size + i, idy * chunk_size / tile_size + j) < 0.01)
				{
					create_obj_chunk(o_Tree3, idx * chunk_size + (i * 16), idy * chunk_size + (j * 16))	
				}
				if(rand(idx * chunk_size / tile_size + i, idy * chunk_size / tile_size + j) < 0.05)
				{
					create_obj_chunk(o_Tree1, idx * chunk_size + (i * 16), idy * chunk_size + (j * 16))	
				}
				if(rand(idx * chunk_size / tile_size + i + 10000, idy * chunk_size / tile_size + j + 10000) < 0.0007)
				{
					create_obj_chunk(o_Rock1, idx * chunk_size + (i * 16), idy * chunk_size + (j * 16))	
				}
				if(rand(idx * chunk_size / tile_size + i + 20000, idy * chunk_size / tile_size + j + 20000) < 0.0007)
				{
					create_obj_chunk(o_Iron, idx * chunk_size + (i * 16), idy * chunk_size + (j * 16))	
				}
			}
			else if(in_range(current_noise, 0.4, 0.6))
			{
				spr = s_TileGrass
				ds_grid_set(grid, i, j, tile.grass)
				
				if(rand(idx * chunk_size / tile_size + i + 20000, idy * chunk_size / tile_size + j + 20000) < 0.01)
				{
					create_obj_chunk(o_Plants3, idx * chunk_size + (i * 16), idy * chunk_size + (j * 16))	
				}
				if(rand(idx * chunk_size / tile_size + i + 20000, idy * chunk_size / tile_size + j + 20000) < 0.005)
				{
					create_obj_chunk(o_Plants1, idx * chunk_size + (i * 16), idy * chunk_size + (j * 16))	
				}
			}
			else if(in_range(current_noise, 0.35, 0.4))
			{
				spr = s_TileSand
				ds_grid_set(grid, i, j, tile.sand)
				
				if(rand(idx * chunk_size / tile_size + i + 20000, idy * chunk_size / tile_size + j + 20000) < 0.005)
				{
					create_obj_chunk(o_RockPickup, idx * chunk_size + (i * 16), idy * chunk_size + (j * 16))	
				}
			}
			else if(in_range(current_noise, 0.25, 0.35))
			{
				spr = s_TileWater
				ds_grid_set(grid, i, j, tile.water)
			}
			else if(in_range(current_noise, 0.0, 0.25))
			{
				spr = s_TileWaterdeep
				ds_grid_set(grid, i, j, tile.waterdeep)
			}

			//debug: draw noise
			//bfDraw(buffer, idx * chunk_size + i * 16, idy * chunk_size + j * 16, 16, 16, 0, s_ChunkTest, 0, current_noise * 255, 0.5)
			
			bfDraw(buffer, idx * chunk_size + i * tile_size, idy * chunk_size + j * tile_size, tile_size, tile_size, 10, spr, 0, c_white, 1)	
		}
	}
	
	for(var i = 1; i < chunk_size / 16; i++)
	{
		for(var j = 1; j < chunk_size / 16; j++)
		{
			//sand
			if(grid[# i,j] == tile.sand)
			{
				var left = grid[# i - 1,j]
				var right = grid[# i + 1,j]
				var up = grid[# i, j - 1]
				var down = grid[#i, j + 1]
				
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
			
			//dirt
			if(grid[# i,j] == tile.dirt)
			{
				var left = grid[# i - 1,j]
				var right = grid[# i + 1,j]
				var up = grid[# i, j - 1]
				var down = grid[#i, j + 1]
				
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
			
			//water
			if(grid[# i,j] == tile.water)
			{
				var left = grid[# i - 1,j]
				var right = grid[# i + 1,j]
				var up = grid[# i, j - 1]
				var down = grid[#i, j + 1]
				
				if(left == tile.sand)
				{
					bfDraw(buffer, idx * chunk_size + (i * tile_size), idy * chunk_size + (j * tile_size), tile_size, tile_size, 9, s_SandEdgeH, 0, c_white, 1)
				}
				if(right == tile.sand)
				{
					bfDraw(buffer, idx * chunk_size + (i * tile_size) + tile_size, idy * chunk_size + (j * tile_size), -tile_size, tile_size, 9, s_SandEdgeH, 0, c_white, 1)
				}
				if(up == tile.sand)
				{
					bfDraw(buffer, idx * chunk_size + (i * tile_size), idy * chunk_size + (j * tile_size), tile_size, tile_size, 9, s_SandEdgeV, 0, c_white, 1)
				}
				if(down == tile.sand)
				{
					bfDraw(buffer, idx * chunk_size + (i * tile_size), idy * chunk_size + (j * tile_size) + tile_size, tile_size, -tile_size, 9, s_SandEdgeV, 0, c_white, 1)
				}	
			}
		}
	}
	
	for(var i = 0; i < chunk_size / 16; i++)
	{
		for(var j = 0; j < chunk_size / 16; j++)
		{
			//bfDraw(buffer, idx * chunk_size + i * tile_size, idy * chunk_size + j * tile_size, tile_size, tile_size, 10, spr, 0, c_white, 1)	
		}
	}

	bfFinish(buffer)
}

ds_list_add(o_RenderManager.terrain, self)
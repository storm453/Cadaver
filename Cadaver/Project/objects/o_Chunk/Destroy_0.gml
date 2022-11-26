ds_list_delete(o_RenderManager.terrain, ds_list_find_index(o_RenderManager.terrain, self))

bfDestroy(buffer)
//mp_grid_destroy(path_grid)
ds_grid_destroy(grid)

//var bf = buffer_create(0, buffer_grow, 1)

//var count = 0

//for(var i = 0; i < ds_list_size(objects); i++)
//{
//	if(instance_exists(objects[|i])) count++
//}

//buffer_write(bf, buffer_u32, count)

for(var i = 0; i < ds_list_size(objects); i++)
{
	//if(!instance_exists(objects[|i])) continue
	
	////save objects to file
	//buffer_write(bf, buffer_u32, objects[|i].object_index)
	//buffer_write(bf, buffer_f64, objects[|i].x)
	//buffer_write(bf, buffer_f64, objects[|i].y)
	
	instance_destroy(objects[|i])
}

ds_list_destroy(objects)

//buffer_save(bf, MAPDIR + file_name)
//buffer_delete(bf)
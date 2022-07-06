objects = ds_list_create()

function init_chunk()
{
	data = ds_grid_create(16, 16)
	
	random_set_seed(x * y * 10000 + global.seed)
	
	//called once when chunk is created	
	if(random(1) > 0.5)
	{
		var obj = instance_create_layer(x + 128, y + 128, "Instances_1", o_Tree)
		ds_list_add(objects, obj)
	}
}
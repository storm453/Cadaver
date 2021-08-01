z = 999 - y

idx = 0
idy = 0

objects = ds_list_create()

function render()
{
	ui_draw_rectangle(x, y, chunk_size, chunk_size, c_green, 1, false)
}

function render_shadow()
{
	
}

ds_list_add(o_RenderManager.entities, self)

function init_chunk(loc_x, loc_y)
{
	idx = loc_x
	idy = loc_y
	
	random_set_seed(rand(idx, idy) * 10000 + o_WorldGen.seed)

	objects_count = irandom_range(1, 8)

	for(var i = 0; i < objects_count; i++)
	{
		var obj = instance_create_layer(random_range(x, x + chunk_size), random_range(y, y + chunk_size), "Instances", o_Plants1)	
	
		ds_list_add(objects, obj)
	}
	
	if (random(1) > 0.9) 
	{
		ds_list_add(objects, instance_create_layer(x + chunk_size / 2, y + chunk_size / 2, "Instances", o_Tree2))
	}
}
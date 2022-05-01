z = 999 - y

idx = 0
idy = 0

objects = ds_list_create()

function render()
{
	ui_draw_rectangle(x, y, chunk_size, chunk_size, 0x547D5B, 1, false)
}

function render_shadow()
{
	
}

ds_list_add(o_RenderManager.entities, self)

function create_obj_chunk(object, xx, yy)
{
	var obj = instance_create_layer(xx, yy, "Instances", object)	
	
	ds_list_add(objects, obj)
}

function init_chunk(loc_x, loc_y)
{
	idx = loc_x
	idy = loc_y
	
	random_set_seed(rand(idx, idy) * 10000 + o_WorldGen.seed)

	for(var i = 0; i < 5; i++)
	{
		create_obj_chunk(o_Plants1, random_range(x, x + chunk_size), random_range(y, y + chunk_size))
	}

	for(var i = 0; i < 3; i++)
	{
		if (random(1) > 0.8) 
		{
			create_obj_chunk(o_Tree1, random_range(x, x + chunk_size), random_range(y, y + chunk_size))
		}
	}
	
	for(var i = 0; i < 2; i++)
	{
		if(random(1) > 0.6)
		{
			create_obj_chunk(o_Rock1, random_range(x, x + chunk_size), random_range(y, y + chunk_size))	
		}
	}
	
	if(random(1) > 0.4)
	{
		create_obj_chunk(o_Tree2, random_range(x, x + chunk_size), random_range(y, y + chunk_size))
	}
}
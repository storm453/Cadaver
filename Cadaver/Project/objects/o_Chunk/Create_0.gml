z = 999 - y

idx = 0
idy = 0

objects = ds_list_create()

function render()
{
	bfSubmit(buffer)
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
	
	buffer = bfCreate()

	repeat(irandom_range(50, 150))
	{
		var random_y = floor(idy * chunk_size + random(chunk_size))
		
		bfDraw(buffer, floor(idx * chunk_size + random(chunk_size)), random_y, 32, 32, (-random_y) / 1000, s_GrassTest, irandom(2), c_white, 1)
	}
	
	bfFinish(buffer)
	
	if(random(0.6))
	{
		var obj = instance_create_layer(floor(idx * chunk_size + random(chunk_size)), floor(idy * chunk_size + random(chunk_size)), "Instances", o_Barrel)	
	
		ds_list_add(objects, obj)
	}
}
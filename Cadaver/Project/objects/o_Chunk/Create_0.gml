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
	
	//for(var i = 0; i < chunk_size / 16; i++)
	//{
	//	for(var j = 0; j < chunk_size / 16; j++)
	//	{
	//		bfDraw(buffer, idx * chunk_size + i * 16, idy * chunk_size + j * 16, 16, 16, 0, s_ChunkTest, 0, noise(v3_div(v3(idx * chunk_size + i * 16, idy * chunk_size + j * 16,0), v3(100))) * 255, 0.5)
	//	}
	//}
	
	bfFinish(buffer)
	
	var zm = irandom_range(50, 1000)

	var current_noise = noise(v3_div(v3(idx * chunk_size, idy * chunk_size, 0), v3(650)))
	
	show_debug_message(zm)
	
	if(current_noise > 0.75)
	{
		repeat(irandom_range(3, 7))
		{
			var obj = instance_create_layer(floor(idx * chunk_size + random(chunk_size)), floor(idy * chunk_size + random(chunk_size)), "Instances", o_Tree1)
	
			ds_list_add(objects, obj)
		}
		
		//var obj = instance_create_layer(idx * chunk_size + chunk_size / 2, idy * chunk_size + chunk_size / 2, "Instances", o_Tree1)
		
		//ds_list_add(objects, obj)
	}
	if(current_noise > 0.5) && (current_noise < 0.75)
	{
		repeat(irandom_range(3, 9))
		{
			var obj = instance_create_layer(floor(idx * chunk_size + random(chunk_size)), floor(idy * chunk_size + random(chunk_size)), "Instances", o_Tree2)
	
			ds_list_add(objects, obj)
		}
		
		//var obj = instance_create_layer(idx * chunk_size + chunk_size / 2, idy * chunk_size + chunk_size / 2, "Instances", o_Tree2)
		
		//ds_list_add(objects, obj)
	}
	if(current_noise > 0.25) && (current_noise < 0.5)
	{
		repeat(irandom_range(2, 8))
		{
			var obj = instance_create_layer(floor(idx * chunk_size + random(chunk_size)), floor(idy * chunk_size + random(chunk_size)), "Instances", choose(o_Rock1, o_Iron,  o_Coal, o_RockPickup))	
	
			ds_list_add(objects, obj)
		}		
		
		//var obj = instance_create_layer(idx * chunk_size + chunk_size / 2, idy * chunk_size + chunk_size / 2, "Instances", o_Rock1)
		
		//ds_list_add(objects, obj)
	}
	if(current_noise < 0.25)
	{
		repeat(irandom_range(5, 16))
		{
			var obj = instance_create_layer(floor(idx * chunk_size + random(chunk_size)), floor(idy * chunk_size + random(chunk_size)), "Instances", choose(o_Plants1, o_Plants2, o_Plants3))	

			ds_list_add(objects, obj)
		}	
		
		//var obj = instance_create_layer(idx * chunk_size + chunk_size / 2, idy * chunk_size + chunk_size / 2, "Instances", o_Plants1)
		
		//ds_list_add(objects, obj)
	}
}
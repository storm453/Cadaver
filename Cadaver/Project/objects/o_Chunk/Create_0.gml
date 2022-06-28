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
		
		//bfDraw(buffer, floor(idx * chunk_size + random(chunk_size)), random_y, 32, 32, (-random_y) / 1000, s_GrassTest, irandom(2), c_white, 1)
	}
	
	var zm = 256
	
	for(var i = 0; i < chunk_size / 16; i++)
	{
		for(var j = 0; j < chunk_size / 16; j++)
		{
			var nois = v3_div(v3(idx * chunk_size + i * 16, idy * chunk_size + j * 16,0), v3(zm))
			
			nois.x = floor(nois.x)
			nois.y = floor(nois.y)
			
			nois = v3_div(nois, v3(2))
			 
			bfDraw(buffer, idx * chunk_size + i * 16, idy * chunk_size + j * 16, 16, 16, 0, s_ChunkTest, 0, noise(nois) * 255, 0.5)
		}
	}
	
	bfFinish(buffer)
	
	var zm = irandom_range(50, 1000)

	var current_noise = noise(v3_div(v3(idx * chunk_size, idy * chunk_size, 0), v3(650)))
}
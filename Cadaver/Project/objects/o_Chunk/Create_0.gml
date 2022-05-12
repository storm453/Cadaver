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
}
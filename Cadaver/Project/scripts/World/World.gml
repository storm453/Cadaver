function check_adjacent(parent)
{
	var right = instance_place(x + 8, y, all)
	
	if(right != noone)
	{
		if(right.object_index == o_Pipe)
		{
			with(right) check_adjacent(parent)
		}
		if(right.object_index == o_Storage)
		{
			ds_list_add(parent.outputs, right.id)
		}
	}
}

function create_obj_chunk(object, xx, yy)
{
	var obj = instance_create_layer(xx, yy, "World", object)	
	
	ds_list_add(objects, obj)
}

function create_drop(xx, yy, item, amt)
{
	var drop = instance_create_layer(xx, yy, "Instances", o_ItemDropped)
	
	drop.data = { item: item, amt: amt }
}

function enemy_create(arg_hp = 10, arg_armor = 0, arg_knock_res = 0)
{
	return { hp: arg_hp, protection: 1 - (0.045 * arg_armor), knock_resistance: 1 - (0.05 * arg_knock_res), arg_knock_x : 0, arg_knock_y: 0, hit : 0 }	
}

function create_multiblock(arg_name, arg_gui, arg_item)
{
	return { name: arg_name, to_gui: arg_gui, block_item: arg_item }
}

function spawn_enemy(radius_min, radius_max, obj)
{
	var random_angle = irandom(360)
	
	randomize()
	var radius = irandom_range(radius_min, radius_max)
	
	var ex = sin(random_angle) * radius + o_Player.x;
	var ey = cos(random_angle) * radius + o_Player.y;	

	instance_create_layer(ex, ey, "Instances", obj)
}

function create_light(arg_x, arg_y, range, color, brightness)
{
	instance_create_layer(arg_x, arg_y, "World", o_Light)
	
	o_Light.color = color
	o_Light.range = range
	o_Light.brightness = brightness
}
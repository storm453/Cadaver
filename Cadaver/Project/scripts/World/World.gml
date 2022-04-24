function check_adjacent(parent)
{
	var right = instance_place(x + 8, y, all)
	
	if(right != -4)
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

function enemy_create(arg_hp = 10, arg_armor = 0, arg_knock_res = 0)
{
	return { hp: arg_hp, protection: 1 - (0.045 * arg_armor), knock_resistance: 1 - (0.05 * arg_knock_res), arg_knock_x : 0, arg_knock_y: 0 }	
}

function create_multiblock(arg_gui, arg_check_inv, arg_check_data, arg_shift_inv, arg_shift_data, arg_crafting_level = 0)
{
	return { to_gui: arg_gui, check_inv: arg_check_inv, check_dat: arg_check_data, shift_inv: arg_shift_inv, shift_dat: arg_shift_data, crafting_level: arg_crafting_level }
}

function spawn_enemy(radius, obj)
{
	var random_angle = irandom(360)
	
	var ex = sin(random_angle) * radius + o_Player.x;
	var ey = cos(random_angle) * radius + o_Player.y;	

	instance_create_layer(ex, ey, "Instances", obj)
}
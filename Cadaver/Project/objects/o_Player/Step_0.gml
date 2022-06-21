z = -bbox_bottom

rotation = lerp(rotation, 90, 0.1)
melee_rot = lerp(melee_rot, 0, 0.1)

tool_cooldown--

part_system_depth(part_sys, -20)

//all logic involving attacking and item types for hotbar item
if(global.hotbar_sel_item != 0)
{
	var hotbar_item_data = global.items_list[global.hotbar_sel_item.item].item_data

	if(hotbar_item_data.item_type == item_types.melee)
	{
		if(attack_cooldown <= 0)
		{
			if(attack)
			{
				gave_item = false
				dealt_damage = false
				attack_cooldown = attack_cooldown_set

				melee_rot = -135

				//instance_create_layer(x, y,  "Instances", o_Swing)

				image_index = 0

				state = player_state.attack
			}
		}
	}

	var tool = false
	
	if(global.hotbar_sel_item == 0) tool = true
	if(hotbar_item_data.item_type == item_types.tool) tool = true

	
}

//check list movable if player should be able to move in this gui state
var move = true

for(var i = 0; i < ds_list_size(list_movable); i++)
{
	if(global.current_gui == list_movable[|i])
	{
		move = false
	}
}

if(!move) exit;

if(hp <= 0) state = player_state.dead

script_execute(scripts_array[state])
	
//opening up objects with 'E'
var scan = instance_nearest(x, y, o_Multiblock)

if(keyboard_check_pressed(ord("E")))
{
	if(global.current_gui == gui.NONE)
	{
		if(global.open_instance == noone)
		{
			scan_distance = distance_to_object(scan)

			if(scan_distance < 10)
			{
				global.open_instance = scan
				global.current_gui = global.open_instance.block_data.to_gui
			}
		}
	}
}

attack_cooldown--
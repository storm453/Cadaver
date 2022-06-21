//draw blueprint in phsyical world
if(selected_bp != noone)
{
	var sprite = object_get_sprite(selected_bp)
	
	var sw = sprite_get_width(sprite)
	var sh = sprite_get_height(sprite)
	
	var ox = 16 * floor(mouse_x / 16)
	var oy = 16 * floor(mouse_y / 16)
		
	var collision = collision_rectangle(ox, oy, ox + sw, oy + sh, all, false, true)
	
	var color = c_lime
	var build = true
	
	if(collision != noone)
	{
		if(object_get_parent(collision.object_index) == o_Harvestable)
		{
			build = false
			color = c_red
		}
		if(object_get_parent(collision.object_index) == o_Collision)
		{
			build = false
			color = c_red
		}
	}
	
	if(build)
	{
		if(mouse_check_button_pressed(mb_left))
		{
			if(sel_bp_id != -1)
			{
				instance_create_layer(ox, oy, "World", selected_bp)

				for(var i = 0; i < array_length_1d(blueprints[|sel_bp_id].need); i++)
				{
					var itm = blueprints[|sel_bp_id].need[i].item
					var amt = blueprints[|sel_bp_id].need[i].amt
				
					remove_item(o_PlayerInventory.inv, o_PlayerInventory.inv_data, itm, amt)
				}
			
				selected_bp = noone
			}
		}	
	}
	
	draw_sprite_ext(sprite, 0, ox, oy, 1, 1, 0, color, 0.5)
}
//draw housing
if(global.hotbar_sel_item != 0)
{
	if(global.hotbar_sel_item.item == items.hammer)
	{
		var bp_op = housing[|selected_housing].obj
		var sprite = object_get_sprite(bp_op)
		
		var sw = sprite_get_width(sprite)
		var sh = sprite_get_height(sprite)
		
		var ox = 16 * floor(mouse_x / 16)
		var oy = 16 * floor(mouse_y / 16)
		
		var collision = collision_rectangle(ox + 2, oy + 2, ox + sw - 4, oy + sh - 4, all, false, true)
		
		var color = c_red
		
		if(hos_build)
		{
			if(collision == noone)
			{
				color = c_lime
			
				if(mouse_check_button_pressed(mb_left))
				{
					instance_create_layer(ox, oy, "World", bp_op)	
					
					var need_arr = housing[|selected_housing].need
			
					for(var i = 0; i < array_length_1d(need_arr); i++)
					{
						remove_item(o_PlayerInventory.inv, o_PlayerInventory.inv_data, need_arr[i].item, need_arr[i].amt)	
					}
				}
			}
		}
		
		draw_sprite_ext(sprite, 0, ox, oy, 1, 1, 0, color, 0.5)
	}
}
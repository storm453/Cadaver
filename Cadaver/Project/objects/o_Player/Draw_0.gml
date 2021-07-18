draw_self()
  
anim += 0.2

var tile_size = 16

var item_draw_scale = 0.5
var distance = 1

var draw_x = x + (distance) * image_xscale
var draw_y = y - sprite_height / 2

var attackable = false
var buildable = false

if(global.hotbar_sel_item == 0)
{
	attackable = true	
}

if(global.hotbar_sel_item != 0)
{
	draw_sprite_ext(s_Items, o_InventoryBase.items_list[global.hotbar_sel_item[0]].spr_index, draw_x, draw_y, image_xscale * item_draw_scale, item_draw_scale, 0, c_white, 1)

	if(variable_struct_exists(o_InventoryBase.items_list[global.hotbar_sel_item[0]], "item_data"))
	{
		var struct = variable_struct_get(o_InventoryBase.items_list[global.hotbar_sel_item[0]], "item_data")

		if(struct.item_type == item_types.weapon)
		{
			attackable = true
		}
		
		if(struct.item_type == item_types.building)
		{
			buildable = true		
		}
	}
}	

if(buildable)
{
	var mouse_tile_x = floor(mouse_x / tile_size) * tile_size
	var mouse_tile_y = floor(mouse_y / tile_size) * tile_size
	
	draw_sprite_ext(s_Slot, 0, mouse_tile_x, mouse_tile_y, 1, 1, 0, c_lime, 0.2)
	
	if(mouse_check_button_pressed(mb_left))
	{
		o_PlayerInventory.inv[global.hotbar_sel, o_PlayerInventory.slots_y - 1] = 0
		instance_create_layer(mouse_tile_x, mouse_tile_y, "Instances", struct.building_obj)
	}
}

if(attackable)
{
	if(attack)
	{
		if(attack_cooldown <= 0)
		{
			gave_item = false
			attack_cooldown = attack_cooldown_set
		}
	}

	if(attack_cooldown > attack_duration)
	{
		rec_x = x + 10 * image_xscale
		rec_y = y - sprite_height
		
		var attack_rec = collision_rectangle(rec_x, rec_y, rec_x + attack_range * image_xscale, rec_y + attack_range, all, false, true)
	
		ui_draw_rectangle(rec_x, rec_y, attack_range * image_xscale, attack_range, c_red, 1, true)
		
		show_debug_message(attack_rec)
		
		for(var i = 0; i < array_length_1d(resource_drops); i++)
		{
			if(attack_rec != -4)
			{
				if(attack_rec.object_index == resource_drops[i].object)
				{
					if(!gave_item)
					{
						gave_item = true
			
						var index = resource_drops[i]
				
						for(var j = 0; j < array_length_1d(resource_drops[i].drops); j++)
						{
							randomize()
							if(chance(index.drops[j].chnce))
							{
								o_PlayerInventory.add_item(index.drops[j].uid, irandom_range(index.drops[j].amt_min, index.drops[j].amt_max))
							}
						}
					}
				}
			}
		}
	}
}
ds_list_add(o_RenderManager.entities, self)

z = 0

list_movable = ds_list_create()

ds_list_add(list_movable, gui.INVENTORY)
ds_list_add(list_movable, gui.PROFILE)
ds_list_add(list_movable, gui.JOURNAL)
ds_list_add(list_movable, gui.LOOT)

spawn_x = x
spawn_y = y

hp = 100;
energy = 100;

energy_time = 60

//energy timer
alarm[0] = energy_time

walk_speed = 100 
acceleration = 50

velocity = vec2(0, 0);

state = player_state.idle

enum player_state
{
	idle,
	run,
	attack,
	dead
}

attack_cooldown_set = 60
attack_cooldown = 0

attack_range = 25
gave_item = false
dealt_damage = false

swing_angle = 0

resource_drops = array_create(2)

//Tree 1
resource_drops[0] =
{
  	object: o_Tree1,
	  
 	all_drops: array
	(
		{ item: items.air, drops:  array( { uid : items.wood, amt_min : 3, amt_max : 6, chnce : 1 } ) }, 
		{ item: items.stonehatchet, drops: array( { uid : items.wood, amt_min : 5, amt_max : 11, chnce : 1 } ) },
	)
}

//Rock 1
resource_drops[1] =
{
	object: o_Rock1,

	all_drops: array
	(
		{ item: items.air, drops:  array( { uid : items.stone, amt_min : 1, amt_max : 3, chnce : 1 } ) }, 
		{ item: items.pickaxe, drops:  array( { uid : items.stone, amt_min : 3, amt_max : 7, chnce : 1 }, { uid : items.rawmetal, amt_min : 2, amt_max : 4, chnce: 0.5 } ) }
	)
}

//Bush
resource_drops[2] =
{
	object: o_Plants1,

	all_drops: array
	(
		{ item: items.air, drops:  array( { uid : items.plants, amt_min : 2, amt_max : 4, chnce : 1 } ) }, 
		{ item: items.basicknife, drops: array( { uid : items.plants, amt_min : 2, amt_max : 7, chnce : 1 }, { uid : items.rareplants, amt_min : 1, amt_max : 1, chnce : 0.1 } ) }
	)
}

// Bush
// resource_drops[2] =
// {
// 	object: o_Plants1,
// 	drops : array
// 	(
// 		{ uid : 17, amt_min : 1, amt_max : 3, chnce : 1 },
// 		{ uid : 31, amt_min : 1, amt_max : 1, chnce : 0.1 }
// 	)
// }

// //Bush
// resource_drops[3] =
// {
// 	object: o_Plants2,
// 	drops : array
// 	(
// 		{ uid : 34, amt_min : 1, amt_max : 3, chnce : 0.5 },
// 		{ uid : 36, amt_min : 2, amt_max : 7, chnce : 1 }
// 	)
// }

enemies_list = ds_list_create()

ds_list_add(enemies_list, o_Mutant)
ds_list_add(enemies_list, o_Walker)

anim = 0

#region player functions
function input()
{
	in_x = keyboard_check(ord("D")) - keyboard_check(ord("A"))
	in_y = keyboard_check(ord("S")) - keyboard_check(ord("W"))
	
	shift = keyboard_check(vk_shift);	
	attack = mouse_check_button(mb_left)
}

sprites_array[player_state.idle] = s_Player
sprites_array[player_state.run] = s_PlayerRun
sprites_array[player_state.attack] = s_PlayerAttack
sprites_array[player_state.dead] = s_PlayerDead

function movement() 
{
	var move_speed = walk_speed
	var target_velocity = vec_mul(vec_normalized(vec2(in_x, in_y)), vec2(move_speed))

	var velocity_change = vec_sub(target_velocity, velocity)
	var velocity_increase = vec_mul(velocity_change, vec2(acceleration * get_delta_time()))

    if (vec_length(velocity_increase) > vec_length(velocity_change)) velocity_increase = velocity_change
	
	velocity = vec_add(velocity, velocity_increase)

	// move the player
	if(!place_meeting(x + velocity.x * get_delta_time(), y, o_Collision))
	{
		x += velocity.x * get_delta_time()
	}
	
	if(!place_meeting(x, y + velocity.y * get_delta_time(), o_Collision))
	{
		y += velocity.y * get_delta_time()	
	}
}

function player_animation() 
{
	sprite = sprites_array[state]

	sprite_index = sprite

	var sign_mouse = sign(mouse_x - x)

	if(sign_mouse == 0) 
	{
		sign_mouse = 1
	}

    if(in_x != 0 && sign(in_x) != sign_mouse) 
	{
		image_speed = -1
	}
	else {
		image_speed = 1
	}
	
	if(sign_mouse != 0)
	{
		image_xscale = sign_mouse;	
	}
}
#endregion

function render_shadow()
{
	
}

function render()
{
	draw_self()
  
	anim += 0.2

	var tile_size = 16

	var item_draw_scale = 0.5
	var distance = 1

	var draw_x = x + (distance) * image_xscale
	var draw_y = y - sprite_height / 2

	var melee = false
	var ranged = false
	var buildable = false
	var consumable = false

	if(global.hotbar_sel_item == 0)
	{
		melee = true	
	}

	if(global.hotbar_sel_item != 0)
	{
		var struct = variable_struct_get(global.items_list[global.hotbar_sel_item.item], "item_data")

		if(struct.item_type == item_types.consumable)
		{
			consumable = true
		}

		if(struct.item_type == item_types.melee)
		{
			melee = true
		}
	
		if(struct.item_type == item_types.building)
		{
			buildable = true		
		}
		
		if(struct.item_type == item_types.ranged)
		{
			ranged = true	
		}
	}	

	if(melee)
	{
		if(attack_cooldown <= 0)
		{
			if(attack)
			{
				//@TEMP
				if(global.current_gui != gui.BLUEPRINT)
				{
					gave_item = false
					dealt_damage = false
					attack_cooldown = attack_cooldown_set

					instance_create_layer(x, y,  "Instances", o_Swing)

					image_index = 0

					state = player_state.attack
				}	
			}
		}
	}	

	if(consumable)
	{
		draw_sprite_ext(s_Items, global.items_list[global.hotbar_sel_item.item].spr_index, draw_x, draw_y, image_xscale * item_draw_scale, item_draw_scale, 0, c_white, 1)

		if(mouse_check_button_pressed(mb_left))
		{
			attack_cooldown = 60

			var slot_y = o_PlayerInventory.inv_data.slots_y - 1

			o_Player.hp += global.items_list[global.hotbar_sel_item.item].item_data.hp
			o_Player.energy += global.items_list[global.hotbar_sel_item.item].item_data.energy

			remove_item_slot(o_PlayerInventory.inv, o_PlayerInventory.inv_data, 1, global.hotbar_sel, slot_y)
		}
	}

	if(buildable)
	{
		var mouse_tile_x = floor(mouse_x / tile_size) * tile_size
		var mouse_tile_y = floor(mouse_y / tile_size) * tile_size
	
		if(global.in_hand == 0)
		{
			var free = 1
			var preview_col = c_lime
			
			var check = -tile_size
			
			repeat(3)
			{
				check += tile_size
				
				if(place_meeting(mouse_tile_x + check, mouse_tile_y + check, all))
				{
					free = 0
					preview_col = c_red
				}
				if(place_meeting(mouse_tile_x - check, mouse_tile_y - check, all))
				{
					free = 0
					preview_col = c_red
				}
			}
			
			draw_sprite_ext(s_Tile, 0, mouse_tile_x, mouse_tile_y, 1, 1, 0, preview_col, 1)
				
			if(mouse_check_button_pressed(mb_left))
			{
				//@TEMP
				o_PlayerInventory.inv[global.hotbar_sel, o_PlayerInventory.inv_data.slots_y - 1].amt--	
			
				if(o_PlayerInventory.inv[global.hotbar_sel, o_PlayerInventory.inv_data.slots_y - 1].amt <= 0)
				{
					o_PlayerInventory.inv[global.hotbar_sel, o_PlayerInventory.inv_data.slots_y - 1] = 0
				}

				instance_create_layer(mouse_tile_x, mouse_tile_y, "Instances", struct.building_obj)
			}
		}
		
	}

	if(ranged)
	{
		//draw_sprite_ext(s_Items, o_InventoryBase.global.items_list[global.hotbar_sel_item[0]].spr_index, draw_x, draw_y, image_xscale * item_draw_scale, item_draw_scale, point_direction(x, y,  mouse_x, mouse_y), c_white, 1)	
	}
}
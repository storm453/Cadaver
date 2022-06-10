//@Declare(o_Player)
ds_list_add(o_RenderManager.entities, self)

//x = random_range(-1000, 1000)
//y = random_range(-1000, 1000)

instance_create_layer(x, y, "Meta", o_Camera)

global.linking = noone

test_x = 0

hurt_alpha = 0

z = 0

list_movable = ds_list_create()

ds_list_add(list_movable, gui.INVENTORY)
ds_list_add(list_movable, gui.PROFILE)
ds_list_add(list_movable, gui.JOURNAL)
ds_list_add(list_movable, gui.LOOT)
ds_list_add(list_movable, gui.BASE)
ds_list_add(list_movable, gui.SELECTBLUE)

spawn_x = x
spawn_y = y

//@Field(spawn_x, float)
//@Field(spawn_y, float)

//@Field(x, float)
//@Field(y, float)

hp = 100; //@Field(hp, float)
energy = 100; //@Field(energy, float)

energy_time = 0
heal_duration = 0

walk_speed = 50 
acceleration = 50

velocity = vec2(0, 0);

part_sys = part_system_create()

state = player_state.idle

enum player_state
{
	idle,
	run,
	walk,
	attack,
	dead
}

attack_cooldown_set = 60
attack_cooldown = 0

attack = 0

attack_range = 25
gave_item = false
dealt_damage = false

swing_angle = 0

resource_drops = array_create(2)

//Tree 1
resource_drops[0] =
{
  	object: o_Tree1,
	  
 	all_drops: 0
	//array
	//(
		//{ item: items.stonehatchet, drops: array( { uid : items.log, amt_min : 3, amt_max : 7, chnce : 1 } ) }
	//)
}

resource_drops[1] =
{
  	object: o_Tree2,
	  
 	all_drops: array
	(
		{ item: items.stonehatchet, drops: array( { uid : items.log, amt_min : 1, amt_max : 3, chnce : 1 } ) },
	)
}

//Rock 1
resource_drops[2] =
{
	object: o_Rock1,

	all_drops: array
	(
		{ item: items.pickaxe, drops:  array( { uid : items.stone, amt_min : 4, amt_max : 7, chnce : 1 } ) }
	)
}

//Bush
resource_drops[3] =
{
	object: o_Plants1,

	all_drops: array
	(
		{ item: items.air, drops:  array( { uid : items.plants, amt_min : 2, amt_max : 4, chnce : 1 }, { uid : items.stick, amt_min : 1, amt_max : 3, chnce : 0.8 } ) },
		{ item: items.stonehatchet, drops: array( { uid : items.plants, amt_min : 3, amt_max : 6, chnce : 1 }, { uid : items.stick, amt_min : 2, amt_max : 5, chnce : 1 } ) }
	)
}
resource_drops[4] =
{
	object: o_Plants3,

	all_drops: array
	(
		{ item: items.air, drops:  array( { uid : items.plants, amt_min : 2, amt_max : 4, chnce : 1 } ) }
	)
}
resource_drops[5] =
{
	object: o_Coal,

	all_drops: array
	(
		{ item: items.pickaxe, drops:  array( { uid : items.coal, amt_min : 2, amt_max : 4, chnce : 1 } ) }
	)
}
resource_drops[6] =
{
	object: o_Iron,

	all_drops: array
	(
		{ item: items.pickaxe, drops:  array( { uid : items.ironore, amt_min : 2, amt_max : 4, chnce : 1 } ) }
	)
}

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
	attack = mouse_check_button_pressed(mb_left)
}

rotation = 0
melee_rot = 0

tool_cooldown = 0
tool_cooldown_set = 30

sprites_array[player_state.idle] = s_Player
sprites_array[player_state.walk] = s_PlayerWalk
sprites_array[player_state.run] = s_PlayerRun
sprites_array[player_state.attack] = s_PlayerAttack
sprites_array[player_state.dead] = s_PlayerDead

function movement(spd = 1) 
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
		x += velocity.x * get_delta_time() * spd
	}
	
	if(!place_meeting(x, y + velocity.y * get_delta_time(), o_Collision))
	{
		y += velocity.y * get_delta_time() * spd	
	}
}

function player_animation() 
{
	switch(state)
	{
		case(player_state.idle):
		case(player_state.walk):
			if(!global.hotbar_sel_item) 
			{
				sprite_index = s_Player
			}
			else
			{
				sprite_index = s_PlayerAttack
			}
		break;
		
		case(player_state.run):
			sprite_index = s_PlayerRun
		break;
	}

	//image_xscale and sacaling
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

flash_alpha = 0

function render_shadow()
{
	
}

function render()
{
	draw_self()

	//drawing items on player or anytihng else.
	if(global.hotbar_sel_item != 0)
	{
		var hotbar_item_data = global.items_list[global.hotbar_sel_item.item].item_data

		var tool = false
		
		if(hotbar_item_data.item_type = item_types.tool) tool = true
		if(global.hotbar_sel_item == 0) tool = true

		var item_draw_scale = 1
		var distance = 1

		var draw_x = x + (distance) * image_xscale
		var draw_y = y - sprite_height / 2 + 2

		var hand_sprite = global.items_list[global.hotbar_sel_item.item].item_data.hand_sprite

		if(hotbar_item_data.item_type == item_types.melee)
		{
			var melee_angle = (point_direction(x, y, mouse_x, mouse_y) + 90) + (melee_rot * image_xscale)
			
			draw_sprite_ext(hand_sprite, 0, draw_x, draw_y, image_xscale * item_draw_scale, item_draw_scale, melee_angle, c_white, 1)
		}	
		if(tool)
		{
			var correct_tool = false
		
			var selected = collision_circle(mouse_x, mouse_y, 10, o_Harvestable, false, true)

			if(selected != -4) 
			{
				//DROPS
				for(var i = 0; i < array_length_1d(resource_drops); i++)
				{
					if(selected != noone)
					{
						//IF NOT -4 GIVE RESOURCES BECAUSE ITS RESOURCE DROPS
						if(selected.object_index == resource_drops[i].object)
						{
							var drops_array = resource_drops[i].all_drops

							for(var j = 0; j < array_length_1d(drops_array); j++)
							{
								var do_item_check = (global.hotbar_sel_item.item == drops_array[j].item)
								
								if(global.hotbar_sel_item == 0) do_item_check = true
								
								if(do_item_check) 
								{
									correct_tool = true
									
									if(mouse_check_button(mb_left))
									{	
										if(tool_cooldown <= 0)
										{
											tool_cooldown = tool_cooldown_set

											rotation = -90

											var sel_x = selected.x + (sprite_get_width(selected.sprite_index) / 2)
											var sel_y = selected.y + (sprite_get_height(selected.sprite_index) / 4) * 3

											selected.hp--

											if(selected.hp <= 0)
											{
												instance_destroy(selected)

												//you are using an item that exists, gets drops from there
												var item_drops = drops_array[j].drops

												for(var k = 0; k < array_length_1d(item_drops); k++)
												{
													if(random(1) < item_drops[k].chnce)
													{
														var drop_amt = irandom_range(item_drops[k].amt_min, item_drops[k].amt_max)
													
														repeat(drop_amt) create_drop(sel_x, sel_y, item_drops[k].uid, 1)
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}	
			
			draw_sprite_ext(hand_sprite, 0, draw_x, draw_y, image_xscale * item_draw_scale, item_draw_scale, rotation * image_xscale, c_white, 1)

			if(selected != noone)
			{
				with(selected)
				{
					if(correct_tool) draw_sprite_ext(test, 0, x, y, sprite_width / 16, sprite_height / 16, 0, c_white, 0.5)
				}
			}
		}
	}
	else
	{
		//fists
		var selected = collision_circle(mouse_x, mouse_y, 10, o_Harvestable, false, true)

		if(selected == noone)
		{
			//allow attacking because nothing selecteds!
			if(attack_cooldown <= 0)
			{
				if(attack)
				{
					gave_item = false
					dealt_damage = false
					attack_cooldown = attack_cooldown_set

					melee_rot = -135

					instance_create_layer(x, y,  "Instances", o_Swing)

					image_index = 0

					state = player_state.attack
				}
			}
		}
		else
		{
			var correct_tool = false
			
			//tool time
			for(var i = 0; i < array_length_1d(resource_drops); i++)
			{
				if(selected != noone)
				{
					//IF NOT -4 GIVE RESOURCES BECAUSE ITS RESOURCE DROPS
					if(selected.object_index == resource_drops[i].object)
					{
						var drops_array = resource_drops[i].all_drops

						for(var j = 0; j < array_length_1d(drops_array); j++)
						{
							if(global.hotbar_sel_item == drops_array[j].item)
							{
								correct_tool = true
								
								if(mouse_check_button(mb_left))
								{	
									if(tool_cooldown <= 0)
									{
										tool_cooldown = tool_cooldown_set

										var sel_x = selected.x + (sprite_get_width(selected.sprite_index) / 2)
										var sel_y = selected.y + (sprite_get_height(selected.sprite_index) / 4) * 3

										selected.hp--
										selected.flash_alpha = 1

										part_particles_create(part_sys, mouse_x, mouse_y, global.pt_basic, 5)	
										
										if(selected.hp <= 0)
										{
											instance_destroy(selected)

											part_particles_create(part_sys, mouse_x, mouse_y, global.pt_basic, 25)	

											//you are using an item that exists, gets drops from there
											var item_drops = drops_array[j].drops

											for(var k = 0; k < array_length_1d(item_drops); k++)
											{
												if(random(1) < item_drops[k].chnce)
												{
													var drop_amt = irandom_range(item_drops[k].amt_min, item_drops[k].amt_max)
													
													repeat(drop_amt) create_drop(sel_x, sel_y, item_drops[k].uid, 1)
												}
											}
										
											return;
										}
									}
								}
							}
						}
					}
					
					with(selected)
					{
						if(correct_tool) draw_sprite_ext(test, 0, x, y, sprite_width / 16, sprite_height / 16, 0, c_white, 0.5)
					}
				}
			}
		}
	}
}
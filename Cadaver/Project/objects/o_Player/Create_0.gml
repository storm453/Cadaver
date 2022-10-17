//@Declare(o_Player)
ds_list_add(o_RenderManager.entities, self)

light = instance_create_layer(x, y, "Instances", o_Light)

walk_speed = 50 
acceleration = 50

velocity = vec2(0, 0);

//x = random_range(-1000, 1000)
//y = random_range(-1000, 1000)

instance_create_layer(x, y, "Meta", o_Camera)

global.linking = noone

test_x = 0

hurt_alpha = 0

z = 0

list_movable = ds_list_create()

ds_list_add(list_movable, gui.INVENTORY)

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

part_sys = part_system_create()
part_system_depth(part_sys, -20)

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
		{ item: items.stonehatchet, drops: array( { uid : items.wood, amt_min : 1, amt_max : 3, chnce : 1 } ) },
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
		{ item: items.air, drops:  array( { uid : items.plantfibers, amt_min : 2, amt_max : 4, chnce : 1 }, { uid : items.wood, amt_min : 1, amt_max : 3, chnce : 0.8 } ) },
		{ item: items.stonehatchet, drops: array( { uid : items.plantfibers, amt_min : 3, amt_max : 6, chnce : 1 }, { uid : items.wood, amt_min : 2, amt_max : 5, chnce : 1 } ) }
	)
}
resource_drops[4] =
{
	object: o_Plants3,

	all_drops: array
	(
		{ item: items.air, drops:  array( { uid : items.plantfibers, amt_min : 2, amt_max : 4, chnce : 1 } ) }
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

ds_list_add(enemies_list, o_Infected)
ds_list_add(enemies_list, o_Walker)

anim = 0

rotation = 0
melee_rot = 0

tool_cooldown = 0
tool_cooldown_set = 30

scripts_array[player_state.idle] = player_idle
scripts_array[player_state.walk] = player_walk
scripts_array[player_state.run] = player_run
scripts_array[player_state.attack] = player_attack
scripts_array[player_state.dead] = player_dead

sprites_array[player_state.idle] = s_Player
sprites_array[player_state.walk] = s_PlayerWalk
sprites_array[player_state.run] = s_PlayerRun
sprites_array[player_state.attack] = s_PlayerAttack
sprites_array[player_state.dead] = s_PlayerDead

//circle melee hitbox
py = 0
			
angle = 0

ex = 0
ey = 0

flash_alpha = 0

mine_distance = 20

check = 0

function render()
{
	part_system_depth(part_sys, 1000)
	
	draw_self()

	//move col x & y
	py = y - 10

	angle = point_direction(x, py, mouse_x, mouse_y)

	ex = cos(angle * 2 * pi / 360) * 25 + x
	ey = -sin(angle * 2 * pi / 360) * 25 + py

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
		
			var selected = collision_circle(mouse_x, mouse_y, 10, all, false, true)

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
							if(distance_to_object(selected) <= mine_distance)
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
												selected.flash_alpha = 1

												part_particles_create(part_sys, sel_x, sel_y, global.pt_basic, 5)	

												if(selected.hp <= 0)
												{
													part_particles_create(part_sys, sel_x, sel_y, global.pt_basic, 25)	
												
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
				
				//ENEMY
				var enemy = enemies_list

				for(var i = 0; i  < ds_list_size(enemy); i++)
				{
					if(selected.object_index == enemy[|i])
					{
						if(distance_to_object(selected) <= mine_distance)
						{
							//enemy hovered over
							with(selected)
							{
								draw_sprite_ext(test, 0, x - sprite_width / 2, y - sprite_height, sprite_width / 16, sprite_height / 16, 0, c_white, 0.5)
							}
								
							if(mouse_check_button(mb_left))
							{	
								if(tool_cooldown <= 0)
								{
									tool_cooldown = tool_cooldown_set

									rotation = -90

									selected.enemy_data.hp -= global.items_list[global.hotbar_sel_item.item].item_data.damage

									part_particles_create(part_sys, selected.x, selected.y - selected.sprite_height / 2, global.pt_blood, 5)	
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
		if(hotbar_item_data.item_type == item_types.building)
		{
			var obj = hotbar_item_data.building_obj
			
			var build_spr = object_get_sprite(obj)
			var build_w = sprite_get_width(build_spr)
			var build_h = sprite_get_height(build_spr)
			
			var build_x = floor(mouse_x / 16) * 16
			var build_y = floor(mouse_y / 16) * 16
			
			var build_clr = c_red
			
			//redo check
			check = collision_rectangle(build_x, build_y, build_x + build_w, build_y + build_h, all, 0, 1)
			
			if(hotbar_item_data.building_obj = o_Floor)
			{
				check = collision_rectangle(build_x + 2, build_y + 2, build_x + 12, build_y + 12, all, 1, 1)	
			}

			if(hotbar_item_data.building_obj = o_WallCenter)
			{
				check = collision_rectangle(build_x + 2, build_y + 4, build_x + (build_w - 8), build_y + 8, all, 1, 1)
				
				//wall
				var right = place_meeting(build_x + 18, build_y	+ 4, o_Floor)
				draw_point_color(build_x + 18, build_y + 4, c_lime)
				
				var left = place_meeting(build_x - 4, build_y + 4, o_Floor)
				draw_point_color(build_x - 4, build_y + 4, c_red)
				
				draw_point_color(build_x + 1, build_y, c_white)
				
				if(!place_meeting(build_x + 1, build_y, o_Floor))
				{
					if(right)
					{
						if(!left)
						{
							build_spr = s_WallSideRight
							obj = o_WallSide
						}
					}
					if(!right)
					{
						if(left)
						{
							build_spr = s_WallSideLeft
							obj = o_WallSide
						}
					}
				}
			}

			//check = col

			if(check == noone || o_Floor)
			{
				build_clr = c_lime
				
				if(mouse_check_button_pressed(mb_left))
				{
					remove_item_slot(o_PlayerInventory.inv, 1, global.hotbar_sel_slot, array_height(o_PlayerInventory.inv) - 1)	
					
					instance_create_layer(build_x, build_y, "World", obj)
				}	
			}

			draw_sprite_ext(build_spr, 0, build_x, build_y, 1, 1, 0, build_clr, 1)
			
			ui_draw_rectangle(build_x + 2, build_y + 4, build_w - 8, 8, c_red, 0.5, false)
		}
	}
	else
	{
		//fists
		var selected = collision_circle(mouse_x, mouse_y, 10, o_Harvestable, false, true)

		if(selected == noone)
		{
			//draw hitbox for fists
			draw_set_alpha(0.1)
			draw_circle_color(ex, ey, 10, c_red, c_maroon, 0)
			draw_set_alpha(1)
			
			//allow attacking because nothing selecteds!
			if(attack_cooldown <= 0)
			{
				if(attack)
				{
					gave_item = false
					dealt_damage = false
					attack_cooldown = attack_cooldown_set

					melee_rot = -135

					swing()

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
						if(distance_to_object(selected) <= mine_distance)
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

											swing()

											var sel_x = selected.x + (sprite_get_width(selected.sprite_index) / 2)
											var sel_y = selected.y + (sprite_get_height(selected.sprite_index) / 4) * 3

											selected.hp--
											selected.flash_alpha = 1

											part_particles_create(part_sys, sel_x, sel_y, global.pt_basic, 5)	
										
											if(selected.hp <= 0)
											{
												instance_destroy(selected)

												part_particles_create(part_sys, sel_x, sel_y, global.pt_basic, 25)	

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
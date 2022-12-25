z = -bbox_bottom

//check list movable if player should be able to move in this gui state
var move = true

for(var i = 0; i < ds_list_size(list_movable); i++)
{
	if(global.current_gui == list_movable[|i])
	{
		move = false
	}
}

//NIPUT
in_x = keyboard_check(ord("D")) - keyboard_check(ord("A"))
in_y = keyboard_check(ord("S")) - keyboard_check(ord("W"))
	
shift = keyboard_check(vk_shift);	
attack = mouse_check_button_pressed(mb_left)
attack_held = mouse_check_button(mb_left)

//change sprite index based on state
sprite_index = sprites_array[state]

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

if(keyboard_check_pressed(ord("I")))
{
	instance_create_layer(mouse_x, mouse_y, "World", o_Infected)
}

//animation exceptions here

if(!move) exit;

sel_breakable = noone

function check_if_attack()
{
	if(attack_cooldown <= 0)
	{
		//harvest
		var harv_check = collision_circle(mouse_x, mouse_y, 5, o_Harvestable, 1, 1)

		if(harv_check != noone)
		{
			if(harv_check.type != -1)
			{
				var get_drops = resource_drops[harv_check.type]

				for(var i = 0; i < array_length_1d(get_drops); i++)
				{
					var needed_tool = get_drops[i].tool

					var tool_check = 0
					var tier_check = 1
					
					if(global.hotbar_sel_item != 0)
					{
						tool_check = global.hotbar_sel_item.item
						tier_check = global.items_list[global.hotbar_sel_item.item].item_data.tier
					}
					
					if(tool_check == needed_tool)
					{
						sel_breakable = harv_check
						
						if(attack)
						{
							harv_check.hp--
							harv_check.flash_alpha = 1
							harv_check.bounce = 10
	
							var harv_spawn_x = harv_check.x + sprite_get_width(harv_check.sprite_index) / 2
							var harv_spawn_y = harv_check.y + sprite_get_height(harv_check.sprite_index) / 2

							part_particles_create(part_sys, harv_spawn_x, harv_spawn_y, global.pt_basic, 5)

							if(harv_check.hp <= 0) 
							{
								var cur_tool_drops_array = get_drops[i].drops

								for(var j = 0; j < array_length_1d(cur_tool_drops_array); j++)
								{
									var drop_percent = random(1) + 0.1
									
									var drop_amt = round(drop_percent * (irandom_range(cur_tool_drops_array[j].min_amt, cur_tool_drops_array[j].max_amt)))
										
									repeat(drop_amt) create_drop(harv_spawn_x, harv_spawn_y, cur_tool_drops_array[j].item, 1)
								}
								
								instance_destroy(harv_check)

								o_Camera.shake = 1
							}
						}
					}
				}
			}
		}
		
		if(attack)
		{
			var item_check = collision_circle(mouse_x, mouse_y, 5, o_ItemDropped, 1, 1)

			if(item_check != noone)
			{
				state = player_state.pickup
				return;
			}

			var sweep_list = ds_list_create()
			
			collision_circle_list(ex, ey, attack_radius, o_WorldParent, 0, 1, sweep_list, 1)
			
			for(var i = 0; i < ds_list_size(sweep_list); i++)
			{
				var sweep_index = sweep_list[|i]
				
				if(sweep_index != noone)
				{
					for(var j = 0; j < ds_list_size(enemies_list); j++)
					{
						if(sweep_index.object_index = enemies_list[|j])
						{
							//damage
							var dmg = 1
							
							if(global.hotbar_sel_item != 0)
							{
								dmg = global.items_list[global.hotbar_sel_item.item].item_data.damage	
							}
							
							sweep_index.enemy_data.hp -= dmg
							 
							var player = move_towards(sweep_index)
							
							//knockback
							sweep_index.enemy_data.arg_knock_x = 2 * player.x
							sweep_index.enemy_data.arg_knock_y = 2 * player.y
						}
					}
				}
			}
			
			attack_cooldown = 0.6
			
			state = player_state.attack
			image_index = 0
		}
	}
}

function check_if_block()
{
	if(mouse_check_button_pressed(mb_right))
	{
		state = player_state.block	
	}
}

attack_cooldown -= get_delta_time()

//check what state and run certain code depending on state
if(state = player_state.idle)
{
	movement()
	check_if_attack()
	check_if_block()
	
	//if player is moving shift to either walk or run
	if(vec_length(velocity) > walk_speed / 2) 
	{
		if(!shift)
		{
			state = player_state.walk
		}
		else
		{
			state = player_state.run	
		}
	}
}
else if(state = player_state.walk)
{
	movement()
	check_if_attack()
	check_if_block()
	
	if(vec_length(velocity) < walk_speed / 2) 
	{
		state = player_state.idle
	}
	if(shift)
	{
		state = player_state.run		
	}
	
	//if(shift) state = player_state.run
}
if(state = player_state.run)
{
	movement(2)
	
	if(!shift) 
	{
		state = player_state.walk	
	}
	if(vec_length(velocity) < walk_speed / 2) 
	{
		state = player_state.idle
	}
}
if(state = player_state.attack)
{
	check_if_block()
}
if(state = player_state.block)
{
	block_time += get_delta_time()	
	
	if(block_time >= block_end)
	{
		block_time = 0
		
		state = player_state.idle
	}
}

//music per biome
var near_x = floor(o_Player.x / chunk_size) * chunk_size
var near_y = floor(o_Player.y / chunk_size) * chunk_size

var chunk = instance_nearest(near_x, near_y, o_Chunk)
	
var block = chunk.grid[# floor((x - chunk.x) / tile_size), floor((y - chunk.y) / tile_size)]
	
//music manager	
if(block == tile.water)
{
	sprite_index = s_PlayerSwim
}
	
function volume(arg_x)
{
	if(arg_x < 3)
	{
		return arg_x / 3;	
	}
	else
	{
		return 1;	
	}
}

if(songs[block] == current_song)
{
	audio_state += (get_delta_time()) * 2
		
	if(audio_state > 10) audio_state = 10
}
else
{
	audio_state -= (get_delta_time()) * 2
		
	if(audio_state <= 0) 
	{
		audio_state = 0

		old_block = playing_block

		array_set(song_position, old_block, floor(song_playtime))

		audio_stop_sound(current_song)
	}
}

song_playtime += get_delta_time()

if(audio_state == 0)
{
	current_song = songs[block]	
		
	var change = audio_play_sound(current_song, 0, 1)

	playing_block = block

	song_playtime = 0

	audio_sound_set_track_position(change, song_position[block])
}
	
audio_sound_gain(current_song, volume(audio_state), 0)

rotation = lerp(rotation, 90, 0.1)
melee_rot = lerp(melee_rot, 0, 0.1)

tool_cooldown--

part_system_depth(part_sys, -20)

//kill player if low health
if(hp <= 0) state = player_state.dead

//opening up objects with 'E'

for(var i = 0; i < instance_number(o_Multiblock); i++)
{
	var cur_multiblock = instance_find(o_Multiblock, i)
	
	var distance_check = distance_to_object(cur_multiblock)

	if(current_multi == noone)
	{
		current_multi = cur_multiblock
	}
	else
	{
		var current_distance = distance_to_object(current_multi)

		print(round(current_distance))
		print(round(distance_check))

		if(distance_check < current_distance)
		{
			current_multi = cur_multiblock
		}
	}
}

var scan = current_multi

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
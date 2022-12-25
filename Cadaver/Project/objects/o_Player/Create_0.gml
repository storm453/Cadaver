//@Declare(o_Player)
ds_list_add(o_RenderManager.entities, self)

//light = instance_create_layer(x, y, "Instances", o_Light)

#macro interact_range 10

outline_init()

walk_speed = 50 
acceleration = 50

display_time = 7

velocity = vec2(0, 0);

//x = random_range(-1000, 1000)
//y = random_range(-1000, 1000)

instance_create_layer(x, y, "Meta", o_Camera)

songs[tile.grass] = a_MusicPlains
songs[tile.water] = a_MusicOcean
songs[tile.sand] = a_MusicOcean
songs[tile.waterdeep] = a_MusicDeep
songs[tile.dirt] = a_MusicNight
songs[tile.stone] = a_MusicOcean
songs[tile.infected] = a_MusicWastelands	

song_playtime = 0

song_position = array_create(tile.length, 0)

old_block = 0
playing_block = 0

current_song = a_MusicPlains
audio_play_sound(current_song, 1, 1)

audio_state = 0

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
	block,
	pickup,
	dead
}

attack_cooldown_set = 60
attack_cooldown = 0
attack_radius = 10

block_time = 0
block_end = 0.4

attack = 0

attack_range = 25
gave_item = false
dealt_damage = false

swing_angle = 0

sel_breakable = noone

//test
//resource_test[resources.tree] = 

function make_drop(arg_item, arg_min, arg_max)
{
	return { item: arg_item, min_amt: arg_min, max_amt: arg_max }
}

resource_drops = array_create(2)

resource_drops[resources.plants1] = array
(
	{ tool: items.stonehatchet, drops: array( make_drop(items.wood, 6, 11) ) },
	{ tool: items.sturdyaxe, drops: array( make_drop(items.wood, 11, 17) ) }
)

resource_drops[resources.plants2] = array
(
	{ tool: items.stonehatchet, drops: array( make_drop(items.plantfibers, 0, 21), make_drop(items.wood, 0, 16) ) },
	{ tool: items.sturdyaxe, drops: array( make_drop(items.plantfibers, 0, 31), make_drop(items.wood, 0, 26) ) }
)

resource_drops[resources.plants3] = array
(
	{ tool: items.air, drops: array( make_drop(items.flax, 2, 5) ) },
	{ tool: items.stonehatchet, drops: array( make_drop(items.plantfibers, 0, 21), make_drop(items.wood, 0, 16) ) },
	{ tool: items.sturdyaxe, drops: array( make_drop(items.plantfibers, 0, 31), make_drop(items.wood, 0, 26) ) }
)

resource_drops[resources.stone1] = array
(
	{ tool: items.pickaxe, drops: array( make_drop(items.stone, 0, 23) ) },
	{ tool: items.sturdypickaxe, drops: array( make_drop(items.stone, 0, 40) ) }
)

resource_drops[resources.iron1] = array
(
	{ tool: items.pickaxe, drops: array( make_drop(items.ironore, 0, 23) ) },
	{ tool: items.sturdypickaxe, drops: array( make_drop(items.ironore, 0, 35) ) }
)

resource_drops[resources.tree1] = array
(
	{ tool: items.sturdyaxe, drops: array( make_drop(items.wood, 0, 50) ) }
)

enemies_list = ds_list_create()

ds_list_add(enemies_list, o_Infected)

anim = 0

rotation = 0
melee_rot = 0

tool_cooldown = 0
tool_cooldown_set = 30

sprites_array[player_state.idle] = s_Player
sprites_array[player_state.walk] = s_PlayerWalk
sprites_array[player_state.run] = s_PlayerRun
sprites_array[player_state.pickup] = s_PlayerPickup
sprites_array[player_state.attack] = s_PlayerAttack
sprites_array[player_state.block] = s_PlayerBlock
sprites_array[player_state.dead] = s_PlayerDead

//circle melee hitbox
py = 0
			
angle = 0

ex = 0
ey = 0

flash_alpha = 0

mine_distance = 20

check = 0


current_multi = noone

multi_buttons_list = ds_list_create()

ds_list_add(multi_buttons_list, { text: "USE", type: 0, button_spr: s_KeyE } )
ds_list_add(multi_buttons_list, { text: "MOVE", type: 0, button_spr: s_KeyR } )
ds_list_add(multi_buttons_list, { text: "BREAK", type: 0, button_spr: s_KeyX } )

function render()
{
	//if(current_multi != noone) draw_line(x, y, current_multi.x + sprite_get_width(current_multi.sprite_index) / 2, current_multi.y)
	
	part_system_depth(part_sys, 1000)
	
	//draw_circle(mouse_x, mouse_y, 5, true)
	
	draw_self()

	//move col x & y
	py = y - 10

	angle = point_direction(x, py, mouse_x, mouse_y)

	ex = cos(angle * 2 * pi / 360) * 25 + x
	ey = -sin(angle * 2 * pi / 360) * 25 + py

	draw_set_alpha(0.1)
	draw_set_color(c_red)
	//draw_circle(ex, ey, attack_radius, 0)

	//drawing items on player or anytihng else.
	if(global.hotbar_sel_item != 0)
	{	
		var hotbar_item_data = global.items_list[global.hotbar_sel_item.item].item_data
		
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
}
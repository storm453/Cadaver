//@Declare(o_Player)
ds_list_add(o_RenderManager.entities, self)

x = random_range(-1000, 1000)
y = random_range(-1000, 1000)

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

rotation = 0

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

	//drawing items on player or anytihng else.
	if(global.hotbar_sel_item != 0)
	{
		var hotbar_item_data = global.items_list[global.hotbar_sel_item.item].item_data

		var item_draw_scale = 1
		var distance = 1

		var draw_x = x + (distance) * image_xscale
		var draw_y = y - sprite_height / 2 + 2

		if(hotbar_item_data.item_type == item_types.melee)
		{
			draw_sprite_ext(s_Test2, 0, draw_x, draw_y, image_xscale * item_draw_scale, item_draw_scale, rotation * image_xscale, c_white, 1)
		}
		if(hotbar_item_data.item_type = item_types.tool)
		{
			var selected = instance_position(mouse_x, mouse_y, o_Harvestable)

			draw_sprite_ext(s_Test, 0, draw_x, draw_y, image_xscale * item_draw_scale, item_draw_scale, rotation * image_xscale, c_white, 1)

			if(selected != noone)
			{
				with(selected)
				{
					draw_sprite_ext(test, 0, x, y, sprite_width / 16, sprite_height / 16, 0, c_white, 0.5)
				}
			}
		}
	}
}
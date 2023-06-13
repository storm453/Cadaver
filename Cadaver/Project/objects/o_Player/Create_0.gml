ds_list_add(o_RenderManager.entities, self)

z = 0

type = parent_type.world

#macro interact_range 10

instance_create_layer(x, y, "Meta", o_Camera)

player_state = make_enum()

is_animal = false
is_parasite = false

hit_alpha = 0

handle_damage = true

function on_damage()
{
	hit_alpha = 1.4	
	goto_state(player_state.hit)
}

add_enum(player_state, "idle")
add_enum(player_state, "walk")
add_enum(player_state, "attack")
add_enum(player_state, "run")
add_enum(player_state, "dash")
add_enum(player_state, "death")
add_enum(player_state, "dead")
add_enum(player_state, "hit")
add_enum(player_state, "rest")
add_enum(player_state, "raise")

state = player_state.idle

state_timer_enabled = false
state_timer = 0
state_timer_next = player_state.idle

sprites_array[player_state.idle] = s_Player
sprites_array[player_state.walk] = s_PlayerWalk
sprites_array[player_state.run] = s_PlayerRun
sprites_array[player_state.dash] = s_PlayerDash
sprites_array[player_state.attack] = s_PlayerAttack
sprites_array[player_state.death] = s_PlayerDeath
sprites_array[player_state.dead] = s_PlayerDead
sprites_array[player_state.hit] = s_PlayerHurt
sprites_array[player_state.raise] = s_PlayerRaise
sprites_array[player_state.rest] = s_PlayerRest

disable_move = []

array_push(disable_move, gui.INVENTORY)

dash_dir = 0

global.temperature = 45
damagable = true
hp = 10
energy = 10

hit_state_next = 0
hit_state_was_timer_enabled = 0
hit_state_timer = 0

knockback_target = noone
knockback_velocity = vec2(0, 0)

velocity_dampen = 5

current_multi = noone

iframes_set = 20

attack_circle = vec2(0, 0)
attack_distance = 25
attack_radius = 15

attack_cooldown = 0
attack_cooldown_set = 0.6
attack_time = 0.25
attacked = false

walk_speed = 50 
dash_speed = 4
acceleration = 50
velocity = vec2(0, 0);

mouse_angle = 0
attack_angle = 0
swing_scale = 1.5

part_sys = part_system_create()

part_system_automatic_draw(part_sys, false)

function render()
{
	part_system_drawit(part_sys)
	
	if(state == player_state.dash)
	{
		draw_sprite_ext(sprite_index, 0, x, y, 1, 1, 0, c_aqua, 1)
	}
	else
	{
		draw_self()
	}
	
	if(global.db_enemy)
	{
		draw_set_color(c_red)
		draw_set_alpha(0.1)
		draw_circle(attack_circle.x, attack_circle.y, attack_radius, false)
	}
	
	if(state == player_state.attack)
	{
		var _swing_point = circle_point(x, y - 20, attack_distance * 1.5, attack_angle)
		var _swing_alpha = 1 - 1 * (state_timer / attack_time)
		
		draw_sprite_ext(s_Swing, 0, _swing_point.x, _swing_point.y, 1, 1, attack_angle, c_white, _swing_alpha)
	}
       
	if(state == player_state.rest)
	{
		var _swing_point = circle_point(x, y - 20, attack_distance * 1.5, attack_angle)
		
		draw_sprite_ext(s_Swing, 0, _swing_point.x, _swing_point.y, 1, 1, attack_angle, c_white, 1)
	}
}
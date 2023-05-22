ds_list_add(o_RenderManager.entities, self)

z = 0

type = parent_type.world

#macro interact_range 10

instance_create_layer(x, y, "Meta", o_Camera)

player_state = make_enum()

is_animal = false

handle_damage = false

add_enum(player_state, "idle")
add_enum(player_state, "walk")
add_enum(player_state, "attack")
add_enum(player_state, "run")
add_enum(player_state, "dash")

state = player_state.idle

state_timer_enabled = false
state_timer = 0
state_timer_next = player_state.idle

sprites_array[player_state.idle] = s_Player
sprites_array[player_state.walk] = s_PlayerWalk
sprites_array[player_state.run] = s_PlayerRun
sprites_array[player_state.dash] = s_PlayerDash
sprites_array[player_state.attack] = s_PlayerAttack

disable_move = []

array_push(disable_move, gui.INVENTORY)

dash_dir = 0

global.temperature = 45
damagable = true
hp = 10
energy = 10

current_multi = noone

attack_circle = vec2(0, 0)
attack_distance = 15
attack_radius = 15

attack_cooldown = 0
attack_cooldown_set = 0.6

walk_speed = 50 
dash_speed = 4
acceleration = 50
velocity = vec2(0, 0);

mouse_angle = 0
swing_scale = 1.5

part_sys = part_system_create()

part_system_depth(part_sys, -20)

function render()
{
	part_system_depth(part_sys, 1000)

	draw_self()
	
	if(global.db_enemy)
	{
		draw_set_color(c_red)
		draw_set_alpha(0.1)
		draw_circle(attack_circle.x, attack_circle.y, attack_radius, false)
	}
	
	if(state == player_state.attack)
	{
		var _swing_point = circle_point(x, y - 20, attack_distance * 1.5, mouse_angle)
		
		draw_sprite_ext(s_Swing, 0, _swing_point.x, _swing_point.y, swing_scale, swing_scale, mouse_angle, c_white, 1)
	}
}
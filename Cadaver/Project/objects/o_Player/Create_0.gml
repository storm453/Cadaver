animation = 0

z = 0

type = parent_type.world

alarm[0] = 180

#macro interact_range 10

player_state = make_enum()

is_animal = false
is_parasite = false

hit_alpha = 0
infect_alpha = 0

infectable = true
infected = false

handle_damage = true

function on_damage()
{
	hit_alpha = 1.4
}

add_enum(player_state, "idle")
add_enum(player_state, "walk")
add_enum(player_state, "run")
add_enum(player_state, "dash")
add_enum(player_state, "punch_light")
add_enum(player_state, "punch_heavy")
add_enum(player_state, "melee_light")
add_enum(player_state, "melee_heavy")

state = player_state.idle

state_timer_enabled = false
state_timer = 0
state_timer_next = player_state.idle

dash_time = 0.5
attack_time = 0.25

animation_array[player_state.idle] = make_animation(s_Player, 10)
animation_array[player_state.walk] = make_animation(s_PlayerWalk, 8)
animation_array[player_state.run] = make_animation(s_PlayerRun, 12)
animation_array[player_state.dash] = make_animation(s_PlayerDash, 0, dash_time)

animation_array[player_state.punch_light] = make_animation(s_PlayerPunchLight, 12)
trigger_animation(animation_array[player_state.punch_light], 2, function() { damage_circle(attack_circle.x, attack_circle.y, attack_radius, 1, 80) } )
end_animation(animation_array[player_state.punch_light], function() { goto_state(player_state.idle) } )

animation_array[player_state.punch_heavy] = make_animation(s_PlayerPunchHeavy, 8)
trigger_animation(animation_array[player_state.punch_heavy], 4, function() { damage_circle(attack_circle.x, attack_circle.y, attack_radius, 2, 240) } )
end_animation(animation_array[player_state.punch_heavy], function() { goto_state(player_state.idle) } )

animation_array[player_state.melee_light] = make_animation(s_PlayerAttackLight, 14)
trigger_animation(animation_array[player_state.melee_light], 3, function() { damage_circle(attack_circle.x, attack_circle.y, attack_radius, 2, 40) } )
end_animation(animation_array[player_state.melee_light], function() { goto_state(player_state.idle) } )

animation_array[player_state.melee_heavy] = make_animation(s_PlayerAttackHeavy, 8)
trigger_animation(animation_array[player_state.melee_heavy], 4, function() { damage_circle(attack_circle.x, attack_circle.y, attack_radius, 5, 120) } )
end_animation(animation_array[player_state.melee_heavy], function() { goto_state(player_state.idle) } )

set_animation(animation_array[state])

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
attacked = false

walk_speed = 50 
dash_speed_set = 180
dash_speed = dash_speed_set
acceleration = 50
velocity = vec2(0, 0);

mouse_angle = 0
attack_angle = 0
swing_scale = 1.5

part_sys = part_system_create()

part_system_automatic_draw(part_sys, false)

function render()
{
	//draw_circle(attack_circle.x, attack_circle.y, 15, false)
	
	part_system_drawit(part_sys)
	
	draw_self()
	
	if(global.db_enemy)
	{
		draw_set_color(c_red)
		draw_set_alpha(0.1)
		draw_circle(attack_circle.x, attack_circle.y, attack_radius, false)
	}
	
	if(global.hotbar_data != 0) draw_sprite_ext(s_Items, global.hotbar_data.item, x - 8, y - 16, 1, 1, 45, c_white, 1)
}



render_next = noone
render_prev = noone

o_RenderManager.add(self)
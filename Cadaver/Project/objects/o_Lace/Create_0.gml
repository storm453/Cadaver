event_inherited()

lace_state = make_enum()

add_enum(lace_state, "idle")
add_enum(lace_state, "roam")
add_enum(lace_state, "chase")
add_enum(lace_state, "charge")
add_enum(lace_state, "attack")
add_enum(lace_state, "rest")

state = lace_state.roam

animation_array[lace_state.idle] = make_animation(s_Lace, 5)
animation_array[lace_state.roam] = make_animation(s_LaceWalk, 12)
animation_array[lace_state.chase] = make_animation(s_LaceWalk, 12)
animation_array[lace_state.charge] = make_animation(s_Lace, 5)
animation_array[lace_state.attack] = make_animation(s_LaceAttack, 10)
animation_array[lace_state.rest] = make_animation(s_Lace, 5)

set_animation(animation_array[state])

is_damagable = true
parent_hp(3)

target_velocity = vec2(0, 0)

roam_target = vec2(0, 0)

function new_roam()
{
	roam_target.x = x + irandom_range(-150, 150)
	roam_target.y = y + irandom_range(-150, 150)
}

is_parasite = true

velocity_dampen = 3

player_angle = 0
state_timer = 0

idle_chance = 0.001
chase_distance = 120
charge_distance = 50
charge_time = 1
attack_time = 0.8

lace_speed = 30
acc = 10

custom_render = true

function my_render()
{
	if(state != lace_state.charge)
	{
		draw_self()
	}
	else
	{
		var _random_x = image_xscale + random(0.1)
		var _random_y = image_yscale + random(0.1)

		var _charge_alpha = 1 - (state_timer / charge_time)
		
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale + random(0.1), 1 + random(0.1), 0, c_white, 1)
		draw_sprite_ext(sprite_index, image_index, x, y, _random_x, _random_y, 0, c_lime, _charge_alpha)
		
		draw_sprite_ext(s_Look, 0, x, y, 1, 1, player_angle, c_green, _charge_alpha)
	}
}
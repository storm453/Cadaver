event_inherited()

thread_choice = make_enum()

add_enum(thread_choice, "coil")
add_enum(thread_choice, "lace")

choice = choose(thread_choice.coil, thread_choice.lace)

part = part_system_create()

thread_state = make_enum()

add_enum(thread_state, "roam")
add_enum(thread_state, "flee")
add_enum(thread_state, "coil")
add_enum(thread_state, "charge")
add_enum(thread_state, "attack")

state = thread_state.roam

target_velocity = vec2(0, 0)

is_parasite = true
infects = 0

evolve_timer = 0

handle_damage = true

thread_speed = 40
acc = 10
roam_position = vec2(x, y)
flee_distance = 120
pounce_distance = 15
charge = false
pounce_timer = 0
pounce_speed = 175
attack_timer = 0

custom_render = true

parent_hp(2)

function on_damage()
{
	state = thread_state.flee
}

function new_roam()
{
	roam_position.x = x + irandom_range(-100, 100)
	roam_position.y = y + irandom_range(-100, 100)
}

function my_render()
{
	draw_self()
	
	if(state == thread_state.charge)
	{
		draw_sprite_ext(sprite_index, 0, x, y, image_xscale + random(0.05),  image_yscale + random(0.05), 0, c_red, 0.5)
	}

	if(global.db_enemy)
	{
		draw_set_color(c_red)
		draw_set_alpha(1)
		draw_circle(x, y, flee_distance, true)
	}
}
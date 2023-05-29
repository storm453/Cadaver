event_inherited()

thread_choice = make_enum()

add_enum(thread_choice, "coil")
add_enum(thread_choice, "infect")
add_enum(thread_choice, "lace")

choice = choose(thread_choice.coil, thread_choice.infect, thread_choice.lace)

part = part_system_create()

thread_state = make_enum()

add_enum(thread_state, "roam")
add_enum(thread_state, "flee")
add_enum(thread_state, "infect")
add_enum(thread_state, "coil")

state = thread_state.roam

target_velocity = vec2(0, 0)

is_parasite = true

evolve_timer = 0

handle_damage = true

thread_speed = 40
acc = 10
roam_position = vec2(x, y)
flee_distance = 120

custom_render = true

parent_hp(2)

function on_damage()
{
	state = thread_state.flee
	evolve_timer = 0
}

function new_roam()
{
	roam_position.x = x + irandom_range(-100, 100)
	roam_position.y = y + irandom_range(-100, 100)
}

function my_render()
{
	draw_self()
	
	if(global.db_enemy)
	{
		draw_set_color(c_red)
		draw_set_alpha(1)
		draw_circle(x, y, flee_distance, true)
	}
}
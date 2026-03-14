event_inherited()

custom_render = true

volant_state = make_enum()

add_enum(volant_state, "fly")
add_enum(volant_state, "attack")

state = volant_state.fly

acc = 1

fly_speed = 120
fly_target = vec2(x, y)

function my_render()
{
	draw_self()
	
	var _eye_pos = circle_point(x, y, 6, point_direction(x, y, o_Player.x, o_Player.y))
	
	draw_set_color(c_red)
	draw_set_alpha(1)
	draw_circle(_eye_pos.x, _eye_pos.y, 3, false)
}
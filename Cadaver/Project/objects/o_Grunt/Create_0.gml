event_inherited()

parent_hp(5)

hp_bar = true

custom_render = true

grunt_state = make_enum()

grunt_speed = 100
acc = 25
target_velocity = vec2(0, 0)

dash_timer = 0

is_parasite = true

add_enum(grunt_state, "idle")
add_enum(grunt_state, "move")
add_enum(grunt_state, "path")
add_enum(grunt_state, "charge")
add_enum(grunt_state, "attack")
add_enum(grunt_state, "rest")

state = grunt_state.idle

path = path_add()
path_timer = 0

attack_distance = 60
attack_circle_points = 0
attack_radius = 10
follow_distance = 240
attack_speed = 400

player_last_seen = vec2(0, 0)

function my_render()
{
	if(state != grunt_state.charge)
	{
		draw_self();	
	}
	else
	{
		draw_sprite_ext(s_Grunt, 0, x, y, 1 + random(0.1), 1 + random(0.1), 0, c_lime, 1)	
	}
	
	if(state != grunt_state.rest)
	{
		sprite_index = s_Grunt
	}
	else
	{
		sprite_index = s_GruntRest	
	}
	
	var _player_direction = point_direction(x, y, player_last_seen.x, player_last_seen.y)
	
	if(state == grunt_state.attack)
	{
		draw_sprite_ext(s_Swing, 0, attack_circle_points.x, attack_circle_points.y, 1 + random(0.2), 1 + random(0.2), _player_direction, c_white, 1)
	}
	
	if(global.db_enemy)
	{
		draw_set_color(c_lime)
		draw_set_alpha(1)
		draw_line_width(x, y - sprite_height / 2, o_Player.x, o_Player.y, 3)
		
		draw_set_color(c_red)
		draw_circle(attack_circle_points.x, attack_circle_points.y, attack_radius, true)
		
		draw_set_color(c_black)
		draw_set_alpha(1)
		draw_circle(x, y, follow_distance, true)
		
		draw_circle(x, y, attack_distance, true)
	}
}
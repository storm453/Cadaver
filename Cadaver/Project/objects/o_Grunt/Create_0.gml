z = 0

enum grunt_state
{
	idle,
	move,
	attack
}

path = path_add()
path_timer = 0
following = false

follow_distance = 150
state = grunt_state.idle

function render()
{
	draw_self();
	
	if(global.db_enemy)
	{
		draw_set_color(c_lime)
		draw_set_alpha(1)
		draw_line_width(x, y - sprite_height / 2, o_Player.x, o_Player.y, 3)
		
		draw_set_alpha(0.1)
		draw_circle(x, y, follow_distance, false)
	}
}

ds_list_add(o_RenderManager.entities, self)
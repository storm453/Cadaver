z = 0

outline_init()

flash_alpha = 0

enum resources
{
	plants1,
	plants2,
	stone1,
	iron1,
	tree1
}

event_user(0)

function render()
{
	//draw_self();

	var sprite_width_left = sprite_get_xoffset(sprite_index)
	var sprite_height_top = sprite_get_yoffset(sprite_index)

	var sprite_width_right = sprite_width - sprite_width_left
	var sprite_height_bottom = sprite_height - sprite_height_top
	
	var top_left = vec2(x - sprite_width_left, y - sprite_height_top)
	var top_right = vec2(x + sprite_width_right, y - sprite_height_top)

	var bottom_left = vec2(x - sprite_width_left, y + sprite_height_bottom)
	var bottom_right = vec2(x + sprite_width_right, y + sprite_height_bottom)

	//parallax
	var middle = vec2(top_left.x + sprite_width / 2, top_left.y + sprite_height / 2)

	var angle_to_player = point_direction(middle.x, middle.y, o_Player.x, o_Player.y)
	var dist_to_player = distance_to_point(o_Player.x, o_Player.y)

	var side_of_player = (x - o_Player.x) / dist_to_player

	var dif = vec2(o_Player.x - x, o_Player.y - y)

	var dif_h = sqrt(dif.x * dif.x + dif.y * dif.y)

	var mov = vec2(dif.x / dif_h, dif.y / dif_h)

	var parallax = vec2(-mov.x * dist_to_player / 25, mov.y * dist_to_player / 25)
	
	shader_set(sh_darken);

	draw_sprite_pos(sprite_index, image_index, top_left.x + parallax.x, top_left.y + parallax.y, top_right.x + parallax.x, top_right.y + parallax.y, bottom_right.x, bottom_right.y, bottom_left.x, bottom_left.y, 1)

	shader_reset()

	if(flash_alpha > 0)
	{
		flash_alpha -= 0.05
		
		shader_set(sdhr_flash)
		
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, flash_alpha)
		
		shader_reset()
	}
}

function render_shadow()
{
	//draw_sprite_ext(sprite_index, 0, x + sprite_width / 2, y + sprite_height / 2, 0.5, 0.8, 270, c_blue, 0.2 * (- o_GUI.day_factor / 2 + 0.5));	
	
	//draw_set_alpha(0.2 * (- o_GUI.day_factor / 2 + 0.5))
	//draw_circle_color(x + sprite_width / 2, y + sprite_height / 2, 15, c_blue, c_black, false)
}

ds_list_add(o_RenderManager.entities, self)
z = 0

outline_init()

flash_alpha = 0

position_uni = shader_get_uniform(shd_bright, "position")
sprite_height_uni = shader_get_uniform(shd_bright, "sprite_height")

sway = 0
sway_time = 0

bounce = 0;

enum resources
{
	plants1,
	plants2,
	plants3,
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

	var dist_to_player = distance_to_point(o_Player.x, o_Player.y)

	var dif = vec2(o_Player.x - x, o_Player.y - y)

	var dif_h = sqrt(dif.x * dif.x + dif.y * dif.y)

	var mov = vec2(dif.x / dif_h, dif.y / dif_h)
	
	sway_time += get_delta_time()
	
	sway = sin(sway_time)
	
	var bounce_effect = vec2(0,0)
	
	if(bounce > 0)
	{
		bounce_effect = vec2(bounce / 3, bounce / 2)
		
		bounce--
	}
	
	var parallax = vec2(-mov.x * dist_to_player / 25 * (sprite_width / 32) + sway, mov.y * dist_to_player / 25)

	//shader_set(shd_bright)
	
	//shader_set_uniform_f_array(position_uni, array(x, y + sprite_height_bottom))
	//shader_set_uniform_f(sprite_height_uni, sprite_height)
	
	draw_sprite_pos(sprite_index, image_index, top_left.x + parallax.x - bounce_effect.x, top_left.y + parallax.y + bounce_effect.y, top_right.x + parallax.x + bounce_effect.x, top_right.y + parallax.y, bottom_right.x + bounce_effect.x + bounce_effect.y, bottom_right.y, bottom_left.x - bounce_effect.x, bottom_left.y, 1)
	
	shader_reset()

	if(flash_alpha > 0)
	{
		flash_alpha -= 0.05
		
		shader_set(sdhr_flash)
		
		draw_sprite_pos(sprite_index, image_index, top_left.x + parallax.x - bounce_effect.x, top_left.y + parallax.y + bounce_effect.y, top_right.x + parallax.x + bounce_effect.x, top_right.y + parallax.y, bottom_right.x + bounce_effect.x + bounce_effect.y, bottom_right.y, bottom_left.x - bounce_effect.x, bottom_left.y, flash_alpha)
		
		shader_reset()
	}
	
	if(o_Player.sel_breakable == id)
	{
		draw_sprite_ext(s_Selector2, 0, top_left.x, top_left.y, 1, 1, 0, -1, 1)	
		
		draw_sprite_ext(s_Selector2, 0, top_right.x, top_right.y, 1, 1, -90, -1, 1)	
		
		draw_sprite_ext(s_Selector2, 0, bottom_right.x, bottom_right.y, 1, 1, 180, -1, 1)	
		
		draw_sprite_ext(s_Selector2, 0, bottom_left.x, bottom_left.y, 1, 1, 90, -1, 1)	
	}
}

ds_list_add(o_RenderManager.entities, self)
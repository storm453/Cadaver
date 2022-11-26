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
	draw_self();
	
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
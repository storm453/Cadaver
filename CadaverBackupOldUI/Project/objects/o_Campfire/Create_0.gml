z = 0

light = create_light(x + 8, y + 8, 0.2, c_yellow, 1)

function render()
{
	draw_self()
	
	//draw_sprite_ext(s_light, 0, x + sprite_width / 2, y + sprite_width / 2, image_xscale, image_yscale * 0.5, 0, c_yellow, 0.4 * (o_GUI.day_factor / 2 + 0.5));
}

function render_shadow()
{
	draw_sprite_ext(sprite_index, 0, x, y, 0.5, 0.8, 270, c_blue, 0.2 * (- o_GUI.day_factor / 2 + 0.5));	
}

ds_list_add(o_RenderManager.entities, self)
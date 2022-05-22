z = 0
alpha = 0

function render()
{
	var xx = x - sprite_width / 2
	var yy = y + sprite_height / 2
	
	draw_sprite(s_House, 1, xx, yy)
	draw_sprite_ext(s_House, 1, xx, yy, 1, 1, 0, c_black, alpha * 0.3)
	draw_sprite_ext(s_House, 0, xx, yy, 1, 1, 0, c_white, alpha)
}

function render_shadow()
{
	//draw_sprite_ext(sprite_index, 0, x, y, 0.5, 0.8, 270, c_blue, 0.2 * (- o_GUI.day_factor / 2 + 0.5));	
}

ds_list_add(o_RenderManager.entities, self)
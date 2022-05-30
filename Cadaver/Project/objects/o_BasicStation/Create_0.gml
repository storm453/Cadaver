z = 0

block_data = create_multiblock(gui.CRAFT)

moo = 0

dw = player_inv_width
dh = 400

dx = display_get_gui_width() / 2 - dw / 2
dy = display_get_gui_height() - player_inv_height - dh

start_x = dx

function render()
{
	draw_self();
}

function render_shadow()
{
	//draw_sprite_ext(sprite_index, 0, x + sprite_width / 2, y + sprite_height / 2, 0.5, 0.8, 270, c_blue, 0.2 * (- o_GUI.day_factor / 2 + 0.5));	
	
	//draw_set_alpha(0.2 * (- o_GUI.day_factor / 2 + 0.5))
	//draw_circle_color(x + sprite_width / 2, y + sprite_height / 2, 15, c_blue, c_black, false)
}

ds_list_add(o_RenderManager.entities, self)
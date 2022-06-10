z = 0

depth = -1

block_data = create_multiblock(gui.CRAFT)

selected_list = 0
selected_item = -1

categories = ds_list_create()

ds_list_add(categories, "Basic")
ds_list_add(categories, "Cat2")
ds_list_add(categories, "Cat3")
ds_list_add(categories, "Cat4")

dw = player_inv_width
dh = 400

dx = display_get_gui_width() / 2 - dw / 2
dy = display_get_gui_height() - player_inv_height - dh

sw = 250

lerp_x = dx - dw / 2

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
z = 0

radius = 100

level = 0

block_data = create_multiblock(gui.BASE, noone, noone, noone, noone)

queue_list = ds_list_create()

function render()
{
	draw_set_alpha(0.02)
	draw_circle_color(x + sprite_width / 2, y + sprite_width / 2, 50, c_aqua, c_blue, false)
	draw_set_alpha(1)
	
	draw_self();
}

function render_shadow()
{
	draw_sprite_ext(sprite_index, 0, x, y, 0.5, 0.8, 270, c_blue, 0.2 * (- o_GUI.day_factor / 2 + 0.5));	
}

ds_list_add(o_RenderManager.entities, self)
z = 0

open = false
inv_data = create_inv_data(3, 1, 10, 10, 3)
inv = create_inventory(inv_data.slots_x, inv_data.slots_y)

function render()
{
	draw_self();
	
	event_user(1)
}

function render_shadow()
{
	draw_sprite_ext(sprite_index, 0, x, y, 0.5, 0.8, 270, c_blue, 0.2 * (- o_GUI.day_factor / 2 + 0.5));	
}

ds_list_add(o_RenderManager.entities, self)
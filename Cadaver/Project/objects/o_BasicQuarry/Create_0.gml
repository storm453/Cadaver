z = 0

inv_data = create_inv_data(10, 1, 3)
inv = create_inventory(inv_data.slots_x, inv_data.slots_y)

block_data = create_multiblock(gui.LOOT, inv, inv_data, inv, inv_data)

ui_width = inv_data.slots_x * slot_size * inv_data.draw_scale
ui_height = 200

var ui_title_height = string_height_font("Title", ft_Title) + pad * 2

ui_x = display_get_gui_width() / 2 - ui_width / 2
ui_y = display_get_gui_height() - inv_height - ui_height - pad - ui_title_height

function render()
{
	draw_self();
}

function render_shadow()
{
	draw_sprite_ext(sprite_index, 0, x, y, 0.5, 0.8, 270, c_blue, 0.2 * (- o_GUI.day_factor / 2 + 0.5));	
}

ds_list_add(o_RenderManager.entities, self)
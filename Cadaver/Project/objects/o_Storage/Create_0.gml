z = 0

open = false
inv_data = create_inv_data(10, 5, 3)
inv = create_inventory(inv_data.slots_x, inv_data.slots_y)

loot_width = inv_data.slots_x * global.slot_size * inv_data.draw_scale
loot_height = inv_data.slots_y * global.slot_size * inv_data.draw_scale
var inv_title_height = string_height_font("Title", ft_Title) + pad * 2

inv_x = display_get_gui_width() / 2 - loot_width / 2
inv_y = display_get_gui_height() - inv_height - loot_height - inv_title_height  - pad

function render()
{
	draw_self();
}

function render_shadow()
{
	draw_sprite_ext(sprite_index, 0, x, y, 0.5, 0.8, 270, c_blue, 0.2 * (- o_GUI.day_factor / 2 + 0.5));	
}

ds_list_add(o_RenderManager.entities, self)
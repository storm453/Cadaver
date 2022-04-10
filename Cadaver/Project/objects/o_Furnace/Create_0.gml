z = 0

counter = 0

//ui / panel
#macro furn_width 325
#macro furn_height 400
	
work_window_x = display_get_gui_width() / 2 + inv_width / 2 + pad
work_window_y = display_get_gui_height() - inv_height - craft_height - pad

//inv
burn_timer = 0
open = false
on = false

fuel_inv_data = create_inv_data(1, 1, 3)
fuel_inv = create_inventory(fuel_inv_data.slots_x, fuel_inv_data.slots_y)

smelt_inv_data = create_inv_data(3, 1, 3)
smelt_inv = create_inventory(smelt_inv_data.slots_x, smelt_inv_data.slots_y)

stored_inv_data = create_inv_data(5, 1, 3)
stored_inv = create_inventory(stored_inv_data.slots_x, stored_inv_data.slots_y)

crafted_inv_data = create_inv_data(5, 1, 3)
crafted_inv = create_inventory(crafted_inv_data.slots_x, crafted_inv_data.slots_y)

queue_list = ds_list_create()

smelted = array(0, 0, 0)

function render()
{
	if(on) draw_sprite_ext(s_light, 0, x + sprite_width / 2, y + sprite_width / 2, image_xscale / 2, image_yscale / 2 * 0.5, 0, c_yellow, 0.4 * (o_GUI.day_factor / 2 + 0.5));
	
	draw_self();
}

function render_shadow()
{
	draw_sprite_ext(sprite_index, 0, x, y, 0.5, 0.8, 270, c_blue, 0.2 * (- o_GUI.day_factor / 2 + 0.5));	
}

ds_list_add(o_RenderManager.entities, self)
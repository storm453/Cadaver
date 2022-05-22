z = 0

counter = 0

open = false
inv_data = create_inv_data(6, 1, 3)
inv = create_inventory(inv_data.slots_x, inv_data.slots_y)

block_data = create_multiblock(gui.INVENTORY, o_PlayerInventory.inv, o_PlayerInventory.inv_data, inv, inv_data, crafting_lvls.WORKBENCH)

queue_list = ds_list_create()

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
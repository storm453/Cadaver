z = 0

outputs = ds_list_create()
input = instance_place(x - 8, y, o_Storage)

transfer_timer_set = 30
transfer_timer = transfer_timer_set

check_adjacent(id)

function render()
{
	draw_self();
}

function render_shadow()
{
	draw_sprite_ext(sprite_index, 0, x, y, 0.5, 0.8, 270, c_blue, 0.2 * (- o_GUI.day_factor / 2 + 0.5));	
}

ds_list_add(o_RenderManager.entities, self)
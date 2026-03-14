z = 0

light = instance_create_layer(x + sprite_width / 2, y + sprite_height / 2, "World", o_Light)

part_sys = part_system_create()
part_system_depth(part_sys, -20)

function render()
{
	draw_self();
}

ds_list_add(o_RenderManager.entities, self)
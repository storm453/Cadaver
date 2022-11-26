z = 0

nearest_chunk = noone

function render()
{
	draw_self();

	draw_path(path, x, y, 1)
}

path = path_add()

alarm[0] = 120

ds_list_add(o_RenderManager.entities, self)
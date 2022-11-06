z = 0

depth = -1

block_data = create_multiblock(gui.CRAFT)

block_data.misc.station = stations.workbench

function render()
{
	draw_self();
}

ds_list_add(o_RenderManager.entities, self)
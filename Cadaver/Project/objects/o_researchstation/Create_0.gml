z = 0

depth = -1

inv = create_inventory(1, 1)

research_width = sprite_get_width(s_ResearchUI) * inv_scale
research_height = sprite_get_height(s_ResearchUI) * inv_scale

block_data = create_multiblock(gui.CONTAINER)

rui_x_set = display_get_gui_width() / 2 - research_width / 2
rui_y_set = display_get_gui_height() / 2 - player_inv_height / 2 + inv_offset - pad - research_height

messages_log = ds_list_create()
log_del_timer = 0

researching = false
research_prog = 0

researched = ds_list_create()

//recipes unlocked
unlocks_list[items.stone] = array(global.recipes[items.stonehatchet], global.recipes[items.pickaxe])

function render()
{
	draw_self();
}

ds_list_add(o_RenderManager.entities, self)
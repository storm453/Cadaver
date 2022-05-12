z = 0

block_data = create_multiblock(gui.INVENTORY, -4, -4, -4, -4, 0, 0, 1, 5)

function render()
{
	draw_self();
	
	if(global.current_gui == gui.WIRE)
	{
		var link_size = 5
	
		var out_x = x + sprite_width / 2 - link_size / 2
		var out_y = y + sprite_width / 2
	
		if(block_data.elecout[0] == noone)
		{
			var out_button = rm_draw_button_color(out_x, out_y, link_size, link_size, c_red, c_maroon, c_white, false)
			if(out_button[0])
			{
				global.linking = id
			}
		}
	}
}

function render_shadow()
{
	draw_sprite_ext(sprite_index, 0, x, y, 0.5, 0.8, 270, c_blue, 0.2 * (- o_GUI.day_factor / 2 + 0.5));	
}

ds_list_add(o_RenderManager.entities, self)
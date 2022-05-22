z = 0

block_data = create_multiblock(gui.INVENTORY, -4, -4, -4, -4, 0, 3, 0)

function render()
{
	draw_self();
	
	var link_size = 5

	var in_x = x + sprite_width / 2 - link_size / 2
	var in_y = y

	var slots_free = false
	
	for(var i = 0; i < array_length_1d(block_data.elecin); i++)
	{
		if(block_data.elecin[i] == noone)
		{
			slots_free = true	
		}
	}

	if(global.current_gui == gui.WIRE)
	{
		if(slots_free)
		{
			var in_button = rm_draw_button_color(in_x, in_y, link_size, link_size, c_lime,  c_green, c_white, false)
			if(in_button[0])
			{
				if(global.linking != noone)
				{
					for(var i = 0; i < array_length_1d(block_data.elecin); i++)
					{
						if(block_data.elecin[i] == noone)
						{
							//input is free
							block_data.elecin[i] = global.linking
					
							if(global.linking != noone)
							{
								global.linking.block_data.elecout[0] = id	
							}
					
							global.linking = noone
						}
					}
				}
			}
		}
	}
	
	for(var i = 0; i < array_length_1d(block_data.elecin); i++)
	{
		if(block_data.elecin[i] != noone)
		{
			var line_x = x + sprite_width / 2
			var line_y = y + 4
			
			var target_x = block_data.elecin[i].x + block_data.elecin[i].sprite_width / 2
			var target_y = block_data.elecin[i].y +4
			
			draw_set_color(c_black)
			draw_line_width(line_x, line_y, target_x, target_y, 1.5)
		}
	}
}

function render_shadow()
{
	draw_sprite_ext(sprite_index, 0, x, y, 0.5, 0.8, 270, c_blue, 0.2 * (- o_GUI.day_factor / 2 + 0.5));	
}

ds_list_add(o_RenderManager.entities, self)
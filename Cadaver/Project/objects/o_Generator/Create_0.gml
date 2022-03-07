z = 0

linked = noone

function render()
{
	draw_self()
	
	var in = rm_draw_button_color(x + 6, y + 6, 15, 15, c_red, c_maroon, c_white, false)
	if(in[0])
	{
		if(global.linker_id != -4)
		{
			if(global.linker_id = id)
			{
				if(mouse_check_button_pressed(mb_left))
				{
					global.linking = id
				}
			}
		}	
	}
	
	if(global.linking == id)
	{
		draw_line(x + 10, y + 10, mouse_x, mouse_y)	
	}
	
	if(linked != noone)
	{
		draw_set_color(c_black)
		draw_line(x + 10, y + 10, linked.object_index.x + 10, linked.object_index.y + 10)
	}
}

function render_shadow()
{
	
}

ds_list_add(o_RenderManager.entities, self)
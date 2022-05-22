z = 0

linked = noone
power_recieve = 0
power_needed = 5

function render()
{
	draw_self()
	
	var in = rm_draw_button_color(x + 6, y + 6, 15, 15, c_lime, c_green, c_white, false)
	if(in[0])
	{
		if(global.linking != -4)
		{
			global.linking.linked = id
			global.linking = -4
		}
	}
}

function render_shadow()
{
	
}

ds_list_add(o_RenderManager.entities, self)
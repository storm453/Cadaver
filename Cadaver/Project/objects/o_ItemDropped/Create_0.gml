z = 0
data = 0

outline_init()

randomize()
dx = random(2) - 1
dy = random(2) - 1

my = y

dl = sqrt(dx * dx + dy * dy)
dx /= dl
dy /= dl

spd = random_range(0.35, 0.5)

zz = 0
vz = 1

grav = -0.1

up = false

window_set_cursor(cr_none)

function render()
{
	//pick up and draw contents text
	if(point_in_rectangle(mouse_x, mouse_y, x - 8, y - 8, x + 8, y + 8))
	{
		outline_start(1, c_white)
		
		cursor_sprite = s_HandCursor
		
		if(mouse_check_button_pressed(mb_left))
		{
			if(spd == 0)
			{
				if(!up)
				{
					up = true
				
					add_item(o_PlayerInventory.inv, data.item, data.amt)
				}
			}
		}
		
		var item_name = global.items_list[data.item].name
		
		//ui_draw_string(x, y, string(item_name) + " x" + string(data.amt), ft_Small)
	}
	else
	{
		outline_end()
	}
	
	//6ui_draw_rectangle(x - 8, y - 8, 16, 16, c_white, 0.5, 0)
	
	draw_self()

	outline_end()
}

ds_list_add(o_RenderManager.entities, self)
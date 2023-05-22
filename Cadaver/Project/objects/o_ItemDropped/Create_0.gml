event_inherited()

custom_render = true

data = { item: items.wood, amt: 3 }

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

function my_render()
{
	//pick up and draw contents text
	if(point_in_rectangle(mouse_x, mouse_y, x - 8, y - 8, x + 8, y + 8))
	{
		outline_start(2, c_white)

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
	
	draw_self()

	outline_end()
}
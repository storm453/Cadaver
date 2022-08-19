z = 0
data = 0

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

function render()
{
	draw_self();
	
	//pick up and draw contents text
	if(point_in_rectangle(o_Player.x, o_Player.y, x - 2, y -2, x + 18, y + 18))
	{
		if(spd == 0)
		{
			if(!up)
			{
				up = true
				
				add_item(o_PlayerInventory.inv, data.item, data.amt)
			}
		}
		
		var item_name = global.items_list[data.item].name
		
		//ui_draw_string(x, y, string(item_name) + " x" + string(data.amt), ft_Small)
	}
}

ds_list_add(o_RenderManager.entities, self)
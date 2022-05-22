z = 0
data = 0

randomize()
dx = random(2) - 1
dy = random(2) - 1

my = y

dl = sqrt(dx * dx + dy * dy)
dx /= dl
dy /= dl

spd = 0.5

zz = 0
vz = 1

grav = -0.1

function render()
{
	draw_self();
	
	//pick up and draw contents text
	if(point_in_rectangle(mouse_x, mouse_y, x, y, x + 10, y + 10))
	{
		if(spd == 0)
		{
			if(mouse_check_button(mb_left))
			{
				add_item(o_PlayerInventory.inv, o_PlayerInventory.inv_data, data.item, data.amt)

				instance_destroy()	
			}
		}
		
		var item_name = global.items_list[data.item].name
		
		//ui_draw_string(x, y, string(item_name) + " x" + string(data.amt), ft_Small)
	}
}

function render_shadow()
{

}

ds_list_add(o_RenderManager.entities, self)
z = 0

function render()
{
	outline_init()
	
	//outline if selected
	if(o_Player.current_multi == id)
	{
		if(distance_to_object(o_Player) <= 10)
		{
			outline_start(1, c_lime)
		}
	}
	
	draw_self();
	
	
	
	outline_end()
}

ds_list_add(o_RenderManager.entities, self)
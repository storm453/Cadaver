z = 0

damagable = false
custom_render = false

function damage_info()
{
	return {  }	
}

function render()
{
	if(custom_render)
	{
		my_render()	
	}
	else
	{
		draw_self();	
	}
}

ds_list_add(o_RenderManager.entities, self)
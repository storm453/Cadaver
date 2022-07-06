global.entities = ds_list_create()

function render_game()
{
	//loop through entities & draw
	for(var i = 0; i < ds_list_size(global.entities); i++)
	{
		//run render
		global.entities[|i].render()
	}
}
function render_game()
{
	// sort depths:

	ds_list_clear(render_list);
ds_list_copy(render_list, entities);

	for (var i = 0; i < ds_list_size(render_list); i++) {
	  var closest = i;
	  for (var j = i + 1; j < ds_list_size(render_list); j++) {
	    if (render_list[|closest].z < render_list[|j].z) {
	      closest = j;
	    }
	  }

	  var a = render_list[|closest];
	  render_list[|closest] = render_list[|i];
	  render_list[|i] = a;
	}
	
	draw_sprite_tiled(s_DirtTest, 0, 0, 0)
	
	for(var i = 0; i < ds_list_size(render_list); i++)
	{
		render_list[|i].render_shadow()
	}
	
	for(var i = 0; i < ds_list_size(render_list); i++)
	{
		render_list[|i].render()
	}
}

entities = ds_list_create()
render_list = ds_list_create()
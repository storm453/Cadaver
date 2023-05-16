//open inventory iwth tab or ecsape
if(keyboard_check_pressed(vk_tab) or keyboard_check_pressed(vk_escape))
{
	var to_gui = gui.INVENTORY
	
	if(global.current_gui != 0)
	{
		to_gui = gui.NONE
		global.open_instance = noone
	}
	
	global.current_gui = to_gui
}

//open craft
if(keyboard_check_pressed(ord("C")))
{
	global.current_gui = gui.CRAFT	
}
if(keyboard_check_pressed(ord("U")))
{
	//sledgehammer researched
	//ds_list_add(craft_recipes[0], recipe(items.sledgehammer, array( recipe_req(items.wood, 5), recipe_req(items.iron, 15) ), 1 ) )
}
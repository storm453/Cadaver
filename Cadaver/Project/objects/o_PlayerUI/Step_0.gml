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
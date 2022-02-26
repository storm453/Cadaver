if(keyboard_check_pressed(vk_tab) or keyboard_check_pressed(vk_escape))
{
	var to_gui = gui.INVENTORY
	
	if(global.current_gui != 0)
	{
		to_gui = gui.NONE	
	}
	
	global.current_gui = to_gui
}

//o_Player.hp--
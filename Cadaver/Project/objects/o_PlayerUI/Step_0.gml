if(keyboard_check_pressed(vk_tab))
{
	var to_gui = gui.INVENTORY
	
	if(global.current_gui == gui.INVENTORY)
	{
		to_gui = gui.NONE	
	}
	
	global.current_gui = to_gui
}

if(keyboard_check_pressed(vk_shift)) global.current_gui = gui.LOOT
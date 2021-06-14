if(keyboard_check_pressed(vk_tab))
{
	if(global.current_gui == gui.INVENTORY)
	{
		global.current_gui = gui.NONE;
	}
	else
	{
		global.current_gui = gui.INVENTORY
	}
}
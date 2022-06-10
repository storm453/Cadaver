//open inventory iwth tab or ecsape
if(keyboard_check_pressed(vk_tab) or keyboard_check_pressed(vk_escape))
{
	var to_gui = gui.INVENTORY
	
	if(global.current_gui != 0)
	{
		to_gui = gui.NONE
		global.open_instance = noone
	}
	//if ur in building, remove the current building that you have selecct bc not build no more
	if(global.current_gui == gui.BUILDING)
	{
		selected_bp = noone
		sel_bp_id = -1
	}
	
	global.current_gui = to_gui
}
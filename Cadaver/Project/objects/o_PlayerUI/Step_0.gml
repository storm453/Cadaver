if(keyboard_check_pressed(vk_tab) or keyboard_check_pressed(vk_escape))
{
	var to_gui = gui.INVENTORY
	
	if(global.current_gui != 0)
	{
		to_gui = gui.NONE
		
		crafting_level = crafting_lvls.ALL

		open_instance = -4
	}
	
	global.current_gui = to_gui
}

var scan = instance_nearest(o_Player.x, o_Player.y, o_Multiblock)

if(keyboard_check_pressed(ord("E")))
{
	if(global.current_gui == gui.NONE)
	{
		if(open_instance == -4)
		{
			scan_distance = 0

			with(o_Player)
			{
				other.scan_distance = distance_to_object(scan)
			}

			if(scan_distance < 10)
			{
				open_instance = scan

				global.current_gui = open_instance.block_data.to_gui
				crafting_level = open_instance.block_data.crafting_level
			}
		}
	}
}

if(keyboard_check_pressed(ord("B")))
{
	//buil;d!
	global.current_gui = gui.BLUEPRINT
}

//o_Player.hp--
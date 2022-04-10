z = -bbox_bottom

//open if near
var distance = distance_to_object(o_Player)

if(distance < 10)
{
	if(keyboard_check_pressed(ord("E")))
	{
		global.current_gui = gui.LOOT
		
		open = true
	}
}

if(keyboard_check_pressed(vk_escape))
{
    open = false
}

if(global.current_gui != gui.LOOT) open = false

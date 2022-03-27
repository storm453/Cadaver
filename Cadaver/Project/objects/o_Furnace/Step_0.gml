z = -bbox_bottom

//open if near
var distance = distance_to_object(o_Player)

if(distance < 10)
{
	if(keyboard_check_pressed(ord("E")))
	{
		global.current_gui = gui.INVENTORY
		
		open = !open
	}
}

if(keyboard_check_pressed(vk_escape))
{
    open = false
}
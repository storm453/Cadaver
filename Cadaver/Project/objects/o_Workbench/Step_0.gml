//sorting
z = -bbox_bottom

//open if near
var distance = distance_to_object(o_Player)

if(distance < 10)
{
	if(keyboard_check_pressed(ord("E")))
	{
		global.current_gui = gui.INVENTORY
		o_PlayerUI.crafting_level = crafting_lvls.WORKBENCH
		
		global.object_open = id
		open = true
	}
}

if(global.current_gui != gui.INVENTORY) open = false

queue_count(queue_list, inv, inv_data)
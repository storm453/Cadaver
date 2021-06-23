map = array_create();

alarm[0] = 60

tiles = 16
world = room_width / tiles

for(var i = 0; i < world; i++)
{
	for(var j = 0; j < world; j++)
	{
		map[i,j] = 0;
	}
}

#macro grass_color c_lime
#macro object_color c_red

hp_show = 0;
energy_show = 0;

crafting_tab = "Consumables"

enum gui
{
	NONE,
	INVENTORY,
	CRAFTING,
	PROFILE
}

global.current_gui = gui.NONE

selected_tab = "CRAFTING"

#macro button_color c_dkgray
#macro button_s_color 0x6a6a69
#macro menu_color 0x262626
#macro tab_color 0x171717
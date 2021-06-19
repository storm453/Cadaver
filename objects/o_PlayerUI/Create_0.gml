hp_show = 0;
energy_show = 0;

enum gui
{
	NONE,
	INVENTORY,
	CRAFTING,
	PROFILE
}

global.current_gui = gui.NONE

selected_tab = "INVENTORY"

#macro button_color c_dkgray
#macro button_s_color 0x6a6a69
#macro menu_color 0x262626
#macro tab_color 0x171717
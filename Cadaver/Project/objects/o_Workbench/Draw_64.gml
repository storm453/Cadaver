if(open)
{
	//var item_window_x = display_get_gui_width() / 2 - inv_width / 2
	//var item_window_y = display_get_gui_height() - inv_height - craft_height - title_height - pad
	
	//ui_draw_window(item_window_name, item_window_x, item_window_y, craft_width, craft_height)
	
	//item_panel = make_panel(item_window_x + pad, item_window_y + pad)
	
	#macro work_width 300
	#macro work_height 200
	
	//var work_window_x = display_get_gui_width() / 2 - o_PlayerUI.inv_width - work_width
	
	ui_draw_window("WORKBENCH", 50, 50, 300, 200)
}
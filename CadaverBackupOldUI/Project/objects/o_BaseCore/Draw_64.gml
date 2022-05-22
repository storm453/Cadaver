if(global.current_gui == gui.BASE)
{

var main_width = 500
var main_height = 700

var left_width = 275
var left_height = 500

var right_width = 275
var right_height = 500

var offset = (main_height - left_height) / 2

var main_x = display_get_gui_width() / 2 - main_width / 2
var main_y = display_get_gui_height() - main_height - pad

ui_draw_window("Base Core", main_x, main_y, main_width, main_height)

main_panel = make_panel(main_x + pad, main_y + pad)

text_gap(main_panel, "Information")

var build_button = ui_draw_button_color("Build", main_panel.at_x, main_panel.at_y, 250, 125, button_color, button_h_color, text_color, false)
if(build_button[0])
{
	global.current_gui = gui.SELECTBLUE
	o_PlayerUI.open_instance = noone
}

pn_row(main_panel, 125 + pad)

var wiring_button = ui_draw_button_color("Wiring", main_panel.at_x, main_panel.at_y, 250, 125, button_color, button_h_color, text_color, false)
if(wiring_button[0])
{
	global.current_gui = gui.WIRE
	o_PlayerUI.open_instance = noone
}

var left_x = main_x - pad - left_width
var left_y = main_y + offset

ui_draw_window("Details", left_x, left_y, left_width, left_height)

var right_x = main_x + main_width + pad
var right_y = main_y + offset

ui_draw_window("Upgrades", right_x, right_y, right_width, right_height)

}
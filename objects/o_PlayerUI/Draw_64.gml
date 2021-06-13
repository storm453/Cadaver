#macro pad 5

#macro switch_button_scale 64

#macro title_button_width 128
#macro title_button_height 32

var inv_width = round(o_PlayerInventory.slots_x * o_PlayerInventory.draw_scale * o_PlayerInventory.slot_size) - 1
var inv_height = o_PlayerInventory.player_inventory_height

var window_width = inv_width
var window_height = 300

var switch_x = display_get_gui_width() / 2 - switch_button_scale / 2
var switch_y = 0

draw_set_color(0x262626)
draw_rectangle(switch_x  - pad - switch_button_scale - pad, switch_y, switch_x - pad - switch_button_scale - pad + switch_button_scale * 3 + pad * 4, switch_y + switch_button_scale + pad * 2 + title_button_height, false)

var craft_button = ui_draw_button_color("C", switch_x, switch_y, switch_button_scale, switch_button_scale, button_color, button_s_color, c_white, false)

switch_x -= switch_button_scale + pad

var inv_button = ui_draw_button_color("I", switch_x, switch_y, switch_button_scale, switch_button_scale, button_color, button_s_color, c_white, false)

switch_x += switch_button_scale * 2 + pad * 2

var profile_button = ui_draw_button_color("P", switch_x, switch_y, switch_button_scale, switch_button_scale, button_color, button_s_color, c_white, false)

switch_x = display_get_gui_width() / 2 - title_button_width / 2
switch_y +=  switch_button_scale + pad

ui_draw_title("Crafting", switch_x, switch_y, title_button_width, title_button_height, button_color, c_white, false)

//MAIN UI
var start_x = display_get_gui_width() / 2 - inv_width / 2
var start_y = display_get_gui_height() - inv_height - window_height - pad

ui_draw_rectangle(start_x, start_y, window_width, window_height, menu_color, 1, false)

start_x += pad
start_y += pad

var test_button = ui_draw_button_color("Button", start_x, start_y, 100, 50, button_color, button_s_color, c_white, false)
if(test_button[0])
{
	game_end()	
}
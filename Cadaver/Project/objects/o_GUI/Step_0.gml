//day_factor = 1
global.time += get_delta_time()

function brzeczszyszrzkiewicz_curve(time_dr_freeman)
{
	return -cos(pi / 2 + (pi / 2 * min(1, max(-1, cos(pi * time_dr_freeman / 1440) * steepness)))) * 0.5 + 0.5
}

if(keyboard_check_pressed(vk_f1)) 
{
	game_restart()
	rand_seed()
}

if(keyboard_check_pressed(vk_f11))
{
	if(window_get_fullscreen()) display_set_gui_size(window_get_width(), window_get_height())
	
	window_set_fullscreen(!window_get_fullscreen())
}

day_factor = 1 - brzeczszyszrzkiewicz_curve(global.time * 50)

//set cursors

window_set_cursor(cr_cross)
cursor_sprite = noone

//var mouse_item = collision_circle(mouse_x, mouse_y, 15, o_ItemDropped, true, true)
//var mouse_harv = collision_circle(mouse_x, mouse_y, 5, o_Harvestable, true, true)

//function cursor_set(spr)
//{
//	window_set_cursor(cr_none)
//	cursor_sprite = spr
//}

//if(mouse_item != noone)
//{
//	cursor_set(s_CursorGrab)	
//}
//if(mouse_harv != noone)
//{
//	cursor_set(s_CursorHit)	
	
//	if(o_Player.attack_cooldown > 0) cursor_set(s_NoAction)
//}
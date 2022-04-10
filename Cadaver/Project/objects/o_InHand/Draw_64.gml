//draw the sprite you have in your hand
var mx = device_mouse_x_to_gui(0)
var my = device_mouse_y_to_gui(0)

if(global.in_hand != 0)
{
	draw_sprite_ext(s_Items, global.items_list[global.in_hand.item].spr_index, mx - 32, my - 32, 3.5, 3.5, 0, c_white, 1);
}

gpu_set_blendmode(bm_normal)
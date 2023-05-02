//draw the sprite you have in your hand
var mx = device_mouse_x_to_gui(0)
var my = device_mouse_y_to_gui(0)

var _holding_scale = 6 * global.res_fix

if(global.in_hand != 0)
{
	var item_half = (sprite_get_width(s_Items) / 2) * _holding_scale
	
	draw_sprite_ext(s_Items, global.items_list[global.in_hand.item].spr_index, mx - item_half, my - item_half, _holding_scale, _holding_scale, 0, c_white, 1);
}

gpu_set_blendmode(bm_normal)
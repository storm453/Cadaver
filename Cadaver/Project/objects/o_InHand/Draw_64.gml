//draw the sprite you have in your hand
var mx = device_mouse_x_to_gui(0)
var my = device_mouse_y_to_gui(0)

if(global.in_hand != 0)
{
	var item_half = (sprite_get_width(s_Items) / 2) * inv_scale
	
	draw_sprite_ext(s_Items, global.items_list[global.in_hand.item].spr_index, mx - 32 + item_half, my - 32 + item_half, inv_scale , inv_scale, 0, c_white, 1);
}

gpu_set_blendmode(bm_normal)
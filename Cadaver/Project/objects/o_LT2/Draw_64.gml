surface_set_target(lighting)

draw_set_color(c_black)
draw_rectangle(0, 0, cw, ch, false)

gpu_set_blendmode(bm_add)

var _cx = o_Camera.x - cw / 2
var _cy = o_Camera.y - ch / 2

with(o_LightBlue) 
{
	draw_circle_colour(x - _cx, y - _cy, radius,col, c_black, false)
}
gpu_set_blendmode(bm_normal)

surface_reset_target()

shader_set(sh_Light);

var tex = surface_get_texture(lighting);
var handle = shader_get_sampler_index(sh_Light,"lighting");
texture_set_stage(handle,tex);

surface_resize(application_surface, display_get_gui_width(), display_get_gui_height()) 

draw_surface(application_surface, 0, 0);

shader_reset();
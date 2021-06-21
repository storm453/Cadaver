draw_set_font(ft_Default)
display_set_gui_size(view_wport[0], view_hport[0])

global.draw_scale = 1

show_debug_message(display_get_gui_width())
show_debug_message(display_get_gui_height())

//t = 0.0

temp_surface = surface_create(view_wport[0], view_hport[0])


texture_lut_day = sprite_get_texture(spr_lut, 0);
texture_lut_night = sprite_get_texture(spr_night, 0);

day_factor = 0
timer = 0;

colour_grade = true
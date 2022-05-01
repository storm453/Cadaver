time_speed = 0.5

draw_set_font(ft_Default)
display_set_gui_size(view_wport[0], view_hport[0])

temp_surface = surface_create(view_wport[0], view_hport[0])

texture_lut_day = sprite_get_texture(spr_lut, 0);
texture_lut_night = sprite_get_texture(spr_night, 0);

day_factor = 0
timer = 0;

colour_grade = 1

//cursor
//window_set_cursor(cr_none)
//cursor_sprite = s_Cursor
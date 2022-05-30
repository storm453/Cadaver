display_set_gui_size(view_wport[0], view_hport[0])

//initialize particle types
var pt = part_type_create()

part_type_shape(pt, pt_shape_disk)
part_type_life(pt, 40, 80)

//part_type_alpha2(pt, 1, 0)
part_type_color1(pt, c_white)
//part_type_color2(pt, c_red, c_white)
part_type_size(pt, 0.15, 0, -0.01, 0)

part_type_speed(pt, 0.5, 1, 0, 0)
part_type_direction(pt, 0, 360, 0, 0)
part_type_gravity(pt, 0.1, 270)

global.pt_basic = pt 
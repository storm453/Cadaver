display_set_gui_size(view_wport[0], view_hport[0])

function rand_seed()
{
	randomize()
	random_set_seed(current_second * irandom(25241))
	
	global.seed = random_get_seed()
}

rand_seed()

#macro MAPDIR working_directory + "/"+string(global.seed)+"/"
if(!directory_exists(MAPDIR)) directory_create(MAPDIR)

//fire
var pt = part_type_create()

part_type_sprite(pt, s_Rain, 0, false, 0)
part_type_alpha1(pt, 0.1)
part_type_blend(pt, bm_add)
part_type_color1(pt, color_hex(0xd6f8ff))
part_type_size(pt, 0.1, 0, -0.00005, 0)
part_type_direction(pt, 270, 270, 0, 0)
part_type_gravity(pt, 0.1, 270)
part_type_orientation(pt, 0, 0, 0, 0, true)

global.pt_rain = pt

var pt = part_type_create()

part_type_shape(pt, pt_shape_cloud)

part_type_alpha1(pt, 0.1)
part_type_blend(pt, bm_add)
part_type_color1(pt, color_hex(0xd6f8ff))
part_type_direction(pt, 0, 360, 0, 0)
part_type_gravity(pt, 0.001, 270)

global.pt_splash = pt

var pt = part_type_create()

part_type_shape(pt, pt_shape_sphere)
part_type_life(pt, 300, 600)
part_type_direction(pt, 0, 360, false, false)
part_type_alpha3(pt, 0, 0.1, 0)
part_type_blend(pt, bm_add)
part_type_color1(pt, c_white)
part_type_size(pt, 0.05, 0.05, 0, 0)

global.pt_dust = pt

//NEW ADVANCED PARTICLES

//global.particle_rain = new advanced_part_type()

//with(global.particle_rain)
//{
//	part_life(1, 3)
//	part_speed(400, 700, false, false)
//	part_image(s_Rain, 0, color_hex(0xd6f8ff), false, false, false)
//	part_alpha3(1, 1, 1)
//	part_size(0.1, 0.1, 0, 0)
//	part_gravity(0.1, 270)
//	part_orientation(90, 90, false, false, false)
//	part_direction(270, 270, 0, 0)
//}

//global.particle_dust = new advanced_part_type()

//with(global.particle_dust)
//{
//	part_life(3, 6)
//	part_direction(0, 359, 0, 0)
//	part_alpha3(0, 0.1, 0)
//	part_blend(bm_add)
//	part_color3(c_white, c_white, c_white)
//	part_image(s_Dust, 0, c_white, false, false, false)
//	part_size(0.1, 0.1, 0, 0)
//	part_speed(3, 6, 0, 0)
//}

//global.particle_shine = new advanced_part_type();

//with(global.particle_shine)
//{
//	part_life(1, 2)
//	part_size(0.08, 0.08, -0.05, 0)
//	part_color3(c_white, c_white, c_white)
//	part_orientation(0, 359, 10, 0, false)
//	part_image(s_Shine, 0, c_white, false, false, false)
//	part_direction(0, 359, 0, 0)
//}

//global.particle_spore = new advanced_part_type()

//with(global.particle_spore)
//{
//	part_life(4, 8)
//	part_alpha3(0, 0.5, 0)
//	part_size(0.08, 0.08, -0.02, 0)
//	part_color3(c_red, c_red, c_red)
//	part_orientation(0, 359, 50, 0, false)
//	part_image(s_Smoke, 0, c_white, false, false, false)
//	part_direction(0, 359, 0, 0)	
//	part_speed(0.5, 1, 0, 0)
//}
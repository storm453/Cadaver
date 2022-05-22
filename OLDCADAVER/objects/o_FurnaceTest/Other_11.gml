open = false
on = 0

slot_scale = slot_size * draw_scale

held_data = 0

fuel = 0
fuel_max = 100

current = 0

fuel_timer[0] = 0
fuel_timer[1] = 0
fuel_timer[2] = 0

fuel_rect_width = 65
slots_to_x = 6

smelt_timer = 0

//recipes
//@REFACTOR change namees
smelt_recipes = array
(
	{ cost: 35, ret: 4 },
	{ cost: 8, ret: 9 },
	{ cost: 34, ret: 13 }
)

var width = (pad + draw_scale * slot_size) * slots_to_x + pad + fuel_rect_width
var height = (pad + draw_scale * slot_size) * 3 + pad

//furnace_width = 550
furnace_width = width
furnace_height = height
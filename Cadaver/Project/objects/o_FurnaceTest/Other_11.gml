open = false

slot_scale = slot_size * draw_scale

held_data = 0

fuel = 0
fuel_timer = 0
burnt = 0

fuel_rect_width = 65
slots_to_x = 6

var width = (pad + draw_scale * slot_size) * slots_to_x + pad + fuel_rect_width
var height = (pad + draw_scale * slot_size) * 3 + pad

//furnace_width = 550
furnace_width = width
furnace_height = height


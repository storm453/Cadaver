particles = part_system_create()

weather_type = make_enum()

add_enum(weather_type, "clear")
add_enum(weather_type, "rain")

weather = weather_type.clear
timer = 0

global.wind = vec2(0, 0)

part_system_depth(particles, -10)
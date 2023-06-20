particles = new advanced_part_system();
particles.enabledelta();

weather_type = make_enum()

add_enum(weather_type, "clear")
add_enum(weather_type, "rain")

dust = true

weather = weather_type.rain
timer = 0

global.wind = vec2(0, 0)

part_system_depth(particles, -10)
event_inherited()

custom_render = true

acc = 1
hover_speed = 200
velocity_dampen = 50

data = { item: items.wood, amt: 3 }

outline_init()

randomize()
dx = random(2) - 1
dy = random(2) - 1

my = y

dl = sqrt(dx * dx + dy * dy)
dx /= dl
dy /= dl

spd = random_range(0.35, 0.5)

zz = 0
vz = 1

grav = -0.1

up = false

function my_render()
{
	draw_self()
}
z = -bbox_bottom

//movement
x += spd * dx
my += spd * dy

y = my - zz
zz += vz
vz += grav

if(zz < 0)
{
	spd = 0
	vz = 0
	zz = 0
}

if(data != 0)
{
	image_index = data.item
}

//scaling
image_xscale = (5 / (5 - zz / 5) / 3) * 2
image_yscale = (5 / (5 - zz / 5) / 3) * 2
z = -bbox_bottom


cursor_sprite = s_CrosshairCursor


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

if(up)
{
	image_xscale -= 0.1	
	image_yscale -= 0.1	
	
	if(image_xscale <= 0) instance_destroy()
}
else
{
	//scaling
	image_xscale = (5 / (5 - zz / 5) / 3) * 2
	image_yscale = (5 / (5 - zz / 5) / 3) * 2
}
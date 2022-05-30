z = -bbox_bottom

if(mouse_check_button_pressed(mb_left))
{
	moo = !moo
}

if(moo)
{
	dx = lerp(dx, 0, 0.1)	
}
else
{
	dx = lerp(dx, start_x, 0.1)
} 
z = -bbox_bottom

if(distance_to_object(o_Player) < 10)
{
	if(o_Player.z > z)
	{
		if(image_alpha > 0.35) image_alpha -= 0.05	
	}
}
else
{
	if(image_alpha < 1) image_alpha += 0.05
}
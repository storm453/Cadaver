z = -bbox_bottom

var up   = place_meeting(x, y - 16, o_Floor)
var down = place_meeting(x, y + 16, o_Floor)

if(up)
{
	if(!down)
	{
		//@TEMP 
		if(distance_to_object(o_Player) < 20)
		{
			if(z < o_Player.z)
			{
				image_alpha = 0.5
			}
		}
		else
		{
			image_alpha = 1	
		}
	}
}
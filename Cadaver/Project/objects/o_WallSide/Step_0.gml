z = -bbox_bottom

var left =  place_meeting(x - 16, y, o_Floor)
var right = place_meeting(x + 18, y, o_Floor)

if(!left)
{
	if(right)
	{
		sprite_index = s_WallSideRight
	}
}
else
{
	if(!right)
	{
		sprite_index = s_WallSideLeft	
	}
}
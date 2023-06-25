//collision_rectangle_list(x, y, x + chunk_size, y + chunk_size, o_WorldParent, false, true, _parent_list, false)

var _animals = 0
var _parasites = 0

// for(var i = 0; i < ds_list_size(_parent_list); i++)
// {
// 	if(_parent_list[|i].is_animal)
// 	{
// 		_animals++	
// 	}
// 	if(_parent_list[|i].is_parasite)
// 	{
// 		_parasites++
// 	}
// }

var _mob_x = x + random(chunk_size)
var _mob_y = y + random(chunk_size)

var _cam_x = o_Camera.x - (o_Camera.x_size * o_Camera.zoom) / 2
var _cam_y = o_Camera.y - (o_Camera.y_size * o_Camera.zoom) / 2

if(!point_in_rectangle(_mob_x, _mob_y, _cam_x, _cam_y, _cam_x + (o_Camera.x_size * o_Camera.zoom), _cam_y + (o_Camera.y_size * o_Camera.zoom)))
{
	if(_animals < 2)
	{
		//if(chance(0.001)) instance_create_layer(_mob_x, _mob_y, "World", choose(o_Bird, o_Dog))
	}
	
	if(_parasites < 1)
	{
		//spawn parasites
		switch(_parasites)
		{
			case(0):
			{
				//if(chance(0.0005)) instance_create_layer(_mob_x, _mob_y, "World", o_Thread)
			}
			break;
		
			case(1):
			{
			
			}
			break;
		}
	}
}
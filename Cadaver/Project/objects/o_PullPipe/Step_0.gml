z = -bbox_bottom

var left = place_meeting(x - 16, y, o_Multiblock)
var right = place_meeting(x + 16, y, o_Multiblock)

//move items
var transfer = true

if(ds_list_size(outputs) <= 0) transfer = false
if(input == -4) transfer = false

if(transfer)
{
	for(var i = 0; i < input.inv_data.slots_y; i++)
	{
		for(var j = 0; j < input.inv_data.slots_x; j++)
		{
			if(input.inv[j,i] != 0)
			{
				if(transfer_timer <= 0)
				{
					transfer_timer = transfer_timer_set

					add_item(outputs[|0].inv, outputs[|0].inv_data, input.inv[j,i].item, 1)

					input.inv[j,i].amt--

					if(input.inv[j,i].amt <= 0)
					{
						array_set(input.inv[j], i, 0)
					}
				}
			}
		}
	}
}

transfer_timer--

if(left)
{
	if(right)
	{
		image_index = 3
	}
	else
	{
		image_index = 2
	}
}
else
{
	if(right)
	{
		image_index = 1	
	}
	else
	{
		image_index = 0	
	}
}

////run when update
//var adj = place_meeting(x + 16, y, o_Pipe)

////if there is adj
//if(adj)
//{
//	with(adj)
//	{
//		other.with_adj = place_meeting(x + 16, y, o_Pipe)
//	}
//}
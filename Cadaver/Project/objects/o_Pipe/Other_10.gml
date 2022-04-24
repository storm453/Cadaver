var left = instance_place(x - 16, y, all)
var right = instance_place(x + 16, y, all)

if(left != -4)
{
	if(left.object_index == o_Pipe or o_Multiblock) left = true
}
if(right != -4)
{
	if(right.object_index == o_Pipe or o_Multiblock) right = true	
}

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
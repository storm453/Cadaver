//function split_string(string, delimiter)
//{
//	container[0] = "";
//	previous_position = 1;
//	container_index = 0;

//	for (i = 1; i < string_length(string); i++) 
//	{
//	    // If the character at the current location is equivalent to the delimiter
//	    if(string_char_at(string, i) == delimiter)
//		{
//	        container[container_index] = "";
			
//	        letters = i - previous_position;
			
//	        for(j = 0; j < letters; j++)
//			{
//	            container[container_index] += string_char_at(string, previous_position + j);
//	        }
	
//	        container_index += 1;
//	        previous_position = i;
//		}
//	}
	
//	return container;
//}

function room_to_gui(_x, _y)
{
	var _a0 = o_Camera.x - o_Camera.x_size * o_Camera.zoom / 2
	var _a1 = o_Camera.x + o_Camera.x_size * o_Camera.zoom / 2
	
	var _b0 = 0
	var _b1 = display_get_gui_width()
	
	var guix = (_x - _a0) / (_a1 - _a0) * (_b1 - _b0) + _b0
	
	var _a0 = o_Camera.y - o_Camera.y_size * o_Camera.zoom / 2
	var _a1 = o_Camera.y + o_Camera.y_size * o_Camera.zoom / 2
	
	var _b0 = 0
	var _b1 = display_get_gui_height()
	
	var guiy = (_y - _a0) / (_a1 - _a0) * (_b1 - _b0) + _b0
	
	return vec2(guix, guiy)
}

function string_split(base, delimiter)
{
	var inline=false;                               // inside a block quote?
	var queue=ds_list_create();                    // Contains the individual words
	var tn="";                                      // temporary substring

	base=base+delimiter;                            // lazy way of ensuring the last term in the list does not get skipped

	for (var i=1; i<=string_length(base); i++){     // for each character in the string:
	    var c=string_char_at(base, i);              //      Current character
	    if (string_char_at(base, i-1)=="\\"){        //      If the previous character is a backslash, bypass the other checks
	        tn=string_copy(tn, 1, string_length(tn)-1);     // and remove the backslash
	        tn=tn+c;
	    } else if (c=="\""){                         //      If double quotation mark:
	        if (inline){                            //          If already inside a block, end the block
	            inline=false;
	        } else {                                //          If not already inside a block, start a block
	            inline=true;
	        }
	    } else if (c==delimiter&&!inline){          //      Delimiter met and not inside a block, enqueue and reset the substring
	        ds_list_add(queue, tn);
	        tn="";
	    } else {                                    // Just an ordinary character, add it to the substring
	        tn=tn+c;
	    }
	}

	return queue;
}

function array_height(arr)
{
	return array_length(arr[0])	
}

function chance(probability) {
	return probability > random(1);
}

function array() {
	var arr;
	for (var i=0;i<argument_count;i++)
	{
	    arr[i] = argument[i];
	}
	return arr;
}

function color_hex(arg)
{
	return (arg & $FF) << 16 | (arg & $FF00) | (arg & $FF0000) >> 16;	
}

function instance_nearest_notme(obj)
{
    instance_deactivate_object(self);
    
    var n = instance_nearest(x, y, obj);
    
    instance_activate_object(self);
    return n;
}

function move_towards(target)
{
    return v2_normalized(v2_sub(target, self))
}

function in_range(check, _min, _max)
{
    if(_min < check && check <= _max)
    {
        return true;
    }
    else
    {
        return false;
    }
}
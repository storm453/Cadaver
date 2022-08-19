function split_string(string, delimiter)
{
	container[0] = "";
	previous_position = 1;
	container_index = 0;

	for (i = 1; i < string_length(string); i++) 
	{
	    // If the character at the current location is equivalent to the delimiter
	    if(string_char_at(string, i) == delimiter)
		{
	        container[container_index] = "";
			
	        letters = i - previous_position;
			
	        for(j = 0; j < letters; j++)
			{
	            container[container_index] += string_char_at(string, previous_position + j);
	        }
	
	        container_index += 1;
	        previous_position = i;
		}
	}
	
	return container;
}

function print(msg)
{
	show_debug_message(string(msg))
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
    if(_min < check && check < _max)
    {
        return true;
    }
    else
    {
        return false;
    }
}
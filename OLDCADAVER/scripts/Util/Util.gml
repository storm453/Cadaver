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
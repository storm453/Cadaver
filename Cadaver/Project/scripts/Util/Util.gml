function damage_circle(_x, _y, _radius, _damage)
{
	var _circle_hit = ds_list_create()
	var _hit = false
		
	collision_circle_list(_x, _y, _radius, o_WorldParent, false, true, _circle_hit, false)
		
	for(var i = 0; i < ds_list_size(_circle_hit); i++)
	{
		var _current_hit = _circle_hit[|i]
			
		if(_current_hit.damagable == true)
		{
			_current_hit.hp -= _damage	
			_hit = true
		}
		if(_current_hit.handle_damage == true)
		{
			with(_current_hit)
			{
				on_damage(other.id)	
			}
		}
	}
	
	return _hit
}

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

function make_enum()
{
	return { names: array_create() }
}

function add_enum(_enum, _name)
{
	var _length = array_length(_enum.names)

	array_push(_enum.names, _name)
	variable_struct_set(_enum, _name, _length)
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

function move_towards_point(_x, _y, _speed)
{
	var _diff_x = _x - x
	var _diff_y = _y - y
	
	var _norm = sqrt(_diff_x * _diff_x + _diff_y * _diff_y)
	
	var _add_x = (_diff_x / _norm) * _speed
	var _add_y = (_diff_y / _norm) * _speed
	
	return vec2(_add_x, _add_y)
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
function make_animation(_sprite, _fps, _time = 0)
{
	var _speed = _fps

	if(_time != 0)
	{
		_speed = sprite_get_number(_sprite) / _time
	}

	return { animation: _sprite, triggers: array_create(sprite_get_number(_sprite), 0), spd: _speed, finish: 0, playback_time: 0, trigger_status: false }	
}

function set_animation(_animation)
{
	if(animation != _animation)
	{
		animation = _animation
		sprite_index = _animation.animation
		image_index = 0
		animation.playback_time = 0
		animation.trigger_status = false
	}
}

function trigger_animation(_animation, _frame, _script)
{
	_animation.triggers[_frame] = _script
}

function end_animation(_animation, _script)
{
	_animation.finish = _script
}

function step_animation()
{
	animation.playback_time += delta_time / 1000000 * animation.spd
	image_index = floor(animation.playback_time)
	
	if(image_index >= image_number)
	{
		if(animation.finish != 0)
		{
			animation.finish()
		}
		else
		{
			image_index = 0
			animation.trigger_status = false
			animation.playback_time = 0
		}
	}
	
	if(animation.triggers[image_index] != 0)
	{
		if(animation.trigger_status == false)
		{
			animation.trigger_status = true
			animation.triggers[image_index]()	
		}
		
	}
}
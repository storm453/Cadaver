world_first = noone
world_last = noone

function world_add(_entity)
{
	assert(_entity.prev == noone)
	assert(_entity.next == noone)
	
	if(world_first == noone)
	{
		world_first = _entity
		world_last  = _entity
	}	
	else
	{
		world_last.next = _entity
		_entity.prev = world_last
		world_last = _entity
	}
}

function world_remove(_entity)
{
	if(_entity.prev != noone)
	{
		_entity.prev.next = _entity.next
	}
	if(_entity.next != noone)
	{
		_entity.next.prev = _entity.prev
	}
	
	if(world_first == _entity)
	{
		world_first = _entity.next
	}
	if(world_last == _entity)
	{	
		world_last = _entity.prev
	}
}
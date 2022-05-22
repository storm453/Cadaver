function save_a_o_Player( output_buffer, obj ) {
	buffer_write( output_buffer , buffer_string , "o_Player" );
	buffer_write( output_buffer , buffer_f32 , obj.spawn_x );
	buffer_write( output_buffer , buffer_f32 , obj.spawn_y );
	buffer_write( output_buffer , buffer_f32 , obj.x );
	buffer_write( output_buffer , buffer_f32 , obj.y );
	buffer_write( output_buffer , buffer_f32 , obj.hp );
	buffer_write( output_buffer , buffer_f32 , obj.energy );
}

function load_a_o_Player( input_buffer ) {
	return {
		spawn_x : buffer_read( input_buffer, buffer_f32 ),
		spawn_y : buffer_read( input_buffer, buffer_f32 ),
		x : buffer_read( input_buffer, buffer_f32 ),
		y : buffer_read( input_buffer, buffer_f32 ),
		hp : buffer_read( input_buffer, buffer_f32 ),
		energy : buffer_read( input_buffer, buffer_f32 ),
	};
}

function load_crap( which_room, input_buffer ) {
	var actor_count = buffer_read( input_buffer , buffer_u32 );
	for(var idx = 0; idx < actor_count; ++idx) {
		var actor_type = buffer_read( input_buffer , buffer_string );
		if (actor_type == "o_Player") {
			var actor = load_a_o_Player( input_buffer );
			var _x = 0, _y = 0;
			_x = actor.x;
			_y = actor.y;
			room_instance_add( which_room, _x, _y, o_Player );
		}
	}
}

function save_crap(output_buffer) {
	var how_many = 0;
	with (all) {
		++how_many;
	}
	buffer_write( output_buffer, buffer_u32, how_many );
	with (all) {
		buffer_write( output_buffer , buffer_string, object_get_name(object_index) );
		if (object_get_name( object_index ) == "o_Player") {
			save_a_o_Player( output_buffer, self );
		}
	}
}

function save_world_to_file(file)
{
	var output_buffer = buffer_create( 0, buffer_grow, 1 );
	save_crap(output_buffer);
	buffer_save(output_buffer, file);
	buffer_delete(output_buffer);
}

function load_world_from_file(file)
{
	var input_buffer = buffer_load( file );
	var a_room = room_add(); // this function has memory leaks! dont load too many times for the time being
	// ~Todo cache the room and reuse it because gamemaker is crap
	load_crap( a_room, input_buffer );
	buffer_delete( input_buffer );
	
	room_goto(a_room);
}
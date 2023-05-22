global.db_enemy = false
global.db_god = false
global.db_path = false
global.db_chunk = false

open = false
typing = ""
typing_cursor = 0
output = ds_list_create()

depth = -200

function cprint(_message)
{
	var _lines = string_split(_message, "\n")
	
	for(var i = 0; i < array_length(_lines); i++)
	{
		ds_list_add(output, _lines[i])
	}
}

function parse_command(_string)
{
	var _parts = string_split(_string, " ")
	
	switch(_parts[0])
	{
		case("god"):
		{
			global.db_god = !global.db_god
			cprint("godmode " + (global.db_god ? "ON" : "OFF"))
		}
		break;
		
		case("itemdrop"):
		{
			instance_create_layer(o_Player.x, o_Player.y, "World", o_ItemDropped)	
		}
		break;
		
		case("db_entity"):
		{
			global.db_enemy = !global.db_enemy
			cprint("db_entity " + (global.db_enemy ? "ON" : "OFF"))
		}
		break;
		
		case("db_chunk"):
		{
			global.db_chunk = !global.db_chunk
			cprint("db_chunk " + (global.db_chunk ? "ON" : "OFF"))
		}
		break;
		
		case("db_path"):
		{
			global.db_path = !global.db_path
			cprint("db_path " + (global.db_path ? "ON" : "OFF"))
		}
		break;
		
		default:
		{
			cprint("Unknown command " + "'" + string(_parts[0]) + "'")
		}
		break;
	}
}
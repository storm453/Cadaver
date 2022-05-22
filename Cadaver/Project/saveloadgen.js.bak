const fs = require('fs');
const path = require('path');
const util = require('util');


const traverse = function(dir, result = []) {
    
    // list files in directory and loop through
    fs.readdirSync(dir).forEach((file) => {
        
        // builds full path of file
        const fPath = path.resolve(dir, file);
        
        // is the file a directory ? 
        // if yes, traverse it also, if no just add it to the result
        if (fs.statSync(fPath).isDirectory()) {
            return traverse(fPath, result)
        }

        const fileStats = { file, path: fPath };

        result.push(fileStats);
    });
    return result;
};




function parse_save_load_metadata(src)
{
	let actor_type = null;
	let fields = [];

	let lines = src.toString().split('\n');
	
	for (let line of lines)
	{
		let declare = line.indexOf("@Declare");
		
		if (declare != -1)
		{
			let part0 = line.substr(declare);
			let openBrac  = part0.indexOf("(");
			let closeBrac = part0.indexOf(")");
			
			let declaration = part0.substr(openBrac + 1, closeBrac - openBrac - 1);
			actor_type = declaration;
		}
		
		
		let field = line.indexOf("@Field");
		if (field != -1)
		{
			let part0 = line.substr(field);
			let openBrac  = part0.indexOf("(");
			let closeBrac = part0.indexOf(")");
			
			let args = part0.substr(openBrac + 1, closeBrac - openBrac - 1);
			let argParts = args.split(',');
			for(let i in argParts) argParts[i] = argParts[i].trim();
			
			fields.push({ name: argParts[0], type: argParts[1] });
		}
	}
	
	return { actor: actor_type, fields: fields };
}


function get_buffer_type_from_field_type(type)
{
	switch (type)
	{
		case "int": 	return "buffer_s32";
		case "float": 	return "buffer_f32";
		case "string":	return "buffer_string";
	}
	
	return "unknown";
}

function emit_actor_save_function(actor)
{
	let t = [];
	
	t.push("function save_a_" + actor.actor + "( output_buffer, obj ) {");
	
	t.push("\tbuffer_write( output_buffer , buffer_string , \"" + actor.actor + "\" );");
		
	for (let field of actor.fields) {
		t.push("\tbuffer_write( output_buffer , " + get_buffer_type_from_field_type(field.type) + " , obj." + field.name + " );");
		
	}
	
	t.push("}");
	
	return t.join('\n');
}

function emit_actor_load_function(actor)
{
	let t = [];
	
	t.push("function load_a_" + actor.actor + "( input_buffer ) {");
	
	
	
	t.push("\treturn {");
	
	for (let field of actor.fields) {
		t.push("\t\t" + field.name + " : buffer_read( input_buffer, " + get_buffer_type_from_field_type(field.type) +  " ),");
	}
	
	t.push("\t};");
	
	t.push("}");
	
	return t.join('\n');
}

let files = traverse("objects");

let actors = [];

for (let file of files)
{
	let actor = parse_save_load_metadata(fs.readFileSync(file.path));
	if (actor.actor == null) continue;
	actors.push(actor);
}


let blobs = [];

for (let actor of actors)
{
	blobs.push(emit_actor_save_function(actor));
	blobs.push(emit_actor_load_function(actor));
}

{
	let t = [];
	t.push("function load_crap( which_room, input_buffer ) {");
	t.push("\tvar actor_count = buffer_read( input_buffer , buffer_u32 );");

	t.push("\tfor(var idx = 0; idx < actor_count; ++idx) {");	
	t.push("\t\tvar actor_type = buffer_read( input_buffer , buffer_string );");

	let first = true;
	for (let actor of actors) {
		let ifLine = "\t\t";
		if (!first) ifLine += ("else ");
		first = false;
	
		t.push(ifLine + "if (actor_type == \"" + actor.actor + "\") {");

		t.push("\t\t\tvar actor = load_a_" + actor.actor + "( input_buffer );");
		t.push("\t\t\tvar _x = 0, _y = 0;");
		for (let field of actor.fields)
		{
			if (field.name == "x") t.push("\t\t\t_x = actor.x;");
			if (field.name == "y") t.push("\t\t\t_y = actor.y;");
		}

		t.push("\t\t\troom_instance_add( which_room, _x, _y, " + actor.actor + " );");

		t.push("\t\t}");
	}
	
	t.push("\t}");
	t.push("}");
	blobs.push(t.join("\n"));
}

{
	let t = [];
	t.push("function save_crap(output_buffer) {");
// 	t.push("\tvar output_buffer = buffer_create( 0, buffer_grow, 1 );");

	t.push("\tvar how_many = 0;")
	t.push("\twith (all) {");	
	t.push("\t\t++how_many;")
	t.push("\t}");

	t.push("\tbuffer_write( output_buffer, buffer_u32, how_many );");

	t.push("\twith (all) {");	
	t.push("\t\tbuffer_write( output_buffer , buffer_string, object_get_name(object_index) );");

	let first = true;
	for (let actor of actors) {
		let ifLine = "\t\t";
		if (!first) ifLine += ("else ");
		first = false;
		
		t.push(ifLine + "if (object_get_name( object_index ) == \"" + actor.actor + "\") {");

		t.push("\t\t\tsave_a_" + actor.actor + "( output_buffer, self );");

		t.push("\t\t}");
	}
	
	t.push("\t}");
	t.push("}");
	blobs.push(t.join("\n"));
}


blobs.push(
`function save_world_to_file(file)
{
	var output_buffer = buffer_create( 0, buffer_grow, 1 );
	save_crap(output_buffer);
	buffer_save(output_buffer, file);
	buffer_delete(output_buffer);
}`);

blobs.push(
`function load_world_from_file(file)
{
	var input_buffer = buffer_load( file );
	var a_room = room_add(); // this function has memory leaks! dont load too many times for the time being
	// ~Todo cache the room and reuse it because gamemaker is crap
	load_crap( a_room, input_buffer );
	buffer_delete( input_buffer );
	
	room_goto(a_room);
}`);

let v = (blobs.join("\n\n"));
fs.writeFileSync("scripts/SaveLoad/SaveLoad.gml", v);


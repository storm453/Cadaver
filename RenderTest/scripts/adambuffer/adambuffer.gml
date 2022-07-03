function vxFormat()
{
	vertex_format_begin()

	vertex_format_add_position_3d()
	vertex_format_add_texcoord()
	vertex_format_add_color()
	
	format = vertex_format_end()
}

function vxData(uid)
{
	var spr = object_get_sprite(uid.object_index)
	var sw = sprite_get_width(spr)
	var sh = sprite_get_height(spr)
	
	//vbos
	texture = sprite_get_texture(spr, 0)
	
	buffer = vertex_create_buffer()
	
	vertex_begin(buffer, format)
	
	//4 sections
	var x1 = uid.x
	var y1 = uid.y
	var x2 = x1 + sw
	var y2 = y1 + sh
	
	var dpth = -y2
	
	var uvs = sprite_get_uvs(spr, 0)
	
	var uv_x1 = uvs[0]
	var uv_y1 = uvs[1]
	var uv_x2 = uvs[2]
	var uv_y2 = uvs[3]
	
	//first triangle
	vertex_position_3d(buffer, x1, y1, dpth)
	vertex_texcoord(buffer, uv_x1, uv_y1)
	vertex_color(buffer, c_white, 1)
	
	vertex_position_3d(buffer, x2, y1, dpth);
    vertex_texcoord(buffer, uv_x2, uv_y1);
    vertex_color(buffer, c_white, 1);
	
	vertex_position_3d(buffer, x1, y2, dpth);
    vertex_texcoord(buffer, uv_x1, uv_y2);
    vertex_color(buffer, c_white, 1);
	
	//triagnle 2
	vertex_position_3d(buffer, x2, y1, dpth)
    vertex_texcoord(buffer, uv_x2, uv_y1)
    vertex_color(buffer, c_white, 1)

    vertex_position_3d(buffer, x1, y2, dpth)
    vertex_texcoord(buffer, uv_x1, uv_y2)
    vertex_color(buffer, c_white, 1)

    vertex_position_3d(buffer, x2, y2, dpth)
    vertex_texcoord(buffer, uv_x2, uv_y2)
    vertex_color(buffer, c_white, 1)
	
	//stuff
	vertex_end(buffer);	
}

function vxSend()
{
	vertex_submit(buffer, pr_trianglelist, texture);	
}
function bfCreate()
{    
    vertex_format_begin();
    vertex_format_add_position_3d();
    vertex_format_add_texcoord();
    vertex_format_add_colour();
    my_format = vertex_format_end();


    var buffer = { components: ds_list_create(), vbo: vertex_create_buffer(), texture: 0, my_format: my_format };    

    return buffer;
}

function bfDraw(buffer, x, y, w, h, z, sprite_index, image_index, color, alpha)
{
    var drawCall = {
        x: x,
        y: y,
        w: w,
        h: h,
        z: z,
        sprite_index: sprite_index,
        image_index: image_index,
        color: color,
        alpha: alpha,
    };
    
    ds_list_add(buffer.components, drawCall);
    
    buffer.texture = sprite_get_texture( sprite_index, image_index );
}

function bfDestroy(buffer)
{
    ds_list_destroy(buffer.components);
}

function bfFinish(buffer)
{
    vertex_begin(buffer.vbo, buffer.my_format);
    
    for (var i = 0; i < ds_list_size(buffer.components); ++i)
    {
        var drawCall = buffer.components[|i];
        
        var uvs = sprite_get_uvs(drawCall.sprite_index, drawCall.image_index);
        var uvs_left   = uvs[0];
        var uvs_top    = uvs[1];
        var uvs_right  = uvs[2];
        var uvs_bottom = uvs[3];
        
        vertex_position_3d(buffer.vbo, drawCall.x, drawCall.y, drawCall.z);
        vertex_texcoord(buffer.vbo, uvs_left, uvs_top);
        vertex_color(buffer.vbo, drawCall.color, drawCall.alpha);
        
        vertex_position_3d(buffer.vbo, drawCall.x + drawCall.w, drawCall.y, drawCall.z);
        vertex_texcoord(buffer.vbo, uvs_right, uvs_top);
        vertex_color(buffer.vbo, drawCall.color, drawCall.alpha);
        
        vertex_position_3d(buffer.vbo, drawCall.x + drawCall.w, drawCall.y + drawCall.h, drawCall.z);
        vertex_texcoord(buffer.vbo, uvs_right, uvs_bottom);
        vertex_color(buffer.vbo, drawCall.color, drawCall.alpha);
        
        
        
        
        
        vertex_position_3d(buffer.vbo, drawCall.x, drawCall.y, drawCall.z);
        vertex_texcoord(buffer.vbo, uvs_left, uvs_top);
        vertex_color(buffer.vbo, drawCall.color, drawCall.alpha);
        
        vertex_position_3d(buffer.vbo, drawCall.x + drawCall.w, drawCall.y + drawCall.h, drawCall.z);
        vertex_texcoord(buffer.vbo, uvs_right, uvs_bottom);
        vertex_color(buffer.vbo, drawCall.color, drawCall.alpha);
        
        vertex_position_3d(buffer.vbo, drawCall.x, drawCall.y + drawCall.h, drawCall.z);
        vertex_texcoord(buffer.vbo, uvs_left, uvs_bottom);
        vertex_color(buffer.vbo, drawCall.color, drawCall.alpha);
    }
    
    vertex_end(buffer.vbo);
}

function bfSubmit(buffer)
{
    vertex_submit(buffer.vbo, pr_trianglelist, buffer.texture);    
}
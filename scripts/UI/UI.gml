//UI UTIL
function string_width_font(_string, _font)
{
	draw_set_font(_font)
	return string_width(_string)
}

function string_height_font(_string, _font)
{
	draw_set_font(_font)
	return string_height(_string)
}

//UI ASSETS
function make_sprite(_sprite, _index, _scale, _color)
{
	var _width = sprite_get_width(_sprite) * _scale
	var _height = sprite_get_height(_sprite) * _scale
	
	return { sprite: _sprite, index: _index, scale: _scale, color: _color, width: _width, height: _height }
}

function make_text(_text, _text_color, _font)
{
	var _width = string_width_font(_text, _font)
	var _height = string_height_font(_text, _font)
	
	return { text: _text, color: _text_color, font: _font, width: _width, height: _height }	
}

function make_rectangle(_width, _height, _color, _alpha, _border, _sprite = -1)
{
	return { w: _width, h: _height, color: _color, alpha: _alpha, border: _border, sprite: _sprite }
}

//UI FUNCTIONS
function ui_draw_rectangle(_x, _y, _rectangle)
{
	draw_set_alpha(_rectangle.alpha)
	
	if(_rectangle.sprite == -1)
	{
		draw_set_color(_rectangle.color)
	
		draw_rectangle(_x, _y, _x + _rectangle.w, _y + _rectangle.h, false)
	
		if(_rectangle.border != false)
		{
			draw_set_color(_rectangle.border)
			draw_rectangle(_x, _y, _x + _rectangle.w, _y + _rectangle.h, true)
		}
	}
	else
	{
		draw_sprite_stretched(_rectangle.sprite, 0, _x, _y, _rectangle.w, _rectangle.h)
	}
}

function ui_draw_sprite(_x, _y, _sprite)
{
	draw_sprite_ext(_sprite.sprite, _sprite.index, _x, _y, _sprite.scale, _sprite.scale, 0, _sprite.color, 1)
}

function ui_draw_title(_x, _y, _rectangle, _text)
{
	ui_draw_rectangle(_x, _y, _rectangle)
	
	draw_set_font(_text.font)
	draw_set_color(_text.color)
	
	var _text_x = (_rectangle.w / 2) - (_text.width / 2)
	var _text_y = (_rectangle.h / 2) - (_text.height / 2)

	draw_text(_x + _text_x, _y + _text_y, _text.text)
}

function ui_draw_title_sprite(_x, _y, _rectangle, _sprite)
{
	ui_draw_rectangle(_x, _y, _rectangle)
	
	var _sprite_x = (_rectangle.w / 2) - (_sprite.width / 2)
	var _sprite_y = (_rectangle.h / 2) - (_sprite.height / 2)
	
	ui_draw_sprite(_x + _sprite_x, _y + _sprite_y, _sprite)
}

function ui_draw_title_both(_x, _y, _rectangle, _sprite, _text)
{
	ui_draw_rectangle(_x, _y, _rectangle)
	
	var _total_width = _sprite.width + _text.width + pad
	
	var _sprite_x = _x + (_rectangle.w / 2) - (_total_width / 2)
	var _sprite_y = _y + (_rectangle.h / 2) - (_sprite.height / 2)
	
	var _text_x = _x + (_rectangle.w / 2) - (_total_width / 2) + _sprite.width + pad
	var _text_y = _y + (_rectangle.h / 2) - (_text.height / 2)
	
	ui_draw_sprite(_sprite_x, _sprite_y, _sprite)
	
	draw_set_color(_text.color)
	draw_set_font(_text.font)
	draw_text(_text_x, _text_y , _text.text)
}

function ui_draw_title_button(_x, _y, _rectangle, _text, _rectangle_hover, _text_hover)
{
	var mx = device_mouse_x_to_gui(0)
	var my = device_mouse_y_to_gui(0)
	
	ui_draw_title(_x, _y, _rectangle, _text)
	 
	var _temp_rectangle_hover = _rectangle
	var _temp_text_hover = _text
	
	if(_rectangle_hover != false)
	{
		_temp_rectangle_hover = _rectangle_hover	
	}
	if(_text_hover != false)
	{
		_temp_text_hover = _text_hover
	}
	
	if(point_in_rectangle(mx, my, _x, _y, _x + _rectangle.w, _y + _rectangle.h))
	{
		ui_draw_title(_x, _y, _temp_rectangle_hover, _temp_text_hover)
	}
}

function ui_draw_title_sprite_button(_x, _y, _rectangle, _sprite, _rectangle_hover, _sprite_hover)
{
	var mx = device_mouse_x_to_gui(0)
	var my = device_mouse_y_to_gui(0)
	
	ui_draw_title_sprite(_x, _y, _rectangle, _sprite)
	
	var _temp_rectangle_hover = _rectangle
	var _temp_sprite_hover = _sprite
	
	if(_rectangle_hover != false) _temp_rectangle_hover = _rectangle_hover
	if(_sprite_hover != false) _temp_sprite_hover = _sprite_hover
	
	if(point_in_rectangle(mx, my, _x, _y, _x + _rectangle.w, _y + _rectangle.h))
	{
		ui_draw_title_sprite(_x, _y, _temp_rectangle_hover, _temp_sprite_hover)
	}
	else
	{
		
	}
}

function ui_draw_title_both_button(_x, _y, _rectangle, _sprite, _text, _rectangle_hover, _sprite_hover, _text_hover)
{
	var mx = device_mouse_x_to_gui(0)
	var my = device_mouse_y_to_gui(0)
	
	ui_draw_title_both(_x, _y, _rectangle, _sprite, _text)
	
	var _temp_rectangle_hover = _rectangle
	var _temp_sprite_hover = _sprite
	var _temp_text_hover = _text
	
	if(_rectangle_hover != false) _temp_rectangle_hover = _rectangle_hover
	if(_sprite_hover != false) _temp_sprite_hover = _sprite_hover
	if(_text_hover != false) _temp_text_hover = _text_hover
	
	if(point_in_rectangle(mx, my, _x, _y, _x + _rectangle.w, _y + _rectangle.h))
	{
		ui_draw_title_both(_x, _y, _temp_rectangle_hover, _temp_sprite_hover, _temp_text_hover)
	}
}

function draw_text_outline(xx, yy, outline_color, color, str, font)
{
	draw_set_font(font)
	
	draw_set_color(outline_color);  
	draw_text(xx + 1, yy + 1, str);  
	draw_text(xx - 1, yy - 1, str);  
	draw_text(xx, yy + 1, str);  
	draw_text(xx + 1, yy, str);  
	draw_text(xx, yy - 1, str);  
	draw_text(xx - 1, yy, str);  
	draw_text(xx - 1, yy + 1, str);  
	draw_text(xx + 1, yy - 1, str);  
	
	draw_set_color(color);  
	draw_text(xx, yy, str);  	
}
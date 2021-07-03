// player input
in_x = keyboard_check(ord("D")) - keyboard_check(ord("A"))
in_y = keyboard_check(ord("S")) - keyboard_check(ord("W"))
attack = mouse_check_button_pressed(mb_left);

if(in_x != 0) or (in_y != 0)
{
	dir = point_direction(0, 0, in_x, in_y);
	
	move_x = lengthdir_x(move_speed, dir);
	move_y = lengthdir_y(move_speed, dir);
	
	x += move_x
	y += move_y
}

attack_cooldown--

var sign_mouse = sign(mouse_x - x);

if(sign_mouse != 0)
{
	image_xscale = sign_mouse;	
}
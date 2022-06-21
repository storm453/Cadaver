function input()
{
	in_x = keyboard_check(ord("D")) - keyboard_check(ord("A"))
	in_y = keyboard_check(ord("S")) - keyboard_check(ord("W"))
	
	shift = keyboard_check(vk_shift);	
	attack = mouse_check_button_pressed(mb_left)
}
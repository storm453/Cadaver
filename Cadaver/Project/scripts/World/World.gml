function enemy_create(arg_hp = 10, arg_armor = 0, arg_knock_res = 0)
{
	return { hp: arg_hp, protection: 1 - (0.045 * arg_armor), knock_resistance: arg_knock_res }	
}
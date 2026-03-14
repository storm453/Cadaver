var _slot_size = slot_size * global.res_fix
var _slot_pad = slot_pad * global.res_fix

var _inv_slots_x = array_length(loot)
var _inv_slots_y = array_length(loot[0])

if(global.open_instance == id)
{
	loot_x = display_get_gui_width() / 2 + (slot_margin * global.res_fix)
	loot_y = inv_marg_y * global.res_fix
	
	for(var i = 0; i < _inv_slots_x; i++)
	{
		for(var j = 0; j < _inv_slots_y; j++)
		{
			var _slot_x = loot_x + (i * (_slot_size + _slot_pad))
			var _slot_y = loot_y + (j * (_slot_size + _slot_pad))
			
			do_slot(_slot_x, _slot_y, _slot_size, i, j)
		}
	}
}
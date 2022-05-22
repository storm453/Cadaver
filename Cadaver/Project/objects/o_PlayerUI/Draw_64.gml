var hp_x = 10;
var hp_y = 10;

var bar_draw = 3

hp_show = lerp(hp_show, o_Player.hp, 0.2);

var hp_w = (hp_show / 100) * sprite_get_width(s_HealthBar);
var hp_h = sprite_get_width(s_HealthBar)

draw_sprite_ext(s_HealthBar, 1, hp_x, hp_y, bar_draw, bar_draw, 0, c_white, 1)
draw_sprite_part_ext(s_HealthBar, 0, 0, 0, hp_w, hp_h, hp_x, hp_y, bar_draw, bar_draw, c_white, 1)

//energy bar
hp_y += hp_h * bar_draw + pad

energy_show = lerp(energy_show, o_Player.energy, 0.2);

var en_w = (energy_show / 100) * sprite_get_height(s_EnergyBar);
var en_h = sprite_get_width(s_EnergyBar)

draw_sprite_ext(s_EnergyBar, 1, hp_x, hp_y, bar_draw, bar_draw, 0, c_white, 1)
draw_sprite_part_ext(s_EnergyBar, 0, 0, 0, en_w, en_h, hp_x, hp_y, bar_draw, bar_draw, c_white, 1)

//ITEM PICKUP DROP NOTIFICATIONS LOG HJING YEAH
var log_x = 1700
var log_y = 1000

for(var i = 0; i < ds_list_size(item_log); i++)
{
	var log_height = 50
		
	var item_entry = item_log[|i]
		
	var item_spr_index = item_entry.spr_index
	//var item_name = o_iitem_entry.spr_index
	
	var fade_time = 0.5
	var fade_alpha = clamp(item_entry.time / fade_time, 0, 1)
	
	//@TODO Smooth moving
	//@HACK
	draw_set_alpha(fade_alpha)
	ui_draw_title(item_entry.msg, log_x, log_y - (log_height + pad) * i, 200, log_height, tab_color, c_white, false)
	draw_set_alpha(1)	
	
	item_entry.time -= get_delta_time()
		
	if(item_entry.time <= 0)
	{
		ds_list_delete(item_log, i)
	}
}
#macro pad 5

if(global.current_gui == gui.INVENTORY)
{
	
}

if(global.current_gui == gui.SELECTBLUE)
{
	var start_x = display_get_gui_width() / 2
	var start_y = display_get_gui_height() / 2

	var rec_scale = 100

	var rec_amt_x = 8
	var rec_amt_y = 5

	var rec_pad = 25

	var boxes_width = (rec_scale * rec_amt_x) + ((rec_amt_x - 1) * rec_pad)
	var boxes_height = (rec_scale * rec_amt_y) + ((rec_amt_y - 1) * rec_pad)

	start_x -= boxes_width / 2
	start_y -= boxes_height / 2

	ui_draw_window("Blueprints", start_x - 25, start_y - 25, boxes_width + 50, boxes_height + 50)

	for(var i = 0; i < rec_amt_x; i++)
	{
		for(var j = 0; j < rec_amt_y; j++)
		{
			if(building_grid[i,j] != 0)
			{
				var sprite_scale = 2.5 * (32 / sprite_get_width(building_grid[i,j].spr))

				var blueprint_button = ui_draw_button_sprite(building_grid[i,j].spr, 0, start_x + (i * (rec_scale + rec_pad)), start_y + (j * (rec_scale + rec_pad)), rec_scale, rec_scale, button_color, button_h_color, c_white, sprite_scale, false)
				if(blueprint_button[0])
				{
					global.current_gui = gui.BLUEPRINT
					blueprint_obj = building_grid[i,j].obj
				}
			}
			else
			{
				ui_draw_rectangle(start_x + (i * (rec_scale + rec_pad)), start_y + (j * (rec_scale + rec_pad)), rec_scale, rec_scale, button_color, 1, false)
			}
		}
	}
}
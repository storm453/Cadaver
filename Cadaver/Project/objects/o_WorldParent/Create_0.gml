z = 0

enum parent_type
{
	world,
	harvestable,
	interactable
}

type = parent_type.world

handle_damage = false

iframes = 0
iframes_set = 0

is_animal = false
is_parasite = false

infected = false
infectable = false

knockback = 0
knockback_velocity = vec2(0, 0)
knockback_target = noone

particles = part_system_create()

part_system_automatic_draw(particles, false)

state_timer_enabled = false
state_timer = 0
state_timer_next = 0

block_data = create_interactable("NULL", gui.INVENTORY)
damagable = false
hp = 0
max_hp = 0
hp_bar = false
custom_render = false
auto_z = true

velocity = vec2(0, 0)
velocity_dampen = 5

sway = 0
sway_time = 0

bounce = 0

function parent_hp(_hp)
{
	hp = _hp
	max_hp =_hp
	damagable = true
}

function damage_info()
{
	return {  }	
}

function render()
{
	if(hp_bar)
	{
		var _hp_bar_width = 20 * (hp / max_hp)
		var _hp_bar_height = 3
		
		var _hp_x = x - (_hp_bar_width / 2)
		var _hp_y = y - sprite_height / 2
		
		ui_draw_rectangle(_hp_x, _hp_y, make_rectangle(_hp_bar_width, _hp_bar_height, c_red, 1, false))
	}
	
	if(custom_render)
	{
		my_render()	
	}
	else
	{
		if(sprite_exists(sprite_index))
		{
			switch(type)
			{
				case(parent_type.world):
				{
					draw_self()
				}
				break;
			
				case(parent_type.harvestable):
				{
					var sprite_width_left = sprite_get_xoffset(sprite_index)
					var sprite_height_top = sprite_get_yoffset(sprite_index)

					var sprite_width_right = sprite_width - sprite_width_left
					var sprite_height_bottom = sprite_height - sprite_height_top
	
					var top_left = vec2(x - sprite_width_left, y - sprite_height_top)
					var top_right = vec2(x + sprite_width_right, y - sprite_height_top)

					var bottom_left = vec2(x - sprite_width_left, y + sprite_height_bottom)
					var bottom_right = vec2(x + sprite_width_right, y + sprite_height_bottom)

					var dist_to_player = distance_to_point(o_Player.x, o_Player.y)

					var dif = vec2(o_Player.x - x, o_Player.y - y)

					var dif_h = sqrt(dif.x * dif.x + dif.y * dif.y)

					var mov = vec2(dif.x / dif_h, dif.y / dif_h)
	
					sway_time += get_delta_time()
	
					sway = sin(sway_time)
	
					var bounce_effect = vec2(0,0)
	
					if(bounce > 0)
					{
						bounce_effect = vec2(bounce / 3, bounce / 2)
		
						bounce--
					}
	
					var parallax = vec2(-mov.x * dist_to_player / 25 * (sprite_width / 32) + sway, mov.y * dist_to_player / 25)

					parallax.x *= 1.4
			
					draw_sprite_pos(sprite_index, image_index, top_left.x + parallax.x - bounce_effect.x, top_left.y + parallax.y + bounce_effect.y, top_right.x + parallax.x + bounce_effect.x, top_right.y + parallax.y, bottom_right.x + bounce_effect.x + bounce_effect.y, bottom_right.y, bottom_left.x - bounce_effect.x, bottom_left.y, 1)
				}
				break;
			
				case(parent_type.interactable):
				{
					draw_self()	
				
					if(distance_to_object(o_Player) < interact_range)
					{
						draw_sprite_ext(sprite_index, 0, x, y, 1, 1, 0, c_red, 1)
					}
				}
				break;
			}
		}
	}
	
	if(infected)
	{
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_lime, 1)
	}

	part_system_drawit(particles)
}

ds_list_add(o_RenderManager.entities, self)
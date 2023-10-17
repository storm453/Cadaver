z = 0

enum parent_type
{
	world,
	harvestable,
	interactable
}

type = parent_type.world

handle_damage = false

animation = 0

iframes = 0
iframes_set = 0

is_animal = false
is_parasite = false

infected = false
infectable = false

knockback = 0
knockback_velocity = vec2(0, 0)
knockback_target = noone
knockback_strength = 80

//particles = new advanced_part_system()

//particles.enabledelta()
//particles_emitter = new advanced_part_emitter(particles, x - 25, x + 25, y - 25, y + 25, aps_shape.ellipse, aps_distr.linear);

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
					shader_set(sh_parallax)
	
					shader_set_uniform_f(shader_get_uniform(sh_parallax, "fBbox"), bbox_bottom)
					shader_set_uniform_f(shader_get_uniform(sh_parallax, "fObjVecOf"), (bbox_right + bbox_left)/2, (bbox_bottom))
					shader_set_uniform_f(shader_get_uniform(sh_parallax, "fBboxHeight"), (bbox_bottom-bbox_top));
	
					draw_self()
	
					shader_reset()
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
		if(!is_parasite) draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_lime, 0.1)
	}

	//articles.draw()
}

//ds_list_add(o_RenderManager.entities, self)
render_next = noone
render_prev = noone

next = noone
prev = noone

o_Game.world_add(self)

o_RenderManager.add(self)
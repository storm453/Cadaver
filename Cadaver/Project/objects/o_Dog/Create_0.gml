event_inherited()

parent_hp(5)

handle_damage = true
hp_bar = true

is_animal = true
infectable = true

function on_damage(_attacker)
{
	if(angry == noone)
	{
		state = dog_state.fof
	}

	angry = _attacker
}

dog_state = make_enum()

angry = noone
fof_chosen = false
fight = choose(true, false)

add_enum(dog_state, "idle")
add_enum(dog_state, "move")
add_enum(dog_state, "fof")
add_enum(dog_state, "charge")
add_enum(dog_state, "pounce")

state = dog_state.idle

dog_sprites = []

dog_animation[dog_state.idle] = make_animation(s_Dog, 0)
dog_animation[dog_state.move] = make_animation(s_DogWalk, 12)
dog_animation[dog_state.fof] = make_animation(s_DogWalk, 12)
dog_animation[dog_state.charge] = make_animation(s_DogCharge, 5)
end_animation(dog_animation[dog_state.charge], function(){ state = dog_state.pounce; pounce_timer = 0 } )
dog_animation[dog_state.pounce] = make_animation(s_DogPounce, 10)

custom_render = true

acc = 6
dog_speed = 90

pounce_distance = 50
pounce_timer = 0

move_distance = 200
move_target = vec2(x, y)

function my_render()
{
	if(state == dog_state.charge)
	{
		var _random_x = image_xscale + random(0.1)
		var _random_y = image_yscale + random(0.1)

		draw_sprite_ext(sprite_index, image_index, x, y, _random_x, _random_y, 0, c_white, 1)
		draw_sprite_ext(sprite_index, image_index, x, y, _random_x, _random_y, 0, c_red, 0.2)
	}
	else
	{
		draw_self()
	}
}
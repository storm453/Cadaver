event_inherited()

parent_hp(5)

handle_damage = true
hp_bar = true

is_animal = true
infectable = true

function on_damage(_attacker)
{
	angry = _attacker
	
	if(!fof_chosen)
	{
		fof_chosen = true
		fight = choose(false, true)
	}
}

dog_state = make_enum()

angry = noone
fof_chosen = false
fight = false

add_enum(dog_state, "idle")
add_enum(dog_state, "move")
add_enum(dog_state, "fof")
add_enum(dog_state, "charge")
add_enum(dog_state, "pounce")

state = dog_state.idle

dog_sprites = []

dog_sprites[dog_state.idle] = s_Dog
dog_sprites[dog_state.move] = s_DogWalk
dog_sprites[dog_state.fof] = s_DogWalk
dog_sprites[dog_state.charge] = s_DogCharge
dog_sprites[dog_state.pounce] = s_DogPounce

acc = 6
dog_speed = 90

pounce_distance = 50
pounce_timer = 0

move_distance = 200
move_target = vec2(x, y)
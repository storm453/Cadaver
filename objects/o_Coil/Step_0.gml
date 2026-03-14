event_inherited()

particles_emitter = new advanced_part_emitter(particles, x - 25, x + 25, y - 25, y + 25, aps_shape.ellipse, aps_distr.linear);

advanced_part_emitter_burst(particles, particles_emitter, global.particle_spore, 40)

for(var i = 0; i < instance_number(o_WorldParent); i++)
{
    var _parent = instance_find(o_WorldParent, i)

    if(_parent.infectable)
    {
        if(_parent.infected == false)
        {
            if(point_in_circle(_parent.x, _parent.y, x, y, 20))
            {
                _parent.infected = true

                infects++

                if(_parent.object_index == o_Player)
                {
                    o_Player.infect_alpha = 1
                }
            }
        }
    }
}

fear = clamp(fear, 0, 50)

sprite_index = coil_sprites[state]

var _player_distance = distance_to_object(o_Player)

switch(state)
{
    case(coil_state.idle):
    {   
        fear -= get_delta_time()

        if(_player_distance <= danger_distance)
        {
            state = coil_state.open
        }
    }
    break;

    case(coil_state.open):
    {
        fear += get_delta_time()

        if(_player_distance > danger_distance)
        {
            state = coil_state.idle
        }
    }   
    break;
}

if(fear >= fear_spawn)
{
    fear = 0

    var _lace = infects_spawn(3, o_Lace)

    if(_lace == noone)
    {
        var _thread = infects_spawn(1, o_Thread)

        with(_thread)
        {
            choice = thread_choice.lace
        }
    }
}

if(fear <= 1)
{
    var _coil = infects_spawn(3, o_Coil)

    with(_coil)
    {
        infects = 0
    }
}
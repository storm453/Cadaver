event_inherited()

is_parasite = true
infects = 0
fear = 0
fear_spawn = 5

parent_hp(10)

coil_state = make_enum()

add_enum(coil_state, "idle")
add_enum(coil_state, "open")

state = coil_state.idle

coil_sprites[coil_state.idle] = s_Coil
coil_sprites[coil_state.open] = s_CoilOpen

custom_render = true

danger_distance = 120

handle_damage = true

function infects_spawn(amount, entity)
{   
    var _successful = noone

    if(infects >= amount)
    {
        infects -= amount

        var _angle = random(360)

        var _spawn = circle_point(x, y, 25, _angle)

        _successful = instance_create_layer(_spawn.x, _spawn.y, "World", entity)
    }

    return _successful
}

function on_damage()
{
   infects_spawn(3, o_Lace)
}

function my_render()
{
    // draw_set_color(c_red)
    // draw_set_alpha(1)
    // draw_circle(x, y, 20, true)

    draw_self()

    if(global.db_enemy)
    {
        draw_set_color(c_white)
        draw_set_alpha(1)
        draw_text(x, y, infects)

        draw_text(x, y + 50, fear)
    }
}
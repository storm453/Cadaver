//application_surface_draw_enable(false)

if(!surface_exists(temp_surface))
{
	temp_surface = surface_create(1280, 720)
}

if((surface_get_width(temp_surface)  != surface_get_width(application_surface)) or (surface_get_height(temp_surface)  != surface_get_height(application_surface)))
{
	surface_resize(temp_surface, surface_get_width(application_surface), surface_get_height(application_surface))
}
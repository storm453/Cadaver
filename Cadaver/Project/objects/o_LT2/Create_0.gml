gw = display_get_gui_width()
gh = display_get_gui_height()

cw = o_Camera.x_size * o_Camera.zoom
ch = o_Camera.y_size * o_Camera.zoom

lighting = surface_create(cw, ch)
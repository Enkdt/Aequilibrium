// Inherit the parent event
event_inherited();
	room_goto(Room1);
	obj_plr.x = 130
	obj_plr.y = 1860
	surface_resize(application_surface, 2560, 1440);
	camera_set_view_size(view_camera[0], 1280, 720);
	view_wport[0] = 2560;
	view_hport[0] = 1440;

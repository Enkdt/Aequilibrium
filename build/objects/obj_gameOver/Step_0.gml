window_center()
//Registro de teclas usadas para o menu
var upKey = keyboard_check_pressed(vk_up);
var downKey =keyboard_check_pressed(vk_down);
var enterKey = keyboard_check_pressed(vk_enter)
var yInput = downKey - upKey

//Número de opções no menu que está, tem de resetar a cada step

//"Efeito de volta do menu"
hover += yInput;
if hover < 0 {hover = optLen-1}
if hover >= optLen {hover = 0}

//Gigantesca switch case para o menu
if enterKey{
		switch (hover){
		case 0: 
		room_goto(Room1);
		obj_plr.x = 130
		obj_plr.y = 1860
		surface_resize(application_surface, 2560, 1440);
		camera_set_view_size(view_camera[0], 1280, 720);
		view_wport[0] = 2560;
		view_hport[0] = 1440;
		break;
		case 1: room_goto(Menu_ass); break;
		case 2: game_end() break;
		}
	}
switch (button_id){
	//Resume
	case 0:
		if instance_exists(obj_pausemanager){
			obj_pausemanager.paused = !obj_pausemanager.paused;
			obj_pausemanager.update_pause();
		}
	break;
	
	//Settings
	case 1:
	break;
	
	//Exit Game
	case 2:
		game_end();
	break;
}
function keysCheck(){	//Adiciona as keys que serão usadas
	//Wasd ou setinhas, pra movimento básico
	_left = keyboard_check(vk_left) or keyboard_check(ord("A"));
	_right = keyboard_check(vk_right) or keyboard_check(ord("D"));
	_up = keyboard_check(vk_up) or keyboard_check(ord("W"));
	_down = keyboard_check(vk_down) or keyboard_check(ord("S"));
	
	//botão de pulo
	_jumpKeyPressed = keyboard_check_pressed(vk_space);
	//botões de hábilidades de movimento
	_sprintKeyPressed = keyboard_check(vk_shift)	
	_dashKeyPressed = keyboard_check_pressed(ord("Q"))	
}

function pixelCheck(axisSpeed){
	_closerPixel = 0.0001
	Teste = _closerPixel*sign(axisSpeed)
	return Teste;
}
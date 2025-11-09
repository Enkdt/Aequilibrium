window_set_size(900,600)


function keysCheck(){	//Adiciona as keys que serão usadas
	//Wasd ou setinhas, pra movimento básico
	_left = keyboard_check(vk_left) or keyboard_check(ord("A"));
	_right = keyboard_check(vk_right) or keyboard_check(ord("D"));
	_up = keyboard_check(vk_up) or keyboard_check(ord("W"));
	_down = keyboard_check(vk_down) or keyboard_check(ord("S"));
	
	_left = clamp(_left,0,1)
	_right = clamp(_right,0,1)
	_up = clamp(_up,0,1)
	_down = clamp(_down,0,1)	
	//botão de pulo
	_jumpKeyPressed = keyboard_check_pressed(vk_space);
	_jumpKey = keyboard_check(vk_space)
	
	//botões de habilidades de movimento
	_sprintKey = keyboard_check(vk_shift)	
	_dashKeyPressed = keyboard_check_pressed(ord("J"))
	_dashKeyPressed = clamp(_dashKeyPressed, 0, 1)
	_mousekey = keyboard_check_pressed(ord("K"))

	//botão de troca
	_switchKey = keyboard_check_pressed(vk_control)
}

function buffers(){
	keysCheck();
	bufferTime = 1000;
	jumpKeyBuffer = {
		isBuffering: false,
		timer:0,
	}
	wallKeyBuffer = {
		isBuffering: false,
		timer:0,
		bufferTime:5,
	}
	//jump buffer
	if	_jumpKeyPressed{
		jumpKeyBuffer.timer = bufferTime;
	}
	if jumpKeyBuffer.timer>0{
		jumpKeyBuffer.timer--;
		jumpKeyBuffer.isBuffering = true
	}
	else{
		jumpKeyBuffer.isBuffering = false
	}
	//wallbuffer
	if	_jumpKeyPressed and walled{
		wallKeyBuffer.timer = wallKeyBuffer.bufferTime;
	}
	if wallKeyBuffer.timer>0{
		wallKeyBuffer.timer--;
		wallKeyBuffer.isBuffering = true
	}
	else{
		wallKeyBuffer.isBuffering = false
	}
}
function keysCheck(){	//Adiciona as keys que serão usadas
	//Wasd ou setinhas, pra movimento básico
	_left = keyboard_check(vk_left) or keyboard_check(ord("A"));
	_right = keyboard_check(vk_right) or keyboard_check(ord("D"));
	_up = keyboard_check(vk_up) or keyboard_check(ord("W"));
	_down = keyboard_check(vk_down) or keyboard_check(ord("S"));
	
	//botão de pulo
	_jumpKeyPressed = keyboard_check_pressed(vk_space);
	_jumpKey = keyboard_check(vk_space)
	//botões de hábilidades de movimento
	_sprintKey = keyboard_check(vk_shift)	
	_dashKeyPressed = keyboard_check_pressed(ord("Q"))	
}

function Walled(){
	while place_meeting(x,y+0.5,obj_collision){
		y-=0.1
	}
	while place_meeting(x,y-0.5,obj_collision){
		y+=0.1
	}
}

function buffers(){
	keysCheck();
	bufferTime = 3;
	jumpKeyBuffer = {
		isBuffering: false,
		timer:0,
	}
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
}

function pixelCheck(axisSpeed){
	_closerPixel = 0.01
	Teste = _closerPixel*sign(axisSpeed)
	return Teste;
}


//teclas que recebem input, o ord(x) pega o ascii da tecla selecionada :)
var _left = keyboard_check(vk_left) or keyboard_check(ord("A"))
var _right = keyboard_check(vk_right) or keyboard_check(ord("D"))
var _shift = keyboard_check(vk_shift);
var _spacebarPressed = keyboard_check_pressed(vk_space);
var _qPressed = keyboard_check_pressed(ord("Q"));

//Direção de movimento
MvDir = _right - _left;
//Velocidade de incremento do x
x_spd = MvDir * (_shift?runspeed:walkspeed);

//para "abraçar" a parede
var _collidePixel = .75;
if place_meeting(x + x_spd,y,oWall){
	var _pixelCheckx = _collidePixel * sign(x_spd);
	while(!place_meeting(x+_pixelCheckx,y,oWall)){
		x+=_collidePixel;
	}
	x_spd = 0;
}

//dash
if _qPressed && !dashed{
	if place_meeting(x + dashDistance,y,oWall){
		var _pixelCheckx = _collidePixel * sign(x_spd);	
		while(!place_meeting(x+_pixelCheckx,y,oWall)){
			x+=_collidePixel;
		}
	}
	else{
		x+=dashDistance*MvDir;
	}
	dashed = true;
}


//Y e pulo
y_spd += grav;
if y_spd>capGrav{y_spd=capGrav;}

var grounded = place_meeting(x, y + 1,oWall);

if grounded  && _spacebarPressed{
	y_spd = jmpSpd;
}

if grounded{dashed=false}

if place_meeting(x,y + y_spd,oWall){
	var _pixelChecky = _collidePixel * sign(y_spd);
	while !place_meeting(x,y+_pixelChecky,oWall){
		y+=_collidePixel;
	}
	y_spd = 0;
}

y+=y_spd
x+=x_spd
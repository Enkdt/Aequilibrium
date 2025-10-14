//Máquina de estados
enum state{
	idle,
	running,
	walking,
	jumping,
	falling,
	dashing,
	shooting,
	skating,
	walljumping,
}

currentState = state.idle;

//Teclas, andar e correr
keysCheck();
mv ={
mvSpeed:3,
sptSpeed: 6,
}
//Pulo
jump = {
	jheight: -7,
	max: 2,
	counter: 0,
	hold:0,
	frames:18,
}
walljump = {
	initialXSpd:20,
	active:false,
	able:false,
	wjheight:10,
	delay:0,
	time:10,
	distance:50,
	spd: 0,
}

//Alterar direção do sprite	
spr_flip = 1

//Dash
dash = {
	able:true,
	distance:200,
	time:10,
	delay:0,
	dir:0,
	spd:0,
	duration:0,
	delay:30,
	active:false
}

//eixo y
ySpd = _down - _up;
grav = 0.375;
yAccelCap = 10;
grounded = true;

//eixo x
xSpd = _right-_left
xInput = 0
moveLock = 0;
spd = 3;	
keysCheck(); // chamada da função do script, invoca as teclas
var collisions = [obj_wall,obj_ground] // define os objetos que vão colidir

//Debug
if keyboard_check(vk_control){
	x = 450;
	y = 370;
}

//basico x e y, add gravidade e sprintspeed
var xSpd = _right - _left;
xSpd *= _sprintKeyPressed?sptSpeed:mvSpeed
ySpd+=grav

var grounded = place_meeting(x,y + 1,collisions) //verificar se está no chão
if grounded {jumpCounter=0; dash.able = true} //reset de pulo caso no chão

if _jumpKeyPressed && jumpCounter<jumpMax{ //permite o pulo duplo
	jumpCounter+=1;
	ySpd = -jumpHeight;
}

if xSpd>0{
	spr_flip = 1;
} else {
	if xSpd<0{
		spr_flip = -1;
	}
}

if ySpd>yAccelCap{ySpd=yAccelCap} //Cap no Y, para que não fique ultra rápido

//Dash
//Não sei como ta funcionando, nao mexe.
if _dashKeyPressed and dash.able and !dash.active{
	dash.able = false;
	dash.active = true;
	jumpCounter = jumpMax+1;
	dash.dir = point_direction(0, 0, spr_flip, 0);
	dash.spd = dash.distance/dash.time;
	dash.energy = dash.distance;
}

if dash.active{
	xSpd = lengthdir_x(dash.spd, dash.dir);
	with (instance_create_depth(x,y,depth+1,obj_trail)){ //Trilha bonitinha
		sprite_index = other.sprite_index;
		image_blend = c_black;
		image_alpha = 0.7;
	}
	dash.energy-=dash.spd;
	if(dash.energy<=0){
		xSpd = 0;
		dash.active = false;
	}
}

var collide_vertical = place_meeting(x,y+ySpd,collisions);
var collide_horizontal = place_meeting(x+xSpd,y,collisions);

//colisão do x, vai até o pixel mais próximo e para o spd
if collide_horizontal{
	var pxc = pixelCheck(xSpd)
	while !place_meeting(x+pxc,y,collisions){
		x+=pxc;
	}
	xSpd=0;
}

//colisão do y, mesma lógica que o X
if collide_vertical{
	var pxc = pixelCheck(ySpd)
	while !place_meeting(x,y+pxc,collisions){
		y+=pxc;
	}
	ySpd=0;
}

y+=ySpd
x+=xSpd

image_xscale = spr_flip //Vira a imagem

//Agora só resta chorar :-)
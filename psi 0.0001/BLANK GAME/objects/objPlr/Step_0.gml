keysCheck(); // chamada da função do script, invoca as teclas
var collisions = [objWall,objGround] // define os objetos que vão colidir
//basico x e y, add gravidade e sprintspeed
var xSpd = _right - _left;
xSpd *= _sprintKeyPressed?sptSpeed:mvSpeed
ySpd+=grav

var grounded = place_meeting(x,y + 1,collisions) //verificar se está no chão
if grounded {jumpCounter=0 dashCounter=0} //reset de pulo caso no chão

if _jumpKeyPressed && jumpCounter<jumpMax{ //permite o pulo duplo
	jumpCounter+=1;
	ySpd = -jumpHeight;
}

if _dashKeyPressed && dashCounter<dashCap{
	dashCounter++;
	xSpd=dashDistance*sign(xSpd);
}
if ySpd>yAccelCap{ySpd=yAccelCap} //Cap no Y, para que não fique ultra rápido

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

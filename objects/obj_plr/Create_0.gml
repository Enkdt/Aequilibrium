keysCheck();
mvSpeed = 3;
sptSpeed = 6;

jumpHeight = 10;
jumpMax = 2;
jumpCounter = 0;

spr_flip = 1

//Dash
dash = {
	able:true,
	distance:200,
	time:10,
	dir:0,
	spd:0,
	energy:0,
	active:false
}



ySpd = _down - _up;
grav = 0.375;
yAccelCap = 10;

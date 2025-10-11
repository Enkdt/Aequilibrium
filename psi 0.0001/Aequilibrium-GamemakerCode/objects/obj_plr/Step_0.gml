keysCheck(); // chamada da função do script, invoca as teclas
buffers();
var collisions = [obj_collision,obj_ground] // define os objetos que vão colidir
//Debug
if keyboard_check(vk_control){
	x = 450;
	y = 370;
}

walljump.delay = max(walljump.delay-1,0)
dash.delay = max(dash.delay-1,0)
xSpd = _right-_left 
xSpd *= _sprintKey?mv.sptSpeed:mv.mvSpeed
if ySpd>=0 and place_meeting(x,y + 1,collisions) grounded = true//verificar se está no chão
else grounded = false
if grounded {jump.counter=0; dash.able = true} 
else{
	if jump.counter==0 {
		jump.counter=1
	}
}//reset de pulo caso no chão
var walled = spr_flip*(place_meeting(x + 0.3,y,collisions)-place_meeting(x - 0.3,y,collisions))

ySpd+= grav;
//walljump-to/do



if  jumpKeyBuffer.isBuffering and walljump.delay == 0{
	if walled && !grounded {
			jump.counter=2;
			ySpd=0.75*-walljump.wjheight;
			xSpd = -walled * walljump.distance * spr_flip
			walljump.delay = 18
			with (instance_create_depth(x,y,depth+1,obj_walltrail)){ //Trilha bonitinha
				sprite_index = obj_walltrail.sprite_index;
				image_blend = c_black;
				image_alpha = 0.7;
			}
		}
	}
	
if jumpKeyBuffer.isBuffering and !walled and jump.counter<jump.max{
	jump.counter++;
	jump.hold = jump.frames;
	ySpd = jump.jheight
}

if jump.hold>0 && _jumpKey{
	ySpd = jump.jheight
	jump.hold--;
}
else{
	jump.hold = 0
}


if xSpd>0{
	spr_flip = 1;
} else if xSpd<0 {
	spr_flip = -1;
}

if ySpd>yAccelCap{ySpd=yAccelCap} //Cap no Y, para que não fique ultra rápido

//Dash
//Não sei como ta funcionando, nao mexe.

if dash.delay ==0{
	if _dashKeyPressed and dash.able and !dash.active{
		dash.delay=40
		dash.able = false;
		dash.active = true;
		dash.dir = point_direction(0, 0, spr_flip, 0); //usa spr_flip p/ direção
		dash.spd = dash.distance/dash.time; 
		dash.duration = dash.distance;
	}
}
	if dash.active{
		xSpd = lengthdir_x(dash.spd, dash.dir);
		with (instance_create_depth(x,y,depth+1,obj_trail)){ //Trilha bonitinha
			sprite_index = other.sprite_index;
			image_blend = c_black;
			image_alpha = 0.7;
		}
		dash.duration-=dash.spd;
		if(dash.duration<=0){
			xSpd = 0;
			dash.active = false;
		}
		Walled();
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
	while !place_meeting(x,y+pxc,collisions){y+=pxc;}
	if ySpd<0{jump.hold=0} //bonk, pro pulo segurado não ficar flutuando qndo colidir
	ySpd=0;
}
Walled();

y+=ySpd
x+=xSpd

image_xscale = spr_flip //Vira a imagem

//Agora só resta chorar :-)
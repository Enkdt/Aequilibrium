keysCheck(); // chamada da função do script, invoca as teclas
buffers();
var collisions = [obj_collision,obj_groundCollision]; // define os objetos que vão colidir
//Debug
if keyboard_check(vk_control){
	x = 450;
	y = 370;
}

//Adição de gravidade ao Y, para que haja queda.
ySpd+= grav;

//Cooldowns tick
walljump.delay = max(walljump.delay-1,0)
dash.delay = max(dash.delay-1,0)

//X direction
xInput = _right - _left

//Verificar se está grounded
if ySpd>=0 and place_meeting(x,y + 1,collisions){ 
	grounded = true;
	//reset de habilidades
	jump.counter=0; 
	dash.able = true;
} else{
	grounded = false 
	//Para não ter 2 pulos pós queda de plataforma
	if jump.counter==0 {jump.counter=1}
}

//Check se encosta na parede
var walled = spr_flip*(place_meeting(x + 0.3,y,collisions)-place_meeting(x - 0.3,y,collisions))

//Condições adicionais quando encostado na parede
if walled{
	//Aumento de gravidade quando encostado na parede
	ySpd+=0.2
	//Criação de Trilha no pé do personagem
	with (instance_create_depth(x,y,depth+1,obj_walltrail)){ 
		sprite_index = obj_walltrail.sprite_index;
		image_blend = c_red;
		image_alpha = 0.7;
	}
}

//Definição de estados para a state machine
if grounded and xInput == 0{
	with (instance_create_depth(x-64,y-100,depth+1,obj_aura)){ 
		sprite_index = obj_aura.sprite_index;
		image_xscale =2;
		image_yscale = 2;
		image_alpha = 0.7;
	}
	currentState = state.idle
}
else if xInput!=0 and grounded{
	if _sprintKey currentState = state.running
	else currentState = state.walking
}

//check de pulo e/ou walljump

if  jumpKeyBuffer.isBuffering{
	if walled and !grounded  and walljump.delay == 0 {
		currentState = state.walljumping
	}
	if jumpKeyBuffer.isBuffering and jump.counter<jump.max{
		currentState = state.jumping
		if walled and jump.counter>0{
			currentState=state.walljumping
		}
	}
}
//check se está no ar
else if !grounded{
	currentState = state.falling
}

//pulo segurável
if jump.hold>0 and _jumpKey{
	ySpd = jump.jheight
	jump.hold--;
}
else{
	jump.hold = 0
}

//delay do dash
if dash.delay == 0{
	if _dashKeyPressed and dash.able and !dash.active{
		currentState = state.dashing
	}
}

//MAQUITA DE ESTADOS
switch currentState{
	//walljump state
    case state.walljumping:
        jump.counter=2;
        ySpd=0.8*-walljump.wjheight;
        xSpd = -walled * walljump.distance * spr_flip
        walljump.delay = 18
        break;
	//jump state		
    case state.jumping:
		if xInput!=0 {
			xSpd = xInput * mv.mvSpeed
		}
		jump.counter++;
		jump.hold = jump.frames;
		ySpd = jump.jheight;
		break;
	//falling state		
	case state.falling:
		xSpd = xInput * mv.mvSpeed
		break;	
	//walking state		
	case state.walking:
		xSpd = xInput * mv.mvSpeed
		break;
	//running state		
	case state.running:
		xSpd = xInput * mv.sptSpeed
		break;
	//idle state				
	case state.idle:
		xSpd = 0
		break;
	//dashing state			
	case state.dashing:
		dash.delay=40
		dash.able = false;
		dash.active = true;
		dash.dir = point_direction(0, 0, spr_flip, 0); //usa spr_flip p/ direção
		dash.spd = dash.distance/dash.time; 
		dash.duration = dash.distance;
		break;
}

//O que é ativado se dash estiver ativo :)
if dash.active{
	xSpd = lengthdir_x(dash.spd, dash.dir);
	//Trilha do dash
	with (instance_create_depth(x,y,depth+1,obj_trail)){
		sprite_index = other.sprite_index;
		image_blend = c_black;
		image_alpha = 0.7;
	}
	//Dash decrescer para não ficar infinita duração
	dash.duration-=dash.spd;
	//Acaba o dash
	if(dash.duration<=0){
		xSpd = 0;
		dash.active = false;
	}
	//verifica os headbumps e colisões
	clipInGround(); 
}

//Flipa o sprite da direção
if xSpd > 0 spr_flip = 1 else spr_flip = -1

//Adição de mecânicas de boost
if place_meeting(x,y,obj_upwardBoost){
	ySpd -= 1-grav;
}
if place_meeting(x,y,obj_lateralBoost){
	xSpd += 30;
}

//Cap no Y, para que não fique ultra rápido
if ySpd>yAccelCap{ySpd=yAccelCap}

//Declaração de colisões
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

//Adição das velocidades Xspd e Yspd a seus respectivos eixos
y+=ySpd
x+=xSpd

//Vira a imagem de acordo com seu lado
image_xscale = spr_flip

//Agora só resta chorar :-)
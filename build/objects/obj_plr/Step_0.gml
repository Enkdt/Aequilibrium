//Adição de mecânicas de boost
var hBoosting = colConditionCheck(0,0,obj_horizontalBoost)
var hSpecBoosting = colConditionCheck(0,0,obj_horizontalSpecBoost)
//chamada de funções buffer e keycheck, definidas no script
keysCheck();
buffers();
//Debug
if keyboard_check(vk_control){
	room = Room7
	x = 70
	y = 680
	ySpd = 0
}

if _switchKey and ying==false and colConditionCheck(0,0,obj_swapPlatform){
	ying = true
} 
else if _switchKey and ying==true and colConditionCheck(0,0,obj_swapPlatform){
	ying = false
}

//Time tick
atk.delay = cdTick(atk.delay)
dash.delay = cdTick(dash.delay)
walljump.delay = cdTick(walljump.delay)
parry.delay = cdTick(parry.delay)

alpha  = lerp(alpha,0,0.1)

if room==Menu_ass or room==Room8{
	dead = true
	camera_set_view_size(view_camera[0], 1000, 1000);
}
else{
	dead = false
}

//X direction
if !hBoosting{xInput = _right - _left}

//Y direction
yInput = _down - _up;

if coyote.airedTimer > 0{
	coyote.airedTimer--;
}
else{
	ySpd += grav;
	setGrounded(false);
}

if grounded{
	jump.counter = 0;
	jump.hold = 0;
	dash.able = true;
	coyote.canJumpTimer = coyote.canJumpFrames;
}
else 
{
	if jump.counter == 0 and coyote.canJumpTimer< 0{
		jump.counter = 1;
	}
	coyote.canJumpTimer--
}

//define sprite direction
if !iframe.active and !parry.active and !dash.active{
	if xInput !=0{
		image_xscale = xInput
	}
}

//Walk & sprint
if xInput!=0{
	if _sprintKey{
		xSpd = xInput * mv[1];
	}
	else{
		xSpd = xInput * mv[0];
	}
}
else if xInput = 0{xSpd=0}

//Check de pulo e/ou walljump
if jumpKeyBuffer.isBuffering
	{
	if walled and !grounded and walljump.delay == 0{
		jump.counter = 0;
		walljump.delay = 20;
		walljump.active = true;
		walljump.timer = walljump.duration;
		dash.able = true;
	}
	else {walljump.active=false;}
	if jump.counter <= jump.max{
		if jump.counter < jump.max{
			jumpKeyBuffer.isBuffering = false;
			jumpKeyBuffer.bufferTime = 0;
			jump.counter++
			jump.hold = jump.frames[jump.counter-1];
			setGrounded(false);
		}
	}
}

if !_jumpKey{
	jump.hold = 0;
}

if jump.hold > 0 and _jumpKey
{
	if jump.counter>0{
		ySpd = jump.heights[jump.counter-1];
	}else ySpd = jump.heights[0]
	jump.hold--;
}
	
//Funções de walljump caso esteja ativo
if walljump.active {
	xSpd = walljump.distance*-xInput
	ySpd = walljump.height
	walljump.timer--;
	if walljump.timer=0{
		walljump.active = false
	}
}

//Ativação do dash
if !ying{
	if dash.delay == 0{
		if _dashKeyPressed and dash.able and !dash.active{
			dash.delay=40;
			dash.able = false;
			dash.active = true;
			dash.spd = dash.distance/dash.time; 
			dash.duration = dash.distance;
			dash.dir = point_direction(0,0,image_xscale,0);
		}
	}
	//O que é ativado se dash estiver ativo :)
	if dash.active{
		ySpd = 0
		xSpd = lengthdir_x(dash.spd, dash.dir)
		//Trilha bonitinha
		trail(0,0,1,obj_trail,c_black,0.7)
		//Dash decrescer para não ficar infinita duração
		dash.duration-=dash.spd;
		//Acaba o dash
		if(dash.duration<=0){
			xSpd = 0;
			ySpd = 0;
			dash.active = false;
		}
	}
}

//Parry
if keyboard_check_pressed(ord("P")) and parry.delay==0 and !parry.active{
	parry.active=true
	parry.timer=20
	image_index=0
}

if parry.active{
	if(sprite_index!=spr_plr_parry){
		sprite_index=spr_plr_parry
		image_speed=1
	}
	xSpd=0
	ySpd=0
	parry.timer--
	if !instance_exists(obj_collision_parry){
		instance_create_layer(x,y,"Instances",obj_collision_parry);
	}
	if parry.timer<=0 or parry.work=true{
		if(instance_exists(obj_collision_parry)){
			instance_destroy(obj_collision_parry)
		}
		parry.active = false
		if parry.work{ //Checa se o parry funcionou, para o cooldown ficar menor
			color = c_yellow
			alpha = 1
			parry.delay=5;
			parry.work=false
		}
		else{
			parry.delay = 60
		}
	}
}

if atk.delay==0 and _mousekey and grounded and !atk.active and abs(xSpd)!=mv[1]{
	atk.active = true;
	atk.delay = 30;
	image_index = 0
}

if atk.active{
	var enemies = [obj_enemy_shoot,obj_enemy_follow,obj_enemy_patrol, obj_boss1_hand]
	_sprintKey = false
	xSpd *=0.3
	
	if(sprite_index!=spr_plr_atk){
		sprite_index=spr_plr_atk
		image_speed=1
		ds_list_clear(hitByAttack)
	}
	
	var last_image_index = image_index
	
	mask_index=spr_collsion_atk
	var hitByAttackNow = ds_list_create()
	var hits = instance_place_list(x,y,enemies,hitByAttackNow,false)
	if (hits > 0) {
		for(var i = 0; i < hits; i++){
			var hitID = hitByAttackNow[|i]
			if (ds_list_find_index(hitByAttack,hitID) == -1){
				ds_list_add(hitByAttack,hitID)
				with(hitID){
					if !hit{
						hit = true
						//ySpd=-10
						//xSpd=3*image_xscale
						hitstop(50)
						if instance_exists(obj_boss1_hand){
							if(id==obj_boss1.hand_l) or (id==obj_boss1.hand_r){
								if !obj_boss1_hand.immune{
									obj_boss1.life-=obj_plr.atk.damage
									alpha=1
								}
							}
						}else{
							knockback(3,10,obj_plr.image_xscale)
							life-=obj_plr.atk.damage
							alpha=1
						}
						hitdelay=10
					}
				}
			}
		}
	}
	ds_list_destroy(hitByAttackNow)
	mask_index=spr_plr_idle
	if(image_index>image_number-1){
		sprite_index=spr_plr_idle
		atk.active=false
	}
}

var enemies = instance_place(x, y, global.evil_collide)
if enemies and !enemies.knockbacked and iframe.active==false{
	hp.count-=1;
	iframe.active = true
}
if hp.count <= 0{
	if(instance_exists(obj_boss1)){
		obj_boss1.activated = false
		obj_boss1.bossstart = false
		obj_boss1.bossdeath = false
	}
	room_goto(Room8)
	dead = true
	hp.count = 10;
}

if iframe.active{
	iframe.time = cdTick(iframe.time)
	iframe.blink = (iframe.time div 3) mod 2
	if iframe.time<=0{
		iframe.active  = false;
		iframe.time = 50;
		iframe.blink = false
	}
}

if hBoosting{
	xSpd += 25 * image_xscale
	ySpd = 0
}
if hSpecBoosting{
	xSpd = 7 * image_xscale
	ySpd = -3;
}

if instance_exists(obj_boss1){
	if obj_boss1.activated{
		_jumpKeyPressed  = false
		_jumpKey = false
		xSpd = 0
		if ySpd <0{
			ySpd = 0
		}
	}
}

//Declaração de colisões 
xCollision(global.collisions);
x+=xSpd

//Adição de uma "Fricção" qunaod encostado na parede
if walled and !grounded{
	if yInput<0{
		ySpd = -2
	}
	else{
		ySpd +=0.04
	}
}

//colisão do y, mesma lógica que o X
yCollision(global.collisions);
y+=ySpd

window_center()
//fullscreen toggle
if keyboard_check_pressed(vk_f11)
{
	window_set_fullscreen(!window_get_fullscreen())
}
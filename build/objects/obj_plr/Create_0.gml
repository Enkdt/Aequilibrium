//Colisões definidas como globais visando facilitar códigos
global.collisions = [obj_wallCollision,obj_groundCollision]
global.evil_collide = [obj_enemy_follow, obj_enemy_shoot, obj_enemy_patrol, obj_spiek]

paused = false;
layer_name = "PauseLayer";

update_pause = function()
{
	if(paused)
	{
		layer_set_visible(layer_name, true)
	}
	else{
		layer_set_visible(layer_name, false);
	}
}
update_pause();

//Plr
ying = false

//Movimento
mv = [3,9]

//Pulo
jump = {
	max: 2,
	counter: 0,
	hold:0,
	heights: [-7,-5],
	frames:[18,9],
}

coyote = {
	//Hang time, em que ele pode ficar no ar, substituí por aired
	airedWalkFrames:5,
	airedSptFrames:3,
	airedTimer:0,
	//Tempo útil que ele pode pular
	canJumpFrames:7,
	canJumpTimer:0,
}

//Pulo parede
walljump = {
	height: -4,
	distance: 15,
	hold:0,
	frames:20,
	delay:0,
	active: false,
	duration: 5,
	timer: 0,
}

//Dash
dash = {
	able:true,
	distance:200,
	time:10,
	dir:0,
	spd:0,
	duration:0,
	delay:30,
	active:false
}

//Attack
hitByAttack=ds_list_create()

atk={
	active:false,
	delay:10,
	damage:5
}

//eixo y
ySpd = clamp(0,-1,1)
yInput = 0
grav = 0.375;
grounded = true;
walled = false

//eixo x
xSpd = clamp(0,-1,1)
xInput = 0

//Hp
hp = {
	count: 10,
	mx: 10,
}
iframe = {
	active:true,
	time:90,
}

parry={
	active:false,
	timer:0,
	delay:60,
	work:false
}

alpha = 0
color = c_white

dead = false

//image_yscale=1.25
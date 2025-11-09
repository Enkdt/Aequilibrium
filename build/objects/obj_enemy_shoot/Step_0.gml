mask_index=spr_shoot_idle

alpha=lerp(alpha,0,0.1)

delay = cdTick(delay);

hitdelay = cdTick(hitdelay)
if hitdelay==0{
	hit = false
}

if(life<=0){
	instance_create_layer(x,y,layer,obj_explosion)
	instance_destroy();
}

if obj_plr.x < x - 1{
	image_xscale = 1; // Se o player está à esquerda com folga
}else if obj_plr.x > x + 1{
	image_xscale = -1; // Se o player está à direita com folga
}

if delay==0 and !shoot{
	var bala = instance_create_layer(x-(1*image_xscale),y+30,layer,obj_bullet);
	bala.spawn_dir = image_xscale*-1;
	delay=60
	shoot=true
	sprite_index = spr_shoot_shot
	image_index=0
	image_speed=1
}

if !shoot and grounded{
	sprite_index=spr_shoot_idle
	image_speed=1
}else if !shoot and !grounded{
	knockbacked = true
	sprite_index = spr_shoot_shot_1
	delay = 20
}

if grounded and !hit{
	xSpd = 0
	knockbacked = false
}

mask_index=spr_shoot_idle
yNxEnemy(global.collisions)
alpha = lerp(alpha,0,0.1)
delay = cdTick(delay)
hitdelay = cdTick(hitdelay)

if hitdelay==0{
	hit = false
}

if(life<=0){
	instance_create_layer(x,y-32,layer,obj_explosion)
	instance_destroy()
}

delay = max(delay-1,0)

global.enemyBounceBack = [obj_enemyBounceBack,obj_wallCollision]

if place_meeting(x+xSpd, y, global.enemyBounceBack){
	xSpd *=-1;
	delay = 3;
	spr_flip *= -1;
}

image_xscale = spr_flip

yNxEnemy(global.collisions)

if grounded{
	xSpd = 1.5*image_xscale
}
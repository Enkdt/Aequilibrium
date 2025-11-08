alpha = lerp(alpha,0,0.1)
hitdelay = cdTick(hitdelay)

if hitdelay==0{
	hit = false
}

if(life<=0){
	instance_create_layer(x,y-32,layer,obj_explosion)
	instance_destroy();
}
chase.cooldown = max(chase.cooldown-1,0)
if chase.cooldown ==0 and grounded{
	chase.able = true
}

if chase.able = true and distance_to_object(obj_plr)<= chase.range {
	if !place_meeting(x,y,obj_plr) {
		if x > obj_plr.x{
			xSpd=-1*mv[0]
			spr_flip=1;
		} else if x < obj_plr.x{
			xSpd=1*mv[0]
			spr_flip=-1;
		}
} 
else {
	xSpd = 0
	chase.able = false
	chase.cooldown = 32
	}
}
if grounded and !hit ySpd = 0

if distance_to_object(obj_plr)> chase.range{
	xSpd=0;
}
yNxEnemy(global.collisions)
image_xscale = spr_flip;
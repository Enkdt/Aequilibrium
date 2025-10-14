chase.cooldown = max(chase.cooldown-1,0)
if chase.cooldown ==0{
	chase.able = true
}

if place_meeting(x,y,obj_upwardBoost){
	ySpd -= 1;
}

if place_meeting(x,y,obj_lateralBoost){
	xSpd +=1;
}

if chase.able = true && distance_to_object(obj_plr)<= chase.range {
	if !place_meeting(x,y,obj_plr) {
		if x > obj_plr.x{
			xSpd=-1*mvspeed
			spr_flip=1;
		} else if x < obj_plr.x{
			xSpd=1*mvspeed
			spr_flip=-1;
		}
} 
else {
	xSpd = 0;
	ySpd = 0;
	chase.able = false
	chase.cooldown = 32
	}
}

if distance_to_object(obj_plr)> chase.range{
	xSpd=0;
}
x+=xSpd
y+=ySpd
image_xscale = spr_flip;
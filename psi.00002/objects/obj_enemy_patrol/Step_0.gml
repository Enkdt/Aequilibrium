delay = max(delay-1,0)

if place_meeting(x+xSpd, y, obj_collision){
	if bounce_x == false{
		xSpd = -1.5;
		bounce_x = true;
		delay = 3;
	}else{
		xSpd = 1.5;
		bounce_x = false;	
	}
	spr_flip *= -1;
}

image_xscale = spr_flip
x+=xSpd
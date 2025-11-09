alpha = lerp(alpha,0,0.1)
hitdelay = cdTick(hitdelay)

if place_meeting(x,y,obj_plr) and !immune{
	if !obj_plr.iframe.active{
		obj_plr.hp.count-=1
		obj_plr.iframe.active = true; //tira hp
	}
}

if hitdelay==0{
	hit = false
}

if obj_boss1.bossstart{
	immune = false
}

if obj_boss1.bossdeath{
	instance_destroy()
}

if (!obj_boss1.swipe.active) and obj_boss1.bossstart{
    var posx = 0
	if id == hand_right posx = 2592 else posx = 1632
	var distancia = abs(x-posx)
	var spd = obj_boss1.swipe.spd
	if distancia > spd{
		move_towards_point(posx, y, spd)
		obj_boss1.handisback = false
	} else if distancia > 0 {
		x = posx
		speed = 0
		obj_boss1.handisback = true
	} else {
		speed = 0
		obj_boss1.handisback = true
	}
}

if obj_boss1.current_atk==4{
	switch(move_state){
		case 1:
			ySpd+=0.325
			if(ySpd>=0){
				move_state = 2
				ySpd = 50
			}
			break
		case 2:
			if place_meeting(x,y+ySpd,obj_groundCollision) or y>=target_y{
				ySpd = 0
				move_state = 0
			}
			break
		case 0:
			if !place_meeting(x,y+ySpd,obj_groundCollision){
				ySpd+=0.325
			} else {
				ySpd  = 0
			}
	}
}

y+=ySpd
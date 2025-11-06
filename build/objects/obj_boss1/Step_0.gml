randomise()

var doors = [door_1,door_2]

show_debug_message(activated)
if !activated and !bossdeath{
	y=1600;
}
if activated and !obj_plr.dead{
	for(var i = 0; i < array_length(doors); i++){
		with(doors[i]){
			move_towards_point(x,480,2)
			if 480-y<2{
				y=480
			}
		}
	}
	move_towards_point(x,704,5)
	if y-704<5{
		y=708
		bossstart= true
		activated = false
	}
}

if bossstart or bossdeath{
	if(instance_exists(doors[0])){
		doors[0].y=480
	}
}
var last_atk = 0
if bossstart{
	
	for(var i = 0; i < array_length(doors); i++){
		if instance_exists(doors[i]){
			doors[i].y=480
		}
	}
	
	if life<=0{
		bossdeath=true
		bossstart=false
	}
	
	y=708
	
	cooldown = max(cooldown-1,0)
	swipe.cooldown=max(swipe.cooldown-1,0)
	atk_cooldown = max(atk_cooldown-1,0)

	if current_atk == 0 and atk_cooldown==0{
		current_atk = irandom_range(1,4)
		if current_atk == last_atk{
			current_atk = irandom_range(1,4)
		}
	}

	//Atk 1
	if current_atk<=2 and current_atk!=0 and !swipe.active and handisback and swipe.cooldown==0{
		var hand = choose(hand_l,hand_r)
		var side = 10
		if hand==hand_l side=1 else side=-1
		swipe.spd = swipe.distance/swipe.time
		swipe.duration = swipe.distance
		swipe.dir=point_direction(0,0,side,0)
		swipe.active = true
		swipe.hand = hand
	}

	if swipe.active{
		var hand = swipe.hand
		var sped = swipe.spd
		var dir = swipe.dir
		with(hand){
			x+=lengthdir_x(sped, dir)
			x = clamp(x, 1632, 2592)
		}
		swipe.duration-=swipe.spd
		if swipe.duration<=0{
			swipe.active = false
			with(hand)
				speed = 0
			last_atk = current_atk
			current_atk = 0
			atk_cooldown = 120
			swipe.cooldown = 60
		}
	}

	//atk "bullet hell" 2
	if current_atk==3 and cooldown==0 and reps<10{
		ang+=22.5
		ang2+=12.75
		for (var pattern1 = 0; pattern1 < 8; pattern1++){
		
			var direction_to_shoot = (pattern1 * 45) + ang - ang2
		
			instance_create_layer(x,244 ,"bullets", obj_boss_bullet, { 
				direction : direction_to_shoot,
				speed : 5
				})
		}
		cooldown=30
		reps++
		if reps >= 10{
			current_atk = 0
			atk_cooldown = 120
			last_atk = 3
			reps = 0
		}
	}
	
	if current_atk==4 and !attack_started{
		with(obj_boss1_hand){
			move_state = 1
			ySpd-=20
			target_y = y
		}
		attack_started = true
		cooldown = 1
	}
	
	//cai cai balao cai cai balao
	if current_atk==4 and attack_started and cooldown==0 and reps<15{
		if(obj_boss1_hand.move_state==0){
			layer_set_visible("Effect_1",1)
			var posx = irandom_range(1728,2482)
			instance_create_layer(posx,0,"bullets",obj_boulder)
			cooldown=15
			reps++
		}
		if reps>=15{
			layer_set_visible("Effect_1",0)
			current_atk = 0
			last_atk = 4
			atk_cooldown = 120
			reps = 0
			attack_started = false
		}
	}
}

if bossdeath{
	layer_set_visible("Effect_1",0)
	with(doors[1]){
		move_towards_point(x,224,1)
		if y-224<1{
			y=224
			instance_destroy(doors[1])
		}
	}
	if instance_exists(doors[0]){doors[0].y=480}
	move_towards_point(x,1632,8)
	if 1632-y<10{
		y=1632
	}
}
show_debug_message(bossdeath)

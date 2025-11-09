if place_meeting(x,y,obj_collision_parry){
	id.direction-=180
	hitstop(100)
	obj_plr.parry.work=true
}
if place_meeting(x,y,obj_groundCollision){
	instance_destroy()
}
if place_meeting(x,y,obj_plr){
	if !obj_plr.iframe.active{
		obj_plr.hp.count-=1
		obj_plr.iframe.active = true; //tira hp
	}
		instance_destroy();
}
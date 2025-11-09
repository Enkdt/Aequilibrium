x+=10*spawn_dir //movimentacao
image_xscale=spawn_dir*-1
//colisao 
var collisions = [obj_wallCollision, obj_groundCollision]
var enemies = [obj_enemy_shoot,obj_enemy_follow,obj_enemy_patrol]
var inst_enemy = instance_place(x, y, enemies);

if place_meeting(x,y,obj_plr){
	if !obj_plr.iframe.active{
		obj_plr.hp.count-=1
		obj_plr.iframe.active = true; //tira hp
	}
		instance_destroy();
}

if place_meeting(x,y,obj_collision_parry){
	id.spawn_dir*=-1
	id.reflected=true
	obj_plr.parry.work=true
	hitstop(120)
}

if place_meeting(x,y,collisions){
	instance_destroy();
}

if (inst_enemy != noone) and reflected {
    inst_enemy.life -= 20;
    instance_destroy();
}
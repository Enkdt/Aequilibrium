ySpd+=grav
y+=ySpd
if place_meeting(x,y-32,obj_groundCollision){
	instance_create_layer(x,y-64,layer,obj_explosion)
	instance_destroy()
}
if place_meeting(x,y,obj_plr){
	if !obj_plr.iframe.active{
		obj_plr.hp.count-=1
		obj_plr.iframe.active = true; //tira hp
	}
		instance_destroy();
}
image_angle+=1
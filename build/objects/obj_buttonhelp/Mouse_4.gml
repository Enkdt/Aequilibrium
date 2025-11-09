// Inherit the parent event
event_inherited();

if instance_exists(obj_controls){
	instance_destroy(obj_controls);
}
else{
	instance_create_layer(670, room_height-400, "instances", obj_controls);
}


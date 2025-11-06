if obj_plr.ySpd<0 and timer > 0{
	var vboost = instance_create_layer(860,2385,"Instances",obj_verticalSpecBoost)
	vboost.image_xscale = 4
	vboost.image_yscale = 3
	var hboost = instance_create_layer(860,2350,"Instances",obj_horizontalSpecBoost)
	hboost.image_xscale =15
	hboost.image_yscale =4
	instance_destroy()
}
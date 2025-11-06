
function hitable(){ //does your english not haveth good?
	hit = false
	alpha = 0
	hitdelay = 5
	color = c_white
}

function flash(){
	draw_self()

	if alpha>0{
		gpu_set_fog(true,color,0,0)
		draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,1,0,c_white,alpha)
		gpu_set_fog(false,color,0,0)
	}
}

function knockback(multx, multy, dir){
	xSpd=multx*dir
	ySpd=multy*-1
}	
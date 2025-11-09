function trail(xpxc,ypxc,dpxc,objToTrail,color,alpha){
	with instance_create_depth(x + xpxc,y + ypxc,depth+dpxc,objToTrail){ 
		sprite_index = other.sprite_index;
		image_blend = color;
		image_alpha = alpha;
		image_xscale = other.image_xscale
	}
}

function hitstop(_tempo){ //efeitinho top
	var _tempo_total = current_time + _tempo
	while(current_time<_tempo_total){
		//nao faco nada travei o jogo levei vantage
	}
}
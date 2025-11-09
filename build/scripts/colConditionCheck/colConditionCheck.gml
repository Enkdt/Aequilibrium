function colConditionCheck(xpxc,ypxc,objCollide){
	var condition
	if place_meeting(x+xpxc,y+ypxc,objCollide){
		condition = true
	}
	else{
		condition = false
	}
	return condition
}
function setGrounded(value){
	if value == true
	{
		grounded = true;
		if xSpd == mv[0]{		
			coyote.airedTimer = coyote.airedWalkFrames;
		}else{
			coyote.airedTimer=coyote.airedSptFrames;
		}
	}
	else
	{
		grounded = false;
		coyote.airedTimer = 0;
	}
}
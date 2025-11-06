function yNxEnemy(collisionSet){
	grav = 0.5;
	if ySpd >=0 and place_meeting(x, y+1, global.collisions){
		grounded = true
	} else grounded = false
	if !grounded ySpd += grav;
	var px = 0.5
	if colConditionCheck(xSpd,0,collisionSet){
		if !colConditionCheck(xSpd,-abs(xSpd)-2,collisionSet){
			while colConditionCheck(xSpd,0,collisionSet){
				y -= px
			}
		}
		else{
			collide_horizontal = colConditionCheck(xSpd,0,collisionSet)
			if !colConditionCheck(xSpd,abs(xSpd)+2,collisionSet){
				while colConditionCheck(xSpd,0,collisionSet){
					y += px
				}
			}
			else{
				var pxc = px*sign(xSpd)
				while !colConditionCheck(pxc,0,collisionSet){
					x+=pxc
				}
				xSpd = 0;
			}			
		}
	}
	
	if ySpd >= 0 and !colConditionCheck(xSpd,2,collisionSet) and colConditionCheck(xSpd,abs(xSpd)+2,collisionSet){
		while !colConditionCheck(xSpd,px,collisionSet){
			y += px
		}
	}
	
	if ySpd < 0 and colConditionCheck(0,ySpd,collisionSet){
		//pulando em rampas no teto
		var slopeSlide = false;
		//deslizando pra esquerda
		if !colConditionCheck(-abs(ySpd)-1,ySpd,collisionSet){
			while colConditionCheck(0,ySpd,collisionSet){x-=1;}
			slopeSlide = true
		}
		//deslizando pra direita
		if !colConditionCheck(abs(ySpd)-1,ySpd,collisionSet)
		{
			while colConditionCheck(0,ySpd,collisionSet) {x+=1;}
			slopeSlide = true;
		}
		
		//Colisão normal do Y
		if !slopeSlide
		{
			var pxc = px * sign(ySpd)
			while !colConditionCheck(0,pxc,collisionSet)
			{
				y += pxc
			}
			ySpd = 0;
		}
	}
	if ySpd > 0
	{
		if colConditionCheck(0,ySpd,collisionSet)
		{
			var pxc = px * sign(ySpd)
			while !colConditionCheck(0,pxc,collisionSet)
			{
				y += pxc
			}	
			ySpd = 0;
		}
	}
	x+=xSpd
	y+=ySpd
}
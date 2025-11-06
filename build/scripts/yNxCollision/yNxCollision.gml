function xCollision(collisionSet){
	var px = 0.5
	if colConditionCheck(xSpd,0,collisionSet){
		//Subindo rampas à esquerda
		
		/*Checa alguns pixels acima da parte inferior do player, 
		para que se possa subir na rampa*/
		if !colConditionCheck(xSpd,(-abs(xSpd))*2-2,collisionSet){
		//Mudando os "abs"s, se muda a angulação que ele pode subir
			//Sobe a quantidade de pixels/subpixels que for possível
			while colConditionCheck(xSpd,0,collisionSet){
				y -= px
			}
		}
		//Subindo rampas à direita
		else{
			collide_horizontal = colConditionCheck(xSpd,0,collisionSet)
			if !colConditionCheck(xSpd,(abs(xSpd))*2+2,collisionSet){
				while colConditionCheck(xSpd,0,collisionSet){
					y += px
				}
			}
			else{
				var pxc = px*sign(xSpd)
				while !colConditionCheck(pxc,0,collisionSet){
					x+=pxc
				}
				if colConditionCheck(pxc,0,collisionSet){
					walled = true
				}
				xSpd = 0;
			}			
		}
	}
	else{
		walled = false
	}		
	if ySpd >= 0 and !colConditionCheck(xSpd,2*2,collisionSet) and colConditionCheck(xSpd,(abs(xSpd))*2+2,collisionSet){
		while !colConditionCheck(xSpd,px,collisionSet){
			y += px
		}
	}
}

function yCollision(collisionSet){
	var px = 0.5
	//Colisão do Y quando tá indo pra cima (com rampas no teto)
	if ySpd < 0 and colConditionCheck(0,ySpd,collisionSet){
		//pulando em rampas no teto
		var slopeSlide = false;
		//deslizando pra esquerda
		if xInput == 0 and !colConditionCheck(-abs(ySpd)-1,ySpd,collisionSet){
			while colConditionCheck(0,ySpd,collisionSet){x-=1;}
			slopeSlide = true
		}
		//deslizando pra direita
		if xInput == 0 and !colConditionCheck(abs(ySpd)-1,ySpd,collisionSet)
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
			if ySpd < 0{jumpHoldTimer = 0;}
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
			if ySpd < 0{jumpHoldTimer = 0;}			
			ySpd = 0;
		}
		//you grounded?
		if ySpd >=0 and place_meeting(x, y+1, global.collisions){
			setGrounded(true)
		}
	}
}

	
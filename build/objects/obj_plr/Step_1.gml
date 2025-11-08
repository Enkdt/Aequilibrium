//Sprite control 
mask_index = spr_plr_idle
if iframe.blink{
	image_alpha = 0
}
else{
	image_alpha = 1
}
if !ying{
	//if clibim {sprite_index = spr_plr_clibim}
	if (!atk.active){
		if abs(xSpd) > 0 and _sprintKey {sprite_index = spr_plr_sprint}
		if abs(xSpd) > 0 and !_sprintKey {sprite_index = spr_plr_walk}
		if xSpd == 0 {sprite_index = spr_plr_idle}
		if abs(ySpd) > 0 and !grounded{sprite_index = spr_plr_jump}
		if dash.active {sprite_index = spr_plr_dash}
		if parry.active sprite_index = spr_plr_parry
		if walled and !grounded {sprite_index = spr_plr_walljump}
	}
}
else if ying{
	if abs(xSpd) > 0 {sprite_index = spr_plr_walk}
	if xSpd == 0 {sprite_index = spr_plr_idle}
	if abs(ySpd) > 0 and !grounded{sprite_index = spr_plr_jump}
	if dash.active {sprite_index = spr_plr_dash}
	if walled and !grounded {sprite_index = spr_plr_walljump}
}
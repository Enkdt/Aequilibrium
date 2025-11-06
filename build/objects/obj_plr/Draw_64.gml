var hbWidth = 202
var hbHeight = 68
var hbX = 64
var hbY = 64
if room !=Menu_ass and room !=Room8{
	draw_sprite_stretched(spr_healthbarFill,0,hbX,hbY,hp.count/hp.mx * hbWidth,hbHeight)
	draw_sprite(spr_healthbarEmpty,0,hbX,hbY);
}
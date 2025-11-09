//Alocação dinâmica de altura e largura
height = margin*2 + optLen*lineHeight
var newWidth = 0;
for(var i = 0; i<optLen;++i){
	var curWidth = string_width(">"+opt[i])
	newWidth = max(curWidth,newWidth);
}
width = newWidth + margin*2;

//Centralização da Caixa
x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])/2 - width/2
y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])/2 - height/2

draw_text(x,y-50,"Game Over")
//Desenha a caixa, parte de trás do sprite
draw_sprite_ext(sprite_index,image_index,x,y,width/sprite_width,height/sprite_height,0,c_white,1)

//Seta a fonte e alinhamento de tal
draw_set_font(global.font1);
draw_set_valign(fa_top);
draw_set_halign(fa_left);

//Desenha as opções na tela e faz o efeito de hover
for(var i = 0; i<optLen;++i){
	var color = c_white
	if hover == i{
		color = c_yellow
		draw_text_color(x+margin,y+margin+i*lineHeight,">"+opt[i],color,color,color,color,1)
	}
	else{
		draw_text_color(x+margin,y+margin+i*lineHeight,opt[i],color,color,color,color,1)
	}
}
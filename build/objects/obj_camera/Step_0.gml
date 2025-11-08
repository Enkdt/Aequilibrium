

//exit if there's no player
if !instance_exists(obj_plr) exit;

//Pega o tamanho da câmera
var _camwidth = camera_get_view_width(view_camera[0])
var _camheight = camera_get_view_height(view_camera[0])

//Pega as coordenadas do player
var _camX = obj_plr.x - _camwidth/2;
var _camY = obj_plr.y - _camheight/2;

//Deixa a câmera nas bordas da room
_camX = clamp( _camX, 0, room_width - _camwidth)
_camY = clamp( _camY, 0, room_height - _camheight)

//Define as vars das coord da Cam
finalcamX += (_camX - finalcamX) * camTrail;
finalcamY += (_camY - finalcamY) * camTrail;

//Define as coordenadas da câmera
camera_set_view_pos(view_camera[0], finalcamX, finalcamY)
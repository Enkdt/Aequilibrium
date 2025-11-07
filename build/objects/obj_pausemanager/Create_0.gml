paused = false;
layer_name = "PauseLayer";

update_pause = function()
{
	if(paused)
	{
		layer_set_visible(layer_name, true)
	}
	else{
		layer_set_visible(layer_name, false);
	}
}
update_pause();
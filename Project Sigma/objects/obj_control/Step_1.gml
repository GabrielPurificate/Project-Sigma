/// @description Insert description here
if (velocidadeHorizontal != 0)
{
	image_xscale = sign(velocidadeHorizontal);
}

if(position_meeting(mouse_x, mouse_y, id))
{
	if(mouse_check_button_pressed(mb_right))
	{
		showDebug = !showDebug;
	}
}
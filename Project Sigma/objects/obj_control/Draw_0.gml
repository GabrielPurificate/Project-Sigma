/// @description Insert description here
draw_self();

#region debugs
	if (showDebug == true) 
	{
		draw_set_valign(1);
		draw_set_halign(1);
		
		draw_text(x, y - sprite_height * 1.5, state);
		
		draw_set_valign(-1);
		draw_set_halign(-1);
	}
#endregion
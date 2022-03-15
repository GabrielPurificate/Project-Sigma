draw_self();

#region debugs
	if (showDebug == 1) 
	{
		draw_set_valign(1);
		draw_set_halign(1);
		
		draw_text(x, y - sprite_height * 1.5, playerState);
		
		draw_set_valign(-1);
		draw_set_halign(-1);
	}
#endregion
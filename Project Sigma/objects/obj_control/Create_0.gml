#region declarações
	velocidade = 5;
	velocidadeHorizontal = 0;
	velocidadeVertical = 0;
	gravidade = 0.25;
	massa = 1;
	ataque = 1;
	state = "idle";
	
	showDebug = false;
#endregion

if (!layer_sequence_exists("Assets", sq_logo) and room == rm_logo)
{
    layer_sequence_create("Assets", room_width / 2, room_height / 2, sq_logo);
    audio_play_sound(snd_Splashscreen, 1, false);
}
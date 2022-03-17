//Herdando o código do create do pai (obj_control)
event_inherited();

//imageSpeed = 55 / room_speed;

showDebug = 1;

//Pode usar ataque em sequencia
combo = 0;

#region declaraçõesPlayer
	//Definindo o estado do player
	playerState = "idle";

	//Movimento
	gravidade = 0.2;
	pulo = 6;
#endregion
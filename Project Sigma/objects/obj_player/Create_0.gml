//Herdando o código do create do pai (obj_control)
event_inherited();

velocidade = 3.5;

//imageSpeed = 55 / room_speed;

showDebug = 1;

//Pode usar ataque em sequencia
combo = 0;

#region declaraçõesPlayer
	//Vida
	vidaMax = 3;
	vidaAtual = vidaMax;
	//Definindo o estado do player
	playerState = "idle";

	//Movimento
	massa = 1;
	pulo = 6;
#endregion
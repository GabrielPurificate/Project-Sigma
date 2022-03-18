//Herdando o código do create do pai (obj_control)
event_inherited();

velocidade = 3.5;

//imageSpeed = 55 / room_speed;

//Pode usar ataque em sequencia
combo = 0;
comboMulti = 1;

#region declaraçõesPlayer
	//Vida
	vidaMax = 3;
	vidaAtual = vidaMax;
	hit = noone;
	possoAtacar = true;

	//Movimento
	massa = 1.1;
	pulo = 6;
#endregion
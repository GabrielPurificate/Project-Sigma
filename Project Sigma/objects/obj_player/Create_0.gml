//Herdando o código do create do pai (obj_control)
randomize();
event_inherited();

velocidade = 2.5;

//Pode usar ataque em sequencia
combo = 0;
comboMulti = 1;

//Margem de cada coração
margX = 36;

//Desenhar a vida na tela
function desenharVida(_margX)
{
	for(var i = 0; i < global.vidaAtual; i++)
	{
		draw_sprite_ext(spr_coracao, 0, 20 + (i * _margX), 20, 1, 1, 0, c_white, 1);
	}
}

#region declaraçõesPlayer
	//Vida
	vidaMax = 3;
	vidaAtual = vidaMax;
	hit = noone;
	possoAtacar = true;
	possoUsarSFX = true;

	//Movimento
	massa = 1.1;
	pulo = 6;
#endregion
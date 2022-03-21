event_inherited();

vidaMax = 12;
vidaAtual = vidaMax;

velocidade = 2;
massa = 1.2;

timerEstado = 0;
dist = 40;
hit = noone;
ataque = 1;
possoAtacar = true;

function attackPlayerMelee(_outro)
{
	if(playerDistance < 50 and _outro.state != "death" and possoAtacar == true)
	{
		state = "attack";
	}
}
event_inherited();

vidaMax = 18;
vidaAtual = vidaMax;

velocidade = 2;
massa = 1.2;

timerEstado = 0;
dist = 40;
hit = noone;
ataque = 1;
possoAtacar = true;
possoUsarSFX = true;

function attackPlayerMelee(_dist, _xscale, _outro)
{
	var _attackPlayer = collision_line(x, y - sprite_height / 2, x + (_dist * _xscale), y - sprite_height / 2, _outro, false, true);
	if(_attackPlayer and _outro.state != "death")
	{
		state = "attack";
	}
}
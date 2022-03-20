event_inherited();

vidaMax = 1;
vidaAtual = vidaMax;

velocidade = 1.5;
massa = 1.5;

timerEstado = 0;
dist = 40;
hit = noone;
ataque = 1;
possoAtacar = true;
possoUsarSFX = true;


taunt_timer = room_speed * 5;

function attackPlayerMelee(_dist, _xscale, _outro)
{
	var _attackPlayer = collision_line(x, y - sprite_height / 4, x + (_dist * _xscale), y - sprite_height / 2, _outro, false, true);
	if(_attackPlayer and _outro.state != "death")
	{
		state = "attack";
	}
}
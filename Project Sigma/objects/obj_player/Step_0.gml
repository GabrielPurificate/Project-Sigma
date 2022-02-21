//Movimento
var _jump, _jump_r, _right, _left, _velH, _chao;

_chao = place_meeting(x, y + 1, obj_block);

_right = keyboard_check(ord("D"));
_left = keyboard_check(ord("A"));
_jump = keyboard_check_pressed(vk_space);
_jump_r = keyboard_check_released(vk_space);

_velH = (_right - _left) * velocidade;

velocidadeHorizontal = lerp(velocidadeHorizontal, _velH, 0.1);

//Aplicar a gravidade
if(!_chao)
{
	velocidadeVertical += gravidade;
	//Controlar a altura do pulo
	if(_jump_r and velocidadeVertical < 0)//Soltar o botão de pulo
	{
		velocidadeVertical *= 0.5;
	}
}

//Pular
if(_chao and _jump)
{
	velocidadeVertical -= pulo;
}

//Checar se está no chao
if(_chao and _velH == 0)
{
	playerState = "idle";
}

if(_chao and _velH != 0)
{
	playerState = "run";
}

switch playerState
{
	case "idle":
		sprite_index = spr_player_idle;
		break;
	case "jump":
		sprite_index = spr_player_jump;
		break;
	case "fall":
		sprite_index = spr_player_fall;
		break;
	case "run":
		sprite_index = spr_player_run;
		break;
}
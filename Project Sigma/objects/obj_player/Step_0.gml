//Movimento
var _jump, _jump_r, _right, _left, _velH, _chao;

_chao = place_meeting(x, y + 1, obj_block);

_right = keyboard_check(ord("D"));
_left = keyboard_check(ord("A"));
_jump = keyboard_check_pressed(vk_space);
_jump_r = keyboard_check_released(vk_space);

_velH = (_right - _left) * velocidade;

velocidadeHorizontal = lerp(velocidadeHorizontal, _velH, 0.1);
show_debug_message(velocidadeVertical);
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

switch playerState
{
	case "idle":
		sprite_index = spr_player_idle;
		if (_right or _left)
		{
			playerState = "run";
		}
		if(velocidadeVertical != 0)
		{
			playerState = "jump";
		}
		break;
	case "run":
		sprite_index = spr_player_run;
		if (!_right and !_left)
		{
			playerState = "idle";
		}
		if(velocidadeVertical != 0)
		{
			playerState = "jump";
		}
		break;
	case "jump":
		//Caindo
		if(velocidadeVertical > 0)
		{
			sprite_index = spr_player_fall;
		}else
		{
			sprite_index = spr_player_jump;
			//Não deve repetir a sprite de iniciar o pulo
			if(image_index >= image_number)
			{
				image_index = image_number - 1;
			}
		}
		//Trocar de estado
		if(_chao)
		{
			playerState = "idle";
		}
		break;
}
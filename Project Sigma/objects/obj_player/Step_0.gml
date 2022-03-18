//Definir Variaveis
var _jump, _jump_r, _attack, _right, _left, _velH, _chao;

_chao = place_meeting(x, y + 1, obj_block);

_right = keyboard_check(ord("D"));
_left = keyboard_check(ord("A"));
_jump = keyboard_check_pressed(vk_space);
_jump_r = keyboard_check_released(vk_space);
_attack = keyboard_check_pressed(ord("J")) or mouse_check_button_pressed(mb_left);

_velH = (_right - _left) * velocidade;

velocidadeHorizontal = lerp(velocidadeHorizontal, _velH, 0.1);

//Aplicar a gravidade
if(!_chao)
{
	velocidadeVertical += gravidade * massa;
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

//Cair do céu se cair pra fora da room
if(y > room_height)
{
	room_restart();
}
switch state
{
	case "idle":
		sprite_index = spr_player_idle;
		
		if (_right and !_left or !_right and _left)
		{
			state = "run";
		}
		else if(_jump or sign(velocidadeVertical) != 0)
		{
			state = "jump";
			image_index = 0;
		}
		else if (_attack)
		{
			state = "attack";
			image_index = 0;
		}
		break;
		
	case "run":
		sprite_index = spr_player_run;
		
		if (!_right and !_left or _right and _left)
		{
			state = "idle";
		}
		else if(_jump or sign(velocidadeVertical) != 0)
		{
			state = "jump";
			image_index = 0;
		}
		else if (_attack)
		{
			state = "attack";
			image_index = 0;
		}
		break;
		
	case "jump":
		//Caindo
		if(velocidadeVertical > 0)
		{
			sprite_index = spr_player_fall;
			if(place_meeting(x, y - 2, obj_block))
			{
				sprite_index = spr_player_touch_fall;
			}
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
			state = "idle";
		}
		break;
		
	case "attack":
		//Parar para bater
		velocidadeHorizontal = 0;
		
		//Animação de bater
		if(combo == 0)
		{
			sprite_index = spr_player_attack_1;
		}
		else if(combo == 1)
		{
			sprite_index = spr_player_attack_2;
		}
		else if(combo == 2)
		{
			sprite_index = spr_player_attack_3;
		}
		
		//Criar o objeto de dano
		if(image_index >= 2 and hit == noone and possoAtacar == true)
		{
			hit = instance_create_layer(x + sprite_width / 3, y - sprite_height / 2, layer, obj_hit);
			hit.dano = ataque * comboMulti;
			hit.pai = id;
			possoAtacar = false;
		}
		
		//Testar para saber se tem um proximo ataque em sequencia para uso
		if(_attack and combo < 2 and image_index >= image_number -3)
		{
			combo++;
			image_index = 0;
			possoAtacar = true;
			comboMulti ++;
			if(hit)
			{
				instance_destroy(hit, false);
				hit = noone;
			}
		}
		
		//Resetar a sequencia se ela já tiver terminado
		if(combo > 2)
		{
			combo = 0;
		}
		
		//Retornar ao idle
		if(image_index > image_number - 1)
		{
			state = "idle";
			combo = 0;
			possoAtacar = true;
			comboMulti = 1;
			if(hit)
			{
				instance_destroy(hit, false);
				hit = noone;
			}
		}
		break;
}
//Definir variaveis
var _chao;

_chao = place_meeting(x, y + 1, obj_block);

//Cair se cair pra fora da room se destruir
if(y > room_height)
{
	instance_destroy(self, false);
}

//Aplicar a gravidade
if(!_chao)
{
	velocidadeVertical += gravidade * massa;
}

switch(state)
{
	case "idle":
		velocidadeHorizontal = 0;
		timerEstado++;
		if(sprite_index != spr_boss_idle)
		{
			sprite_index = spr_boss_idle;
			image_index = 0;
		}
		
		//trocar de estados
		if(instance_exists(obj_player))
		{
			var _dist = point_distance(x, y, obj_player.x, obj_player.y);
			if(_dist < 300 and obj_player.state != "death")
			{
				state = "run";
			}
		}
		break;
	
	case "run":
		timerEstado++;
		if(sprite_index != spr_boss_run)
		{
			sprite_index = spr_boss_run;
			image_index = 0;
		}
		
		//trocar de estados
		if(instance_exists(obj_player))
		{
			var _dist = point_distance(x, y, obj_player.x, obj_player.y);
			var _dir = point_direction(x, y, obj_player.x, obj_player.y);
			
			if(_dist > 40)
			{
				velocidadeHorizontal = lengthdir_x(velocidade, _dir);
			}else if(_dist <= 40 and obj_player.state != "death")
			{
				velocidadeHorizontal = 0;
				state = "attack";
				//Substate
				ataques = irandom(2);
			}
		}
		break;
	
	case "attack":
		velocidadeHorizontal = 0;
		switch (ataques)
		{
			#region ataque_1
			case 0:
				if(sprite_index != spr_boss_attack_1)
				{
					sprite_index = spr_boss_attack_1;
					image_index = 0;
					possoAtacar = true;
					possoUsarSFX = true;
				}
		
				//Criar o objeto de dano
				if(image_index >= 1 and hit == noone and possoAtacar)
				{
					hit = instance_create_layer(x + sprite_width / 2.5, y - sprite_height / 3, layer, obj_hit);
					hit.dano = ataque;
					hit.pai = id;
					hit.image_xscale = 1.5;
					hit.image_yscale = 1.5;
					possoAtacar = false;
					if(possoUsarSFX == true)
					{
						audio_play_sound(snd_enemy1_attack, 2, false);
						possoUsarSFX = false;
					}
				}
		
				if(image_index > image_number - 1)
				{
					state = "taunt";
					if(hit != noone)
					{
						instance_destroy(hit, false);
						hit = noone;
					}
				}
				break;
				#endregion
				
			#region ataque_2
			case 1:
				if(sprite_index != spr_boss_attack_2)
				{
					sprite_index = spr_boss_attack_2;
					image_index = 0;
					possoAtacar = true;
					possoUsarSFX = true;
				}
		
				//Criar o objeto de dano
				if(image_index >= 1 and hit == noone and possoAtacar)
				{
					hit = instance_create_layer(x + sprite_width / 3, y - sprite_height / 3, layer, obj_hit);
					hit.dano = ataque;
					hit.pai = id;
					hit.image_xscale = 1;
					hit.image_yscale = 1;
					possoAtacar = false;
					if(possoUsarSFX == true)
					{
						audio_play_sound(snd_enemy1_attack, 2, false);
						possoUsarSFX = false;
					}
				}
		
				if(image_index > 3)
				{
					state = "taunt";
					if(hit != noone)
					{
						instance_destroy(hit, false);
						hit = noone;
					}
				}
				break;
				#endregion
				
			#region ataque_3
			case 2:
				if(sprite_index != spr_boss_attack_3)
				{
					sprite_index = spr_boss_attack_3;
					image_index = 0;
					possoAtacar = true;
					possoUsarSFX = true;
				}
		
				//Criar o objeto de dano
				if(image_index >= 4 and hit == noone and possoAtacar)
				{
					hit = instance_create_layer(x, y, layer, obj_hit);
					hit.dano = ataque;
					hit.pai = id;
					hit.image_xscale = 2;
					hit.image_yscale = 0.6;
					possoAtacar = false;
					if(possoUsarSFX == true)
					{
						audio_play_sound(snd_enemy1_attack, 2, false);
						possoUsarSFX = false;
					}
				}
		
				if(image_index > 7)
				{
					state = "taunt";
					if(hit != noone)
					{
						instance_destroy(hit, false);
						hit = noone;
					}
				}
				break;
				#endregion
		}
		break;
	
	case "hit":
		velocidadeHorizontal = 0;
		if (sprite_index != spr_boss_hit)
		{
			sprite_index = spr_boss_hit;
			image_index = 0;
		}
				
		//Trocar de estado
		if(image_index > image_number - 1)
		{
			//Checar se ainda tem vida
			if(vidaAtual > 0)
			{
				state = "idle";
			}
			else if(vidaAtual <= 0)
			{
				state = "death"
			}
		}
	break;
	
	case "taunt":
		velocidadeHorizontal = 0;
		if (sprite_index != spr_boss_taunt)
		{
			sprite_index = spr_boss_taunt;
			image_index = 0;
		}
		
		//Condição pra sair do estado
		taunt_timer--;
		if(taunt_timer <= 0)
		{
			taunt_timer = room_speed * 5;
			state = "idle";
		}
		break;
		
	case "death":
		velocidadeHorizontal = 0;
		if (sprite_index != spr_boss_death)
		{
			image_index = 0;
		}
		
		sprite_index = spr_boss_death;
		
		//Morrendo
		if(image_index > image_number - 1)
		{
			image_speed = 0;
			image_alpha -= 0.05;
			if(image_alpha <= 0)
			{
				instance_destroy();
			}
			//Adicionar screenshake
			obj_control.screenShake(15);
		}
		break;
}
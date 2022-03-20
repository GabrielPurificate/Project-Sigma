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
		if(sprite_index != spr_enemy1_idle)
		{
			image_index = 0;
		}
		
		sprite_index = spr_enemy1_idle;
		
		//trocar de estados
		if(irandom(timerEstado > 200))
		{
			state = choose("run", "idle", "run");
			timerEstado = 0;
		}
		attackPlayerMelee(dist, image_xscale, obj_player);
		break;
	
	case "run":
		timerEstado++;
		if(sprite_index != spr_enemy1_run)
		{
			image_index = 0;
			velocidadeHorizontal = choose(velocidade, -velocidade);
		}
		
		sprite_index = spr_enemy1_run;
		
		//Se não tiver chão na frente trocar de direção
		if(!place_meeting(x + sign(velocidadeHorizontal), y, obj_block) and !place_meeting(x + sign(velocidadeHorizontal), y + 1, obj_block) and !place_meeting(x + sign(velocidadeHorizontal), y + 2, obj_block))
		{
			velocidadeHorizontal *= -1;
		}
		
		//trocar de estados
		if(irandom(timerEstado > 200))
		{
			state = choose("idle", "run", "idle");
			timerEstado = 0;
		}
		attackPlayerMelee(dist, image_xscale, obj_player);
		break;
	
	case "attack":
		velocidadeHorizontal = 0;
		if(sprite_index != spr_enemy1_attack)
		{
			image_index = 0;
			possoAtacar = true;
			possoUsarSFX = true;
		}
		
		sprite_index = spr_enemy1_attack;
		
		//Criar o objeto de dano
		if(image_index >= 6 and hit == noone and possoAtacar)
		{
			hit = instance_create_layer(x + sprite_width / 3, y - sprite_height / 3, layer, obj_hit);
			hit.dano = ataque;
			hit.pai = id;
			possoAtacar = false;
			if(possoUsarSFX == true)
			{
				audio_play_sound(snd_enemy1_attack, 2, false);
				possoUsarSFX = false;
			}
		}
		
		if(image_index > image_number - 1)
		{
			state = "idle";
			if(hit != noone)
			{
				instance_destroy(hit, false);
				hit = noone;
			}
		}
		break;
	
	case "hit":
		velocidadeHorizontal = 0;
		if (sprite_index != spr_enemy1_hit)
		{
			image_index = 0;
		}
		
		sprite_index = spr_enemy1_hit;
				
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
		
	case "death":
		velocidadeHorizontal = 0;
		if (sprite_index != spr_enemy1_death)
		{
			image_index = 0;
		}
		
		sprite_index = spr_enemy1_death;
		
		//Morrendo
		if(image_index > image_number - 1)
		{
			image_speed = 0;
			image_alpha -= 0.05;
			if(image_alpha <= 0)
			{
				instance_destroy();
			}
		}
		break;
}
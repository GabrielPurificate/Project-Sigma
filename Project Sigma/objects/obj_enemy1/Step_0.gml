event_inherited();

if(instance_exists(obj_player))
{
	playerDirection = point_direction(x, y, obj_player.x, obj_player.y);
	playerDistance = point_distance(x, y, obj_player.x, obj_player.y);
}


switch(state)
{
	case "idle":
	{
		velocidadeHorizontal = 0;
		if(sprite_index != spr_enemy1_idle)
		{
			sprite_index = spr_enemy1_idle;
			image_index = 0;
		}
		
		//trocar de estados
		if(playerDistance < 150)
		{
			state = "run";
		}
		if(instance_exists(obj_player))
		{
			attackPlayerMelee(obj_player);
		}
		break;
	}
	
	case "run":
	{
		if(sprite_index != spr_enemy1_run)
		{
			sprite_index = spr_enemy1_run;
			image_index = 0;
		}
		
		if(playerDistance > 30)
		{
			velocidadeHorizontal = lengthdir_x(velocidade, playerDirection);
		}
		if(playerDistance >= 150)
		{
			state = "idle";
		}

		//Se não tiver chão na frente ou bater em uma parede deve trocar de direção
		if(!place_meeting(x + sprite_width / 2 * sign(velocidadeHorizontal), y, obj_block) and !place_meeting(x + sprite_width / 2 * sign(velocidadeHorizontal), y + 1, obj_block))
		{
			velocidadeHorizontal *= -1;
		}
		
		/*if(place_meeting(x + sign(velocidadeHorizontal), y, obj_block) and place_meeting(x + sign(velocidadeHorizontal), y - 1, obj_block))
		{
			velocidadeHorizontal = -1;
		}*/
		
		//trocar de estados
		if(instance_exists(obj_player))
		{
			attackPlayerMelee(obj_player);
		}
		break;
	}
	
	case "attack":
	{
		velocidadeHorizontal = 0;
		if(sprite_index != spr_enemy1_attack)
		{
			sprite_index = spr_enemy1_attack;
			image_index = 0;
		}
		
		//Criar o objeto de dano
		if(image_index >= 6 and hit == noone and possoAtacar == true)
		{
			hit = instance_create_layer(x + sprite_width / 3, y - sprite_height / 3, layer, obj_hit);
			hit.dano = ataque;
			hit.pai = id;
			audio_play_sound(snd_enemy1_attack, 2, false);
			alarm[0] = room_speed * 2;
			possoAtacar = false;
		}
		
		if(image_index >= 7 and hit != noone)
		{
			instance_destroy(hit, false);
			hit = noone;
		}
		
		if(image_index >= image_number - 1)
		{
			state = "idle";
			if(hit != noone)
			{
				instance_destroy(hit, false);
				hit = noone;
			}
		}
		break;
	}
	
	case "hit":
	{
		velocidadeHorizontal = 0;
		if (sprite_index != spr_enemy1_hit)
		{
			sprite_index = spr_enemy1_hit;
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
	}
		
	case "death":
	{
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
	default:
	{
		state = "idle";
		break;
	}
}
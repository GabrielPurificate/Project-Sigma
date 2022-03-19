//Definir variaveis
var _chao;

_chao = place_meeting(x, y + 1, obj_block);

//Cair se cair pra fora da room se destruir
if(y > room_height)
{
	instance_destroy(self, false);
}

var _attackPlayer = collision_line(x, y - sprite_height / 2, x + (dist * image_xscale), y - sprite_height / 2, obj_player, 0, 1);

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
		}else if(_attackPlayer) //Se o player está na visão atacar
		{
			state = "attack";
		}
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
		}else if(_attackPlayer) //Se o player está na visão atacar
		{
			state = "attack";
		}
		break;
	
	case "attack":
		velocidadeHorizontal = 0;
		if(sprite_index != spr_enemy1_attack)
		{
			image_index = 0;
		}
		
		sprite_index = spr_enemy1_attack;
		
		/*Criar o objeto de dano
		if(image_index >= image_number - 3 and hit == noone)
		{
			hit = instance_create_layer(x + sprite_width / 3, y - sprite_height / 2, layer, obj_hit);
			hit.dano = ataque;
			hit.pai = id;
		}*/
		
		if(image_index > image_index - 1)
		{
			state = "idle";
		}
		break;
	
	case "hit":
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
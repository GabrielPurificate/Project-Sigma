//Definir variaveis
var _chao;

_chao = place_meeting(x, y + 1, obj_block);

//Aplicar a gravidade
if(!_chao)
{
	velocidadeVertical += gravidade * massa;
}

switch(state)
{
	case "idle":
		if(sprite_index != spr_enemy1_idle)
		{
			image_index = 0;
		}
		
		sprite_index = spr_enemy1_idle;
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
//Definir variaveis
var _chao;

_chao = place_meeting(x, y + 1, obj_block);

//Aplicar a gravidade
if(!_chao)
{
	velocidadeVertical += gravidade * massa;
}

if(position_meeting(mouse_x, mouse_y, obj_enemy1))
{
	if(mouse_check_button(mb_right))
	{
		velocidadeVertical = 0;
		x = mouse_x;
		y = mouse_y;
	}
}

if(keyboard_check(ord("K")))
{
	sprite_index = spr_enemy1_attack;
}
else if(keyboard_check(ord("L")))
{
	sprite_index = spr_enemy1_hit;
}
else if(keyboard_check(ord("I")))
{
	sprite_index = spr_enemy1_run;
}
else if(keyboard_check(ord("O")))
{
	sprite_index = spr_enemy1_death;
}
else
{
	sprite_index = spr_enemy1_idle;
}
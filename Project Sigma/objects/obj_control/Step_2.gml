/// @description Insert description here

repeat(abs(velocidadeHorizontal))
{
	//Subir a rampa
	//Se do meu lado eu vou colidir e 1 pixel acima eu não vou colidir do mesmo lado então y vai ganhar -1(vai subir 1 pixel)
	if(place_meeting(x + sign(velocidadeHorizontal), y, obj_block) and !place_meeting(x + sign(velocidadeHorizontal), y - 1, obj_block))
	{
		y --;
	}
	//Descer a rampa
	//Checando se abaixo de mim eu estou colidindo e se eu descer 1 posição na rampa eu não colidir e descer 2 eu colidir então y ganha +1(vai descer 1 pixel);
	if(!place_meeting(x + sign(velocidadeHorizontal), y, obj_block) and !place_meeting(x + sign(velocidadeHorizontal), y + 1, obj_block) and place_meeting(x + sign(velocidadeHorizontal), y + 2, obj_block))
	{
		y++;
	}
	
	//Colisão horizontal
	if(!place_meeting(x + sign(velocidadeHorizontal), y, obj_block))
	{
		x += sign(velocidadeHorizontal);
	}else
	{
		velocidadeHorizontal = 0;
		break;
	}
}

repeat(abs(velocidadeVertical))
{
	//Colisão vertical
	if(!place_meeting(x, y + sign(velocidadeVertical), obj_block))
	{
		y += sign(velocidadeVertical);
	}else
	{
		velocidadeVertical = 0;
		break;
	}
}
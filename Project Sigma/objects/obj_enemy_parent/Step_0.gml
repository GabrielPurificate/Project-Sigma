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
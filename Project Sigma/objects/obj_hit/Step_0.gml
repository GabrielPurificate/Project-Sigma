var _outro = instance_place(x, y, obj_control);
var _outroLista = ds_list_create();
var _qtd = instance_place_list(x, y, obj_control, _outroLista, 0);

//Adicionar todos que eu toquei na lista de dar dano
for(var i = 0; i < _qtd; i++)
{
	var _atual = _outroLista[| i];
	
	//Checar se estou colidindo com um filho do meu pai
	if(object_get_parent(_atual.object_index) != object_get_parent(pai.object_index))
	{
		//Só vai rodar se puder bater em um inimigo
		
		//Checar se realmente posso dar dano
		
		//Checar se o _atual esta na lista aplicarDano
		var _pos = ds_list_find_index(aplicarDano, _atual);
		
		if(_pos == -1)
		{
			//Se o atual não está na lista de dano adicionar ele
			ds_list_add(aplicarDano, _atual);
		}
	}
}

//Aplicar o dano
var _tam = ds_list_size(aplicarDano);
for (var i = 0; i < _tam; i++)
{
	_outro = aplicarDano[| i].id;
	if(_outro.id != pai and _outro.vidaAtual > 0)
	{
		if(obj_player.id == _outro.id)
		{
			obj_player.state = "hit";
			global.vidaAtual--;
		}else
		{
			_outro.state = "hit";
			_outro.vidaAtual -= dano;
		}
		image_index = 0;
		
		if(object_get_parent(_outro.object_index) == obj_enemy_parent)
		{
			obj_control.screenShake(2);
		}
	}
}

//Destruir as listas
ds_list_destroy(aplicarDano);
ds_list_destroy(_outroLista);
instance_destroy();
/*
//Se eu estou tocando em alguem
if(_outro)
{
	//Checar se os pais são iguais
	var _pai = object_get_parent(_outro.object_index);
	if(_pai != object_get_parent(pai.object_index))
	{
		if(_outro.id != pai and _outro.vidaAtual > 0)
		{
			_outro.state = "hit";
			_outro.vidaAtual -= dano;
			image_index = 0;
			instance_destroy();
		}
	}
}
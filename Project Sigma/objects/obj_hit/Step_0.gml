var _outro;

_outro = instance_place(x, y, obj_control);

//Se eu estou tocando em alguem
if(_outro)
{
	if(_outro.id != pai and _outro.vidaAtual > 0)
	{
		_outro.state = "hit";
		_outro.vidaAtual -= dano;
		instance_destroy();
	}
}
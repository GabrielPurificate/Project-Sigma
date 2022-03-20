/// @description Insert description here

//Criando o menu
menu = ["Iniciar", "Opções", "Sair"];

//Seleção de menu
sel = 0;
margVal = 32;
margValTotal = 32;

//Controlar a página do menu
pag = 0;

if(room == rm_menu)
{
	if(audio_is_playing(snd_menu) == false)
	{
		audio_stop_all();
		audio_play_sound(snd_menu, 1, true);
	}
}

enum menuAcoes
{
	rodaMetodo,
	carregaMenu,
	ajustesMenu
}

enum menuLista
{
	principal,
	opcoes,
	tela
}


#region métodos
	function defineAlign(_ver, _hor)
	{
		draw_set_valign(_ver);
		draw_set_halign(_hor);
	}
	
	//Pegar o valor da animation Curve
	function animCurve(_anim, _animar = false, _channel = 0)
	{
		static _pos = 0;
		static _val = 0;
		
		//Aumentar o valor do _pos
		//Em 1 segundo ir de 0 até 1
		_pos += delta_time / 1000000;
		
		if(_animar)
		{
			_pos = 0;
		}
		
		//Pegando o valor do canal
		var _canal = animcurve_get_channel(_anim, _channel);
		_val = animcurve_channel_evaluate(_canal, _pos);

		return _val;
	}
	
	function desenharMenu(_menu, _verAlign, _horAlign, _margVal)
	{
		//Definindo a fonte
		draw_set_font(fnt_menu);

		//Alinhar o texto
		defineAlign(_verAlign, _horAlign);

		//Desenhando o menu
		//Pegar o tamanho do menu
		var _qtd = array_length(_menu);

		//Pegar a altura da tela
		var _alt = display_get_gui_height();
		
		//Pegar a largura da tela
		var _larg = display_get_gui_width();

		//Definir o tamanho do espaçamento do eixo y
		var _espaco_y = string_height("I") + 5;
		var _alt_menu = (_espaco_y * _qtd);

		//Desenhar as opções
		for(var i = 0; i < _qtd; i++)
		{
			//Definir a cor
			var _cor = c_white;
			var _marg_x = 0;
	
			//Desenhar o item do menu
			var _texto = _menu[i][0];
	
			//Permitindo a seleção
			if(menus_sel[pag] == i)
			{
				_cor = c_fuchsia;
				_marg_x = _margVal;
			}
	
			draw_text_color(20 + _marg_x, (_alt / 2) + (_alt_menu / 2) + (i * _espaco_y), _texto, _cor, _cor, _cor, _cor, 1);
		}
		
		//Desenhar o outro lado do menu caso for um menu de ajustes
		for(var i = 0; i < _qtd; i++)
		{
			//Checar se eu preciso desenhar as opções
			switch(_menu[i][1])
			{
				case menuAcoes.ajustesMenu:
					//Desenhar as opções do lado direito
					//Salvar os indices que eu estou
					var _indice = _menu[i][3];
					var _txt	= _menu[i][4][_indice];
					
					//Só pode ir para a esquerda se o indice for > 0
					var _esq	= _indice > 0 ? "<< " : "";
					
					//Só pode ir para a esquerda se o indice for < fim do vetor
					var _dir	= _indice < array_length(_menu[i][4]) - 1 ? " >>" : "";
					
					var _cor = c_white;
					
					//Se eu estiver mexendo nessa opção devo trocar de cor
					if(alterando and menus_sel[pag] == i)
					{
						_cor = c_red;
					}
					
					draw_text_color(_larg / 2, (_alt / 2) + (_alt_menu / 2) + (i * _espaco_y), _esq + _txt + _dir, _cor, _cor, _cor, _cor, 1);
					break;
			}
		}

		//Resetar
		draw_set_font(-1);
		defineAlign(-1, -1);
	}
	
	function controlarMenu(_menu)
	{
		static _animar = false;
		
		var _sel = menus_sel[pag];
		
		//Pegar as teclas
		var _up, _down, _avancar, _recuar, _left, _right;
		_up = keyboard_check_pressed(vk_up);
		_down = keyboard_check_pressed(vk_down);
		_left = keyboard_check_pressed(vk_left);
		_right = keyboard_check_pressed(vk_right);
		_avancar = keyboard_check_released(vk_enter);
		_recuar = keyboard_check_released(vk_backspace);
		
		if(!alterando)
		{
			if(_up or _down)
			{
				//Mudar o valor de sel
				menus_sel[pag] += _down - _up;
	
				//Limitando o sel dentro do vetor
				var _tam = array_length(_menu) - 1;
				menus_sel[pag] = clamp(menus_sel[pag], 0, _tam);
				_animar = true;
			}
		}else
		{
			//Caso alterando seja verdade
			_animar = false;
			
			if(_left or _right)
			{
				//Descobrir o limite do vetor
				var _limite = array_length(_menu[_sel][4]) - 1;
				
				//Mudar o indice
				menus[pag][_sel][3] += _right - _left;
				
				//Garantir que não vai sair do limite
				menus[pag][_sel][3] = clamp(menus[pag][_sel][3], 0, _limite);
			}
		}
		
		//O que fazer quando apertar enter
		if(_avancar)
		{
			switch(_menu[_sel][1])
			{
				case menuAcoes.rodaMetodo: //Caso seja 0 rodarMétodo
					_menu[_sel][2]();
					break;
					
				case menuAcoes.carregaMenu: //Mudar o valor da página
					pag = _menu[_sel][2];
					break;
				
				case menuAcoes.ajustesMenu: //Quando entrar no estado de ajuste, inverter o valor de alterando
					//Rodar o método se estiver alterando
					if(alterando)
					{
						//Salvar o argumento(informação) do método
						var _arg = _menu[_sel][3];
						_menu[_sel][2](_arg);
					}
					
					alterando = !alterando;
					break;
			}
		}
		
		if(_animar == true)
		{
			margVal = margValTotal * animCurve(ac_margem, _up xor _down, 0);
		}
	}
	
	iniciarJogo = function()
	{
		room_goto(rm_1);
	}
	
	fecharJogo = function()
	{
		game_end();
	}
	
	ajustarTela = function(_valor)
	{
		//Checar se a tela deve ficar cheia ou janela
		switch(_valor)
		{
			case 0://Se tela cheia
				window_set_fullscreen(true);
				break;
			
			case 1://Se janela
				window_set_fullscreen(false);
				break;
		}
	}
	
	teste = function()
	{
		show_message("Teste!")
	}
	
#endregion

//Quando apertar enter no iniciar, deve rodar o método de iniciar o jogo
//Quando apertar enter no opções, deve carregar o menu de opções
//Quando apertar enter no sair, deve fechar o jogo

menu_principal	=	[
						["Iniciar", menuAcoes.rodaMetodo, iniciarJogo],
						["Opçoes", menuAcoes.carregaMenu, menuLista.opcoes],
						["Sair", menuAcoes.rodaMetodo, fecharJogo]
					];
					
menu_opcoes		=	[
						["Tipo de janela", menuAcoes.carregaMenu, menuLista.tela],
						["Voltar", menuAcoes.carregaMenu, menuLista.principal]
					];

menu_tela		=	[
						["Tipo de janela", menuAcoes.ajustesMenu, ajustarTela, 1, ["Tela Cheia", "Janela"]],
						["Voltar", menuAcoes.carregaMenu, menuLista.opcoes]
					]

//Salvar todos os menus
menus = [menu_principal, menu_opcoes, menu_tela];

//Salvar a seleção de cada menu
menus_sel = array_create(array_length(menus), 0);

alterando = false;
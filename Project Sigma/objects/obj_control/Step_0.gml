/// @description Insert description here
if(keyboard_check_pressed(vk_enter) and room != rm_logo and room != rm_menu)
{
	if(instance_exists(obj_gameover_effects))
	{
		instance_destroy(obj_gameover_effects, false);
		
		//Remover efeitos do gameover se o objeto do game over existir
		layer_desaturate = layer_get_fx("filter_desaturate");
		layer_distort = layer_get_fx("filter_distort");
		fx_set_parameter(layer_desaturate, "g_Intensity", 0);

		fx_set_parameter(layer_distort, "g_DistortScale", 0);
		fx_set_parameter(layer_distort, "g_DistortAmount", 0);
	}
	room_restart();
}
/// @description Insert description here

if(!instance_exists(obj_player))
{
	saturation = lerp(saturation, 1, 0.05);
	distort = lerp(distort, 8, 0.08);
	distort_amount = lerp(distort_amount, 50, 0.5);

	fx_set_parameter(layer_desaturate, "g_Intensity", saturation);

	fx_set_parameter(layer_distort, "g_DistortScale", distort);
	fx_set_parameter(layer_distort, "g_DistortAmount", floor(distort_amount));
}
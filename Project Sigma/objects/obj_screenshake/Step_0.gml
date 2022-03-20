/// @description Insert description here

//Tremer a tela
view_xport[0] = random_range(-shake, shake);
view_yport[0] = random_range(-shake, shake);

shake *= 0.9;

if(shake <= 0.2)
{
	instance_destroy();
}
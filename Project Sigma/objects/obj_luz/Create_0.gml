/// @description Insert description here

//Criando uma surface
surf = surface_create(room_width, room_height);
//Criar um método para desenhar as surfaces
desenhar_surface = function()
{
    if (surface_exists(surf) == false)
    {
        //Criar a surface
        surf = surface_create(room_width, room_height);

        //Definir a surface alvo
        surface_set_target(surf);

        //Limpar a surface
        draw_clear_alpha(c_black, 0);

        //Resetar o alpha (Voltar a ver a surface correta)
        surface_reset_target();
    }
    else //Se a surface existir desenhar ela
    {
        draw_surface(surf, 0, 0);
    }
}
//Desenhar luz
desenhar_luz = function()
{
    //Checar se a surface existe
    if (surface_exists(surf) == true)
    {
        surface_set_target(surf);

        //Limpando a surface
        draw_clear_alpha(c_black, 0.8);

        //Mudar o blendmode do desenho
        gpu_set_blendmode(bm_subtract);

        //Desenhando a luz
        var _variavel = random_range(-0.05, 0.05);
        draw_sprite_ext(spr_luz, 0, obj_player.x, obj_player.y - obj_player.sprite_height / 2, 2 + _variavel, 2 + _variavel, image_angle, c_white, 1);

        //Resetar o blendmode do desenho
        gpu_set_blendmode(bm_normal);

        surface_reset_target();
    }
}
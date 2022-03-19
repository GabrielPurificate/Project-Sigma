event_inherited();

draw_text(x, y + sprite_height / 2, timerEstado);
draw_text(x, y - sprite_height / 2, image_index);

draw_line(x, y - sprite_height / 2, x + (dist * image_xscale), y - sprite_height / 2);
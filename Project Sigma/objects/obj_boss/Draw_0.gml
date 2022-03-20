event_inherited();

draw_text(x + sprite_width / 2, y + sprite_height / 2, timerEstado);
draw_text(x, y - sprite_height / 2, sprite_index);
draw_text(x - sprite_width / 2, y - sprite_height / 2, image_index);

draw_line(x - sprite_width / 2, y - sprite_height / 3, x + (dist * image_xscale), y - sprite_height / 3);
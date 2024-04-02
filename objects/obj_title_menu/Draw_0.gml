draw_set_font(global.font_main)

var new_w = 1;
for (var i = 0; i < op_length; i ++) {
	var op_w = string_width(option[menu_level, i])
	new_w = max(new_w, op_w)
}

width = new_w + op_border*2


height = op_border*2 + string_height(option[0,0]) + (op_length-1)*op_space



draw_sprite_ext(sprite_index, image_index, x, y, width/sprite_width, height/sprite_height, 0, c_white, 1);


draw_set_valign(fa_top)
draw_set_halign(fa_left)

for (var i = 0; i < op_length; i ++) {
	var c = c_white
	if pos == i {c = c_aqua}
	draw_text_color(x+op_border, y+op_border +op_space*i, option[menu_level, i], c, c, c, c, 1)
}
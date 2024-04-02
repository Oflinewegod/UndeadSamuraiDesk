up_key = keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W")) or gamepad_button_check_pressed(global.pone, gp_padu)
down_key = keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S")) or gamepad_button_check_pressed(global.pone, gp_padd) 
select_key = keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_enter) or gamepad_button_check_pressed(global.pone, gp_face1) 
gamepad_set_axis_deadzone(global.pone, 0.3)

op_length = array_length(option[menu_level])


//menu movement
pos += down_key - up_key
if pos >= op_length {pos = 0}
if pos < 0 {pos = op_length - 1}

if select_key {

	var sml = menu_level;

	switch(menu_level) {
		case 0:
			switch(pos){
				case 0: pos = -2; menu_level = 3 break; //start 
				case 1: menu_level = 1; pos = 6; break; //settings
				case 2: game_end(); break; //exit game
			}
		case 1:
			switch(pos) {
				case 0: window_set_fullscreen(!window_get_fullscreen()); pos = 6; global.fullscreen = true; break; //fullscreen toggle
				case 1: if (pos == 1){audio_play_sound(snd_click, 1, false)}; break;  //fun button
				case 2: menu_level = 2; global.showcontrol = true; break;  //controls
				case 3: menu_level = 0; break; //go back
			}
		case 2:
			switch(pos) {
				case 0: if !global.controller { global.controller = true} else {global.controller = false}; break;
				case 1: menu_level = 1; global.showcontrol = false; break; //go back
				case 2: break; //nothing
			}
		case 3:
			switch(pos) {
				case 0: room_goto_next(); break;
				case 1: room_goto_next(); global.multi = true; break;
				case 2: menu_level = 0; break; //go back
			}
	}
	

	if sml != menu_level {pos = 0};

	op_length = array_length(option[menu_level]) 

}


if (menu_level != last_menu) && (menu_level > last_menu) {
	audio_play_sound(snd_select, 1, false)
	last_menu = menu_level
	menu_switch = true
} else if (menu_level != last_menu) && (menu_level < last_menu) {
	audio_play_sound(snd_exit, 1, false)
	last_menu = menu_level
	menu_switch = true
}

if (pos != last_selected) && (!menu_switch){audio_play_sound(snd_move, 1, false)
	last_selected = pos
}

if menu_switch == true {
	menu_switch = false
	last_selected = pos
}



var gp_num = gamepad_get_device_count();
for (var i = 0; i < gp_num; i++)
{
    if gamepad_is_connected(i) {
        global.gp[i] = true
		global.pone = i
	}    else {
        global.gp[i] = false;
}
}

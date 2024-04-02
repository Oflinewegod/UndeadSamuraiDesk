width = 64
height = 104

op_border = 8
op_space = 16

pos = 0;

//pause (?)
option[0, 0] = "Play"
option[0, 1] = "Settings"
option[0, 2] = "Exit"

//settings
option[1, 0] = "Toggle Fullscreen"
option[1, 1] = "Click Me"
option[1, 2] = "Controls"
option[1, 3] = "Back"

option[2, 0] = "Toggle Keyboard/Gamepad"
option[2, 1] = "Back"
option[2, 2] = "You are currently using:"

option[3, 0] = "1 Player"
option[3, 1] = "2 Players"
option[3, 2] = "Back"

alarm[0] = 500

op_length = array_length(option);
menu_level = 0

last_selected = 0
last_menu = 0
menu_switch = false
global.fullscreen = false;

global.multi = false
global.controller = false;
global.showcontrol = false;
global.pone = 0;
global.ptwo = 0;
gamepad_set_axis_deadzone(global.pone, 0.3)
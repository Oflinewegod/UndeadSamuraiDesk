//movement variables (they don't work if placed in Create event)
move_right = keyboard_check(ord("D"))
move_left = keyboard_check(ord("A"))
jump_pressed = keyboard_check_pressed(vk_space)
throw_shuriken = keyboard_check(ord("P"))
//grapple = keyboard_check(ord("I"))

if global.controller {
	move_right = (gamepad_axis_value(global.pone, gp_axislh) > 0 ) or gamepad_button_check(global.pone, gp_padr)
	move_left = (gamepad_axis_value(global.pone, gp_axislh) < 0 ) or gamepad_button_check(global.pone, gp_padl )
	jump_pressed = gamepad_button_check_pressed(global.pone, gp_face1)
	throw_shuriken = gamepad_button_check(global.pone, gp_face2)
}	

//to get speeds and stuff:
x_speed = (move_right - move_left) * move_speedx

y_speed += grav;

/*
if jump_pressed && place_meeting(x, y+1, obj_white_wall)
{
	y_speed = move_speedy;
	
}
*/

if  place_meeting(x, y+1, obj_white_wall){double_jump = true} //can dbl jump if floor touched

if jump_pressed{ //jumping and double jumping
	if place_meeting(x, y+1, obj_white_wall){
		y_speed = move_speedy;
		audio_play_sound(snd_jump, 4, false)
	} else if double_jump == true{ 
		y_speed = move_speedy*0.75;
		double_jump = false;
		audio_play_sound(snd_jump, 4, false)
	}
}

if place_meeting( x + x_speed, y, obj_white_wall)
{
	var _pixelcheck = sign(x_speed);
	while !place_meeting(x + _pixelcheck, y, obj_white_wall)
	{
		x += _pixelcheck;
	}
	x_speed = 0;
}

if place_meeting( x + x_speed, y + y_speed, obj_white_wall)
{
	var _pixelcheck = sign(y_speed);
	while !place_meeting(x + x_speed, y + _pixelcheck, obj_white_wall)
	{
		y += _pixelcheck;
	}	
	
	y_speed = 0;
}
if place_meeting(x, y, instance_place(x, y, obj_white_wall)){
	if instance_place(x, y, obj_white_wall.y) < y {y += 2}
}

x += x_speed;	
y += y_speed;

//shuriken throwing

if move_right{ //checks player direction
	global.dir = 1;
} else if move_left{
	global.dir = -1;
}
if throw_shuriken && (throw_cooldown <= 0) && !grappling && released{ //shuriken throwing
	if global.dir == 1 {
		instance_create_layer(x-8, y-30, "Bullet", obj_shuriken)
		throw_cooldown = 1
	}
	else if global.dir == -1 {
		instance_create_layer(x+8, y, "Bullet", obj_shuriken)
		throw_cooldown = 1
	}
	audio_play_sound(snd_shuriken, 3, false)
	released = false;
}
/* grappling doesn't work right now, will be commented out until we have time to fix it

if grapple && (throw_cooldown <= 0) && !grappling{  //grappling
	if global.dir == 1 {
		instance_create_layer(x-8, y-30, "Bullet", obj_grapplehead)
		throw_cooldown = 1
	} else if global.dir == -1 {
		instance_create_layer(x+8, y, "Bullet", obj_grapplehead)
		throw_cooldown = 1
	}	grappling = true;	
}
*/

	
if throw_cooldown > 0 {throw_cooldown -= 0.075} //caps out how fast you can throw shurikens
if keyboard_check_released(ord("P")) or gamepad_button_check_released(global.pone, gp_face2){released = true} //prevents you from just holding the throw button

//step sound effect
if step_cooldown == 0 && (move_left or move_right) && place_meeting(x, y+2, obj_white_wall){
	step_cooldown = 6
	audio_play_sound(snd_step, 2, false)
} else if step_cooldown > 0{
	step_cooldown -= 1
}


//Animations
if y_speed <0 {
	if double_jump == true {
		if global.dir = 1 {
			sprite_index = sprPlayerOneJump
			image_xscale = -1
		} else if global.dir = -1 {
			sprite_index = sprPlayerOneJump
			image_xscale = 1
		}
	} else { 
		if global.dir = 1 {
			sprite_index = sprPlayerOneFlip
			image_xscale = -1
		} else if global.dir = -1 {
			sprite_index = sprPlayerOneFlip
			image_xscale = 1
		}
	}
} else if y_speed > 0 && !place_meeting(x, y+1, obj_white_wall){
	if global.dir = 1 {
		sprite_index = sprPlayerOneFall
		image_xscale = -1
	} else if global.dir = -1 {
		sprite_index = sprPlayerOneFall
		image_xscale = 1
	}
} else if move_right {
	sprite_index = sprPlayerOneRun
	image_xscale = -1
} else if move_left {
	sprite_index = sprPlayerOneRun
	image_xscale = 1
	
} else { 
	sprite_index = sprPlayerOneIdle
}

if (keyboard_check_pressed(vk_f1)) // vk_f1 can be replaced with any desired key
{
    // Toggle between fullscreen and windowed mode
    window_set_fullscreen(!window_get_fullscreen());
}

if (keyboard_check_pressed(vk_escape)) // vk_f1 can be replaced with any desired key
{
    game_end()
}
if (instance_exists(obj_player_one)) {
	if (obj_player_one.x > obj_test_enemy.x) {
		x_speed = move_speedx
	} else if (obj_player_one.x < obj_test_enemy.x){
		x_speed = (move_speedx*-1)
	}
}

y_speed += grav;

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

x += x_speed;	
y += y_speed;

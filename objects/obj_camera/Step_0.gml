/// @description Camera Setup
	
if (instance_exists(follow)) {
	xTo = follow.x
	yTo = follow.y
}

x += (xTo - x)/25
y += (yTo - y)/25

x = clamp(x, view_w_half, room_width-view_w_half)

camera_set_view_pos(cam,x-view_w_half,y-view_h_half)

if global.fullscreen == true{
	window_set_fullscreen(true);
}
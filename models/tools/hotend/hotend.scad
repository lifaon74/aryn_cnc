include <../tool_base.scad>
include <../e3d_v6.scad>

$fn=40;


e3d_v6();

//	cylinder($fn = 6, r=(screws_nuts_side_max / 2), h=nut_heigth, center=true);
//	cube([_stepper_motor_corner_size, _stepper_motor_corner_size, stepper_motor_corner_height], center = true);

_render_tool_base(1);
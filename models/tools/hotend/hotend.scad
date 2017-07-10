include <../tool_base.scad>
include <../e3d_v6.scad>

$fn=40;

e3d_v6_radiator_diameter_margin = 0.25;
e3d_v6_fix_diameter_margin = 0.25;

e3d_v6("plenty", e3d_v6_radiator_diameter_margin, e3d_v6_fix_diameter_margin);

//	cylinder($fn = 6, r=(screws_nuts_side_max / 2), h=nut_heigth, center=true);
//	cube([_stepper_motor_corner_size, _stepper_motor_corner_size, stepper_motor_corner_height], center = true);

_render_tool_base(1);
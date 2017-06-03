include <../tool_base.scad>

$fn=40;

stepper_motor_size = 42;
stepper_motor_corner_size = 4;
stepper_motor_shaft_diameter = 5;
stepper_motor_shaft_ring_diameter = 22;
stepper_motor_shaft_ring_height = 2;
stepper_motor_shaft_diameter = 5;
stepper_motor_shaft_height = 20;
stepper_motor_holes_distance = 31;

drive_gear_diameter = 11;
drive_gear_height = 11;

push_gear_diameter = 12;
push_gear_height = 4;

filament_diameter = 1.75;
filament_margin = 0.25;
filament_x_offset = (drive_gear_diameter / 2) + (filament_diameter / 2);
filament_z_offset = 13;

material_spacing = 0;

module stepper_motor_corner(pos_x, pos_y, stepper_motor_corner_height = stepper_motor_size) {
	
	_stepper_motor_corner_size = (stepper_motor_corner_size * 2) / sqrt(2);
	
	stepper_motor_corner_horizontal_offset = (stepper_motor_size / 2);
	stepper_motor_corner_z_offset = -(stepper_motor_size / 2);
	
	translate([stepper_motor_corner_horizontal_offset * pos_x, stepper_motor_corner_horizontal_offset * pos_y, stepper_motor_corner_z_offset])
	rotate([0, 0, 45])
	cube([_stepper_motor_corner_size, _stepper_motor_corner_size, stepper_motor_corner_height], center = true);
}
// stepper_motor_corner

module stepper_motor_corners(stepper_motor_corner_height = stepper_motor_size) {
	stepper_motor_corner(+1, +1, stepper_motor_corner_height);
	stepper_motor_corner(+1, -1, stepper_motor_corner_height);
	stepper_motor_corner(-1, +1, stepper_motor_corner_height);
	stepper_motor_corner(-1, -1, stepper_motor_corner_height);
}
// stepper_motor_corners


module stepper_motor(margin = 0) {
	
	_stepper_motor_shaft_ring_diameter = stepper_motor_shaft_ring_diameter + margin * 2;
	_stepper_motor_shaft_ring_height = stepper_motor_shaft_ring_height + margin;
	
	_stepper_motor_shaft_ring_diameter_z_offset = (_stepper_motor_shaft_ring_height / 2);
	
	
	_stepper_motor_shaft_diameter = stepper_motor_shaft_diameter + margin * 2;
	_stepper_motor_shaft_height = stepper_motor_shaft_height + margin;
	_stepper_motor_shaft_height_z_offset =stepper_motor_shaft_ring_height + (_stepper_motor_shaft_height / 2);
	
	union() {
		color([0.7, 0.7, 0.7])
		difference() {
			translate([0, 0, -(stepper_motor_size / 2)])
			cube([stepper_motor_size, stepper_motor_size, stepper_motor_size], center = true);
			stepper_motor_corners(stepper_motor_size + 1);
		}
			
		color([0.6, 0.6, 0.6])
		translate([0, 0, _stepper_motor_shaft_ring_diameter_z_offset])
		cylinder(r=(_stepper_motor_shaft_ring_diameter / 2), h=_stepper_motor_shaft_ring_height, center=true);
		
		color([0.3, 0.3, 0.3])
		translate([0, 0, _stepper_motor_shaft_height_z_offset])
		cylinder(r=(_stepper_motor_shaft_diameter / 2), h=_stepper_motor_shaft_height, center=true);
	}
}
//stepper_motor

module stepper_motor_holes(height = 50) {
	stepper_motor_holes_offset = (stepper_motor_holes_distance / 2);
	
	color([1, 0, 0])
	union() {
		translate([+stepper_motor_holes_offset, +stepper_motor_holes_offset, 0])
		screw(height);
		
		translate([+stepper_motor_holes_offset, -stepper_motor_holes_offset, 0])
		screw(height);
		
		translate([-stepper_motor_holes_offset, +stepper_motor_holes_offset, 0])
		screw(height);
		
		translate([-stepper_motor_holes_offset, -stepper_motor_holes_offset, 0])
		screw(height);
	}
}
// stepper_motor_holes


module drive_gear(margin = 0) {
	_drive_gear_diameter = drive_gear_diameter + margin * 2;
	_drive_gear_height = drive_gear_height + margin * 2;
	
	color([1, 0.8, 0])
	cylinder(r=(_drive_gear_diameter / 2), h=_drive_gear_height, center=true);
}
// drive_gear

module push_gear(margin_diameter = 1, margin_height = 0.5) {
	_push_gear_diameter = push_gear_diameter + margin_diameter * 2;
	_push_gear_height = push_gear_height + margin_height * 2;
	
	color([0.8, 0.8, 0.8])
	cylinder(r=(_push_gear_diameter / 2), h=_push_gear_height, center=true);
}
// push_gear


module filament(margin = 0) {
	_filament_diameter = filament_diameter + margin * 2;
	color([0, 0.8, 0])
	translate([filament_x_offset, 0, filament_z_offset])
	rotate([90, 0, 0])
	cylinder(r=(_filament_diameter / 2), h=400, center=true);
}
// filament


module gears(margin = 0) {
	drive_gear_z_offset = filament_z_offset - 2;
	
	translate([0, 0, drive_gear_z_offset])
	drive_gear(margin);
	
	push_gear_x_offset = (push_gear_diameter / 2) + (drive_gear_diameter / 2) + 1;
	push_gear_z_offset = filament_z_offset;
	
	translate([push_gear_x_offset, 0, push_gear_z_offset])
	push_gear(margin);
}
// gears

filament();
gears(material_spacing);

stepper_motor(material_spacing);
stepper_motor_holes();













$fn=20;

include <../tool_base.scad>

use_vacuum = false;
use_laser_diode = true;

base_block_y = 70;

spindler_z_offset = (base_block_z / 2) - 10;

spindler_height = 94;
spindler_diameter_inner = 55;
spindler_diameter_outer = 56.5;
spindler_case_bottom_z = 23;
spindler_case_top_z = 15;

spindler_shaft_length = 40;
spindler_shaft_diameter = 12;

spindler_shaft_circle_length = 3;
spindler_shaft_circle_diameter = 25;
	
spindler_screw_length = 30;
spindler_screw_diameter = 4;
spindler_screw_radius = 39;
	
	
	
vacuum_diameter_inner = 18;
vacuum_diameter_outer = 25;
vacuum_border_distance = 3.5;

vacuum_z = base_block_z + 10;
vacuum_x_offset = (base_block_remove_x / 2) - (vacuum_diameter_inner / 2) - pieces_spacing - vacuum_border_distance;
vacuum_y_offset = (base_block_remove_y / 2) - (vacuum_diameter_inner / 2) - vacuum_border_distance;
vacuum_z_offset = (base_block_z / 2) + (vacuum_z / 2) - 10;

vacuum_spindler_x_offset = use_vacuum ? -9 : 0;


laser_diode_diameter = 6 + 0.2;
laser_diode_height = 6;
laser_diode_beam_diameter = 1;




/*
    PIECE
*/

module spindler_motor(margin = 1) {
	$fn=100;
	
	_spindler_diameter_inner = spindler_diameter_inner + 2 * margin;
	_spindler_diameter_outer = spindler_diameter_outer + 2 * margin;
	_spindler_case_bottom_z = spindler_case_bottom_z + 10;

	_spindler_shaft_diameter = spindler_shaft_diameter + 2 * margin;

	_spindler_shaft_circle_length = spindler_shaft_circle_length + margin;
	_spindler_shaft_circle_diameter = spindler_shaft_circle_diameter + 2 * margin;
	
	translate([0, 0, 0.001])
	union() {
		// motor
		color([0.1, 0.1, 0.1])
		translate([0, 0, (spindler_height / 2)])
		cylinder(r=(_spindler_diameter_inner / 2), h=spindler_height, center=true);
		
		// case_bottom
		color([0.2, 0.2, 0.2])
		translate([0, 0, (_spindler_case_bottom_z / 2) - 0.001])
		cylinder(r=(_spindler_diameter_outer / 2), h=_spindler_case_bottom_z, center=true);
		
		// case_top
		color([0.2, 0.2, 0.2])
		translate([0, 0, spindler_height - (spindler_case_top_z / 2) + 0.001])
		cylinder(r=(_spindler_diameter_outer / 2), h=spindler_case_top_z, center=true);
		
		// shaft circle
		color([0.1, 0.1, 0.1])
		translate([0, 0, -(_spindler_shaft_circle_length / 2)])
		cylinder(r=(_spindler_shaft_circle_diameter / 2), h=_spindler_shaft_circle_length, center=true);
		
		// shaft
		color([0.5, 0.5, 0.5])
		translate([0, 0, -(spindler_shaft_length / 2)])
		cylinder(r=(_spindler_shaft_diameter / 2), h=spindler_shaft_length, center=true);
	}
}
// spindler_motor

module spindler_screws() {
	// screws
	color([1, 0, 0])
	for(x = [-1 : 2 : 1]) {
		for(y = [-1 : 2 : 1]) {
			pos = (spindler_screw_radius / 2) / sqrt(2);
			translate([pos * x, pos * y, 0])
			cylinder(r=(spindler_screw_diameter / 2), h=spindler_screw_length, center=true);
		}
	}
}
// spindler_screws

module spindler(margin = 1, with_screws = true) {
	if(with_screws) {
		union() {
			spindler_motor(margin);
			spindler_screws();
		}
	} else {
		difference() {
			spindler_motor(margin);
			spindler_screws();
		}
	}
}
// spindler
//color([0, 0, 0, 0.5])
//spindler(0, false); // for true motor size


module vacuum() {
	$fn=100;
	translate([vacuum_x_offset, vacuum_y_offset, 0])
	cylinder(r=(vacuum_diameter_inner / 2), h=vacuum_z, center=true);
	
	translate([vacuum_x_offset, vacuum_y_offset, vacuum_z_offset])
	cylinder(r=(vacuum_diameter_outer / 2), h=vacuum_z, center=true);
}
// vacuum

module laser_diode(pos_x) {
	laser_diode_x_offset = round(((spindler_diameter_outer + 2) / 2) + (laser_diode_diameter / 2) + 3);
	
	echo("laser_diode_x_offset", laser_diode_x_offset);
	
	translate([laser_diode_x_offset * pos_x, 0, 0])
	union() {
		translate([0, 0, base_block_z / 2])
		cylinder(r=(laser_diode_diameter / 2), h=laser_diode_height * 2, center=true, $fn=100);
		
		cylinder(r=(laser_diode_beam_diameter / 2), h=base_block_z * 2, center=true);
	}
}
// laser_diode



/*
    RENDERING
*/

module _render(cube_pos_z) {
	difference() {
		_render_tool_base(cube_pos_z);
		
		color([0.5, 0, 0.5])
		translate([vacuum_spindler_x_offset, 0, -spindler_z_offset])
		spindler();
		
		
		if(use_vacuum) vacuum();
		if(use_laser_diode) {
			laser_diode(+1);
			laser_diode(-1);
		}
	}
}


//translate([0, 0, -spindler_z_offset])
//spindler();
_render(1); // -1 for bottom, 0, for all, 1 for top












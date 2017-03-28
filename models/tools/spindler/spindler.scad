$fn=20;

include <../tool_base.scad>

use_vacuum = true;

base_block_y = 70;

spindler_z_offset = (base_block_z / 2) - 12;

vacuum_diameter_inner = 16;
vacuum_diameter_outer = 21;
vacuum_border_distance = 3;

vacuum_z = base_block_z + 10;
vacuum_x_offset = (base_block_remove_x / 2) - (vacuum_diameter_inner / 2) - pieces_spacing - vacuum_border_distance;
vacuum_y_offset = (base_block_remove_y / 2) - (vacuum_diameter_inner / 2) - vacuum_border_distance;
vacuum_z_offset = (base_block_z / 2) + (vacuum_z / 2) - 10;

vacuum_spindler_x_offset = use_vacuum ? -5 : 0;


/*
    PIECE
*/

module spindler_motor(margin = 1) {
	$fn=100;
	
	spindler_height = 94;
	spindler_diameter_inner = 55 + 2 * margin;
	spindler_diameter_outer = 56.5 + 2 * margin;
	spindler_case_bottom_z = 23;
	spindler_case_top_z = 15;

	pindler_shaft_length = 40;
	spindler_shaft_diameter = 12 + 2 * margin;

	spindler_shaft_circle_length = 3 + margin;
	spindler_shaft_circle_diameter = 25 + 2 * margin;
	
	translate([0, 0, 0.001])
	union() {
		// motor
		color([0.1, 0.1, 0.1])
		translate([0, 0, (spindler_height / 2)])
		cylinder(r=(spindler_diameter_inner / 2), h=spindler_height, center=true);
		
		// case_bottom
		color([0.2, 0.2, 0.2])
		translate([0, 0, (spindler_case_bottom_z / 2) - 0.001])
		cylinder(r=(spindler_diameter_outer / 2), h=spindler_case_bottom_z, center=true);
		
		// case_top
		color([0.2, 0.2, 0.2])
		translate([0, 0, spindler_height - (spindler_case_top_z / 2) + 0.001])
		cylinder(r=(spindler_diameter_outer / 2), h=spindler_case_top_z, center=true);
		
		// shaft circle
		color([0.1, 0.1, 0.1])
		translate([0, 0, -(spindler_shaft_circle_length / 2)])
		cylinder(r=(spindler_shaft_circle_diameter / 2), h=spindler_shaft_circle_length, center=true);
		
		// shaft
		color([0.5, 0.5, 0.5])
		translate([0, 0, -(pindler_shaft_length / 2)])
		cylinder(r=(spindler_shaft_diameter / 2), h=pindler_shaft_length, center=true);
	}
}
// spindler_motor

module spindler_screws() {
	spindler_screw_length = 30;
	spindler_screw_diameter = 4;
	spindler_screw_radius = 39;
	
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
//spindler(0, false); // for true motor size


module vacuum() {
	$fn=100;
	translate([vacuum_x_offset, vacuum_y_offset, 0])
	cylinder(r=(vacuum_diameter_inner / 2), h=vacuum_z, center=true);
	
	translate([vacuum_x_offset, vacuum_y_offset, vacuum_z_offset])
	cylinder(r=(vacuum_diameter_outer / 2), h=vacuum_z, center=true);
}
// vacuum


/*
    RENDERING
*/

module _render(cube_pos_z) {
	difference() {
		_render_tool_base(cube_pos_z);
		
		translate([vacuum_spindler_x_offset, 0, -spindler_z_offset])
		spindler();
		if(use_vacuum) vacuum();
	}
}


//translate([0, 0, -spindler_z_offset])
//spindler();
_render(1); // -1 for bottom, 0, for all, 1 for top












$fn=40;

include <../../config.scad>

belt_holder_case_x = 17.2;
belt_holder_case_y = 20;
belt_holder_case_z = 13.3;
belt_holder_wall_thickness_x = 1.4;
belt_holder_wall_thickness_y = 3;
belt_holder_wall_thickness_z = 2;


base_top_y = base_block_y;
base_top_z = 7;

belt_space = 3;


carriage_block_offset_x = 0; // comment/uncomment to adjust preview
//	carriage_block_offset_x = carriage_block_x / 2;


/**
	COMPUTED
**/

    // base position
base_block_y_offset = (base_block_y / 2) - (bearing_virtual_cube_side / 2)/* - screw_virtual_holder_side*/ - outer_screw_offset;


belt_holder_case_block_x = belt_holder_case_x + (belt_holder_wall_thickness_x * 2);
belt_holder_case_block_y = 44;
belt_holder_case_block_z = belt_holder_case_z + (belt_holder_wall_thickness_z * 2);

belt_holder_case_block_z_offset = (belt_holder_case_block_z / 2) + (rod_remove_side / 2);

belt_holder_case_y_offset = (belt_holder_case_block_y - belt_holder_case_y) / 2 - belt_holder_wall_thickness_y;
	
base_top_x = belt_holder_case_block_x;
base_top_block_z_offset = (base_block_z / 2) + (base_top_z / 2);
	
	
base_fix_block_z_offset = (base_block_z / 2) + (base_top_z / 2);


screws_remove_offset_y = (base_block_y / 2) - (base_top_z / 2);

	
// fine manual tunning
belt_holder_case_block_y_offset = 4;
belt_remove_part1_y = 40;
belt_remove_part1_y_offset = 41.3;

belt_remove_part2_y_offset = -3.8;
belt_remove_part2_z_offset = (rod_remove_side / 2) + belt_holder_wall_thickness_z + 4.5;



module carriage_block() {
	
	
	color([0, 0, 0, 0.7])
	translate([-carriage_block_offset_x, base_block_y_offset, 0])
	cube([carriage_block_x, base_block_y, base_block_z], center = true);
	echo("piece x :", base_block_x);
	echo("piece y :", base_block_y);
	echo("piece z :", base_block_z);
	
	
	rod(true);
}
// carriage_block

module belt_remove() {
	belt_remove_y = 40;
	belt_remove_y_offset = 40;
	
	color([1, 0, 0, 0.7])
	union() {
		translate([0, belt_remove_part1_y_offset, 0])
		cube([belt_holder_case_x, belt_remove_part1_y, belt_space], center = true);
		
		rotate([-45, 0, 0])
		translate([0, belt_remove_part2_y_offset, belt_remove_part2_z_offset])
		cube([belt_holder_case_x, belt_remove_part1_y, belt_space], center = true);
	}
}
// belt_remove

module base_holder_case_remove() {
	rotate([-45, 0, 0])
	translate([0, belt_holder_case_block_y_offset, belt_holder_case_block_z_offset])
	
	union() {
		translate([0, -belt_holder_case_y_offset, 0])
		cube([belt_holder_case_x, belt_holder_case_y, belt_holder_case_z], center = true);
		
		screw_height = 30;
		screw_diameter = 2.5;
		
		translate([0, -(screw_height / 2) - belt_holder_case_y_offset, (belt_holder_case_z / 2) - 2.75])
		rotate([90, 0, 0])
		cylinder(r=(screw_diameter / 2), h=screw_height , center=true);
	}
}
// base_holder_case_remove

module base_extra_remove() {
	base_extra_size = 60;
	
	union() {
		
		translate([0, (base_extra_size / 2) + (base_block_y / 2) + base_block_y_offset - 0.01, 0])
		cube([base_extra_size, base_extra_size, base_extra_size], center = true);
		
		translate([0, 0, -(base_extra_size / 2) - (belt_space / 2) - belt_holder_wall_thickness_z])
		cube([base_extra_size, base_extra_size, base_extra_size], center = true);
	}
}
// base_extra_remove

module base_extra_add() {
	base_extra_size = 10;
	
	translate([0, -(base_extra_size / 2) + (base_block_y / 2) + base_block_y_offset, -(base_extra_size / 2) + (base_block_z / 2) + 0.01])
	cube([belt_holder_case_block_x, base_extra_size, base_extra_size], center = true);
}
// base_extra_add

module screws_remove() {
	
	union() {
		translate([0, base_block_y_offset + screws_remove_offset_y, base_top_block_z_offset])
		rotate([0, 90, 0])
		screw();
		
		translate([0, base_block_y_offset - screws_remove_offset_y, base_top_block_z_offset])
		rotate([0, 90, 0])
		screw();
	}
}
// screws_remove

module base_fix_switch() {
	switch_y_offset = (base_top_y / 2) - 7.6;
	switch_z_offset = (base_top_z / 2) + (switch_z / 2);
	
	translate([0, base_block_y_offset, base_fix_block_z_offset])
	translate([0, switch_y_offset, switch_z_offset + 0.001])
	switch();
}
// base_fix_switch 


module base_fix_nuts_insert() {
	base_fix_nuts_insert_x_offset = (carriage_block_x / 2) - 6;
	
	color([1, 0, 0, 0.7])
	translate([0, base_block_y_offset, base_fix_block_z_offset])
	union() {
		translate([base_fix_nuts_insert_x_offset, screws_remove_offset_y, 0])
		cube([screw_nuts_height, screws_nuts_side_min, 10], center = true);
		
		translate([base_fix_nuts_insert_x_offset, -screws_remove_offset_y, 0])
		cube([screw_nuts_height, screws_nuts_side_min, 10], center = true);
	}
}
// base_fix_nuts_insert


module base_top_block() {
	translate([0, base_block_y_offset, base_top_block_z_offset])
	cube([base_top_x, base_top_y, base_top_z], center = true);
}
// base_top_block

module base_holder_case_block() {

	rotate([-45, 0, 0])
translate([0, belt_holder_case_block_y_offset, belt_holder_case_block_z_offset])
	cube([belt_holder_case_block_x, belt_holder_case_block_y, belt_holder_case_block_z], center = true);
}
// base_holder_case_block

module belt_holder_x() {
   difference() {
		 union() {
			 base_holder_case_block();
			 base_top_block();
			 base_extra_add();
		 }
		 
		 base_holder_case_remove();
		 belt_remove();
		 base_extra_remove();
		 screws_remove();
	 }
}
// belt_holder_x

module base_fix_block_remove_lighter() {
	base_fix_block_remove_lighter_diameter = 26;
	
	color([1, 0, 0, 0.7])
	translate([0, base_block_y_offset, base_fix_block_z_offset])
	cylinder (r=(base_fix_block_remove_lighter_diameter / 2), h=(base_top_z * 2), center=true);
}
//base_fix_block_remove_lighter


module base_fix_block() {
	translate([0, base_block_y_offset, base_fix_block_z_offset])
	cube([carriage_block_x, base_block_y, base_top_z], center = true);
}
// base_fix_block



module render_belt_holder() {
	intersection() { // difference, intersection
		belt_holder_x();
		
		translate([50 + (belt_holder_case_block_x / 2) - belt_holder_wall_thickness_x - 0.001, 0, 0])
		cube([100, 100, 100], center = true);
	}
}
// render_belt_holder


module render_fix_block() {
	difference() {
		base_fix_block();
		
		base_fix_switch();
		base_fix_nuts_insert();
		
		translate([(50 / 2) + (carriage_block_x / 2 )- 6 - 5, 0, 0])
		screws_remove();
		
		translate([0, base_block_y_offset, base_fix_block_z_offset])
		carriage_block_fix(base_top_z);
		base_fix_block_remove_lighter();
	}
}
// render_fix_block

//carriage_block();
//carriage_block_fix();

//render_belt_holder();
render_fix_block();


//base_fix_switch();







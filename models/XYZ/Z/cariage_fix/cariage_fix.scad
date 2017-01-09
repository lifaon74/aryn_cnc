$fn=20;

include <../../config.scad>
include <../carriage/carriage.scad>

rod_side = 20.4;

pieces_margin = 0.5;

rod_fix_thickness_x = 7;
rod_fix_thickness_y = 10;
rod_fix_thickness_z = 4;
rod_fix_thickness_z_gap = 0.6;

carriage_fix_z_adjust = 25;


rod_fix_x = rod_side + 2 * rod_fix_thickness_x;
rod_fix_y = rod_fix_thickness_y;
rod_fix_z = rod_side + rod_fix_thickness_z - rod_fix_thickness_z_gap;

rod_fix_z_offset = -(rod_fix_z / 2) + (rod_side / 2) - rod_fix_thickness_z_gap;

carriage_fix_thickness = 2.5;
carriage_fix_thickness_z = 10;

carriage_fix_x = rod_fix_x + pieces_margin + (carriage_fix_thickness * 2);
carriage_fix_y = rod_fix_y + pieces_margin + carriage_fix_thickness;
carriage_fix_z = carriage_fix_thickness_z + rod_fix_z + 2;

carriage_fix_y_offset = -(carriage_fix_thickness / 2);
carriage_fix_z_offset = (carriage_fix_z / 2) - carriage_fix_thickness_z;

carriage_fix_back_plate_x = carriage_fix_x;
carriage_fix_back_plate_y = 5;
carriage_fix_back_plate_z = base_z;

screw_head_diameter = 6;


/*
    ROD FIX
*/

module positioned_rod() {
	color([0.7, 0.7, 0.7])
    cube([rod_side, 1000, rod_side], center = true);
}
// positioned_rod




module fix_screw(pos_x) {
	screw_head_height = 20;
	
	screw_head_z_thickness = 8;
	screw_head_z_offet = rod_fix_z_offset + (screw_head_height / 2) - (rod_fix_z / 2) + screw_head_z_thickness;
	
	screw_x_offset = (rod_fix_x / 2) - (rod_fix_thickness_x / 2);
	color([1, 0, 0])
	translate([screw_x_offset * pos_x, 0, 0])
	union() {
		screw();
		translate([0, 0, screw_head_z_offet])
		cylinder (r=(screw_head_diameter / 2), h=screw_head_height , center=true);
	}
}
// fix_screw


module positioned_screws() {
	fix_screw(+1);
	fix_screw(-1);
}
// positioned_screws


module rod_fix_base() {
	color([1, 1, 0, 0.7])
	translate([0, 0, rod_fix_z_offset])
	cube([rod_fix_x, rod_fix_y, rod_fix_z], center = true);
}
//rod_fix_base

module rod_fix() {
	difference() {
		rod_fix_base();
		screw();
		positioned_screws();
		positioned_rod();
	}
}
// rod_fix


/*
    carriage FIX
*/


module base_screw_remove_fixation(pos_x, pos_z) {
	screw_height = 20;
	screw_head_height = 3;

	fixation_offset_x = 8;
	fixation_offset_y = -(carriage_fix_back_plate_y / 2) + screw_head_height * 1;
	fixation_offset_z = (base_z / 2) - (screw_virtual_holder_side_smaller / 2);
	
	translate([fixation_offset_x * pos_x, fixation_offset_y, fixation_offset_z * pos_z])
	color([1, 0, 1, 0.7])
	rotate([90, 0, 0])
	union() {
		translate([0, 0, -(screw_height / 2) + 0.01])
		cylinder (r=(screw_diameter / 2), h=screw_height , center=true);
		
		translate([0, 0, (screw_height / 2)])
		cylinder (r=(screw_head_diameter / 2), h=screw_height , center=true);
		
	}
}
//base_screw_remove_fixation

module positioned_carriage_fix_screws() {
	base_screw_remove_fixation(+1, +1);
	base_screw_remove_fixation(-1, +1);
	base_screw_remove_fixation(+1, -1);
	base_screw_remove_fixation(-1, -1);
}
//positioned_carriage_fix_screws






module carriage_fix_screw(pos_x) {
	screw_x_offset = (rod_fix_x / 2) - (rod_fix_thickness_x / 2);
	color([1, 0, 0])
	translate([screw_x_offset * pos_x, 0, 0])
	union() {
		screw();
		
		nut_y = 20;
		nut_offset_z = -(carriage_fix_thickness_z / 2);
		translate([0, 0, nut_offset_z])
		cube([screws_nuts_side_min, nut_y, screw_nuts_height], center = true);
	}
	
}
// carriage_fix_screw

module carriage_fix_screw_remove() {
	carriage_fix_screw(+1);
	carriage_fix_screw(-1);
}
//carriage_fix_screw_remove

module carriage_fix_base_remove() {
	carriage_fix_base_remove_x = rod_fix_x + pieces_margin;
	carriage_fix_base_remove_y = (rod_fix_y + pieces_margin);
	carriage_fix_base_remove_z = 30;
	
	color([1, 0, 0])
	translate([0, 0, (carriage_fix_base_remove_z / 2)])
	union() {
		cube([carriage_fix_base_remove_x, carriage_fix_base_remove_y + 0.01, carriage_fix_base_remove_z], center = true);
		
		carriage_fix_base_remove_x_2 = rod_side + 2;
		translate([0, 0, rod_fix_thickness_z])
		cube([carriage_fix_base_remove_x_2, 30, carriage_fix_base_remove_z], center = true);
		
		
		carriage_fix_base_remove_cylinder_diameter = 7;
		cylinder (r=(carriage_fix_base_remove_cylinder_diameter / 2), h=60 , center=true);
	}
}
//carriage_fix_base_remove

module carriage_fix_base() {
	color([1, 1, 0, 0.7])
	translate([0, carriage_fix_y_offset, carriage_fix_z_offset])
	cube([carriage_fix_x, carriage_fix_y, carriage_fix_z], center = true);
}
//carriage_fix_base

module carriage_fix_back_plate() {
	
	
	
	carriage_fix_back_plate_y_offset = carriage_fix_y_offset + (carriage_fix_y / 2) + (carriage_fix_back_plate_y / 2);
	carriage_fix_back_plate_z_offset = (carriage_fix_back_plate_z / 2) - carriage_fix_thickness_z;
	
	translate([0, carriage_fix_back_plate_y_offset, carriage_fix_back_plate_z_offset])
	difference() {
		color([1, 1, 0, 0.7])
		cube([carriage_fix_back_plate_x, carriage_fix_back_plate_y + 0.01, carriage_fix_back_plate_z], center = true);
		
		positioned_carriage_fix_screws();
	}
}
//carriage_fix_back_plate


module positionned_carriage_fix_back_plate() {
	
	union() {
		
		translate([0, 0, carriage_fix_z_adjust - 0.01])
		carriage_fix_back_plate();
		
		
		
		carriage_fix_back_plate_remain_y = carriage_fix_back_plate_y - 2;
		carriage_fix_back_plate_remain_z = carriage_fix_z_adjust;
		
		carriage_fix_back_plate_remain_y_offset = carriage_fix_y_offset + (carriage_fix_y / 2) + (carriage_fix_back_plate_remain_y / 2);
		
		carriage_fix_back_plate_z_offset = (carriage_fix_back_plate_remain_z / 2) - carriage_fix_thickness_z;
		
		translate([0, carriage_fix_back_plate_remain_y_offset, carriage_fix_back_plate_z_offset])
		cube([carriage_fix_back_plate_x, carriage_fix_back_plate_remain_y + 0.01, carriage_fix_back_plate_remain_z], center = true);
	}
}
//positionned_carriage_fix_back_plate


module carriage_fix() {
	difference() {
		carriage_fix_base();
		carriage_fix_base_remove();
		carriage_fix_screw_remove();
	}
}
// carriage_fix


module _render() {
//	translate([0, 0, +17])
//	rod_fix();
	
	union() {
		carriage_fix();
		positionned_carriage_fix_back_plate();
	}
}


_render();











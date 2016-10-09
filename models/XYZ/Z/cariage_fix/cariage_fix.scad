$fn=20;

include <../../config.scad>
include <../cariage/cariage.scad>

rod_side = 20.4;

pieces_margin = 0.5;

rod_fix_thickness_x = 7;
rod_fix_thickness_y = 10;
rod_fix_thickness_z = 4;
rod_fix_thickness_z_gap = 0.6;

cariage_fix_z_adjust = 25;


rod_fix_x = rod_side + 2 * rod_fix_thickness_x;
rod_fix_y = rod_fix_thickness_y;
rod_fix_z = rod_side + rod_fix_thickness_z - rod_fix_thickness_z_gap;

rod_fix_z_offset = -(rod_fix_z / 2) + (rod_side / 2) - rod_fix_thickness_z_gap;

cariage_fix_thickness = 2.5;
cariage_fix_thickness_z = 10;

cariage_fix_x = rod_fix_x + pieces_margin + (cariage_fix_thickness * 2);
cariage_fix_y = rod_fix_y + pieces_margin + cariage_fix_thickness;
cariage_fix_z = cariage_fix_thickness_z + rod_fix_z + 2;

cariage_fix_y_offset = -(cariage_fix_thickness / 2);
cariage_fix_z_offset = (cariage_fix_z / 2) - cariage_fix_thickness_z;

cariage_fix_back_plate_x = cariage_fix_x;
cariage_fix_back_plate_y = 5;
cariage_fix_back_plate_z = base_z;

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
    CARIAGE FIX
*/


module base_screw_remove_fixation(pos_x, pos_z) {
	screw_height = 20;
	screw_head_height = 3;

	fixation_offset_x = 8;
	fixation_offset_y = -(cariage_fix_back_plate_y / 2) + screw_head_height * 1;
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

module positioned_cariage_fix_screws() {
	base_screw_remove_fixation(+1, +1);
	base_screw_remove_fixation(-1, +1);
	base_screw_remove_fixation(+1, -1);
	base_screw_remove_fixation(-1, -1);
}
//positioned_cariage_fix_screws






module cariage_fix_screw(pos_x) {
	screw_x_offset = (rod_fix_x / 2) - (rod_fix_thickness_x / 2);
	color([1, 0, 0])
	translate([screw_x_offset * pos_x, 0, 0])
	union() {
		screw();
		
		nut_y = 20;
		nut_offset_z = -(cariage_fix_thickness_z / 2);
		translate([0, 0, nut_offset_z])
		cube([screws_nuts_side_min, nut_y, screw_nuts_height], center = true);
	}
	
}
// cariage_fix_screw

module cariage_fix_screw_remove() {
	cariage_fix_screw(+1);
	cariage_fix_screw(-1);
}
//cariage_fix_screw_remove

module cariage_fix_base_remove() {
	cariage_fix_base_remove_x = rod_fix_x + pieces_margin;
	cariage_fix_base_remove_y = (rod_fix_y + pieces_margin);
	cariage_fix_base_remove_z = 30;
	
	color([1, 0, 0])
	translate([0, 0, (cariage_fix_base_remove_z / 2)])
	union() {
		cube([cariage_fix_base_remove_x, cariage_fix_base_remove_y + 0.01, cariage_fix_base_remove_z], center = true);
		
		cariage_fix_base_remove_x_2 = rod_side + 2;
		translate([0, 0, rod_fix_thickness_z])
		cube([cariage_fix_base_remove_x_2, 30, cariage_fix_base_remove_z], center = true);
		
		
		cariage_fix_base_remove_cylinder_diameter = 7;
		cylinder (r=(cariage_fix_base_remove_cylinder_diameter / 2), h=60 , center=true);
	}
}
//cariage_fix_base_remove

module cariage_fix_base() {
	color([1, 1, 0, 0.7])
	translate([0, cariage_fix_y_offset, cariage_fix_z_offset])
	cube([cariage_fix_x, cariage_fix_y, cariage_fix_z], center = true);
}
//cariage_fix_base

module cariage_fix_back_plate() {
	
	
	
	cariage_fix_back_plate_y_offset = cariage_fix_y_offset + (cariage_fix_y / 2) + (cariage_fix_back_plate_y / 2);
	cariage_fix_back_plate_z_offset = (cariage_fix_back_plate_z / 2) - cariage_fix_thickness_z;
	
	translate([0, cariage_fix_back_plate_y_offset, cariage_fix_back_plate_z_offset])
	difference() {
		color([1, 1, 0, 0.7])
		cube([cariage_fix_back_plate_x, cariage_fix_back_plate_y + 0.01, cariage_fix_back_plate_z], center = true);
		
		positioned_cariage_fix_screws();
	}
}
//cariage_fix_back_plate


module positionned_cariage_fix_back_plate() {
	
	union() {
		
		translate([0, 0, cariage_fix_z_adjust - 0.01])
		cariage_fix_back_plate();
		
		
		
		cariage_fix_back_plate_remain_y = cariage_fix_back_plate_y - 2;
		cariage_fix_back_plate_remain_z = cariage_fix_z_adjust;
		
		cariage_fix_back_plate_remain_y_offset = cariage_fix_y_offset + (cariage_fix_y / 2) + (cariage_fix_back_plate_remain_y / 2);
		
		cariage_fix_back_plate_z_offset = (cariage_fix_back_plate_remain_z / 2) - cariage_fix_thickness_z;
		
		translate([0, cariage_fix_back_plate_remain_y_offset, cariage_fix_back_plate_z_offset])
		cube([cariage_fix_back_plate_x, cariage_fix_back_plate_remain_y + 0.01, cariage_fix_back_plate_remain_z], center = true);
	}
}
//positionned_cariage_fix_back_plate


module cariage_fix() {
	difference() {
		cariage_fix_base();
		cariage_fix_base_remove();
		cariage_fix_screw_remove();
	}
}
// cariage_fix


module _render() {
//	translate([0, 0, +17])
//	rod_fix();
	
	union() {
		cariage_fix();
		positionned_cariage_fix_back_plate();
	}
}


_render();











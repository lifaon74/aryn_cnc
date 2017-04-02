$fn=20;

include <../../XYZ/config.scad>

frame_rod_side = 20.4;
material_thickness = 4;

cable_chain_10x20_holder_frame_length = 16;

cable_chain_10x20_holder_frame_x = rod_side + (material_thickness * 2);
cable_chain_10x20_holder_frame_y = rod_side + cable_chain_10x20_holder_frame_length;
cable_chain_10x20_holder_frame_z = 7;

cable_chain_10x20_holder_frame_y_offset = cable_chain_10x20_holder_frame_length / 2;


cable_chain_10x20_holder_carriage_x = carriage_block_x;
cable_chain_10x20_holder_carriage_y = base_block_y;
cable_chain_10x20_holder_carriage_z = 6;

/*
    ROD FIX
*/

module positioned_frame_rod() {
	color([0.7, 0.7, 0.7])
	rotate([0, 90, 0])
	translate([0, -0.001, 0])
  cube([1000, frame_rod_side, frame_rod_side], center = true);
}
// positioned_frame_rod
//positioned_frame_rod();


module fix_screw_rod() {
	color([1, 0, 0])
	rotate([0, 90, 0])	
	screw();
}
// fix_screw_rod

module fix_screw_chain(pos_x) {
	positioned_screws_y_dist = 2.8; //2, 3.15
	
	positioned_screws_x_offset = 4;
	positioned_screws_y_offset = 7.5;
	positioned_screws_z_offset = -(screws_attach_length / 2) - 3;
	
	x_offset = positioned_screws_x_offset;
//	y_offset = (rod_side / 2) + positioned_screws_y_offset - positioned_screws_y_dist * pos_x;
	y_offset = positioned_screws_y_offset - positioned_screws_y_dist * pos_x;
	
	translate([x_offset * pos_x, y_offset, positioned_screws_z_offset])
	base_screw_remove_tighten();
}
// fix_screw_chain

module positioned_screws() {
	fix_screw_chain(+1);
	fix_screw_chain(-1);
}
// positioned_screws

module cable_chain_10x20_holder_frame_base() {
	color([0.7, 0.7, 0, 0.7])
	translate([0, cable_chain_10x20_holder_frame_y_offset, 0])
	cube([cable_chain_10x20_holder_frame_x, cable_chain_10x20_holder_frame_y, cable_chain_10x20_holder_frame_z], center = true);
}
// cable_chain_10x20_holder_base


module cable_chain_10x20_holder_carriage_base() {
	color([0.7, 0.7, 0, 0.7])
	cube([cable_chain_10x20_holder_carriage_x, cable_chain_10x20_holder_carriage_y, cable_chain_10x20_holder_carriage_z], center = true);
}
// cable_chain_10x20_holder_carriage_base


module cable_chain_10x20_holder_frame() {
	difference() {
		cable_chain_10x20_holder_frame_base();
		
		union() {
			positioned_rod();
			fix_screw_rod();
			translate([0, (rod_side / 2), (cable_chain_10x20_holder_frame_z / 2)])
			positioned_screws();
		}
	}
}
// cable_chain_10x20_holder


module carriage_cable_holder() {
	carriage_cable_holder_belt_y = 15;
	carriage_cable_holder_belt_z = cable_chain_10x20_holder_carriage_z;
	
	carriage_cable_holder_x = cable_chain_10x20_holder_carriage_x;
	carriage_cable_holder_y = 10;
	carriage_cable_holder_z = base_block_z + carriage_cable_holder_belt_z;
	carriage_cable_holder_material_thickness = 1;
	
	carriage_cable_holder_x_offset = 0;
	carriage_cable_holder_y_offset = (cable_chain_10x20_holder_carriage_y / 2) + (carriage_cable_holder_y / 2) + carriage_cable_holder_belt_y;
	carriage_cable_holder_z_offset = -(carriage_cable_holder_z / 2) + (carriage_cable_holder_belt_z / 2);
	
	
	translate([carriage_cable_holder_x_offset, carriage_cable_holder_y_offset - 0.002, carriage_cable_holder_z_offset])

	difference() {
		union() {
			translate([0, -(carriage_cable_holder_belt_y / 2) - (carriage_cable_holder_y / 2) + 0.001, (carriage_cable_holder_z / 2) - (carriage_cable_holder_belt_z / 2)])
			cube([carriage_cable_holder_x, carriage_cable_holder_belt_y, carriage_cable_holder_belt_z], center = true);
			
			cube([carriage_cable_holder_x, carriage_cable_holder_y, carriage_cable_holder_z], center = true);
		}
		
		cube([carriage_cable_holder_x - (carriage_cable_holder_material_thickness * 2), carriage_cable_holder_y  - (carriage_cable_holder_material_thickness * 2), carriage_cable_holder_z * 2], center = true);
	}
}
// carriage_cable_holder

module cable_chain_10x20_holder_carriage() {
	difference() {
		union() {
			cable_chain_10x20_holder_carriage_base();
			carriage_cable_holder();
		}
		
		carriage_block_fix(cable_chain_10x20_holder_carriage_z);
		
	rotate([0, 0, 90])
	mirror([-1, 0, 0])
	mirror([0, 0, -1])
	translate([0, 0, (cable_chain_10x20_holder_carriage_z / 2)])
	positioned_screws();
	}
}
// cable_chain_10x20_holder_carriage


//cable_chain_10x20_holder_frame();
cable_chain_10x20_holder_carriage();










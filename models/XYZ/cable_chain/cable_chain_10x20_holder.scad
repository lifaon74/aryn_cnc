$fn=20;

include <../../XYZ/config.scad>

rod_side = 20.4;
material_thickness = 4;

cable_chain_10x20_holder_frame_length = 16;

cable_chain_10x20_holder_frame_x = rod_side + (material_thickness * 2);
cable_chain_10x20_holder_frame_y = rod_side + cable_chain_10x20_holder_frame_length;
cable_chain_10x20_holder_frame_z = 7;

cable_chain_10x20_holder_frame_y_offset = cable_chain_10x20_holder_frame_length / 2;


cable_chain_10x20_holder_carriage_x = (rod_side * sqrt(2)) + (screw_virtual_holder_side * 2);
cable_chain_10x20_holder_carriage_y = base_block_y;
cable_chain_10x20_holder_carriage_z = 7;

/*
    ROD FIX
*/

module positioned_rod() {
	color([0.7, 0.7, 0.7])
	rotate([0, 90, 0])
	translate([0, -0.001, 0])
  cube([1000, rod_side, rod_side], center = true);
}
// positioned_rod
//positioned_rod();


module fix_screw_rod() {
	color([1, 0, 0])
	rotate([0, 90, 0])	
	screw();
}
// fix_screw_rod

module fix_screw_chain(pos_x) {
	positioned_screws_y_dist = 2;
	
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
	//	translate([0, base_block_y_offset, base_fix_block_z_offset])
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

module cable_chain_10x20_holder_carriage() {
	difference() {
		cable_chain_10x20_holder_carriage_base();
		carriage_block_fix(cable_chain_10x20_holder_carriage_z);
		
		
		mirror([0, 0, -1])
		translate([0, 0, (cable_chain_10x20_holder_carriage_z / 2)])
		positioned_screws();
	}
}
// cable_chain_10x20_holder_carriage

//cable_chain_10x20_holder_frame();
cable_chain_10x20_holder_carriage();










$fn=20;

include <../../XYZ/config.scad>

rod_side = 20.4;
material_thickness = 4;

cable_chain_10x20_holder_length = 16;

cable_chain_10x20_holder_x = rod_side + (material_thickness * 2);
cable_chain_10x20_holder_y = rod_side + cable_chain_10x20_holder_length;
cable_chain_10x20_holder_z = 7;

cable_chain_10x20_holder_y_offset = cable_chain_10x20_holder_length / 2;

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
	positioned_screws_z_offset = (cable_chain_10x20_holder_z / 2) - (screws_attach_length / 2) - 3;
	
	x_offset = positioned_screws_x_offset;
	y_offset = (rod_side / 2) + positioned_screws_y_offset - positioned_screws_y_dist * pos_x;
	
	translate([x_offset * pos_x, y_offset, positioned_screws_z_offset])
	base_screw_remove_tighten();
}
// fix_screw_chain

module positioned_screws() {
	fix_screw_chain(+1);
	fix_screw_chain(-1);
}
// positioned_screws


module cable_chain_10x20_holder_base() {
	color([0.7, 0.7, 0, 0.7])
	translate([0, cable_chain_10x20_holder_y_offset, 0])
	cube([cable_chain_10x20_holder_x, cable_chain_10x20_holder_y, cable_chain_10x20_holder_z], center = true);
}
// cable_chain_10x20_holder_base


module cable_chain_10x20_holder() {
	difference() {
		cable_chain_10x20_holder_base();
		
		union() {
			positioned_rod();
			fix_screw_rod();
			positioned_screws();
		}
	}
}
// cable_chain_10x20_holder

cable_chain_10x20_holder();










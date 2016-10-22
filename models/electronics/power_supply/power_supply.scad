$fn=20;

include <../../XYZ/config.scad>

rod_side = 20.4;
material_thickness = 4;
material_space = 0.5;

power_socket_x = 46.7 + material_space;
power_socket_y = 20;
power_socket_z = 27.3 + material_space;

power_socket_fix_margin = 1;
power_socket_fix_x_1 = 8;
power_socket_fix_x_border_1 = 3; // distance between border of part and fix 
power_socket_fix_x_2 = 5;
power_socket_fix_x_border_2 = 10;
power_socket_fix_y = 0.8;
power_socket_fix_z = 1;

power_socket_extra_border = 4;

power_socket_base_x = power_socket_x + (power_socket_extra_border * 2);
power_socket_base_y = material_thickness;
power_socket_base_z = rod_side + power_socket_z + (power_socket_extra_border * 2);

power_socket_base_y_offset = -(rod_side / 2) - (power_socket_base_y / 2);
power_socket_base_z_offset = (power_socket_base_z / 2) - (rod_side / 2);

power_socket_y_offset = (power_socket_y / 2) - (rod_side / 2) - material_thickness - 0.01;
power_socket_z_offset = (rod_side / 2) + (power_socket_z / 2) + power_socket_extra_border;

/*
    ROD FIX
*/

module positioned_rod() {
	color([0.7, 0.7, 0.7])
    cube([1000, rod_side, rod_side], center = true);
}
// positioned_rod
//positioned_rod();


module fix_screw(pos_x) {
	screw_x_offset = (power_socket_base_x / 2) - 10;
	color([1, 0, 0])
	translate([screw_x_offset * pos_x, 0, 0])
	rotate([90, 0, 0])
	screw();
}
// fix_screw

module positioned_screws() {
	fix_screw(+1);
	fix_screw(-1);
}
// positioned_screws


module power_socket_piece() {
	union() {
		color([0, 0, 0])
		cube([power_socket_x, power_socket_y, power_socket_z], center = true);
		
		
		power_socket_fix_x_offset_1 = (power_socket_x / 2) - (power_socket_fix_x_1 / 2) - power_socket_fix_x_border_1;
		
		power_socket_fix_x_offset_2 = (power_socket_x / 2) - (power_socket_fix_x_2 / 2) - power_socket_fix_x_border_2;
		
		power_socket_fix_z_offset = (power_socket_z / 2) + (power_socket_fix_z / 2); 
		
		color([1, 0, 0])
		translate([0, power_socket_fix_y, 0])
		union() {
			translate([power_socket_fix_x_offset_1, 0, power_socket_fix_z_offset - 0.01])
			cube([power_socket_fix_x_1 + (2 * power_socket_fix_margin), power_socket_y, power_socket_fix_z], center = true);
		

			translate([-power_socket_fix_x_offset_2, 0, power_socket_fix_z_offset - 0.01])
			cube([power_socket_fix_x_2 + (2 * power_socket_fix_margin), power_socket_y, power_socket_fix_z], center = true);
			
			
			translate([power_socket_fix_x_offset_1, 0, -power_socket_fix_z_offset + 0.01])
			cube([power_socket_fix_x_1 + (2 * power_socket_fix_margin), power_socket_y, power_socket_fix_z], center = true);
		

			translate([-power_socket_fix_x_offset_2, 0, -power_socket_fix_z_offset + 0.01])
			cube([power_socket_fix_x_2 + (2 * power_socket_fix_margin), power_socket_y, power_socket_fix_z], center = true);
		}
	}
}
// power_socket_piece


module power_socket_base() {
	color([0.7, 0.7, 0])
	translate([0, power_socket_base_y_offset, power_socket_base_z_offset])
	cube([power_socket_base_x, power_socket_base_y, power_socket_base_z], center = true);
}
// power_socket_base

module power_socket() {
	difference() {
		power_socket_base();
		
		translate([0, power_socket_y_offset, power_socket_z_offset])
		power_socket_piece();
		
		positioned_screws();
	}
}
// power_socket



power_socket();











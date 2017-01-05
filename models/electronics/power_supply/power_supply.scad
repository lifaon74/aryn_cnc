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
power_socket_base_z = 85;

power_socket_base_y_offset = -(rod_side / 2) - (power_socket_base_y / 2);
power_socket_base_z_offset = (power_socket_base_z / 2) - (rod_side / 2);

power_socket_y_offset = (power_socket_y / 2) - (rod_side / 2) - material_thickness - 0.01;
power_socket_z_offset = (power_socket_base_z / 2) - (rod_side / 2);

/*
    ROD FIX
*/

module positioned_rod() {
	color([0.7, 0.7, 0.7])
  cube([1000, rod_side, rod_side], center = true);
	
	color([0.7, 0.7, 0.7])
	translate([0, 0, 65])
	cube([1000, rod_side, rod_side], center = true);
}
// positioned_rod
//positioned_rod();


module fix_screw(pos_x, pos_z) {
	screw_x_offset = (power_socket_base_x / 2) - (rod_side / 2);
	screw_z_offset = power_socket_base_z - rod_side;
	
	color([1, 0, 0])
	translate([screw_x_offset * pos_x, 0, screw_z_offset * pos_z])
	rotate([90, 0, 0])	
	screw();
}
// fix_screw

module positioned_screws() {
	fix_screw(+1, 0);
	fix_screw(-1, 0);
	fix_screw(+1, +1);
	fix_screw(-1, +1);
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

washer_diameter = 8;
screw_m3_diameter = 3;
screw_m4_diameter = 4;

power_supply_x = 114;
power_supply_y = 215;
power_supply_z = 50;

power_supply_hole_z_offset = 12;
power_supply_screw_z_margin = 3;

power_supply_base_x = power_supply_x + (material_thickness * 2);
power_supply_base_y = 16;
power_supply_base_z = material_thickness + power_supply_screw_z_margin + (power_supply_hole_z_offset * 2);

power_supply_base_z_offset = (power_supply_base_z / 2) - material_thickness - power_supply_screw_z_margin;


module screw_m4() {
	screw_height = 50;
	cylinder (r=(screw_m4_diameter / 2), h=screw_height , center=true);
	cylinder (r=((screw_m4_diameter + 1) / 2), h=2 , center=true);
}
// screw_m4

module power_supply_piece_fix_holes() {
	translate([(power_supply_base_x / 2), 0, power_supply_hole_z_offset])
	rotate([0, 90, 0])
	screw_m4();
	
	translate([-(power_supply_base_x / 2), 0, power_supply_hole_z_offset])
	rotate([0, 90, 0])
	screw_m4();
}
// power_supply_piece_fix_holes


module power_supply_piece_fix_rod() {
	power_supply_piece_fix_rod_z = 20;
	
	union() {
		cube([(power_supply_x - washer_diameter), screw_m3_diameter, power_supply_piece_fix_rod_z], center = true);
		
		cube([power_supply_x, washer_diameter, (power_supply_screw_z_margin * 2)], center = true);
	}
}
// power_supply_piece_fix_rod

module power_supply_piece() {
	
	color([0.5, 0.5, 0.5])
	translate([0, 0, (power_supply_z / 2)])
	cube([power_supply_x, power_supply_y, power_supply_z], center = true);
}
// power_socket_piece


module power_supply_base() {
	
	color([0.7, 0.7, 0])
	translate([0, 0, power_supply_base_z_offset])
	cube([power_supply_base_x, power_supply_base_y, power_supply_base_z], center = true);
}
//power_supply_base


power_strip_base_x = 10;
power_strip_base_y = material_thickness + rod_side;
power_strip_base_z = (material_thickness * 2) + rod_side;
power_strip_base_y_offset = material_thickness / 2;

module power_strip_screws() {
	screw();
	rotate([90, 0, 0])
	screw();
}
// power_strip_screws


module power_strip_base() {
	
	color([0.7, 0.7, 0])
	translate([0, power_strip_base_y_offset + 0.001, 0])
	cube([power_strip_base_x, power_strip_base_y, power_strip_base_z], center = true);
}
//power_supply_base


module power_supply() {
	difference() {
		power_supply_base();
		
		power_supply_piece();
		power_supply_piece_fix_holes();
		power_supply_piece_fix_rod();
	}
}
// power_supply

module power_strip() {
	difference() {
		power_strip_base();
		
		positioned_rod();
		power_strip_screws();
	}
}
// power_strip


//power_socket();
//power_supply();
power_strip();









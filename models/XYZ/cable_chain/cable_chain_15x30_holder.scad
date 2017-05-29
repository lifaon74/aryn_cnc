$fn=20;

include <../../XYZ/config.scad>

frame_rod_side = 20.4;
material_thickness = 4;


cable_chain_15x30_holder_frame_x = 22;
cable_chain_15x30_holder_frame_y = frame_rod_side + (material_thickness * 2);
cable_chain_15x30_holder_frame_z = frame_rod_side + material_thickness;

cable_chain_15x30_holder_frame_z_offset = material_thickness / 2;

cable_chain_15x30_fix_base_x = 20;
cable_chain_15x30_fix_base_y = 7;
cable_chain_15x30_fix_base_z = 38;

cable_chain_15x30_fix_base_y_offset = 7;
cable_chain_15x30_fix_base_z_offset = (cable_chain_15x30_fix_base_z / 2) + (cable_chain_15x30_holder_frame_z / 2) + cable_chain_15x30_holder_frame_z_offset;


cable_chain_15x30_holder_carriage_x = carriage_block_x;
cable_chain_15x30_holder_carriage_y = base_block_y;
cable_chain_15x30_holder_carriage_z = 6;

cable_chain_15x30_holder_carriage_tower_x = 20;
cable_chain_15x30_holder_carriage_tower_y = 20;
cable_chain_15x30_holder_carriage_tower_z = 60;

cable_chain_15x30_holder_carriage_attach_x_offset = (rod_horizontal_spacing / 2);
cable_chain_15x30_holder_carriage_attach_z = (cable_chain_15x30_holder_carriage_z / 2) + cable_chain_15x30_holder_carriage_tower_z;

cable_chain_15x30_holder_carriage_bridge_x = rod_horizontal_spacing + cable_chain_15x30_holder_carriage_tower_x;
cable_chain_15x30_holder_carriage_bridge_y = cable_chain_15x30_holder_carriage_tower_y;
cable_chain_15x30_holder_carriage_bridge_z = 4;



cable_chain_15x30_holder_carriage_bridge_z_offset = cable_chain_15x30_holder_carriage_attach_z + (cable_chain_15x30_holder_carriage_bridge_z / 2);
	
/*
    ROD FIX
*/

module positioned_frame_rod() {
	color([0.7, 0.7, 0.7])
	translate([0, -0.001, 0])
  cube([1000, frame_rod_side, frame_rod_side], center = true);
}
// positioned_frame_rod
//positioned_frame_rod();


module fix_screw_rod() {
	color([1, 0, 0])
	rotate([90, 0, 0])	
	screw();
}
// fix_screw_rod
//fix_screw_rod();

module fix_screw_chain() {
	positioned_screws_z_dist = 16;
	
	translate([0, -(screws_attach_length / 2), +(positioned_screws_z_dist / 2)])
	rotate([90, 0, 0])
	base_screw_remove_tighten();
	
	translate([0, -(screws_attach_length / 2), -(positioned_screws_z_dist / 2)])
	rotate([90, 0, 0])
	base_screw_remove_tighten();
}
// fix_screw_chain




module cable_chain_15x30_holder_frame_base() {
	color([0.7, 0.7, 0, 0.7])
	translate([0, 0, cable_chain_15x30_holder_frame_z_offset + 0.01])
	cube([cable_chain_15x30_holder_frame_x, cable_chain_15x30_holder_frame_y, cable_chain_15x30_holder_frame_z], center = true);
}
// cable_chain_15x30_holder_base

module cable_chain_15x30_fix_base() {
	color([0.7, 0.7, 0, 0.7])
	cube([cable_chain_15x30_fix_base_x, cable_chain_15x30_fix_base_y, cable_chain_15x30_fix_base_z], center = true);
}
// cable_chain_15x30_fix_base

module cable_chain_15x30_fix() {
	translate([0, cable_chain_15x30_fix_base_y_offset, cable_chain_15x30_fix_base_z_offset])
	rotate([0, 0, -20])
	difference() {
		cable_chain_15x30_fix_base();
		fix_screw_chain();
	}
}
// cable_chain_15x30_fix



module cable_chain_15x30_holder_carriage_base() {
	color([0.7, 0.7, 0, 0.7])
	cube([cable_chain_15x30_holder_carriage_x, cable_chain_15x30_holder_carriage_y, cable_chain_15x30_holder_carriage_z], center = true);
}
// cable_chain_15x30_holder_carriage_base

module cable_chain_15x30_holder_carriage_tower() {
	cable_chain_15x30_holder_carriage_tower_z_offset = (cable_chain_15x30_holder_carriage_z / 2) + (cable_chain_15x30_holder_carriage_tower_z / 2);
	
	color([0.7, 0.7, 0, 0.7])
	translate([0, 0, cable_chain_15x30_holder_carriage_tower_z_offset - 0.001])
	cube([cable_chain_15x30_holder_carriage_tower_x, cable_chain_15x30_holder_carriage_tower_y, cable_chain_15x30_holder_carriage_tower_z], center = true);
}
// cable_chain_15x30_holder_carriage_tower

module cable_chain_15x30_holder_carriage_bridge_base() {
	color([0.7, 0.7, 0, 0.7])
	cube([cable_chain_15x30_holder_carriage_bridge_x, cable_chain_15x30_holder_carriage_bridge_y, cable_chain_15x30_holder_carriage_bridge_z], center = true);
}
// cable_chain_15x30_holder_carriage_bridge_base

module cable_chain_15x30_holder_carriage_bridge() {
	cable_chain_15x30_holder_carriage_bridge_base();
}
// cable_chain_15x30_holder_carriage_bridge


module cable_chain_15x30_holder_carriage_attach_fix() {
	nut_y = 50;
	screw_height = 50;
	
	union() {
		translate([0, (nut_y / 2) - (screws_nuts_side_max / 2) - 1, 0])
		cube([screws_nuts_side_min, nut_y, screw_nuts_height], center = true);
		
		cylinder (r=(screw_diameter / 2), h=screw_height , center=true);
	}
}
// cable_chain_15x30_holder_carriage_attach_fix

module cable_chain_15x30_holder_carriage_attach() {
	difference() {
		union() {
			cable_chain_15x30_holder_carriage_base();
			cable_chain_15x30_holder_carriage_tower();
		}
		
		carriage_block_fix(cable_chain_15x30_holder_carriage_z);
		
		// top fix
		translate([0, 0, cable_chain_15x30_holder_carriage_attach_z - 5])
		cable_chain_15x30_holder_carriage_attach_fix();
		
		cable_chain_15x30_holder_carriage_attach_fix_top_z_offet = (cable_chain_15x30_holder_carriage_z / 2) + (screws_nuts_side_min / 2);
		
		// bottom fix
		translate([0, 0, cable_chain_15x30_holder_carriage_attach_fix_top_z_offet + 0.01])
		rotate([0, 90, 0])
			cable_chain_15x30_holder_carriage_attach_fix();
	}
}
// cable_chain_15x30_holder_carriage_attach

module cable_chain_15x30_holder_frame() {
	difference() {
		union() {
			cable_chain_15x30_holder_frame_base();
			cable_chain_15x30_fix();
		}
		
		union() {
			positioned_frame_rod();
			fix_screw_rod();
		}
	}
}
// cable_chain_15x30_holder_frame

module cable_chain_15x30_holder_carriage() {
	union() {
		translate([+cable_chain_15x30_holder_carriage_attach_x_offset, 0, 0])
		cable_chain_15x30_holder_carriage_attach();
		
		translate([-cable_chain_15x30_holder_carriage_attach_x_offset, 0, 0])
		cable_chain_15x30_holder_carriage_attach();
		
		
		translate([0, 0, cable_chain_15x30_holder_carriage_bridge_z_offset + 10])
		cable_chain_15x30_holder_carriage_bridge();
	}
}
// cable_chain_10x20_holder_carriage

//cable_chain_15x30_holder_frame();
cable_chain_15x30_holder_carriage_attach();
//cable_chain_15x30_holder_carriage_bridge();

//cable_chain_15x30_holder_carriage();










$fn=20;

include <../../XYZ/config.scad>

total_height = 75;

frame_rod_side = 20.4;
material_thickness = 4;
material_thickness_v2 = 7;

cable_chain_15x30_holder_frame_v1_x = 22;
cable_chain_15x30_holder_frame_v1_y = frame_rod_side + (material_thickness * 2);
cable_chain_15x30_holder_frame_v1_z = frame_rod_side + material_thickness;

cable_chain_15x30_holder_frame_v1_z_offset = material_thickness / 2;

cable_chain_15x30_fix_base_rotation = 10;
cable_chain_15x30_fix_base_x = 20;
cable_chain_15x30_fix_base_y = 7;
cable_chain_15x30_fix_base_z = 38 + 0.5;

cable_chain_15x30_fix_frame_base_v1_y_offset = 9;
cable_chain_15x30_fix_frame_base_v1_z_offset = (cable_chain_15x30_fix_base_z / 2) + (cable_chain_15x30_holder_frame_v1_z / 2) + cable_chain_15x30_holder_frame_v1_z_offset;


cable_chain_15x30_holder_carriage_x = carriage_block_x;
cable_chain_15x30_holder_carriage_y = base_block_y;
cable_chain_15x30_holder_carriage_z = 6;

cable_chain_15x30_holder_carriage_tower_x = 20;
cable_chain_15x30_holder_carriage_tower_y = 30;
cable_chain_15x30_holder_carriage_tower_z = total_height - cable_chain_15x30_holder_carriage_z - material_thickness_v2 - 1;


cable_chain_15x30_holder_carriage_attach_x_offset = (rod_horizontal_spacing / 2);
cable_chain_15x30_holder_carriage_attach_z = (cable_chain_15x30_holder_carriage_z / 2) + cable_chain_15x30_holder_carriage_tower_z;

cable_chain_15x30_holder_carriage_bridge_x = rod_horizontal_spacing + cable_chain_15x30_holder_carriage_tower_x;
cable_chain_15x30_holder_carriage_bridge_y = cable_chain_15x30_holder_carriage_tower_y;
cable_chain_15x30_holder_carriage_bridge_z = material_thickness_v2;

cable_chain_15x30_holder_carriage_bridge_z_offset = cable_chain_15x30_holder_carriage_attach_z + (cable_chain_15x30_holder_carriage_bridge_z / 2);
	
cable_chain_15x30_fix_bridge_base_y_offset = (cable_chain_15x30_holder_carriage_bridge_y / 2) - (cable_chain_15x30_fix_base_y / 2);
cable_chain_15x30_fix_bridge_base_z_offset = (cable_chain_15x30_fix_base_z / 2) + (cable_chain_15x30_holder_carriage_bridge_z / 2);



cable_chain_15x30_holder_frame_v2_x = 70;
cable_chain_15x30_holder_frame_v2_y = frame_rod_side + (material_thickness_v2 * 2);
cable_chain_15x30_holder_frame_v2_z = material_thickness_v2;

cable_chain_15x30_fix_frame_base_v2_y_offset = 12;
cable_chain_15x30_fix_frame_base_v2_z_offset = (cable_chain_15x30_fix_base_z / 2) + (cable_chain_15x30_holder_frame_v2_z / 2);

cable_chain_15x30_fix_frame_base_v2_screw_x_offset = (cable_chain_15x30_holder_frame_v2_x / 2) - 10;
cable_chain_15x30_fix_frame_base_v2_screw_z_offset = -(cable_chain_15x30_holder_frame_v2_z / 2) + material_thickness;


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

module screw_and_head(screw_height) {
	screw_head_diameter = 8;
	
	color([1, 0, 0, 0.7])
	union() {
		translate([0, 0, -(screw_height / 2)])
		cylinder (r=(screw_diameter / 2), h=screw_height , center=true);
		translate([0, 0, (screw_height / 2) - 0.01])
		cylinder (r=(screw_head_diameter / 2), h=screw_height , center=true);
	}
}
// screw_and_head



module cable_chain_15x30_fix_base() {
	color([0.7, 0.7, 0, 0.7])
	cube([cable_chain_15x30_fix_base_x, cable_chain_15x30_fix_base_y, cable_chain_15x30_fix_base_z], center = true);
}
// cable_chain_15x30_fix_base

module cable_chain_15x30_fix_frame() {
	rotate([0, 0, -cable_chain_15x30_fix_base_rotation])
	difference() {
		cable_chain_15x30_fix_base();
		fix_screw_chain();
	}
}
// cable_chain_15x30_fix_frame



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


module cable_chain_15x30_fix_bridge() {
	translate([0, cable_chain_15x30_fix_bridge_base_y_offset, cable_chain_15x30_fix_bridge_base_z_offset - 0.001])
	difference() {
		cable_chain_15x30_fix_base();
		fix_screw_chain();
	}
}
// cable_chain_15x30_fix_bridge

module cable_chain_15x30_holder_carriage_bridge_base() {
	color([0.7, 0.7, 0, 0.7])
	cube([cable_chain_15x30_holder_carriage_bridge_x, cable_chain_15x30_holder_carriage_bridge_y, cable_chain_15x30_holder_carriage_bridge_z], center = true);
}
// cable_chain_15x30_holder_carriage_bridge_base

module cable_chain_15x30_holder_carriage_bridge() {
	difference() {
		union() {
			cable_chain_15x30_holder_carriage_bridge_base();
			cable_chain_15x30_fix_bridge();
		}
		
		cable_chain_15x30_holder_carriage_bridge_screw_z_offset = -(cable_chain_15x30_holder_carriage_bridge_z / 2) + material_thickness;
		
		translate([+cable_chain_15x30_holder_carriage_attach_x_offset, 0, cable_chain_15x30_holder_carriage_bridge_screw_z_offset])
		screw_and_head(20);
		
		translate([-cable_chain_15x30_holder_carriage_attach_x_offset, 0, cable_chain_15x30_holder_carriage_bridge_screw_z_offset])
		screw_and_head(20);
	}
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




module cable_chain_15x30_holder_frame_v1_base() {
	color([0.7, 0.7, 0, 0.7])
	translate([0, 0, cable_chain_15x30_holder_frame_v1_z_offset + 0.01])
	cube([cable_chain_15x30_holder_frame_v1_x, cable_chain_15x30_holder_frame_v1_y, cable_chain_15x30_holder_frame_v1_z], center = true);
}
// cable_chain_15x30_holder_frame_v1_base

module cable_chain_15x30_holder_frame_v1() {
	difference() {
		union() {
			cable_chain_15x30_holder_frame_v1_base();
			
			translate([0, cable_chain_15x30_fix_frame_base_v1_y_offset, cable_chain_15x30_fix_frame_base_v1_z_offset])
			cable_chain_15x30_fix_frame();
		}
		
		union() {
			positioned_frame_rod();
			fix_screw_rod();
		}
	}
}
// cable_chain_15x30_holder_frame_v1




module cable_chain_15x30_holder_frame_v2_base() {
	color([0.7, 0.7, 0, 0.7])
//	translate([0, 0, cable_chain_15x30_holder_frame_v1_z_offset + 0.01])
	cube([cable_chain_15x30_holder_frame_v2_x, cable_chain_15x30_holder_frame_v2_y, cable_chain_15x30_holder_frame_v2_z], center = true);
}
// cable_chain_15x30_holder_frame_v2_base


module cable_chain_15x30_holder_frame_v2() {
	difference() {
		union() {
			cable_chain_15x30_holder_frame_v2_base();
			
			translate([0, cable_chain_15x30_fix_frame_base_v2_y_offset, cable_chain_15x30_fix_frame_base_v2_z_offset - 0.001])
			cable_chain_15x30_fix_frame();
		}
		
		translate([0, 0, cable_chain_15x30_fix_frame_base_v2_screw_z_offset])
		union() {
			translate([+cable_chain_15x30_fix_frame_base_v2_screw_x_offset, 0, 0])
			screw_and_head(10);
			
			translate([-cable_chain_15x30_fix_frame_base_v2_screw_x_offset, 0, 0])
			screw_and_head(10);
		}
	}
}
// cable_chain_15x30_holder_frame_v2



//cable_chain_15x30_holder_frame_v1();
//cable_chain_15x30_holder_frame_v2();
//cable_chain_15x30_holder_carriage_attach();
cable_chain_15x30_holder_carriage_bridge();

//cable_chain_15x30_holder_carriage();










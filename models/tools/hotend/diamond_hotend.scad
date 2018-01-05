include <../tool_base.scad>
include <../diamond_hotend.scad>

$fn=100;

diamond_hot_end_radiator_air_flow_x = 31.4;
diamond_hot_end_radiator_air_flow_y = e3d_v6_radiator_diameter + e3d_v6_radiator_diameter_margin * 2;
diamond_hot_end_radiator_air_flow_z = 70; // 43.1

diamond_hot_end_piramidal_base_radius_top = 44;
diamond_hot_end_piramidal_base_radius_bottom = 22;
diamond_hot_end_piramidal_base_z = 40;
	
	
diamond_hot_end_y_offet = 8;
diamond_hot_end_z_offet = -42.5;

diamond_hot_end_top_cover_base_z = 10;
diamond_hot_end_top_cover_base_radius = 54;
diamond_hot_end_top_cover_base_angle_grind_size = 12;
diamond_hot_end_top_cover_pipe_out_diameter = 12;
diamond_hot_end_top_cover_pipe_out_insert_size = 8;

diamond_hot_end_top_cover_wire_hole_diameter = 10;

fan_40x40_diameter = 36;
fan_40x40_z = 13;


diamond_hot_end_fan_air_flow_out_x = 20;
diamond_hot_end_fan_air_flow_out_y = 15;
diamond_hot_end_fan_air_flow_out_z_offset = -1.5;
diamond_hot_end_fan_air_flow_out_margin = 0.1;
diamond_hot_end_fan_air_flow_in_margin = 1.2;


diamond_hot_end_fan_fix_screw_0_x = 51.3 - (4.5 / 2) - 1;
diamond_hot_end_fan_fix_screw_0_z = 25.4 - 18;

diamond_hot_end_fan_fix_screw_1_x = diamond_hot_end_fan_fix_screw_0_x - 20 - 23;

diamond_hot_end_fan_fix_screw_1_z = diamond_hot_end_fan_fix_screw_0_z + 18 + 20;

diamond_hot_end_fan_holder_y = 2;
diamond_hot_end_fan_holder_z = 8;
diamond_hot_end_fan_holder_feet_x_offset = (diamond_hot_end_fan_air_flow_out_x / 2);
diamond_hot_end_fan_holder_feet_z = 40;


diamond_hot_end_bltouch_x = 18 + 2 * 4;
diamond_hot_end_bltouch_y = 11.53;
diamond_hot_end_bltouch_wire_x = 12;
diamond_hot_end_bltouch_wire_y = 3;

diamond_hot_end_bltouch_holder_z = 7;
diamond_hot_end_bltouch_holder_margin = 0.1;

diamond_hot_end_bltouch_fix_top_x_border = 7;
diamond_hot_end_bltouch_fix_top_x_top = diamond_hot_end_bltouch_x + diamond_hot_end_bltouch_fix_top_x_border * 2;
diamond_hot_end_bltouch_fix_top_y = diamond_hot_end_bltouch_y;
diamond_hot_end_bltouch_fix_top_z_bottom = 4;
diamond_hot_end_bltouch_fix_top_z_top = 1;
diamond_hot_end_bltouch_fix_top_margin = 0.1;






module diamond_hot_end_genuine() {
	color([1, 0, 1])
	translate([-30, 0, 63])
	import("../models/diamond_hotend_base.stl");
}
// diamond_hot_end_genuine

module diamond_hot_end_genuine_positionned() {
	translate([0, diamond_hot_end_y_offet, diamond_hot_end_z_offet/* - 0.5*/])
	rotate([0, 0, 30])
	diamond_hot_end_genuine();
}
// diamond_hot_end_genuine_positionned


module radial_fan_genuine() {
	color([0.1, 0.1, 0.1])
	translate([-0.1701575, 0, -3.30])
	rotate([90, -0.9, 0])
	import("../models/radial_fan_50mm.stl");
}
// radial_fan_genuine

module radial_fan_genuine_positionned() {
	translate([-29.5, -26.5, (base_block_z / 2)])
	rotate([0, 0, 120])
	radial_fan_genuine();
}
// radial_fan_genuine_positionned

module diamond_hot_end_bltouch_genuine() {
	color([0, 1, 0])
//	translate([-0.1701575, 0, -3.30])
	rotate([180, 0, 0])
	import("../models/bltouch.stl");
}
// diamond_hot_end_bltouch_genuine

module diamond_hot_end_bltouch_genuine_positionned() {
	translate([26.5, -14.5, diamond_hot_end_z_offet + 42])
	rotate([0, 0, -120])
	diamond_hot_end_bltouch_genuine();
}
// diamond_hot_end_bltouch_genuine_positionned

module diamond_hot_end_bed_positionned() {
	color([1, 0, 0, 0.5])
	translate([0, 0, diamond_hot_end_z_offet - 1])
	cube([100, 100, 2], center = true);
}
// diamond_hot_end_bed_positionned

module fan_40x40(mode = "default") {
	if(mode == "remove") {
		union() {
			color([0.1, 0.1, 0.1])
			cube([40, 40, fan_40x40_z], center = true);
			
			union() {
				_offset = 16;
				for(x = [-1 : 2 : 1]) {
					for(y = [-1 : 2 : 1]) {
						translate([_offset * x, _offset * y, -(fan_40x40_z / 2) - 3])
						rotate([0, 0, atan(x / y) + 90 * x])
						base_screws_remove_fixation();
					}
				}
				
				cylinder(h=50, r=fan_40x40_diameter / 2, center=true);
			}
		}
	} else {
		difference() {
			color([0.1, 0.1, 0.1])
			cube([40, 40, fan_40x40_z], center = true);
			
			union() {
				_offset = 17;
				for(x = [-1 : 2 : 1]) {
					for(y = [-1 : 2 : 1]) {
						translate([_offset * x, _offset * y, -(fan_40x40_z / 2) - 3])
						rotate([0, 0, atan(x / y) + 90 * x])
						base_screws_remove_fixation();
					}
				}
				
				cylinder(h=50, r=fan_40x40_diameter / 2, center=true);
			}
		}
	}
}
// fan_40x40
//fan_40x40();





module diamond_hot_end_radiator_air_flow_base() {
	
	color([1, 0, 0])
	translate([19.8 + e3d_v6_radiator_diameter_margin, 0, (diamond_hot_end_radiator_air_flow_z / 2)])
	
	difference() {
		cube([diamond_hot_end_radiator_air_flow_x,diamond_hot_end_radiator_air_flow_y, diamond_hot_end_radiator_air_flow_z], center = true);
		
		diamond_hot_end_radiator_air_flow_base_break_corder_side = 7;
		
		offset_x = (diamond_hot_end_radiator_air_flow_x / 2);
		offset_y = (diamond_hot_end_radiator_air_flow_y / 2);
		
		union() {
			for(y = [-1 : 2 : 1]) {
				translate([offset_x, offset_y * y, 0])
				rotate([0, 0, 45])
				cube([diamond_hot_end_radiator_air_flow_base_break_corder_side, diamond_hot_end_radiator_air_flow_base_break_corder_side, diamond_hot_end_radiator_air_flow_z + 1], center = true);
			}
		}
	}
	
}
// diamond_hot_end_radiator_air_flow_base

module diamond_hot_end_radiator_air_flow_base_all() {
	for(a = [0 : 1 : 2]) {
		rotate([0, 0, 120 * a])
		diamond_hot_end_radiator_air_flow_base();
	}
}
// diamond_hot_end_radiator_air_flow_base_all

module diamond_hot_end_piramidal_base() {
	union() {
		difference() {
			cylinder($fn=3, h=diamond_hot_end_piramidal_base_z, r1=diamond_hot_end_piramidal_base_radius_bottom, r2=diamond_hot_end_piramidal_base_radius_top, center=true);
			
			width = (diamond_hot_end_piramidal_base_radius_top - diamond_hot_end_piramidal_base_radius_bottom);
			angle = atan(width / diamond_hot_end_piramidal_base_z);
			median_width = (diamond_hot_end_piramidal_base_radius_top + diamond_hot_end_piramidal_base_radius_bottom) / 2;
			

			union() {
			//	color([1, 1, 0, 0.5])
				for(a = [0 : 1 : 2]) {
					rotate([0, 0, 60 + 120 * a])
					translate([-median_width, 0, 0])
					rotate([0, -angle, 0])
					cube([20, 20, diamond_hot_end_piramidal_base_z * 2], center = true);
				}
			}
		}
		
		cylinder (r=15, h=diamond_hot_end_piramidal_base_z * 2 , center=true);
	}
}
// diamond_hot_end_piramidal_base
//diamond_hot_end_piramidal_base();



module diamond_hot_end_fan_air_flow() {
	height = base_block_z * 2;
	
	translate([(diamond_hot_end_fan_air_flow_out_x / 2), -(diamond_hot_end_fan_air_flow_out_y / 2), 0])
	union() {
		translate([0, 0, (height / 2) - 0.01])
		cube([diamond_hot_end_fan_air_flow_out_x + (diamond_hot_end_fan_air_flow_out_margin * 2), diamond_hot_end_fan_air_flow_out_y + (diamond_hot_end_fan_air_flow_out_margin * 2), height], center = true);
		
		translate([0, 0, -(height / 2)])
		cube([diamond_hot_end_fan_air_flow_out_x - (diamond_hot_end_fan_air_flow_in_margin * 2), diamond_hot_end_fan_air_flow_out_y - (diamond_hot_end_fan_air_flow_in_margin * 2), height], center = true);
	}
}
// diamond_hot_end_fan_air_flow

module diamond_hot_end_fan_air_flow_fix_remove() {
		for(x = [-1 : 2 : 1]) {
			_x = diamond_hot_end_fan_air_flow_out_x - (diamond_hot_end_fan_air_flow_in_margin * 2) + 7 + 2;
	
			translate([(_x / 2) * x + (diamond_hot_end_fan_air_flow_out_x / 2), -(diamond_hot_end_fan_air_flow_out_y / 2), -base_block_z - diamond_hot_end_fan_air_flow_out_z_offset + 3])
			rotate([180, 0, -90 * x])
			base_screws_remove_fixation(20);
		}
}
// diamond_hot_end_fan_air_flow_fix_remove

module diamond_hot_end_fan_fix_screw() {
	translate([diamond_hot_end_fan_fix_screw_0_x, 0, diamond_hot_end_fan_fix_screw_0_z])
	rotate([90, 0, 0])
	screw();
	
	translate([diamond_hot_end_fan_fix_screw_1_x, 0, diamond_hot_end_fan_fix_screw_1_z])
	rotate([90, 0, 0])
	screw();
}
// diamond_hot_end_fan_fix_screw

module diamond_hot_end_fan_holder_base() {
	dx = diamond_hot_end_fan_fix_screw_0_x - diamond_hot_end_fan_fix_screw_1_x;
	
	dz = diamond_hot_end_fan_fix_screw_0_z - diamond_hot_end_fan_fix_screw_1_z;
	
	diamond_hot_end_fan_holder_x = sqrt(dx * dx + dz * dz);
	
	
	angle = -atan(dz / dx);
	
	union() {
		translate([((diamond_hot_end_fan_fix_screw_0_x + diamond_hot_end_fan_fix_screw_1_x) / 2), 0, ((diamond_hot_end_fan_fix_screw_0_z + diamond_hot_end_fan_fix_screw_1_z) / 2)])
		rotate([0, angle, 0])
		cube([diamond_hot_end_fan_holder_x, diamond_hot_end_fan_holder_y, diamond_hot_end_fan_holder_z], center = true);
		
		translate([diamond_hot_end_fan_fix_screw_0_x, 0, diamond_hot_end_fan_fix_screw_0_z])
		rotate([90, 0, 0])
		cylinder (r=(diamond_hot_end_fan_holder_z / 2), h=diamond_hot_end_fan_holder_y , center=true);
		
		translate([diamond_hot_end_fan_fix_screw_1_x, 0, diamond_hot_end_fan_fix_screw_1_z])
		rotate([90, 0, 0])
		cylinder (r=(diamond_hot_end_fan_holder_z / 2), h=diamond_hot_end_fan_holder_y , center=true);
	}
}
// diamond_hot_end_fan_holder_base

module diamond_hot_end_fan_holder_feet(mode = "default") {
	if(mode == "default") {
		translate([diamond_hot_end_fan_holder_feet_x_offset, 0, (diamond_hot_end_fan_holder_feet_z / 2) - diamond_hot_end_fan_air_flow_out_z_offset])
		cube([diamond_hot_end_fan_holder_z, diamond_hot_end_fan_holder_y, diamond_hot_end_fan_holder_feet_z], center = true);
		
		translate([diamond_hot_end_fan_holder_feet_x_offset, (diamond_hot_end_fan_holder_z / 2) + (diamond_hot_end_fan_holder_y / 2), (diamond_hot_end_fan_holder_y / 2) - diamond_hot_end_fan_air_flow_out_z_offset])
		difference() {
			union() {
				cylinder (r=(diamond_hot_end_fan_holder_z / 2), h=diamond_hot_end_fan_holder_y , center=true);
				
				_y = (diamond_hot_end_fan_holder_z / 2) + diamond_hot_end_fan_holder_y;
				translate([0, -(_y / 2), 0])
				cube([diamond_hot_end_fan_holder_z, _y, diamond_hot_end_fan_holder_y], center = true);
			}
			
			translate([0, 0, -4])
			rotate([0, 0, 180])
			base_screws_remove_fixation(20);
		}
	} else if(mode == "remove") {
		translate([diamond_hot_end_fan_holder_feet_x_offset, (diamond_hot_end_fan_holder_z / 2) + (diamond_hot_end_fan_holder_y / 2), (diamond_hot_end_fan_holder_y / 2)])
		translate([0, 0, -4])
		rotate([0, 0, 180])
		base_screws_remove_fixation(20);
	}
}
// diamond_hot_end_fan_holder_feet

module diamond_hot_end_fan_holder(mode = "default") {
	translate([0, (diamond_hot_end_fan_holder_y / 2), 0])
	
	if(mode == "default") {
		difference() {
			union() {
				diamond_hot_end_fan_holder_base();
				diamond_hot_end_fan_holder_feet();
			}
			diamond_hot_end_fan_fix_screw();
		}
	} else if(mode == "remove") {
		diamond_hot_end_fan_holder_feet("remove");
	}
}
// diamond_hot_end_fan_holder

module diamond_hot_end_fan_holder_remove() {
	color([1, 0, 0, 0.5])
	union() {
		diamond_hot_end_fan_air_flow();
		diamond_hot_end_fan_holder("remove");
		diamond_hot_end_fan_air_flow_fix_remove();
	}
}
// diamond_hot_end_fan_holder_remove

module diamond_hot_end_fan_holder_remove_positioned() {
	translate([-29.5, -26.5, (base_block_z / 2) + diamond_hot_end_fan_air_flow_out_z_offset])
	rotate([0, 0, 120])
	diamond_hot_end_fan_holder_remove();
}
// diamond_hot_end_bltouch_remove_positioned

//radial_fan_genuine();
//diamond_hot_end_fan_holder();
//diamond_hot_end_fan_holder_remove();



module diamond_hot_end_bltouch_angle_remove() {
	diamond_hot_end_bltouch_angle_remove_side = 5;
	
	for(x = [-1 : 2 : 1]) {
		for(y = [-1 : 2 : 1]) {
			translate([(diamond_hot_end_bltouch_fix_top_x_top / 2) * x, (diamond_hot_end_bltouch_fix_top_y / 2) * y, 0])
			rotate([0, 0, 45])
			cube([diamond_hot_end_bltouch_angle_remove_side, diamond_hot_end_bltouch_angle_remove_side, 20], center = true);
		}
	}
}
// diamond_hot_end_bltouch_angle_remove

module diamond_hot_end_bltouch_fix_remove() {
	for(x = [-1 : 2 : 1]) {
		translate([9 * x, 0, 0])
		rotate([180, 0, 90 * x])
		base_screws_remove_fixation(20);
	}
}
// diamond_hot_end_bltouch_fix_remove

module diamond_hot_end_bltouch_free_rotate_remove() {
	union() {
		nut_y = 20;
		nut_z = 4.5;
		screw_height = 20;
		cube([screws_nuts_side_max + 0.5, nut_y, nut_z], center = true);
		
		translate([0, 0, (screw_height / 2) - (nut_z / 2) - 1])
		cylinder (r=(screw_diameter / 2), h=screw_height , center=true);
	}
}
// diamond_hot_end_bltouch_free_rotate_remove

module diamond_hot_end_bltouch_fix_top(mode = "default") {
	if(mode == "default") {
		difference() {
			union() {
				translate([0, 0, (diamond_hot_end_bltouch_fix_top_z_top / 2)])
				cube([diamond_hot_end_bltouch_fix_top_x_top, diamond_hot_end_bltouch_fix_top_y, diamond_hot_end_bltouch_fix_top_z_top], center = true);
				
				translate([0, 0, -(diamond_hot_end_bltouch_fix_top_z_bottom / 2)])
				cube([diamond_hot_end_bltouch_x, diamond_hot_end_bltouch_fix_top_y, diamond_hot_end_bltouch_fix_top_z_bottom], center = true);
			}
			
			diamond_hot_end_bltouch_angle_remove();
			
			screw();
			
			translate([0, 0, (diamond_hot_end_bltouch_fix_top_z_top -diamond_hot_end_bltouch_fix_top_z_bottom) / 2])
			cube([screws_nuts_side_min, 20, screw_nuts_height], center = true);
			
			for(x = [-1 : 2 : 1]) {
				translate([((diamond_hot_end_bltouch_fix_top_x_top - diamond_hot_end_bltouch_fix_top_x_border) / 2) * x, 0, 0])
				screw();
			}
		}
	} else if(mode == "remove") {
		color([1, 0, 0, 0.5])
		union() {
			for(x = [-1 : 2 : 1]) {
				translate([((diamond_hot_end_bltouch_fix_top_x_top - diamond_hot_end_bltouch_fix_top_x_border) / 2) * x, 0, -3])
				rotate([0, 0, 90 * x])
				base_screws_remove_fixation(20);
			}
		}
	}
}
// diamond_hot_end_bltouch_fix_top

module diamond_hot_end_bltouch_holder(mode = "default") {
	if(mode == "default") {
		difference() {
			translate([0, 0, (diamond_hot_end_bltouch_holder_z / 2)])
			cube([diamond_hot_end_bltouch_x, diamond_hot_end_bltouch_y, diamond_hot_end_bltouch_holder_z], center = true);
			
			translate([0, 0, (diamond_hot_end_bltouch_holder_z / 2)])
			union() {
				diamond_hot_end_bltouch_fix_remove();
				diamond_hot_end_bltouch_free_rotate_remove();
			}
		}
	} else if(mode == "remove") {
		color([1, 0, 0, 0.5])
		union() {

			diamond_hot_end_bltouch_remove_x = diamond_hot_end_bltouch_x + (diamond_hot_end_bltouch_holder_margin * 2);
			diamond_hot_end_bltouch_remove_y = diamond_hot_end_bltouch_y + (diamond_hot_end_bltouch_holder_margin * 2); 
			
			cube([diamond_hot_end_bltouch_remove_x, diamond_hot_end_bltouch_remove_y, 100], center = true);
			
			translate([0, (diamond_hot_end_bltouch_wire_y / 2) + (diamond_hot_end_bltouch_remove_y / 2) - 0.01, 0])
			cube([diamond_hot_end_bltouch_wire_x, diamond_hot_end_bltouch_wire_y, 100], center = true);
		}
	}
}
// diamond_hot_end_bltouch_holder

module diamond_hot_end_bltouch_remove() {
	union() {
		diamond_hot_end_bltouch_fix_top("remove");
		
		translate([0, 0, -40])
		diamond_hot_end_bltouch_holder("remove");
	}
}
// diamond_hot_end_bltouch_remove

module diamond_hot_end_bltouch_remove_positioned() {
	translate([26, -15, (base_block_z / 2)]) // 26.5, -14.5
	rotate([0, 0, -120])
	diamond_hot_end_bltouch_remove();
}
// diamond_hot_end_bltouch_remove_positioned

//translate([0, 0, 15])
//diamond_hot_end_bltouch_fix_top();
//diamond_hot_end_bltouch_fix_top("remove");
//diamond_hot_end_bltouch_genuine();
//diamond_hot_end_bltouch_holder();
//diamond_hot_end_bltouch_holder("remove");
//diamond_hot_end_bltouch_remove();


module diamond_hot_end_top_cover_base() {
	difference() {
		cylinder($fn=3, h=diamond_hot_end_top_cover_base_z, r=diamond_hot_end_top_cover_base_radius, center=true);

		_offset = -((diamond_hot_end_top_cover_base_radius / 2) / cos(60));
		
		for(a = [0 : 1 : 2]) {
			rotate([0, 0, 60 + 120 * a])
			translate([_offset, 0, 0])
			cube([diamond_hot_end_top_cover_base_angle_grind_size * 2, diamond_hot_end_top_cover_base_angle_grind_size * 2, diamond_hot_end_top_cover_base_z * 2], center = true);
		}
	}
}
// diamond_hot_end_top_cover_base

module diamond_hot_end_top_cover_pipe_remove() {
	diamond_hot_end_top_cover_pipe_angle = 28;
	
	union() {
		for(a = [0 : 1 : 2]) {
			rotate([0, 0, 120 * a])
			translate([30.72, 0, 0])
			union() {
				
				translate([0, 0, -(diamond_hot_end_top_cover_base_z / 2)])
				rotate([0, 28, 0])
				union() {
					cylinder(h=50, r=diamond_hot_end_top_cover_pipe_out_diameter / 2, center=true);
					
					translate([(diamond_hot_end_top_cover_pipe_out_diameter / 2), 0, 0])
					cube([diamond_hot_end_top_cover_pipe_out_diameter, diamond_hot_end_top_cover_pipe_out_diameter, diamond_hot_end_top_cover_base_z * 4], center = true);
					
					translate([0, 0, -25 + 4.5])
					cylinder(h=50, r=(e3d_v6_fix_diameter_outer / 2) + e3d_v6_fix_diameter_margin, center=true);
					
				}
				
				
				translate([(sin(diamond_hot_end_top_cover_pipe_angle) * diamond_hot_end_top_cover_base_z ) + (diamond_hot_end_top_cover_pipe_out_insert_size / 2), 0, 0])
				rotate([0, 0, 90])
				cube([diamond_hot_end_top_cover_pipe_out_diameter, diamond_hot_end_top_cover_pipe_out_insert_size, diamond_hot_end_top_cover_base_z * 2], center = true);
			}
		}
		
		color([1, 0, 0])
		translate([0, 0, diamond_hot_end_z_offet - (base_block_z / 2) - (diamond_hot_end_top_cover_base_z / 2)])
		diamond_hot_end_plenty();
	}
}
// diamond_hot_end_top_cover_pipe_remove
//diamond_hot_end_top_cover_pipe_remove();

module diamond_hot_end_top_cover_fix_remove() {
	for(a = [0 : 1 : 2]) {
		_offset_y = 6;
		rotate([0, 0, 120 * a])
		translate([-(diamond_hot_end_top_cover_base_radius / 2) + 3, (a == 0) ? _offset_y : ((a == 1) ? -_offset_y : 0), -(diamond_hot_end_top_cover_base_z / 2) - 4])
		rotate([0, 0, -90])
		base_screws_remove_fixation(20);
	}
}
// diamond_hot_end_top_cover_fix_remove

module diamond_hot_end_top_cover_wire_hole_remove() {
	rotate([-13, 0, -30])
	translate([-7.5, 20.5, 0])
	scale([1, 0.7, 1])
	cylinder(h=26, r=diamond_hot_end_top_cover_wire_hole_diameter / 2, center=true);
}
// diamond_hot_end_top_cover_wire_hole_remove

module diamond_hot_end_top_cover(mode = "default") {
	if(mode == "default") {
		difference() {
			diamond_hot_end_top_cover_base();
			diamond_hot_end_top_cover_pipe_remove();
			
			translate([0, 0, (diamond_hot_end_top_cover_base_z / 2) + (fan_40x40_z / 2) + 0.01])
			rotate([0, 0, 60])
			fan_40x40("remove");
			
			diamond_hot_end_top_cover_fix_remove();
			diamond_hot_end_top_cover_wire_hole_remove();
		}
	} else if(mode == "remove") {
		union() {
			translate([0, 0, (diamond_hot_end_top_cover_base_z / 2) + (fan_40x40_z / 2) + 0.01])
			rotate([0, 0, 60])
			fan_40x40("remove");
			
			diamond_hot_end_top_cover_fix_remove();
			diamond_hot_end_top_cover_wire_hole_remove();
		}
	}
}
// diamond_hot_end_top_cover

module diamond_hot_end_top_cover_positionned(mode = "default") {
	_diamond_hot_end_top_cover_base_z_offset = (base_block_z / 2) + (diamond_hot_end_top_cover_base_z / 2);
	
	translate([0, diamond_hot_end_y_offet, _diamond_hot_end_top_cover_base_z_offset + 0.01])
	rotate([0, 0, 30])
	diamond_hot_end_top_cover(mode);
}
//diamond_hot_end_top_cover_positionned



module diamond_hot_end_remove() {
	translate([0, diamond_hot_end_y_offet, diamond_hot_end_z_offet])
	rotate([0, 0, 30])
	union() {
		translate([0, 0, 40])
		diamond_hot_end_piramidal_base();
		
		diamond_hot_end_radiator_air_flow_base_all();
		diamond_hot_end_plenty();
	}
}
// diamond_hot_end_remove
//diamond_hot_end_remove();

module diamond_hot_end_render() {
	difference() {
		_render_tool_base(1, "no_fixation_top");
		diamond_hot_end_remove();
		diamond_hot_end_top_cover_positionned("remove");
		diamond_hot_end_bltouch_remove_positioned();
		diamond_hot_end_fan_holder_remove_positioned();
	}
	
//	diamond_hot_end_remove();
//	_render_tool_base(1);
}
// diamond_hot_end_render

module diamond_hot_end_top_cover_render() {
	color([0, 0, 1, 0.7])
	diamond_hot_end_top_cover_positionned();
}
// diamond_hot_end_top_cover_render


module diamond_hot_end_helpers_render() {
	translate([0, diamond_hot_end_y_offet, 33])
	fan_40x40();

	radial_fan_genuine_positionned();
	
	diamond_hot_end_genuine_positionned();
	diamond_hot_end_bltouch_genuine_positionned();
//	diamond_hot_end_bed_positionned();
}
//diamond_hot_end_helpers_render


// attention: l'insertion du hotend dans la "top cover" peut etre difficile a cause d'un angle particulier


//diamond_hot_end_helpers_render();

//color([0, 0, 0, 0.1])
diamond_hot_end_render();

//diamond_hot_end_top_cover_render();

//diamond_hot_end_bltouch_fix_top();

//diamond_hot_end_bltouch_holder();

//diamond_hot_end_fan_holder();

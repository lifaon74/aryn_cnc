include <../tool_base.scad>
include <../diamond_hotend.scad>

$fn=20;

diamon_hot_end_radiator_air_flow_x = 31.4;
diamon_hot_end_radiator_air_flow_y = e3d_v6_radiator_diameter + e3d_v6_radiator_diameter_margin * 2;
diamon_hot_end_radiator_air_flow_z = 70; // 43.1

diamon_hot_end_piramidal_base_radius_top = 44;
diamon_hot_end_piramidal_base_radius_bottom = 22;
diamon_hot_end_piramidal_base_z = 40;
	
	
diamon_hot_end_y_offet = 8;
diamon_hot_end_z_offet = -42;


module diamon_hot_end_genuine() {
	color([1, 0, 1])
	translate([-30, 0, 63])
	import("../diamon_hotend_base.stl");
}
// diamon_hot_end_genuine

module diamon_hot_end_genuine_positionned() {
	translate([0, diamon_hot_end_y_offet, diamon_hot_end_z_offet])
	rotate([0, 0, 30])
	diamon_hot_end_genuine();
}
// diamon_hot_end_genuine_positionned


fan_40x40_diameter = 36;
fan_40x40_z = 13;

module fan_40x40(mode = "default") {
	if(mode == "remove") {
		union() {
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

module diamon_hot_end_radiator_air_flow_base() {
	
	color([1, 0, 0])
	translate([19.8 + e3d_v6_radiator_diameter_margin, 0, (diamon_hot_end_radiator_air_flow_z / 2)])
	
	difference() {
		cube([diamon_hot_end_radiator_air_flow_x,diamon_hot_end_radiator_air_flow_y, diamon_hot_end_radiator_air_flow_z], center = true);
		
		diamon_hot_end_radiator_air_flow_base_break_corder_side = 7;
		
		offset_x = (diamon_hot_end_radiator_air_flow_x / 2);
		offset_y = (diamon_hot_end_radiator_air_flow_y / 2);
		
		union() {
			for(y = [-1 : 2 : 1]) {
				translate([offset_x, offset_y * y, 0])
				rotate([0, 0, 45])
				cube([diamon_hot_end_radiator_air_flow_base_break_corder_side, diamon_hot_end_radiator_air_flow_base_break_corder_side, diamon_hot_end_radiator_air_flow_z + 1], center = true);
			}
		}
	}
	
}
// diamon_hot_end_radiator_air_flow_base

module diamon_hot_end_radiator_air_flow_base_all() {
	for(a = [0 : 1 : 2]) {
		rotate([0, 0, 120 * a])
		diamon_hot_end_radiator_air_flow_base();
	}
}
// diamon_hot_end_radiator_air_flow_base_all

module diamon_hot_end_piramidal_base() {
	union() {
		difference() {
			cylinder($fn=3, h=diamon_hot_end_piramidal_base_z, r1=diamon_hot_end_piramidal_base_radius_bottom, r2=diamon_hot_end_piramidal_base_radius_top, center=true);
			
			width = (diamon_hot_end_piramidal_base_radius_top - diamon_hot_end_piramidal_base_radius_bottom);
			angle = atan(width / diamon_hot_end_piramidal_base_z);
			median_width = (diamon_hot_end_piramidal_base_radius_top + diamon_hot_end_piramidal_base_radius_bottom) / 2;
			

			union() {
			//	color([1, 1, 0, 0.5])
				for(a = [0 : 1 : 2]) {
					rotate([0, 0, 60 + 120 * a])
					translate([-median_width, 0, 0])
					rotate([0, -angle, 0])
					cube([20, 20, diamon_hot_end_piramidal_base_z * 2], center = true);
				}
			}
		}
		
		cylinder (r=15, h=diamon_hot_end_piramidal_base_z * 2 , center=true);
	}
}
// diamon_hot_end_piramidal_base
//diamon_hot_end_piramidal_base();


diamon_hot_end_top_cover_base_z = 10;
diamon_hot_end_top_cover_base_radius = 54;
diamon_hot_end_top_cover_base_angle_grind_size = 12;
diamon_hot_end_top_cover_pipe_out_diameter = 12;
diamon_hot_end_top_cover_pipe_out_insert_size = 8;

module diamon_hot_end_top_cover_base() {
	difference() {
		cylinder($fn=3, h=diamon_hot_end_top_cover_base_z, r=diamon_hot_end_top_cover_base_radius, center=true);

		_offset = -((diamon_hot_end_top_cover_base_radius / 2) / cos(60));
		
		for(a = [0 : 1 : 2]) {
			rotate([0, 0, 60 + 120 * a])
			translate([_offset, 0, 0])
			cube([diamon_hot_end_top_cover_base_angle_grind_size * 2, diamon_hot_end_top_cover_base_angle_grind_size * 2, diamon_hot_end_top_cover_base_z * 2], center = true);
		}
	}
}
// diamon_hot_end_top_cover_base

module diamon_hot_end_top_cover_pipe_remove() {
	diamon_hot_end_top_cover_pipe_angle = 28;
	
	union() {
		for(a = [0 : 1 : 2]) {
			rotate([0, 0, 120 * a])
			translate([30.5, 0, 0])
			union() {
				
				translate([0, 0, -(diamon_hot_end_top_cover_base_z / 2)])
				rotate([0, 28, 0])
				union() {
					cylinder(h=50, r=diamon_hot_end_top_cover_pipe_out_diameter / 2, center=true);
					
					translate([(diamon_hot_end_top_cover_pipe_out_diameter / 2), 0, 0])
					cube([diamon_hot_end_top_cover_pipe_out_diameter, diamon_hot_end_top_cover_pipe_out_diameter, diamon_hot_end_top_cover_base_z * 4], center = true);
					
					translate([0, 0, -25 + 5.1])
					cylinder(h=50, r=(e3d_v6_fix_diameter_outer / 2) + e3d_v6_fix_diameter_margin, center=true);
					
				}
				
				
				translate([(sin(diamon_hot_end_top_cover_pipe_angle) * diamon_hot_end_top_cover_base_z ) + (diamon_hot_end_top_cover_pipe_out_insert_size / 2), 0, 0])
				rotate([0, 0, 90])
				cube([diamon_hot_end_top_cover_pipe_out_diameter, diamon_hot_end_top_cover_pipe_out_insert_size, diamon_hot_end_top_cover_base_z * 2], center = true);
			}
		}
		
		color([1, 0, 0])
		translate([0, 0, diamon_hot_end_z_offet - (base_block_z / 2) - (diamon_hot_end_top_cover_base_z / 2)])
		diamon_hot_end_plenty();
	}
}
// diamon_hot_end_top_cover_pipe_remove
//diamon_hot_end_top_cover_pipe_remove();

module diamon_hot_end_top_cover() {
	
	color([0, 0, 1, 0.7])
	difference() {
		diamon_hot_end_top_cover_base();
		diamon_hot_end_top_cover_pipe_remove();
		
		translate([0, 0, (diamon_hot_end_top_cover_base_z / 2) + (fan_40x40_z / 2) + 0.01])
		rotate([0, 0, 60])
		fan_40x40("remove");
	}
}
// diamon_hot_end_top_cover


module diamon_hot_end_remove() {
	translate([0, diamon_hot_end_y_offet, diamon_hot_end_z_offet])
	rotate([0, 0, 30])
	union() {
		translate([0, 0, 40])
		diamon_hot_end_piramidal_base();
		
		diamon_hot_end_radiator_air_flow_base_all();
		diamon_hot_end_plenty();
	}
}
// diamon_hot_end_remove
//diamon_hot_end_remove();

module diamon_hot_end_render() {
	difference() {
		_render_tool_base(1);
		diamon_hot_end_remove();
	}
	
//	diamon_hot_end_remove();
//	_render_tool_base(1);
}
// diamon_hot_end_render

module diamon_hot_end_top_cover_render() {
	_diamon_hot_end_top_cover_base_z_offset = (base_block_z / 2) + (diamon_hot_end_top_cover_base_z / 2);
	
	translate([0, diamon_hot_end_y_offet, _diamon_hot_end_top_cover_base_z_offset + 0.01])
	rotate([0, 0, 30])
	diamon_hot_end_top_cover();
}
// diamon_hot_end_top_cover_render

translate([0, diamon_hot_end_y_offet, 33])
fan_40x40();

diamon_hot_end_render();

diamon_hot_end_genuine_positionned();

diamon_hot_end_top_cover_render();


include <../tool_base.scad>
include <../diamond_hotend.scad>

$fn=40;

diamon_hot_end_radiator_air_flow_x = 30;
diamon_hot_end_radiator_air_flow_y = e3d_v6_radiator_diameter + e3d_v6_radiator_diameter_margin * 2;
diamon_hot_end_radiator_air_flow_z = 70; // 43.1

diamon_hot_end_y_offet = 8;
diamon_hot_end_z_offet = -43;


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
diamon_hot_end_genuine_positionned();


module diamon_hot_end_radiator_air_flow_base() {
	
	color([1, 0, 0])
	translate([19.8 + e3d_v6_radiator_diameter_margin, 0, (diamon_hot_end_radiator_air_flow_z / 2)])
	
	difference() {
		cube([diamon_hot_end_radiator_air_flow_x,diamon_hot_end_radiator_air_flow_y, diamon_hot_end_radiator_air_flow_z], center = true);
		
		diamon_hot_end_radiator_air_flow_base_break_corder_side = 5;
		
		offset_x = (diamon_hot_end_radiator_air_flow_x / 2);
		offset_y = (diamon_hot_end_radiator_air_flow_y / 2);
		
		union() {
			translate([offset_x, offset_y, 0])
			rotate([0, 0, 45])
			cube([diamon_hot_end_radiator_air_flow_base_break_corder_side, diamon_hot_end_radiator_air_flow_base_break_corder_side, diamon_hot_end_radiator_air_flow_z + 1], center = true);
			
		translate([offset_x, -offset_y, 0])
			rotate([0, 0, 45])
			cube([diamon_hot_end_radiator_air_flow_base_break_corder_side, diamon_hot_end_radiator_air_flow_base_break_corder_side, diamon_hot_end_radiator_air_flow_z + 1], center = true);
		}
	}
	
}
// diamon_hot_end_radiator_air_flow_base

module diamon_hot_end_radiator_air_flow_base_all() {
	rotate([0, 0, 0])
	diamon_hot_end_radiator_air_flow_base();
	
	rotate([0, 0, 120])
	diamon_hot_end_radiator_air_flow_base();
	
	rotate([0, 0, 240])
	diamon_hot_end_radiator_air_flow_base();
}
// diamon_hot_end_radiator_air_flow_base_all

module diamon_hot_end_piramidal_base() {
	diamon_hot_end_piramidal_base_side = 46;
	diamon_hot_end_piramidal_base_z = 40;
	
	translate([0, 0, 0])
	cylinder($fn=3, h=diamon_hot_end_piramidal_base_z, r1=24, r2=diamon_hot_end_piramidal_base_side, center=true);
}
// diamon_hot_end_piramidal_base

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

module diamon_hot_end_render() {
	difference() {
		_render_tool_base(1);
		diamon_hot_end_remove();
	}
	
//	diamon_hot_end_remove();
//	_render_tool_base(1);
}
// diamon_hot_end_render

diamon_hot_end_render();
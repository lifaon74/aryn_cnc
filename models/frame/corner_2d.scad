include <config.scad>

// compted 
base_cube_height = aluminium_extrusion_size + (material_thickness * 2);

module attached_extrusion_rod() {
	
	screw_offset = -(screw_height / 2);
	union() { // difference
		
		rotate([90, 0, 0])
		rod();
		
		translate([0, screw_offset, 0])
		rotate([90, 0, 0])
		screw();
		
		translate([screw_offset, 0, 0])
		rotate([0, 90, 0])
		screw();
	}
}
// attached_extrusion_rod
//attached_extrusion_rod();

module positioned_aluminium_extrusion_rods() {
	union() {
		positioned_aluminium_extrusion_rod();
		
		rotate([0, 0, -90])
		positioned_aluminium_extrusion_rod();
	}
}
// positioned_aluminium_extrusion_rods
//positioned_aluminium_extrusion_rods();

module base_cube_remove_inner_2D_corners() {
	union() {
		rotate([0, 90, 0])
		base_cube_remove_inner_2D_corner();
	}
}
//base_cube_remove_inner_2D_corners
//base_cube_remove_inner_2D_corners();


module base_cube() {
	color([1, 1, 0, 0.7])
	difference() {
		translate([base_cube_offset, base_cube_offset, 0])
		cube([base_cube_size, base_cube_size, base_cube_height], center=true);
		
		base_cube_remove_inner_2D_corners();
	}
}
// base_cube

module _render() {
	difference() {
		base_cube();
		attached_extrusion_rod();
		positioned_aluminium_extrusion_rods();
	}
}
// _render

_render();
include <config.scad>



module positioned_aluminium_extrusion_rods() {
	union() {
		positioned_aluminium_extrusion_rod();
		
		rotate([0, 0, -90])
		positioned_aluminium_extrusion_rod();
		
		rotate([90, 0, 0])
		positioned_aluminium_extrusion_rod();
	}
}
// positioned_aluminium_extrusion_rods
//positioned_aluminium_extrusion_rods();

module base_cube_remove_inner_3D_corner() {
	base_cube_remove_inner_3D_corner_size = base_cube_size;
	base_cube_remove_inner_3D_corner_offset = (base_cube_remove_inner_3D_corner_size / 2) + (aluminium_extrusion_size / 2) + material_thickness;
	
	
	reinforcement_3D_offset = (aluminium_extrusion_size / 2) + material_thickness - (reinforcement_3D_margin / 3);
	

	
	color([1, 0, 0, 0.7])
	difference() {
		translate([base_cube_remove_inner_3D_corner_offset, base_cube_remove_inner_3D_corner_offset, base_cube_remove_inner_3D_corner_offset])
		cube([base_cube_remove_inner_3D_corner_size, base_cube_remove_inner_3D_corner_size, base_cube_remove_inner_3D_corner_size], center=true);
			
			
		translate([reinforcement_3D_offset, reinforcement_3D_offset, reinforcement_3D_offset])
		reinforcement_3D();
	}
}
//base_cube_remove_inner_3D_corner


module base_cube_remove_inner_2D_corners() {
	union() {
		base_cube_remove_inner_2D_corner();
		
		rotate([0, 0, -90])
		base_cube_remove_inner_2D_corner();
		
		rotate([0, 90, 0])
		base_cube_remove_inner_2D_corner();
	}
}
//base_cube_remove_inner_2D_corners

//base_cube_remove_inner_2D_corners();


module base_cube_remove_unsharp() {
	//base_cube_remove_unsharp_size = base_unsharp_size * sqrt(3);
	//base_cube_remove_unsharp_offset = -((aluminium_extrusion_size / 2) + material_thickness);
	

	base_cube_remove_unsharp_points = [
		[0, 0, 0],
		[base_unsharp_size + base_unsharp_margin, 0, 0],
		[0, base_unsharp_size + base_unsharp_margin, 0],
		[0, 0, base_unsharp_size + base_unsharp_margin],
	];
  
	base_cube_remove_unsharp_faces = [
		[0, 1, 2], // x, y plan
		[0, 2, 3], // y, z plan
		[0, 3, 1], // x, z plan
		[1, 3, 2]
	]; 
  
	base_cube_remove_unsharp_offset = -((base_unsharp_margin / 3) + (aluminium_extrusion_size / 2) + material_thickness);
	
	
	
	translate([base_cube_remove_unsharp_offset, base_cube_remove_unsharp_offset, base_cube_remove_unsharp_offset])
	polyhedron(base_cube_remove_unsharp_points, base_cube_remove_unsharp_faces);
}
//base_cube_remove_unsharp
//base_cube_remove_unsharp();

module base_cube_remove_nut() {
	base_cube_remove_nut_screw_inside_length= 30;
	
	base_cube_remove_nut_screw_length = (base_cube_remove_nut_screw_inside_length * 2) + (nut_height_m6 * 2);
	base_cube_remove_nut_offset_z = -((aluminium_extrusion_size / 2) + material_thickness) ;
	
	translate([0, 0, base_cube_remove_nut_offset_z])
	rotate([0, 0, 15])
	union() {
		cylinder(r=(nut_diameter_m6 / 2), h=(nut_height_m6 * 2) , $fn=6, center=true);
		
		cylinder(r=(screw_diameter_m6 / 2), h=base_cube_remove_nut_screw_length, center=true);
	}
}
// base_cube_remove_nut


module base_cube() {
	color([1, 1, 0, 0.7])
	difference() {
		translate([base_cube_offset, base_cube_offset, base_cube_offset])
		cube([base_cube_size, base_cube_size, base_cube_size], center=true);
		
		base_cube_remove_inner_3D_corner();
		base_cube_remove_inner_2D_corners();
	}
}
//base_cube





module _render() {
	difference() {
		base_cube();
		positioned_aluminium_extrusion_rods();
		base_cube_remove_unsharp();
		base_cube_remove_nut();
	}
}
//_render



_render();
//_calibration_rod_test();


include <config.scad>

$fn=100;

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

module screw_with_head() {
	union() {
		translate([0, 0, (screw_height / 2)])
		cylinder(r=(screw_diameter / 2), h=screw_height , center=true);
		
		translate([0, 0, -(screw_height / 2) + 0.01])
		cylinder(r=3, h=screw_height , center=true);
	}
}
// screw_with_head

module corder_3d_smooth_slide() {
//	cube([base_cube_size, base_cube_size, material_thickness], center=true);
	
	_length = 16;
	_x0 = (aluminium_extrusion_size / 2) + material_thickness;
	_x1 = _x0 + 6.1;
	_y0 = base_cube_offset + (base_cube_size / 2) + 0.4;
	_y1 = _y0 + _length;
	_z0 = material_thickness + 2;
	
	_points = [
		// left
		[-_x0, _y0, 0],
		[_x1, _y0, 0],
		[_x1, _y1, 0],
		[-_x0, _y1, 0],
		[-_x0, _y0, -_z0],
		[_x1, _y0, -_z0],
	
		// right
		[_y0, -_x0, 0],
		[_y0, _x1, 0],
		[_y1, _x1, 0],
		[_y1, -_x0, 0],
		[_y0, -_x0, -_z0],
		[_y0, _x1, -_z0],
	];
  
	_faces = [
		// left face
		[0, 2, 1],
		[0, 3, 2], // bottom face
		
		[4, 5, 2],
		[4, 2, 3],  // slope face
		
		[0, 4, 3], // side face
		
		[0, 1, 4],
		[4, 1, 5], // back face
		
//		[5, 1, 2], // side face
		
		// right face
		[6, 7, 8],
		[6, 8, 9], // bottom face
		
		[10, 8, 11],
		[10, 9, 8],  // slope face
		
		[6, 9, 10], // side face
		
		[6, 10, 7],
		[10, 11, 7], // back face
		
//		[11, 8, 7], // side face
		
		// middle face
		[1, 8, 7],
		[1, 2, 8], // bottom face
		
		[5, 11, 8],
		[5, 8, 2],	// slope face

		[1, 7, 5],
		[5, 7, 11], // back face
	]; 
  
	_y2 = _y0 + 4.5;
	_z2 = (aluminium_extrusion_size / 2) + 1;
	
	
	difference() {
		translate([0, 0, -(aluminium_extrusion_size / 2) + 1])
		polyhedron(_points, _faces);
		
		positioned_aluminium_extrusion_rods();
		
		translate([0, _y2, -_z2])
		screw_with_head();
		
		translate([_y2, 0, -_z2])
		screw_with_head();
	}

}
// corder_3d_smooth_slide


module _render() {
	difference() {
		base_cube();
		positioned_aluminium_extrusion_rods();
		base_cube_remove_unsharp();
		base_cube_remove_nut();
	}
}
//_render



//_render();
//_calibration_rod_test();
corder_3d_smooth_slide();


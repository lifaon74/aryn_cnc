$fn=20;

aluminium_extrusion_size = 20.4;
aluminium_extrusion_length = 650;



material_on_rod_length = 40; // the length of material wrapping the rods
material_thickness = 4;

screw_diameter = 3;

screw_diameter_m6 = 6;
nut_diameter_m6 = 11.7;
nut_height_m6 = 5;

reinforcement_3D_size = 15;
reinforcement_2D_size = 15;
reinforcement_2D_unsharp_size = 30;

base_unsharp_size = 10;


// do not touch
screw_height = 100;
reinforcement_3D_margin = 1;
reinforcement_2D_margin = 1;
base_unsharp_margin = 1;


// computed

base_cube_size = aluminium_extrusion_size + material_on_rod_length + material_thickness;
base_cube_offset = (base_cube_size / 2) - (aluminium_extrusion_size / 2) - material_thickness;


module screw() {
    cylinder(r=(screw_diameter / 2), h=screw_height , center=true);
}
// screw

module rod() {
    color([0.7, 0.7, 0.7, 1])
		cube([aluminium_extrusion_size, aluminium_extrusion_length,aluminium_extrusion_size], center=true);
}
// rod

module positioned_aluminium_extrusion_rod_screw_holder(rel_pos, rotation) {
	
	base_border = (aluminium_extrusion_size / 2) + material_on_rod_length;
	
	rotate([0, 90 * rotation, 0])
	translate([0, base_border + rel_pos, 0])
	screw();
}
// positioned_aluminium_extrusion_rod_screw_holder

module positioned_aluminium_extrusion_rod() {
	
	delta = (aluminium_extrusion_length / 2) + (aluminium_extrusion_size / 2) + 1;
	
	translate([0, delta, 0])
	rod();
	
	
	base_border = (aluminium_extrusion_size / 2) + material_on_rod_length;
	
	color([1, 0, 0, 0.7])
	union() {
		positioned_aluminium_extrusion_rod_screw_holder(-10, 0);
		positioned_aluminium_extrusion_rod_screw_holder(-(material_on_rod_length - 10), 0);
		positioned_aluminium_extrusion_rod_screw_holder(-10, 1);
		positioned_aluminium_extrusion_rod_screw_holder(-(material_on_rod_length - 10), 1);
	}
}
//positioned_aluminium_extrusion_rod


module reinforcement_3D() {
	reinforcement_3D_points = [
		[0, 0, 0],
		[reinforcement_3D_size + reinforcement_3D_margin, 0, 0],
		[0, reinforcement_3D_size + reinforcement_3D_margin, 0],
		[0, 0, reinforcement_3D_size + reinforcement_3D_margin],
	];
  
	reinforcement_3D_faces = [
		[0, 1, 2], // x, y plan
		[0, 2, 3], // y, z plan
		[0, 3, 1], // x, z plan
		[1, 3, 2]
	]; 
  
	polyhedron(reinforcement_3D_points, reinforcement_3D_faces);
}
// reinforcement_3D

module reinforcement_2D() {
	reinforcement_2D_width = aluminium_extrusion_size + reinforcement_2D_margin;
	translate([0, 0, -(reinforcement_2D_width / 2)])
    linear_extrude(height=reinforcement_2D_width)
    polygon([
        [0, 0],
        [reinforcement_2D_size + reinforcement_2D_margin, 0],
        [0, reinforcement_2D_size + reinforcement_2D_margin]
    ]);
}
//reinforcement_2D


module base_cube_remove_inner_2D_corner() {
	base_cube_remove_inner_2D_corner_size = material_on_rod_length * 1;
	
	base_cube_remove_inner_2D_corner_offset = (base_cube_remove_inner_2D_corner_size / 2) + (aluminium_extrusion_size / 2) + material_thickness;
	
	reinforcement_2D_offset = (aluminium_extrusion_size / 2) + material_thickness - (reinforcement_2D_margin / 2);
	
	
	base_cube_remove_inner_2D_corner_unsharp_length = aluminium_extrusion_size + (material_thickness * 2) + 1;
	
	base_cube_remove_inner_2D_corner_unsharp_size = reinforcement_2D_unsharp_size * sqrt(2);
	
	base_cube_remove_inner_2D_corner_unsharp_offset = (aluminium_extrusion_size / 2) + material_on_rod_length;
	
	screw_offset = (reinforcement_2D_size + ((material_on_rod_length - material_thickness) * 2 - reinforcement_2D_unsharp_size)) / 4
	+ (aluminium_extrusion_size / 2) + material_thickness;
	
	color([1, 0, 0, 0.7])
	union() {
		difference() {
			translate([0, base_cube_remove_inner_2D_corner_offset, base_cube_remove_inner_2D_corner_offset])
			cube([aluminium_extrusion_size, base_cube_remove_inner_2D_corner_size, base_cube_remove_inner_2D_corner_size], center=true);
			
			translate([0, reinforcement_2D_offset, 		reinforcement_2D_offset])
			rotate([0, -90, 0])
			reinforcement_2D();
		}
		
		
		translate([0, base_cube_remove_inner_2D_corner_unsharp_offset, 		base_cube_remove_inner_2D_corner_unsharp_offset])
		rotate([45, 0, 0])
		cube([base_cube_remove_inner_2D_corner_unsharp_length, base_cube_remove_inner_2D_corner_unsharp_size, base_cube_remove_inner_2D_corner_unsharp_size], center=true);
	
		translate([0, screw_offset, screw_offset])
		rotate([0, 90, 0])
		screw();
	}
}
// base_cube_remove_inner_2D_corner

//base_cube_remove_inner_2D_corner();

module _calibration_screw_m6_test() {
	
	_calibration_rod_test_thickness = 2;
	_calibration_rod_test_size = nut_diameter_m6 + (_calibration_rod_test_thickness * 2);
	
	difference() {
		
		cube([_calibration_rod_test_size, _calibration_rod_test_size, 4], center=true);
		
		cylinder(r=(nut_diameter_m6 / 2), h=50 , $fn=6, center=true);
	}
}
// _calibration_screw_m6_test


module _calibration_rod_test() {
	
	_calibration_screw_test_thickness = 2;
	_calibration_screw_test_size = aluminium_extrusion_size + (_calibration_screw_test_thickness * 2);
	
	difference() {
		
		cube([_calibration_screw_test_size, _calibration_screw_test_size, 4], center=true);
		
		cube([aluminium_extrusion_size, aluminium_extrusion_size, aluminium_extrusion_length], center=true);
	}
}
// _calibration_rod_test
//_calibration_rod_test();
//_calibration_screw_m6_test();



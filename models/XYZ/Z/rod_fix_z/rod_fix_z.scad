$fn=100;

include <../../config.scad>


frame_rod_side = 20.4;
material_thickness_frame_rod = 4;
material_thickness_frame_rod_z = 4;
material_thickness_bearring_compression_z = 1;

bearing_608z_diameter = 22;
bearing_608z_height = 7.5;

acme_rod_diameter = 8;

compression_washer_diameter = 19.3; //18.9
compression_washer_height = 2.2;

rod_holder_size = 7.5 + 1 + 2;

rod_x = frame_rod_side; // sqrt(2) * rod_side

base_x = rod_x + (screw_virtual_holder_side * 2);
base_y = base_block_z;
base_z = frame_rod_side + material_thickness_frame_rod_z + rod_holder_size;

base_z_offset = (base_z / 2) - (frame_rod_side / 2);

base_acme_x = bearing_608z_diameter + screw_virtual_holder_side;
base_acme_y = base_y;
base_acme_z = base_z;



rod_offset_z = (rod_length / 2) + (frame_rod_side / 2) + material_thickness_frame_rod_z;
acme_rod_offset_x = -(base_x / 2) - (bearing_608z_diameter / 2);

base_acme_offset_x = -(base_acme_x / 2) + (bearing_608z_diameter / 2);


module frame_rod() {
	color([0.7, 0.7, 0.7])
	cube([500, frame_rod_side, frame_rod_side + 0.01], center = true);
}
// frame_rod
//frame_rod();

module positioned_rod() {
	translate([0, 0, rod_offset_z])
	rotate([0, 90, 0])
	rod(true);
}
// positioned_rod
//positioned_rod();


module positioned_acme_rod() {
	color([0.7, 0.7, 0.7])
	translate([acme_rod_offset_x, 0, rod_offset_z - 0.01])
	cylinder (r=(acme_rod_diameter / 2), h=rod_length , center=true);
}
// positioned_acme_rod
//positioned_acme_rod();

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

module screw_holes() {
	screw_hole_offset = frame_rod_side / 2 + material_thickness_frame_rod;
	
	translate([0, -screw_hole_offset, 0])
	rotate([90, 0, 0])
	screw_and_head(20);
	
	translate([0, screw_hole_offset, 0])
	rotate([-90, 0, 0])
	screw_and_head(20);
}
// screw_holes

module positioned_base_screw_remove_tighten() {
    base_screw_remove_tighten_x = (base_x / 2) - (screw_virtual_holder_side / 2);
	base_screw_remove_tighten_z = (frame_rod_side / 2) + material_thickness_frame_rod_z + (rod_holder_size / 2);
	
	base_screw_remove_tighten_acme_rod_x = acme_rod_offset_x - (base_acme_x / 2) + base_acme_offset_x + (screw_virtual_holder_side / 2);
	
    translate([0, 0, base_screw_remove_tighten_z])
    union() {
        translate([base_screw_remove_tighten_x, 0, 0])
        rotate([90, -45, 0])
        base_screw_remove_tighten();
		
		translate([-base_screw_remove_tighten_x, 0, 0])
        rotate([90, 0, 0])
        base_screw_remove_tighten();
		
		translate([base_screw_remove_tighten_acme_rod_x, 0, 0])
        rotate([90, +45, 0])
        base_screw_remove_tighten();
    }
}
// positioned_base_screw_remove_tighten



module base_block() {
	color([1, 1, 0, 0.7])
	translate([0, 0, base_z_offset])
	cube([base_x, base_y, base_z], center = true);
}
// base_block


module acme_rod_hole() {
	color([0.7, 0.7, 0.7])
	translate([0, 0, rod_offset_z - material_thickness_frame_rod - 0.01])
	cylinder (r=(14 / 2), h=rod_length , center=true);
}
// acme_rod_hole

module bearing() {
	bearing_offset_z = (frame_rod_side / 2) + material_thickness_frame_rod_z + (bearing_608z_height / 2);
	
	color([0, 1, 0, 0.7])
	translate([0, 0, bearing_offset_z])
	cylinder (r=(bearing_608z_diameter / 2), h=bearing_608z_height , center=true);
}
// bearing

module compression_washer() {
	compression_washer_offset_z = (frame_rod_side / 2) + material_thickness_frame_rod_z + bearing_608z_height + material_thickness_bearring_compression_z + (compression_washer_height / 2);
	
	color([0, 0, 1, 0.7])
	translate([0, 0, compression_washer_offset_z])
	cylinder (r=(compression_washer_diameter / 2), h=compression_washer_height , center=true);
}
// compression_washer


module base_acme_block() {
	color([1, 1, 0, 0.7])
	translate([base_acme_offset_x, 0, base_z_offset])
	cube([base_acme_x, base_acme_y, base_acme_z], center = true);
}
// base_block



module base_acme_block_positioned() {
	translate([acme_rod_offset_x + 0.01, 0, 0])
	difference() {
		base_acme_block();
		
		union() {
			bearing();
			acme_rod_hole();
			compression_washer();
			screw_holes();
		}
	}
}
// base_acme_block_positioned


module base_block_separator() {
	base_block_separator_offset_x = -15;
	base_block_separator_offset_z = (frame_rod_side / 2) + material_thickness_frame_rod_z + rod_holder_size;
	
	translate([base_block_separator_offset_x, 0, base_block_separator_offset_z])
	cube([100, 1, rod_holder_size * 2], center = true);
}
// base_block_separator

module base_block_spliter() {
	base_block_spliter_y = base_y;
	base_block_spliter_offset_z = (frame_rod_side / 2) + material_thickness_frame_rod_z + rod_holder_size;
	
	base_block_separator_offset_x = -15;
	color([0, 0, 1, .7])
	translate([base_block_separator_offset_x, -(base_block_spliter_y / 2) - 0.01, base_block_spliter_offset_z])
	cube([100, base_block_spliter_y, rod_holder_size * 2 - 0.01], center = true);
}
// base_block_spliter


module positioned_switch() {
	switch_offset_y = -(base_y / 2) - (switch_z / 2);
	switch_offset_z = (frame_rod_side / 2) + material_thickness_frame_rod_z + rod_holder_size - 8.5;

	translate([0, switch_offset_y - 0.01, switch_offset_z])
	rotate([90, 0, 0])
	switch();
}
// positioned_switch

module base_block_full() {
	difference() {
		union() {	
			base_block();
			base_acme_block_positioned();
		}
		
		union() {
			frame_rod();
			positioned_rod();
			screw_holes();
			positioned_base_screw_remove_tighten();
			base_block_separator();
			positioned_switch();
		}
	}
}
// base_block_full

module _render() {
	difference() { // difference, intersection
		base_block_full();
		base_block_spliter();
	}

}
// _render

_render();








$fn=20;

include <../../config.scad>

frame_rod_side = 20.4;
material_thickness_frame_rod = 4;


base_x = frame_rod_side + material_thickness_frame_rod + rod_holder_size;
base_y = frame_rod_side + (material_thickness_frame_rod * 2) + (screw_virtual_holder_side * 2);
base_z = base_block_z;

base_x_offset = (base_x / 2) - (frame_rod_side / 2);

base_belt_holder_block_y = 17;
base_belt_holder_block_offset_y = (base_y / 2) + (base_belt_holder_block_y / 2);

base_belt_holder_block_remove_x = frame_rod_side;
base_belt_holder_block_remove_z = 50;
base_belt_holder_block_remove_offset_x = material_thickness_frame_rod;


module frame_rod() {
	color([0.7, 0.7, 0.7])
	cube([frame_rod_side + 0.01, frame_rod_side, 500], center = true);
}
// frame_rod

module positioned_rod() {
	translate([(rod_length / 2) + (frame_rod_side / 2) + material_thickness_frame_rod, 0, 0])
	rod(true);
}
// positioned_rod

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
	
	translate([screw_hole_offset + 0.1, 0, 0])
	rotate([0, 90, 0])
	screw_and_head(20);
}
// screw_holes


module base_screw_remove_tighten() {
    
    
    color([1, 0, 0, 0.7])
    union() {
        
        screw_length = base_block_z + 1;
        
        cylinder (r=(screw_diameter / 2), h=screw_length, center=true);
    
        nuts_remove_length = (screw_length / 2) - (screws_attach_length / 2);
    
        translate([0, 0, (screw_length / 2) - (nuts_remove_length / 2)])
        cylinder ($fn = 6, r=(screws_nuts_side_max / 2), h=nuts_remove_length, center=true);
        
        translate([0, 0, -((screw_length / 2) - (nuts_remove_length / 2))])
        cylinder ($fn = 6, r=(screws_nuts_side_max / 2), h=nuts_remove_length, center=true);
    }
}
// base_screw_remove_tighten

module positioned_base_screw_remove_tighten() {
    base_screw_remove_tighten_x = (frame_rod_side / 2) + material_thickness_frame_rod + (rod_holder_size / 2);
    base_screw_remove_tighten_y = (base_block_y / 2) - (screw_virtual_holder_side / 2) - 1.5;
    

    translate([base_screw_remove_tighten_x, 0, 0])
    union() {
        translate([0, base_screw_remove_tighten_y, 0])
        rotate([0, 0, -45 ])
        base_screw_remove_tighten();
		
		translate([0, -base_screw_remove_tighten_y, 0])
        rotate([0, 0, +45 ])
        base_screw_remove_tighten();
    }
}
// positioned_base_screw_remove_tighten



module positioned_switch() {
	switch_offset_x = (frame_rod_side / 2) + material_thickness_frame_rod + 3;
	switch_offset_z = (base_z / 2) + (switch_z / 2);
	
	translate([switch_offset_x, 0, switch_offset_z + 0.01])
	rotate([0, 0, -90])
	switch();
}
// positioned_switch
positioned_switch();


module base_block_separator() {
	base_block_separator_offset_x = frame_rod_side / 2 + material_thickness_frame_rod + rod_holder_size;
	translate([base_block_separator_offset_x, 0, 0])
	cube([rod_holder_size * 2, 100, 1], center = true);
}
// base_block_separator

module base_block_spliter() {
	base_block_spliter_z = 50;
	
	base_block_separator_offset_x = frame_rod_side / 2 + material_thickness_frame_rod + rod_holder_size;
	color([0, 0, 1, .7])
	translate([base_block_separator_offset_x, 0, base_block_spliter_z / 2])
	cube([rod_holder_size * 2, 100, base_block_spliter_z], center = true);
}
// base_block_spliter


/*
    BELT HOLDER
*/

module base_belt_holder_block_belt_remove() {
	base_belt_holder_block_belt_remove_x = rod_holder_size * 2;
	base_belt_holder_block_belt_remove_y = base_belt_holder_block_y * 2;
	
	base_belt_holder_block_belt_remove_offset_x = (frame_rod_side /2) + material_thickness_frame_rod + (rod_holder_size / 2);
	
	translate([base_belt_holder_block_belt_remove_offset_x, -(base_belt_holder_block_y / 2) + 0.01, 0])
	cube([base_belt_holder_block_belt_remove_x, base_belt_holder_block_belt_remove_y, 2], center = true);
}
// base_belt_holder_block_belt_remove

module base_belt_holder_block_screw_remove() {
	screw_m2_diameter = 2;
	screw_m2_offset_x = -(frame_rod_side / 2) + (material_thickness_frame_rod / 2);
	
	translate([screw_m2_offset_x, 0, -4.5])
	rotate([0, 90, 0])
	cylinder (r=(screw_m2_diameter / 2), h=20 , center=true);
}
// base_belt_holder_block_screw_remove

module base_belt_holder_block_remove() {
	
	translate([base_belt_holder_block_remove_offset_x, 0, 0])
	cube([base_belt_holder_block_remove_x, base_belt_holder_block_y + 0.01, base_belt_holder_block_remove_z], center = true);
}
// base_belt_holder_block_remove

module base_belt_holder_block() {
	color([1, 0.5, 0, 0.7])
	translate([base_x_offset, 0, 0])
	cube([base_x, base_belt_holder_block_y, base_z], center = true);
}
// base_belt_holder_block


module base_belt_holder_block_full() {
	translate([0, -base_belt_holder_block_offset_y + 0.01, 0])
	difference() {
		union() {
			base_belt_holder_block();
		}
		
		base_belt_holder_block_remove();
		base_belt_holder_block_belt_remove();
		base_belt_holder_block_screw_remove();
		
	}
}
// base_belt_holder_block_full


module base_block() {
	color([1, 1, 0, 0.7])
	translate([base_x_offset, 0, 0])
	cube([base_x, base_y, base_z], center = true);
}
// base_block





module base_block_full() {
	difference() {
		union() {	
			base_block();
			base_belt_holder_block_full();
		}
		
		union() {
			frame_rod();
			positioned_rod();
			screw_holes();
			base_block_separator();
			positioned_base_screw_remove_tighten();
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








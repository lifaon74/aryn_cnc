$fn=100;

include <../../config.scad>

frame_rod_side = 20.4;
material_thickness_frame_rod = 4;

motor_renforcement_thickness = 3;
motor_pulley_size = 10;
motor_side = 42;
motor_screws_spacing = 31; // space between the screws fixing the motor
motor_special_z_offset = 7.5; // z offset of the motor

motor_pinion_diameter = 25; // min 22


base_x = motor_side + (motor_renforcement_thickness * 2);
base_y = frame_rod_side + (material_thickness_frame_rod * 2);
base_z = frame_rod_side + material_thickness_frame_rod + motor_special_z_offset;

base_z_offset = (base_z / 2) - (frame_rod_side / 2);

motor_x = motor_side + (motor_renforcement_thickness * 2);
motor_y = motor_side;
motor_z = material_thickness_frame_rod;
motor_y_offset = (motor_y / 2) + (base_y / 2);
motor_z_offset = (base_z / 2) + base_z_offset - (motor_z / 2);

motor_pulley_holder_top_thickness = 3;
motor_pulley_holder_top_z_space = 10;

rail_x = 20;
rail_y = 10;
rail_z = 2;

rail_y_margin = 0.5;


motor_pulley_holder_part_space = 6;
motor_pulley_holder_part_butt_tickness = 4;


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

module motor_pulley_holder(pos_x, thickness = motor_z) {
	offset_x = (motor_x / 2) + (motor_pulley_size / 2);
	offset_y = (motor_y / 2) - (motor_pulley_size / 2);
	
	translate([offset_x * pos_x, offset_y, 0])
	difference() {
		
		union() {
			
			cube([motor_pulley_size, motor_pulley_size, thickness], center=true); // base
			
			translate([-(motor_pulley_size / 2) * pos_x, -motor_pulley_size * 1.5, -(thickness / 2)])
			linear_extrude(height=thickness)
			polygon([
				[0, 0],
				[motor_pulley_size * pos_x, motor_pulley_size],
				[0, motor_pulley_size]
			]);
		}
		
		screw();
	}
}
// motor_pullye_holder


module motor_renforcement(pos_x) {
//    translate([25, 15, material_thickness])
//    rotate([0, -90, 0])
	
	motor_renforcement_z = base_z - motor_z;
	motor_renforcement_x_offset = (motor_x / 2) - (motor_renforcement_thickness / 2);
	
	translate([motor_renforcement_x_offset * pos_x, -(motor_y / 2), -(motor_z / 2)])
	translate([-(motor_renforcement_thickness / 2), 0, 0])
	rotate([0, 90, 0])
    color([1, 0, 1])
    linear_extrude(height=motor_renforcement_thickness)
    polygon([
        [0, 0],
        [motor_renforcement_z, 0],
        [0, motor_y]
    ]);
}
// motor_renforcement
//motor_renforcement();

module motor_remove() {
    color([1, 0, 0, 0.7])
    union() {
        cylinder (r=(motor_pinion_diameter / 2), h=50 , center=true);


        motor_screws_offset = motor_screws_spacing / 2;
		
        translate([motor_screws_offset, motor_screws_offset, 0])
        screw();
        translate([motor_screws_offset, -motor_screws_offset, 0])
        screw();
		 translate([-motor_screws_offset, motor_screws_offset, 0])
        screw();
        translate([-motor_screws_offset, -motor_screws_offset, 0])
        screw();
    }
}
// the holes to fix the motor
//motor_remove();

module motor_base_block(thickness = motor_z, with_vertical_renforcement = true) {
	
	offset_z = with_vertical_renforcement ? motor_z_offset : 0;
	
	color([1, 0.8, 0])
	translate([0, motor_y_offset - 0.01, offset_z])
	difference() {
		
		union() {
			cube([motor_x, motor_y, thickness], center=true); // base
			
			if(with_vertical_renforcement) {
				motor_renforcement(1);
				motor_renforcement(-1);
			}
			
			motor_pulley_holder(1, thickness);
			motor_pulley_holder(-1, thickness);
		}
		
		motor_remove();
	}
}
//motor_base_block


module motor_pulley_holder_top_rail_remove() {
	x = base_x - (motor_pulley_holder_top_thickness * 2);
	z = rail_z + 0.25;
	
	color([1, 0, 1])
	translate([0, 0, (motor_pulley_holder_top_thickness / 2) - (z / 2) + 0.01])
	cube([x, rail_y + rail_y_margin, z], center=true);
	
	cube([x, rail_y - 3, motor_pulley_holder_top_thickness * 2], center=true);
}
//motor_pulley_holder_top_rail_remove
//motor_pulley_holder_top_rail_remove();


module motor_pulley_holder_top_belt_tensionner_butt() {
	
	extra_renforcement_x = 3;
	extra_renforcement_y = 2;
	
	x = motor_pulley_holder_top_thickness;
	y = rail_y + rail_y_margin + (extra_renforcement_y * 2);
	
	translate([(base_x / 2) - (motor_pulley_holder_top_thickness / 2), 0, (motor_pulley_holder_top_thickness / 2) + (motor_pulley_holder_top_z_space / 2)])
	
	difference() {
		union() {
			cube([x, y, motor_pulley_holder_top_z_space], center=true);
			
			translate([-(x / 2) - (extra_renforcement_x / 2), (y / 2) - (extra_renforcement_y / 2), 0])
			cube([extra_renforcement_x, extra_renforcement_y, motor_pulley_holder_top_z_space], center=true);
			
			translate([-(x / 2) - (extra_renforcement_x / 2), -(y / 2) + (extra_renforcement_y / 2), 0])
			cube([extra_renforcement_x, extra_renforcement_y, motor_pulley_holder_top_z_space], center=true);
		}
		
		rotate([0, 90, 0])
		screw();
	}
}
// motor_pulley_holder_top_belt_tensionner_butt

module motor_pulley_holder_top() {
	color([1, 1, 0])
	
	difference() {
		
		union() {
			motor_base_block(motor_pulley_holder_top_thickness, false);
			
			cube([base_x, base_y, motor_pulley_holder_top_thickness], center=true); // base
			
//			motor_pulley_holder_top_belt_tensionner_butt();
		}
	
		motor_pulley_holder_top_rail_remove();
		
		translate([0, -(base_y / 2) + 3.5, 0])
		screw();
	}
	
}
//motor_pulley_holder_top


module motor_pulley_holder_part() {
	
	
	motor_pulley_holder_part_x = (motor_pulley_size / 2) + motor_pulley_holder_part_space + motor_pulley_holder_part_butt_tickness;
	motor_pulley_holder_part_y = rail_y;
	motor_pulley_holder_part_z = motor_pulley_holder_top_z_space + (rail_z * 2);
	
	color([1, 1, 0])
	difference() {
		union() {
			translate([(motor_pulley_holder_part_x / 2), 0, 0])
			cube([motor_pulley_holder_part_x, motor_pulley_holder_part_y, motor_pulley_holder_part_z], center=true); // base
			
			offset_z = (motor_pulley_holder_part_z / 2) - (rail_z / 2);
			translate([0, 0, offset_z])
			cylinder (r=(motor_pulley_holder_part_y / 2), h=rail_z , center=true);
			translate([0, 0, -offset_z])
			cylinder (r=(motor_pulley_holder_part_y / 2), h=rail_z , center=true);
		}
		
		screw();
		
		
		translate([motor_pulley_holder_part_x, 0, 0])
			rotate([0, 90, 0])
			cylinder ($fn = 6, r=(screws_nuts_side_max / 2), h=(motor_pulley_holder_part_butt_tickness), center=true);
		
		rotate([0, 90, 0])
		screw();
		
		
		rem_x = motor_pulley_holder_part_x - motor_pulley_holder_part_butt_tickness;
		rem_z = motor_pulley_holder_part_z;
		translate([(rem_x / 2) - 0.01, 0, 0])
		cube([rem_x, motor_pulley_holder_part_y + 1, motor_pulley_holder_top_z_space], center=true);
		
	}
	
}

//motor_pulley_holder_part


module motor_gearbox_adapter() {
	
	motor_gearbox_hole_diamater = 36.5;
	motor_gearbox_adapter_side = motor_side - 1;
	motor_gearbox_adapter_z = 22.6;
	
	color([1, 1, 0])
	
	difference() {
			
		cube([motor_gearbox_adapter_side, motor_gearbox_adapter_side, motor_gearbox_adapter_z], center=true); // base
		
		union() {
			
			cylinder (r=(motor_gearbox_hole_diamater / 2), h=50 , center=true, $fn = 100);
			
			motor_remove();
		}
	}
	
}
//motor_gearbox_adapter
motor_gearbox_adapter();



module base_block_remove() {
	screw_height = 10;
	attach_offset = (frame_rod_side / 2) + material_thickness_frame_rod;
	
	offset_x = (base_x / 2) - 7;
	offset_y = attach_offset;
	offset_z = attach_offset;
	
	union() {
	
		translate([offset_x, -offset_y - 0.1, 0])
		rotate([90, 0, 0])
		screw_and_head(screw_height);
		
		translate([-offset_x, -offset_y - 0.1, 0])
		rotate([90, 0, 0])
		screw_and_head(screw_height);
		
		translate([offset_x, 0, offset_z])
		screw_and_head(screw_height);
		
		translate([-offset_x, 0, offset_z])
		screw_and_head(screw_height);
		
		translate([0, offset_y + 0.1, 0])
		rotate([-90, 0, 0])
		screw_and_head(screw_height);
		
		translate([0, -(base_y / 2) + 3.5, (base_z / 2) + base_z_offset + 0.1])
		screw_and_head(screw_height);
		
		
		nut_y = 8;
		nut_y_offset = -(base_y / 2) + (nut_y / 2);
		nut_z_offset = (base_z / 2) + base_z_offset - (screw_nuts_height - 2) - 3;
		translate([0, nut_y_offset - 0.01, nut_z_offset])
		cube([screws_nuts_side_min, nut_y, screw_nuts_height], center = true);
	}
}
// base_block_remove
//base_block_remove();

module base_block() {
	color([1, 1, 0])
	translate([0, 0, base_z_offset])
	cube([base_x, base_y, base_z], center=true);
}
// base_block


module frame_rod() {
	color([0.7, 0.7, 0.7])
	cube([500, frame_rod_side, frame_rod_side + 0.01], center = true);
}
// frame_rod
//frame_rod();

module _render() {
	difference() {
		union() {	
			base_block();
			motor_base_block();
		}
		
		base_block_remove();
		frame_rod();
	}
	
}

//_render();
//motor_pulley_holder_top();
//motor_pulley_holder_part();
motor_gearbox_adapter();






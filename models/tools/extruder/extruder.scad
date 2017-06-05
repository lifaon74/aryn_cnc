include <../tool_base.scad>

$fn=40;

// stepper_motor
stepper_motor_size = 42;
stepper_motor_corner_size = 4;
stepper_motor_shaft_diameter = 5;
stepper_motor_shaft_ring_diameter = 22;
stepper_motor_shaft_ring_height = 2;
stepper_motor_shaft_diameter = 5;
stepper_motor_shaft_height = 20;
stepper_motor_screws_distance = 31;

// extruder_base
extruder_base_x = stepper_motor_size;
extruder_base_y = stepper_motor_size;
extruder_base_z = stepper_motor_shaft_ring_height + stepper_motor_shaft_height;

//stepper_motor_screws
stepper_motor_screws_height = extruder_base_z - 3;
stepper_motor_screws_head_diameter = 8;
stepper_motor_screws_head_height = 10;


//filament
filament_diameter = 1.75;
filament_z_offset = 11;


// drive_gear
drive_gear_diameter = 11;
drive_gear_height = 11;

// push_gear
push_gear_diameter = 12;
push_gear_height = 4;

	
// tube_connector
tube_connector_thread_diameter = 9.65 - 0.1; // 9.65 ~ 9.35;
tube_connector_thread_height = 5;

tube_connector_clamp_diameter = 10;
tube_connector_clamp_height = 7;

tube_connector_tube_fix_diameter = 10;
tube_connector_tube_fix_height = 6;

tube_connector_thread_inner_diameter = 6.5;
tube_connector_thread_inner_height = 3.2;

tube_connector_tube_thread_junction_diameter = 3.1;
tube_connector_tube_thread_junction_height = 6;

tube_connector_tube_diameter = 4;
tube_connector_tube_height = 10;

tube_connector_y_offset = 11;

// filament_throat
filament_throat_diameter = 4;
filament_throat_center_height = 10;
filament_throat_cone_height = 5;

filament_throat_end_diameter = tube_connector_tube_thread_junction_diameter;
filament_throat_end_height = 10;

// push_gear_base_screw
push_gear_base_screw_relative_y_offset = 7.5;
push_gear_base_screw_relative_z_offset = 5;

// push_gear_base
push_gear_base_x = 11;
push_gear_base_y = 21.5;


// margins
material_spacing = 0.5;
bearing_height_spacing = 0.5;
filament_spacing = 0.25;
material_thickness = 2.5;


// computed
stepper_motor_screws_offset = (stepper_motor_screws_distance / 2);

stepper_motor_screws_head_z_offset = (stepper_motor_screws_height / 2) + (stepper_motor_screws_head_height / 2);
	
filament_x_offset = (drive_gear_diameter / 2) + (filament_diameter / 2) - 0.1; // v2

drive_gear_z_offset = filament_z_offset - 2;

push_gear_screw_height = push_gear_height + (bearing_height_spacing * 2) + (material_thickness * 2);
push_gear_x_offset = (push_gear_diameter / 2) + (drive_gear_diameter / 2) + 1;
push_gear_z_offset = filament_z_offset;


filament_throat_cone_z_offset = (filament_throat_center_height / 2) + (filament_throat_cone_height / 2);

filament_throat_end_z_offset = (filament_throat_center_height / 2) + filament_throat_cone_height + (filament_throat_end_height / 2);


push_gear_base_z = max(push_gear_screw_height + 3.5 * 2, 15);
push_gear_base_z_offet = push_gear_z_offset;


module m3_screw_nut(height = 10) {
	cylinder($fn = 6, r=(screws_nuts_side_max / 2), h=height, center=true);
}
// m3_screw_nut

module m3_screw(body_height = 10, head_diameter = 6.5, head_height = 50, nut_heigth = 50) {
	
	m3_screw_diameter = 3;
	z_offset = (body_height / 2) + (head_height / 2) - 0.01;
	
	color([1, 0, 0])
	union() {
		cylinder(r=(m3_screw_diameter / 2), h=body_height, center=true);
		
		translate([0, 0, z_offset])
		cylinder(r=(head_diameter / 2), h=head_height, center=true);
		
		translate([0, 0, -z_offset])
		cylinder($fn = 6, r=(screws_nuts_side_max / 2), h=nut_heigth, center=true);
	}
}
// m3_screw


module stepper_motor_corner(pos_x, pos_y, stepper_motor_corner_height = stepper_motor_size) {
	
	_stepper_motor_corner_size = (stepper_motor_corner_size * 2) / sqrt(2);
	
	stepper_motor_corner_horizontal_offset = (stepper_motor_size / 2);
	stepper_motor_corner_z_offset = -(stepper_motor_size / 2);
	
	translate([stepper_motor_corner_horizontal_offset * pos_x, stepper_motor_corner_horizontal_offset * pos_y, stepper_motor_corner_z_offset])
	rotate([0, 0, 45])
	cube([_stepper_motor_corner_size, _stepper_motor_corner_size, stepper_motor_corner_height], center = true);
}
// stepper_motor_corner

module stepper_motor_corners(stepper_motor_corner_height = stepper_motor_size) {
	for(x = [-1 : 2 : 1]) {
		for(y = [-1 : 2 : 1]) {
			stepper_motor_corner(x, y, stepper_motor_corner_height);
		}
	}
}
// stepper_motor_corners


module stepper_motor(mode = "preview") {
	margin = (mode == "base") ? material_spacing : 0;
	
	_stepper_motor_shaft_ring_diameter = stepper_motor_shaft_ring_diameter + margin * 2;
	_stepper_motor_shaft_ring_height = stepper_motor_shaft_ring_height + margin;
	
	_stepper_motor_shaft_ring_diameter_z_offset = (_stepper_motor_shaft_ring_height / 2);
	
	
	_stepper_motor_shaft_diameter = stepper_motor_shaft_diameter + margin * 2;
	_stepper_motor_shaft_height = stepper_motor_shaft_height + margin;
	_stepper_motor_shaft_height_z_offset =stepper_motor_shaft_ring_height + (_stepper_motor_shaft_height / 2);
	
	union() {
		color([0.7, 0.7, 0.7])
		difference() {
			
			translate([0, 0, -(stepper_motor_size / 2)])
			cube([stepper_motor_size, stepper_motor_size, stepper_motor_size], center = true);
			
			stepper_motor_corners(stepper_motor_size + 1);
		}
			
		color([0.6, 0.6, 0.6])
		translate([0, 0, _stepper_motor_shaft_ring_diameter_z_offset - 0.01])
		cylinder(r=(_stepper_motor_shaft_ring_diameter / 2), h=_stepper_motor_shaft_ring_height, center=true);
		
		color([0.3, 0.3, 0.3])
		translate([0, 0, _stepper_motor_shaft_height_z_offset - 0.02])
		cylinder(r=(_stepper_motor_shaft_diameter / 2), h=_stepper_motor_shaft_height, center=true);
	}
}
//stepper_motor

module stepper_motor_screws() {
	color([1, 0, 0])
	translate([0, 0, (stepper_motor_screws_height / 2) - 0.01])
	union() {
		for(x = [-1 : 2 : 1]) {
			for(y = [-1 : 2 : 1]) {
				translate([stepper_motor_screws_offset * x, stepper_motor_screws_offset * y, 0])
				union() {
					screw(stepper_motor_screws_height);
					
					translate([0, 0, stepper_motor_screws_head_z_offset - 0.01])
					cylinder(r=(stepper_motor_screws_head_diameter / 2), h=stepper_motor_screws_head_height, center=true);
				}
			}
		}
	}
}
// stepper_motor_screws

module drive_gear(mode = "preview") {
	margin = (mode == "base") ? material_spacing : 0;
	
	_drive_gear_height_base_mode = 10;
	
	_drive_gear_diameter = drive_gear_diameter + margin * 2;
	_drive_gear_height = drive_gear_height + margin * 2 + ((mode == "base") ? _drive_gear_height_base_mode : 0);
	
	_drive_gear_z_offet = ((mode == "base") ? -(_drive_gear_height_base_mode / 2) : 0) + drive_gear_z_offset;
	
	color([1, 0.8, 0])
	translate([0, 0, _drive_gear_z_offet])
	cylinder(r=(_drive_gear_diameter / 2), h=_drive_gear_height, center=true);
}
// drive_gear


module push_gear_screw(mode = "preview") {

	m3_screw_nut_height = (mode == "push_gear_part") ? 10 : 3.5;
	m3_screw_nut_z_offset = (push_gear_screw_height / 2) + (m3_screw_nut_height / 2);
	
	color([1, 0, 0])
	union() {
		screw(push_gear_screw_height);
		
		for(z = [-1 : 2 : 1]) {
			translate([0, 0, (m3_screw_nut_z_offset - 0.01) * z])
			rotate([0, 0, 30])
			m3_screw_nut(m3_screw_nut_height);
		}
	}
}
// push_gear_screw

module push_gear(mode = "preview") {
	margin_diameter = (mode == "base" || mode == "push_gear_part") ? material_spacing : 0;
	margin_height = (mode == "base" || mode == "push_gear_part") ? bearing_height_spacing : 0;
	
	_push_gear_diameter = push_gear_diameter + margin_diameter * 2;
	_push_gear_height = push_gear_height + margin_height * 2;
	
	translate([push_gear_x_offset, 0, push_gear_z_offset])
	union() {
		color([0.8, 0.8, 0.8])
		cylinder(r=(_push_gear_diameter / 2), h=_push_gear_height, center=true);
		
		if(mode == "push_gear_part") {
			push_gear_screw(mode);
		}
	}
}
// push_gear



module filament(margin = 0) {
	_filament_diameter = filament_diameter + margin * 2;
	
	color([0, 0.8, 0])
	translate([filament_x_offset, 0, filament_z_offset])
	rotate([90, 0, 0])
	cylinder(r=(_filament_diameter / 2), h=400, center=true);
}
// filament


module tube_connector(mode = "preview") {
	
	margin_thread_inner = (mode == "base") ? 0.25 : 0;
	
	tube_connector_thread_z_offset = (tube_connector_thread_height / 2);
	
	tube_connector_clamp_z_offset = tube_connector_thread_height + (tube_connector_clamp_height / 2);
	
	tube_connector_tube_fix_z_offset = tube_connector_thread_height + tube_connector_clamp_height + (tube_connector_tube_fix_height / 2);
	
	_tube_connector_clamp_diameter = (tube_connector_clamp_diameter / sqrt(3 / 4)); // to get the ouside diameter
	
	
	tube_connector_thread_inner_diameter_z_offset = (tube_connector_thread_inner_height / 2);
	
	tube_connector_tube_thread_junction_z_offset = tube_connector_thread_inner_height + (tube_connector_tube_thread_junction_height / 2);
	
	tube_connector_tube_diameter_z_offset = tube_connector_thread_inner_height + tube_connector_tube_thread_junction_height + (tube_connector_tube_height / 2);
	
	_tube_connector_thread_inner_diameter = tube_connector_thread_inner_diameter - (margin_thread_inner * 2);
	
	_tube_connector_tube_thread_junction_diameter = tube_connector_tube_thread_junction_diameter / sqrt(3 / 4); // to get the ouside diameter
	
	if(mode == "base") {
		color([1, 0.8, 0])
		difference() {
			union() {
				translate([0, 0, tube_connector_thread_z_offset])
				cylinder(r=(tube_connector_thread_diameter / 2), h=tube_connector_thread_height, center=true);
		
		_tube_connector_clamp_height = tube_connector_clamp_height + 50;
	
				translate([0, 0, tube_connector_clamp_z_offset - 0.01 + 50 / 2])
				cylinder(r=(_tube_connector_clamp_diameter / 2) + 1, h=_tube_connector_clamp_height, center=true);
			}
			
			translate([0, 0, tube_connector_thread_inner_diameter_z_offset - 0.01])
				cylinder(r=(_tube_connector_thread_inner_diameter / 2), h=tube_connector_thread_inner_height, center=true);
		}
	} else if(mode == "push_gear_part" || mode == "push_gear_part_special") {
		_tube_connector_thread_diameter = tube_connector_thread_diameter + 1.5 * 2 + ((mode == "push_gear_part") ? (material_spacing * 2) : 0);
		_tube_connector_thread_z_offset = tube_connector_thread_z_offset - 1 - ((mode == "push_gear_part") ? material_spacing : 0);
		
		translate([0, 0, _tube_connector_thread_z_offset])
		cylinder(r=(_tube_connector_thread_diameter / 2), h=tube_connector_thread_height, center=true);
		
	} else {
		difference() {
			union() {
				color([1, 0.8, 0])
				translate([0, 0, tube_connector_thread_z_offset])
				cylinder(r=(tube_connector_thread_diameter / 2), h=tube_connector_thread_height, center=true);
				
				color([1, 0.8, 0])
				translate([0, 0, tube_connector_clamp_z_offset - 0.01])
				cylinder(r=(_tube_connector_clamp_diameter / 2), h=tube_connector_clamp_height, center=true, $fn = 6);
				
				color([0, 0, 1])
				translate([0, 0, tube_connector_tube_fix_z_offset - 0.02])
				cylinder(r=(tube_connector_tube_fix_diameter / 2), h=tube_connector_tube_fix_height, center=true);
			}
			
			
			translate([0, 0, -0.01])
			color([1, 0, 0])
			union() {
				translate([0, 0, tube_connector_thread_inner_diameter_z_offset])
				cylinder(r=(_tube_connector_thread_inner_diameter / 2), h=tube_connector_thread_inner_height, center=true);
				
				translate([0, 0, tube_connector_tube_thread_junction_z_offset - 0.01])
				cylinder(r=(_tube_connector_tube_thread_junction_diameter / 2), h=tube_connector_tube_thread_junction_height, center=true, $fn = 6);
				
				translate([0, 0, tube_connector_tube_diameter_z_offset - 0.02])
				cylinder(r=(tube_connector_tube_diameter / 2), h=tube_connector_tube_height, center=true);
	
			}
		}
	}
}
// tube_connector

module tube_connectors(mode = "preview") {
	for(y = [-1 : 2 : 1]) {
		translate([filament_x_offset, tube_connector_y_offset * y, filament_z_offset])
		rotate([90 * -y, 0, 0])
		tube_connector(mode);
	}
}
// tube_connectors


module filament_throat() {
	translate([filament_x_offset, 0, filament_z_offset])
	rotate([-90, 0, 0])
	union() {
		
		// center
		cylinder(r=(filament_throat_diameter / 2), h=filament_throat_center_height, center=true);
		
		for(z = [0 : 1 : 1]) {
			mirror([0, 0, z])
			union() {
				// cone 1
				translate([0, 0, filament_throat_cone_z_offset - 0.01])
				cylinder(h=filament_throat_cone_height, r1=(filament_throat_diameter / 2), r2=(filament_throat_end_diameter / 2), center=true);

				// end
				translate([0, 0, filament_throat_end_z_offset - 0.02])
				cylinder(r=(filament_throat_end_diameter / 2), h=filament_throat_end_height, center=true);
			}
		}
		
	}

}
// filament_throat



module push_gear_base_screw(pos_y, pos_z) {
	translate([5, push_gear_base_screw_relative_y_offset * pos_y, filament_z_offset + (push_gear_base_screw_relative_z_offset * pos_z)])
	rotate([0, 90, 0])
	rotate([0, 0, 30])
	m3_screw(25);
}
//push_gear_base_screw

module push_gear_base_screws() {
	for(y = [-1 : 2 : 1]) {
		for(z = [-1 : 2 : 1]) {
			push_gear_base_screw(y, z);
		}
	}
}
// push_gear_base_screws



module push_gear_base(mode = "preview") {
	_push_gear_base_x = (mode == "base") ? 50 : push_gear_base_x;
	_push_gear_base_y = push_gear_base_y + ((mode == "base") ? (material_spacing * 2) : 0);
	_push_gear_base_z = push_gear_base_z + ((mode == "base") ? (material_spacing * 2) : 0);
	
	push_gear_base_x_offet = push_gear_x_offset + (_push_gear_base_x / 2) - 3 - ((mode == "base") ? material_spacing : 0);
	
	difference() {
		translate([push_gear_base_x_offet, 0, push_gear_base_z_offet])
		cube([_push_gear_base_x, _push_gear_base_y, _push_gear_base_z], center = true);
		
		if(mode == "push_gear_part") {
			tube_connectors("push_gear_part");
		} else if(mode == "base") {
			tube_connectors("push_gear_part_special");
		}
	}
}
// push_gear_base

module push_gear_part() {
	color([0, 0.7, 1, 0.7])
	difference() {
		push_gear_base("push_gear_part");
		
		union() {
			push_gear("push_gear_part");
			push_gear_base_screws();
		}
	}
}
// push_gear_part



module extruder_base() {
	difference() {
		
		translate([0, 0, (extruder_base_z / 2)])
		cube([extruder_base_x, extruder_base_y, extruder_base_z], center = true);
		
		stepper_motor_corners(stepper_motor_size + (extruder_base_z * 2) + 1);
	}
}
// extruder_base

module extruder_base_part() {
	color([1, 0.7, 0, 0.7])
	difference() {
		extruder_base();
		
		union() {
			translate([0, 0, -0.001])
			stepper_motor("base");
			
			stepper_motor_screws();
			
			drive_gear("base");
			push_gear("base");
			
			tube_connectors("base");
			
			filament_throat();
			
			push_gear_base_screws();
			push_gear_base("base");
		}
	}
}
// extruder_base_part




module preview_base() {
	stepper_motor("preview");
	stepper_motor_screws();
	
	filament();
	drive_gear("preview");
	push_gear("preview");

	tube_connectors("preview");
	
	filament_throat();
	
	push_gear_base_screws();
}
// preview_base

//preview_base();
push_gear_part();
//extruder_base_part();











